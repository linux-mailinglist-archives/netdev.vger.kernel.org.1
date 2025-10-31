Return-Path: <netdev+bounces-234633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73AC24D09
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A8BE34EBE2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11DE346A09;
	Fri, 31 Oct 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SY5eRufJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD692335557;
	Fri, 31 Oct 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910950; cv=none; b=Djqn0E2MdQ9X3kn+IkVuCP8i4HVjwOk38Kv34QNIArzVS2DODScESj7cS5jaHOnyBQTtFoUcoaFa2535n2p5gfHJF4RH6/870gppynG1/9f5dk/zWle3CgyvNQ6QMlKykChcGeJUm3lhpKUD/SbNGd2fxhTmqsbkR0cESteOH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910950; c=relaxed/simple;
	bh=YQ6PwtFXbaQwhsnlM6RHuhQxFDME8QV0xiknAS1hJNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MyzoYez0HYueAs1Ee3u4cSYtG/RQDfulXWF3dfYwYcfwLV7Cz7hLLPXojwfd5MYZNdKPZwJkAN1zr5mHU3GBNGpwsy0tff7DZKvXqMS2+6sVip7ATZ2OtjgSN4Q0uPW9JoCBlTdmdfNi5vC5d6gXmNh06x4V2PU/HpjxeVw5piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SY5eRufJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761910933; x=1762515733; i=markus.elfring@web.de;
	bh=LIuwmjED+t2z+KDKUv8Eh5krBiiaen7sVq2Zq/jdSwU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SY5eRufJ7Pb0ZtlEyF6l8rSXaJvF2Ne6ES8h0gJmfkUMt+pbqcQLoqw3xloaM5KI
	 m+GpSi1YsKtlkrHmiyx0wAwVvcP/VPhxzSkMV6dEW2DSWwl/QwcTZHHXc7krdb6SO
	 v7y2x9pZ9mw+dkWrEJwQvM1e+qGdtAaP2Vkl4SVqLfvonUYjUXF33oZQq41RsKxM7
	 ojxvVeYzYQsJa2dwIm1w0AieSfx2WjATDHu/IY/7KHt6TMOg6NfmiRqrsjtbd1O2h
	 BOq6at3l36U7/FrPHr2TM0X8yzRo/d9iDTQk0zu+nONMyjcU1Lr1nC7TN3A7BK05z
	 oIts+fWCBr027Cu6RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbHE-1vxAta3M9q-00auAZ; Fri, 31
 Oct 2025 12:42:12 +0100
Message-ID: <093033d3-0ea3-49a0-83e8-621fc4fe1d24@web.de>
Date: Fri, 31 Oct 2025 12:42:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 Chas Williams <3chas3@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <David.Woodhouse@intel.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] atm: solos-pci: Use pointer from memcpy() call for assignment
 in fpga_tx()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YuRQqTE/gUfjHYEOzXOz5Zch2p9YXCmHybB97ONwl/osGzDq+Qm
 SY4ZAsWssp4sOpNIhyPtwSAWzXcmEQCgd4SVFzLShCNJQEJwuiEpQxUcfmEP/6etaTQnYRX
 duC1AyDt1NEbnEPaf4cG2mNVB9wu94vXUlHA17OLM6HuiinAioEOwIRHm7+2gmStXbro+AE
 ZvSBeK4q8i25ezy41UiNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yOe7G9YCKVM=;4SxOJKoifK+RClfI8uVCLgYoEWw
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 12:30:38 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/atm/solos-pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index d3c30a28c410..dc4aa803f3d6 100644
=2D-- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1087,10 +1087,11 @@ static uint32_t fpga_tx(struct solos_card *card)
 				oldskb =3D skb; /* We're done with this skb already */
 			} else if (skb && card->using_dma) {
 				unsigned char *data =3D skb->data;
-				if ((unsigned long)data & card->dma_alignment) {
-					data =3D card->dma_bounce + (BUF_SIZE * port);
-					memcpy(data, skb->data, skb->len);
-				}
+
+				if ((unsigned long)data & card->dma_alignment)
+					data =3D memcpy(card->dma_bounce + (BUF_SIZE * port),
+						      skb->data, skb->len);
+
 				SKB_CB(skb)->dma_addr =3D dma_map_single(&card->dev->dev, data,
 								       skb->len, DMA_TO_DEVICE);
 				card->tx_skb[port] =3D skb;
=2D-=20
2.51.1


