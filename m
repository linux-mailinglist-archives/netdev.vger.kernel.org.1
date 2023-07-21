Return-Path: <netdev+bounces-19887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6971075CAD4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249DC2822F0
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CD27F26;
	Fri, 21 Jul 2023 14:58:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D719BC5
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:58:22 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381002735
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689951501; x=1721487501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CqDJKbSP60EYkLj7qrC49RcCekoGw+rz+RZFFzaAk3w=;
  b=fzm0SDhRNOAEK8WYAL2vuqCjTZZPxkcPXUgiZN4Y/Fgzu7RRqXs2Qthn
   qiwONIjlhXBjS4xpNOcf8GcXuuNqb6hlWqGFWcWWISajLrbUvVQpY6ngU
   UQuIaUK1dg0vWFJvj/VhQsJjkEbZC1aN1suWJ4mXNouy2WN66XAU7ZBWt
   LXMV9yN+A7tyQdumhll12JCtin+wytjIz/VG4/djn5rT7j1BXP3RTE98M
   u/fHvePiGO/kTXbKF6YK4js3R5vyiXi8FAyM2tRnS8MrDvIOESyZ1YLZZ
   x+dXY4DXEzP3Qf18COxsFciZlkSkZKhRpCS6YEVwt3rH99CUopkj1Tt3o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433273025"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433273025"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 07:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055586101"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055586101"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 07:58:18 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: magnus.karlsson@intel.com,
	davem@davemloft.net,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH net-next] net: add missing net_device::xdp_zc_max_segs description
Date: Fri, 21 Jul 2023 16:58:08 +0200
Message-Id: <20230721145808.596298-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Cited commit under 'Fixes' tag introduced new member to struct
net_device without providing description of it - fix it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20230720141613.61488b9e@canb.auug.org.au/
Fixes: 13ce2daa259a ("xsk: add new netlink attribute dedicated for ZC max frags")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/linux/netdevice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3800d0479698..11652e464f5d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2043,6 +2043,8 @@ enum netdev_ml_priv_type {
  *			receive offload (GRO)
  * 	@gro_ipv4_max_size:	Maximum size of aggregated packet in generic
  * 				receive offload (GRO), for IPv4.
+ *	@xdp_zc_max_segs:	Maximum number of segments supported by AF_XDP
+ *				zero copy driver
  *
  *	@dev_addr_shadow:	Copy of @dev_addr to catch direct writes.
  *	@linkwatch_dev_tracker:	refcount tracker used by linkwatch.
-- 
2.34.1


