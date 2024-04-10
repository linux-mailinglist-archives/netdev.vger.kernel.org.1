Return-Path: <netdev+bounces-86379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA489E86E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9561C227B6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D3946C;
	Wed, 10 Apr 2024 03:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BF8BF0
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712719629; cv=none; b=fmzwWDCgOXA9K7RJ/LJ4aVbL/lGbC09zvTDjsnWOeVuGTKk/jbYL64/Z/XcWYL4AoP/yhO6Ui6KN0bJlQsrDxWv1HVudlyg/RGHgCbWCWo+FaHVtxgjQ0cej08Ad7Iz6N0MPgMFVNCYCOurcZ8yWSy4uj43X2/Fqcl81ceEzXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712719629; c=relaxed/simple;
	bh=DEkMOwjBrOesmp6ysQM4XzGJyJRjVi85+PE2p3aW/I0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6FGUdGb0U93W5VsAOBluUkNUoZFJzhvLfF0XiibPU9paY1bf0UrTxX7YuMEB27x0kI5hWCEITSKFEgGduAOaT0ufTNJP29pamEVyYamtaWQ8bPDmF7CH7jAaUnpI1clF8gpycvedHxWf9AGzAmc94qEirhUzqZLaj7mRcnVRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp87t1712719602tudlzqcf
X-QQ-Originating-IP: uRWCNgTYqI5PSSyYE3Jzxc0qeDmpbW9kJ1kw8BM6vac=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 11:26:31 +0800 (CST)
X-QQ-SSF: 01400000000000C0F000000A0000000
X-QQ-FEAT: +ynUkgUhZJlFxRXM17hS87Xr8XncyJPFL1YLkIGZUv/VkQC7MTnx6XuFBWvdz
	DNGvbc2mWakNwlaUCYpYN/6AFxn18ShVA3ZEfu8gsI6nHyPDmbUbHk36QH482NcXg6tyeuE
	wu+CsCVxq5UK0eJ0DVwPzVRYEKc4MTSKMzdNd+07NFzk/22a1xq6LytGxGozaP/YvjRJ8Fb
	1ZgCWz2AV7ghf/jYqpqVnIATX19yS3mkWsqh1r+Wgnhs44TA73/0KaJpVRmdj9QuLOjms+1
	gLGe1aj1MdpdWVVNr6lEakz3v6wCO+YDXrOOzympjLBfwdJM8I7aLUf3VyVRYPUMWUDW0w4
	vUg8bjIh1l+ec/OM74ZYJRZuDmoSr4TKaYT9EynaS8v/h+xkiflGCtyzPIBOg==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2209935845310419828
From: liweigang <liweiganga@uniontech.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	liweigang <liweiganga@uniontech.com>
Subject: [PATCH] netlink: fix typo Add missing colon in coalesce_reply_cb
Date: Wed, 10 Apr 2024 11:26:29 +0800
Message-Id: <20240410032629.3224092-1-liweiganga@uniontech.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0

Signed-off-by: liweigang <liweiganga@uniontech.com>
---
 netlink/coalesce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/coalesce.c b/netlink/coalesce.c
index bc34d3d..bb93f9b 100644
--- a/netlink/coalesce.c
+++ b/netlink/coalesce.c
@@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
 	show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
-	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
+	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
 	show_cr();
 
-- 
2.33.1


