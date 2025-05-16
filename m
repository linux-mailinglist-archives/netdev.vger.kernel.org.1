Return-Path: <netdev+bounces-190972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0486AB98F0
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45D217F65F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC0230BFF;
	Fri, 16 May 2025 09:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE88227B94
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388055; cv=none; b=a6xDO7PzRXcgB3A4wVl6/Wgo7aYL3QZUs1JBrIKvL4JbT8iv/hZIc+x8mbZr5JQbljbz68bYfhyINuyjc9oldc6FmRCz4tRI3b4QxWafZTur739M86fwwLCmFI7B0EhhmDQ7PGLk+EU1ZfJ/9pS0s9LyU8x8ccEI/BgFj4NPSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388055; c=relaxed/simple;
	bh=UsCVnBo0eQufHoVHOfeu8WmFOesnBq+wgoNdGzh/cs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdeU7yhgjYlXTbks0XAWLQiNFlzxkSQu96RIrxa0mp6pEKWoL64AZOf6E63V7hcaIDYX6MXE7vCqTfW3uB4ICIVFbW7MyYek663A4lxqC4Q+io0WfREjXH2mlyInFRYO7WAMvFzxYzvXkL4sUMxrSbD93zShCOGn1siv+78CZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387957tedeb4c4f
X-QQ-Originating-IP: VsLLIB0xCAMv9iZBwPKNOmP24LXW7+2kKrSN/FvX6dY=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:27 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13065548487009362881
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/9] Add functions for TXGBE AML devices
Date: Fri, 16 May 2025 17:32:11 +0800
Message-ID: <44F90801FAEFB3E4+20250516093220.6044-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NcEwhrcyhX+Ezv4BkdEM3jEXZvqNHAvpL5QSpb1YHy2AdhhU/61JjKRR
	HT4SG/NvfVrxXpGTbGAWVRE8ib57Wv3rp7GG0fg8xYH9BKifUGlQWvFDM7xnF3bmG79F6pH
	RshbUUX2WGT95hL4ic+sAXsv8/dHnWngaxvlf+6cSmjjRXjTJilKClNhp/ZGtrR49NWs21r
	3f36eEdT/YecFv9aJ1oO/Ncfv3Ef5+iuLi9/gGdRWhDR54Go+d53/Btqsjw00J5HkrjnBVB
	xJZztDNN+8pfTPn0ExbBuhNFZeTKHFX5wqStpB1iG4Fj8idzA+D8GtdeIneYms2pt9HvFpg
	q55eNeEGRfOdN2AomVOU/Ws3aE8gEmTw7XQ0pz1XHakQLps+L4vYWDvKAAPO7O/yF73n1On
	EQ6+gPlAXoSvBrwfnIOIgQD6O0JDla2kQy+Y3K4wqioJ4eaYXDHwYUKKfUHKkEjH0uWfCMn
	RArKMDCbtwomhD706eGqOOznn3b6lDGwAX0VvxJKfKYNEakOT9L5YsC3fqQfIgcBdS4/y9a
	tBxyelnRN6lFIiKbAziU88xuSESQ6LxX0qAvL6v9OZs9jEmV5V3tng2yucfFM3VWstKq3H4
	snSkwGz3ynjzogu9jCelfzjbrh73pY7GyPcNQIpiawnxf/hybxBBuxT62G43AmrSK0m69gF
	hHhqbFg4UA4QSM3cr8gVkIQL5FlfVZw0tmgchiopuO0sJEzMRK6CQ/mAFeT2/qcMQgDrAxq
	ojQlLszDAiuKwwQUzrBVkVIu21qtQgHi1qsAeAQ926Ethk8cJVxKRvZYU/OaxqB0LBZtZcV
	wRjv6O9lvA2LiNBvbdlVyEWZFK/+cuL3rQkiYdzx0I8e8gecVAkRbgX/oeLbY7AA3At9wTi
	ssXl4VXtzcbMsg9nwMur5XYK65OQjUbTFtlPT2xsPBzHutREj/BJpfVr3ihC6WqvkaivPtA
	CvyXdCubmIBCKzccI783WtmcFgyAbOgLrmNNgSSuG9JGiMeANA6ytRUdxPejgzX/BGzH82v
	ncJR2be+5Fv9mLHqvUsn6jSGgGdPTm1WfMSHUhiL+ogvzGnQVNZ2nP75h4VleIE5gMT1qn0
	+ifK7tax48QOJdZNTxp6PcFCouT8Ypa0w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Support phylink and link/gpio irqs for AML 25G/10G devices, and complete
PTP and SRIOV.

Jiawen Wu (9):
  net: txgbe: Remove specified SP type
  net: wangxun: Use specific flag bit to simplify the code
  net: txgbe: Distinguish between 40G and 25G devices
  net: txgbe: Implement PHYLINK for AML 25G/10G devices
  net: txgbe: Support to handle GPIO IRQs for AML devices
  net: txgbe: Correct the currect link settings
  net: txgbe: Restrict the use of mismatched FW versions
  net: txgbe: Implement PTP for AML devices
  net: txgbe: Implement SRIOV for AML devices

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  22 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  48 +--
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  43 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  30 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |   8 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  22 +-
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 385 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  15 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  27 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.h    |   2 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   4 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  44 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 140 ++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  41 +-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 106 ++++-
 18 files changed, 831 insertions(+), 113 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h

-- 
2.48.1


