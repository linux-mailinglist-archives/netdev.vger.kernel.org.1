Return-Path: <netdev+bounces-289178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPSHCn2DC2oZIwUAu9opvQ
	(envelope-from <netdev+bounces-289178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D840573C9C
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E58B30387A6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B117398903;
	Mon, 18 May 2026 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLmmnmoy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6F396D15;
	Mon, 18 May 2026 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139430; cv=none; b=OoU8fC8d0vLkv1hh6rdQ/s+ISlOtMkmeU40eYXok01UjJlFOBqCyRXOKY3YMSRVlyQQIzon17qd9lBDF+czNcgF6U3Ggh3LM7Ro6kEBjXu4ucqdIx57n6rwaRqF0jXy3J4O3kBvvNzKm2qouJIB4pvpv/ZKo/uqZjm5n04O+oZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139430; c=relaxed/simple;
	bh=FuV6u6TGiEJVgFDyOMOd0dpdl0m2x0H0VRsE3KpBVhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+iJy2FNpnYcMCxO1v/kWCrQ679XClxbWtlAObj/wLnTQ9EI9SX1U3RsN8Ed+0QC88F/3kJDU9wwh7zWmHWZOdm5JXkfFnbo7rx3DQ9CGS9QrYFn/xBurJE3uijQp5pDKD2vGc6p59RmuBn/03cMzSCOg2X8pvAOkmZs9nO2iXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLmmnmoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC50CC2BCB7;
	Mon, 18 May 2026 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779139429;
	bh=FuV6u6TGiEJVgFDyOMOd0dpdl0m2x0H0VRsE3KpBVhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HLmmnmoyyKFNMsGo2xiV+5XtcfMN/kmMGqbaOXw/v7MVA6V/GIqESOutuuscSMaTx
	 5eoLoFkEl7lBtcDG3YjLNGXpXUUKfITb7yD8YvTm1sManxDSv5LTVqGuN/rL5RFfNq
	 R7YNTxcGp511O/PDPNBStiBaKKdTiJGewoKaGhGWi0OYcXWtcAZtTPhO2yfin4Gn42
	 ZUQdYMoi+ryR4iq0wa1s7LuV36fFP5EZFMLr8Kcjq5v+D/Hac3Z/m4Nbmra7dRL9qP
	 jxGRVoe9RkAgdtpPwUiLQpu/PF0x2fBtD8VGMryWO2un/Zirpb7ZB1Yw55KQR9f+8P
	 Zk4s2ErrpOPIQ==
Date: Mon, 18 May 2026 14:23:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 3/3 net-next v4] selftests: net: add test for IPv4
 devconf netlink notifications
Message-ID: <20260518142346.4c0903de@kernel.org>
In-Reply-To: <f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
References: <20260510081528.5257-1-fmancera@suse.de>
	<20260510081528.5257-3-fmancera@suse.de>
	<20260513193544.47970cb8@kernel.org>
	<bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de>
	<20260514162429.366b94c9@kernel.org>
	<f528360c-18b3-46e5-8ba8-88f921203716@suse.de>
	<20260515181623.5a44140e@kernel.org>
	<f5cae72f-93c7-41d7-b7db-2b60281afb72@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D840573C9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 16 May 2026 09:02:27 +0200 Fernando Fernandez Mancera wrote:
> >> Oh sorry, I should have clarified it. ip netconf only shows/query them
> >> but it cannot set them AFAICS.
> >>
> >> Usage: ip netconf show [ dev STRING ]  
> > 
> > Oh, fun. anyway, you gotta find a better way. Or just give up on the
> > selftest, the YNL hack is too ugly to live
> >   
> 
> Fair, let me see what I can do. Otherwise, Paolo as you requested the 
> selftest, would it be acceptable for you to drop it given the situation? 
> I looking for alternatives anyway :-)

Maybe extend iproute2 ?

