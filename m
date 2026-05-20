Return-Path: <netdev+bounces-289696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDVUJv8SDWpUtAUAu9opvQ
	(envelope-from <netdev+bounces-289696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:48:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05730586A04
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9B0301C923
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551591EEA31;
	Wed, 20 May 2026 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCchF8eZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57B1A316E;
	Wed, 20 May 2026 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241722; cv=none; b=kz8j24xeR/ZqraqZYK57u+4VXyA7/WkRiVwU8SONKp+gQKsjCVJ7nk403ReL3GdJhYX++F39diHjtfnbnlB+iMsAXCqYVlfdeTZ5igwi47WpJW/Yl/APa4DO1Yd1BqbTYXeiW1DziIHNUxIiCdW9Wzc7re8qiCaatXZWQdqBg3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241722; c=relaxed/simple;
	bh=r0hrPtdaLfzdMBPWJsvL43jbSfzuu59fR7trCtwXXvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqmtqY9XWQwMEbkZYUEFxYdld3ELkKVQopFj9JSHltXOcWMMnpcfU98UnFfhXwDJ9rbkFGLKpMk3wCGx5mZm33XDQB2w/M6iOYl2PyoEl34fP7jswzp47kcY+aVwebeeajfECuKbI884qr9aPdGHK6K6aslOUg32lPW7gpdfgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCchF8eZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D721F000E9;
	Wed, 20 May 2026 01:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779241720;
	bh=wSF9Ql3zIM4WMFOVCaOX+47rMFfdcv+wlHVCJQF/LXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UCchF8eZrjmn3XJIM5l8N+/uKtFX3Mhts/29pT7wn8Aaa1R7NtQzwlj4ziFbew0cs
	 VRESRkoajFsikUjBU9NI13udzSzQpcKRzTPTjAhrSewrygMAC9ckgugxt6GiEZgzVO
	 kIAY6bt4ZILXDNzoPSMe3CPZrcVzfemWu8JQdv6sa9qNnyvScvdohTBpDe5MLO9qPm
	 k2Hzr7a52d1p5+sXwATcT+7Gu+PMz2oG7pnOfAfs1H0rWTli7TV+VYoHpYZ1nxh84i
	 UdlVB0iAXH4VUtrJioHz/5MxLLKrrCBfTpkShtlkhLvhuWH68ImOztD6hzZ9apm+tK
	 J09XC2+id7Hlg==
Date: Tue, 19 May 2026 18:48:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/6] net: hns3: support IP and tunnel VNI
 dissectors for tc flow
Message-ID: <20260519184839.4501f720@kernel.org>
In-Reply-To: <20260518093526.1109595-5-shaojijie@huawei.com>
References: <20260518093526.1109595-1-shaojijie@huawei.com>
	<20260518093526.1109595-5-shaojijie@huawei.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05730586A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 17:35:24 +0800 Jijie Shao wrote:
> Currently, the driver does not support FLOW_DISSECTOR_KEY_IP and
> FLOW_DISSECTOR_KEY_ENC_KEYID. But the hardware supports
> ip_tos (FLOW_DISSECTOR_KEY_IP) and
> outer_tun_vni (FLOW_DISSECTOR_KEY_ENC_KEYID).
> 
> This patch adds support for FLOW_DISSECTOR_KEY_IP and
> FLOW_DISSECTOR_KEY_ENC_KEYID.
> 
> Additionally, since tc flow cannot effectively support
> l2_user_def, l3_user_def, and l4_user_def,
> this patch explicitly sets them to not be used.

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:5771:37: warning: restricted __le32 degrades to integer
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:5773:37: warning: restricted __le32 degrades to integer
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:7369:31: warning: restricted __be32 degrades to integer
-- 
pw-bot: cr

