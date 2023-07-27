Return-Path: <netdev+bounces-21868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBD17651D1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAEC281555
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DE0156DA;
	Thu, 27 Jul 2023 10:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA616418
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:26 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4622810D2
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:25 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id 9B7EC32016B;
	Thu, 27 Jul 2023 11:40:45 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQ9-0002X7-To;
	Thu, 27 Jul 2023 11:40:37 +0100
Subject: [PATCH net-next 00/11] sfc: Remove Siena bits from sfc.ko
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:40:37 +0100
Message-ID: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,KHOP_HELO_FCRDNS,MAY_BE_FORGED,
	NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL,
	SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Last year we split off Siena into it's own driver under directory siena.
This patch series removes the now unused Falcon and Siena code from sfc.ko.
No functional changes are intended.

---

Martin Habets (11):
      sfc: Remove falcon references
      sfc: Remove siena_nic_data and stats
      sfc: Remove support for siena high priority queue
      sfc: Remove EFX_REV_SIENA_A0
      sfc: Remove PTP code for Siena
      sfc: Remove some NIC type indirections that are no longer needed
      sfc: Filter cleanups for Falcon and Siena
      sfc: Remove struct efx_special_buffer
      sfc: Miscellaneous comment removals
      sfc: Cleanups in io.h
      sfc: Remove vfdi.h


 drivers/net/ethernet/sfc/ef10.c             |    4 
 drivers/net/ethernet/sfc/ef100_nic.c        |    2 
 drivers/net/ethernet/sfc/ef100_tx.c         |    6 
 drivers/net/ethernet/sfc/ef10_sriov.h       |    2 
 drivers/net/ethernet/sfc/efx.c              |    1 
 drivers/net/ethernet/sfc/efx.h              |    2 
 drivers/net/ethernet/sfc/efx_channels.c     |   30 
 drivers/net/ethernet/sfc/efx_common.c       |    7 
 drivers/net/ethernet/sfc/farch_regs.h       | 2929 ---------------------------
 drivers/net/ethernet/sfc/filter.h           |    7 
 drivers/net/ethernet/sfc/io.h               |   84 -
 drivers/net/ethernet/sfc/mcdi.c             |    7 
 drivers/net/ethernet/sfc/mcdi_functions.c   |   24 
 drivers/net/ethernet/sfc/mcdi_port_common.c |    5 
 drivers/net/ethernet/sfc/net_driver.h       |   63 -
 drivers/net/ethernet/sfc/nic.c              |  158 -
 drivers/net/ethernet/sfc/nic.h              |  178 --
 drivers/net/ethernet/sfc/nic_common.h       |   13 
 drivers/net/ethernet/sfc/ptp.c              |  227 --
 drivers/net/ethernet/sfc/selftest.c         |    7 
 drivers/net/ethernet/sfc/tx.c               |   45 
 drivers/net/ethernet/sfc/tx_tso.c           |    2 
 drivers/net/ethernet/sfc/vfdi.h             |  252 --
 drivers/net/ethernet/sfc/workarounds.h      |    7 
 24 files changed, 42 insertions(+), 4020 deletions(-)
 delete mode 100644 drivers/net/ethernet/sfc/farch_regs.h
 delete mode 100644 drivers/net/ethernet/sfc/vfdi.h

--
Martin Habets <habetsm.xilinx@gmail.com>



