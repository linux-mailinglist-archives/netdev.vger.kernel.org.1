Return-Path: <netdev+bounces-207851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909B2B08CB3
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A526A7ABBCA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5C29ACF3;
	Thu, 17 Jul 2025 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M9WmBD88"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08121A288;
	Thu, 17 Jul 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754762; cv=none; b=h8zuHd+HAxstz8/Hzbvlj5qz351VnIfNNdzzdXdYant+dbeuwQ4V6wzabDY6EXb977ZOcG/r8IyiMMYhbz2mTxzSO/R2ZrEXcZ27YrzaBOggQL5TwTErqePs28GvoEkZ8R6H/98Y7AwGu5EfC/Rox8/wMyDQ2XvAO/Csea9sLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754762; c=relaxed/simple;
	bh=p+jQ8lpHJFpy+DZRWg5Ni/tDS46YYqVmyiSWIJkFqbY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=evA1Lgh8j3XKNzox+0leCNtw7oAEqSs0gyiT6ooLt20Y8OPSY1c5S1j1u7T3RnRjw8g6US67yiKezrGVVLiv7fGbZvI6VXoTLPsR7XJMGjoX8WKdlq/VN49ZICAASwKjcxHmbQFpwci0utNXgsU9HwTayroLyAGypmfryCQ9ut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=M9WmBD88; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752754737; x=1753359537; i=markus.elfring@web.de;
	bh=a9frde+TCHsKKJJekqPE+TXCVkRomw5gr4tBN4H9t1w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M9WmBD88KOV+FGJEEL3REnVKRQJHORo2WC4sfFCXfuqXwrm2+Ht0WEFR1SeiTYL4
	 Ci3W/nsD9mjvuDLbp69ltuiNQcqfjn3Wcy53rnTtrOqc2ZUappiGn3PEppeOgIuSE
	 pycydGixZxpwgOYYGTALaapO/QH8NZkVTJYSpXvWKTPrJ3LOuzhhC5fcY3JP6Fh4Z
	 0RmooGQ5CtiaF9nvB0i4jx6z38GsmJlgL9d1fcrDsS29OrhbVw+3OMBIt+Fgd2gR2
	 uG/BwOvP0fCcaDnHKEf6xTcFKJVLeBkNbkiS3YOlxNbR+o+ZBTYyleZOLUhdIYW06
	 UWMPqaaPb92NdQ095g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1uaicN0apW-00Bk5J; Thu, 17
 Jul 2025 14:18:57 +0200
Message-ID: <21104b21-c24f-4b1f-bd6e-072597927e81@web.de>
Date: Thu, 17 Jul 2025 14:18:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Himanshu Mittal <h-mittal1@ti.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 prajith@ti.com, Pratheesh Gangadhar <pratheesh@ti.com>,
 Simon Horman <horms@kernel.org>, Sriramakrishnan <srk@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250710131250.1294278-1-h-mittal1@ti.com>
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250710131250.1294278-1-h-mittal1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HdKKwwCkdS0uUcMCsjU4EauINBHqY1JcQjAzy+hip0DXyMEwYBL
 lMsp2/fjKpABmTfH6R3tS7aHb6m3nWDlr7rzI1L2swy8rjAduUkp/4rGXsp8EXvzuxLt4ps
 6P2t6Y2+41K9T0RRArCiudKZ/8cr8uof7vGNX1IHi4zZedu3Mxa67swgmgmJ4B/hUqkEuZ4
 Nl9y9bzDKG3SKYOdtSszA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ylv/pdWbBjo=;2DUCA7MBwYkvSDJGexulglLoII6
 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
 ggTBo=

=E2=80=A6
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -288,8 +288,12 @@ static int prueth_fw_offload_buffer_setup(struct pr=
ueth_emac *emac)
>  	int i;
> =20
>  	addr =3D lower_32_bits(prueth->msmcram.pa);
> -	if (slice)
> -		addr +=3D PRUETH_NUM_BUF_POOLS * PRUETH_EMAC_BUF_POOL_SIZE;
> +	if (slice) {
> +		if (prueth->pdata.banked_ms_ram)
> +			addr +=3D MSMC_RAM_BANK_SIZE;
> +		else
> +			addr +=3D PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE;
> +	}
=E2=80=A6

How do you think about to use the following code variant?

	if (slice)
		addr +=3D ( prueth->pdata.banked_ms_ram
			? MSMC_RAM_BANK_SIZE
			: PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE);

Regards,
Markus

