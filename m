Return-Path: <netdev+bounces-302022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s/FjCtxRPWoH1QgAu9opvQ
	(envelope-from <netdev+bounces-302022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8C6C74A1
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:05:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Pht8evVM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302022-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302022-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA932303E17B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9C3CC310;
	Thu, 25 Jun 2026 16:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450A37C0FB
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:05:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403541; cv=none; b=c+1dv201kC28UEMbnwOrpD21B9R4Dge0tG+NTXndKEvFtk4t0Qwb7S5RNp+Q2loaCmkrmICPKvzyz1Dd43VdKChAu1J4PubFqPPM1FeH31hv8YREikzfJhrBOS7gmSjNJcVtgdT7I7JzUd/dQqa9sWcz4FZh/S6XpSjN2KYYgMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403541; c=relaxed/simple;
	bh=KgPJePNXcynL5wVdvESOxTecPqRWFfNIHcFNR4q+q9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+eHUMsSiQ1NJrqoX93N3ODxryNwI63zlkOE8w8I7tHd6/oUlAIsOdgE5WAnCxNSpq9dIuxmFo6kYW8NOcRqRf5Equxtc2E0NuK3aFziplWyCDV245Nsfmu1LUkGESj39X01xFsQCXSNoeFrrRAtWIzQvLYgSdeTV2wg7S3GGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pht8evVM; arc=none smtp.client-ip=209.85.214.193
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c80810247dso1098615ad.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403537; x=1783008337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2MJP6G+0qiz8VruHee0NS0DtXdE/aa4R8BvTRRv9rU=;
        b=Pht8evVMH8uAy8YyOIR+NHbB/QuSgB/d3L5cl3CxOuf3Xt9cji6s5xP7gqOAc8LZaz
         76h3PpodPpZH5ojY3Esbhu57ixM9kx/Esrqj4r0fc6sm7v1At8Y6umX0JIPpN5IamOkQ
         nmtw8T/LCJb8kPY96S5k9GCfZb4k7/j91Si0U5Ww+iELWYUWzaXIAv36qcYB8F5QL6G7
         TghBU65QihvIk0tQG/mKqCH+5DP2omBMZiI9aLntVeyX3TCKIE6/o51HX1xNbzpxtzgF
         OLSvEAOX4w5+eZ6gdJHyMYwU5RR9QcxHc8kPTc1s+rX1e+PJgEA1DxXgmZVMhkP+07mL
         KKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403537; x=1783008337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2MJP6G+0qiz8VruHee0NS0DtXdE/aa4R8BvTRRv9rU=;
        b=mq941KswF9wCr1B3vnMG4llU66oew39d6vSVHGfqntyMgfpQ9/jSCANzSaAxZJKVVg
         yFA4s9rEJE7HVsvwU4hgHV97XnVgFbMLmbuwbwDnUsbm2UVZliLGyQlowjJuN6ODlBaF
         wSlIQTGyHWY/sEostqO/5inKH5fuMyMz8S5XAct/8RfkN6QrZkhZDHHKiWfZ46c3kzc+
         N4mX35sdqrwDkGhTS9761cxjLkoujz4/wkVoBDK9zAeqEJPhoYuI75AUHSnkOqQwyQaK
         oXjcpu6DbOl+HjVFhrE34A4IeX4IIeD/RFkJPVkcnGtxCPuWbjIvIINptf/0Z6XCBJ3v
         C9Mw==
X-Forwarded-Encrypted: i=1; AHgh+RoFEe0yIDbYlmYs+jlKdhHWZFo/Fgh8LpXVXji5Bb2PbzrSn4GbKPZFmt1il5tQHyJ43D+NREY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyj9qt34glhGpAmi8UyXcl0gLfiFLYyhJg9u6UIGi9Jg0zXZr9
	2nHbSxLhYY4efNFIbUsBdNnDnJliQNFw4y7Flr6GkD+52WM9uhgLNh/H
X-Gm-Gg: AfdE7cnHkffO5gnMsIx/s4JDR81tolh15X0W5EqgRsP7idb1sagfe5Wa1Dp7lc/3aD0
	rOhkvMXs4fWe4XFOOG7BDBk/uWqIkgixF1koerDkhwsLBr4ZUQSeAuJiFtWayjdrx7SZtAd6RZt
	faLf+SukkjNAZDj4dwpYN9eccBe6ve+tIF3xPayqi8X2ZxKLjegISpQdg+M0ShwzQvVM1M7F+1W
	z7l6VtHE/TsFDykPrG3edT/Cp11liDnryk1zhj3D0HMjafaoxXTqhkLGF8kafGzSt4dEMpj6NKL
	ipxghTBpCbKM/FV8YyPHYiz6n2vRoOEC1y/ls5697V7hZJeGOnNwTf3IHY0014Zj8v0uuKYArNT
	P+ndYPjlPo8+tQtl0whNA4mUedqOuSv4k3uz2CaNm24cgLdkLz8bdNmCdDWkrbhKTtnonVDPSfC
	aE3VDv
X-Received: by 2002:a17:902:ef03:b0:2c0:d9b7:b7a3 with SMTP id d9443c01a7336-2c7fc740665mr30975935ad.21.1782403537535;
        Thu, 25 Jun 2026 09:05:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b27dasm22916635ad.45.2026.06.25.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:05:36 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:48:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Breno Leitao <leitao@debian.org>, joshwash@google.com, hramamurthy@google.com, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, alexanderduyck@fb.com, 
	kernel-team@meta.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, jordanrhee@google.com, 
	jacob.e.keller@intel.com, nktgrg@google.com, debarghyak@google.com, mohsin.bashr@gmail.com, 
	ernis@linux.microsoft.com, sdf@fomichev.me, gal@nvidia.com, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: keep rtnl_lock for ops using
 ethtool_op_get_link()
Message-ID: <aj1Nqe3RoITzxSEb@devvm7509.cco0.facebook.com>
References: <20260624190439.2521219-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624190439.2521219-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:leitao@debian.org,m:joshwash@google.com,m:hramamurthy@google.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:alexanderduyck@fb.com,m:kernel-team@meta.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:jordanrhee@google.com,m:jacob.e.keller@intel.com,m:nktgrg@google.com,m:debarghyak@google.com,m:mohsin.bashr@gmail.com,m:ernis@linux.microsoft.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,intel.com,nvidia.com,fb.com,meta.com,microsoft.com,gmail.com,linux.microsoft.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE8C6C74A1

On 06/24, Jakub Kicinski wrote:
> Breno reports following splats on mlx5:
> 
>   RTNL: assertion failed at net/core/dev.c (2241)
>   WARNING: net/core/dev.c:2241 at netif_state_change+0xed/0x130, CPU#5: ethtool/1335
>   RIP: 0010:netif_state_change+0xf9/0x130
>   Call Trace:
>     <TASK>
>      __linkwatch_sync_dev+0xea/0x120
>      ethtool_op_get_link+0xe/0x20
>      __ethtool_get_link+0x26/0x40
>      linkstate_prepare_data+0x51/0x200
>      ethnl_default_doit+0x213/0x470
>      genl_family_rcv_msg_doit+0xdd/0x110
> 
> Looks like I missed ethtool_op_get_link() trying to sync linkwatch,
> which needs rtnl_lock. Not all drivers do this - bnxt doesn't,
> it just returns the link state, so add an opt-in bit.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Fixes: 45079e00133e ("net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

