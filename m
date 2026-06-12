Return-Path: <netdev+bounces-298733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xZlwFMw4LGrGNwQAu9opvQ
	(envelope-from <netdev+bounces-298733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:50:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E822367B138
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HYtBWOv+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298733-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6654C300289E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3133E8323;
	Fri, 12 Jun 2026 16:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B43FE649;
	Fri, 12 Jun 2026 16:50:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283016; cv=none; b=OmxpSHi1uZhtCLOHHltNU24732z+OG6JRfmqObY1Wq79XdCm/CxgKCg8/W946cfEuTz65xlIhjh20Qzg+HgyfaadIhNDo5X+AcsNrtDkbBbKp7HUMFzgdFPTzcO0sL8ymJIaKPkRKSgBstWlvSO0JIXKIZQONAcKXaB+fn1bi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283016; c=relaxed/simple;
	bh=5SFHbzXmYeJOjeGP6n53U6/rRL3lm4sSKEGkK7NUnrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCesKj6Otf+NLLUGyveONOu76Tm+h+BVjz8BHq812s+u0ZPepGEZ0KMQe/9j0uLZK8FRfYP1tcWOh1Z7DKnDY+vyv0Ol067WYtveUijZ2tV8X9PCWlWW69wZK80CTqDkZDt65Xw+Ie/bOqPy/kycrBy2j4p6XN4o4IdZFjitFBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYtBWOv+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C71F000E9;
	Fri, 12 Jun 2026 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781283015;
	bh=5SFHbzXmYeJOjeGP6n53U6/rRL3lm4sSKEGkK7NUnrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HYtBWOv+FJenMPLWr7AzvR2JoJdLD9JJZm2xF9uFvX22gOaJ7NnB81Z/xsGrWlFjO
	 dPJc3I/zFisn430Zi8ynhRgdJSlnA/8w+ZcjD4D2vbdALeb5nBqqnN2owciH8ZCGfC
	 PPLYDEhp7WIVnoQcE4SydXc6pZDqEBeMJ8oL5NniJIhzmpULI/quIWxYdIl3/3uB2p
	 gqZbu2r6M28fF8O5V4Kzh6cV4DQQg4SiNKmM1Rv726fUIy5fv8SNm+D+Py/Qk8bL9/
	 x+Go1k4tWNvZcNsZUpb3t7hs1wvI8iLM4ELTn7g/aNAoZui0aud1RS1LkECeLU8kjo
	 5ZZWhKXWH2IYg==
Date: Fri, 12 Jun 2026 17:50:10 +0100
From: Simon Horman <horms@kernel.org>
To: angelayucode@gmail.com
Cc: dsahern@kernel.or, blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz, linux-kernel@vger.kernel.org,
	angela.yu@alliedtelesis.co.nz, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] [PATCH] l2tp: fix IPv6 xmit frag failure for
 oversized non-GSO packets
Message-ID: <20260612165010.GH671640@horms.kernel.org>
References: <20260610223557.2765487-1-angela.yu@alliedtelesis.co.nz>
 <20260612164213.694784-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612164213.694784-2-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298733-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:angelayucode@gmail.com,m:dsahern@kernel.or,m:blair.steven@alliedtelesis.co.nz,m:carl.smith@alliedtelesis.co.nz,m:linux-kernel@vger.kernel.org,m:angela.yu@alliedtelesis.co.nz,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,horms.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E822367B138

On Fri, Jun 12, 2026 at 05:42:14PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, I forgot to update the boilerplate above.
This AI-generated review is actually from
https://netdev-ai.bots.linux.dev/sashiko/

...

