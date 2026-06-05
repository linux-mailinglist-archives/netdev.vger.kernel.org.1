Return-Path: <netdev+bounces-295992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cDpxIVxSI2oypQEAu9opvQ
	(envelope-from <netdev+bounces-295992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 00:49:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4664BB63
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 00:48:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GJPlU4M7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295992-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295992-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 675A33004F7E
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955B3E51CB;
	Fri,  5 Jun 2026 22:48:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E5282F1A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 22:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699737; cv=none; b=vEY84FWrNexH5quHasC6P0pzHzFQEglLHoK9vvA0QACMKQDUCtNdwUV46Z3yZGKO/64fgGRBjMLTnrKrZ1JSmc933GuHe+h9DCzT6CmhRAk/WbwahywTmBlBUKFdMB273IJS1LBff/GspGEeyIaDQb8YEfnQ8Xe09bUbaftxkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699737; c=relaxed/simple;
	bh=EQnNTf0pIZYmqTgtnPUvLmk/sLbCzfsQXpsApa9s9v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilqd0re5zWSBom59VWC4ywy9ggxvqTKgKVMpDSGsD7/DHp/p4x/NYSXPliSEfKAlTS8C8OtPnNzNmCCwmIxkoZbHeZeT7wRyx6a5phO/VUIgsbWmdKMZit9RLYVRCZylxN2D31rGvgmC9e8b/wbZRGCgJkUzzvi+kgkBAqp5Xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJPlU4M7; arc=none smtp.client-ip=209.85.216.65
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-36b9033d230so1305444a91.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780699736; x=1781304536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DehWeiKc92M7Zv9NckDTBoXMxx9jy6o0Ks2Zn7INmk=;
        b=GJPlU4M7VjFG2Y6DF4QqGvZxG8csyxx3a0Hsl4oR1s/Q7W2XX6+Aik0qK6K9E3zxRR
         Euf69QvDrc69v/8Svpii+ihphrIQr98AhRHY9c+Qfc5BvvB/h8LjJy9sDM1HHqDz0ZlL
         QE8lBAORwL/Rpx+Rn1gYEgcE2yhhhEf1Wu6OWfscARUFPcNHqUH7B87y83q50QOe/Cpl
         yFIy8iqMFvTzJDP9+YkAlsoaet1i6BVDa6kZEdTBlRcF13ABm4r66E3fhUKshaeWQpDf
         Md4skaLAH0h+ye0q7tpCwsG9zaApYV19A2gFafuyYFEekPw+DFd5BhbxjJVJwkjfFoPH
         NnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780699736; x=1781304536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DehWeiKc92M7Zv9NckDTBoXMxx9jy6o0Ks2Zn7INmk=;
        b=V+oOsEWunOP+sF5Tledz4PkFkqC2zdfz61wuqC9dqa2UxcUAxqWqaxb2ILMFLCumx8
         ReGqa2xn0pBOG/qCUweZJdNBw5CaJVmqtV/zttQNTijA4u+TQYiBe6vTIBE9cAnEfDpU
         FSkWQeH12joBSyfx0W+OLNA8WswHeQ+II20IIKBIosiZpkDy+7laf5CzKASbsU6xrjxW
         unrPX21a1YE/I3G74+ru1T63D9wDKo5dZrrGnuzfkavUnk3/b6uLvy6Z2iHQ/cyIjXiB
         ifNSpdOptI/YjrTBDVp7qsaWI3hayL/r0hSBCPtChGFnkvRzEAYrZ5SG49jxnvcwH9ag
         Ah5A==
X-Forwarded-Encrypted: i=1; AFNElJ+VAFBzSwft2TTvWb+ssKpQyLnmRSu0F0qUJY19ir92UnXPMnkWIqyR12KeqzNoEgklOj+uD74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoGpw2HYwUwlmfSU8B5OPxDoyaoKikqgbEcUJWlkql4D/e8tT
	vx/H/FIXCiJeDEM5J0VnEhW9rItvjXBGCWA2vDX2O8+xLd0UGDdXVOjc
X-Gm-Gg: Acq92OHOjTgaGcWq+gDh8YalpqVqk4xo8b1LwbrS0scAa6juoMLo/ao29TfrjCToGrO
	9vRgYYH6kxWuiZch62jui38QgZsifaCMHkExu6vrSgLdfClKz4rx+xItO0XPPju8XSq+6kIvDcj
	qVHCPJilOUl06xoxOGyJUhkyjoakFSl9XQn/4jLxJJNeosTq67/Up8Js6KyuCFiwxaKEJM3qhEK
	wx8GexLLNZTWDB41ib7Qg5eFlLRu3LTrOqKXv1n/0FKjBeL1X86IjDiWXHBJnjI01u901s5sact
	ClyXY8xn9QDgG4td8XqQMvGBejkD1xoEAWgzz0+z9usw/ffJpXgkd267xHMlirbc4AYvxPhLJAn
	y1ADiCk9w4J3NKXv5ULvvja1exgfP5quMrC3CtL/S13ScZElpjLoOprcwL/z8fgihKGLleiMH2L
	7ufTcMzESFgaX/AgFiVKpwu8+jSVk=
X-Received: by 2002:a17:90b:560d:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-3712ffaa11fmr3719651a91.3.1780699734972;
        Fri, 05 Jun 2026 15:48:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f712de91asm7669382a91.16.2026.06.05.15.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:48:54 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:48:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, hkallweit1@gmail.com, maxime.chevallier@bootlin.com, 
	joshwash@google.com, tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, jakub@cloudflare.com, nb@tipi-net.de
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
Message-ID: <aiNR_GaST-NnkZie@devvm7509.cco0.facebook.com>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295992-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFA4664BB63

On 06/04, Jakub Kicinski wrote:
> With the ethtool_get_link_ksettings() situation hopefully ironed out
> the previous series (commit 6a5d837f0ce2) let's return to the main
> part of the series.
> 
> We have been slowly moving towards removing the rtnl_lock dependency
> in driver ops since the concept of "ops-locked" drivers have been
> introduced last year. Since last year will take the netdev instance
> lock before invoking any ndo or ethtool op of "ops-locked" drivers.
> 
> We dipped our toes into rtnl_lock-less ops with the queue binding API.
> Queue stats, NAPI, and other netdev-netlink objects are also queried
> without holding rtnl_lock already. It's time to take the next logical
> step and lift the requirement from ethtool ops.
> 
> The direct motivation for this patchset is that ethtool ops often
> involve communicating with device FW, and may take a long time
> to complete. Aggressive polling of device state on machines
> with 10+ NICs have been shown to significantly increase rtnl_lock
> pressure.
> 
> There's a handful of areas which still need rtnl_lock (see below).
> I decided to convert everything to rtnl_lock-less by default, and
> add a set of flags which let the drivers request rtnl_lock to still
> be taken. I don't love this, but I'm worried that opt-in would be
> even more confusing.
> 
> Known issues / exclusions:
>  - qdiscs - qdisc configuration currently assumes rtnl_lock, this
>    is mostly impacting set_channels callback. qdisc config is probably
>    the easiest one of the exclusions to tackle, it's fairly self-contained.
>  - features - even tho feature changes are (correctly) plumbed to
>    the driver thru ndos they are part of ethtool uAPI. ethtool itself
>    calls netdev_features_change() if it has spotted device feature change
>    before vs after to the callback. Some drivers also call
>    netdev_features_change() directly in response to various changes,
>    e.g. setting priv flags.
>    Since features have to propagate to upper and lower devices anything
>    that touches features is quite hard to move from under rtnl_lock.
>  - phylink - phylink and SFP depend on rtnl_lock today, I suspect
>    that this is purely for historic reasons. I started poking at
>    it and don't really see a need for a global lock. But accessing
>    the netdev instance lock from the SFP entry points will require
>    some attention from the phylink folks.
>  - phydev - similar to phylink, looks quite doable. But no ops-locked
>    driver currently has a phydev (fbnic only uses phylink) so phydev
>    related paths retain a ASSERT_RTNL() for now.
> 
> Tested on mlx5, bnxt and fbnic.
> 
> Jakub Kicinski (12):
>   net: ethtool: serialize broadcast notification sequence allocation
>   net: ethtool: relax ethnl_req_get_phydev() locking assertion
>   net: ethtool: make dev->hwprov ops-protected
>   net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
>   net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
>   net: ethtool: optionally skip rtnl_lock in cable test handlers
>   net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
>   net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
>   net: ethtool: optionally skip rtnl_lock in RSS context handlers
>   net: ethtool: ioctl: concentrate the locking
>   net: ethtool: optionally skip rtnl_lock on IOCTL path
>   docs: net: ethtool: document ops-locked drivers and op_needs_rtnl

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

netdev_ops_lock_dereference name trips me a bit (_compat suffix would've been
more obvious), but I do agree with the reasoning about needing 'a' lock..

