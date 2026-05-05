Return-Path: <netdev+bounces-284117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CPUCn41+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:10:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F34C5227
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65823034DD3
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5010F76025;
	Tue,  5 May 2026 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxWXwu95"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E67080D;
	Tue,  5 May 2026 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939757; cv=none; b=BUibziabpDtos9SYXjt+Ix7cOb6Xm3PXOSMrP/9IwYHFDEnspgkFX5mzOxM+HGOaM8JB00RqoCD0n/GKTPuVCcAKYZwPWZXMnAlWImLLJZ2LYPvtEeNO11cuVr2dIgMGc1RZUxybR8OPAUwE7Mc1b7F5vN3AyMbcULizZLG/dYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939757; c=relaxed/simple;
	bh=nBDaiHkgq6qyTHWG1No9+fMBjir+RY459GFaq0WreOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUVgLR7zqMEhAtl0zY/OZkO7AyME6Q3XcmyJhmJba+h45MYPthgjuhE//ny6Jp4v1quziH26wbHKnw+LPwyLKEKW/W6SjBwmWsSAZ9VFotv3Uxf/ar/EAMNZWjY3fFAwRhi5dg36jl7B3vZpJWYVy0M87eb+ljUpkVwMXU3tWYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxWXwu95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1549DC2BCB8;
	Tue,  5 May 2026 00:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939756;
	bh=nBDaiHkgq6qyTHWG1No9+fMBjir+RY459GFaq0WreOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CxWXwu95X7sVf5vh4Phs7b06wOVtewD0Apzr4pSrEiHi+MwpX7kOc0K4tLjkzOZcf
	 CCpMLzIEB6liyrvciIx+yMys6my4bwHN1Pn21SRq3i6z+UxsDCV93SurX0mBiwKOLY
	 NfluGwnE5UuWYyPWDAKv0rH4SbWpgaTz1S1e9swCxUbP1L+l9yC/v0ZJYIvdt3XA5z
	 jlZ0ethB+lM5gImPP/0iVEf74B7X0cSEer55m0TH/WQ7CNZje4N/mNdNe5jpe1AAO1
	 oDbkpyAoCOGkI83hnoY91MEkOZEL3Yvm4Mmb/IJdBMHJwjv21POibhmq1x06Eashde
	 sEOcPoY85tmUQ==
Date: Mon, 4 May 2026 17:09:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Alyssa Ross <hi@alyssa.is>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Ricardo B .
 =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Subject: Re: [PATCH v2] ipv6: default IPV6_SIT to m
Message-ID: <20260504170912.174235db@kernel.org>
In-Reply-To: <d299649e-d01e-451a-b604-76c8662f1ecc@suse.de>
References: <20260503192515.290900-2-hi@alyssa.is>
	<5f676587-fcdd-4704-9523-07a7fd98455a@suse.de>
	<878q9zdz6s.fsf@alyssa.is>
	<d299649e-d01e-451a-b604-76c8662f1ecc@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 793F34C5227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 4 May 2026 17:01:43 +0200 Fernando Fernandez Mancera wrote:
> > Yes, it appears you're right.  I had only tested on ARM.  In that case,
> > perhaps it make sense to instead set this to m in the arm64 defconfig, to
> > preserve the previous situation, but I can also see the value in
> > reducing platform discongruity by letting it change to y on arm64 too.  
> 
> Changing it on arm64 defconfig would make sense to me too. We should 
> probably visit other configs that might be in the same situation. That 
> in my opinion would qualify a net tree fix as you proposed initially.

Right. I think the fix as posted makes sense. Tunnel drivers should 
be =m. If other arches default to =y that's likely an oversight.
Fedora and I suspect all other distros (and "prod kernels") set SIT=m.

