Return-Path: <netdev+bounces-111401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69445930CD7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 04:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9441C20B12
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DB8825;
	Mon, 15 Jul 2024 02:52:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E979C4;
	Mon, 15 Jul 2024 02:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721011943; cv=none; b=RkeN/4uUxzjVKGq4L7KZQBeiiEDfkbFKWZIvfTwY93eyYz19e6RrGQJZ5db8CV3JQkDC96apra8Yfo1ZG4VfbtX0Nczz/au7Sw7eMCR/fkDIO0cGTmy9lNWkdAOQEXlV64hkYqg1d04HY3KWQDpu4YQLaOHIO5wBTyQhJ5jm4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721011943; c=relaxed/simple;
	bh=X4Zat/Y0hsdoDe5Svj/icJkSVmFXQVcN6YIDamtiEFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WUuddLUNsxrzlKt2nfbAgXfo2fDEcu85UHniCu2ZacIviBgjFfDRbQhUNBaHoCnoinY46ZsEIBvKidW3BeBEmGVR2+2kqTDLIj5yyyTjUCKAQprvc9muG0BN66DWTW2JJaJIt0q3QrMBVp5FexmSq9Odg/8LgF+OxEqkZzeTZ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAD3_1vRjpRm23TOFQ--.12132S2;
	Mon, 15 Jul 2024 10:52:01 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: roopa@nvidia.com,
	razor@blackwall.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
Date: Mon, 15 Jul 2024 10:44:57 +0800
Message-Id: <20240715024457.3743560-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3_1vRjpRm23TOFQ--.12132S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr13ZryDWF1UXF4fCryxuFg_yoW8JFWfpa
	4UGan3AF47Xw1Ygw48ZFWUAry3tFn5KrW3Gr12y34Fvrn3tFy0kFWktryUCr1rAF4Dur13
	Jr12gF1Syw1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU1UGYJUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary cast of void * returned by netdev_priv().

Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 net/bridge/br_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f17dbac7d828..d02cc1497281 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1085,7 +1085,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 	       struct netlink_ext_ack *extack)
 {
-	struct net_bridge *br = (struct net_bridge *)netdev_priv(dev);
+	struct net_bridge *br = netdev_priv(dev);
 	struct nlattr *tb[IFLA_BRPORT_MAX + 1];
 	struct net_bridge_port *p;
 	struct nlattr *protinfo;
@@ -1143,7 +1143,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 /* Delete port information */
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags)
 {
-	struct net_bridge *br = (struct net_bridge *)netdev_priv(dev);
+	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *p;
 	struct nlattr *afspec;
 	bool changed = false;
-- 
2.25.1


