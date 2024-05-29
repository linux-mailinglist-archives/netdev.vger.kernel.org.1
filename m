Return-Path: <netdev+bounces-99050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E58D38A1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D83B245C4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473EB1CAB0;
	Wed, 29 May 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k3+9+r+w"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70C1CABF;
	Wed, 29 May 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991519; cv=none; b=G4DymBSwVKjQZ+t8c0J+dpwv9uwCXGziED9aTiE1PB7gZrkhse4ZGdvPaPABJq7wzoW7hYpl5i6AEQv1vuxo1z4JBL4UwRP1wN3PYVSQTAWz1+v0AanUhSVkhCGC+kPFTFUikqcuAzsM+BMHREgPrWL45QVbNnNmONK0U7+ke3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991519; c=relaxed/simple;
	bh=8pdtjxaYvnJvGSTuNW0rIboHP2B6PxKFn2ipg5YnrGs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijX7NE3QPPAUR9JDpbN4yA7SQhn6YEPJx23Yjj1MTWqi+3cM1r1ZB2j0LblflJQWKMxC+M1mcHXBsmDfpU1bOIunVgDPLaWKmMrcQHyqj/pdyNkLGEAHo2j6LkJy4iVDrCnZBguYSZsSaAaI1N6HJEBlurW1WISWOwRb2LTMB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k3+9+r+w; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716991516; x=1748527516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8pdtjxaYvnJvGSTuNW0rIboHP2B6PxKFn2ipg5YnrGs=;
  b=k3+9+r+wLQz2GwvZ3gSlcOc1sa+jXA2IS6prBQ7MyOrm/1DSA6PhMdYg
   Se7kjvk4nZPV7etmYnN7qGrDQzD1OiC6cX09yWTxonyrWezq4DYQrWysx
   OTsjiH/QbzHK1IG2z0zJrpESvpnlioh3JGY06ARZIBSaojO7LiM8SegAh
   NfXo1SYWnX8sqIqr6VdODjPjzf6Gau2n7ZMJM8GaoAG7pjdhb3KIVWuDJ
   CQnbNn+MQSUQaPO4ocxGYJEUg+7kKUADbw374PFgo6ApM+M2PhlbAlzzy
   Gtk5g/U2QdPtuKushGeUFFLkjyZKWtJ35ShtBHbOdMh+//zyGByziSPP9
   Q==;
X-CSE-ConnectionGUID: Qz98x/EKR4io2vz4tc77eA==
X-CSE-MsgGUID: vSzJpDZKSqCYYXaTnc4krA==
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="26704201"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2024 07:05:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 May 2024 07:04:28 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 29 May 2024 07:04:25 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v3 0/2] lan78xx: Enable 125 MHz CLK and Auto Speed configuration for LAN7801 if NO EEPROM is detected
Date: Wed, 29 May 2024 19:32:54 +0530
Message-ID: <20240529140256.1849764-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds the support for 125 MHz clock, Auto speed and
auto duplex configuration for LAN7801 in the absence of EEPROM.

Rengarajan S (2):
  lan78xx: Enable 125 MHz CLK configuration for LAN7801 if NO EEPROM is
    detected
  lan78xx: Enable Auto Speed and Auto Duplex configuration for LAN7801
    if NO EEPROM is detected

v3
Resubmitting the patch. No changes.
v2
Split the patches into 125 MHz clock support and Auto speed config
support for LAN7801.
v1
Initial Commit.

 drivers/net/usb/lan78xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1


