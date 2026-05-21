Return-Path: <netdev+bounces-290577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFn6L39JD2ptIgYAu9opvQ
	(envelope-from <netdev+bounces-290577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:05:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 637975AAC13
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 690CC308F6A9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FA23F44F7;
	Thu, 21 May 2026 17:55:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C930BB80;
	Thu, 21 May 2026 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386142; cv=none; b=QNFF5DbxWvdUt6QP8Rr1KtRkuXE6ahRBBWIw1r50sJMfpvnFmv0ivOOOV7JPIT03x+blDz7K+eoxeBi0Qn/THOL5ucBMtA9ZDFaC4EoTUaQ2/XPVWAtmTjPN0u65s+w8r+fjUVieNQ9drKXJFT1Sr99imOJLbHbZgEIq/aB7pWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386142; c=relaxed/simple;
	bh=lmS4wzQFIu/9MH7Qr7cAn+PdWhDqMSVASRmd7euYDfo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SM/k0C8Hd/DUk/PsKnLJX/QerTpAP9l4uA4n2zTYH1eeXK0w8Qzl8PrfI+3ih6I2Z7cO7RJfp9sAZHI8dNAyCxtcALRInLcj7XplJqNF342wRZ67a8JFSOUnNYJY9XXbUG5MGS5fS/Y+EVjthEkukzbfBruJ55NiggaGsAqwZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9BC1E92009C; Thu, 21 May 2026 19:55:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 957A092009B;
	Thu, 21 May 2026 18:55:36 +0100 (BST)
Date: Thu, 21 May 2026 18:55:36 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
In-Reply-To: <20260521082703.2991393f@kernel.org>
Message-ID: <alpine.DEB.2.21.2605211853030.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk> <e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch> <20260521082703.2991393f@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-290577-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[angie.orcam.me.uk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 637975AAC13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, Jakub Kicinski wrote:

> > The problem with these sorts of patches is that they often break
> > stuff. This driver has been stable for a long time. Do we care about
> > coding style issues enough that we are happy to possibly break it? Do
> > we want to spend time on debugging it? Probably more time than it took
> > to fix the checkpatch issues?
> 
> The way I look at it, Maciej is the maintainer and has access to HW.
> If we have to keep this driver it's better to modernize it a bit.
> If nothing else it shows the maintainer is willing to put in the effort.

 FWIW I've been around with Linux for 28 years now and have no immediate 
plans to disappear, although as we all know this may happen anytime and 
eventually will anyway.

  Maciej

