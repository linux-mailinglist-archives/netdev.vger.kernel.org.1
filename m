Return-Path: <netdev+bounces-234975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DBC2A869
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 09:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82763A3F14
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493E2D4807;
	Mon,  3 Nov 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oNyzKVTn"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D828DF07;
	Mon,  3 Nov 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157643; cv=none; b=DfFUf6j4PvxzFDzCWWgF4zQau/cnmnTsaDWFJ/1Rk/+TJgCLLq1CY/+9Q2R33J2zFD94jGL60bzgQFJrK+s9xhnmeGIwGCIblmOfd8fvGDhxK5asl6xgswlDfj+Wt7KJLgizfLOBAIRDIVYlkNDLZys3SuMAhSHesK1vmUtvAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157643; c=relaxed/simple;
	bh=54n85ZwyayArP7yhougQewaTm0CQee0hnxz3GHcV5Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqfEUKf4mxuLuyYMB/uN0MXmuGJSpI+WCtB6dayKio5HD0jxqIR+9+xD4fl8MVatdH6f4LpzllnnNazt4ETeEwJfay2z5+F6EjwAPL6hHQrx24BasDd3010kEcVc6lpYblFN8nuu4UKZY3lU2cXkmCDKu4cAAYHYkS5ejcqvSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oNyzKVTn; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E81CAA0A96;
	Mon,  3 Nov 2025 09:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gw0/qyfr1zOYI5nSB/iu
	m7AsYKgJjol2bq0uNTSmVDo=; b=oNyzKVTndUf6k4MmwLMb9UdLqY3qOueDGlmA
	iAX37ynu3OZJab5CFUdMPhwsfkpXkXbOjUWCqOFZRVsDfvAACCTdhC4c5FXS09Gj
	h+gVgxj0c5y8iMPFrdD9GJyil/+V+BQYRcsBdq9x8C0QVztbhRbbbvycZV0ygGpF
	y16UXT+suwjmftg3ItVDXLGsFWltnMf9+8N5QcL5/ABlTZj0FMUFaXGMPIRh/MDS
	QV8fDzZNdljuujhy9SC6e4HbMe80m/d0LFj4pciU8/eqRKKogSROnL4DA8eHLYw7
	renehLdWFzvyccBD2W1aPSJpaNKibGC0R4WEuvXw91STG9yc3U1sMfPhZt51vf5u
	y1Zt0m26ZehAt9KvrJxhwHNi0l04kvrxMw+xuIzUUad5rhOUrCo0Hux+pWC8rKjr
	ZBI2VONAzieF66uKbgf/TXqeKLJbpw9uyW8fa4OiqPIpayZoUrpeoeQSU7s9k4aV
	/cY6dGL4O/eS2sb4ZwbQt9N42wJ7iwJ5QCClzGwgzAMNK9SEAenCj3/wZOVI0ZKN
	3KQ2mg57r4htDM1Kevb0yTmcf8XjsQy1MAYunu+ekjvdTPiOSAh6yGanBl1+GKFM
	RokppcrenaqVqyGcg2xpgbr6gg9P0oQ3VaztgLLWZFjhe8Z34TkcGaLkwwNc/hdV
	iL5MD00=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH v2 1/1] dt-bindings: net: ethernet-phy: clarify when compatible must specify PHY ID
Date: Mon, 3 Nov 2025 09:13:42 +0100
Message-ID: <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
References: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1762157629;VERSION=8001;MC=2379286761;ID=111644;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F66756A

Change PHY ID description in ethernet-phy.yaml to clarify that a
PHY ID is required (may -> must) when the PHY requires special
initialization sequence.

Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V1 -> V2: Changed wording on maintainer request.
---
 .../devicetree/bindings/net/ethernet-phy.yaml          | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2ec2d9fda..bb4c49fc5 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -35,9 +35,13 @@ properties:
         description: PHYs that implement IEEE802.3 clause 45
       - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
         description:
-          If the PHY reports an incorrect ID (or none at all) then the
-          compatible list may contain an entry with the correct PHY ID
-          in the above form.
+          PHYs contain identification registers. These will be read to
+          identify the PHY. If the PHY reports an incorrect ID, or the
+          PHY requires a specific initialization sequence (like a
+          particular order of clocks, resets, power supplies), in
+          order to be able to read the ID registers, then the
+          compatible list must contain an entry with the correct PHY
+          ID in the above form.
           The first group of digits is the 16 bit Phy Identifier 1
           register, this is the chip vendor OUI bits 3:18. The
           second group of digits is the Phy Identifier 2 register,

base-commit: 0d0eb186421d0886ac466008235f6d9eedaf918e
-- 
2.39.5



