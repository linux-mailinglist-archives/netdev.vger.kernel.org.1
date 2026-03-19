Return-Path: <netdev+bounces-269279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCyUOTNmu2lVjgIAu9opvQ
	(envelope-from <netdev+bounces-269279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CAF2C5374
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1F1F30117C3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198B3876AD;
	Thu, 19 Mar 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKbB1DU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA013859C7;
	Thu, 19 Mar 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889070; cv=none; b=K5F9PLVqld9fRdHMIj63G7xiiT+fl9T6F5nT7BQRiu6kSwZgisuVoURp7WdWW4fxO+gFM81in4mKFDHVa9aNbYle4Zcpjc7azCPG8/W4Qq3SVDGssoUXm3GRm066R4L9/t1WSqIO5HM9m2gIVY0QWqUq4UYLZDR6WE+DtvIHjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889070; c=relaxed/simple;
	bh=Le2iTBYvC8iZtu6+lvmW29GWCftNxNhX5q1Y3Y+Tg48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJZnvWIGs+pdAuf1sdP9nRe+wSfG11ec6+We4+VwQcB/BkNqrHpVnRXbJmMUeRvhqaqtB1cDIzxupFDs3g+7EfH4kbzuu9weWSuwzTR2wuxB5BtzOKm/X28lRfjb+1tV/7bca/2M63Ooq/mQzSbkQz3Zv5CW8BJIcj5bGdo6J9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKbB1DU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623D2C19421;
	Thu, 19 Mar 2026 02:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773889070;
	bh=Le2iTBYvC8iZtu6+lvmW29GWCftNxNhX5q1Y3Y+Tg48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKbB1DU3ZN8N5MNwtYCbNaaCKvThlVA3vU++49CikZIsayrvkiOfGg5suymzTCgAB
	 hVwdJ11jxGEmyHlA1zO62fAZFVC4gcPIMNfesxEswDNeNw0KFKvsrNGwD8wfpXgqMT
	 vYk9h18HeLGpTOssKV/lq8Iji/P747p7i7uqxs2yzwl4+zfo3arXT8XI7iGU8egJF5
	 thjMMBGXQokgTglwMigCFQM4StG+psbuAsN5qf1gIn27fQtQAP0ljC0MxYVJyjYC1e
	 KsiG4lPkfQJj6jKR1oVf8EXpKa0OfPROJH6OMb3Lkx0sOUOHY5sQhBHoD4uA7fgvwF
	 pb1qBZrFH1YAg==
Date: Wed, 18 Mar 2026 19:57:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
 <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
 <cjubran@nvidia.com>, <shshitrit@nvidia.com>, "Saeed Mahameed"
 <saeedm@nvidia.com>
Subject: Re: [PATCH v5 net-next 2/5] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20260318195748.6754aafc@kernel.org>
In-Reply-To: <20260317045623.250187-3-rkannoth@marvell.com>
References: <20260317045623.250187-1-rkannoth@marvell.com>
	<20260317045623.250187-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88CAF2C5374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 10:26:20 +0530 Ratheesh Kannoth wrote:
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
> 
> Devlink param multi-attribute values are considered to be dynamically
> sized arrays of u32 values, by introducing a new devlink param type
> DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> 
> Implement get/set parsing and add to the internal value structure passed
> to drivers.
> 
> This is useful for devices that need to configure a list of values for
> a specific configuration.

Jiri's suggesting to use uint seems quite sensible. That way we don't
have to add another type if anyone needs >32b in the future. Should
be a fairly straightforward conversion. All the real types in the
kernel s/u32/u64/ and the netlink helper and API s/u32/uint/

