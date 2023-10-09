Return-Path: <netdev+bounces-39343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DAA7BEE4A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD5C2819D9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE33450DB;
	Mon,  9 Oct 2023 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDV467JY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0B45F46
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:29:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4B9E;
	Mon,  9 Oct 2023 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696890569; x=1728426569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRpEHHx345nS6YYwo+ZTnWtYWBfcifiu4bdKvhxp9Cc=;
  b=HDV467JYXPF8PcWV3VEQB2BnZPJBsDw8zI0gwNr6Ucm8zd9wpsNQrP3X
   wIj9MBxFTNexGbGmHemMy0mdWeZ2mgq4zFNehIf8sHYLwgqcUKQL+ijm+
   i23bX4Y4Afw6oa/SShp65ju1hrZTZwhtAn9XiGGOaYcMD1BLd6UR2hUfo
   J2zj9FoY8EDxK525VwIThBph7517bkD3wwG3Us4Cl1W/jfWiel/qISsU+
   3GEJ6/Gh5mZrpj04mEkcpFJKcDPmINAK0u6jZpP8GqiepwmP5ij1SUknc
   llejtYLW3F+2GxGOjgGZnNsak7G4FJiq9GU3WJGh0+PaMnks+HHRU5x28
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2849388"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="2849388"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="843876578"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="843876578"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2023 15:28:50 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v4 1/5] dpll: docs: add support for pin signal phase offset/adjust
Date: Tue, 10 Oct 2023 00:26:12 +0200
Message-Id: <20231009222616.12163-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add documentation on:
- measurement of phase of signal between pin and dpll
- adjustment of pin signal phase

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 Documentation/driver-api/dpll.rst | 53 ++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 69670deb8c4e..e3d593841aa7 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -173,6 +173,47 @@ in order to configure active input of a MUX-type pin, the user needs to
 request desired pin state of the child pin on the parent pin,
 as described in the ``MUX-type pins`` chapter.
 
+Phase offset measurement and adjustment
+========================================
+
+Device may provide ability to measure a phase difference between signals
+on a pin and its parent dpll device. If pin-dpll phase offset measurement
+is supported, it shall be provided with ``DPLL_A_PIN_PHASE_OFFSET``
+attribute for each parent dpll device.
+
+Device may also provide ability to adjust a signal phase on a pin.
+If pin phase adjustment is supported, minimal and maximal values that pin
+handle shall be provide to the user on ``DPLL_CMD_PIN_GET`` respond
+with ``DPLL_A_PIN_PHASE_ADJUST_MIN`` and ``DPLL_A_PIN_PHASE_ADJUST_MAX``
+attributes. Configured phase adjust value is provided with
+``DPLL_A_PIN_PHASE_ADJUST`` attribute of a pin, and value change can be
+requested with the same attribute with ``DPLL_CMD_PIN_SET`` command.
+
+  =============================== ======================================
+  ``DPLL_A_PIN_ID``               configured pin id
+  ``DPLL_A_PIN_PHASE_ADJUST_MIN`` attr minimum value of phase adjustment
+  ``DPLL_A_PIN_PHASE_ADJUST_MAX`` attr maximum value of phase adjustment
+  ``DPLL_A_PIN_PHASE_ADJUST``     attr configured value of phase
+                                  adjustment on parent dpll device
+  ``DPLL_A_PIN_PARENT_DEVICE``    nested attribute for requesting
+                                  configuration on given parent dpll
+                                  device
+    ``DPLL_A_PIN_PARENT_ID``      parent dpll device id
+    ``DPLL_A_PIN_PHASE_OFFSET``   attr measured phase difference
+                                  between a pin and parent dpll device
+  =============================== ======================================
+
+All phase related values are provided in pico seconds, which represents
+time difference between signals phase. The negative value means that
+phase of signal on pin is earlier in time than dpll's signal. Positive
+value means that phase of signal on pin is later in time than signal of
+a dpll.
+
+Phase adjust (also min and max) values are integers, but measured phase
+offset values are fractional with 3-digit decimal places and shell be
+divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
+modulo divided to get fractional part.
+
 Configuration commands group
 ============================
 
@@ -263,6 +304,12 @@ according to attribute purpose.
                                        frequencies
       ``DPLL_A_PIN_ANY_FREQUENCY_MIN`` attr minimum value of frequency
       ``DPLL_A_PIN_ANY_FREQUENCY_MAX`` attr maximum value of frequency
+    ``DPLL_A_PIN_PHASE_ADJUST_MIN``    attr minimum value of phase
+                                       adjustment
+    ``DPLL_A_PIN_PHASE_ADJUST_MAX``    attr maximum value of phase
+                                       adjustment
+    ``DPLL_A_PIN_PHASE_ADJUST``        attr configured value of phase
+                                       adjustment on parent device
     ``DPLL_A_PIN_PARENT_DEVICE``       nested attr for each parent device
                                        the pin is connected with
       ``DPLL_A_PIN_PARENT_ID``         attr parent dpll device id
@@ -270,8 +317,10 @@ according to attribute purpose.
                                        dpll device
       ``DPLL_A_PIN_STATE``             attr state of pin on the parent
                                        dpll device
-     ``DPLL_A_PIN_DIRECTION``          attr direction of a pin on the
+      ``DPLL_A_PIN_DIRECTION``         attr direction of a pin on the
                                        parent dpll device
+      ``DPLL_A_PIN_PHASE_OFFSET``      attr measured phase difference
+                                       between a pin and parent dpll
     ``DPLL_A_PIN_PARENT_PIN``          nested attr for each parent pin
                                        the pin is connected with
       ``DPLL_A_PIN_PARENT_ID``         attr parent pin id
@@ -284,6 +333,8 @@ according to attribute purpose.
   ``DPLL_CMD_PIN_SET``                 command to set pins configuration
     ``DPLL_A_PIN_ID``                  attr unique a pin ID
     ``DPLL_A_PIN_FREQUENCY``           attr requested frequency of a pin
+    ``DPLL_A_PIN_PHASE_ADJUST``        attr requested value of phase
+                                       adjustment on parent device
     ``DPLL_A_PIN_PARENT_DEVICE``       nested attr for each parent dpll
                                        device configuration request
       ``DPLL_A_PIN_PARENT_ID``         attr parent dpll device id
-- 
2.38.1


