Return-Path: <netdev+bounces-197938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21DADA6C2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F019416C127
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7826A0B1;
	Mon, 16 Jun 2025 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KLbFEjWj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8686329;
	Mon, 16 Jun 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750044215; cv=none; b=l0uVLh17AkckQRqHcXHkd4b3MJuHIsINPzsttRC5DqbyD0Yx8s49amKi+PVbY8m7Vi02McoI5AS3U69rbdeLfKJUvryjUMPXptpDJBnqgEcqrFCaLn2DHnEHn2Pn9oLbkOD2d7ArgPL3l3CCmLDSXkyQHoY82bJ7tDKp1eXedmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750044215; c=relaxed/simple;
	bh=+I56kdvpVXRtSoPdLmV+uJ+JQPdl0Sj12h8HsJ/Jfy4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxd1kcY8kbYCXNpAK/XpeAKtp60QJSCUxWHEw2EbU9o5O6wYW6aHdX+xHbm1Gz7flJCyt3DxrQVT8xxnkazNSPAz4kBY4hnZSGwW2/mxXvuukndHph8kWjCw5sXQn+/gm7gF7Arfdm0TigYZgk0d0tE0aXdrdLdc6wF9FDSORHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KLbFEjWj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3N0hcC3976451, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750044180; bh=WE4KDjDz5dfPH50KspF6oR4vvDcJ53rKoowvoXx9d2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KLbFEjWj/qNLGmeEvQYAco6AgBbw6vbQrkts+x8eH1R+5TDqAyf0WeJpGLvz8iYSD
	 EWHj/8ELL83yGce/QKoN+v0LSHXZbMdBfzCmkhJHt7jWcrFXHnMQ6/gxc0mmXUOPLZ
	 xb2cYa4fqHrtjMng8FRpQd/Sel4cspzUBvZM/fHYNkl6elofK1O2+fHHratA+JBeVZ
	 B7BmEvEI6onPvWQNijdzvlsLrocPGcCKDeSb4GLkOI1xCek5iyTCVQbI1F5BeGK6pZ
	 d6PXbwpG9Y54LXrq08F/XA+ls4gyxUbTluYRsK0FP3Kgedu8QMsonNCCc4kLt8sUjc
	 trJuiwEgM3vIQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3N0hcC3976451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:23:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:22:38 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 11:22:37 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v2 0/2] Link NAPI instances to queues and IRQs
Date: Mon, 16 Jun 2025 11:22:24 +0800
Message-ID: <20250616032226.7318-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch series introduces netdev-genl support to rtase, enabling
user-space applications to query the relationships between IRQs,
queues, and NAPI instances.

v1 -> v2:
- Use netif_napi_add_config() to support persistent NAPI configuration.
- Use enum netdev_queue_type instead of driver-specific values.
- Rename ring_type to type.

Justin Lai (2):
  rtase: Link IRQs to NAPI instances
  rtase: Link queues to NAPI instances

 drivers/net/ethernet/realtek/rtase/rtase.h    |  1 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 39 +++++++++++++++----
 2 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.34.1


