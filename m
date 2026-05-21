Return-Path: <netdev+bounces-290401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO8YMk8HD2qFEQYAu9opvQ
	(envelope-from <netdev+bounces-290401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:23:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABBD5A5B09
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BF27320BB18
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6073DCDBA;
	Thu, 21 May 2026 12:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1463C819E;
	Thu, 21 May 2026 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367537; cv=none; b=rZAQh81iln4o5rNChvxlot4JqU0OhlcvPvrNuOFc4hcCZQkcHrQrCBlGBPWm0k6o9tP+HWDRRrxsF4e9Y/nzOnsIQX6UQi2GpQzIskgRD74TIVvBGhvjWMRRo1USOIEwsX8Z8k4d4xNTq9a5HJbDjAF3t0EBC8QznFrj6nxpieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367537; c=relaxed/simple;
	bh=HNznpNKXvpGW7RXhaCy71GovAW3T1uNQxCXPoOOEoz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wk2r/zLivgMSK6Vr9PnUrFVv7qu/DYBZl/YavxlnMN1gCcanOliizU3F+/CU1SQaWbwVpsd0QInM0D/dCd/f3C/pMZPFaa4NLVyg6Pa9meRM28zXY5Df+nO4v+dM6LrS4iFUrJkD7bT9s2yGkSck7uCpXGKrgnT6SHeBEUjMkr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9DE2C92009C; Thu, 21 May 2026 14:45:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9706A92009B;
	Thu, 21 May 2026 13:45:26 +0100 (BST)
Date: Thu, 21 May 2026 13:45:26 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
In-Reply-To: <e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
Message-ID: <alpine.DEB.2.21.2605211329000.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk> <e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: 4ABBD5A5B09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, Andrew Lunn wrote:

> You need to split this up. Patches to net are likely to get back
> ported, even if they don't have Fixes tags. So please add the driver
> back in net, but fixup the issues you have found in net-next.

 Sure.

> There is also an question of if we want the coding style patch or not.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
>   1.7.4. Clean-up patches
> 
>   Netdev discourages patches which perform simple clean-ups, which are
>   not in the context of other work. For example:
> 
>   * Addressing checkpatch.pl, and other trivial coding style warnings
> 
> The problem with these sorts of patches is that they often break
> stuff. This driver has been stable for a long time. Do we care about
> coding style issues enough that we are happy to possibly break it? Do
> we want to spend time on debugging it? Probably more time than it took
> to fix the checkpatch issues?

 The cleanup was requested by Jakub; since you're both maintainers for 
this stuff would you please sort this out between you two?

 As I noted in the discussion referred I'm fine either way, and especially 
now that I've gone through the effort.  Overall I'm not a great enthusiast 
of such cleanups, as mentioned there in the context of the defxx driver, 
which IMO suffers from much worse coding style issues.  I'm even less an 
enthusiast of folding the cleanup into the revert, as it's a recipe asking 
for stuff to be missed.  Plus I do consider it important for 2/5 to apply 
cleanly on top of the original code.

 NB as I point out in the cover letter I made sure there's been no change 
to binary code produced, so I expect no fallout, and as we discussed with 
Jakub the removal of the driver broke `git blame' anyway, so there should 
be no cost associated with the cleanup.

 So as I say, may you both please weigh in pros and cons and let me know 
of the outcome?  I'll then proceed accordingly.

  Maciej

