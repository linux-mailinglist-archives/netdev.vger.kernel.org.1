Return-Path: <netdev+bounces-20282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE275EF12
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD081C20962
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84F6FC1;
	Mon, 24 Jul 2023 09:26:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1402113
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:26:12 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BFF3
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:26:08 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690190757tksm5kye
Received: from localhost.localdomain ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 17:25:47 +0800 (CST)
X-QQ-SSF: 01400000000000N0Z000000A0000000
X-QQ-FEAT: 90EFqYDyPxCndpA0WRvVFW1JepbbgFqTj3fKEv7gVz/8I8kL92JQ92NZjiFUD
	dxDNpa322tjKKRZ0/2D0sTLuAd8+wdKjo+miv8cvtPQxpgSjBB4zbv6neJAvdnJQGMFThQO
	Dq2Np/HxFp5nj2STfFhS/0uZysY5H44pvi7r6laP/18wR0ghVQYkAi5gXQirtcDaZp0su4r
	QIwCahYVG7o0Vja+zfIpn5MiRsHwJdvJZpqnqfduKkcobs+W8mxWITW+NcqIfa0FAa/IiW0
	z63T2UNTthYgPPEZ14FFKaYjd1Q8ipDLj/PMpVUTdCnrtBLmU5eTkiozTRlbPu3khcWshdz
	a/oSs7RlACnXWOZ/xeEyElv93cA5yAl/WIZQnhcz/0VgX9pynPuQxLV7Qw0rAXAE11NLXHz
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13039048734958941633
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 0/2] Wangxun ngbe nics nsci support
Date: Mon, 24 Jul 2023 17:24:57 +0800
Message-ID: <BC93A5C671379750+20230724092544.73531-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add check flow in phy_supend() to implement Wangxun gigabit nics
nsci feature.

Mengyuan Lou (2):
  net: ngbe: add ncsi_enable flag for wangxun nics
  net: phy: add keep_data_connection to struct phydev

 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 5 +++--
 drivers/net/phy/phy_device.c                  | 6 ++++--
 include/linux/netdevice.h                     | 3 +++
 include/linux/phy.h                           | 3 +++
 5 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.41.0


