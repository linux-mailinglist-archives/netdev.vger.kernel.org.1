Return-Path: <netdev+bounces-108247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DB91E806
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B78283005
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829016F0DE;
	Mon,  1 Jul 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="d6Z4tSyT"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDD10F9;
	Mon,  1 Jul 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860191; cv=none; b=RvGX9EAkxVN2mM07FHmdrKTpVzmCuS8sumvVwQ/c5lXFW6NfJZw2kwku02UA76qFvjDuTRRNRUJnu795b8SIjZgncRNXJxtvivxK6rnl78XsE8VFud25W0p1myIudcNLfmtD3JAEJXL5jXJ8o06rUUyoLN5LvRcsa9BTpaeoMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860191; c=relaxed/simple;
	bh=FGjF9H72/VjAVssFyu2ost2sDyRH7zc8H/44qyHvy5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNJWtmQH6yU/vtY4BM6epCaafHYgulF140PLv/V3nWrjjtgJAGgu28ESCeo+RBbbuMs2fo4DnSK44uzJVyHTzJEVCii34RoDt7dke6ayOjRWl93yxboBTbZJhp2pEUCZxyyRIp4JSCOXOjFH+4vt4ZIpcSwQf86wNz7pMnKFQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=d6Z4tSyT; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A2AC1886BF;
	Mon,  1 Jul 2024 20:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719860180;
	bh=ftdeQIvicw6mG0MiKB0Aa+ePUHUQrNFHdnNxsWe3Sa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d6Z4tSyT9tMbxoio/eIxjq41VHtZbL4iwD1zMfZX8ymQG0LLkwcgt4r/aGw9zb6bh
	 ZSkFckq+9cF1DjVzSW9YUk2DxTfERXzHpPBaRLOugjf5BgBax1FEWitvH4+As3W4xW
	 /5PTjxsmsD+I5yRnZdhQvrbU+ujquh7u5FHGZTbDbgUAlQ0SJfCzOPN+TNGxZb6v6y
	 wVv/oqd2PFItUrDcMDYJyPXnvvFd8ji2y+VxykE/qa2qSB7LWsyijLEuP4Pc01HEyy
	 /LeW+DIUY/I/yBTAlenKNAaDYqWWLYLVSWSnAU+F2rC/t19qzZD5myvxwwFZbErFI5
	 E7e7zFUTLUuyA==
Message-ID: <c1b3dffb-f7e5-4c10-8cda-a4c26ce3c74b@denx.de>
Date: Mon, 1 Jul 2024 20:35:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@dh-electronics.com
References: <20240625184359.153423-1-marex@denx.de>
 <CAMuHMdWJmQ-Jhko-0SO6_dKceXPNu8nx++wgWxxLn=6xPcBMPg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAMuHMdWJmQ-Jhko-0SO6_dKceXPNu8nx++wgWxxLn=6xPcBMPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/1/24 5:06 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Tue, Jun 25, 2024 at 8:46 PM Marek Vasut <marex@denx.de> wrote:
>> Extract known PHY IDs from Linux kernel realtek PHY driver
>> and convert them into supported compatible string list for
>> this DT binding document.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Thanks for your patch, which is now commit 8fda53719a596fa2
> ("dt-bindings: net: realtek,rtl82xx: Document known PHY IDs as
> compatible strings") in net-next/main (next-20240628 and later).
> 
>> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> @@ -18,6 +18,29 @@ allOf:
>>     - $ref: ethernet-phy.yaml#
>>
>>   properties:
>> +  compatible:
>> +    enum:
>> +      - ethernet-phy-id001c.c800
>> +      - ethernet-phy-id001c.c816
>> +      - ethernet-phy-id001c.c838
>> +      - ethernet-phy-id001c.c840
>> +      - ethernet-phy-id001c.c848
>> +      - ethernet-phy-id001c.c849
>> +      - ethernet-phy-id001c.c84a
>> +      - ethernet-phy-id001c.c862
>> +      - ethernet-phy-id001c.c878
>> +      - ethernet-phy-id001c.c880
>> +      - ethernet-phy-id001c.c910
>> +      - ethernet-phy-id001c.c912
>> +      - ethernet-phy-id001c.c913
>> +      - ethernet-phy-id001c.c914
>> +      - ethernet-phy-id001c.c915
>> +      - ethernet-phy-id001c.c916
>> +      - ethernet-phy-id001c.c942
>> +      - ethernet-phy-id001c.c961
>> +      - ethernet-phy-id001c.cad0
>> +      - ethernet-phy-id001c.cb00
> 
> Can you please elaborate why you didn't add an
> "ethernet-phy-ieee802.3-c22" fallback?

I'll quote Andrew's comment on

[PATCH 2/2] arm64: dts: renesas: Drop ethernet-phy-ieee802.3-c22 from 
PHY compatible string on all RZ boards

"
"ethernet-phy-ieee802.3-c22" is pretty much pointless. I don't
remember seeing a DT description which actually needs it. It is in the
binding more for completion, since "ethernet-phy-ieee802.3-c45" is
needed sometimes, and -c22 just completes the list.
"

But also, statistically, the in-kernel DTs contain both options, the one 
with "ethernet-phy-ieee802.3-c22" fallback is less common:

$ git grep -ho ethernet-phy-id001c....... | sort | uniq -c
       1 ethernet-phy-id001c.c816",
       2 ethernet-phy-id001c.c915",
       2 ethernet-phy-id001c.c915";
       5 ethernet-phy-id001c.c916",
      13 ethernet-phy-id001c.c916";

