Return-Path: <netdev+bounces-96284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD28C4CFB
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BA528420E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785C3B794;
	Tue, 14 May 2024 07:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897283A1DB
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671551; cv=none; b=Mirx2WD4bxWjiuuuc/d7ESYoK4m0awdmzlUUvFystEsm3KMxVzTNSqYnjhnuBXH+3be7KjrckJA1fvruG8AChO4ZHM4+sRDpHjBAT11m2Ue7JLkzteU1yhm3NYdaEpGz7DAWyyPZK9UdzQ8pOlF9b9z7EJWegkYL1h2tVwbcJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671551; c=relaxed/simple;
	bh=z/BpDN4Inymh39fsZtZPhnwiphdEJQg1xa5NDQuWEgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RdHwtM0HK/gMi5APHbDdFCVDPYjLo6J3jPOZAUwSID/0XeHEwAPelBBMdvx57DhuEstg6wDj8HiqXDbqb2fVhmP+XUubwFPRci4t0zXWGzQ/Y/368sDo9vSQ5gJGOxw+4epE48y+K4UiacSJHalxPJtAeS1RGxmAgJDHp3xyoG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1715671416t20ad4
X-QQ-Originating-IP: Tuza4jrcTc//jWoEC+38qjgDbtGnxafA3CdSR76yrAQ=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 May 2024 15:23:33 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: oYmLx0sYfrUNE8bT59XrjiwdWCyleis7iyvFqu898gLznMDDdHTvOE0DYD9wk
	fQzFMTjux8G5VJ/XEbJ9yxgGlJrZMPFf6LT8X55IweIuieIw4Ak9kYHcXtuYFLL3cuHLH44
	ut6qrZJVJEnflFxOPr3MAqu92MZTz2DSPKOmseJZbFScBfi0cdpGkLzhleHBVG8uFlXrQRa
	VG2fiSOihLm/WyaMkPWCTkjTTAcQBOC407jMYxsm/XX6UfXoMlCmDd7mxtqfA89vRfqT7br
	UyztxeKuV14bsQvyBPkLgJL8TdVwK4rRLL5didgX0QdQEsrp0L74mUY6P5FydDMhIEtt7lX
	0T3npo4aiADay1bpbsIFvGQ+tCS5SXDl7wkSSHmr9c/0+YbOqkCiU9aHxXGCw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2749014110534123576
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v4 0/3] Wangxun fixes
Date: Tue, 14 May 2024 15:23:27 +0800
Message-Id: <20240514072330.14340-1-jiawenwu@trustnetic.com>
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
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 71 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 +++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 +++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 31 ++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 9 files changed, 152 insertions(+), 14 deletions(-)

-- 
2.27.0


