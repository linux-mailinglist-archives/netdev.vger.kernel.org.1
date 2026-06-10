Return-Path: <netdev+bounces-297402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CAXGJq7EKGpCJQMAu9opvQ
	(envelope-from <netdev+bounces-297402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:58:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1066655B0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:58:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=elkSS2mY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297402-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C583300608F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01701A0BE0;
	Wed, 10 Jun 2026 01:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7540D56C;
	Wed, 10 Jun 2026 01:56:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056587; cv=none; b=OoPNHJ65jXwTmVU0mXRb46rq+QVAWlCwNjwFI6s3H5rDeJ/k0D2sXHjDNUM+IAs7B+iroGIt9OiOMUL3QeklPXQkdQXGi+U958tooQpSdKewrygsNrWOwPXhbJz+3DPy03yIcKq+c8vMY59C0G2VgV1Ek3vJO4gv7x/5l+2zdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056587; c=relaxed/simple;
	bh=jqEH/I4ORqQHaVFuiF+WyIc9xDvqyp0+Da3ck9EklqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/HIxM8fMyn8fk+flEfq+rnxBzsoPdLDYVmONA718roFJOd4a2hltXqlCG80Pk5XwYjgr6EIFk8q7aDbZ2lZR+fVJJOpE8sWaMj5Ls1JSMqhGwAv3EQSigafEhLcWJELbkRqbmaUoY0OmHZxAUivVscWp3oFbGBUvyb/y+iVE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elkSS2mY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135AC1F00893;
	Wed, 10 Jun 2026 01:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056586;
	bh=RWQWcDFojEGqcP2PeWpgKeXklxJCD4SA/cMgzCf1SMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=elkSS2mY6LN55qxmNJIreK2zXIQX9DHNCZF2Rv9xc7dSpxWJWJpCy9ivwQQDdNbhr
	 YqS4pbIZ+zPaUAn3eOqf/l7dmfmiz2C/tdQrL/WrSQlcGF4KCF6R5HEAujj1dILj2p
	 SbTf7adDvGH1HosjxKq5GnkwklUnPfBSP5VQGrdUI1Ziz3B9iUYNBCcpIxY9HcpjKd
	 fblRN6mAY3p3tvH5vskjt6vyi4wHkz3Q5y9516ZJOLs1PLfYcj17Al7bi/QeiqO5Xl
	 BME0mS5BSk7G7LHsFILS5Yf7dv4/8xyQ2fmAM0bP15CvFzZujbflcp6NbwNOCWVDJM
	 58fDFitcS45Ow==
Date: Tue, 9 Jun 2026 18:56:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:TC subsystem),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net/sched: drr: reseed active class deficit after
 quantum changes
Message-ID: <20260609185625.6e4bb757@kernel.org>
In-Reply-To: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
References: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297402-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B1066655B0

On Tue,  9 Jun 2026 00:36:18 +0000 Samuel Moelius wrote:
> Subject: [PATCH] net/sched: drr: reseed active class deficit after quantum changes

If the change is not for a serious bug it needs to be generated against
net-next. This was generated against Linus's tree I guess and doesn't
apply to -next.

> Changing the quantum of an active DRR class leaves the old deficit in
> place.  The next scheduling round can therefore use credit accumulated
> under a different quantum.
> 
> This can be observed by making a class active, changing its quantum, and
> then dequeuing with the old deficit still present.
> 
> When an active class quantum changes, reseed its deficit from the new
> quantum so the changed class weight is reflected immediately.

TBH the current implementation is how I would expect DRR to work.
quantum is the "refill" value, it should not reset the state of 
the current round? It wouldn't in an ASIC.
-- 
pw-bot: cr

