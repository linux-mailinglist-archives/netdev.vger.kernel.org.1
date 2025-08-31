Return-Path: <netdev+bounces-218568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C68BB3D4A1
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 19:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2E83BAD0B
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D620272E5E;
	Sun, 31 Aug 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E/ihWJkl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60542170A37
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661679; cv=none; b=aOwlht4m3czEHBCGb0nccUH19qXj9dtOG3wUIvBUGUbFv32eg79ipUWO3HupswShA3xzPorm5mJArqlESCo2OQL1haqNnmRNZ8OjT7dPrylNDnAIuoNrHMYYhvMdAu8DtnyGTdfRrLTIGr8i/L3pmB9JEGjFFZtmuNVKPVzR8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661679; c=relaxed/simple;
	bh=dkmmNxUf9roy80IzSAFkK8fALbwaqgJVo/lAtQKHxfY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=n2h5o4WY6WQC5shL9TW2PVI32auacz/FbQFrcm1DHfrz8kTW8QxHlPFMzy1n79VHp41gDZszob41tyvfkuQiqoeQFYqmUG5cNgacyHFs+oZRy4s727HsWklxhErL2NFoq6145140+l9DfOCVdJixxLYr5TokgounjoOyjhyaf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E/ihWJkl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xto7HrSU84kXOvaeqlIchR8bdzoqlbM0saRfW0UcuKs=; b=E/ihWJkl1OHsDzs+vP0yx6DJwk
	3B55Dd9WuIQvrmp396n64nV3zyw6T7jg7UHByIXln/Tc6M6J4r0F+jX39ahGJTLmau5+ZmNCZYNpA
	r1Ap52aIZdoVvBfsV8fRMM2n4TcB4o9+gjCSJ+iyCj8+33kd4IWnm0N4JDHVUw3OPQsPQMVZedhKn
	9+nqV5TdQ38EwD5DQdI5Vx+SZ3jFehZxKZwGvqPQdmDBZNuXxhBAWtSpRlKMt8vNdXATCER75fjO9
	nB8rWm1dqlkzEu5PVrRixYmc7/nLfwT9DPRAyII4CR32M2rr0/VADuIUo1KB9n/QvaErVJysDGZfX
	vMjIA7mA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52972 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uslwn-00000000581-3w3D;
	Sun, 31 Aug 2025 18:34:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uslwn-00000001SOx-0a7H;
	Sun, 31 Aug 2025 18:34:33 +0100
In-Reply-To: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mathew McBride <matt@traverse.com.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 1/3] net: phy: add phy_interface_weight()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uslwn-00000001SOx-0a7H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 31 Aug 2025 18:34:33 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/phy.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4c2b8b6e7187..bb45787d8684 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -169,6 +169,11 @@ static inline bool phy_interface_empty(const unsigned long *intf)
 	return bitmap_empty(intf, PHY_INTERFACE_MODE_MAX);
 }
 
+static inline unsigned int phy_interface_weight(const unsigned long *intf)
+{
+	return bitmap_weight(intf, PHY_INTERFACE_MODE_MAX);
+}
+
 static inline void phy_interface_and(unsigned long *dst, const unsigned long *a,
 				     const unsigned long *b)
 {
-- 
2.47.2


