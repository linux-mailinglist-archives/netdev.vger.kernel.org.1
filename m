Return-Path: <netdev+bounces-128990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE6097CC38
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E5F2882EC
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E311A2C3F;
	Thu, 19 Sep 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XbmqdyeO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BA1A2C1D;
	Thu, 19 Sep 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762569; cv=none; b=FjTJde8cVOUldgdPcmenSZFzNauV4DDPTh5hT+coPD0DqJZbIr1hCH57PxgcZtLNMjrl2GAXv9fGmtiXeEoCXUd3BfDesKbjvBon0GtrCvJEFHcQVprgPcgvhgwt3TDmvitGpMWMiQ5Y2CaeJbJq8efXso0bHaHiN1T+zQ/F4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762569; c=relaxed/simple;
	bh=Lc423gjDl81fsMM/dZ7Go72powVCs3Jg4uby7CM29C8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TI/XFA3BibNqPiJ9N4E0lC2KyAceCIcmi4LlNnVEc72iDhOC5Pkctd0UjsytiiHEuoKqYrJLyqlmZE0sawJw1xLEySDNao34azegZCFTUBgtx6AvtA4tXGx6ZA1jZESjwpa3vr5hApyihFtt+PHl9cqAZdOPlvADSwWSNpWXEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XbmqdyeO; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726762527; x=1727367327; i=markus.elfring@web.de;
	bh=vC5t0U3EfcwVBCP2ZrQ03aFjdZHrsKaGhmSQvUuG2GE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XbmqdyeO6DhXaW6lMp7DtZMr0z1JVi1Gz7FbOna8R4qE1JNfENfVxYvj57LJP6BZ
	 OIiZbEhyOlEMyX6TRCaXkkf8tZdHV7cHxf0iBMy0RCvdqhVPN9eIZZ0RiWheZqUeM
	 0FrlAqxWTfXY5AiSPI3DTPO+nntSBM3sJIqB3TPqLmrUKWlFpIdtqXRzh26Loly9k
	 r1sIwkTsa1TaaIWO5SlE7zOSZc90lF79jIffGu/WcIceaQVeAoW2YFv3ZDWFA7Nsu
	 zOAgee8JwrMOKhXPhyjh9c2eBqLFvfatjxZoyN2uE9zKOAxbbn6SrAYSB68nGLw1t
	 S4BUc1Q8PxbBDZkPXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1sWt0r1AkA-00K3QZ; Thu, 19
 Sep 2024 18:15:27 +0200
Message-ID: <e7caae09-70fd-431a-9df2-4c3068851a35@web.de>
Date: Thu, 19 Sep 2024 18:15:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Igal Liberman <igal.liberman@freescale.com>, Jakub Kicinski
 <kuba@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Paolo Abeni <pabeni@redhat.com>, Sean Anderson <sean.anderson@seco.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: fman: Use of_node_put(muram_node) call only once in
 read_dts_node()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NBwQFGMxHFxO8UHurIaUYVpHcgKs/6MliAFnZaEdRksyTi4QBUF
 MOLqPmE2iEg9ZsFvm/PpyZ497uePPm/4Gb78n3eDvEDsSQy2+m+MNh8HQ63mT6U1EMV9v/1
 74GqIVcyF3HXb43ALEeTTwjUh6zay4wRjRNaaMVAvWdgkaE5g5LOBeFtnG7rW+kcYDAShsg
 jlC7xeDcE7dzjwgLTysBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:evisc+zGJrA=;YorHIdoacsfu1x3yBWTpS7CD1ig
 ry9PnL6Is0zVylT3s9jjEz6fkZTBhMvz93NUuYezEGHqSdaM9mzIsPnDZrPupbM2HuLM7ZFhb
 j7KqWoQaIJH4/mH6R6426ZikNi8vEZlsoWq0YNlXjpsASun6BX4wfz6Oac91kq0PooXEO2qpY
 MSF/CGJSoX0cm6oLc2LEstGUNyLEHjBFdJQHPP/j6b3LoPzOpPujDcYaAqT/J+KLI3AXs3Pk7
 aXoQUwa4NLoZKrm0/t4vW19MXREGMaNeMAJAhKrIvmFzSeeh5oA55VXGvqVsgz6jcBbp5D6Ds
 s3vH7v5Hb5J4nuUpcS2ypPY8WyABfu9WN+tp33COE0sSPB1+2eAk0gGA0So8yzqAhRbOKS+55
 scUnkzw8WWlCBplxCsPm5VbPIWXR79Pyhlfqof367YM4HtrJQ43aLLZpQXUfzqPai4mlTvL5W
 RQVGTlhZveqh6/gFuwzK39f7a8+iMhRsE5d2zk6XiK339zH78P7TbaJU/Jx4LibNBw9YD9toz
 9Ca2YyvAooBqOHSf4bnPdmI7JaL/cc8X+egj133BTZery65a79F64D25XS+qbX5MPomvexy0b
 i64KpXWjNjiJyb83TahdJ4qf1r7ufvTcUuzmmrhBddB1uoYASFjgXF5Q5Gsah/Q6vW3ON8NQx
 gr73clmp0yVqxe/wCQiSpvcJUNLbtoPKav2I8CuxIxbkH97a01Q6DYdZERa3QWZfwQvAOcbPS
 WleqWDxpr+6+cvMq1RkK6lfnOPhvvx9TmqFXIi5ffPsmspwUnykVOmhIekN1oNk+bOZQXx991
 Q5D7TCtaziNaqDaVW5NXQQ7Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2024 18:05:28 +0200

A of_node_put(muram_node) call was immediately used after a return code
check for a of_address_to_resource() call in this function implementation.
Thus use such a function call only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/freescale/fman/fman.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethe=
rnet/freescale/fman/fman.c
index d96028f01770..8c29ac9dd850 100644
=2D-- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2776,15 +2776,13 @@ static struct fman *read_dts_node(struct platform_=
device *of_dev)

 	err =3D of_address_to_resource(muram_node, 0,
 				     &fman->dts_params.muram_res);
+	of_node_put(muram_node);
 	if (err) {
-		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() =3D %d\n",
 			__func__, err);
 		goto fman_free;
 	}

-	of_node_put(muram_node);
-
 	err =3D devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
 			       "fman", fman);
 	if (err < 0) {
=2D-
2.46.0


