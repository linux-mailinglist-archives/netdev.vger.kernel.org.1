Return-Path: <netdev+bounces-50070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5BE7F4848
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B846B20C2F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE74E619;
	Wed, 22 Nov 2023 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E489D45;
	Wed, 22 Nov 2023 05:53:04 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vww0FXz_1700661181;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vww0FXz_1700661181)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 21:53:02 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	kgraul@linux.ibm.com,
	corbet@lwn.net,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: tonylu@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] add two sysctl for SMC-R v2.1
Date: Wed, 22 Nov 2023 21:52:56 +0800
Message-Id: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set add two sysctl for SMC-R v2.1:
net.smc.smcr_max_links_per_lgr is used to control the max links
per lgr.
net.smc.smcr_max_conns_per_lgr is used to control the max connections
per lgr.

Guangguan Wang (2):
  net/smc: add sysctl for max links per lgr for SMC-R v2.1
  net/smc: add sysctl for max conns per lgr for SMC-R v2.1

 Documentation/networking/smc-sysctl.rst | 14 ++++++++++++++
 include/net/netns/smc.h                 |  2 ++
 net/smc/af_smc.c                        |  2 +-
 net/smc/smc_clc.c                       | 15 ++++++++++-----
 net/smc/smc_clc.h                       |  3 ++-
 net/smc/smc_sysctl.c                    | 24 ++++++++++++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 7 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.24.3 (Apple Git-128)


