Return-Path: <netdev+bounces-39913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558357C4E31
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEAE282177
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223E1A71F;
	Wed, 11 Oct 2023 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71B1A718
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:07:55 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806189D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:07:53 -0700 (PDT)
X-QQ-mid: bizesmtp86t1697015204tmyj44k5
Received: from wxdbg.localdomain.com ( [115.200.230.47])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Oct 2023 17:06:32 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: eSZ1CZgv+JC4eNoHnF/IkOoO8IIQtt6j2qZ1Uo0YfyKC8eFbhUKJ8mCJDDJ73
	4L4WzdXyoM7dC6VH3pVsYW52R1Msg5v0Wb7vTNhrBi3JejmOotnK3BwKK0eJD8zBUgwyhFC
	zH7UdAjWAJVIvc0VKa+DKYHPPg/2YjTSpEaGnzFVBrYsPEcXCHwwQNXwlQ9Djvtcs8Fc1iR
	m1VTWnXu8jiotjjlxf59j1Q+tLYkUqVna9X2MVL3mXq2r/mJUMJwJEOxi7z11YTH9Ct72bD
	b3C5Nd+F1eYWbVF+nJSADkUMNY1cYnrjQRnGm8oTUPizs0cg0DanblJrvGw5rcnIyMNm1sY
	Ycya+VXzZJpgkr3igojP6/27C94JRa+JPRo2lgWDM1P0HYa50w=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12012513055778814548
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/3] Wangxun ethtool stats
Date: Wed, 11 Oct 2023 17:19:03 +0800
Message-Id: <20231011091906.70486-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool stats for txgbe/ngbe.

v2 -> v3:
- remove standard netdev statistics
- move some stats to the right ethtool_ops
- remove test strings

v1 -> v2:
- change struct wx_stats member types
- use ethtool_sprintf()

Jiawen Wu (3):
  net: libwx: support hardware statistics
  net: txgbe: add ethtool stats support
  net: ngbe: add ethtool stats support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 169 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   8 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  99 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  81 +++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   5 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c   |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   5 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   2 +
 12 files changed, 395 insertions(+), 2 deletions(-)

-- 
2.27.0


