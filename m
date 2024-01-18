Return-Path: <netdev+bounces-64126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1A831348
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 08:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B511C22892
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0ABE47;
	Thu, 18 Jan 2024 07:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E931C154
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563763; cv=none; b=SWGDmrkf8u6Ah1pU5GW1y0w0hld/kS2oPAHuLl+kYZUDdu/es+/TY8wkhOX03Sc8NIkrObnHsaBb9teGClFW0ozjLg64rZ2TtMl8AzuWT7OjpkBM/OqZzp70Z9SJ3AjoHZTkg3VPgybkxMpZo7iNdmU3JU4XUlo/SQ91NDOi+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563763; c=relaxed/simple;
	bh=MyQKfL7ETEQmZGAZ6gejvOeNF0ILgotrtzkGe37xYLg=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID; b=K4lqhYYxKFnjbtQ/C9HnWiKvI9qk/F9/X7Alu7pAV78CMG2Hqd8Jr6DSZl7d+MPHyE6hdPdzom+MwJC2VFxLmdS87TvBcff6rR7lOoeHakzcZEexwgPw68wPNLn8pBIMQjBvU4PMvR9RqYLUSCJWc3tVXmj63tU+0mly7fG2uYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp76t1705563637tmbi6dbe
X-QQ-Originating-IP: +4oOSZkMJmj+rEJ5sV8GpRXjOaagVp4X/bm1tH2El+s=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.144.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 15:40:35 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: Ez/E6GbqAwLNtlU914Lt4Ry94tyOsOoJ6VpahzeUV3X+Q6l1XlxWomBqNyTGU
	xmiyim2c867CVFEtZX4pTAFDL/DkUiXl4uFaXF+mRBbTdKftU8FgPvr4rmOZmzgzaXvgmQU
	X1I5iA7+d3IvU+gfCdyvWBTwXv/iVAgJQftCtZ2GSZkA9eTAGszkGUAzD03TKlyLRIiEb+0
	tptaBNIR5xUyM1JB+FtVXJ8+caO52sdueEzKCpX6BaNkmYe8TEoiLGU/mTLfqp4J5YW8kfT
	qcQ2axvvkAdkTlPoIvP2oWPIu58O77A3p29iUwhHEx2JW95gz+HudsE+ByZCYA/AxieMroc
	BbZYl5tcnCT1HFbgJVJG3ue8OA75v0xuk4Mm1R5D+JZPzqK6/gStUAo1BbQNQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16904444299948585669
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RFC PATCH net-next v2 0/2] Implement irq_domain for TXGBE
Date: Thu, 18 Jan 2024 15:40:27 +0800
Message-Id: <20240118074029.23564-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Implement irq_domain for the MAC interrupt and handle the sub-irqs.

v1 -> v2:
- move interrupt codes to txgbe_irq.c
- add txgbe-link-irq to msic irq domain
- remove functions that are not needed

Jiawen Wu (2):
  net: txgbe: move interrupt codes to a separate file
  net: txgbe: use irq_domain for interrupt controller

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   2 -
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 -
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 269 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 140 +--------
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  59 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  11 +
 10 files changed, 331 insertions(+), 181 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h

-- 
2.27.0


