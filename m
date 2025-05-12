Return-Path: <netdev+bounces-189856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A297AB3F41
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E12819E2BE3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A88296D17;
	Mon, 12 May 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="kE/5vxOH"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02926248F71;
	Mon, 12 May 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071213; cv=none; b=bn9x78LyOBFheNr3zUhQcJvPAmUDEHblXvTomI61GsLae6LzwENRXKMLcm7PqSWJ7JqJNvkT9MTKVysJW1nuh9XuHFWNVRERpCT//usGffNkgYy4hQ8U1OFhmsN5zIItA7peXpIvmlcvDWN2DTx/f6xHjizf/F2kaMtlv+cPh/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071213; c=relaxed/simple;
	bh=hUF1s567+qbSPtX2zIZBeWkAIaJckfoue1ZdzRXxzXE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=N59O1QoFQ71PVEPdNdE+C5xx6RS6mXHSWlONst+isxM8S9X4Ea3wMaHYp7qzaLrU71B7nQA2DhccXVHqR2VZ4tVAq74xuOPIaLvGdBVeLa57PM+YxQ+1SGSnWvMRjxNThdrQkc7hpRkpomObusZ473I7CXEGkiszRbDcQAw1aSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=kE/5vxOH; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 6EBA6601D8;
	Mon, 12 May 2025 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747071203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOnx2nS8BUGOff4qxVjsY99Ec3z57H2RyW27rvY/0bw=;
	b=kE/5vxOHk4WeXfDsBzUVJQU1s7TuLuM8EKYi/1mLuGdaNckHloGXV27dRjex99Aw/g9tCf
	5sOD403GIqwnucydRJ13DZ2OjWkkVt4yPY5+KBN9PYb5IZDHQ8v5WcKJLQ47B1i3U8Utt0
	p6Te9xqfKW9dvjVR2RoENhB4uVrdvXg=
Received: from [127.0.0.1] (fttx-pool-194.15.84.99.bambit.de [194.15.84.99])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 238C6360303;
	Mon, 12 May 2025 17:33:22 +0000 (UTC)
Date: Mon, 12 May 2025 19:33:22 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_01/14=5D_dt-bindings=3A_n?=
 =?US-ASCII?Q?et=3A_mediatek=2Cnet=3A_update_for_mt7988?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250512-nibble-freemason-69e0279f2f99@spud>
References: <20250511141942.10284-1-linux@fw-web.de> <20250511141942.10284-2-linux@fw-web.de> <20250512-nibble-freemason-69e0279f2f99@spud>
Message-ID: <05760B5E-955E-4E0E-9B69-E762783CC37B@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 374a0106-a2a0-463f-a626-6a3e8e2d7734

Am 12=2E Mai 2025 18:21:45 MESZ schrieb Conor Dooley <conor@kernel=2Eorg>:
>On Sun, May 11, 2025 at 04:19:17PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Update binding for mt7988 which has 3 gmac and 2 reg items=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  Documentation/devicetree/bindings/net/mediatek,net=2Eyaml | 9 +++++++-=
-
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml =
b/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> index 9e02fd80af83=2E=2E5d249da02c3a 100644
>> --- a/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> +++ b/Documentation/devicetree/bindings/net/mediatek,net=2Eyaml
>> @@ -28,7 +28,8 @@ properties:
>>        - ralink,rt5350-eth
>> =20
>>    reg:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>
>This should become an items list, with an explanation of what each of
>the reg items represents=2E

I would change to this

  reg:
    items:
      - description: Register for accessing the MACs=2E
      - description: SoC internal SRAM used for DMA operations=2E
    minItems: 1

Would this be OK this way?

>> =20
>>    clocks:
>>      minItems: 2
>> @@ -381,8 +382,12 @@ allOf:
>>              - const: xgp2
>>              - const: xgp3
>> =20
>> +        reg:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>>  patternProperties:
>> -  "^mac@[0-1]$":
>> +  "^mac@[0-2]$":
>>      type: object
>>      unevaluatedProperties: false
>>      allOf:
>> --=20
>> 2=2E43=2E0
>>=20

Hi Conor

Thank you for review=2E
regards Frank

