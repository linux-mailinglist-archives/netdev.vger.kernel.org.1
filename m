Return-Path: <netdev+bounces-111149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178993011B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5474B21F3B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F0381A4;
	Fri, 12 Jul 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cix14nq6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7C1B95B;
	Fri, 12 Jul 2024 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813968; cv=none; b=js0WxOWRtoSyMSZS6rzHAEOWGHD98bs6N8utLJWdtIhABgSA3FL7o3I9VdT5ZWA4GHk3JkUel+HvacpoWNluW8XV00vb5wmfklqtmsY2MmhSDsu+wDy8MygRvPD8Y5g0DdNuOHuUR3APnl3GLdbrf4ZOgdliPZ3caUd53vVRbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813968; c=relaxed/simple;
	bh=4JpOdrHF9yVIaqkkjK73+x67qt6NLBvjC+qQbGZmaIs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=eFPlUDdr514e3dH9knHmUdvaOL09AvtJKBWz3eiX0QWii52uxULmW5Ap71nADtcD3CTRgjwPdTPqKUz2FPJlsbyW2UK6gSnLOQXpTRq9/t6a9W+x38HOwUMswA5B08xHHc1QkDM0ocZG3AM4zZ8dL1bMX2zgtW2eF97LFeLLMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cix14nq6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720813935; x=1721418735; i=markus.elfring@web.de;
	bh=fihKUc/kaj99ERsbRn7CbqhY5SiZXokiELceXjSmV9g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cix14nq66GzkZtyXdh6PdQ52Vd+idDVTP8YUDE4w3KNJ/5XpTPwmTfRo1OcG1GU3
	 uRp+mm8YCIgH817ZxwqVgDyixShkTULs2RhWwY/0EUyRMYQfvyihPfkKI/nM4xsyq
	 0LyyVSH0oWGxWvSh/PAxstj/oiSaib1f/Uj6p7LuHuh1xToaq/dVH6IqufY+V+uxP
	 ZbhC+R/M6/phWtkt/AsgjsN2eCICVpuPQLJnB9hmYXYSrhgLrh3CDW855UFD+LHGI
	 ShfU29XWfeK33PAGdWA3I1Vr0eN0GCKf7CYW1GqvuGMeG7uxMpOE1aNVDVU/Ke04q
	 Gm0UCGwgjViboTzmPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1rqIXZ3XXi-00bNg9; Fri, 12
 Jul 2024 21:52:15 +0200
Message-ID: <fd40e1b9-cb76-4617-b699-19f1f580fe98@web.de>
Date: Fri, 12 Jul 2024 21:52:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
References: <20240712175520.7013-6-gakula@marvell.com>
Subject: Re: [net-next PATCH v9 05/11] octeontx2-af: Add packet path between
 representor and VF
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240712175520.7013-6-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UVFUEjtxhb49QRh8eHS0Pk5+rTIm5E+GbTko8+MUbvbEXPGzkIO
 prHH1DXI4rcdARZlEnnhECgPI6owbmhRPyOzQoCdMOODNxpgI74N7jCQM8EQ315eLwoSajH
 yz8LbzdzY9gM2TR5FEl1Lr2lMcKajZ6NCPYLM23d1pdEJNTxdpe/Q94TyF6EWm5YuN5GzP5
 iX6MdXblpoPRSti7E/zMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9yQUEHdKTxw=;PL8fLEJFKJrcIdKxT2nkYBU/gwa
 5sagHM9rfCKc8r8nDtUMv8jh3W8tSYC40LrEpd5hjt7CWZbLbIMvIAtGLWoy6ujY3SUQLz85F
 s++duNiRt8LOkLyQWLFUU6ZNOjTfXUoigUcpwjgH5UVC4j6r7+NJX/282ZvkTy23J8CiHVdGG
 OoIPUn0GMbauo2iPtT8HjSkTyjR94a4xzI9UEUPGg2Ahl7ZBEMRBkD+OWqsm766zW27Mt07mj
 nYNGK7fBd8+1crqJhpvomD1ixEC9gIkUcAfueMW+sUIS5Fms782iTX/Y0ko7lCijW/MTqTCMX
 VU/KdnWHt9O0zcuQvgV8Wg7LQhgHpzG14a5Ah9ALR9hW8SWksEq9gc0bj77RqBgTqqJuqsJ7d
 U33XertiyKhpd77reZKPltfpmJjIrc+zsNFpQYToOACN4O8HPV39NrgGkqXHEjyhDkcBFOpro
 yawQBAP2jdjftcqxCyQTCpzU0zc5dliAf4s9yzseXb2Dww/dNEPL6qR4G5Su283jFnfTYT+SB
 v36k7PX20CZe9txgUb4HCtZsxNhSAhNiRYxAABV7f/9vSv3r6Y0h9C5vADrp9TiFn6C/EGVsI
 yAo5NtEfS+JbxiCqnE6fL6c1UHxnI+2z+GkbAfV2XRu42BzXvkS0BHkvzJDRN/CEeNTeVbOJ4
 gCg7T0t3YY37zPRGI7wjODl2Yh1J0I0EO0athtbhnepUutdFCys4tFF+75OechXhumyHi5Tk2
 UgeJddfbeMqSevDuYXjjVgejP8Oa1Jym5jZ/vcqNcSevZolhIRJ1sp91HNQPMlAsnNjE9jheX
 U7KbRMKOb84wa4qbXkXdf9Aw==

> Current HW, do not support in-built switch which will forward pkts
=E2=80=A6
              does?          built-in?

How do you think about to avoid any abbreviations for another improved cha=
nge description?


=E2=80=A6
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
=E2=80=A6
> +void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
> +{
=E2=80=A6
> +	rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
> +	mutex_lock(&mcam->lock);
> +	for (entry =3D 0; entry < max; entry++) {
=E2=80=A6
> +	}
> +	mutex_unlock(&mcam->lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a construct
like =E2=80=9Cscoped_guard(mutex, &mcam->lock)=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/cleanup.h#=
L137

Regards,
Markus

