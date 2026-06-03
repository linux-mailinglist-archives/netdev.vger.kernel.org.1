Return-Path: <netdev+bounces-294847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IQfLC4hhIGpa2QAAu9opvQ
	(envelope-from <netdev+bounces-294847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:16:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897863A1BD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:16:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kuu8xEzP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294847-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FC13091F32
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9713E9F61;
	Wed,  3 Jun 2026 17:07:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BA3E4C7B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:07:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506441; cv=none; b=Tcpymn+XnDZvtaHyoPjP+w1AA9DmeQOUh/79aldVO9v2SkZV8uZ3wiSkAVCJi78C72ZT/yRfpncQPDSw0GvL0t+uPx+VVx2PjUogMYdReq6/bRbqNR78MMpKKh7lm3Ij4p2DXI2pYKHB0pILIYMX4RGsVnU/tHB0Dlw6jD9ObT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506441; c=relaxed/simple;
	bh=VI9XorPSlhfHmOeG230kpRBkPlDvZ777QxVLMeV1TIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVDGM9eTqHYoUuq6wiuKY+1TU0FFwTsof3MwA4Jn5Iqn2g25OExy9aWDU+yVMEwm68/7R8R3iJoSpwx4rSpxNLHLwJ7Psf89HDhxvjAe57qzmMU/xE/9+h8Pc7DNQBndtVoBIsznfqNW2vropyUaX8+yGWQ0bRxBJyKFkxg2pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuu8xEzP; arc=none smtp.client-ip=209.85.214.194
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2bea7176c72so101575135ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506439; x=1781111239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TihK8TLFQ7eWvBfrOf1I2w6CeTT78T3znP19Zg8cOL0=;
        b=kuu8xEzPGVtYcbUdgLVRDz7jEPpovEu29/xKnSf/GKM0yiEGM8UWbgNu7fsWLxbipW
         fj9xO0HR8WQ/fbGPJKNwofyZHhK2qetgHoooD57wE40x0Bkj1J8+OsYBbcJB3o4qt5QM
         2iLcTnDF5R7qYKotQ2CqfwmPenDNmVaLQir8VlpEYBucx4M1TdSLyBOvwnpfV1iJ6UC3
         UUan5QKGJd988cqop0i/LgFr/ENIC8e654sSJgJpZNXYBVQusgC4hWCLcgpOy8Gs0P+E
         UMAFqiIGO2P8YK6NsGNb//DD9V1atlGEtoVfr26L684pdzm23Yn/nuE4e1YxtKDW0daV
         K6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506439; x=1781111239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TihK8TLFQ7eWvBfrOf1I2w6CeTT78T3znP19Zg8cOL0=;
        b=gG8M2b4Cjo8hITQ+myBxsyp1YvtXd5ye004eb53YkBbA0WwdJpfRc4MB1hxVvkrryA
         ztg2u0Xm2EOVjHydr0EO8DVgZzOSrN1MhvzeSSVlWd1tC6KjV5KqIwSlcdRrRcOH06fq
         svuE6fS265olrq1x8BIrqY+Hp+mTVWLTiJxwat/WvClnYcd2GfjRQYNtFTafe4qouqdO
         sh0kWtpGKdaHb20i0PV25rO16TxFy6OsZyC5jB1gSo9ek2/sXwpUHDc0N1IEG744MStj
         FkbIA8v4Ty0KUBeZ0mGHaIChopxd/OVeLYFoGDYpBaeTTHPeZ/WDll4XQgkDPQvCC+zT
         K2AA==
X-Forwarded-Encrypted: i=1; AFNElJ+I2pDMgIyYMRIlMZR9e5v+1N9wKsmBG83Hv3d9gGLNdk8GbYoEdvuJJE1r1Lg4YIrhmsDkgKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6Fvy2V6CTBmYeJQAUwj9oIiK3UQEDftH0xr5YfmnKSidaHTS
	FhkK/P0ntE/P4SEiFXpOnpyQmO438GWFF50N9SGS8MK00lvWORvo+3Qw
X-Gm-Gg: Acq92OETmbSCYS7hB/4618xjD0m0e31m1Tglk3aEmz4qC5espMoCzSlZ4Gjd/YopxYF
	XLhGaxyJjQ43yyM6/J60/D0eLTg+AsE/76Yb+FAHMlTrh2pP4tFTcfGU/62KOsumPHDYTKhCN+z
	QtUhcO+sdAxzKQziLxYkKacDCOR3rAWk47p/rqXysesL10BbfE/ZygpibE6t9jveXgZJYGGkLxn
	SlZTygLz9d11ii17oEZr/oT9UYlZLPzc1+riybXuZ7//swHf9S/phhddoiyOkXPt+vCVzglzOtD
	R7wAUlXnlRSL3FfSykHKn6/mukZ6r0uBscDbxZX2HmuSm/xNeqngAE8hwnM91eWjsbew1iTXyYX
	dad26/s0skXI6TsMYU+4getyG38wqwbBgJAOBknIIyWclxmws+pdyJ+0sX4V9iDjTHOUYpoPmhN
	hGwSVCO3YzMXxdHIWUbhSi1iEev24=
X-Received: by 2002:a17:902:ef44:b0:2be:22cc:e227 with SMTP id d9443c01a7336-2c1639ee5b0mr42224385ad.4.1780506439527;
        Wed, 03 Jun 2026 10:07:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e234sm32078445ad.53.2026.06.03.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:07:19 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:05:45 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jakub@cloudflare.com, 
	maxime.chevallier@bootlin.com, nb@tipi-net.de, lee@kernel.org, linux-leds@vger.kernel.org, 
	pavel@kernel.org, jv@jvosburgh.net, michael.chan@broadcom.com, jhs@mojatatu.com, 
	vinicius.gomes@intel.com, idosch@nvidia.com, razor@blackwall.org, hare@suse.de, 
	jhasan@marvell.com, danieller@nvidia.com
Subject: Re: [PATCH net-next v2 01/11] net: rename netdev_ops_assert_locked()
Message-ID: <aiBe4-1vnkJJHwHo@devvm7509.cco0.facebook.com>
References: <20260603012840.2254293-1-kuba@kernel.org>
 <20260603012840.2254293-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603012840.2254293-2-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294847-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:jakub@cloudflare.com,m:maxime.chevallier@bootlin.com,m:nb@tipi-net.de,m:lee@kernel.org,m:linux-leds@vger.kernel.org,m:pavel@kernel.org,m:jv@jvosburgh.net,m:michael.chan@broadcom.com,m:jhs@mojatatu.com,m:vinicius.gomes@intel.com,m:idosch@nvidia.com,m:razor@blackwall.org,m:hare@suse.de,m:jhasan@marvell.com,m:danieller@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,fomichev.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cloudflare.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7897863A1BD

On 06/02, Jakub Kicinski wrote:
> Jakub suggests renaming the existing assert to match
> the netdev_lock_ops_compat() semantics.
> 
> We want netdev_assert_locked_ops() to mean - if the driver
> is ops locked - check that it's holding the device lock.
> 
> The existing helper check for either ops lock or rtnl_lock,
> which is the locking behavior of netdev_lock_ops_compat().
> 
> The reason for naming divergence is likely that
> netdev_ops_assert_locked() predated the _compat() helpers.
> 
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

