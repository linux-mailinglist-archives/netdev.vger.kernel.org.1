Return-Path: <netdev+bounces-281311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FveHsM672mD+gAAu9opvQ
	(envelope-from <netdev+bounces-281311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804947109A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B1B63073C27
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326330E84E;
	Mon, 27 Apr 2026 10:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1830DEA2;
	Mon, 27 Apr 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285408; cv=none; b=r+0+8Kb19Ta1ucc0IgqKgwUXxLfWF8IP0xgkMYN5/JwTscIfQQKuYqlgIZ5Diw8MmuaJB4OLI2g5VYfiPTCghfUChPg1ywqSl6SFn0YDp9YxOtGgBhOx6YERuUpFRolP+cx0SAfAirFCoq5UMfP6FPSJoz+N+MPiKKOw0ia2sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285408; c=relaxed/simple;
	bh=6v46Sw6068fw1Ozo+2xmT+X5Pw/sFtV33b4UtV7SE5E=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=od3w+5vqJEl94uwspoj0W19OlD2iqjHhRRKuufwDDJaFFs38VzELkAtFZzy7pHa/Zudldra4kRdIELPzOT4ClJi0GhAuxsrceS7CWWxLi2gVn6R0bnRbrzkxM0D3B6oQlD/DIMBS34G1BFCYOg8PChBrkJReqWMlW8J82MTWX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C934092009D; Mon, 27 Apr 2026 12:23:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C74A592009C;
	Mon, 27 Apr 2026 11:23:17 +0100 (BST)
Date: Mon, 27 Apr 2026 11:23:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 2804947109A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-281311-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orcam.me.uk:email,angie.orcam.me.uk:mid]

It appears there's a need for a maintainer for the 3Com EtherLink III 
family of Ethernet network adapters.  There is documentation available 
and the driver is very mature so the task ought to be of little hassle, 
so I think I should be able to squeeze in any issues to be addressed.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

linux-maintainers-3c509.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -67,6 +67,12 @@ Maintainers List
           first. When adding to this list, please keep the entries in
           alphabetical order.
 
+3C509 NETWORK DRIVER
+M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/3com/3c509.c
+
 3C59X NETWORK DRIVER
 M:	Steffen Klassert <klassert@kernel.org>
 L:	netdev@vger.kernel.org

