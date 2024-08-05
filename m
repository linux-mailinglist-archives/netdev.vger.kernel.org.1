Return-Path: <netdev+bounces-115763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309E947BBD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547212828C6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5015B12F;
	Mon,  5 Aug 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b="HxBoQTwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53652155C8D
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864128; cv=none; b=B3N2yTqqL/WOPPy2lVfarr8l4Q9zx9ChkqjtN/3BqQhJOUiFVoMiBtM6k2/7yjZfvioU2Ap17MGFD3x0bGOr2Xg2n3O0kMy6gj5pBvlqHB6gRvZQvdd14mycr6XRCsDw++qYAd4AURrm3Pyv6qwcg+yOClnwePzmcqnjTiR27ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864128; c=relaxed/simple;
	bh=ywrtWyTkHrolhdaQJmvhHb0TuH29ZfZXsYPlFF31k68=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=tQ4wnFtFrgk/vwB2Aoa3pjtvz43LtTg33WR+BWunoBBQeNB/0Z1iLrCwgLnBGY9IkWc+MCwVKnBlWRpNXnMi43IGu/JiAuU8pTVAJHvGC1IPKeeK7cR5J45sHl0mwRkWEa6ncP+vWaPsk4h7ylmITw6B2szvBxZGZNy50wAO7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk; spf=pass smtp.mailfrom=martin-whitaker.me.uk; dkim=pass (2048-bit key) header.d=martin-whitaker.me.uk header.i=foss@martin-whitaker.me.uk header.b=HxBoQTwQ; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin-whitaker.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin-whitaker.me.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=martin-whitaker.me.uk; s=s1-ionos; t=1722864123; x=1723468923;
	i=foss@martin-whitaker.me.uk;
	bh=2MNO3RvovrFrgLkKy2lBh0vmYh5cPpd9PTY49aq8YtE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HxBoQTwQsruOzicZXQ6qxEHQLucdhQaMw4RPM3j4Zur8dZ1DnpnECiNR73EdrqHK
	 KV2QpX+oZwqhjZSPM0AReu4pR3GSSZG8BzLbj3x70KS1ZX3KxajJc9hkHdvX7m8XA
	 aBwImmSXmeTvq4GlVjRBPwswSwVKKG4qLaXNMCU5qjuRit63lfagNntDYuAPPPU3p
	 RX2Xo3MX+HIYAmwwX3fUxpp5PqFqXjknGm/cWaVAbb2PSiY5X3C8ztGctjZJjT1B6
	 8Ra4ounYqrd7EpeA0lIoFjTMhdeyFMqkAFLUmK6VKWtoHOqAqmmaPvv+DbFYtwWDf
	 eo9yy1vdiKN2AF7A4g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.1.14] ([194.120.133.17]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MsYzF-1sMAkr0uWh-00tkPD; Mon, 05 Aug 2024 14:13:14 +0200
Message-ID: <137ce1ee-0b68-4c96-a717-c8164b514eec@martin-whitaker.me.uk>
Date: Mon, 5 Aug 2024 13:15:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin Whitaker <foss@martin-whitaker.me.uk>
Content-Language: en-GB
To: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org
Subject: Regression in KSZ9477 dsa driver - KSZ9567 et al. do not support EEE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lPtD4XMmDQTyYZQEpUXp5qLvJBaJDN3IkpY8DTHaxf81N1GmLo5
 tmW1WqSH8zZ0OstT/5adsI77+qsoTy28jG+eVk0qpDir6uSvqF0CrsLlyCMBn5+5LtRbpRP
 PPPGls8O654KHbQvKAOQLbKvUWz4Ht65lKTx/W7ysebFr5d9sDHDAbTsDhgYpOxHZnF7TwA
 OQSQu3D44/6Go+GYJQfuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RIv0shssj6Q=;ZjjQZqGNxYSENHjcbZo7DkX+CKu
 VN+FwO5E0SPBPfCT/wX8fpTjzFApQkM/DBH2+cmzaPTO+DtI2Qh5AbacNjjk/PX9/gUwGveYz
 KjcVFNX9EGCBb/ZrNnb293Uai4cyJKAhZbM0dr5pFNak0N2TWQmdV3qO+mkYiogRCsfO3azAL
 GXuph7G5981xhXtDesrs6VzuId8dygVqoCxJ5QA/EK4FRrukJqgnZicMarpwImvRypV6Woqzj
 lvfY/i1fz5GFLkXr+zvYJ0sRWLLDoYmRpsqpJMUjZscXtgDUOwF9djbiv3kCm5KbJsZ5SeUdg
 /cVMhVyF/tJ6qzK88rJvX+aQinPU1Lqixcck1acSTeTl7ukbqTnXDAZM8zf2wbH3YXm+XJOXr
 Pc9Tom0UdY1XG33EVUud69uASlbefCUtfcmKpMEPMNEf+6xUJCXf1Ph+S72lDZCUeTO8UdSOJ
 bhYd6utOu2d+RQMe3Ono/ymIkVmiq5WyvZCGKcqXWEVr+lDLFWbqdmH08arUT3zq+J2sID0E1
 x4bGUwQ9bsGmer6+7Vmt/Z6CCrYewrCppqh9jLDj5c9WTkT/Pepka4CzFAgwAFtLlNtx5PBBn
 d7G2FY6BrjvfioOVZtxh5Al7IpRGH3698AvvtxzzYr5DTAm1PgAxzhZC98NcLUhtL+V5/rD0c
 fVusjDKxcoWLjuWKRVIfcT/W0OYZd4GttwYgM1gLi5eRjE0WU45dhtcmOsFk2XUcE+SnSM/JP
 mktgx6Y7IbxHgiN9uh1uE0/5cNFu0QprVqsX5vOVaKVLAg+of5ZF0M=

I have an embedded processor board running Linux that incorporates a
KSZ9567 ethernet switch. When using Linux 6.1 I can establish a stable
connection between two of these boards. When using Linux 6.6, the link
repeatedly drops and reconnects every few seconds.

 From bisection, this bug was introduced in the patch series "net: add
EEE support for KSZ9477 switch family" which was merged in commit
9b0bf4f77162.

As noted in the errata for these devices, EEE support is not fully
operational in the KSZ9477, KSZ9567, KSZ9896, and KSZ9897 devices,
causing link drops when connected to another device that supports EEE.

A fix for this regression was merged in commit 08c6d8bae48c2, but only
for the KSZ9477. This fix should be extended to the other affected
devices as follows:

diff --git a/drivers/net/dsa/microchip/ksz_common.c
b/drivers/net/dsa/microchip/ksz_common.c
index 419476d07fa2..091dae6ac921 100644
=2D-- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2346,6 +2346,9 @@ static u32 ksz_get_phy_flags(struct dsa_switch
*ds, int port)
                         return MICREL_KSZ8_P1_ERRATA;
                 break;
         case KSZ9477_CHIP_ID:
+       case KSZ9567_CHIP_ID:
+       case KSZ9896_CHIP_ID:
+       case KSZ9897_CHIP_ID:
                 /* KSZ9477 Errata DS80000754C
                  *
                  * Module 4: Energy Efficient Ethernet (EEE) feature
select must

I have verified this fixes the bug for the KSZ9567 on my board.

