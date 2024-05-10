Return-Path: <netdev+bounces-95326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF968C1E50
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2871C21D80
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB6A13BAC2;
	Fri, 10 May 2024 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W2fa3IWe"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902021DA53;
	Fri, 10 May 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323554; cv=none; b=CUOaxauZsQ8XCKamIFSCwe4cQcE1w6lx1C/63Mqu8pOX+9T9Fuan0NalLbySE4jm7D1gnOGlKCXEN+tnr58/hZRxBYA9XybrTXT9ODwG5prL62CwYck/F0n5XX2BctgC3J/5Br4+Ek4ZteWDN+Jxa6u8NpM6ut010rNYUpPEroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323554; c=relaxed/simple;
	bh=E37wzb7Oc2j7nExYXW6yhBwO5jY3WIFEbE3c2OVZvbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dg/MlMmOmjSR6IBAbIVZb5GF8kpxaFXpqaDgd8zu/Xh9VF29mZmEpSfc26GEtKwCimUiLOoT+WphCaZnR9H5YZhFx3GaAWB8bpj0UonqH7TckLoCd8mmiryp1W5lhsFf7GTh8+38OoTuSMFxU186hby4ZtopYlKEUT4ffk7nA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W2fa3IWe; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715323521; x=1715928321; i=markus.elfring@web.de;
	bh=2A9f1JkH3YiV7UuUkIXTZjRmYrYTSco0Pa5dRp+sG9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W2fa3IWelkldCoyYVac8jhdTQPoIpq5RyMpf7AmrMh0lGs152MKOxPFk0GfWZYNC
	 40+5U8UukREBA7F/bQFtp80hrjQIV+9p+xKaw941I4jyl2/fvlyFiEJW/PrdJKFBH
	 BZA3aKEZNlvLhAzeFMiPwaOxmbzpJHIwy7mPoGP/GVjIS1MzecN6rR/nptywII34y
	 3udC+ndwZoeqpr4ZA1qd6sTC1OHUoan8tOWFa+B/3vFR9990XbtdY20BK0v4wEgiH
	 J5l/BENfusb9noy9AKkxoDJjr9JhfYTZueIm2d8KyI1DvkoxBSA3Zw18inr5G0HUB
	 IEcVLnAr5LXGTQtPDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1sMZuK2WFl-00SQIJ; Fri, 10
 May 2024 08:45:21 +0200
Message-ID: <a9868190-676e-40a4-93de-2a6f9978e89f@web.de>
Date: Fri, 10 May 2024 08:45:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] gve: Add flow steering ethtool support
To: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fraker <jfraker@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Shailend Chand <shailend@google.com>, rushilg@google.com
References: <20240507225945.1408516-6-ziweixiao@google.com>
 <3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
 <CAG-FcCNGsP3FnB6HzrcQxX4kKEHzimYaQnFcBK63z_kFTEQKgw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAG-FcCNGsP3FnB6HzrcQxX4kKEHzimYaQnFcBK63z_kFTEQKgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z0bArOj9RiMuvpRRNSk/7wZyQWP+/BZSS8rcUExDu3P8IiiepMZ
 sNHr8k0qejvxDaR+QQ+mOpNkfcBBNF7DbkDp2Eo+p7QGIZR5Hitd1SFfyCyh7IOJlCg9jtx
 kabwG6cXZ5EMoyGaYSEEr9jcdWkQNRMbzww5l8ocF9MIrOFG4uZ54HExna7TJ/KD8YuX8Kr
 I+Dn3EH32ILdzS3YayQAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mp12yI6FNfE=;p95rRIu2sD/CMUq04nJNzMAK26N
 TBmPoBNnUhwG3Ac5LBBYZXTYlWklwKVrKaZpwbtasJr5XsGh8yntbIMZBzUxhPX92NEdJFcLT
 5V/o36egFnJ49qpY2PB8k/NeFr7s9QPMyaO5XZNiO3DJB/4nPEDI6evCyii8LEfViDsY4xaJL
 E7rxsGh1eOsy3efRIR05YvZkDkflm7u59go4ivYGWn9i2JmvyVfhfdkMJgNBgUVTvCXVjHAvH
 pB9jxeslFNKzPRSm0rvqJFAMMd0j3zmY3g4c66DfpO6X5okFAHP/asgMJvL1GCGWoA3nLtFiF
 8GsEiyuTd4NKPjedaVNtWfLYnxAgKTxgfaMZhw8RjdT9e6IrVDuRMkm/cMXZFYQ2FC07YI1IJ
 AmKx7UsPOHhNam4ujOwuXHmBDnN1ZGZP8InYlUCY0Nrg23dM4Phfkkpavhnbe/G87kiZP8WnT
 ZH0rMSnHNMqV48ZMZKFJbOpOslJ5gz/9nlpL1LTPSO/chRFK37hN9z1blVz6MHduuJBeEgdfp
 6v1yjlfNy6QZCTihTp3VfSnSyD1RfxubTsZtQxClarYR1/yuaQfhMmmjadvMkC/zKJN6OEj93
 6YTPcl1s3hkh49xhpBQvnPjXUiE2Fm44o+43Rv23Y2cGTM1Fo40vrsVsfBb7AwzYHIJyvwHOo
 EPh2LHzCe/4iVLD+KMXTIHNEQTVZvH06QRcZ/1+3g84NipVke0vgDozt8NLWvK8dASqxAxlNN
 OCccPaEs2fzmd8ATREuHKEPVgbWdKLuh/8IggtgXeVyk+XTowUkd+Ty6AgqbEJAxU4x0EbX/+
 1I6awWZyXAnEJ6wkUa4eOtjgVx3zhYMRHSPuj5S2BOz3A=

>> =E2=80=A6
>>> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
>> =E2=80=A6
>>> +static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rx=
nfc *cmd, u32 *rule_locs)
>>> +{
>>> +     struct gve_priv *priv =3D netdev_priv(netdev);
>>> +     int err =3D 0;
>>> +
>>> +     dev_hold(netdev);
>>> +     rtnl_unlock();
>> =E2=80=A6
>>> +out:
>>> +     rtnl_lock();
>>> +     dev_put(netdev);
>>> +     return err;
>>> +}
>> =E2=80=A6
>>
>> How do you think about to increase the application of scope-based resou=
rce management
>> at such source code places?
>>
> Is the suggestion to combine dev_hold(netdev) together with
> rtnl_unlock()? If so, I think there might be different usages for
> using rtnl_unlock. For example, some drivers will call rtnl_unlock
> after dev_close(netdev). Please correct me if I'm wrong.

How much collateral evolution did you notice according to information from
an article like =E2=80=9CScope-based resource management for the kernel=E2=
=80=9D
by Jonathan Corbet (from 2023-06-15)?
https://lwn.net/Articles/934679/

Would you become interested to extend the usage of resource guards accordi=
ngly?
https://elixir.bootlin.com/linux/v6.9-rc7/source/include/linux/cleanup.h#L=
124

Regards,
Markus

