Return-Path: <netdev+bounces-179846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE9A7EBB6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E037A2228
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0873823F43C;
	Mon,  7 Apr 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="Db50McHs";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="Sv0CPmrH"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905F204C26;
	Mon,  7 Apr 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050331; cv=pass; b=XeMqlGkcH3tpwQ5O0ooXaYyhVmIBISRyYsV0i6LtmypgB/Hc05qgRu5grmbis3Hyf67Dgehmn82u8qE1DqNOXo8WM5i3LYecbUfDKcU29i1ZZydZReRzYyzJTDcmXShVqlJeQENeWUEz/Eh9MZ6dLU9nQv8jEFxBe2gLHmlBXBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050331; c=relaxed/simple;
	bh=+NErJk4Wk0ge51zG6dHyKkViDhCpcY/OkRt+ZIoa99A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lqdDQxnc5HACNsptRVOP5UoysascI8QrfNb4BOr0SZdNlISpxa2WdIqvvRHF6V19HWGsrNBVsMI0mJPjUNYUZakd2ofS7fw4GCf91yG7TSCeWieJ7Dkd99+YXHQ950TU3KlLcumV5hKoTv8oZL018cngWcn2oQ+KQErn0mqOETs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=Db50McHs; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=Sv0CPmrH; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744050140; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YzQxTpnyMwS/Iw1MedGg5BqL1D7lWDBVSSopWaS1Ceg2DgSyCj1XwT5Ip2O1QIfxvF
    TvI4wfHpYk1fILkcF798shNaPuD3GK+SSz+w69xItYWXwhuMwLLbGvDrtj2GJJMUThRi
    FGFrOzLxUWm44Ild6//ZSkPplKlkAYuvf9eL2CTT4Fyf6+78OM2BSjCoiIJxy1IPLhHe
    YURJ8//Ra5eUe/qnoRAN3Qt/3s3ENjTS8+eYUJdtDt58ma/q0TZpenGc2BSam4GiYrzD
    ohmlMEt3T/PuTP2vUxBSaE3t7OQadaZKWtTbCeSnUE8DvlFTgZp5JDct8Fpb767XS3yn
    W0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050140;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hvcqKD79mxQemevVPr1abj10ospJ66/oDOwSWypbLxY=;
    b=Tc41h2TyihMEg648avrZeIwUfu1SsSXFQRmHotfqjwrPGtxDGMUGFAG39ka7FD8Zzx
    9wq3KQLyp6aJG1WlAc35JSNwfviUQwyuxuq8um6PenLqbt5gWodIqsBmd/ZdN+42CHZ1
    k8rm9/Dk+24KVFUC5/x0d8hJChli9VbyqTzKpNfMMyzAQ08Uy6+lpxZHAZu1WgWDvHEm
    vk5KsAwEVMQCMsCeEuwdah2tTDmlbtpv32Cz8rqr0NdCZ2QJlNDL8pZl6EfphQSSNNWT
    nP+GzBTHr9/F2BOaxjV8qMrO2zlFhXgrCyXsbBzXR8LjDplKesIukXKW6vwBrzfBWC+e
    sVIg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050140;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hvcqKD79mxQemevVPr1abj10ospJ66/oDOwSWypbLxY=;
    b=Db50McHse3tYLD+He+G3eKmRMynHytNcZDjzjKhCJ+OsI7LVyKZdCTfU68jlBbJ8gs
    OeEtZ1FqvRFfo1PYcjX+SPUUmKSn494qscZD0xRz/X/EGH2llXYqdswZQAsZHDp8bfCB
    vTYypBFquY1VRsjbnq94Lk7EhJ4un4kdM/SCgP2c1mokcPHFyhAR9cBcH2sbU9aQNOk4
    ZrPvz6fd3u6gpSkHqY/HSkCF/80HQWYvS3HCIdilp9qDQQ4mkQJJSk0Vo0USFmcYcul8
    ekeoCUSRIO9+GCk/d4Gk8YflSCl/4JXhD127JqEVIoKSSQ2iLLYcWRPE9c0FL3L7MpJn
    5meg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744050140;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hvcqKD79mxQemevVPr1abj10ospJ66/oDOwSWypbLxY=;
    b=Sv0CPmrHAjjUJ56//7AeJc+23O5S3n6mu7S9ciUzafpxRePbxqp5ZachWg0Q3BgLlZ
    32OvnBqofnl1DfNGa3Dw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35137IMKyOn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Apr 2025 20:22:20 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u1r6x-0003xY-05;
	Mon, 07 Apr 2025 20:22:19 +0200
Received: (nullmailer pid 15018 invoked by uid 502);
	Mon, 07 Apr 2025 18:22:18 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND net-next v5 0/4] net: phy: realtek: Add support for PHY  LEDs on
Date: Mon,  7 Apr 2025 20:21:39 +0200
Message-Id: <20250407182155.14925-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Re-sending the patch after merge window.

Changes in V5:
- Split cleanup patch and improve code formatting

Changes in V4:
- Change (!ret) to (ret == 0)
- Replace set_bit() by __set_bit()

Changes in V3:
- move definition of rtl8211e_read_ext_page() to patch 2
- Wrap overlong lines

Changes in V2:
- Designate to net-next
- Add ExtPage access cleanup patch as suggested by Andrew Lunn

Michael Klein (4):
  net: phy: realtek: Group RTL82* macro definitions
  net: phy: realtek: Clean up RTL8211E ExtPage access
  net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
  net: phy: realtek: Add support for PHY LEDs on RTL8211E

 drivers/net/phy/realtek/realtek_main.c | 201 ++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 41 deletions(-)

-- 
2.39.5

