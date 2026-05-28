Return-Path: <netdev+bounces-292828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAlKM6OZGGr+lQgAu9opvQ
	(envelope-from <netdev+bounces-292828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:38:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C85F739E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4FBC306C59F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CD40911E;
	Thu, 28 May 2026 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smb+A4NU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66AB3FD12B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996962; cv=none; b=t2Mrtn0hP+7F6JinbmXT/NDbnRW7wSk65YSng6z3RoQEChb7C0dvaFtv+FuowvRFb1pTrBYoj2ze5QdhJDcCJi2bS6F8t7cHnUVUYyQDQnviXGpwrH3oHuhyq94NvJ9BXEAyYuzGhjBiaZiET+BPsNHMaI/YyOd2dnHbL931mPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996962; c=relaxed/simple;
	bh=xsXICI5h6DgnJjDwpEi8t56/6QfLbeKAlXD1MKlRBHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA18t5+ASZ2Mm6pIRPX6XC3YlvCUAwef14NC5HSdcCQ16YCfPUMpYEtICBSCo7QD5QcMOWGhSfOcAInKGa6KK55hln83Us2e6qbrh8qLMk27rtjsIZA0WDTm1GGNkwo7jPESH2bpvgyVdAr2gQVKgd+bFI41Q0m4o6LoeQWMoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smb+A4NU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso51876655e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996959; x=1780601759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1epXm0spYI+xC3YQ0LGbrxeOVg6XYaBQS/no7GVttJg=;
        b=Smb+A4NUW6hM9UiRxqkHwT/9H9FTOIFO9FFVUvFkwfkUxM8GsD4Ocqo3/QQGVfljq0
         Xc4IlHAri3PmQGEEWvOcMNK8cjVwZX5dVCeq1YUj9dLkw2AvqZqaBPkCfdybTPyE/2bU
         nnoeDPsp3XJQkHJWz9fr8xNgwfpu9WDRap7sUszMhdd4tVnMn/Ehm2aZMJQfkT6H4XyY
         I15xgLO6mntv4zmCkLvPIcS19m0v4J0oCJcl/5gF+0GAxX2Gy0L+3vWcf+s3Cn+qh6Ss
         QGovE0BqfUK7LanGmmgi50W8ADGGuRzVSSdlcwwzuo/ipS+CXXu93z/qQxYO4nHFosR2
         Yl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996959; x=1780601759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1epXm0spYI+xC3YQ0LGbrxeOVg6XYaBQS/no7GVttJg=;
        b=XTZtcxehHGyL8Show7Q8xwhZpkaQ6EZtBHwtWQJXMCa0k2rZjzZImw4jG35eWTHeJr
         pwxw80NiYsuSt9VkUDyRN7bTNyGhrT//y1i4GNXrinFip/8Gt2pjFt54hzDNPVgcBhBi
         nn042cycXWW/iGyNNE3f/NQ3TYmrqgReZ2yf1453XnRVn4N1rIWr1cdMBe9YIYGLhlul
         C3BYhz0C2uIvKrWgoAtwvo2hVQRzRtAgIWf9yWVcQmkW/kQKbHUT3mfZv6/FzaJKOI1Y
         ltDu1udp7ziz6muDs2ROL2RK4QYMeEobmsIKrpS9oPJ/MOfwLDjwFoAG2BFafgxzKax9
         U6cw==
X-Forwarded-Encrypted: i=1; AFNElJ/SCwR94Bg24S53tRD7SPnm1aZygksdjUdH7DoOTRv74WCY8idS4oNaqb0Q7hBmEeOxwso99L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDC226z5zGtKO2uUbJbmIz7S37sN+ibhrg5ctjYovCBq40mBFz
	5Dv6vwKhV9UBttc3UDcDDeMqlMBwG9JYJdDdAILOHXtWAvevIic5OmNL
X-Gm-Gg: Acq92OFv+ynY6BPj7RZM6YNCFVYsOXaQEDy86i99bLdH07hHSLQ0hoGCpQrRFWEznvp
	wpz9IHRCvBUVhMAd2ctKDM7qMumIbbKKuVm8w8jSrS5GsA+4H+FsBa8UmlM072N8tmqmJ9GVVAc
	Kjtc9zheQtANg92zsXBZAMnaTqaPUrNSmgCf2v50e9p4+nH/0gM40vUA+MsF5xZtXWxSZoh/1x6
	NBEyjNT8htvN/rxjLYOmohmTemUvWmb8DqLZp8zVxT2IdpEWBtrNELSbyoyIjahM88NikJTRAgQ
	PQ00VP6dtldbA5yhtkCio+fszbuGVL/lIepKzKaZQpHMTc1njzCPH1nURdNGTME+SjugfxHsP1v
	DBCEyzsMhbH5NIe66HltujIeBB/We+S6sMIxtTKWiHetTDDiJDSffsQ4PqkdAFeq1JgCcofHa0a
	EHNFLdi0Ur5jHji60Lz27FUekIa0w5Usmoh2zgg8WEnXnk03/yGS2vWLj5VWrUqdfk4ivUgJ3Wb
	nWsnF0=
X-Received: by 2002:a5d:59c5:0:b0:45e:8526:7dd7 with SMTP id ffacd0b85a97d-45ef05e8290mr823717f8f.27.1779996959084;
        Thu, 28 May 2026 12:35:59 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eec5eba06sm4220471f8f.22.2026.05.28.12.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:35:58 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: phy: as21xxx: fill in inband caps
Date: Thu, 28 May 2026 21:35:44 +0200
Message-ID: <20260528193545.11160-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528193545.11160-1-ansuelsmth@gmail.com>
References: <20260528193545.11160-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292828-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 449C85F739E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add .inband_caps function that enforce In Band for USXGMII. With further
test it was discovered that the PHY always require In-Band for USXGMII.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index a6686b4908c6..1b69c2fabc1d 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -967,6 +967,15 @@ static int as21xxx_match_phy_device(struct phy_device *phydev,
 	return ret;
 }
 
+static unsigned int as21xxx_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	if (interface == PHY_INTERFACE_MODE_USXGMII)
+		return LINK_INBAND_ENABLE;
+
+	return 0;
+}
+
 static struct phy_driver as21xxx_drivers[] = {
 	{
 		/* PHY expose in C45 as 0x7500 0x9410
@@ -982,6 +991,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
 		.name		= "Aeonsemi AS21011JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -994,6 +1004,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21011PB1),
 		.name		= "Aeonsemi AS21011PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1006,6 +1017,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010PB1),
 		.name		= "Aeonsemi AS21010PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1018,6 +1030,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21010JB1),
 		.name		= "Aeonsemi AS21010JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1030,6 +1043,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210PB1),
 		.name		= "Aeonsemi AS21210PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1042,6 +1056,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510JB1),
 		.name		= "Aeonsemi AS21510JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1054,6 +1069,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21510PB1),
 		.name		= "Aeonsemi AS21510PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1066,6 +1082,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511JB1),
 		.name		= "Aeonsemi AS21511JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1078,6 +1095,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21210JB1),
 		.name		= "Aeonsemi AS21210JB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
@@ -1090,6 +1108,7 @@ static struct phy_driver as21xxx_drivers[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_AS21511PB1),
 		.name		= "Aeonsemi AS21511PB1",
 		.probe		= as21xxx_probe,
+		.inband_caps	= as21xxx_inband_caps,
 		.match_phy_device = as21xxx_match_phy_device,
 		.read_status	= as21xxx_read_status,
 		.led_brightness_set = as21xxx_led_brightness_set,
-- 
2.53.0


