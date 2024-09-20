Return-Path: <netdev+bounces-129073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F154597D553
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FA11F22DF1
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866114B972;
	Fri, 20 Sep 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="S9E0ghCC"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578524B4A;
	Fri, 20 Sep 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835138; cv=none; b=c0cQ26Sc+R6SfxZysLYOQSrbaeBs9hfVO4rnxaWAPcMtq0tPziLZY+GFnPt6Svj+8k87ypwlVGpf1dtuUeRfctsq3d/fc8wzw+UTCNkAYOm/RH5ojTL/iGu0eAnGZKqDzRbzGXjE2PcI7CkRm+JN98FrGxFG3wXb3qUbXG/LRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835138; c=relaxed/simple;
	bh=yXB0hLWCoGo9t46ZIUBlPoTp7WsJL7Abmdc4v8zPONs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AhEenBPFDUFaio/Ktbh4VViXpDQINxvLO8mD5MtggLLH+ZI8U96AtgYXH3Dvhopl2CNgvw2QBF3FwP39w8uISO2+/sC/UP1yyp1TvurlU+7tkuLaUiQ5/xjDN/QESfu0gkiTPN5ecf5H+OIrv9azg+Vqyia3Mpg4JiJ1zm/sWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=S9E0ghCC; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726835100; x=1727439900; i=markus.elfring@web.de;
	bh=yQ0Q90b27hvd1XnO7XfM7gFJpcmvTpMQ3JKT/PSupIQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S9E0ghCCDgxQ2j22iL5w4xH8OXcFMaoc0b8/uwL4xaweTPftxzgHhEbVn0PGlL+T
	 ZCmTh5wM4phTwq+3PDNr2O0TwZP0XeqV4GkyyIDX97+uDApYRlVbAQPgjejOee4Ou
	 Z7R0H7uPV0bu/l8Mn5FgEz8V3lpVsh7pHqfrdD2VL3k0KSQf7wrO7wHRo4S5PjMsZ
	 plfkMCOAuE8pL0C6AO+VIhg9Pne54DHXNM6ePPdBlE+12Z4NOtBuON+XGADLNFfKW
	 IsFP524O9uh0cHkKfmyJG5nJwBheynFD5fjYucGI67/rkjyqwr5CS8KKFJIZ9SltS
	 chNudQvtWEX98dUWLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1sB7LA49Rn-00c1z9; Fri, 20
 Sep 2024 14:25:00 +0200
Message-ID: <9ec752a8-49e9-40fd-8ed9-fed29d53f37b@web.de>
Date: Fri, 20 Sep 2024 14:24:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nick Child <nnac123@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Taku Izumi <izumi.taku@jp.fujitsu.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <julia.lawall@inria.fr>, Yasuaki Ishimatsu <yasu.isimatu@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: fjes: Refactor a string comparison in
 is_extended_socket_device()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Okdpm64eKK8S6mNuMy1xmqVl1ugr4x6gC9MK1j9HHwdxuKHQZsa
 RY+hEDYcGWWOXYes5ar/fhDgI+DcI8fF6Y9GeWrp6kvl6m7QODGLiMMqdit2ytY8rG/Z/rb
 7bmseRZH2ZIx61oMWfXq1vXlqCgGLbvEvn6FiJywWSonUPqjsquNRAgwHfcVZvAB8ho6VCC
 gReuEaxfjHxlXEnLsF3Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mxgz01IBf1Y=;dsNwyQyC54fLGqG4rPQ1y+4caXQ
 kOejPhWuOKYHl2zDncyRqdqUcgsJdKKRNOD/k+pbzB5PLEQd25Wse2F1VU329lCt8gEO8xmn3
 nNCoijG6L/w+6FXQRPW9R96QMldGF4gFuJchzNiBxuL7AazMWWYe0vsmpheEiVHa1n/GnU2zW
 U3Z7KAEXv31qkaqMpoQg98NJdH7zxqnGsYyDTDF/wUGhJM6mo/SUQW9uRQw+T9d4jkUZjsiX5
 IDsamnpN7/wXEWO+SI1HGLAyP1ZR7Ol+T/+0moS8yKt7X6WOg2UrhCVYufcnhTjr4alMq/Eps
 XBGCzy+B5Mnz6h6GHet6QMciix7pWZAIEeqcET6MDYHh1bcJig5ieXITfdQoHGx00aAVWhx5l
 C2gj6eMIiQGB3KFWDGCwietKxow4zvkgdN1cvjAxO1HvW10KjQ2cU/ftH4eySf9I2kZFkXUeI
 ZOCfwzOFYWp1ND7zqW4xMPQoFc3qwHIuza/xMBlT+V/7QG96ixuWjWFX2/2v7tF+H0gknowH3
 jeLbHtOufhsz2edzjjd64/E9ZF4D+xwnDYPp8yTWPNCU+Dv+9jcQUJQygChHfdF4ry0gQ+WOJ
 cAx/U6iYjUtE6eAAyTNrjpmr6vAIF50ERH1EJa7EfqTIwnkVhfLY7v6ERgJPjegV+V4rjDEUB
 txqkuhyeudggHoSYgY9mfGrwplRBnzijaXk1Ov0HEvVHXVdsn12h+Xh0AYm0mHImvuUinDyyP
 njkmx7Pq33NBBk4g5wMAQqD6LCcNAF4e2HdLRvxotxnXyBn8cNwTvuoDqyi8TqEDDJLqI8EeF
 Mirk/MouRC/IrzfXZQ6pPCLg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Sep 2024 13:56:44 +0200

Assign the return value from a strncmp() call to a local variable
so that an if statement can be omitted accordingly.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/fjes/fjes_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index fad5b6564464..1fae30798899 100644
=2D-- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -54,13 +54,9 @@ static bool is_extended_socket_device(struct acpi_devic=
e *device)
 				 str_buf, sizeof(str_buf) - 1);
 	str_buf[result] =3D 0;

-	if (strncmp(FJES_ACPI_SYMBOL, str_buf, strlen(FJES_ACPI_SYMBOL)) !=3D 0)=
 {
-		kfree(buffer.pointer);
-		return false;
-	}
+	result =3D strncmp(FJES_ACPI_SYMBOL, str_buf, strlen(FJES_ACPI_SYMBOL));
 	kfree(buffer.pointer);
-
-	return true;
+	return result =3D=3D 0;
 }

 static int acpi_check_extended_socket_status(struct acpi_device *device)
=2D-
2.46.0


