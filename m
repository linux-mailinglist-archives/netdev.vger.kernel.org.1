Return-Path: <netdev+bounces-45506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FDA7DDBA0
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 04:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0591C20CC7
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1B1102;
	Wed,  1 Nov 2023 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AABED7
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 03:43:11 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B8A4;
	Tue, 31 Oct 2023 20:43:07 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VvKVDMt_1698810177;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvKVDMt_1698810177)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 11:43:04 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net 0/3] bugfixs for smc
Date: Wed,  1 Nov 2023 11:42:54 +0800
Message-Id: <1698810177-69740-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patches includes bugfix following:

1. hung state
2. sock leak
3. potential panic 

We have been testing these patches for some time, but
if you have any questions, please let us know.

Thanks,
D. Wythe

D. Wythe (3):
  net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
  net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
  net/smc: put sk reference if close work was canceled

 net/smc/af_smc.c    |  4 ++--
 net/smc/smc.h       |  5 +++++
 net/smc/smc_cdc.c   | 11 +++++------
 net/smc/smc_close.c |  5 +++--
 4 files changed, 15 insertions(+), 10 deletions(-)

-- 
1.8.3.1


