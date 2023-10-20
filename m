Return-Path: <netdev+bounces-42999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61D7D0F94
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625562824CB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0AA19BB9;
	Fri, 20 Oct 2023 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="IvFgiRPe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF7199D3
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:21:23 +0000 (UTC)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2353106;
	Fri, 20 Oct 2023 05:21:21 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 7D07110CD493;
	Fri, 20 Oct 2023 15:21:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 7D07110CD493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1697804476; bh=MeYVgElruHgoPzcT+C8vkLtksDQKssoIBbZPZzRGhUY=;
	h=From:To:CC:Subject:Date:From;
	b=IvFgiRPeE2SzWWsBX+hylfJcub+A+eTAHHCkWRS87osccwTslTqcPvybB7V7jEF2S
	 iOxdQrNhrnjca3jC0A2X8cNTtjkua5ZqjqiRBrqoriPVF1T0dThQkWe0uVv9FNqLU6
	 5lK1W+g/6uCU7rbok1xzve78RwJG+S2y2jZ7EqGc=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 7A762300EAA4;
	Fri, 20 Oct 2023 15:21:16 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Chas Williams <chas@cmf.nrl.navy.mil>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] net: atm: Remove redundant check.
Thread-Topic: [PATCH net-next] net: atm: Remove redundant check.
Thread-Index: AQHaA0/sv44EDzb/ykSk/HUfw6flbQ==
Date: Fri, 20 Oct 2023 12:21:16 +0000
Message-ID: <20231020121853.3454896-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/10/20 11:07:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/20 09:36:00 #22238310
X-KLMS-AntiVirus-Status: Clean, skipped

Checking the 'adev' variable is unnecessary,
because 'cdev' has already been checked earlier.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 656d98b09d57 ("[ATM]: basic sysfs support for ATM devices")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/atm/atm_sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index 466353b3dde4..54e7fb1a4ee5 100644
--- a/net/atm/atm_sysfs.c
+++ b/net/atm/atm_sysfs.c
@@ -116,8 +116,6 @@ static int atm_uevent(const struct device *cdev, struct=
 kobj_uevent_env *env)
 		return -ENODEV;
=20
 	adev =3D to_atm_dev(cdev);
-	if (!adev)
-		return -ENODEV;
=20
 	if (add_uevent_var(env, "NAME=3D%s%d", adev->type, adev->number))
 		return -ENOMEM;
--=20
2.39.2

