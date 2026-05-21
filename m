Return-Path: <netdev+bounces-290537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +2T+Hvw/D2qcIQYAu9opvQ
	(envelope-from <netdev+bounces-290537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAB5AA2E9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A99AF32B3ADB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA55B35201F;
	Thu, 21 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu1ZNH/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A034B19A;
	Thu, 21 May 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377309; cv=none; b=fqzZA4ZxDDCRWsHNWuVzvLqR1FP/ZhynWna3TFw51s4IhHHBMTPzapOGwZNDfPjIKkUHdWbRKp+/TPydsY11WL+OPAegmFyCHf122OFaMfyAfKEcnYbRdos17qQAUp6rF/1O05LcGVtOiynfFBS5a7uarr8h4g/tWR+0uewXuuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377309; c=relaxed/simple;
	bh=NRqcA9sShBPq1lQPD0ptM65IFbJItL4ygmoXBP9A6Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H44yJ2LR0Cex8kNAuxysC99ep/Eee2MnTtwxT57RXQ1EEoa0aScTrzcu20kL0A5yhPrdc+nXzi+x9ZW6/mph/Lg61v8C+Wt0CcnOc5BSs6iIkvlcpynHpftHLqvBD6Sm6b9MXB7wGlvKgWbnSrCNPppxq76+le3ecfWyWUZKmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu1ZNH/z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0999F1F000E9;
	Thu, 21 May 2026 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377308;
	bh=lu8kAxwWDCOCDDpNnj4m5XDSc4UU4OQl8r6sKDsrE8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mu1ZNH/zsGVydT/llqqVxHDMs2noDgFjGb5BH6EGqMwvWUPv6q5i2ZQU5suWW6u5b
	 O0E7fB3FSNh9pLOdT0lnobP56bhP97AKRNP1QZulo2lxJCUmUzgMvuVS/Cd3CwmF8s
	 18HXQDtGEtpY7hx3Wr4sWeRRjWpwpPvoqJguwms0PgyF4P9LCnR34OU4kucfC60zMI
	 KAZlZPggU8CNCG/9UVSUjWN31qRLuIz9zlXHyruDGHiNTbvk7/TSE1WhRjZtAr+lEf
	 WhEfnCpR/RmClzCdvI4VbAvdLf1vhIHJ1bE6p7jBYPXESn50oKWMAyt2k9DTiY4n58
	 twmKi8U/U0o0Q==
Date: Thu, 21 May 2026 08:28:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make
 some fixes
Message-ID: <20260521082827.279e640b@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290537-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 79CAB5AA2E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 12:18:44 +0100 (BST) Maciej W. Rozycki wrote:
>  As per the previous discussions[1][2] this patch series brings the 3c509 
> driver back.  Picking up net rather than net-next as I consider it a fix 
> to accidental removal and so that any downstream users do not suffer from 
> disruption when using released kernels.
> 
>  In the course of making the coding style changes requested I have come 
> across an actual bug in transceiver type selection code, where the old 
> setting is not masked out before ORing in the new one, causing no change 
> to be actually made in a requested transition from BNC to AUI.  I guess 
> this code must have been executed exceedingly rarely, as it's always been 
> wrong ever since it was added in 2.5.42 back in 2002.
> 
>  Therefore I find it not worth backporting to stable branches, however for 
> the sake of appropriateness, in case someone downstream does want to have 
> the fix, I chose to apply it second in the series, right after the actual 
> revert and before code clean-ups.
> 
>  The remaining patches of the series should be obvious; see the respective 
> commit descriptions for details.

FWIW sashiko points out a number of potential issues:

https://sashiko.dev/#/patchset/alpine.DEB.2.21.2605201115010.1450%40angie.orcam.me.uk

