Return-Path: <netdev+bounces-289893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI77OBmZDWoMzwUAu9opvQ
	(envelope-from <netdev+bounces-289893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C46758C47E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C4483036A22
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6B3A3E95;
	Wed, 20 May 2026 11:19:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048B93BFAD1;
	Wed, 20 May 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275940; cv=none; b=PemKmby4AZGSY3AFkGyQt+P6b1eEk7IjxnqYyvYC7lmWbGddOPoj+b5kAsXIAM757kB7a6yQvbpwK2kgebI65IIFfV+qYqoprdPbGZTIrECvHMXEr5wULMNN2f4vfzinyPUpseai5/IReBKpNGmol0dznXoDey/4riAHktRdLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275940; c=relaxed/simple;
	bh=Gga684UYpjR7e5qC9JO6/UvxtvUp3k6Cm0LtoDfgVXc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BWNoG+IfKZulwUiqn7t6f5rwlhin4jqm8ltosmhjPhVOLaEYGycYqSg3kmL3VpJIDwecF06VSZQy2oBrXYDBn1peFx0WxSGT53/Un1O+ohHHRycbtb1TqfZwb0hVD7IqIRC8UzzM1n3G/nSYSQwwrP66IPkAKKu76OKLDdLsHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 02B9692009C; Wed, 20 May 2026 13:18:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EFD0592009B;
	Wed, 20 May 2026 12:18:57 +0100 (BST)
Date: Wed, 20 May 2026 12:18:57 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/5] ethernet: 3c509: Add GPL 2.0 SPDX license
 identifier
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605201206370.1450@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289893-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[angie.orcam.me.uk:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,orcam.me.uk:email]
X-Rspamd-Queue-Id: 5C46758C47E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This driver has landed with Linux 0.99.13k, which was covered by the GNU
General Public License version 2, and no further conditions as to
licensing terms have been specified within the copyright notice included
with the driver itself.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/3com/3c509.c |    1 +
 1 file changed, 1 insertion(+)

linux-3c509-spdx.diff
Index: linux-3c509/drivers/net/ethernet/3com/3c509.c
===================================================================
--- linux-3c509.orig/drivers/net/ethernet/3com/3c509.c
+++ linux-3c509/drivers/net/ethernet/3com/3c509.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* 3c509.c: A 3c509 EtherLink3 ethernet driver for linux. */
 /*
 	Written 1993-2000 by Donald Becker.

