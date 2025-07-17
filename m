Return-Path: <netdev+bounces-207866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120FB08DA4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174DC1A6348A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67A2BEC28;
	Thu, 17 Jul 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lCv/XBJ2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DD1F92A;
	Thu, 17 Jul 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756996; cv=none; b=Y5iwQ0vnWXYBh/yS9hawU2oAksfx/gW/ujZiozzYEUV3hf66ZDOC7Z4bpIa4oEqqoXhqZMy16zVPEqJE1y0lOGJHRT+p8Sqg8xUnl2JIk5octgcNzGHUkLjL3wpU41aC1ve0B3cIuTjSlGjFOXXcBOd3KdAgbDU9G3S/JCvtcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756996; c=relaxed/simple;
	bh=4Coq8EX3mw48zTKnbBK5dkCadLXwl7Nuy6lIYp+dE6Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=a4elBCOYK7ONkSeT+wyVt7MOoNfASOEc81KXQaeGes8NYvqKF7YPPtiNB5Lh+P3lteLXcpbcg5uCpPxawgR0Sll4virPSoGvTaKLUgx3HqY1ia7xUqKebiPbxQ7j3N9uz/88u5XjdFnMq6AwdEA0eCb59EvAueWwx1X8iN0liuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lCv/XBJ2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752756982; x=1753361782; i=markus.elfring@web.de;
	bh=c0Dgq398SWqsv0xGVYrsHLUK2zfzUks/6cy5jNdhTwA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lCv/XBJ2x8MA9jBzvMANgdBzpFvEqJZVEOAMYPbbv5czqaixHrqIl4mX+F7c+RE0
	 M/Tb4gBYU0eJPCzhcBMcLArXijEDliBtqUst5qdIktM+QpCEp4xsDiUVBrEKdRB5m
	 nqjD09AhuhzYmmTDkDOw9LYXPlng3OB3XZIGXWcHBNoj2h4UsOAvu0GXsw9MyP/lu
	 PW0Av0vh5L8lz9Xp/YCyZ47G+BTMnZFm8dT0nZiDJ2ziyu5YsHwrMUrJcmzD/B2MR
	 kqbS57yi5gkSLDRubTtvC43UjYcdccxnAegBcTL9eYd1H8WNU3geHGyaGfvMKvsRG
	 QIUV21CXMbZcUGrzYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjxeE-1v0QIf3sG8-00bPwF; Thu, 17
 Jul 2025 14:56:21 +0200
Message-ID: <4c677fdb-e6d6-4961-b911-78aaa28130e6@web.de>
Date: Thu, 17 Jul 2025 14:56:15 +0200
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
References: <20250717094220.546388-1-h-mittal1@ti.com>
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix buffer allocation for
 ICSSG
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250717094220.546388-1-h-mittal1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dvFpaitgATAn9Spja7xoTYCvaq5BvkujF8BPlDw5/Gm7fRy8aiH
 uSzSc/ZpxTMcSBrIl513g7PDjhmkSZk+GlDF3xVPz+ICNwGWe1exx79CjW0XOvT9F8UXueo
 uUifKtgNNbxDDlLdEDlUKe4y4olEhowlpOd5HqmSop8hYvLiYpaEmcn8oXtkpLlCwbN4qG5
 k21Z+2oTFlFmaRiKpPRsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I7+okI5HW0I=;KVc7WKXuK/RBHn7IP17dT5Fj5nF
 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
 Swhho=

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

Would you like to use the following code variant?

	if (slice)
		addr +=3D ( prueth->pdata.banked_ms_ram
			? MSMC_RAM_BANK_SIZE
			: PRUETH_SW_TOTAL_BUF_SIZE_PER_SLICE);


Can the usage of the conditional operator be extended another bit
(also for the function =E2=80=9Cprueth_emac_buffer_setup=E2=80=9D for exam=
ple)?

Regards,
Markus

