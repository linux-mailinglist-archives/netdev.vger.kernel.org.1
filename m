Return-Path: <netdev+bounces-253528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBHbBSSPd2m9hgEAu9opvQ
	(envelope-from <netdev+bounces-253528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07328A6AD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6537E300E722
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542134164B;
	Mon, 26 Jan 2026 15:58:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676733A9C9
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443096; cv=none; b=bGvGqhEy9knE+xHMVTAwrwz2Yy893CJQt6WhpfF2kBBRIy9LsydnJHcNvcrR71a25j5QC++JaLCzG0ECVzfqeXq556lC1Rpr8ARb9gdR8A3ytm+8/zn2v18sMUHjSKs/KvyFgxkSonkrMupMXxWWOyYjBBIUcgSFPUXAqHUUJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443096; c=relaxed/simple;
	bh=3KlzDZ6cxUVBJWS+h1OQAXmOa39PVO65LO6T+n8T530=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouln3Ow2sHbdF0Ir9VDwrPZEJxetu0OuABmR/NYddN0A0mcA412BEr3AAI13VDYUNQixI/Bqci6y6ZcWMjhxL0+ziwOhA+zZ3wghK/UtaLWdoqjRHww6A+aybtixS/6iim1fc/Pw2/HvIGJT29L9q2x0YrzWC862IU9jOb/0H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60QFw7F7041697;
	Tue, 27 Jan 2026 00:58:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60QFw78C041693
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 27 Jan 2026 00:58:07 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <df36633f-05c4-471e-93ca-f890de670565@I-love.SAKURA.ne.jp>
Date: Tue, 27 Jan 2026 00:57:58 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
To: Leon Romanovsky <leon@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sabrina Dubroca <sd@queasysnail.net>
Cc: Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        Aviad Yehezkel <aviadye@nvidia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
 <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
 <aXIKwNJv59KnsnLw@secunet.com>
 <5811ec38-907e-4788-8a0e-7758f12dc9d0@I-love.SAKURA.ne.jp>
 <20260126110712.GJ13967@unreal>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260126110712.GJ13967@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mellanox.com,davemloft.net,strlen.de,gmail.com,nvidia.com,vger.kernel.org,gondor.apana.org.au];
	TAGGED_FROM(0.00)[bounces-253528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E07328A6AD
X-Rspamd-Action: no action

On 2026/01/26 20:07, Leon Romanovsky wrote:
> Steffen, Tetsuo
> 
> If by "HW people" you mean me, we always set NETIF_F_HW_ESP when adding
> the .xfrm_dev_*_add() callbacks.
> 
>   1334 void mlx5e_ipsec_build_netdev(struct mlx5e_priv *priv)
>   1335 {
>   1336         struct mlx5_core_dev *mdev = priv->mdev;
>   1337         struct net_device *netdev = priv->netdev;
>   1338
>   1339         if (!mlx5_ipsec_device_caps(mdev))
>   1340                 return;
>   1341
>   1342         mlx5_core_info(mdev,
>   1343                        "mlx5e: IPSec ESP acceleration enabled\n");
>   1344
>   1345         netdev->xfrmdev_ops = &mlx5e_ipsec_xfrmdev_ops;
>   1346         netdev->features |= NETIF_F_HW_ESP;
>   1347         netdev->hw_enc_features |= NETIF_F_HW_ESP;
> 
> So we are left with two possibilities: either the device registered XFRM
> ops without setting NETIF_F_HW_ESP, or netdev->features was modified
> without clearing the xfrmdev_ops pointer.

I didn't know that netdev->features can be updated via "struct net_device_ops"->
ndo_set_features() callback using "ethtool -K".

Since netdev->features is not "constant after creation", how can
the (dev->features & NETIF_F_HW_ESP) check in xfrm_dev_down() make sense?

Sabrina Dubroca commented that the current behavior ("ignore NETIF_F_HW_ESP and
call xdo_dev_state_add for new states anyway") has been established for multiple
years. Then, I think that we can't count on NETIF_F_HW_ESP bit. I think that
we can't guarantee that dev_put() from xfrm_dev_down() will be called unless
https://lkml.kernel.org/r/447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp
is applied.

> Which device is triggering the syzcaller crash?

In a off-list mail, Leon Romanovsky commented that netdevsim0 device did not
clear its xfrmdev_ops pointer when NETIF_F_HW_ESP bit was removed.

Indeed, it seems that nsim_set_features() does not update xfrmdev_ops pointer
when toggling esp-hw-offload feature, but my question above remains regardless of
xfrmdev_ops pointer.

[  185.475627] [   T1489] nsim_set_features dev->xfrmdev_ops=000000000f684dab dev->features=41800008001c869 features=41000008001c869
[  237.302143] [   T1510] nsim_set_features dev->xfrmdev_ops=000000000f684dab dev->features=41000008001c869 features=41800008001c869
[  258.573477] [   T1531] nsim_set_features dev->xfrmdev_ops=000000000f684dab dev->features=41800008001c869 features=41c00008001c869
[  263.853173] [   T1571] nsim_set_features dev->xfrmdev_ops=000000000f684dab dev->features=41c00008001c869 features=41800008001c869
[  295.907167] [   T1612] nsim_set_features dev->xfrmdev_ops=000000000f684dab dev->features=41800008001c869 features=41c00008001c869


