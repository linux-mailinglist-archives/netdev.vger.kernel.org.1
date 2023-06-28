Return-Path: <netdev+bounces-14387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9EF740880
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 04:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A9B1C20BAA
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDEA7E1;
	Wed, 28 Jun 2023 02:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132815B6
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 02:43:37 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id C40B42950;
	Tue, 27 Jun 2023 19:43:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id D81EF6032EB52;
	Wed, 28 Jun 2023 10:42:44 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: wuych <yunchuan@nfschina.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	irusskikh@marvell.com,
	yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	steve.glendinning@shawell.net,
	iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	mostrows@earthlink.net,
	xeb@mail.ru,
	qiang.zhao@nxp.com
Cc: yangyingliang@huawei.com,
	yunchuan@nfschina.com,
	linux@rempel-privat.de,
	ansuelsmth@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linuxppc-dev@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next 00/10] Remove unnecessary (void*) conversions
Date: Wed, 28 Jun 2023 10:41:21 +0800
Message-Id: <20230628024121.1439149-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove (void*) conversions under "drivers/net" directory.
According to the suggestion[1] of Jakub Kicinski, send these patches
in series of 10. 

wuych (10):
  net: dsa: ar9331: remove unnecessary (void*) conversions
  net: dsa: qca8k: remove unnecessary (void*) conversions
  atlantic:hw_atl2:hw_atl2_utils_fw: Remove unnecessary (void*)
    conversions
  ice: Remove unnecessary (void*) conversions
  ethernet: smsc: remove unnecessary (void*) conversions
  net: hns: Remove unnecessary (void*) conversions
  net: hns3: remove unnecessary (void*) conversions
  net: mdio: Remove unnecessary (void*) conversions
  net: ppp: remove unnecessary (void*) conversions
  net: wan: Remove unnecessary (void*) conversions

 drivers/net/dsa/qca/ar9331.c                     | 16 ++++++++--------
 drivers/net/dsa/qca/qca8k-8xxx.c                 |  2 +-
 drivers/net/dsa/qca/qca8k-common.c               |  6 +++---
 .../aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_ethtool.c   |  2 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c        | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_main.c        |  4 ++--
 drivers/net/ethernet/smsc/smsc911x.c             |  4 ++--
 drivers/net/ethernet/smsc/smsc9420.c             |  4 ++--
 drivers/net/mdio/mdio-xgene.c                    |  8 ++++----
 drivers/net/ppp/pppoe.c                          |  4 ++--
 drivers/net/ppp/pptp.c                           |  4 ++--
 drivers/net/wan/fsl_ucc_hdlc.c                   |  2 +-
 13 files changed, 34 insertions(+), 34 deletions(-)

[1] https://lore.kernel.org/all/20230518194627.4f9a6b04@kernel.org/
-- 
2.30.2


