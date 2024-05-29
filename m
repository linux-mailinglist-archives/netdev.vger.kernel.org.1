Return-Path: <netdev+bounces-98941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863338D3341
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B4E1F25CB2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B416A361;
	Wed, 29 May 2024 09:40:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E4167DB1
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975653; cv=none; b=cFHxug2Sgr6SOHiBJ+HIbCHugWqP0N1i3E7eeay660nuPb/sjpuegjumnSe/LtwDbhZZFs/TcRit68NLu05TC32hzPmhp9UU5d4+fN+2+FlbwY3SdVoYQRAjOGZoKmWhj1GZtSfL5BPLF8579R9jAdxEsXj0D1fjaCmEcEEH4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975653; c=relaxed/simple;
	bh=0bEdKrPYHajaYLvMUKIP9PC+ZPBiAWNF9EE53Qp3gZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMKvsuvYAkmoUoFXdUULOstYuyqAu4sbQUwK9N8DIGiMHBSmj1clY6mq0xDDtQUhDuAOjmsMtKYW/E3Fz0DXX2nszP2jFdS/oy1JUoF5u2hNpxMAsG7wGnVkp+/Qy4lUTC+kt7uFivgROmQaL22XRIzaIaFOrqdrfVN7KMCXhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1716975511twifr8eg
X-QQ-Originating-IP: xJ60VAXB6gsZnXnE8gRuMvG2pZ9wh/v12HtfT58tXug=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.253.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 May 2024 17:38:28 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: fs34Pe/+C2T7Gtpzk6XMJXcv36jm22uTfb1tYbWIhvq7eS5rFe/Awsvbn53aq
	lHdGAY9VLILovwM8wKhPUpGpBG3F0dsZCjyEgXOzJNfRWEtObllgK0HJxl84X22Z6OfxpIT
	rAkStoz2F4tM/91s9Houyrf4/t5zW7l5QcNmLGXqS053WdeEeiq6n2sk+XeOiBhq/OuddQs
	jAwOyo9rlfYzckLd+qnn5Q0qZHaKMNcsYJh6MvyB4/Zkrr08n6fodU/G1QaHVtfEgUGmHQb
	Bi1tf/GJ04OS5FiNoGTYkKT8bcQ3Snr+bCGxzdT+IAP9ZNR8beBSghT3uyx7RdaAamoLYUO
	iAQESriGbwtAynORY4X9KIvhlHnDIWmekXUpmxqP2mXJ9JT8KteKgXK/FzR/LjTeoebst6e
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17379359922282141954
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	justinstitt@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RFC net-next 0/3] add flow director for txgbe
Date: Wed, 29 May 2024 17:38:18 +0800
Message-Id: <20240529093821.27108-1-jiawenwu@trustnetic.com>
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

Add flow director support for Wangxun 10Gb NICs.

Jiawen Wu (3):
  net: txgbe: add FDIR ATR support
  net: txgbe: support Flow Director perfect filters
  net: txgbe: add FDIR info to ethtool ops

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  39 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  32 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  62 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  56 +-
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 417 ++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.c   | 628 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_fdir.h   |  18 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  18 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 147 ++++
 12 files changed, 1410 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.h

-- 
2.27.0


