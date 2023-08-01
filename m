Return-Path: <netdev+bounces-23001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD8276A5F1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95C328176A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DA62D;
	Tue,  1 Aug 2023 01:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566C7E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 01:05:45 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD951E67;
	Mon, 31 Jul 2023 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690851944; x=1722387944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LugKS1Vo2+CJW/PSQHJ6vgOFbm+zdpKgIA3lwNdw6Rw=;
  b=T32jxPz4VwN83KPpPXy+Z81aj3fQsbGbOVZJlSUoLCQBS/7OrVcIm+tt
   jlRMbA5+nzfejSmdEbynUFLb/WTsxJZIL30HvyonXB/PJ2+/XSBqwM0m4
   gvonR9T376a6ORxf6M+FZIe9IT9UJJhtMcvxbCLPolgdrN7ocuvcM+lNz
   T6MxhsAEKGFa7NaeyjFXDgckqI5+cNploxooMzZI5wSb89ZRudi2XKK6V
   zpm079RTALgi+6XwaVSonpGorfnX+9gs+V/WbNQi/UlxKmf3U2WMIwubA
   TP5TTqtpVrgcedyD8kVDEkM1WJ9hDTOh2ZDW5AALDryJlAPVRNt4kZr8x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372787916"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372787916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818587406"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="818587406"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2023 18:03:50 -0700
From: niravkumar.l.rabara@intel.com
To: niravkumar.l.rabara@intel.com
Cc: adrian.ho.yin.ng@intel.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh+dt@kernel.org,
	sboyd@kernel.org,
	wen.ping.teh@intel.com
Subject: [PATCH v2 0/5] Add support for Agilex5 SoCFPGA platform
Date: Tue,  1 Aug 2023 09:02:29 +0800
Message-Id: <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

patch [1/5] - Introduced compatible string for Agilex5 board.
patch [2/5] - Add Agilex5 reset ID definitions.
patch [3/5] - Add Agilex5 clock manager header and yaml file.
patch [4/5] - Reused and modified Agilex clock manager driver for
Agilex5 to avoid code duplication. This patch depends on patch 4.
patch [5/5] - Add device tree files for Agilex5 platform. This patch
depends on patch 1,2,3 & 4.

patch v2 changes:-
- Add separate discription and const for Agilex5 board in yaml file.
- Add reset ID definitions required for Agilex5 and reused
  altr,rst-mgr-s10 bindings similar to Agilex.
- Instead of creating separate clock manager driver, re-use agilex clock
  manager driver and modified it for agilex5 changes to avoid code
  duplicate.
- Fixed device tree alignment issues and other build warnings.
  Removed ethernet nodes as it will be included in a separate patch.

Niravkumar L Rabara (5):
  dt-bindings: intel: Add Intel Agilex5 compatible
  dt-bindings: reset: add reset IDs for Agilex5
  dt-bindings: clock: add Intel Agilex5 clock manager
  clk: socfpga: agilex: add clock driver for the Agilex5
  arm64: dts: agilex5: add initial support for Intel Agilex5 SoCFPGA

 .../bindings/arm/intel,socfpga.yaml           |   5 +
 .../bindings/clock/intel,agilex5-clkmgr.yaml  |  41 ++
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 468 ++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  39 ++
 drivers/clk/socfpga/clk-agilex.c              | 433 +++++++++++++++-
 .../dt-bindings/clock/intel,agilex5-clkmgr.h  | 100 ++++
 include/dt-bindings/reset/altr,rst-mgr-s10.h  |   5 +-
 8 files changed, 1089 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
 create mode 100644 include/dt-bindings/clock/intel,agilex5-clkmgr.h

-- 
2.25.1


