Return-Path: <netdev+bounces-289895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAqyIFGZDWoMzwUAu9opvQ
	(envelope-from <netdev+bounces-289895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9258C4F2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB86630A4EB0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502C3D75B1;
	Wed, 20 May 2026 11:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D089939BFF4;
	Wed, 20 May 2026 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275945; cv=none; b=si/GE6BYOiQckYlncZP/UwQkBuEpqK1TQHiCAMInNO1REoqSlqDg6gIhYsK/l9rN1pOcW6fCZ6bjPPnV7Rf66+f/uDChOYqbBKo4rl2QBNxvagVJZkFkkG2wzzLM4cix4hzjZZWm+qdQVITMSABX5uYqK4uryoLXSMYdVDRnfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275945; c=relaxed/simple;
	bh=fhKHogF13CQnWF/QdDK5NkLPNK0juNowdd6DdjvSHPA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pfb7423Rz+WQekHIhuJhJ9QZkLb9LYR2Rm+ELmcb9as9zmZFlHcpnWXVhcrDaYt1w4DLKaoHMR0szrI4W2t/pY5cK7sZmXo8GEsYNPaVq0SSZToQ8jDGiQC9PGKRSUkMaUhTmlvFJJ4NLu1+mZEdD+LvxN6/8sVI0fwr4GnWOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5733C92009E; Wed, 20 May 2026 13:19:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 535EF92009C;
	Wed, 20 May 2026 12:19:02 +0100 (BST)
Date: Wed, 20 May 2026 12:19:02 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 4/5] ethernet: 3c509: Update documentation to match
 MAINTAINERS
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605201207380.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
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
	TAGGED_FROM(0.00)[bounces-289895-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orcam.me.uk:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: 56A9258C4F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There has been apparently a single message only ever publicly posted by
David Ruggiero, back in 2002, which added this documentation piece among
others, and MAINTAINERS was never updated accordingly.  It is therefore
doubtful that his maintainer status has actually come into effect.  Just
replace the reference then so as not to confuse people.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 Documentation/networking/device_drivers/ethernet/3com/3c509.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-3c509/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
===================================================================
--- linux-3c509.orig/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
+++ linux-3c509/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
@@ -12,7 +12,7 @@ release 1.0
 28 February 2002
 
 Current maintainer (corrections to):
-  David Ruggiero <jdr@farfalle.com>
+  Maciej W. Rozycki <macro@orcam.me.uk>
 
 Introduction
 ============

