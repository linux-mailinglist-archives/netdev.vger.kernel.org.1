Return-Path: <netdev+bounces-292229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IInnBXHBFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:03:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 723275E2574
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09FE53079AC4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD893ED10D;
	Wed, 27 May 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djcDzIaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490F3EDAC9;
	Wed, 27 May 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875978; cv=none; b=ErBjyeuVub+qaOgZ+nMPJw/69axuqSt3cF4WA2MBs3BkFEIgb5xm8geYsTcKO0a3C0vlYn4IIQvf4V/xt9CXAzUFo8wu2ddyMMIvHX4fOdPW8VaU7D5jpl0EqJnyQNHQId6L52ePIEPanRZT3Y4v7M27zVmoGzZ2lMmPMy0TVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875978; c=relaxed/simple;
	bh=8jcWe1lSXPi8AtoGCRoAZPlzqi44Xs4vGacyQu214wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dirLzes3CwpfbZGdloCH6Ve+g7tHpYEOfNGKDMr/NKP1QXBQy8T9k4j7RCxmvHJr63B/9vZVknYK+VYKtVmerKh3tTfRLa8SJEPpu4RhkvBo2KCUNS9ZYdNYRWic9BBsnO1luoS0Bewm/ZT731i7AV43kEVvQPyjOpK58nDqxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djcDzIaf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500CF1F00A3C;
	Wed, 27 May 2026 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779875974;
	bh=9dQ75g70aeWaKdWOHbU4z5KAG44IWr2RpHH814ZtOoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=djcDzIafs26gpX/TSJ06yDTouE7XBvDWcEUEePhQrjXA0c/pu8YJJPdpA8GhKWobZ
	 5wgo7DX+IscoA2RCDbDprFX+I7zH+J0m50IH3TjR4NxhRdGuVp9EanGxlP/ALRqcct
	 OvyCBLKuEOJSdM3qV8OJzPCzWBFM/p7a90nlLFFW9eRaw7xM5nhFLJOk0HZ62hgRpZ
	 f8NwOe6uwfeAYXLoNnOM6Mh4axLwBC4ptT8swT544eXwmdLnN4WXQnjgg1Fy5odPYC
	 e8Y6wKf/deeDLbyTEtn/PjBBSHD5UZwnJIOX8w+KUT5SISbiY/K8r+zmoeAUEUqvis
	 xVOxE6ROS+fiA==
Date: Wed, 27 May 2026 10:59:30 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
Message-ID: <20260527095930.GI2256768@horms.kernel.org>
References: <20260523105449.661848-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523105449.661848-1-shaojijie@huawei.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 723275E2574
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 06:54:43PM +0800, Jijie Shao wrote:
> This patchset enhances the tc flow offload support for hns3 driver:
> 
> - Patch 1: Refactor hclge_add_cls_flower() to support more actions
> - Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
> - Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
> - Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
> - Patch 5: Add debugfs support for dumping FD rules
> - Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - Fixed warnings similar to "warning: restricted __le32 degrades to integer",
>     pointed out by Jakub
>   - Fixed warnings related to
>     "warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)'",
>     pointed out by Jakub
>   v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/

Hi Juijie,

There are AI-generated reviews of this patch-set available at
https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/

I would appreciate it if you could look over them and address any
issues that are either introduced by this patch-set, or directly
impact it.

I would not suggest expanding this patchset to address any other
pre-existing issues, but rather address them separately as appropriate.

