Return-Path: <netdev+bounces-46904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D337E705D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFF281364
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597F22331;
	Thu,  9 Nov 2023 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2022339
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:34:27 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF793;
	Thu,  9 Nov 2023 09:34:26 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A9HY9qE41693911, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A9HY9qE41693911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 01:34:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Nov 2023 01:34:10 +0800
Received: from Test06-PC.realtek.com.tw (172.22.228.55) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 10 Nov 2023 01:34:08 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>
CC: <nic_swsd@realtek.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, ChunHao Lin <hau@realtek.com>
Subject: [PATCH net v4 0/2] r8169: fix DASH devices network lost issue
Date: Fri, 10 Nov 2023 01:33:58 +0800
Message-ID: <20231109173400.4573-1-hau@realtek.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.228.55]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

This series are used to fix network lost issue on systems that support 
DASH. It has been tested on rtl8168ep and rtl8168fp.


V3 -> V4: Fix a coding style issue.
V2 -> V3: Add 'Fixes' tag and correct indentation.
V1 -> V2: Change variable and function name. And update DASH info message.

ChunHao Lin (2):
  r8169: add handling DASH when DASH is disabled
  r8169: fix network lost after resume on DASH systems

 drivers/net/ethernet/realtek/r8169_main.c | 42 +++++++++++++++++------
 1 file changed, 31 insertions(+), 11 deletions(-)

-- 
2.39.2


