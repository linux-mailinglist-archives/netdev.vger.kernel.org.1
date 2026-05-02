Return-Path: <netdev+bounces-283438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uzQEKIEr9mlNSwIAu9opvQ
	(envelope-from <netdev+bounces-283438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 18:51:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB44B2E82
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD283005D24
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD838237D;
	Sat,  2 May 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqupWy9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746F2DAFAF
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740670; cv=none; b=Ta4aahVYVBtOvucRmB6xpZvaha9Eidp1v86JUMzkqQMoez7Ow6tNBBc2zxSiL7ugz6Uzx1tmZD2topXvt65arpSdH5V8KBwpcuSbKIuXdWSkfQyk6xUxP2ywcMOIogWVaZLTV/mhrS5YakvJpy9kUug/40hnOF4YDnmr2ubX/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740670; c=relaxed/simple;
	bh=aJ108+WvKBs1a23mc3aOanUKXjVOe27Cu6VYyK8JpRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaEGTA8rPtHEV2NR2a4icf7RknSTsJXF/IJnYOBt5KDmn1jJ1Kc86dI42WucIawHaEYdCxBv/zwn8/zZSbVxe64nqQ6IXhyVE5G6nVEb3thZQY22mvuzZJz82YxbiHx681UcHYa6d54pDgZbK79JSZ8I30T+w8qlRfi+FUXAB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqupWy9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E812C19425;
	Sat,  2 May 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740670;
	bh=aJ108+WvKBs1a23mc3aOanUKXjVOe27Cu6VYyK8JpRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DqupWy9o5G+83Nhr19yfZTLFeHZhJti09fUO+s5fVznIR8d6WZ2iSe9a0/0RJFGer
	 otn/2oSL8uhH6pxw+Y9XJqd7HFS+BvgU74d6rOv8eBLKHfSu/8La9pI8BidmDjT3Q1
	 neLOYnjjguS72ifB7JSgPi3Cl8WguQqZ2AJLAYpBrEnLdF4Kt8NoDV2qNgIZBFocqw
	 T0VO7r8fVEPT87KLnath+uV2WzXKmbbilvvJOgmeirwc/yKzmeHPot874SA+TSChUE
	 LSsCGw8yg/dyzAyTcRQMQMPma3otq/MBoGR4vzKyg6nkUsiy9PWDv+9MR/0epyNpUH
	 jFCK+UIn0rbQQ==
Date: Sat, 2 May 2026 09:51:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Lee <fronce09@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org
Subject: Re: [RFC] net: ipv4: add KUnit coverage for net/ipv4*
Message-ID: <20260502095108.752a12bf@kernel.org>
In-Reply-To: <CA+2kspPQ0ZyirDsCyDugzb7Wtt9MPNPdz2xDaxM4DGh+hqy=XA@mail.gmail.com>
References: <CA+2kspPQ0ZyirDsCyDugzb7Wtt9MPNPdz2xDaxM4DGh+hqy=XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 23BB44B2E82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283438-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, 2 May 2026 23:08:38 +1000 Peter Lee wrote:
> Was looking to start contributing to the kernel and thought i would start
> with some test coverage action. For net/ipv4, are you looking to increase
> the level of kunit testing across this submodule, or do you prefer coverage
> only through higher-level selftests?

What's your methodology? If you're planning to generate some code with
AI we are not interested.

