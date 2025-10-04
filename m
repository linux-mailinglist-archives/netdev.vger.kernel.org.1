Return-Path: <netdev+bounces-227875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9411BB90FF
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 20:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F6B189D7C5
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8181DF970;
	Sat,  4 Oct 2025 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="J9Zig0om"
X-Original-To: netdev@vger.kernel.org
Received: from out21.tophost.ch (out21.tophost.ch [46.232.182.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE3A926;
	Sat,  4 Oct 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602764; cv=none; b=OsQHhR4sq+mhen5iBpYmgt7RHHJcez4KTa3O65iTh1LqZeQND1bBAV22lWkPAb3/fHRYZXTYCleAALfoM0iWRZGHPiCR7u+anSyxTBH/HgDFxK0R5QRpQZQFrriki1zc8dcF4FVruQF2Zr4oRY35njNg+wfj6Uakf0PSs+1zysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602764; c=relaxed/simple;
	bh=dhLuQ36EqVPpgpUvPcZt+Uq6tFevtT36Fr+HU1vUztM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oe5BCpP0lOxnCtNoZiPzi9UvWLVWSpjmiMkydbHG5BTH05ieka1oM+vA7UIJxvyw/fqyeMahy2pXwAgEqzfH8/kBzyo2JcR2n76TzMq+2F0wUzfP+u9iSAl7laFTPcdhQ9MafX8bb7K1z4AFqXpJyWcgmw30XSbUEQKGcFMFnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=J9Zig0om; arc=none smtp.client-ip=46.232.182.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter1.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56cy-0022UG-97; Sat, 04 Oct 2025 20:05:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ge0m7y+x+0Q1fWZRZAOH/ZPRQgmovtE9EcWz9JWjBDk=; b=J9Zig0omEQ3siayFSZxWW5XgMs
	tI3YuYIZ8d2Lh87sdPSxHwtzalRfn1zbtjKUJqDhpT6JLTRieqkvH8uuA1x6h5jEzzJs+llsZgWkq
	PdVh8xIIqPSkqwlVLLsMIZ7xbHPV3PbCazpH/MbbbUDYPA+Cc4cy+f2CiM9V2HUNCPTuHpyDaGApv
	ZQ6jsiPrV14x49j7BtcAeIg1zC/wuYPabdMVt/FD5UpOvnARD75FoIUhFVwc1dbhgbJvERQiZHjYA
	qJhkaeVVUN9VO8lQIVx4MIZfdUm9d7Gq9tmoqNC0Lr6Qx4+Sr0mQKBvnpaEqxjmhilROahUS473NK
	X2H+efDw==;
Received: from 82-220-106-230.ftth.solnet.ch ([82.220.106.230]:60199 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56cy-00000001wpX-180A;
	Sat, 04 Oct 2025 20:05:02 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] net: pse-pd: tps23881: Fix current measurement scaling
Date: Sat,  4 Oct 2025 20:03:49 +0200
Message-ID: <20251004180351.118779-4-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004180351.118779-2-thomas@wismer.xyz>
References: <20251004180351.118779-2-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zNBC
 KkXXRI8rBkVaItz/MEFwGYjbvhzWX8Co+5c+eruaCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wdUjFxsH/4KTYIVqFSP1MaBk9W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jhamJNIkblvt3tmDvgtmN4H4BUM9bndab3XlnlqHqi4QKnn
 k14/ADuPHCWFyNV2T+avjL9wVRCXwYDpBqMLHNY9B2Ak8LmqWByQuE4NgLCNvMovQedDpDK2Sljn
 CNAO7NpcpxuVcnpyy186dygqpmiD9OtONQZ4S919qVAB9i6zlzTjcVXthHorhNpu23mgOZsC6pUL
 aCdNIXkTykmnK/9/QX3JlnOAYOwvgs4sv7ykOBxKEjX2P24wm2Xm0Zxro1P7++DuIQUs/5JJj4C/
 n4CILsmQ0SO9CeLTQh8bH8PiEW+ElOMr9Bt+m8Nd+m0udqnheQv58dy/2QaHPHC21IdJntHxL8fL
 MkT6TDHnwvPD+cRl6DbasrEImAe+fJfqFuhNsSc9CgHJcMu7KTfBvyswr4sEMysPur9wmiDBurOy
 6iQJ5124E1ny/UQRZHHLkqd13aH9Eyp21gmT7cyCAVA5VCrGu3mBHZ4hEsTvAClo9mqlcyvJWRfO
 MVjD0Lt1T2BfExAHlwca76VdLw2GWIYs+ljrnXdo8M1GW0TnoMpI3UJ+pvlHhV6a5QjptwQBGybQ
 vv1ToHZWNpcnifjzWnmjtnV75K45oykd3VjIUdJS/eyxyfnoc8x6re2H7v/VN3foTPbrWOwDJFM1
 LKpMibQ88o0ORb/rEGGznznyI8PFeRBLZ0Kc+vvfWass5t8K0zA0uhq/IGZ0cCvl49xdmzHJuw==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

From: Thomas Wismer <thomas.wismer@scs.ch>

The TPS23881 improves on the TPS23880 with current sense resistors reduced
from 255 mOhm to 200 mOhm. This has a direct impact on the scaling of the
current measurement. However, the latest TPS23881 data sheet from May 2023
still shows the scaling of the TPS23880 model.

Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
---
 drivers/net/pse-pd/tps23881.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 63f8f43062bc..b724b222ab44 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -62,7 +62,7 @@
 #define TPS23881_REG_SRAM_DATA	0x61
 
 #define TPS23881_UV_STEP	3662
-#define TPS23881_NA_STEP	70190
+#define TPS23881_NA_STEP	89500
 #define TPS23881_MW_STEP	500
 #define TPS23881_MIN_PI_PW_LIMIT_MW	2000
 
-- 
2.43.0


