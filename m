Return-Path: <netdev+bounces-264406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBrCAe6SqWkqAQEAu9opvQ
	(envelope-from <netdev+bounces-264406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:27:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 970DE21361A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC9731D2353
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B83A6F08;
	Thu,  5 Mar 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5/H4LYxe"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EEA246BCD;
	Thu,  5 Mar 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720536; cv=none; b=D32+QOil8yLI1mptHzpKIn2dYmQLaWfEKSl6/Qm6yT1Ogwm9ZFffIVcOQKMg/pNKvf3bWOh/aMXBWK9tJrl0HtDCqlzWNf1i37UYrH5PeTevKRompwJjrE1DEqgYeI/cUdZHBr04ncuo6sAfgU510LY+92HuL23mSeT80Ya31kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720536; c=relaxed/simple;
	bh=FyrJO934c2Q08VFZw98/QGu7W1xJURNsMAM6qBnp2aE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FaQTICyVzgLG7BUkEHY+aIGC6InVMH2c4mR4OXU7LPWmwA2kRkp4MgKhxKmWdR+sB7Cz4iTBvZytcvke326kB3W29/ZMX4p9RyqQfeU6fFzzTaW9CR6GCkUUq2Q4Az0mINZ/6Hd6/ngWITWKMWMoverDQCsPtu/00RFzzZGRQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5/H4LYxe; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6kk/V2kSb+hk1d/bnoCL/WTzwRbODiqZx5XFRSsUATs=;
	b=5/H4LYxeBe2fLH5C07zuYFwZE3RTeVY7U9kcy9Yi9ja6DRwmf/SJr2ZEWHpaEbpZZZR+gMGhp
	IKCNyTvBBiDC7L54vknutFrYOZT7eMJW30MTKyV8IdGq1zek5EvCyUWgnY6WsM+uH7v7kYZAeff
	y4T2xM56x34I5g0NDf6xP2o=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fRWnm1b6gzRhR1;
	Thu,  5 Mar 2026 22:17:16 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FE9340538;
	Thu,  5 Mar 2026 22:22:07 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Mar 2026 22:22:06 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v02 0/4] net: hinic3: Fix code styles
Date: Thu, 5 Mar 2026 22:21:57 +0800
Message-ID: <cover.1769142701.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Queue-Id: 970DE21361A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264406-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This patchset provides 4 code styles fixes:

Remove empty lines between error handling.
Remove redundant defensive code.
Use array_size instead of multiplying.
SQ use SQ_CTXT_PREF_CI_HI to improve readability.

Thanks,
Fan gong

Fan Gong (4):
  hinic3: Fix code Style(remove empty lines between error handling)
  hinic3: Remove redundant defensive code
  hinic3: Use array_size instead of multiplying
  hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI

 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c    | 3 ---
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c     | 1 -
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c     | 5 -----
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c    | 4 ----
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c    | 2 --
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 6 ++++--
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c  | 6 +++++-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c      | 7 -------
 8 files changed, 9 insertions(+), 25 deletions(-)


base-commit: 4515ec4ad58a37e70a9e1256c0b993958c9b7497
-- 
2.43.0


