Return-Path: <netdev+bounces-262699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFOSIuutpWmpDgAAu9opvQ
	(envelope-from <netdev+bounces-262699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:34:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CC1DBECE
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6207D30E97FC
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D96C413249;
	Mon,  2 Mar 2026 15:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB822157B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465294; cv=none; b=PxB6hs5dAmwBsD9VpPSSQOSUmFdhVtAqonASmjDorJ4JQ4bqDiuntxcIgIcPSshyQGoZAx3qKNI7wY1rV2mrR071xvsYu7q3y29umt/eM6RdxbZW3XbHq8vw9bzQgI9YXpm80cALPTAf6haa5KwhcAv009UMqy1TK47qFlsCl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465294; c=relaxed/simple;
	bh=kESa7BlQcqDPKo1mISYqOdErqWp1q3mT2qZ3X+VWvF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO3pMWIo+dVIqmYKgK0MoxZyMllFnjqR5QP/YOWhO+aiMPINAP/UG7Y0Q0dNjAO6KUhoGlLmDhJ8riIwZzRueI1W07mW6+hT226pgdnl5yxaD+og1GM8pac8hUrLeDV6KBG+hOx/TfEoInBdSok+i2NWEKj1XGKFf29SO/cUDXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bf-0004kT-5x; Mon, 02 Mar 2026 16:27:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bd-003P13-0H;
	Mon, 02 Mar 2026 16:27:58 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35F2D4F5475;
	Mon, 02 Mar 2026 15:27:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 12/12] dt-bindings: net: can: nxp,sja1000: add reference to mc-peripheral-props.yaml
Date: Mon,  2 Mar 2026 16:16:18 +0100
Message-ID: <20260302152755.1700177-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302152755.1700177-1-mkl@pengutronix.de>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Queue-Id: 9D4CC1DBECE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262699-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.927];
	DBL_PROHIBIT(0.00)[0.0.0.4:email];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,msgid.link:url,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,devicetree.org:url]
X-Rspamd-Action: no action

From: Frank Li <Frank.Li@nxp.com>

Add a reference to mc-peripheral-props.yaml to allow vendor-specific
properties for memory access timings.

Fix below CHECK_DTBS warings:
arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dtb: can@4,0 (nxp,sja1000): Unevaluated properties are not allowed ('fsl,weim-cs-timing' was unexpected)
        from schema $id: http://devicetree.org/schemas/net/can/nxp,sja1000.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260212163000.1195586-1-Frank.Li@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
index ec0c2168e4b9..6bcfff970117 100644
--- a/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
+++ b/Documentation/devicetree/bindings/net/can/nxp,sja1000.yaml
@@ -87,6 +87,7 @@ required:
 
 allOf:
   - $ref: can-controller.yaml#
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml
   - if:
       properties:
         compatible:
-- 
2.51.0


