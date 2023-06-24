Return-Path: <netdev+bounces-13740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E713A73CCB7
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6278280FF4
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C05A953;
	Sat, 24 Jun 2023 20:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA99470
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 20:56:51 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB9E79
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=Hromm+8/Bd2JrSVGoZjapRwdjy4ZGIB2fS5+FF+t5AM=; b=UJxAINwXr9yNl3jdkqYO3HnUSg
	+3aD+lmoAmLefSWFHqh74U5uDSJXCc8xlhQZ1pysWIj8ZJQh2bipaAEWZy74P2iWc9wh8MBNep4iA
	7OopgrL/HUvPT8A9Bt2CYNJQK891btlFLr+5ySBZ0+WsN0hRPo1H4gzdWBVdxOaazthM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qDAJG-00HRkC-2M; Sat, 24 Jun 2023 22:56:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 net-next 0/3] Support offload LED blinking to PHY.
Date: Sat, 24 Jun 2023 22:56:26 +0200
Message-Id: <20230624205629.4158216-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Allow offloading of the LED trigger netdev to PHY drivers and
implement it for the Marvell PHY driver. Additionally, correct the
handling of when the initial state of the LED cannot be represented by
the trigger, and so an error is returned.

Since v1:

Add true kerneldoc for the new entries in struct phy_driver
Add received Reviewed-by: tags

Since v0:

Make comments in struct phy_driver look more like kerneldoc
Add cover letter

Andrew Lunn (3):
  led: trig: netdev: Fix requesting offload device
  net: phy: phy_device: Call into the PHY driver to set LED offload
  net: phy: marvell: Add support for offloading LED blinking

 drivers/leds/trigger/ledtrig-netdev.c |   8 +-
 drivers/net/phy/marvell.c             | 243 ++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c          |  68 +++++++
 include/linux/phy.h                   |  33 ++++
 4 files changed, 349 insertions(+), 3 deletions(-)

-- 
2.40.1


