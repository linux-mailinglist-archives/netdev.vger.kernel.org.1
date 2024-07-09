Return-Path: <netdev+bounces-110289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121C92BC17
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C351C20C97
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8F18FDA8;
	Tue,  9 Jul 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DpOboHDL"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CB18FC70;
	Tue,  9 Jul 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533247; cv=none; b=rUukPTLgKyGEwqBpbDOROWwKB5mC1xyIvPcZiJ3xLu2GmbkWBzgudbrC9/vq0GXRv89eExfl0SUf6WxtgUulbKd3+z//WBs8cAmCZahIzrSesoG2eBN8kJ2jqHTY2Ao66xsxbhTf1oYmReGU7tDuwugzONBMCbfgZVXPoUlj/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533247; c=relaxed/simple;
	bh=IjMflVvqVRERvYARWe4LKlkVuXmMgcYCDaoitd2X9iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fw6/cmSMsIDHyj0O5QMsxW/e4hsazp81n/b2sBN0P6luoY9JY8hLeuT/5OtQpw6nHuAYqRAqL5gla6DvhB4CFONInT8qnZ+BevEqil64k7UeDpYpNASGprjMLEnSwfrA7CnMqGMVLc0Bp0FEUcTIMi9CD1/XDW+4BWk21ztloRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DpOboHDL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 776001BF20E;
	Tue,  9 Jul 2024 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720533243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrY8w0IMosIqtvCpNeKN+wcauJqxms1gGg8T+SvT1J8=;
	b=DpOboHDLDOzvnRWTS0dmCsFWYSkpEqZ2xX2ZTjQWAxTvXkzybY7GItjyiNr61bVr3XuD3x
	ccWM5KTxbN154Ghsm4ltEEKwqztxHfKl/Gdp9oQi5YNF924Vwrv/eRXBRU7JqbA+73EjO1
	8qx2Jl+l6/84RHD2NIDNsK1V+X9C9AV0teJv96o/imVtmOeukI2FWvKXwZYQ7JEJ+w3sJ/
	OFYpNUUFJjODVgt+h3drywAJWXcgGskH5Mi+ULkdyqwJfWoNP9ZUcRx78mhihut6Xn7v8m
	7hqp6oJwyH+nMas+mk63QrAHDXybcxxP5BFBM4nXkWeQdmYZrRYKxnFjGLeA4g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Jul 2024 15:53:37 +0200
Subject: [PATCH net-next v17 05/14] net: net_tstamp: Add unspec field to
 hwtstamp_source enumeration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-feature_ptp_netnext-v17-5-b5317f50df2a@bootlin.com>
References: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
In-Reply-To: <20240709-feature_ptp_netnext-v17-0-b5317f50df2a@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Prepare for future support of saving hwtstamp source in PTP xarray by
introducing HWTSTAMP_SOURCE_UNSPEC to hwtstamp_source enum, setting it
to 0 to match old behavior of no source defined.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/net_tstamp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 3799c79b6c83..662074b08c94 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -14,6 +14,7 @@
 					 SOF_TIMESTAMPING_RAW_HARDWARE)
 
 enum hwtstamp_source {
+	HWTSTAMP_SOURCE_UNSPEC,
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,
 };

-- 
2.34.1


