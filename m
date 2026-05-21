Return-Path: <netdev+bounces-290575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE3SCM5HD2r5IgYAu9opvQ
	(envelope-from <netdev+bounces-290575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:58:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523A5AAB03
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74AE3009B38
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829E3EC2EB;
	Thu, 21 May 2026 17:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260733EDE5F;
	Thu, 21 May 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385798; cv=none; b=ek3wtZ6mviEuEy3KdWNQ3BlpBS3upkQsxI8FS2lof9WLHGR4xTO4zakvOwU1F4jxv030ljIBMl2oE1uj9j38eXaUoAp0aWTp8l6SqGnA9a/46LEqzZRKz9fpDe/U4V2WvpP5Y3WWULXZrVnJ4Fo3j6qQdAP2obzsxwDrtE8RIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385798; c=relaxed/simple;
	bh=r8UWKLdksCFV4zXfTqFMFNBeRQnkn5bWJKALoiGh/1U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=phmEmPnR6z6bR/F5VcABn2of6aQ3ILTLA8QUfTNHaagNpBINzSdM+XxyHxZNTexRaarGNfIXjH1HPGBPz6PNBYQRG31AjgpS2uperM+EvwSyquE6/574ZZOrb75aT1FyDB5xk9kePD1nlQt5jw6x8wLD+/hr2IGL6COKL3xpKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DCE3592009C; Thu, 21 May 2026 19:49:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id D692292009B;
	Thu, 21 May 2026 18:49:52 +0100 (BST)
Date: Thu, 21 May 2026 18:49:52 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
In-Reply-To: <20260521175549.70c27369@pumpkin>
Message-ID: <alpine.DEB.2.21.2605211848420.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk> <e1c7eab4-b330-49ad-bd39-df7dbc0a9511@lunn.ch> <alpine.DEB.2.21.2605211329000.1450@angie.orcam.me.uk> <20260521175549.70c27369@pumpkin>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290575-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[angie.orcam.me.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5523A5AAB03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026, David Laight wrote:

> >  NB as I point out in the cover letter I made sure there's been no change 
> > to binary code produced, so I expect no fallout, and as we discussed with 
> > Jakub the removal of the driver broke `git blame' anyway, so there should 
> > be no cost associated with the cleanup.
> 
> Can 'we' make sure that the commit that re-instates it has the git tag of the
> old version in the commit message.
> That lets people go back across the remove-add.

 It has all the usual `git revert' stuff.  Have you anything else in mind?

  Maciej

