Return-Path: <netdev+bounces-253767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDDcFoKAeGkzqgEAu9opvQ
	(envelope-from <netdev+bounces-253767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:08:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1A917E6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED9B8301379D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460B3358DB;
	Tue, 27 Jan 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1f5wbYp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF2332EA1;
	Tue, 27 Jan 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504827; cv=none; b=nkmHNSrrIWeSzqU5pPotqbDrelCaalQL7otut4CSTbNc1xjHoSyvX6yXk8AyKuBtxrFi7dses1nC5T55rWGtiyk9i7T8dWOQyjCaOpyHuOj79Tl+j5fs7wpTnEuJp11ffshYXhi8R2IpSa22sB6gGLDmXIdI2jK3//bzHkZYTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504827; c=relaxed/simple;
	bh=kS+B5OilLXGZ1gQvzUctLuiqxVciKaom7Efo5RZq9XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQyYVm9BRRrEJkpLlv9MPJpkeuXCoJQjKF86sGe1lf8+ad/ruhlLW398w42mp1nRT/cmFEjwo0vJimxNkqjN1FoDqWtxO2FwNLmm6bJkahnYTzAGF13+nFYPTtzDnAK4jaPQlXBCyLHKzI6tlrNvxIKvKbeKhmoi9atMshN4KTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1f5wbYp1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8162A1A2A6D;
	Tue, 27 Jan 2026 09:07:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 58189606F5;
	Tue, 27 Jan 2026 09:07:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9BAC119A8687;
	Tue, 27 Jan 2026 10:07:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769504823; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m/Z7ATQ6+ydNQ6rrHsbH1591WnW/lV+NFsdbKJ+MOOw=;
	b=1f5wbYp12K7eRm/s11SVydzICy21FpKRCOORGMB/ubbTQfNnBoRZqnufrk4oaThI88mFTf
	Fgj6BqeGh4jYbjFR1L3l2AZy98RmOG6t5AV9RPAaeg5BVK6SH+GAK7r/0PZLNLLTvz1GEB
	lI3FkKwT4zr7goQU6bM46MqEeCAQjK4iFmFYXUhfB9ZCr9t3HhMQnelJaG1vtWbXc8K1U1
	Ja8C1B0fH6sJbT7MI5VvlIFx0JWS53pW/C8qbMyifSBMij2qSsIetF5lbrf7y5NsKay5qv
	n2jJukcy0ZZOWdkXcGLeucHzT4GeVricOhjR5tmitLLV7WcmdjbqRxXq2SVuPg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 27 Jan 2026 10:06:48 +0100
Subject: [PATCH net-next v4 6/8] net: dsa: microchip: Enable Ethernet PTP
 detection
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-ksz8463-ptp-v4-6-652e021aae86@bootlin.com>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
In-Reply-To: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 8CF1A917E6
X-Rspamd-Action: no action

KSZ8463 needs to enable the Ethernet PTP detection to fire the
interrupts when a timestamp is captured.

Enable Ethernet PTP detection.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 5daadf62689e6d60ab32e7a5a6c1f3fac3024b87..7eb033157f226b1169bc184d71569328e9a20a5b 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -947,8 +947,8 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	/* Currently only P2P mode is supported. When 802_1AS bit is set, it
 	 * forwards all PTP packets to host port and none to other ports.
 	 */
-	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS,
-			PTP_TC_P2P | PTP_802_1AS);
+	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE,
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.52.0


