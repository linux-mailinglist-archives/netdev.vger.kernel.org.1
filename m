Return-Path: <netdev+bounces-286231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZDDWFgjm/2kVAAEAu9opvQ
	(envelope-from <netdev+bounces-286231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D9050228B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 03:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15C613002D21
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD3196C7C;
	Sun, 10 May 2026 01:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93E1CD2C;
	Sun, 10 May 2026 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778378240; cv=none; b=nFf3R0tHCl6kPerUFFf2vynHb+58aWnQJCvuR0ldeohEGr43BCnvN7wBgEHDXlgOmcRyl5Erud5IrvMrWEzQ3gp4shomG9aGTMxBhjI4kZPI0N/9P7Me0tSjFV6WBMwB/9b7IpHRVJ4uUFhULGOqilZJLXlwtzaO6z1R6Ow9rcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778378240; c=relaxed/simple;
	bh=FeQt5ttcbWLwv/nN89wxXVpFGWK6iUKcx7y3nrQ0FZo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q+nacnHVKZnFyVh7gjLDu7T/Avq7kiwxFU5Z/Un3RCZjc+fUhdTzYIuKwMCrf6s+VCsvPpxP1Mb4MXrchYnC9QO5FarVr0J9n92wEo14MlqeBye8zJvaJgaISzWFaL9hPjXA9pNknTTlR6CYKG4aMuBNSkRC2d+WsbWLSBvBRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5F58A92009C; Sun, 10 May 2026 03:57:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5110792009B;
	Sun, 10 May 2026 02:57:15 +0100 (BST)
Date: Sun, 10 May 2026 02:57:15 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
    Ethan Nelson-Moore <enelsonmoore@gmail.com>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
In-Reply-To: <20260509230519.57607-2-enelsonmoore@gmail.com>
Message-ID: <alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org> <20260509230519.57607-2-enelsonmoore@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A3D9050228B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286231-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Action: no action

On Sat, 9 May 2026, Ethan Nelson-Moore wrote:

> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> [...]
> >   - MAINTAINERS: Add self for the 3c509 network driver
> 
> Hi, Jakub,
> 
> Did you forget to revert the driver removal, or have you just not gotten
> around to it yet?

 Thanks for the heads-up.  I can see the removal was fast-tracked to 
Linus; I didn't expect that, waiting a couple of weeks for people to speak 
out wouldn't have hurt.  Now `git revert 91f3a27ae9f6' is in order.  
Shall I post the output from that, or what is the expected way to handle 
this situation?

  Maciej

