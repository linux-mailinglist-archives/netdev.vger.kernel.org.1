Return-Path: <netdev+bounces-246636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA2CEF9B0
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 01:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F15F302106D
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 00:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC82798E6;
	Sat,  3 Jan 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pace-systems.de header.i=@pace-systems.de header.b="NKyTFur2"
X-Original-To: netdev@vger.kernel.org
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612B279DB3;
	Sat,  3 Jan 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401428; cv=none; b=sOiqkPXbWUpDRTNFfkTEEnAzGUR329T4nn+E1jfr8ertnGf/cU0hYhKRuD9gKGRk18YJKUq5dJlZwd8lTuogHpzVbCpAwY1X7uxPncgk4kJT6Yy+WjvabeTY/kP1kpzS6VGejc87+gMCXW8Z2F5EDmqzSf6J7F2iTDJQbBQAE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401428; c=relaxed/simple;
	bh=okzftweSH1vJQJz9+dviq6pmkiigE2rSnRw3bv3j1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQHMIHx0sK0QkNARCY2IT3bEEYmUGKjJrn/6PFjr6FwyG1du9LnFbepkOSby6JuZbsEF6CwLGctN0iOTle5DLVnI4EIDIqs69cH4KqaIvUSVGjX3k16TzI5rrITuqffU368wKOoFfff/YYk6I+7nGlDiUrDmyA2SA4e11RYLtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pace-systems.de; spf=pass smtp.mailfrom=pace-systems.de; dkim=pass (2048-bit key) header.d=pace-systems.de header.i=@pace-systems.de header.b=NKyTFur2; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pace-systems.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pace-systems.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pace-systems.de; s=blu0479712; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=KViZW5fwyykO6fUVHMd4MvYMBNQgS9IVd0D0l1O9UVc=; b=NKyTFur2+419d4urisS5kRu4Sp
	419Ea7chY3PN0ab7HcPqpnORKAub58r9wZdS2iPgR055gGS9DvurWO4axrFG6m8/PQsThhFcTUvlx
	2ybgGvjmt1BnCvIToJRgKQyoSFiOYqHVmstAhOa6J1KYYmdzZWpWPGUTM4Lik32MgQ4Y/ggQdJB0i
	gBrvXLZAiP+do7WUp/aP2hPv0zjUa6Mz7U5FOshxpOpAZfBjlYUe6s+XQGRMMwWTKCfDnkPjvPLJW
	x2WzAarSjct6JfimYR8D39ECmuKWj7kS/yc7QTdW8eIAoCFbiot/zc0FB8xeJyc/i9N771qWtDFW7
	CyDzENBQ==;
Received: from [178.201.20.114] (helo=sebastian-zbook)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Sebastian.Wolf@pace-systems.de>)
	id 1vbpqO-00F1iG-OS;
	Sat, 03 Jan 2026 01:50:12 +0100
From: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sebastian Roland Wolf <srw@root533.premium-rootserver.net>,
	Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
Subject: [PATCH v2] net: mediatek: add null pointer check for hardware offloading
Date: Sat,  3 Jan 2026 01:50:08 +0100
Message-ID: <20260103005008.438081-1-Sebastian.Wolf@pace-systems.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Con-Id: 282146
X-Con-U: 0-sebastianwolf

From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>

Add a null pointer check to prevent kernel crashes when hardware
offloading is active on MediaTek devices.

In some edge cases, the ethernet pointer or its associated netdev
element can be NULL. Checking these pointers before access is
mandatory to avoid segmentation faults and kernel oops.

This improves the robustness of the validation check for mtk_eth
ingress devices introduced in commit 73cfd947dbdb ("net: mediatek:
add support for ingress traffic offloading").

Fixes: 73cfd947dbdb ("net: mediatek: add support for ingress traffic offloading")
net: mediatek: Add null pointer check to prevent crashes with active hardware offloading.

Signed-off-by: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index e9bd32741983..72bc4a42eac1 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -270,7 +270,8 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		flow_rule_match_meta(rule, &match);
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
-			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
+			if (idev && eth->netdev[0] &&
+			    idev->netdev_ops == eth->netdev[0]->netdev_ops) {
 				struct mtk_mac *mac = netdev_priv(idev);
 
 				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))
-- 
2.51.0


