Return-Path: <netdev+bounces-45019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13F7DA8B4
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F5D1C20AC6
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031B182A7;
	Sat, 28 Oct 2023 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V+VT+SLk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF815AEF
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 18:45:22 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86645F2
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=cmzETfobzUjmYzF3aqde9Z8fVR3+bbeXiY1JjPjV6Jc=; b=V+VT+SLkpdJmS/AJ6dM8BCQ9yK
	7e/6M/mLLbqLOOidUmY33tRNv0jeReRei7vuDH9WcLuOwTfOZfayuaVmtqtSoAKMLNMhYwwJGDeay
	ulXsB99GyJkz7xbD7El3JApRFSuYW/TP7f/QBCsZ+ukuaSltMUc77lK9MLDi+QcR7Bu0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwoJ8-000PsD-Nx; Sat, 28 Oct 2023 20:45:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v1 net-next 0/2] Add missing MODULE_DESCRIPTIONS
Date: Sat, 28 Oct 2023 20:44:56 +0200
Message-Id: <20231028184458.99448-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixup PHY and MDIO drivers which are missing MODULE_DESCRIPTION.

Andrew Lunn (2):
  net: phy: fill in missing MODULE_DESCRIPTION()s
  net: mdio: fill in missing MODULE_DESCRIPTION()s

 drivers/net/mdio/acpi_mdio.c    | 1 +
 drivers/net/mdio/fwnode_mdio.c  | 1 +
 drivers/net/mdio/mdio-aspeed.c  | 1 +
 drivers/net/mdio/mdio-bitbang.c | 1 +
 drivers/net/mdio/of_mdio.c      | 1 +
 drivers/net/phy/bcm-phy-ptp.c   | 1 +
 drivers/net/phy/bcm87xx.c       | 1 +
 drivers/net/phy/phylink.c       | 1 +
 drivers/net/phy/sfp.c           | 1 +
 9 files changed, 9 insertions(+)

-- 
2.42.0


