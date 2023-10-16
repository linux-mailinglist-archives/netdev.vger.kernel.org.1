Return-Path: <netdev+bounces-41533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1957CB359
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82B428157B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047B4341B6;
	Mon, 16 Oct 2023 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ITfgOfbA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850728DD2
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 19:33:23 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5B9F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:33:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3575287211bso18012455ab.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697484801; x=1698089601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKDdIBCBe4/E2fPQXL05Dn/ziy5MdIWT0wzMmCG0YLA=;
        b=ITfgOfbAVFEE6XKWz30vNmL3q0xzhkhLZUL0syzAX4YPbtPNLKzuNl84AktGFnzmLv
         r6aI1gqC7DrtDhlEyaCWabueiNvJb9G0OgAcCkOeWvu4VlZe5yKCJrHInhkzGOaAenvk
         oi0ba5vInFW/y2Ym83pvhyj8pDroiPYWEtJlsVQs8TqFFnOVpRDrlokHYpiS8XlFUYeJ
         dlOZUpm6Ux8b7jTxQNkLPQV17UeF6hzgnJy/QYXhlqrxvC7mirty6E60gXdhskS5fHJT
         FkCJKFcd3mBnGE+y0LdoBoa9VAh7ctuGaOxhEkAjQSuPSATku1CD10eAIzfvTmSfAp6V
         qjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697484801; x=1698089601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKDdIBCBe4/E2fPQXL05Dn/ziy5MdIWT0wzMmCG0YLA=;
        b=ux6Ovk1Tzk+AKvpzWiyv0UQD8Ar0uV8MJleM0w2BTbc9tWIpE3/5pght/a9EEubgG6
         sy+oRwsbdLdbBkMpZkYax2ekRHgIYJDhVYXlEh9kIF6jYRq4YyKHwmxJKEQW4hAUFmxd
         P3+A/dlzfP1kbMjY3mvnLEa1etMsNWCkRpYdygfYiqhUIvB0btYXDz//xvAWNDuLypzN
         +sDYqblqQUOl2/eVNp5CRQR/hZTAqqtXsR9iUIw9YKpwoMphbbpmuy3LCqtXdKfsqco4
         IVW101sthGhpJtd7Wh3IvQlpzK8S3SkaBJzBgc4S+/ESlXcud96jH8BFw6Uyvx7bvhcb
         q98g==
X-Gm-Message-State: AOJu0Yx3knCe/lrbmv4dHBoou3MBzxkssvBAIiElFmutKQ2Ol6AjVgud
	0hYFo6guhGSKaOVPh7xmFSudYw==
X-Google-Smtp-Source: AGHT+IFyNafDRn4mI/AYKsDNCkJ9yGm5fj2fd8MINYnX8MENucqT2G5fcARW0Z6BqF5HrLcbkS30uA==
X-Received: by 2002:a92:de4e:0:b0:352:5fcb:1401 with SMTP id e14-20020a92de4e000000b003525fcb1401mr359452ilr.8.1697484801598;
        Mon, 16 Oct 2023 12:33:21 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id i12-20020aa796ec000000b006933866f49dsm293036pfq.19.2023.10.16.12.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:33:21 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:33:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] tun: prevent negative ifindex
Message-ID: <20231016123319.688bbd91@hermes.local>
In-Reply-To: <20231016180851.3560092-1-edumazet@google.com>
References: <20231016180851.3560092-1-edumazet@google.com>
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

On Mon, 16 Oct 2023 18:08:51 +0000
Eric Dumazet <edumazet@google.com> wrote:

> +		ret = -EINVAL;
> +		if (ifindex < 0)
> +			goto unlock;

Shouldn't this be <= 0 since 0 is not a valid ifindex.
Zero ifindex is used as a sentinel in some API's

For example: if_nametoindex() returns 0 if name is not found.

