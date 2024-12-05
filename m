Return-Path: <netdev+bounces-149407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8259E57FC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18A316B0E2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFFC219A91;
	Thu,  5 Dec 2024 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mGc7rduA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738B219A60;
	Thu,  5 Dec 2024 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406952; cv=none; b=APP6unFM7LARIOQRI7/NhI6GT9MAabE/6KnvzytUmtD2OVpUKgzwE+gcZEF0fFiJNcbc+psUlO+qF0cdUnerKuJXbYNZd93WDwu0hzbpt62CO0LPuBqm7RbRbBOSBF2Qq5D4i7vWJWB0/efp87JOu+DoKs3sRzh53uJvlohEux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406952; c=relaxed/simple;
	bh=lHxFLGKPoNfSvqzFkYKUGzmmcfUFjgD/RTXtN5+r7Ms=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=kp0ExE5oscZlfWQAz96OhTPGpF6n0OyVDCtAEPm93gsVbScM/3xLtIzC002fyO+RSTpj1aGQIjP6qMKcXL0QYJqV2O8MxVg9VnahhBNRtYuvL0IbA0kdRIV+e9y/QSqa4fkEbGxRNLcZwNfBqVvjOIWHTtv5J9TXqhOTVPo0IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mGc7rduA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733406951; x=1764942951;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=lHxFLGKPoNfSvqzFkYKUGzmmcfUFjgD/RTXtN5+r7Ms=;
  b=mGc7rduAFhWM2BPwca5Om5twzWGHkWlZAtRZnYtKeFri0/FAXrJU+/Ur
   k8LAhT0nZbrIt9rqMKFbG4oZ1rHSOIjky9zYqwV3hlPp7Hc7uIyBgr+Ia
   EH6kVw/tUAcEBcCLdToQTwzQl9EQJ1xNde9PdN43XWHHS+sveFpESTjbF
   5Dub3Ck6aWz0qTTPjtklcWUaBRPJSu5k6W4LCUcNCBraIr4A3/A6ZBiKG
   Y7kkAGeYzp/MhWKEvttQwoW/QJ1Rwt4z7zfXHhXPJO5kS0+BunKVPgkbG
   1KjP/FmeHqXKIq1Pja5rPzhZyG+qo2LCJWNKLLwBtU72ETjGVdqSJyF42
   g==;
X-CSE-ConnectionGUID: k5kzCLZDRxuQzU38z46vlQ==
X-CSE-MsgGUID: Gs8t/m1WSf+xfE5sWPdvDA==
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="266373257"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2024 06:55:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 5 Dec 2024 06:55:18 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 5 Dec 2024 06:55:15 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net 0/5] net: sparx5: misc fixes for sparx5 and lan969x
Date: Thu, 5 Dec 2024 14:54:23 +0100
Message-ID: <20241205-sparx5-lan969x-misc-fixes-v1-0-575ff3d0b022@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+wUWcC/x2M0QrCMAxFf2Xk2cA67Vj9FfEhrakLuDiaIYWxf
 7f6eM7l3B2Mi7DBtduh8EdM3trAnTpIM+mTUR6NYeiHixv6M9pKpXp8kYYxVFzEEmapbDiNIeY
 8Re/JQevXwv+h5TdQ3uDeZCRjjIU0zb/bhUThOL4ajy6uhwAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<arnd@arndb.de>, <jacob.e.keller@intel.com>,
	<Parthiban.Veerasooran@microchip.com>
CC: Calvin Owens <calvin@wbinvd.org>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

This series fixes various issues in the Sparx5 and lan969x drivers. Most
of the fixes are for new issues introduced by the recent series adding
lan969x switch support in the Sparx5 driver.

Most notable is patch 1/5 that moves the lan969x dir into the sparx5
dir, in order to address a cyclic dependency issue reported by depmod,
when installing modules. Details are in the commit descriptions.

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Richard Cochran <richardcochran@gmail.com>
To: Bjarni Jonasson <bjarni.jonasson@microchip.com>
To: jensemil.schulzostergaard@microchip.com
To: horatiu.vultur@microchip.com
To: arnd@arndb.de
To: jacob.e.keller@intel.com
To: Parthiban.Veerasooran@microchip.com
Cc: Calvin Owens <calvin@wbinvd.org>
Cc: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (5):
      net: lan969x: fix cyclic dependency reported by depmod
      net: lan969x: fix the use of spin_lock in PTP handler
      net: sparx5: fix FDMA performance issue
      net: sparx5: fix default value of monitor ports
      net: sparx5: fix the maximum frame length register

 MAINTAINERS                                               |  2 +-
 drivers/net/ethernet/microchip/Kconfig                    |  1 -
 drivers/net/ethernet/microchip/Makefile                   |  1 -
 drivers/net/ethernet/microchip/lan969x/Kconfig            |  5 -----
 drivers/net/ethernet/microchip/lan969x/Makefile           | 13 -------------
 drivers/net/ethernet/microchip/sparx5/Kconfig             |  6 ++++++
 drivers/net/ethernet/microchip/sparx5/Makefile            |  6 ++++++
 .../net/ethernet/microchip/{ => sparx5}/lan969x/lan969x.c |  9 ++-------
 .../net/ethernet/microchip/{ => sparx5}/lan969x/lan969x.h |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_calendar.c     |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_regs.c         |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_vcap_ag_api.c  |  0
 .../microchip/{ => sparx5}/lan969x/lan969x_vcap_impl.c    |  0
 drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c   |  2 --
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c       | 15 +++++++--------
 drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c     |  3 +--
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c       |  2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c        |  1 -
 18 files changed, 24 insertions(+), 42 deletions(-)
---
base-commit: da4fa00abe5674d3d165cfd8032c740e8aab4d3b
change-id: 20241203-sparx5-lan969x-misc-fixes-869bff8b55a1

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


