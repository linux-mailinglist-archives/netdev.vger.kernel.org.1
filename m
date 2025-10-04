Return-Path: <netdev+bounces-227876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F45BB910E
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ED43ACECB
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18173283FE3;
	Sat,  4 Oct 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="HrgV/qn4"
X-Original-To: netdev@vger.kernel.org
Received: from out10.tophost.ch (out10.tophost.ch [46.232.182.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B467260F;
	Sat,  4 Oct 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759603260; cv=none; b=q1ekXwu5BQOfrHWiVcUC1bd7i9uPTV0Thd8RAokGqpAOHb8humWKLKLDMHdqXR+QxMd4SGKyZSU7WjKgMEho5Zgg1kObKCHKU1xL7PeN5vvYvJZTwLlSyFPqepZ4k9IkqiFNmu+ORjezY45HEd7xUXHZVUDK3WxGjM6uVZwlCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759603260; c=relaxed/simple;
	bh=pMJSuCl+TAn4TlJ1+CiVZJ/lbugUWZ++SAVWt3hVpVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZhayyImTpF3u4/trN6afRs1ntwI6t3/vmg15muUx08vEpNeLfiC3BKAaXHdDlM/ZPO+bQexvFqClYcHLo5xR4e1bKoHCN23wwuV5zLq8dg0EmE9p+CjB9E5XY/VJj1xxWRqCm03ED0A5/fCNjwGevZsIS1dusLh+op+XUbP830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=HrgV/qn4; arc=none smtp.client-ip=46.232.182.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter2.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56dQ-007JNM-7o; Sat, 04 Oct 2025 20:05:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=El79h/tKOjOUBJeKnSvCr7/LIlvQMxmr8FHQYThloIY=; b=HrgV/qn40leBtb5c4pMoRTIJ+p
	HoQ0bTOShVg/derjWVMFRs9hL2M9Z22r3iTSzZwMtSkgMisVFQQ/kHlq/4Orc9o+Z4HrTE4aNhA4G
	/WCLpklKavKYa67Enm6Ex+b+EXTFbuEaglO61WdxZdHSfWjJOvbhtsvE7lE6c8wE3mCHwg3tLW8pw
	FXjipppA3N8qu10k1i/Juu4zAVvrx4ozbq2vToIkEzxTTcyIll7P26dhiyGBaykp7pHo+mtwpxDMb
	z4/jsQELRntsyM0dXj+UZkIPokSfZW5+V/U/MgVvL6cu7tOSVyxxBBjpa7IDDXNS+iYD63YzC6u4I
	R/JEbyyQ==;
Received: from 82-220-106-230.ftth.solnet.ch ([82.220.106.230]:60199 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56dS-00000001wpX-0lQM;
	Sat, 04 Oct 2025 20:05:31 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Date: Sat,  4 Oct 2025 20:03:53 +0200
Message-ID: <20251004180351.118779-8-thomas@wismer.xyz>
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
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zAy+
 i6SmItLXxqJRd5s9GHFwGYjbvhzWX8Co+5c+eruaCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wdR983ISMXlZYfkTQnVvsLb89W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jha5ZR/nf5efcITxrfNKzy0W9Bd37g8M9SCqD8uOq9nJ+Mm
 AyVp7BgHET6y8CCeFlQ7QPOIjlkSAfAYMUguLL/iJ9vYqKPILmSoZcvfXhdPMA/OB6L3DS5gd1SE
 E3USj80Z55NePwA7jxwlhcjVdk/mr85ytrd63MVeviF0i7IZfcqGEigUra+zu74YMVqBb/nqBf/o
 O9ENx2nriip8WhgYbnEnhEbOEzk5yB9ZHNSFnOUf5Q/AoIx5sTYq7iOI4vCrDScUfr46OzpJNOSz
 cdwyiT3dKxLhoxcmaInYbR5vlqGvSe+dDtUIqP45C5A7LqP3b1xqO73zx9HsLZFTQ55zlz9aPc+7
 R744868L+j9WjFdaiDCoaRMMLJurWmXEnoYHaIfVaCHpEB6cFH6WJxE4ZpdasxsGznVQ8gQCuamI
 BuRJXA+qrcHrLEisg/Q99QAygcqaTSs0HzwuLL0f52h9QlQSo1zEvYJi0O+7gv2MANPskD2hG/WB
 q49TQI4s7Zk25QzEh4fdO1UVosIGSxnPvA8wgBLtVZogJpSXh3l1gykJmv2lNIo4lDSAwCBIOnEB
 yG0AYw9A3oZxIE5agCoT+NXj8sDMDsREHLIWEHS8KIc6lVqPCo/SwFbRV8YvNj9QUec8VPZi63hI
 VDdSxAySkA2y1dwxX/fOLxBYDd5BmItKTzNBSIyW/mb8GD9YbxmVCZr9pTSKOJQ0gMAgSDpxAXyp
 F5LUwHZNY/+yVAGZIWgbevr4I2GfjWs7NecHzbPrZnM57PQ4Zhz+lPAiIO8rB9tRBN1MQm1SbNQ8
 mfig9wuAva9NlDz7O8ptuOziYJtS9jihx+Za/cV70jOJzN2r4A==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

From: Thomas Wismer <thomas.wismer@scs.ch>

Add the TPS23881B I2C power sourcing equipment controller to the list of
supported devices.

Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index bb1ee3398655..0b3803f647b7 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - ti,tps23881
+      - ti,tps23881b
 
   reg:
     maxItems: 1
-- 
2.43.0


