Return-Path: <netdev+bounces-41561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03A7CB4F1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105DD28148D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3179936AFE;
	Mon, 16 Oct 2023 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Wwe2BV3B"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B262B779
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:57:33 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E095
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:57:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca6809fb8aso8972745ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697489851; x=1698094651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxtK6wLl9TWtu/exD8AkG1ZbdRDx5CZvWxeRuvqG5iU=;
        b=Wwe2BV3BcKauoRbOjME8vjqrznaeSERE9eeF19jOizVc3AgLZ275eMP4G+pcQgC9ZB
         gZ0wZ4zfui0ilO11VAoWolw2rRFlhu4jAybq7bu3I7NJLXqLBUfUMC6ZMOd1vbm+E4S2
         lq7wmT0OBDDP/oTP+QDI1bpGVG8DVPpTkTWbccwk5K2wU1mf4ou1gZgB/djVGfVSDvH8
         4vXjUeG/+GRZhQ8Fc1o9B+0z2t29UvNF9q5RU5VQjHkpGKRpzrKe6BDWl0pV/imUctO9
         Rm18HjtPL7sW4DpE1NVmDu0srSaiTKKk9rYs7U0bCm+WioONXmtBLk3pGVeuLei5qoQ9
         fZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489851; x=1698094651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxtK6wLl9TWtu/exD8AkG1ZbdRDx5CZvWxeRuvqG5iU=;
        b=mrkhwHZ5IGzMqmoULgrrT2vm0kUaB1xO1gAVEvmDPUQyvn6jLV39CBx3jHEczx4Uiz
         2ZTt30cXaKhAUpF3bMmhHLjsmmkWoRsZElFkoe0jYV9zM9rj5Yfof5E0+zjwRFXKzXvf
         cKVWX57kgD2lSyidq6/fkXw9S/5tL1zCEUix6Tcz3Tgjp1CprGIU0/IfNMOqFz3RIuol
         McGQf75R2+VHYr/gxLyD2cipPql3HttQOPClOEw6v1zmPka2JY9CPc6FMhDhXxECZIwy
         6s3jv2fvpDn95X/ghCgRESq6fhJ3hiC2Ez2MKiJCGqQJL4DFWEkM4VeJy/g41XSAtu2S
         QcJw==
X-Gm-Message-State: AOJu0YxEQZNkFbjODYB73raTqpMQVS8snYHORNYYu2Bk8HEjX8NTqxL8
	TzLsUGZuRPKvjPEvfjG/I0rpMQ==
X-Google-Smtp-Source: AGHT+IFZr7XN6Ql3rzkA3oiaA1zESNipqSD2wacxCOwIrXTvxchAQSVuFqj7NeucI5OxgocilDItKQ==
X-Received: by 2002:a17:903:18e:b0:1c0:9d6f:9d28 with SMTP id z14-20020a170903018e00b001c09d6f9d28mr465165plg.11.1697489850958;
        Mon, 16 Oct 2023 13:57:30 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b001c73701bd17sm65064plb.4.2023.10.16.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:57:30 -0700 (PDT)
Date: Mon, 16 Oct 2023 13:57:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] tun: prevent negative ifindex
Message-ID: <20231016135729.492ae9e2@hermes.local>
In-Reply-To: <CANn89iJdhqOtvoGsquYbicThdUGFEzLFmKR5v7wXryKz6Rw3=Q@mail.gmail.com>
References: <20231016180851.3560092-1-edumazet@google.com>
	<20231016123319.688bbd91@hermes.local>
	<CANn89iJdhqOtvoGsquYbicThdUGFEzLFmKR5v7wXryKz6Rw3=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 21:42:10 +0200
Eric Dumazet <edumazet@google.com> wrote:

> Setting tfile->ifindex to zero should be a NOP ?
> 
> This means dev_index_reserve() will allocate a ifindex for us.
> 
> Not sure we want to prevent something that was working properly in the past.

That makes sense. did not read ahead to see what happens

