Return-Path: <netdev+bounces-157039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A33A08C2E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C307B18843AF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F080207A1F;
	Fri, 10 Jan 2025 09:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791D20767F;
	Fri, 10 Jan 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501679; cv=none; b=P7mwFyNfymKpWy2yCIOQ2yEpcD+uGRr/S0RIz1k9Ibaw49BBq0iAmcAWNnQIbuUGoqjrq+Scn7wJZQv+F9EwuZwavcIqGCHvyBwBiuRKIlFYCGIEjpQ4wGuZto4NPzhyUN1adO0TvyZGch0KZpDb9VYn6cJmUfY0+Cu+7NbH4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501679; c=relaxed/simple;
	bh=tEw9BrMR/fAkBy03L5y+Ed/8+XMqZNd9RjjU++2mDDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3BVg7liFobUJC98VXJOG7WZKLMspa603UCq6uKz/BXLXJrxYTguus5i1oFF0BYOROwwMr7mTwEqNUJf+SdoD+zWWShf0rTfrnbvWgP2gwN1Rkr/8exlMSJVEKcKd3ntTbGBxuqf8xtWQx0kfco63FjtM9NK5Lsbn/CPBxTAF2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17bfb4facf3611efa216b1d71e6e1362-20250110
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7975c84f-0765-41f1-9eca-56a082b4fa2d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:50667abc8eae89a10507cc807e47647e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 17bfb4facf3611efa216b1d71e6e1362-20250110
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxiangqian@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 223800801; Fri, 10 Jan 2025 17:34:30 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 531D6160078C6;
	Fri, 10 Jan 2025 17:34:30 +0800 (CST)
X-ns-mid: postfix-6780E9A6-1121261592
Received: from localhost.localdomain (unknown [172.25.83.26])
	by node4.com.cn (NSMail) with ESMTPA id E9C16160078C6;
	Fri, 10 Jan 2025 09:34:28 +0000 (UTC)
From: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
To: Frank.Sae@motor-comm.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Subject: [PATCH] net: phy: motorcomm: Fix yt8521 Speed issue
Date: Fri, 10 Jan 2025 17:33:58 +0800
Message-Id: <20250110093358.2718748-1-zhangxiangqian@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

yt8521 is 1000Mb/s after connecting to the network cable, but it is
still 1000Mb/s after unplugging the network cable.

Signed-off-by: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
---
 drivers/net/phy/motorcomm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 0e91f5d1a4fd..e1e33b1236e2 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1487,6 +1487,7 @@ static int yt8521_read_status(struct phy_device *ph=
ydev)
 		}
=20
 		phydev->link =3D 0;
+		phydev->speed =3D SPEED_UNKNOWN;
 	}
=20
 	return 0;
--=20
2.25.1


