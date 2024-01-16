Return-Path: <netdev+bounces-63706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E582EF88
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 14:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D328507D
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F931BC4C;
	Tue, 16 Jan 2024 13:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683C1BC40
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-mBUTf_1705410694;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-mBUTf_1705410694)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 21:11:34 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 0/3] virtio-net: a fix and some updates for virtio dim
Date: Tue, 16 Jan 2024 21:11:30 +0800
Message-Id: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Patch 1 fixes an existing bug. Belongs to the net branch.
Patch 2 requires updating the virtio spec.
Patch 3 only attempts to modify the sending of dim cmd to an asynchronous way,
and does not affect the synchronization way of ethtool cmd.

Heng Qi (3):
  virtio-net: fix possible dim status unrecoverable
  virtio-net: batch dim request
  virtio-net: reduce the CPU consumption of dim worker

 drivers/net/virtio_net.c        | 197 ++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |   1 +
 2 files changed, 182 insertions(+), 16 deletions(-)

-- 
1.8.3.1


