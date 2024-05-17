Return-Path: <netdev+bounces-96860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255638C8110
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99621B21740
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953FC15AE0;
	Fri, 17 May 2024 06:53:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E514F68
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715928824; cv=none; b=N6yXaNGuceWEvzcAFgQ55dXdvYxXSkp4dsjXtaZmk5tfxsWtErvxOe3Br6rLWAuLLGeL8S7ku69uSbjYH07FTaAFbzw5hCssYpQVjR0dI2jj38MoWTPkoUK5hFVWV5O7KjniX4n8AYBYB49utcdx5tW+K2vzi7bz2GmVIbSIWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715928824; c=relaxed/simple;
	bh=e4AmGURiQoCdUvm4XoaEtHNi7FGGv8jjqtBkwypm5Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5kTmChbtiIsP5/e1q5Xi2Om0iD+AGBWfKEXGNhMWs7Jj+JYXmx5ydzuBSMkosdni3M3BpNqgeRu47Kn3GCIh63BvFbwvFuAddUbCEzdyword8sr+BHldP4XJT0BS/yx/HlgtgODFGQRaTzhqDapCnK4cbiO4Bke1d/IY7DP7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz11t1715928715tbvjgs
X-QQ-Originating-IP: PcrTEei+AZKYxJa24+gwggZjHmm6ram1O7yKIBv509o=
Received: from lap-jiawenwu.trustnetic.com ( [115.206.162.36])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 May 2024 14:51:52 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: znfcQSa1hKZOgrmWv5OIupl17g0g6LKJ+pJEnN0zbpC34zbEExcO1qJtH/6Pr
	Z0lQbnXrt42kXAfT2rQrQZ91RssXFCNtRRiyuL4oAchKYMW5kY2wLrU1N1elb4hxf2pYpw8
	qgziGjOlAy2vZ5gkyHmIHbkzadzuwailVsF9hLBYJNrsOHr+wYMOs1DG8Xk81KKCTu0pwYS
	mC4MuPTXwUpTlb/vU4XgvBYPNHwrf09o9961ChxymHP5m5hey+/NPdBg7Mo5oPYZIHquM7X
	ln1YPZusLT4+FIsTJDWJcaO9DTLS1sM7xx3uDBduXnxTxyfcTl7YhYe1qFK4hmIzBqbj0qY
	8T/kR3niwWwa6mpigNl95fFjVPD79s2HGiv04RzwYbGhcAulYC2vKW9zDHq4KAXAKOqodTr
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3430255678895096728
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
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v5 0/3] Wangxun fixes
Date: Fri, 17 May 2024 14:51:37 +0800
Message-Id: <20240517065140.7148-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Fixed some bugs when using ethtool to operate network devices.

v4 -> v5:
- Simplify if...else... to fix features.

v3 -> v4:
- Require both ctag and stag to be enabled or disabled.

v2 -> v3:
- Drop the first patch.

v1 -> v2:
- Factor out the same code.
- Remove statistics printing with more than 64 queues.
- Detail the commit logs to describe issues.
- Remove reset flag check in wx_update_stats().
- Change to set VLAN CTAG and STAG to be consistent.

Jiawen Wu (3):
  net: wangxun: fix to change Rx features
  net: wangxun: match VLAN CTAG and STAG features
  net: txgbe: fix to control VLAN strip

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 56 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 ++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 ++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 31 ++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 9 files changed, 137 insertions(+), 14 deletions(-)

-- 
2.27.0


