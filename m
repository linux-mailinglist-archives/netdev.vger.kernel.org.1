Return-Path: <netdev+bounces-34419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E37A41D8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D7928207C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB1748D;
	Mon, 18 Sep 2023 07:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B26FC2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 07:10:51 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E1E6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 00:10:47 -0700 (PDT)
X-QQ-mid: bizesmtp72t1695020976t050brc6
Received: from wxdbg.localdomain.com ( [125.119.240.142])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Sep 2023 15:09:26 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3ikiD2o2uoUaVUxvRMm1WfbnZK5a4gUY23gjBP69kCO7L1SZ8b+r
	SFF0oQAK4FWbSW+ij2R2WpN22eUaf+WI9bx+6c3x0RgmUQdqhQZS82fnAnkyhWTjmDk6M8d
	CNUpIUtgfCz9YD+It7YObPgfOE8QxckE0dNaqLHxjI2NxH6KOZi+j+80ic9qmi9/FHnv0gC
	es/QM275XuoJc3Bn7N5j5P83BXT696LqQWD1KI+ET6nyCVB6xXIB8qUD1Sd10hDh/10BTKd
	B5lV4YUOtp6QmWXtpAuEr7GYHxn0btvePsPsC5vK0psTNLRllOLLJZoPcZBAMoDarsTi5Ik
	+83IqiYWFtrJbKOD0dzW2MR9Q3OhwSMJrXbvhfZ
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7493456648220543593
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 0/3] Wangxun ethtool stats
Date: Mon, 18 Sep 2023 15:21:05 +0800
Message-Id: <20230918072108.809020-1-jiawenwu@trustnetic.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support to show ethtool stats for txgbe/ngbe.

Jiawen Wu (3):
  net: libwx: support hardware statistics
  net: txgbe: add ethtool stats support
  net: ngbe: add ethtool stats support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 208 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 116 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  11 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  80 +++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c   |   2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   2 +
 12 files changed, 433 insertions(+), 2 deletions(-)

-- 
2.27.0


