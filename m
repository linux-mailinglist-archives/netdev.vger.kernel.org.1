Return-Path: <netdev+bounces-270444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK18Kl4KwWmUQAQAu9opvQ
	(envelope-from <netdev+bounces-270444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:39:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BFF2EF343
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 964633007488
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69721386C34;
	Mon, 23 Mar 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VVJL01JE"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9918D29992B
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258780; cv=none; b=FfjhF0lwwV8xN5BGknGQhRanpou+o+vGVL2CYEKnJ0Z8oCDU2A3h158f6ChjnXZw40Zz3g2hJzuo5XOIyhOBp6teT59hjA0abP1YtDkZ2gKc/Yg81hDxXeYv4Ce26D9hBho3tgYx85J/jrDuw+YnuVGUJSqERplj5SRnvIPO0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258780; c=relaxed/simple;
	bh=CtREjtYUErNei1WWtCpEy/9MeVxaYUz32mC5eZ7Fh2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTEYs7cwULtXtaHX+iiPkRVb+Hb6S37u5ML+3FoT/vqt9/4xHW8s3lNyBLxKXsETc1VTVIQvl0CPsvoEdKTjDbE2DlQJA5FLLJG5d7XVUHdtO1LEKqiivm8DA+jFGI62x/tKRyMImv/DQjevBVF+tTu82tclqA+xf3G1pmeQs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VVJL01JE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7F5E5874;
	Mon, 23 Mar 2026 10:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774258699;
	bh=CtREjtYUErNei1WWtCpEy/9MeVxaYUz32mC5eZ7Fh2U=;
	h=From:To:Cc:Subject:Date:From;
	b=VVJL01JEFv5cnLs7xSwqok45AzRLo0XwBFW9rfJxMdud/+WHEMN1TcKFD/TzP7Zdr
	 Sf5Sap6PLQBQ7SvHng1gkA+h7r4OAAAQRjNPJs3sAgn1SHaUGa2z01ZY1cZ7JGw/K1
	 SdAqXUmR/6DBlvcQo++Xza5qdeyUKtKIeWgwP5N4=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: netdev@vger.kernel.org,
	imx@lists.linux.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] net: stmmac: Disable EEE on i.MX
Date: Mon, 23 Mar 2026 11:39:31 +0200
Message-ID: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270444-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,armlinux.org.uk,lists.infradead.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45BFF2EF343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This small patch series fixes a long-standing interrupt storm issue with
stmmac on NXP i.MX platforms.

The initial attempt to fix^Wwork around the problem in DT ([1]) was
painfully but rightfully rejected by Russell, who helped me investigate
the issue in depth. It turned out that the root cause is a mistake in
how interrupts are wired in the SoC, a hardware bug that has been
replicated in all i.MX SoCs that integrate an stmmac. The only viable
solution is to disable EEE on those devices.

Individual patches explain the issue in more details. Patch 1/2,
authored by Russell, adds a new STMMAC_FLAG to disable EEE, and patch
2/2 sets the flag for i.MX platforms.

[1] https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com

Laurent Pinchart (1):
  net: stmmac: imx: Disable EEE

Russell King (Oracle) (1):
  net: stmmac: provide flag to disable EEE

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   |  9 +++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 ++++++-
 include/linux/stmmac.h                            | 11 ++++++-----
 3 files changed, 15 insertions(+), 12 deletions(-)


base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
-- 
Regards,

Laurent Pinchart


