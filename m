Return-Path: <netdev+bounces-145795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1619D0EDF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EC61F21E5D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AEB1946DF;
	Mon, 18 Nov 2024 10:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84E194A63;
	Mon, 18 Nov 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926874; cv=none; b=Xc1K92piOF3ZYxtCmH2r4M4l8v9SCqSJANPWro2kaX/6NQfnuGlfd5DdDWBqJF9am10yWPtbr8FJ4pWV5ZlXLS0hx8D4DIS+VVOR/RNJJFW+iGLLRLXO7aej7UCfs/dqXjFZI0/iJGOrYoFzno9vOQshkCFGs5mSo5kzOXLg/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926874; c=relaxed/simple;
	bh=BbzqMfy6aUfW9yswDEM1hlw0Fu0MrL6aZokYdECl4DY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZUP2mFQHaIi7+qQ+bs81HAxJlrirpxhUWwRFV+asIIlGyBZc5GojjJ98fmbjcG332GhJm4ogb/Oa9+HfM4ivizJHpDJsVrBNki7vrrT4Ui8a3YztUFpTSQaCsF4GC0+Mu6PJeLcsOtrSrdkGyfbpOvn5K1/gN7VqNqdLoYBFHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 18:47:35 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 18:47:35 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next 0/3] Add Aspeed G7 MDIO support
Date: Mon, 18 Nov 2024 18:47:32 +0800
Message-ID: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Aspeed 7th generation SoC features three MDIO controllers.
The design of AST2700 MDIO controller is the same as AST2600.

Jacky Chou (3):
  dt-bindings: net: add support for AST2700
  net: mdio: aspeed: Add support for AST2700
  net: mdio: aspeed: Add dummy read for fire control

 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml      | 4 +++-
 drivers/net/mdio/mdio-aspeed.c                            | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.25.1


