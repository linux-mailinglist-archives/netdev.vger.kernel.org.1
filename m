Return-Path: <netdev+bounces-289897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGXdGvyeDWqC0AUAu9opvQ
	(envelope-from <netdev+bounces-289897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C990C58CE10
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883C031533E9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29813DCDA2;
	Wed, 20 May 2026 11:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703C3DC4A7
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276011; cv=none; b=aO+5ohNIsL76ZNbed0y/ShhOcpoNKfcCd+X+y/QFF0uqX37riGUgHSBWAL6YFnJ75u1U1vPBQdkmPjA0pfagwk3RhM9WWtqM5CKwy0gwFL8N+cBkNyIRGaIHrPbtV3kWdGYD1kdU7WpZMAfvnGIohxlmkg+jbVgKPvr1sCHgLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276011; c=relaxed/simple;
	bh=O3/4Fef+fRm/TTRKXy3GOM2xnA5Vdt8HGJvp4relVjw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qj1ejj8OoefM0wFgeA3m2YdnOQCMloaMZ877FyHC9It0EFhMLglwDHZ/V/M5q9n6gMxjvim1ZiL1RfbHP+scibALy68egYjj+SgcvPaY1Z3ghuFtqqNRx2ttx1AJdzurZMRfIheJWbTvYUfiESwHjtZ42jTgf3gPXsTgTQo843o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9BC4892009C; Wed, 20 May 2026 13:20:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 94F3C92009B;
	Wed, 20 May 2026 12:20:06 +0100 (BST)
Date: Wed, 20 May 2026 12:20:06 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
cc: andrew@lunn.ch, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] docs: 3c509: remove note about card detection
 failing with overclock
In-Reply-To: <20260428052003.66510-2-enelsonmoore@gmail.com>
Message-ID: <alpine.DEB.2.21.2605201148280.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2601260039220.40317@angie.orcam.me.uk> <20260428052003.66510-2-enelsonmoore@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: C990C58CE10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 27 Apr 2026, Ethan Nelson-Moore wrote:

> > -- so it's not about using a time-based vs some other kind of delay.  The
> > comment to be removed was only added along with the whole document on the
> > 3c509 driver with Linux 2.5.13, much later (2002 vs 1998), and therefore
> > still stands.
> 
> I traced back the usage of udelay in this driver and found that id_read_eeprom
> did in fact use a busy waiting loop before kernel 2.0.14:
> 
> https://github.com/schwabe/davej-history/commit/8cf64f0c94dcbf029dc3b12cb8e2afba590f8f72#diff-9acb56ec07fd10ccce51b1dc719976d60ee5a947dec31174e2a96f871fde72f9L331
> 
> This is probably what the comment was referring to, and therefore it is in fact
> incorrect.

 Nope, the driver used to use:

	udelay (500);

which is what documentation refers to, quoting the delay value of 500 
verbatim, as I noted in my reply, and as from 2.5.46 it has respectively:

	mdelay(2);

and:

	mdelay(4);

instead, so the commit description proposed was indeed incorrect as the 
delay mechanism didn't change, as I indicated.

 Now the documentation piece discussed wasn't updated accordingly in 
2.5.46 and likely asks for a fix or maybe removal, but the justification 
needs to be correct.

  Maciej

