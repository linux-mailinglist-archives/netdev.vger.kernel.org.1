Return-Path: <netdev+bounces-223059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82328B57C58
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8F53B3957
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532530C37E;
	Mon, 15 Sep 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PYWH71s6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0693093CA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941601; cv=none; b=famq8HacMM/x90cE2/sOB7nHQOoxZugORWHG32RPPC8OCDkTzE8zgvtP2FZNoBWHG/0uSzzYnvKANCYY62BnQ8a+lPd1oya34bo0p4fcu1OACDWFoRJHfSS8zDLEL2XKOEEeRqxXAwqGgAZvUmKXUIfjNo1XbjR+4pWy6t+RX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941601; c=relaxed/simple;
	bh=ysBAxRahynGzMal8oG1PlMSzqfsVVoFbfcxh8GWnkwg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=d/n2/VmEJI0XiPutpWi6J7HpxJyHooHj/qU0CliKZfjn2TYCk+9NQ1fkpoNpfdWcD3uhixOBMfljmfCErbbC8q9k78/pF7OAQrA0Rrn+5svgmh+5ZQR9gUZA3XH9olFIh4v1iEWnYWuBh00+J8nbsw4bAosK9M+yoEjt7zg0FmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PYWH71s6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BqpmaQ2qVZmySiJrgyMhcUT5GZTDR+puU82pCa75Zfk=; b=PYWH71s64L6112tKM3+2BNa18C
	iH5LSWiiTJayd6oiyKt+YUcwDly73BZpCTEKztndIbY6byuQU+6Ivg8tbwffE9L414RQZ+23U0LJo
	6MHufWHvDTifjwSABcIScFFRS1o5ncmS4vdXBQkmMHyRv19RNi9a/FBg1T3NdeqsSanBigpyHB06H
	0ZTzhqK/wOJ+q3LCRtDBaD//nTokW+YtB3hYxpaJPz6utTMfW5Pa7ObsSwJvqZbk7H5qedA4zwrxX
	gVMZ/fRRNwgcoqpA0+lyVj049VL4PaXowyHtfMotvQX4qaiFoibvQyvwaf0BAL2MIouRg4s0WcyoC
	LeE9r7tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36728 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uy8ui-000000000EX-2rI9;
	Mon, 15 Sep 2025 14:06:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uy8uh-00000005cFT-40x8;
	Mon, 15 Sep 2025 14:06:35 +0100
In-Reply-To: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 15 Sep 2025 14:06:35 +0100

Since mv88e6xxx_hwtstamp_work() is defined in hwtstamp.c, its
prototype should be in hwtstamp.h, so move it there.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.h | 1 +
 drivers/net/dsa/mv88e6xxx/ptp.h      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index 22e4acc957f0..c359821d5a6e 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -124,6 +124,7 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 			  struct kernel_ethtool_ts_info *info);
 
+long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip);
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 3cf3bed82872..63ae2831065c 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -67,7 +67,6 @@
 
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
 
-long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
 
-- 
2.47.3


