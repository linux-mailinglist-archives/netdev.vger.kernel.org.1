Return-Path: <netdev+bounces-224564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48BB86473
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F13E7BEE28
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E631A7FD;
	Thu, 18 Sep 2025 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y06RAfwB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B931A7EE
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217175; cv=none; b=HvuKjx8UCLjyawEyKs9NtjNFQRjM+CA8+Mr2uIMGgj3ITl3+NkHNr0cUBslpOyKTGNVwXxmUEj+bUyUwPeIY977ONUIJTcpHL3cvelFB2LjPkrM2QrlG/2WZ4aQn+Sn1ww0undCSqWc0plTC1vb5T45wrAz++DN9YI3yxkiH9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217175; c=relaxed/simple;
	bh=Bdm7XMarV5hcZutwPD5TQqGYRsLuv2zXIIHNtBHUaZY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Pi2vQW1V6ZnrlGHcPBTBhQdDr+s/hyZLtDJmvE8B8YQZR3mM8o7CCxFFx0MZg2sW8gOtfwj55zf7gAu+MxdPLg0nyaUWZOP+b9TvbaUpEao/LgH32Z5SlrOKERA9bKQfphawf1puQzR2DEQmBFBgG2G210WzuyYjs9XT+xAkMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y06RAfwB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uh3Jc85LNmceDWISw50X1RgyCBUftXUWnX+tDKSf1TM=; b=y06RAfwBaMv9b78xN4p4hQlPnJ
	QiG760lMCT3NNRNQmDxL/LwG6bBwCt4exs79FWWyyMdiwhRTDrkppdCNZIMpS0AdOvMO5TGEbFOic
	IIGKazThmqivJ2k1CM2ScJiukAXSRtcFOAAy0IN7y3aOzB/AE2OC5qX5zNzi0mxVAOvEueQESECkW
	QiadyZt2dRSxQhszbQdWzJr26IQi86gF5iDOhk8dLJgr7reqQQm802lkASJ3s9EEiQgTOJayHcuFE
	k1UWl3LlSxKq2J6Bk2lphXthaEuDXQrDIeyn4/EOFOqn6uil8aC0/6snqklio1F3MB0pofYC2VeQ6
	9dyQF+uQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33848 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbQ-000000001bZ-1umM;
	Thu, 18 Sep 2025 18:39:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbP-00000006mzi-2Xsh;
	Thu, 18 Sep 2025 18:39:27 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 07/20] net: dsa: mv88e6xxx: convert PTP
 ptp_enable() method to take chip
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbP-00000006mzi-2Xsh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:27 +0100

Wrap the ptp_ops->ptp_enable() method and convert it to take
struct mv88e6xxx_chip. This eases the transition to generic Marvell
PTP.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index ca62994f650a..7618f6db235e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -731,7 +731,7 @@ struct mv88e6xxx_avb_ops {
 
 struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
-	int (*ptp_enable)(struct ptp_clock_info *ptp,
+	int (*ptp_enable)(struct mv88e6xxx_chip *chip,
 			  struct ptp_clock_request *rq, int on);
 	int (*ptp_verify)(struct mv88e6xxx_chip *chip, unsigned int pin,
 			  enum ptp_pin_function func, unsigned int chan);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 87d7fe407862..43c4af82cb1c 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -306,6 +306,14 @@ static int mv88e6xxx_ptp_settime(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int mv88e6xxx_ptp_enable(struct ptp_clock_info *ptp,
+				struct ptp_clock_request *req, int enable)
+{
+	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
+
+	return chip->info->ops->ptp_ops->ptp_enable(chip, req, enable);
+}
+
 static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
 				enum ptp_pin_function func, unsigned int chan)
 {
@@ -360,11 +368,9 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 	return err;
 }
 
-static int mv88e6352_ptp_enable(struct ptp_clock_info *ptp,
+static int mv88e6352_ptp_enable(struct mv88e6xxx_chip *chip,
 				struct ptp_clock_request *rq, int on)
 {
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
 		return mv88e6352_ptp_enable_extts(chip, rq, on);
@@ -543,7 +549,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	chip->ptp_clock_info.adjtime	= mv88e6xxx_ptp_adjtime;
 	chip->ptp_clock_info.gettime64	= mv88e6xxx_ptp_gettime;
 	chip->ptp_clock_info.settime64	= mv88e6xxx_ptp_settime;
-	chip->ptp_clock_info.enable	= ptp_ops->ptp_enable;
+	chip->ptp_clock_info.enable	= mv88e6xxx_ptp_enable;
 	chip->ptp_clock_info.verify	= mv88e6xxx_ptp_verify;
 	chip->ptp_clock_info.do_aux_work = mv88e6xxx_hwtstamp_work;
 
-- 
2.47.3


