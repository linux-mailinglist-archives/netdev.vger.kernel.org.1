Return-Path: <netdev+bounces-16874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227874F2F6
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE041C209B8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC518B0C;
	Tue, 11 Jul 2023 15:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FE1428A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 15:08:30 +0000 (UTC)
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C421C10CF;
	Tue, 11 Jul 2023 08:08:28 -0700 (PDT)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
	by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 1CA64601EE01;
	Tue, 11 Jul 2023 18:08:27 +0300 (EEST)
Received: from yocto-vm.localdomain ([172.24.253.44]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	 Tue, 11 Jul 2023 18:08:26 +0300
From: =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= <vesa.jaaskelainen@vaisala.com>
To: 
Cc: vesa.jaaskelainen@vaisala.com,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] ARM: imx: imx6sx: Add support for TX clock controls
Date: Tue, 11 Jul 2023 18:08:03 +0300
Message-Id: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Jul 2023 15:08:26.0759 (UTC) FILETIME=[8B38A170:01D9B409]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add device tree configuration support whether Ethernet controller's
ENETx_TX_CLK output driver is enabled.

Also add device tree configuration support whether Ethernet controller's
ENETx_TX_CLK pin is used as reference clock for Ethernet. If not defined
then ref_enetpllx is used as reference clock.

If the new properties are not present then the existing behavior is
preserved.

Vesa Jääskeläinen (2):
  dt-bindings: net: fsl,fec: Add TX clock controls
  ARM: imx: imx6sx: Add support for TX clock controls

 .../devicetree/bindings/net/fsl,fec.yaml      | 15 +++++++++++
 arch/arm/mach-imx/mach-imx6sx.c               | 27 +++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.34.1


