Return-Path: <netdev+bounces-192178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BEBABEC6A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815D84E2827
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459223FC5F;
	Wed, 21 May 2025 06:46:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BB23E35D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809979; cv=none; b=BApLUpdJnMrCQpyJBOFKnZhw9oPSZjnSYlsMHJYFgp/Vu1m0WSrntYj/GLxBFC7K9JW8Ckx0aHdVSQjf9IN1i6YBoxPtayxHRCTquljKGbaat0s+OByp9WnNREnG+4cAmQ8EXfcyccGtAQh68zkj9T3ah1HjlYvUGiLKunvlvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809979; c=relaxed/simple;
	bh=8DcuykMIp9cW0qiDf0pZittAl3YjFudclTb9TkESuZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vArGjSccSFQRgMBNetTuOgmpnZPJctSiFomjXUsgO2jehOLTQYG5WVdE4g+u9VYHycLbUIDc414cBeW3aA4WFz70pLtcjXmxPSvuX0VCfqUWbuKk59APeC1tAzrvBEoIhWcRHWdKUOcEcuRST7xWmtmZIQKaiLgp72A4776Z59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809862ta23a53d6
X-QQ-Originating-IP: USz2GmSYpPeGhYwvT3Dxlgwqx9+AjjM++fxtKs6g1Fs=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 337926046623095735
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/9] Add functions for TXGBE AML devices
Date: Wed, 21 May 2025 14:43:53 +0800
Message-ID: <197AF462EC58E2B0+20250521064402.22348-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ob+TdET2B71eUSWGDm6LCWGVKvY+vIcFUAhV16hCX8m9Xq1aN/z9uOc5
	EywwxIlDku1ujs04rbLNWnSgANgTscMQUCjgjKITR0Je4Yu2pGHVO195/UBxrK5wHT7Ra6l
	x4BgVaQTlRBUlUyv9Gl3+4KAFzhfKRYkpkfxU7LsAPKdm95Hp9mZrpvCjnovdjRx9WwQ+/6
	Y9azDQSUdQlPPYAeta0ECvLgKsMMYBySKlxNVOHTbXRc4cJhphBn2fWe4RXEoV5PjhraGXE
	hzPA6QerSZH8SR2CePyyTqE2dMA0FxYN8pp6gsFxLF+S+DnJ/txhpsutBJ4wFU1pTVqhdjy
	bCwPKDTXoMLJeDSZU/yKT4nMzbNnbLdOwzqDy6XGYSnM9ZH9GI28F7lE2SmfoFEdDFdP9oB
	UV/BnsyQtixgFp541Tz9XPQplN6y05oQc6CA1DTce8iaNhi2YXSfFydqsBnhis+w5DV2CZ/
	MkbLaeK5nHrLgvHci5tC5oXswhrooYVUZgO/zTiZ3l36Xv97Tov/B2lbe2prnNuSgY0IN2Y
	Ct0Twi8qgW6SlRDm8kgjqK3PlApVaomZSKXkwWkZZwPNVY9SVK/ytGkai8j0MHFuDqjPwWq
	rVw7IpWz4jPwEVxVdvW2HdnV+N1OEmpz+chTSriuLUtA/xFMXqCfd2c4B2tH6ikVq50Y8ai
	tXr74it87pcVmhDlPegFitccMPxFRq3FbDkMz+vUA8NZ7x9u0XnSn3WmP7x/6+B0Llmv1Hu
	kHMV+sfuEdN2xnlWAqI34/EABXtPd/KzjCqfmNDzy1wpYRNV8HZSm9x0vP3Ez/12QmKNsBQ
	AkG9ju0EG2Ve9mxf696Gwu4zpMfZ7X0UQ1OJxMAlV8LgnMSu4GXvI/rsTjYH2OYJWOWrw+Q
	FHMr/4CpVRJhwt2Aem7aC/cSzzXNKk1YX6iiddDRQrxD8UVjqgDIc5zkil3IOfoHq5YJ9zZ
	gbTI3uYIWgchFhITQ0BpphCT4zFviptFMkEPpQczzECVVWnoUJRS4EuXwl4dkYBbFB2q1RA
	uGXrlSmkT9XZjhbPQsi1vwA7DTN1A=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

For the chip design, AML 25G/10G devices use the new PHY/PCS differs
from SP devices. And the PHY/PCS configuration is all left to the
firmware. Add the new link flow for these devices, and complete PTP and
SR-IOV.

v1 -> v2:
- Detail the commit logs

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


