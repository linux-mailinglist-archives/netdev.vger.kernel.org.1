Return-Path: <netdev+bounces-221458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC1AB508BC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 00:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A41C63BE3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617E265CC8;
	Tue,  9 Sep 2025 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kY6PTagr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2CDarXW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10526563B;
	Tue,  9 Sep 2025 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455882; cv=none; b=VUWa6HXIvlSfy0DOYqBaVuO2TYRtygc4gF1aSqMt3Cvl566qWCLfbRP8mKzsP7DTbnPXotGPNksy7MLyo9TiZtJges3QxSkyHJndpz19aOGJxAsGPwHC1GD+zdYiiDwMiwRkOsARykE7YKaK5W4hudqPaVntjcB32lXpefm1nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455882; c=relaxed/simple;
	bh=AFFnAfzTRI3AFCuZ7KttlUOS8jFAymW/E8Tho7dKWOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhmwTIruzrCLugF2+LaubQLMx0qfevfTQdz9JOJq8c3QYMAW+61gsA9ksiGc56JwczQeEqoO+6wPG0aj4Tiu/33JWODnI4Id6q43aJGZVzujEi8nx5ZFCTRKiLcRjiPa87YsbT2mwrpKK/yFrW4LIARCwGjoH+/fOOX8568OYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kY6PTagr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2CDarXW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1686140000E;
	Tue,  9 Sep 2025 18:11:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 09 Sep 2025 18:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757455878; x=
	1757542278; bh=vPzVhUzuxDxCy6rfXqpS+yYCdkswFPAm+UOp/km7akg=; b=k
	Y6PTagr7y6f4+O6eVVO0tHOMPqCntmlp08u5lYiA4wkzsi2Qp0iVXw3unj61Jpz6
	459RuyMQV5n8UvYM8uE+g4qw6K0TFVQa9e0g+aOW9NsOZJrCfvvU2zAmEIXh+6xh
	HC55JwWV/qeXPKYmjnj5/8GLxxlPIneL8xbAYbqteQSNtjUF1rxc4aBjtcqPYAdf
	gvKbDf9JJKQX70gsdEH36hFuWBJB2Gl1MnawbuMgK+bmNgB6UY3S/bvt2w7EfdKg
	u7AIptbLruEKRHUV5PDg1Gmc7+qQ3YUxsqr2pxTzS0MGPogzbsw9sdkBN7Fk/Lw+
	qgaXKs2VgA+XiigdN0WVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757455878; x=1757542278; bh=vPzVhUzuxDxCy6rfXqpS+yYCdkswFPAm+UO
	p/km7akg=; b=P2CDarXWlcPVWmFClLsxU8o7ENNDbD/CdEH2BzBSj9y3iuqwHN1
	AJysntJ2y7GhXNNB2D/c2XItfHkZhSV7aT0RVFci9uqbd3Hc8QMh3BS6FCEofDyH
	OzoRadJNBTcCtI2ABGeOc1d0hrD+/qengDiFdPRM9CmPVCkmW/z5Fp4XtdhNLlsD
	/wgw2cHwwrdNizQEdPnB1AhoKE7bII02r2w3mKOzB36sHKqLYGoVnAAl9QDgM1HT
	Qqu9AokUeVqhb8vaCcq5RcSvLH0YRvEYtQPjHwmswdUN/olfsVdLfN8pHDbj2XoH
	j4xMwXam4xELBkRMcpkpuZi+ymiSe/Rz2ag==
X-ME-Sender: <xms:BqbAaLaANP4g-IEWgRoNHQH_Dy3TUMEymQdA8pevJ4GUzCzlSeROUA>
    <xme:BqbAaL9Nzay9wu1X8xCSFWlAmSMy5zEJmaPtN59BmXmgRu4id92fuI3Y4u5tFhV6b
    bEslW-vjXOpJjqGMrI>
X-ME-Received: <xmr:BqbAaESbI824YQWsbjEyMOFUuSMJa5KDZykUHalJ77whf_f_jY3tj98MjrEH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshih
    shhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephffggeeivedthffgudffveeghe
    egvedvteetvedvieffuddvleeuueegueeggeehnecuffhomhgrihhnpehshiiikhgrlhhl
    vghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsughfsehfohhmih
    gthhgvvhdrmhgvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshiiisghothdojegvtdhfkeelfhgsiegtrggvhegutddtvdguvgdtsehshiiikhgr
    lhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BqbAaNds_uOd53E_J15ZGFq1kMsucWSRtpUFET1eaGZrSLFmi2Tqwg>
    <xmx:BqbAaOSCxqGvU3cp2lWdw7-liYvFPddgYpBbiveG6avm5gPMPPCfwQ>
    <xmx:BqbAaBJrbPmMTT1qS2lRQL-rpb2WyAvtmbQhqVqv33sRZpk3Ddh0Sw>
    <xmx:BqbAaDI69sQSFCV1l8vERm4d9RkdBKB1ieYuI3J3it9K-wAt6V53iA>
    <xmx:BqbAaIhgq1CSNv27_U8YE9sGwie6eQBpFjYAw1r_-rwxK82OijXyw-gu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 18:11:17 -0400 (EDT)
Date: Wed, 10 Sep 2025 00:11:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
Subject: Re: [PATCH net] macsec: sync features on RTM_NEWLINK
Message-ID: <aMCmA0kz7EMG2uCw@krikkit>
References: <20250908173614.3358264-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908173614.3358264-1-sdf@fomichev.me>

2025-09-08, 10:36:14 -0700, Stanislav Fomichev wrote:
> Syzkaller managed to lock the lower device via ETHTOOL_SFEATURES:
> 
>  netdev_lock include/linux/netdevice.h:2761 [inline]
>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>  netdev_sync_lower_features net/core/dev.c:10649 [inline]
>  __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10819
>  netdev_update_features+0x6d/0xe0 net/core/dev.c:10876
>  macsec_notify+0x2f5/0x660 drivers/net/macsec.c:4533
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
>  call_netdevice_notifiers net/core/dev.c:2281 [inline]
>  netdev_features_change+0x85/0xc0 net/core/dev.c:1570
>  __dev_ethtool net/ethtool/ioctl.c:3469 [inline]
>  dev_ethtool+0x1536/0x19b0 net/ethtool/ioctl.c:3502
>  dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:759
> 
> It happens because lower features are out of sync with the upper:
> 
>   __dev_ethtool (real_dev)
>     netdev_lock_ops(real_dev)
>     ETHTOOL_SFEATURES
>       __netdev_features_change
>         netdev_sync_upper_features
>           disable LRO on the lower
>     if (old_features != dev->features)
>       netdev_features_change
>         fires NETDEV_FEAT_CHANGE
> 	macsec_notify
> 	  NETDEV_FEAT_CHANGE
> 	    netdev_update_features (for each macsec dev)
> 	      netdev_sync_lower_features
> 	        if (upper_features != lower_features)
> 	          netdev_lock_ops(lower) # lower == real_dev
> 		  stuck
> 		  ...
> 
>     netdev_unlock_ops(real_dev)
> 
> Per commit af5f54b0ef9e ("net: Lock lower level devices when updating
> features"), we elide the lock/unlock when the upper and lower features
> are synced. Makes sure the lower (real_dev) has proper features after
> the macsec link has been created. This makes sure we never hit the
> situation where we need to sync upper flags to the lower.
> 
> Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/macsec.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks for the detailed explanation of the problem.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

