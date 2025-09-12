Return-Path: <netdev+bounces-222583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF8B54E8E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D474B7B3A4B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E12FC897;
	Fri, 12 Sep 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="KbhEfAN8"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761C2F39CD;
	Fri, 12 Sep 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681724; cv=none; b=PjZMCAQNseO2N6oFpw+QGBnes/GceExYrs0wtS8e5SA7OTGVeP/k6hDlDmKHpGwN/ERy69QTXUmV0eVv2i72V7f/6DEy+NqQm23YPgt1RVk3spxAuUIiYdJ0uptf1pdMrRsfpyDIyvAI9fMfXh+SZeNNNuioBIuBv/XkevwHLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681724; c=relaxed/simple;
	bh=4piJL2JD7w/UByN+p8A0BTsfcXslKwY/3YwqSauegn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STiPM5iY1WrowupaBE8dilowJ+b3wuCr0uyLddMgtOTMXSKlVLUa0Ql5GCw84YshI3LXh2vQiGcREf2x/Nj/2/Lt6o8kLYQd1uuu1+D+lLbbBfa6sQ6ZUO6HV9QCXYfSCT6cfWnIPo3FVi+KZcWk9v6uZJbQWb7/M6EHexYzCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=KbhEfAN8; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6scNEiCwQDhpiTGreKSN8tOQ3odhAtWxi6tg8cuj+Pk=; b=KbhEfAN88WcM4pD441bT2l6Pa1
	23flmmlVtXb4d/OfaU+RBRGolmVniBWbCzoiGQUwB5r3WhnnaMr8RYY+D3naKECyvQhkVw817d2iy
	JSzir0qe4MxEkeVAUGhaTAt5ATR9/yj01IeY7UQGzzHX29VdwRSXJ1qS51q44OO2dEmuyO/RMFIOy
	waB+6mwaoGhA/I0K7eh4Dw4Wd3YKU6LgKyjy4h6JWHzJQfn2wi/kWbtv8moGnEuqdKeCCprlJ7D/7
	3hGFjLBh/my8YIFhU8TvsiQJJLAviSSF9zAlwQcLAN6Z93n4TdFBSz2cBSd+WWkWJTN6v7JsU8EXx
	KV5iBH5w==;
Received: from [122.175.9.182] (port=50898 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1ux3J7-000000025Qs-1rx5;
	Fri, 12 Sep 2025 08:55:17 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	m-malladi@ti.com,
	s.hauer@pengutronix.de,
	afd@ti.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	johan@kernel.org,
	alok.a.tiwari@oracle.com,
	m-karicheri2@ti.com,
	s-anna@ti.com,
	horms@kernel.org,
	glaroque@baylibre.com,
	saikrishnag@marvell.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	basharath@couthit.com,
	parvathi@couthit.com,
	pmohan@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	bastien.curutchet@bootlin.com,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v16 6/6] MAINTAINERS: Add entries for ICSSM Ethernet driver
Date: Fri, 12 Sep 2025 18:23:01 +0530
Message-ID: <20250912125421.530286-7-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104741.528721-1-parvathi@couthit.com>
References: <20250912104741.528721-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add an entry to MAINTAINERS file for the ICSSM Ethernet driver with
appropriate maintainer information and mailing list.

Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c930a961435e..47bc35743f22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25319,6 +25319,18 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/ti,icss*.yaml
 F:	drivers/net/ethernet/ti/icssg/*
 
+TI ICSSM ETHERNET DRIVER (ICSSM)
+M:	MD Danish Anwar <danishanwar@ti.com>
+M:	Parvathi Pudi <parvathi@couthit.com>
+R:	Roger Quadros <rogerq@kernel.org>
+R:	Mohan Reddy Putluru <pmohan@couthit.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/ti,icssm*.yaml
+F:	Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
+F:	drivers/net/ethernet/ti/icssm/*
+
 TI J721E CSI2RX DRIVER
 M:	Jai Luthra <jai.luthra@linux.dev>
 L:	linux-media@vger.kernel.org
-- 
2.43.0


