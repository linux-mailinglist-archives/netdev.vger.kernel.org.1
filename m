Return-Path: <netdev+bounces-88190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96828A63C5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1120E1C21C82
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1126CDD0;
	Tue, 16 Apr 2024 06:32:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D41E49D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249136; cv=none; b=Sle4DbfBz+CkM6yUazEKk52zbaVtk9pYGumrlzyJ1IsnsNNrYfVQUth9oCatoguyEu9BVcjh0OiMhbKZIdL4YyHNqY65QthQ6GQYmLethf1KWtGiOiziB/nckYY2tX6/cPWHQrQkO5GfoRuRD+oB37IJtp6YJw2FB/BCG/XD9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249136; c=relaxed/simple;
	bh=rKgS9gJSgIQaNW8TlCqdIt7O+gTdHiP4EkRYIzSqI8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJ4t0xi13mcbKo1tKSs2KPfU847iENpEOcYMiXskh602kFKfEu+p7WXISrkZFqdC2OgOdzdGTwf8+941K/ijUxP94jgXUz7vqSDXOfp31Wjp0Kvc+ygXSSkmAgUamfhCra6+pYfdt1WIRHUIBiEkruwewITHeboJLAMStsoErsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1713249004t4u6z1wf
X-QQ-Originating-IP: KYaA9508BYvgZgDE9yGCKmyLenS81AyzIsYc1iuHk3E=
Received: from lap-jiawenwu.trustnetic.com ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 14:30:01 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: wFWfi5UJT1vgrRCDAOlTygB3L/7Gbz8u1DFF4RLi6axuQovgVW5ZbNKV1VuUh
	pOSotUExAI1Jt+ij0HImI/HK2EM0rOWhHG4tr6YvgNQfHIcseltsQAvMH9wla8cGqzvyP6x
	BebqF21wAxACP3+TrZNv5WIu6x3hQY+XYly7BCuANxfKGybWjcOp/2i030qtRjNr5R7uJsq
	ZPAjf6dqA77K6nIjRHm/yRdbSm3JnxQUYa6dHjwd1G3e8f/Y82od9LH9GVuV8KZTPBDzpkR
	h3A20eRko577ZwsCCehHbGAcTfqzN4vV0UsdJn95986Klv7roCTe2nEc8giXvMOhnXF4syH
	byBLch7ECbTb/fI5/Om0X2ZhfIhrbYgVO1nGmim39H+tFIiEAM=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12021446528250099071
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
Subject: [PATCH net 0/5] Wangxun fixes
Date: Tue, 16 Apr 2024 14:29:47 +0800
Message-Id: <20240416062952.14196-1-jiawenwu@trustnetic.com>
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

Fixed some bugs when using ethtool to operate network devices.

Jiawen Wu (5):
  net: wangxun: fix the incorrect display of queue number in statistics
  net: wangxun: fix error statistics when the device is reset
  net: wangxun: fix to change Rx features
  net: wangxun: change NETIF_F_HW_VLAN_STAG_* to fixed features
  net: txgbe: fix to control VLAN strip

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 19 ++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 26 +++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  6 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 24 +++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  6 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 24 +++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 63 ++++++++++++++++++-
 9 files changed, 154 insertions(+), 19 deletions(-)

-- 
2.27.0


