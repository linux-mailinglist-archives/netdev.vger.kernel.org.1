Return-Path: <netdev+bounces-244836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F218CBF9DE
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE1AD30141F5
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2712328B5B;
	Mon, 15 Dec 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Ojga1g/B"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9ED328B47;
	Mon, 15 Dec 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828674; cv=none; b=Mx6rNXF41rL4L65n/CYrzthJvPsPjx0c9NGtr5WpHQu8MLpxt3E/jJ002MC7nqQWiW9uZTxSreBCy6sDQIQ9Avv5iOMuRojh7SdBIJ23djpEb16fN94nc5Gju+DM9h6KZDFvC0MpBkFCP4mWraIvCStP2keIr3QttNpbL7WqI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828674; c=relaxed/simple;
	bh=h+GyjR6e1wRFKfzRx7bTCrAHbKW3ZesAaUv0zDAoVO8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=d/oii7wjiXUnNazVFrE8YJm8sq+EAl9QKyIcCKblGEwFpjxln2GTLyhtWfV+qVMCfd9X4DdEgV6T3S1CDGey+/epaQVbcLSdSaASV4NS7ynS1IGhZHAPQqQRokfyJ9dRw+xY4GdPcxJPcINQW15bVvWq/ePIJQL/dM5jomcxerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Ojga1g/B; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1765828664; x=1766433464; i=frank-w@public-files.de;
	bh=bTlyosS7RsRPkdG1WgaA3rjvINz5FKHU/3WjkEkZApM=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ojga1g/Bry3BIm5s15Yhinm4zh5pELb9MryJV7mtt9o4ESv26gsBmWYF3ojIhJE7
	 aWLFrGg46R8w0+fENz17siVyPt+ddQWqmtzJRMHCgNMugDqXWsgR5vqdaj4/klSbj
	 +aB6d8dIt3PxRUd1W+jGqwlbAWh+ZtDpiCLSSoDj0WtV1nj738NNYkNykH9okfNY1
	 hKn+Stag6JcWJ1Op2EReSWbt1mi+TiXjj4vgSSl5cR4bOarqFUCLXqrHnbwdgkW3l
	 +Z99iJA9BfbijOg6q5B2uXKb5aeaelOoxKU6tK8+BLJJnvYTbSFL5TVXFOjVQOzt+
	 uMbzP8cb0bIX8EgddA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([217.61.145.36]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MWRRZ-1vTlnX2S8h-00Ny9N; Mon, 15 Dec 2025 20:57:44 +0100
Date: Mon, 15 Dec 2025 20:57:40 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: "Creeley, Brett" <bcreeley@amd.com>, Frank Wunderlich <linux@fw-web.de>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>
CC: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Mason Chang <mason-cw.chang@mediatek.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_net-next_v3_1/3=5D_net=3A_ethernet=3A_mtk=5Fet?=
 =?US-ASCII?Q?h=5Fsoc=3A_Add_register_definitions_for_RSS_and_LRO?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <d101cf0e-bf7c-4aa7-a444-f6b61a1854ad@amd.com>
References: <20251214110310.7009-1-linux@fw-web.de> <20251214110310.7009-2-linux@fw-web.de> <d101cf0e-bf7c-4aa7-a444-f6b61a1854ad@amd.com>
Message-ID: <033E8AC9-21D6-4707-AE75-37556241CC52@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udmE2bC0mtQBR55i/zb65Ddv20tP2/tgoQqzo35LqbG0fH1xgv3
 z2vvMV6mZMtWhTDp1MubhOxKs2wF+ZPXTHO6qFzDfsvbKGoDsU3rygDCJx/eSPdh2l33hii
 ifwc2XjrW8vrqZTVsJ1NVC00t+ivmfnVzWOdyuG0veBEAyoGv9FdSx7pf4B16rdPRp3fMWR
 A04dCdHQbiPqmK/JEmP6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rhoYV6sbA4c=;1NRagGGJCC+H5lDG23hh1TfNk1f
 MPhkIEC6e6dtXaKn2ccbUJccEqMOORcxD/lLT8zaw6fjop7mmIuH/8y6joAW26BdGc/1JJUdj
 gGyEqvjcpW4M/nrGSHsUoUfT1X2/MEnoHBoS5+WyfMdDrYqOgaS0Fx6SB5loOMOxNys7l6wPC
 gOBR0UJ4J/7S9HWMZMfLM/pjUJ84emcy3zCAxy2LqsYszghd5dYOce1MxPLZ6WyS3yGQFwG7B
 UcKu/q7WiZfSEPKgqFTbSQ6stT84WZ6sJ/XqTMogZWQ9x8IFMOPJ7rG9RW6CHEtP6Kk6Ew4a2
 mTcHmva/bHMsdk97pTYRZ3ZjhzUeezSRXfke8IMAglpmq12pD6LC9tIVrF4So5y4jTIDumcsQ
 /Ei0xCWhiAl33SC+WUnOoWa7NvdowYMNcvBTtToNNJTTUiSAU5KVJpXob0peLV+dPKd/796TR
 GvsCZ7VZLoS+Xh5Iaes4UwyYkvcaYLUHpkulUWQNkZhh0gl5J3CKugMkQxKgih9ue6qFRdPUr
 A2VHxMYlfICoLLwssC2aXIeie4D/JqFsfvsV6+YGOLnWnn/K+3J5lcFFvfN9+8Z3W97YPb9zl
 D4Oa/M71rQOtmd72QVg2f8u8TpcnxX5uv2QLg9inAWOSyLtkg7FBdXMcjru3jGsr+slI9TCOJ
 QQcGT9zkhG3qAX1zez1/PU+ZuOFHD/leh604gv4siDWVAydnEyB+ewdGt00oaOX+wjInM3amu
 kMN94jxPb7IpvkCn7NEVKKa3A6IYWMzvToeRGG2nDZXeUy96no8wsfJlrJnOeNps8wqBKVPyS
 X1LiTieW+3/W+6Y2k1t8jmW/QsMQ2yND8F/O24qbnraI/rWr7klgrtYrgphk7MyVKE9dcRszf
 rhbwU3D9U2CLSmJrrPq8ktEIQ5vCeb0cep33+CfxyU2dr6/ev7VNta+CuQ5CsonM7/28VrDa2
 ERuWeih//gvwp44GQa62TfyhqVI41CpVWxjGyo2AOdiMTEBz5KxP3EKnsu9u7o7ZPKecEUd5q
 2RDJ+m/BivrxjCVlud+OAlO1OfNmALHg4M+/T3RSyaFGgZDOy0OqhioJyzez5Bgjc5v5Ahf3+
 /iz0I2Mq/2ES5AP50GpRaUrGzf/HgMoSBVns4kaZcET84ui2kjx+hVJDGZJBWBy2yeLRNaoNW
 Wib/trn6WUSEQxDkT0Ch6HFPumoDq1ATcuDJTm/EDtIXwkKcCzqEYLNieIxbZjHMMIzBIvtPy
 RBHalwyS6DUx911SGRt6v65yl1E3amo1fDC02bXtM5/n0thwB+9dGzRZgIqWjXeHPA1xlVOLC
 G422oJEfQSYCasroiJZRbMIGkDjKth/s58uRHU2xfz86gPNaSneV2S+DBLF6Vy9B7RGqo4FqA
 AVgx68c4f8eAewbFDEnBTzSnLFPPFYeLm8mCvw7OlViDZ/6tpHquAIkpcP1dQ9kMk2/RyTCEp
 ITpVxkqzVMsDl3uXZNfsIqcw/qJ1ELAWGW0XrLlLtveezRwgn5LztwygJsivCSjxdII7ukPLn
 C1vjOGFGQO+L6NygtPpUM/J4KH7gwz2Qq7tW+W4QkI892ut1EoGNxkqTrwXpKhUSAv22yxrZg
 uABfrkWJkcAEGPKYnghd0EaMEHvTk/AYQumSEwuaPDgvXJLOLYkC9WKAMu88RxTHvnOYOqYBg
 dCUMvkDT1kVrAkOvP41EjAOHCnYcY+iMN79NYZDkFfg8RfIo7/z3aFZQl8DRKvAKqxEiYMkC8
 9DMwgn7Iy+V6ShvTTf2K0POp0Um3rbnz27MuArcsPNxgkMh3oK4NuZw2MP4q6buEes/bwWHCO
 N63nL0uJ1fxWDRhJZJXOAo5VPQQ+PCvg5nQu/phyVlGSilzTAznocu78TZGvYL/a8mNrbYj87
 w6RF5TmR3lXTt3+8g33dNgvpbwtLp6+gfVQetyIk5eLjxT8wDUsj6CUKsSP8cAInT3xh28ssu
 B7p3rRqQWYAyNFPQN0noO8cpBxpTwojg1vi56Ne/NIR0zs8SP9d0hpljFG5AX9dQ49hfj1pfV
 C8M6wGqyC+pGt02StGnstE9ZuQAWDReJjoXXXHLQEweGoqG83qUXAf4eNi71YtZTospxRNSHM
 7KVhHuZggSBcrG3MD7jkitSEO3avWYLQ7jdWoCETsb9lQn0qrq1fVSrSZPu1YDn2zKl5gneks
 7PDXhKg4OLvJOxZ3Ww0dpSlLG9Vz+VpkROyWZLeotv9eG6PyGyMp1YuNVTkF+XI2qemnZFgcF
 CkYs0mZsgEU132sTUeKLr9b8lka/+e3TriP3kzEEhJU8YOGbmXNX23DVz5oQxhXC5vc6ZwgM+
 6LMVnhVsxbXFfSkGu2cmodWU4i6M6Y8YlPGI5iHwCzulhYvbkGbX4obq+CG4cO4Hhcce+3xqq
 WN27j8dZt4yr7qMr5c2Th+EYBjQCEs0C1i84EtJPvH/9x2Dxu4xP+quIgHIhfUBi0bYv8D9Sx
 jmG2onedu8NBXX/GHFwMuYKdu6U6aE+ITd3q8FHwv1sFP3VHbkgPd/28HdLVZK8FEmhNlHeDj
 Yr2K0O692YJNyRL++B7lIBWsol329+BN4GwWLBqP3LDBYHzr+xYfTiyWaFD7b7LNJJdqSlkpf
 6twiA5rc2YxJSa5Mf9DO2xTTzmKOJpy2Pv/khb8iW7ciJMAkYMswj2ZRefiNaEtIQlqw/PjPn
 thlbVuMs9yud6lEO1/aVSqJzMZ1pkfj+CNLyfxEmTVDN8G5/MKS/SQSB4ARRX51sg5dIY7wOU
 v8eZER07gB2xgW+trtdsLUoZ5ECFbFQ4pcTtPyfNcMlmcwhD008H5La3xgKuWOJKcT8k+8+dw
 eYdObXCtkD5+9FoxaxgXJpon2mkJC3IWXejleZhW+7ew4nojhPU/zCmsPxCxP3/pB/2/tclnQ
 Zj26FqK+N+dj7f6mZ1kIBKO1t0dLzQ95P7UYt9/XWDbzjTQwLj7AtWO2tkcdW7Of3PA7UW1kZ
 npv087eNZtdytO7aIJrap6L/RZ0WXGKig803gA8yrc0jP/vVvYM9Ok4CFzteUpsFL1y0iKFfw
 W6dEp9lci38Vl77fYJ69gvBg0jzisQ6Ft57giifZkSs+LzOWw5DtRIxmuIzy3KmeFXpwwqqwL
 uoDW1Pt04Bu2Cw55g89LBr5jn0Gwe/DqtNQz4icOIawOKjvWK+RBSN6xUIH8cMqwvmMeWmfVs
 bBn89F/cD8Hn82WCxQAODiRg+IMAiUok8HL8wDkZf7LOJR91z0ubUNCMmoqsbCoJLBGXAuXRU
 BPFXovKobz46iq+fwEiWZlwlaX5tf+4xabBzO/l553rfB+90CXdD0qBJfjlPL0f8BUxZC24px
 e1kdpVOf+97DE5s6U+loDcD7z90S7yx6xWTyUHPanD0DRn77vtjvMep+ExrXK2vq+np4K4OmR
 VcW3qtd9ThvbU4ieMPQTQ2w/Sh7dbYIalHkNuud541ZJA6QHdLkXMjeSSdNO4gTO/FMaVd1Nn
 Ooz+P7eZIlk/gHVEDRxnw5HoJ0kH9VgoZh8n0crG0QtkLmg/tuibxXWv5dJ67fYUTWd/j6Af5
 KBWX5f76BFgvVADjYjcn7yHXrIvIl7aQIAafkF2t5WEA1KMqBKVaDwId0s+5VW4bOyUVrYMth
 2SWC9BSc83YvVsLL/4R9nz18qYT67yStYlwbzNyCcwF6ljLUxbfN6npbZdDhVwi99+r0WaRS9
 W88PZX7Nm2Uw0TcJDpLtyvGEPX+M65r92EIaZYSG6fl1dbWrR8bgswMfW/o+y/ciWv6j5bQLb
 Ux89pv5WaT/yYTwXC7fcdJxyI5TOTUgygtNibl2tUYQprb3kofdyhvpdg4XFLxXJsMon5aGFb
 ufuPUbwbwmxT0c9mFl6B8w19WHMRsc+1GuDy5/rTGIWohxGLRI71NEFVNA//NznPcs6+qtAUw
 KrKDfuldUGYqutmMJWwVIW+HT+lip4LDWIzeg5J7SdZBecutgK/LIjefqLKCRERbHwGbmPv+V
 aWgx6GyMbFkPjdUgYCOiudZLoQTTEjJFcvU4hZL5L9Ks6ifodHlQwXY6K6Y+wWVsqo5praJPe
 1wbQQV4H+Ai3vFgvu385Tgsl8PK1yxaMiNfXNg3WDMqJj3ujpR7pOb5sSOklWN/TEaZ1lSw6t
 2JkhOSEv41ztjaDTfMolvTEAyipIaH7rOFOHbJXIWc31axjIxVlOS5pLt+I5pzc062vX2I4ag
 ihtUZCvOmBmTCcbIA/RCHZUavoSUlPPRHEfZHSzJebnW7AwDwfBjPJb9PFnBRHcq5JhIR8AhG
 WPH0cYZhTEJ9ljyE+pgQpiwT6sbYFdwOYodh7sTCpVODR9+W87kcF24j8oH8xG8BN3Cx4CRP2
 VRr6hGy6g9JY3VawP/2vyDQ6L7fPhX35MIKcj0p6vR4UDDS8cPJLvjGOe92yoaNhg2Fhb3wak
 AHVtWnOVII2FhiXxvkpvTYm/niHuTlS1DKKZFBSmRGiqsIJJ6HQTHd0HE1ORndHgsdo9fX3+U
 CP1BlYLMFU/1kIRqfaW9I0owR9U7cXynOhsygzpkVhDdbDVUKY/DtqCLrTEqFx7I4IvR4se7j
 wj6ODXh4eXbzWr/G7THOpDaf1/QKcoBFdv/IIsRSvTU0GpgTuLgAYnjGTFvjLJtnJwzXt02Cd
 dg+vyPf97k/eq6SqzsNfjKNa2X4QWPi+eRXSwUgEXDXFvrseYfpEwWuVDsi5beiolo96tyxks
 3lEpqCrC18BuLUwy3K0+9VIAnm3vcw+jg7eAmlEZLvrKF61+llP0CRhr5YpajgdNh8V4mV6Ji
 +9GX9xDmTDHPZ+vsitIUhl9zYLOaBY8LLIeCJ+hPgOrwWf7FGn/unt7gG/3y3lP/4gOMJL9PO
 R23zQTsoRqDDbQaN/PoW6qC/MBiToSFM9KfyUUhicVcjU9PXgkTJBCCibvJY9MLPoo0hM4PV2
 RWTlPObc4Rm1oqJ9PN9K304BX3Dyq+/siCyk/q5kg0fOs+q9H1uDy2h190OvA8hdFheZgEP5Q
 5TU3Q6/nAFZ+nn5FrrA/5XvSWNNgMSfYRRK8p/2vgyvL83RoUjYT3XUFOOm7lMABJ3uIkDWgy
 nxQa01Iwt8293AYFOfilOGhZkCvWQLYOE29vNYeXv5LT9OmGQvxZ+vqh4txnywQIFGBXyVrg8
 LFwtxdOU08kIYsQhJOhA9Cc87OYnnvhdbu41V/W5xmBd3T5YPzrivwFMtkWJCT9Y+TWaa7dP2
 G+b7OGIs/s6eNGAyOKsIHLXh8LGKCzS2A6DXNlGjlsREoKM2/FdajDzS+FImiY/QOiwyRIu+2
 9tOh7aCVHLcdG9Ywc70U

Am 15=2E Dezember 2025 20:28:36 MEZ schrieb "Creeley, Brett" <bcreeley@amd=
=2Ecom>:
>
>
>On 12/14/2025 3:03 AM, Frank Wunderlich wrote:
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh b/drivers/ne=
t/ethernet/mediatek/mtk_eth_soc=2Eh
>> index 0168e2fbc619=2E=2E334625814b97 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh
>> @@ -1143,16 +1143,30 @@ struct mtk_reg_map {
>>          u32     tx_irq_mask;
>>          u32     tx_irq_status;
>>          struct {
>> -               u32     rx_ptr;         /* rx base pointer */
>> -               u32     rx_cnt_cfg;     /* rx max count configuration *=
/
>> -               u32     pcrx_ptr;       /* rx cpu pointer */
>> -               u32     glo_cfg;        /* global configuration */
>> -               u32     rst_idx;        /* reset index */
>> -               u32     delay_irq;      /* delay interrupt */
>> -               u32     irq_status;     /* interrupt status */
>> -               u32     irq_mask;       /* interrupt mask */
>> +               u32     rx_ptr;                 /* rx base pointer */
>> +               u32     rx_cnt_cfg;             /* rx max count configu=
ration */
>> +               u32     pcrx_ptr;               /* rx cpu pointer */
>> +               u32     pdrx_ptr;               /* rx dma pointer */
>> +               u32     glo_cfg;                /* global configuration=
 */
>> +               u32     rst_idx;                /* reset index */
>> +               u32     rx_cfg;                 /* rx dma configuration=
 */
>> +               u32     delay_irq;              /* delay interrupt */
>> +               u32     irq_status;             /* interrupt status */
>> +               u32     irq_mask;               /* interrupt mask */
>
>Small nit - is the comment alignment really necessary?

I could transform it to something like this:

<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh#n921>

>Thanks,
>
>Brett


regards Frank

