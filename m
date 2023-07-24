Return-Path: <netdev+bounces-20465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7375FA56
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5DA281459
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6958BE7;
	Mon, 24 Jul 2023 15:01:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40163D505
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:01:49 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D8510E2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:01:47 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qNx4D-0004qm-QH
	for netdev@vger.kernel.org; Mon, 24 Jul 2023 17:01:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AAA2B1F8A44
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:01:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8B3CE1F8A36;
	Mon, 24 Jul 2023 15:01:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id eacadee7;
	Mon, 24 Jul 2023 15:01:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2023-07-24
Date: Mon, 24 Jul 2023 17:01:39 +0200
Message-Id: <20230724150141.766047-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello netdev-team,

this is a pull request of 2 patches for net/master.

The first patch is by me and adds a missing set of CAN state to
CAN_STATE_STOPPED on close in the gs_usb driver.

The last patch is by Eric Dumazet and fixes a lockdep issue in the CAN
raw protocol.

regards,
Marc

---

The following changes since commit 9f9d4c1a2e82174a4e799ec405284a2b0de32b6a:

  net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type (2023-07-19 21:15:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.5-20230724

for you to fetch changes up to 11c9027c983e9e4b408ee5613b6504d24ebd85be:

  can: raw: fix lockdep issue in raw_release() (2023-07-20 13:46:29 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.5-20230724

----------------------------------------------------------------
Eric Dumazet (1):
      can: raw: fix lockdep issue in raw_release()

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

 drivers/net/can/usb/gs_usb.c | 2 ++
 net/can/raw.c                | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)



