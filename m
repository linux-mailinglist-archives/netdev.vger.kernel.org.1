Return-Path: <netdev+bounces-34618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220107A4DCE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE051C20FD0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BAF20B22;
	Mon, 18 Sep 2023 15:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EA63CC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:58:09 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33C2707
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:54:54 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-76f18e09716so298978885a.2
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052211; x=1695657011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPSTX/62wQkPkVxiiZjUZHNsJWh5xNuhqeelsWlgWkY=;
        b=FJ8zur517vKGNB0Bfg06gflUOrN1dXkE0TKFM7DmcNwKr5HerFOAg+8u5X8K5Nkrxp
         4Bb5phdGdcchRG193OZR8n13cnzlNzRF+WY9S1IBRf4vribnN7wcoL/zNXW0Vib2qTZd
         Q8SPUhqfumO7MK8Hw7fAVGA5RzFGPj9DGbPMmiqMuhfrL5ZLUGFcNf5A96Wa9h3vjWn/
         C6SJd/mpHvOg8/hKQ9vEqtgiUYlNSv8FVBONcva067gfHzUpO1T8S8cs3anfauE2SKoh
         hgELRZKsfM7AxSXOgkJewtrXJSwVlbDlfJ4s2FscePE0LpkXfnxdhElG4gek5sRNrmEL
         S41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052211; x=1695657011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPSTX/62wQkPkVxiiZjUZHNsJWh5xNuhqeelsWlgWkY=;
        b=X/DX5s9BT8DFDvmba390Ok3k0zsLmqLuvnKA2m0YGD8ZB2lyScwVo+K/mHpsIyDypa
         nFKvo+g3NjClNu7cIDTHpQDQdx8Niqia8dwWfYN/ZQdp18pTe2zXUvjPHt2/+kU87nfK
         fC3hDsLixdt0FCn0i5SYpgoaXRT7dteepPJX9lmM+NigNrONdmI+2Y4KgeIJd9gnECX/
         j12ZFLb+xIlWqKWknDlDLOfQmkMoXNDN+LExE1qQ5dZEjvRqRzgtFBZTFCbBD5hLAyLJ
         PK4JvNz5g/PFnSPhzShu5gd/hN/9uZhp4PExSoeLWe32XizMPfzNaDAyYuUztM79Yi5Q
         v8xg==
X-Gm-Message-State: AOJu0Yy6QhrfNr7W+f7nPNEQO+PsBLgbHW8FY56bjuiZ/K1YwT+afFW0
	lJ7JgcODSO9htNjlnqnq9x4v38e8RPl+C2UPISldyBfE
X-Google-Smtp-Source: AGHT+IEmHcwMJ/DhxKZRRQVaw/Iu6DwsOxEIbjRAHjZl81WXapsC8StmJvW/d4/TEuhpFQ7q6OA0OmQfeN9f0KKMFjQ=
X-Received: by 2002:a1f:dd44:0:b0:496:1cd6:b972 with SMTP id
 u65-20020a1fdd44000000b004961cd6b972mr6436400vkg.2.1695042563086; Mon, 18 Sep
 2023 06:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com> <20230918025021.4078252-2-jrife@google.com>
In-Reply-To: <20230918025021.4078252-2-jrife@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 18 Sep 2023 09:08:46 -0400
Message-ID: <CAF=yD-KoKAv_uPR+R+RkVbc3Lm3PREao-n7F1QckPWeW9v6JqA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] net: prevent rewrite of msg_name in sock_sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 10:50=E2=80=AFPM Jordan Rife <jrife@google.com> wro=
te:
>
> Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> space may observe their value of msg_name change in cases where BPF
> sendmsg hooks rewrite the send address. This has been confirmed to break
> NFS mounts running in UDP mode and has the potential to break other
> systems.
>
> This patch:
>
> 1) Creates a new function called __sock_sendmsg() with same logic as the
>    old sock_sendmsg() function.
> 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
>    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
>    as these system calls are already protected.
> 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
>    present before passing it down the stack to insulate callers from
>    changes to the send address.

You used this short-hand to avoid having to update all callers to
sock_sendmsg to __kernel_sendmsg?

Unless the changes are massively worse than the other two patches, I
do think using the kernel_.. prefix is preferable, as it documents
that in-kernel users should use the kernel_.. sockets API rather than
directly call the sock_.. ones.

It's not clear that sock_sendmsg really is part of the kernel socket API.

