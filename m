Return-Path: <netdev+bounces-44156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9D7D6B5B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B0FB20F32
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44227EDC;
	Wed, 25 Oct 2023 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EI+fyB2d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F742773D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:25:49 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5323C191
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:25:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50816562320so1014063e87.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698236743; x=1698841543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mz7jbKZYGWSKMahIhqQmAVefQlwkfoSok+5L/M6OZo=;
        b=EI+fyB2djPkJun3axgX0f0Php4mYFuJMn7ZOdVL6lInemq9cn0FcpusJ+9te7iBOn7
         EFTWwndENGQmdsIPs8lLSZ1L1zwOqM/lZgi7fj+TV/dciMuuhoiJc9kNl2QRcP4dPptP
         ZStSm84GQBjHwnCs7FogcP9jpXwct+MD6neqytmV4guu/Ptb6sqUKsLP6Ef4VsA/V1xy
         djHYNaAbwc2TQdZ602rlaMdE/qqsxn4dumy98oviaEnSQYPWr08MmYEO8iJI+4l8Xk+j
         ymOfQ3ILbGJ/ZdyrpnJ6SnAxhHiL1k3e/yoZrHJNE1ECZJiwdvnZa6Uvlvmc4ml5NYL9
         pTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236743; x=1698841543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mz7jbKZYGWSKMahIhqQmAVefQlwkfoSok+5L/M6OZo=;
        b=rUy9wSyPGsVFgASUJ+Kf6XfxiAgldo3aKAHe+b0Xlqqgp/w21b+VvzqvMsg1WT78SY
         BEKc+9wc7c5pHn+Z/N0y6JZlwRjE4ChKMDBb92twXcTHezGRiHgiztIJb9GF2uUJEN5L
         XWw5XYeJbA/tj0xO26FrMhz8weLokcflV5hsZtHV8nNE6SSHyn/sNFZn+Va5rlWbpYN5
         OA6lBVEUvXS864q2eeIyfCUEh/iream8zPf114iMQ945Mdwb8e8cVLjBjRk7rsLxV3Dr
         P2p/upm4+1wRJWxpiRTXIqugzgFlQ0xBOPxMvVn1ZS7vXTGAtVeyOXDmx+855pnvJxPO
         lDbA==
X-Gm-Message-State: AOJu0Yw9uxIPNzlm1f1gmhv5egN66eFMSzuluReI6g5BUUHsyDS/5B9H
	yz0o8pk0NlYasem9ke2wNfl09A==
X-Google-Smtp-Source: AGHT+IGMDJuU1RQ3HpJZbtFA73v6P92P+ePYKxejiP3Qm00iolEC6Wodw/r9yfmdogeZtdGwrRylPg==
X-Received: by 2002:ac2:5967:0:b0:500:90d1:90a6 with SMTP id h7-20020ac25967000000b0050090d190a6mr9476630lfp.63.1698236743494;
        Wed, 25 Oct 2023 05:25:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n4-20020a05640205c400b0053f9578ec97sm9394916edx.56.2023.10.25.05.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:25:42 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:25:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: ipv6/addrconf: clamp preferred_lft
 to the minimum required
Message-ID: <ZTkJRdp2/oZdXbFo@nanopsycho>
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-3-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024212312.299370-3-alexhenrie24@gmail.com>

Tue, Oct 24, 2023 at 11:23:08PM CEST, alexhenrie24@gmail.com wrote:
>If the preferred lifetime was less than the minimum required lifetime,
>ipv6_create_tempaddr would error out without creating any new address.
>On my machine and network, this error happened immediately with the
>preferred lifetime set to 1 second, after a few minutes with the
>preferred lifetime set to 4 seconds, and not at all with the preferred
>lifetime set to 5 seconds. During my investigation, I found a Stack
>Exchange post from another person who seems to have had the same
>problem: They stopped getting new addresses if they lowered the
>preferred lifetime below 3 seconds, and they didn't really know why.
>
>The preferred lifetime is a preference, not a hard requirement. The
>kernel does not strictly forbid new connections on a deprecated address,
>nor does it guarantee that the address will be disposed of the instant
>its total valid lifetime expires. So rather than disable IPv6 privacy
>extensions altogether if the minimum required lifetime swells above the
>preferred lifetime, it is more in keeping with the user's intent to
>increase the temporary address's lifetime to the minimum necessary for
>the current network conditions.
>
>With these fixes, setting the preferred lifetime to 3 or 4 seconds "just
>works" because the extra fraction of a second is practically
>unnoticeable. It's even possible to reduce the time before deprecation
>to 1 or 2 seconds by also disabling duplicate address detection (setting
>/proc/sys/net/ipv6/conf/*/dad_transmits to 0). I realize that that is a
>pretty niche use case, but I know at least one person who would gladly
>sacrifice performance and convenience to be sure that they are getting
>the maximum possible level of privacy.
>
>Link: https://serverfault.com/a/1031168/310447
>Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Again, Fixes tag and send to -net tree?

