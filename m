Return-Path: <netdev+bounces-106100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E34914970
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22051F248A5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE313C66A;
	Mon, 24 Jun 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EIqP6pjV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537513C3E4;
	Mon, 24 Jun 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231135; cv=none; b=l0yywB42awTSoWdYu4xfF7AlAAyi8n7yGk4fULq8iNNhQ19gBoKCjggShlJBMHUi8PVkNx8Nr5sf364KsJS350s89lDts04gYLUNAQhvss3fEsNCFE+hrMryevGCYl8qG6gEPXHDglbtLvAPUcGP/ldHIIdTaHi5LlzFthITWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231135; c=relaxed/simple;
	bh=esPjEXrAGIEX05PKZeXpgoH/TmziWaZFoodL5j7MfXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FzOgUQQkc4cPQ/Zz+Zzj+1tGk3LsnaFRJnGuf+1SSLh1v9ZB92PEgug5DH9VZ/HasMfMqLxUPUtchGlRiKefuoShJEegZ1LAozZixrSp/Y/TG9kg2Bp70CHxkua0j7QiF3EVG/qsEzbL0QRFn5e5xOIdI0Cx4EC/xSEC0Ik8ry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EIqP6pjV; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719231098; x=1719835898; i=markus.elfring@web.de;
	bh=r2AUt2mr4MkG1kpJMdkpMlA9nEI7djID7MVqxTdNCPA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EIqP6pjVGm4ZjmVUkgMKnvmQvrIc1fCvVc0Nsn8YEDPN/CEYAPktGucJpDf4xV+N
	 oX/gDExd1wc10yXixauEGAlXGMA7H+69S4DsPTn01pOK3plcHwfelU7ykIbkzdR++
	 dvpMUab0xOwTRsEuFopFfVUXEtZj8CK9qm2RYId9aJAZD0us9Hhni8r8kbvMMouqa
	 MIVu9ET2ZOsmQaBXH+iYDttay4EYvhSBmSmsTsXbBpLlsWeIwNEKbdl61frWr2d2d
	 87kh8v+YBnbsD3DVxsZbjCUWJqYlrh0KgspbRUB56hq2qzc7O04bHFSFWJN8spBD6
	 t9tsWG0SVsvufR4zAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d3a-1sSMO93VAO-00vJrr; Mon, 24
 Jun 2024 14:11:37 +0200
Message-ID: <db9c90e2-0e3d-451f-aaf1-bd5d0aba61be@web.de>
Date: Mon, 24 Jun 2024 14:11:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 1/7] octeontx2-af: Fix klockwork issue in cgx.c
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org
References: <20240624103638.2087821-1-sumang@marvell.com>
 <20240624103638.2087821-2-sumang@marvell.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
In-Reply-To: <20240624103638.2087821-2-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xABguZK7h/LPkqzJSWw8/2FWThmR3bz1iljauqQrMVKBTeao0aG
 8XOrQ4dgoLlOoFl0letbf/baU1eVYsmVTNxy1hRrJCdp74VA1ocAXd86kRbW9b9eFvwx9gB
 3Ho/BywAN2zgzIJKdxBAYOyQI27DAJmzsk97AWE5DJYW4RgY4CMAtb1r50BgKW2Wrc1hsfh
 FTddl1FOARk1uw5po6SnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DkpRjsyBh8M=;Q/eo9m0CjRVEGPbdtX7iHW84CUs
 isCUNpsIc55yYDoqPIPuHeTy1Bq1YMY6DhxEX/kRAIyAJGli+8wtqxLMQNKhJ8BbDRYzOqoQf
 wYQ7AH0WQcnerqUc+5qPNI4sXMh3KrbiPyHxrpwnxsANOdT2JyBYkbJ558D2NizMNMmGgiwZQ
 W901LVQt0b+Vud8zEUEohVdQ4geaFTylEdhaJNUf3qTovXuoVVCQxgSYI38NczsHG6f5viMMt
 ZGxhdGGcR8JbgX5rkys3IvwkLJpNlXNANHB5lsSW6N3WnzGc0aBZ5YflECh0J9SHJcbkViwgF
 tljsnwuxlCIDtZZ7A7PspHRW82KuQ2s1cNddo04rKhgQwKrRpPRbSxBs2XTp0oPfRpBlFHMlr
 4wNNKUpYpRKhaw45xmEZJOp5l/bMQZF3SB/20n3dQ7lyfwjHxkfXjnHEIStt8puV09v1XJ3SV
 pom7+Fu4gNXJdB907D1XXMs3nCT6kM90ayF1tD3O2+QASy/EYIuyBoW8MluE21qSul9iFVFRf
 nrcrheRbgBuIddh1aPvsmHQ3G0qsyBFcBLtjcmbexSz8GInMWclMr/e94WEcIQmuqawyAT5p3
 xq3E79J10ImEv7gh5IH0kTp67x75DK8hFPMCAz76WgqruyoFoHjUEnxMQGJYlIHXCEpxdOFHb
 rqzOhCq76SOsDNRfGI1ZAyecuY4WkeLB4lCBBu+hwDsEbQh3QRSEGcoNIztWz8lClhDqMn/Xr
 hQU1NswjkS5E7AMbgZCnZnFuSkQ3xq4DcifzhA1bT8OmjuCMyCgYdOrjImFkW0Uv7gTJ1ODAg
 fH+Hbj2Marvusyna6K+N+FW09e+kzAB5ImqadOIBQO73Q=

> Fix minor klockwork issue in CGX. These are not real issues but sanity c=
hecks.

Please improve your change descriptions considerably.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n45


=E2=80=A6
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> @@ -465,6 +465,13 @@ u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
>  	u64 cfg;
>  	int id;
>
> +	if (!cgx_dev)
> +		return 0;
> +
> +	lmac =3D lmac_pdata(lmac_id, cgx_dev);
> +	if (!lmac)
> +		return 0;
> +
>  	mac_ops =3D cgx_dev->mac_ops;
>
>  	id =3D get_sequence_id_of_lmac(cgx_dev, lmac_id);
> @@ -1648,7 +1655,7 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
>  static int cgx_lmac_init(struct cgx *cgx)
>  {
>  	struct lmac *lmac;
> -	u64 lmac_list;
> +	u64 lmac_list =3D 0;
>  	int i, err;
>
>  	/* lmac_list specifies which lmacs are enabled

Did you mix software development concern categories here?

Please reconsider your selection of change combinations once more.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n168

Regards,
Markus

