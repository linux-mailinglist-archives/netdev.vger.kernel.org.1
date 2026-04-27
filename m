Return-Path: <netdev+bounces-281312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI7eB8w572mD+gAAu9opvQ
	(envelope-from <netdev+bounces-281312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:26:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E65470FA6
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 959EC3028881
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1630DED1;
	Mon, 27 Apr 2026 10:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075E309EE6;
	Mon, 27 Apr 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285418; cv=none; b=b51pOPHY8I9d0m9hq0kxVqAnTw/ClArVRpF2ZbNypyTz/J90sgDlbo4C3XUvocR+BH4kF6EPc+43ju79JBf5cAGiNE3ZsvwILxk0H2lJvjGA8X8tAhPDGPfhCsCU6DlHHU6Tvlxnv8HdJP0Dxn8P40VZR2uro3Zha8Zdq264kW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285418; c=relaxed/simple;
	bh=78RX5zGVLpXWw+msE8uORJWlQul6SCYIsGZZz1TCQQQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZO4GDc6ZYuELLkD0XU+/AFuzzpFfGo0zuTTwqLkewf+jUwlfCox32sJP0sCBJKwvcAb/Ok3OL3v6CECSmH259PlES7OWP5ODYNPf8kJLBwAyz17am2R+/1BRG9fhraKwio9rsOVuE4J+t/1CiWzQT6G0ALGr4GElicS52y914hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A731992009D; Mon, 27 Apr 2026 12:23:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A149092009C;
	Mon, 27 Apr 2026 11:23:35 +0100 (BST)
Date: Mon, 27 Apr 2026 11:23:35 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jakub Kicinski <kuba@kernel.org>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Add self for the DEC LANCE network driver
Message-ID: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C2E65470FA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-281312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,orcam.me.uk:email,angie.orcam.me.uk:mid]

Like with the rest of DECstation and TURBOchannel hardware I have been 
handling the DEC LANCE network driver for some 25 years now anyway.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

linux-maintainers-declance.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -6986,6 +6986,12 @@ T:	git git://git.kernel.org/pub/scm/linu
 F:	include/linux/debugobjects.h
 F:	lib/debugobjects.c
 
+DEC LANCE NETWORK DRIVER
+M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/amd/declance.c
+
 DECSTATION PLATFORM SUPPORT
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org

