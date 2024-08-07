Return-Path: <netdev+bounces-116455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E497C94A737
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DB11F23CB6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6921E3CC1;
	Wed,  7 Aug 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="g/tWAC/T"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-84.smtpout.orange.fr [80.12.242.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F4171E69;
	Wed,  7 Aug 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031453; cv=none; b=THDm4ZJknkZoaABmEu35KoAQzUJe7x0dZJVLFUK6KO0ZyRx1egyu2yOCNdxmmvHJQ1I5zux9vS5HP7b0rZzKivB7vI/z6J0C5WHKsycijoGlJsD3oNGWT8lpWGnnKCZBFpTAfCyvq9WBdosqty7bOwzeHFqbaqWvAjz/kbi8w20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031453; c=relaxed/simple;
	bh=OVFOto6e65+c4nKCzmzscz/exRDud1tlzbTEr4N0EY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sU+yQUVjnxURevEji6NQmFKXibeBR9YeiqjCu6HFC1Z1348TCUAZnNOoSn/9LxYkxwt4l27FBcjIPNNQkZBpJkHHW1GLSnW/s0FaPqo/p8IZQZFmF36Lb/YlWxhMXjZseFpMYuEf9CqAwwfY/19hUH49X0LQf3JFN4TpFX12K3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=g/tWAC/T; arc=none smtp.client-ip=80.12.242.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bfBdsxqDOGdLxbfBdsrywa; Wed, 07 Aug 2024 13:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723031441;
	bh=gGp51/nkgJ7p0vWRXfhYIn/n399BaIfjQd0IuhiOb0E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=g/tWAC/TaNQpzvVepgA1ufqI77xsxYX2zlp8IzDHKUfIU48FOF4L7t8E3gBawNHG7
	 ug8TJTCz9vbEbOpYgAiX/skVMEtZyFQWbyHTRTth1ddt5ifk7MuwN800RrJnozVU9B
	 lTnAiyy3YZpU+UaqeERJ9SiJE+kfOrwzht9qc3VTU1nmCK/xKDhbiZLY1ozaI05BGq
	 I/2iXXAblAG8jI2w5qbzchF+rM3MjfoZlrwK8mo+FOTkyuKWcho/boQtThAMulzOKo
	 BTTKTFlK7Q9t+oh7tebHgp41vQyWLsPT07ptvL3x5ulGRLBjVyCAWe4AkzXFQO1APJ
	 VF06KlvXJaLAQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 07 Aug 2024 13:50:41 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: ibm/emac: Constify struct mii_phy_def
Date: Wed,  7 Aug 2024 13:50:31 +0200
Message-ID: <dfc7876d660d700a840e64c35de0a6519e117539.1723031352.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct mii_phy_def' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increase overall security.


On a x86_64, with allmodconfig:
Before:
======
   4901	    464	      0	   5365	   14f5	drivers/net/ethernet/ibm/emac/phy.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   5127	    240	      0	   5367	   14f7	drivers/net/ethernet/ibm/emac/phy.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/net/ethernet/ibm/emac/phy.c | 18 +++++++++---------
 drivers/net/ethernet/ibm/emac/phy.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/phy.c b/drivers/net/ethernet/ibm/emac/phy.c
index 1e798cc9b6b8..f90abcfaf487 100644
--- a/drivers/net/ethernet/ibm/emac/phy.c
+++ b/drivers/net/ethernet/ibm/emac/phy.c
@@ -284,7 +284,7 @@ static const struct mii_phy_ops generic_phy_ops = {
 	.read_link	= genmii_read_link
 };
 
-static struct mii_phy_def genmii_phy_def = {
+static const struct mii_phy_def genmii_phy_def = {
 	.phy_id		= 0x00000000,
 	.phy_id_mask	= 0x00000000,
 	.name		= "Generic MII",
@@ -349,14 +349,14 @@ static const struct mii_phy_ops cis8201_phy_ops = {
 	.read_link	= genmii_read_link
 };
 
-static struct mii_phy_def cis8201_phy_def = {
+static const struct mii_phy_def cis8201_phy_def = {
 	.phy_id		= 0x000fc410,
 	.phy_id_mask	= 0x000ffff0,
 	.name		= "CIS8201 Gigabit Ethernet",
 	.ops		= &cis8201_phy_ops
 };
 
-static struct mii_phy_def bcm5248_phy_def = {
+static const struct mii_phy_def bcm5248_phy_def = {
 
 	.phy_id		= 0x0143bc00,
 	.phy_id_mask	= 0x0ffffff0,
@@ -429,7 +429,7 @@ static const struct mii_phy_ops et1011c_phy_ops = {
 	.read_link	= genmii_read_link
 };
 
-static struct mii_phy_def et1011c_phy_def = {
+static const struct mii_phy_def et1011c_phy_def = {
 	.phy_id		= 0x0282f000,
 	.phy_id_mask	= 0x0fffff00,
 	.name		= "ET1011C Gigabit Ethernet",
@@ -448,7 +448,7 @@ static const struct mii_phy_ops m88e1111_phy_ops = {
 	.read_link	= genmii_read_link
 };
 
-static struct mii_phy_def m88e1111_phy_def = {
+static const struct mii_phy_def m88e1111_phy_def = {
 
 	.phy_id		= 0x01410CC0,
 	.phy_id_mask	= 0x0ffffff0,
@@ -464,7 +464,7 @@ static const struct mii_phy_ops m88e1112_phy_ops = {
 	.read_link	= genmii_read_link
 };
 
-static struct mii_phy_def m88e1112_phy_def = {
+static const struct mii_phy_def m88e1112_phy_def = {
 	.phy_id		= 0x01410C90,
 	.phy_id_mask	= 0x0ffffff0,
 	.name		= "Marvell 88E1112 Ethernet",
@@ -489,14 +489,14 @@ static const struct mii_phy_ops ar8035_phy_ops = {
 	.read_link	= genmii_read_link,
 };
 
-static struct mii_phy_def ar8035_phy_def = {
+static const struct mii_phy_def ar8035_phy_def = {
 	.phy_id		= 0x004dd070,
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Atheros 8035 Gigabit Ethernet",
 	.ops		= &ar8035_phy_ops,
 };
 
-static struct mii_phy_def *mii_phy_table[] = {
+static const struct mii_phy_def *mii_phy_table[] = {
 	&et1011c_phy_def,
 	&cis8201_phy_def,
 	&bcm5248_phy_def,
@@ -509,7 +509,7 @@ static struct mii_phy_def *mii_phy_table[] = {
 
 int emac_mii_phy_probe(struct mii_phy *phy, int address)
 {
-	struct mii_phy_def *def;
+	const struct mii_phy_def *def;
 	int i;
 	u32 id;
 
diff --git a/drivers/net/ethernet/ibm/emac/phy.h b/drivers/net/ethernet/ibm/emac/phy.h
index 2184e8373ee5..b1ede47a540f 100644
--- a/drivers/net/ethernet/ibm/emac/phy.h
+++ b/drivers/net/ethernet/ibm/emac/phy.h
@@ -47,7 +47,7 @@ struct mii_phy_def {
 
 /* An instance of a PHY, partially borrowed from mii_if_info */
 struct mii_phy {
-	struct mii_phy_def *def;
+	const struct mii_phy_def *def;
 	u32 advertising;	/* Ethtool ADVERTISED_* defines */
 	u32 features;		/* Copied from mii_phy_def.features
 				   or determined automaticaly */
-- 
2.45.2


