Return-Path: <netdev+bounces-140354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E39B627C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5456B1C22021
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A91E5000;
	Wed, 30 Oct 2024 12:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3DB1E6DC2
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289806; cv=none; b=EnQzyKkgBLAhSUBR0pn7ghM7ncN1AizSeOytUmO2MFFzQZWeztBqiFZ0ccp8aStMKam9SYT61OpXVLhqB2/YPV0PqG/Q00zSiNVVV7MrGhTJgY7HU6lAMSFCy/+Dz0AWQl9Co67z2CxwQPiJSALBH57rX1+TDZzYqlR4LUNpGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289806; c=relaxed/simple;
	bh=JY2oCrHIfhPJlZMIwcdNkVKSXrp1Y2lDTuMSPbRIb/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MWLXxScqOXUkr6XhkXqAiaS0aSEQ5nVdEM4L25a36pn48o4GGtqSNz8F+lOY+XgQNam/MDvurq1yeHyz7ubLOTPFiBKXEBqW0gI08mJkvc6lgiS2eyxrhy1fSD/FUWWJ2Yc8HueA3bOHqgpXq9bhN0JQhx9xPOhTiH38JcOKepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1t67Pu-0005ni-4E; Wed, 30 Oct 2024 13:03:14 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 0/2] clk: socfpga: add clock driver for Agilex5
Date: Wed, 30 Oct 2024 13:02:58 +0100
Message-Id: <20241030-v6-12-topic-socfpga-agilex5-clk-v1-0-e29e57980398@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHIgImcC/x3NTQqDMBBA4avIrDuQxJ9qryJdJNMxDhUTEgmCe
 PeGLr/NexdkTsIZXs0FiYtkCXuFfjRAq909o3yqwSjTadUqLANqg0eIQpgDLdFbtF42Pnuk7Yt
 Px7ZraXST66FWYuJFzv9hft/3DyzwQ+RxAAAA
X-Change-ID: 20241030-v6-12-topic-socfpga-agilex5-clk-7bea43c8b9b5
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, netdev@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Teh Wen Ping <wen.ping.teh@intel.com>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The Agilex5 clock tree is compatible to the existing s10 drivers.
Therefore the pll,gate and periph drivers can be reused and only the
main clock tree is added.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Teh Wen Ping (2):
      dt-bindings: clk: agilex5: Add Agilex5 clock bindings
      clk: socfpga: Add clock driver for Agilex5

 drivers/clk/socfpga/Kconfig               |   4 +-
 drivers/clk/socfpga/Makefile              |   2 +-
 drivers/clk/socfpga/clk-agilex5.c         | 847 ++++++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-pll-s10.c         |  48 ++
 drivers/clk/socfpga/stratix10-clk.h       |   2 +
 include/dt-bindings/clock/agilex5-clock.h | 100 ++++
 6 files changed, 1000 insertions(+), 3 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241030-v6-12-topic-socfpga-agilex5-clk-7bea43c8b9b5

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


