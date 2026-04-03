Return-Path: <netdev+bounces-275167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN6mIegO0GlQ2wYAu9opvQ
	(envelope-from <netdev+bounces-275167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:03:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F57397779
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F4183036EAC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5A3630A2;
	Fri,  3 Apr 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DqEjNb1K"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3735A385;
	Fri,  3 Apr 2026 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242970; cv=none; b=YSNTzaveI4MT2UkzlIMAEWg3UYnZHhTiDMW1dsMpi7NevLaA0esArpRsih/RZdJcxCMlSBfL5x9AwEXV7W/vcRuuwFffKjef2qGF9c1tlpJEPLzG4HlXgQzmt0qg99Ncm/aGAcbZ20qthfEtbsDTVUnbju9aOL2eDPYV33EhIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242970; c=relaxed/simple;
	bh=xMJ0Nvap2CsnK2uUrSWpt8DVV7KnOOtBSBQOOGMrk+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OYCdocFJ2PwYP8yJsdr1odsKk5tevfJ6bRDafBS0rPjYdbvEK66No+gvQFC5iAMnEILlDtgOGh4Pxww8uNEEy7+wbig6oBpHwdK5Qi/tNtNsR78BoWaX2ZIDgVH2ED7TU7E2Ewansi8b14hYYsBxhHf5RSnw+gL3LJyP+6cnbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqEjNb1K; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 76DF84E428D8;
	Fri,  3 Apr 2026 19:02:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 326EA603C1;
	Fri,  3 Apr 2026 19:02:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A61A104500FC;
	Fri,  3 Apr 2026 21:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775242963; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AKUAxsGIowO/qrP3Ue03zFJGU3E4OczJZllSpoli1EQ=;
	b=DqEjNb1KN6GZpdZrVsSvAigRbFH5SDwLZj0XZNTWzbBIZqKgs1sgvnhgqs1/mQz7Kw/+bI
	/cnQy9RLEsaPDePl5EPR9UPEFgRterBtZeYMzDAArv6kjwFCcUdvNObJN1V8XtIHCR/pJN
	bd8K+JY9Q0EgoPLcjBudqHF2bpgvM3x4gLxTt+WDM5/Vp0ar1ybAR/ITt/gku1VzJLVUk+
	nyEp1MS1FWnW9kHkLliIWzsluKJ1f6J2Oni1dpNJFrEYfyOBWAXuSGuXTP3wTXKELplf08
	AQt/0HQsTBFCrpAuHHUlO41TNES2l6fyRXFWqQqHVttluss9882qEjyT9iylpQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
Date: Fri, 03 Apr 2026 21:02:22 +0200
Message-Id: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL4O0GkC/x3MQQqAIBBA0avErBuY0oq6SrSwnGqgNBQkiO6et
 HyL/x+IHIQjDMUDgZNE8S6jKgtYduM2RrHZUFPdklKEs8ZkAkZ/oj+1xsO4riFC6u1ql65SVvW
 Q6yvwKvd/Hqf3/QDdrtSYaQAAAA==
X-Change-ID: 20260330-b4-var-som-om44-lan7500-09dfdc713d39
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275167-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0F57397779
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The goal of this series is to add the USB Ethernet controller node in the
VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
devicetree and pass a MAC address to the smsc75xx driver. This was also a
good opportunity to create the schema file for LAN75XX devices.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (2):
      dt-bindings: net: Add schema for LAN75XX compatible USB Ethernet controllers
      ARM: dts: ti: var-som-om44: Add USB Ethernet controller node

 .../devicetree/bindings/net/microchip,lan75xx.yaml | 52 ++++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi  | 14 ++++++
 2 files changed, 66 insertions(+)
---
base-commit: 6fa0f2cbadc046c57fdd2aa1dad81553cca08963
change-id: 20260330-b4-var-som-om44-lan7500-09dfdc713d39

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


