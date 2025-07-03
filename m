Return-Path: <netdev+bounces-203717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED65AF6E11
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCE11C282F8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB662D4B65;
	Thu,  3 Jul 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="qXVoJZH4"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436A2D46D8;
	Thu,  3 Jul 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533355; cv=pass; b=I66GwIrWSxpMW6EXDIZsd9OOQSYL+fREVNiGix/H6l7fxvmm+71SrRWR5lL6SRYM736w8vzYxvp74fAmeJDEM3cRsO4ctGphNLX8KW+F63KQVtcU0yqiiV7mQWgemMWMFW2iYGHm1Ky78PzfiFds578gOOvzLaIPoM5CpSb5Xt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533355; c=relaxed/simple;
	bh=1x9noGp/YyjeYTaho9SwTajjJAkTELQbXuhXq6ypjTQ=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=CgauUw8aqm3WjwYDN7paiAPwiMLd2ewvJA3nF5FcyzXlmgU1yLFgHAIc69bz9gT44gNvGIQGX78V60dlgosvk/ZZoRCJNgyM/dwFTMYfcjuDmfCPb53yRNJKJukjGrQI0h/l6jP9Hoo46CIkb65oQI1+xGStwfN9Z8NEWLJPs4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=qXVoJZH4; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1751533249; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KKVvBkeo3qxgezrXeVABLPlIw6eJ6RvPjxqCLLPR4Wnc8F2rJVoSc/AEIptXtdu4xG8yAAuWEOf9cdgo/kBECOzxLRuHqdPPDDAw/HmE/CuvN4cezsUdL0OCJ0GWzVrpS1LI2/Ciu1SQcN+OkAXEc0lqPwn2fEYKP8P9g+y1ACg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751533249; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1x9noGp/YyjeYTaho9SwTajjJAkTELQbXuhXq6ypjTQ=; 
	b=TRDiAOb2YJWhEJMbR3dNNALR4dGoxA+pcqocs96/m/wERWsEejxGwuKEswbte2hd4eCHqJ37IJcmfQpdtcXRghKbNQxmFwIBZEz0JQqpF5QPbA5aIHFiSRdlqguMcVL2q8hyAMcP+FHQDlYCVZSao3IGgWy6LHN9cWiT2WoY9Kg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751533249;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1x9noGp/YyjeYTaho9SwTajjJAkTELQbXuhXq6ypjTQ=;
	b=qXVoJZH4IPSkxKuRWuy6EJrTq8XQNfEpvvT6bKfDt6znEZxc8MF2TGctYNIe6epI
	Q7bHijO9JmxE/LeFbyiARWeQSK/7g+i/aq/na+ZyVvlj+wBYaPLB93n3J6D4yIr5+r1
	l5cmMXZN430EDk9vglEow6IExvLngACe4mS9YahQ=
Received: by mx.zohomail.com with SMTPS id 175153324571033.72754487040095;
	Thu, 3 Jul 2025 02:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Vivian Wang" <wangruikang@iscas.ac.cn>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@gentoo.org>, 
	"Philipp Zabel" <p.zabel@pengutronix.de>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, 
	"Alexandre Ghiti" <alex@ghiti.fr>
In-Reply-To: <ce2881b9-38ed-42b6-824d-72948389e8fa@iscas.ac.cn>
Cc: "Vivian Wang" <uwu@dram.page>, 
	"Lukas Bulwahn" <lukas.bulwahn@redhat.com>, 
	"Geert Uytterhoeven" <geert+renesas@glider.be>, 
	"Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>, 
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 5/5] riscv: dts: spacemit: Add Ethernet support
	 for Jupiter
Message-ID: <184eb232eceb01f8.c7773f00732f7e87.4136a253a628cb2b@Jude-Air.local>
Date: Thu, 3 Jul 2025 09:00:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Vivian,

On 03/07/2025 15:46, Vivian Wang wrote:
> Hi Junhui,
>=20
> On 7/3/25 14:48, Junhui Liu wrote:
>> Hi Vivian,
>> Thanks for you work!
>>
>> On 2025/7/2 14:01, Vivian Wang wrote:
>>> Milk-V Jupiter uses an RGMII PHY for each port and uses GPIO for PHY
>>> reset.
>>>
>>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>>
>> Successfully tested with iperf3 on Milk-V Jupiter.
>>
>> TCP Rx: 941 Mbits/sec
>> TCP Tx: 943 Mbits/sec
>> UDP Rx: 956 Mbits/sec
>> UDP Tx: 956 Mbits/sec
>>
>> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>=C2=A0
>>
> Thanks for the testing! I do not have a Milk-V Jupiter handy, so that
> was very helpful.
>=20
> As discussed [1], I will post a v4 soon with minor fixes and also sans
> the DTS changes. I will put your Tested-by on the driver patch instead
> of this DTS patch, so it will show up in v4.
>=20
> Are you okay with this? If you don't like it feel free to tell me.

It's okay to me. Thanks!

>=20
> Regards,
> Vivian "dramforever" Wang
>=20
> [1]: https://lore.kernel.org/spacemit/a9cad07c-0973-43c3-89f3-95b856b575df=
@iscas.ac.cn/
>=20
>>> ---
>>> =C2=A0 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts | 46
>>> +++++++++++++++++++++++
>>> =C2=A0 1 file changed, 46 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
>>> b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
>>> index
>>> 4483192141049caa201c093fb206b6134a064f42..c5933555c06b66f40e61fe2b9c159b=
a0770c2fa1
>>> 100644
>>> --- a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
>>> +++ b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
>>> @@ -20,6 +20,52 @@ chosen {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 };
>>> =C2=A0 +&eth0 {
>>> +=C2=A0=C2=A0=C2=A0 phy-handle =3D <&rgmii0>;
>>> +=C2=A0=C2=A0=C2=A0 phy-mode =3D "rgmii-id";
>>> +=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&gmac0_cfg>;
>>> +=C2=A0=C2=A0=C2=A0 rx-internal-delay-ps =3D <0>;
>>> +=C2=A0=C2=A0=C2=A0 tx-internal-delay-ps =3D <0>;
>>> +=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mdio-bus {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <0x1>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0x0>;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio K1_GP=
IO(110) GPIO_ACTIVE_LOW>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-delay-us =3D <10000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-post-delay-us =3D <100=
000>;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rgmii0: phy@1 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0x1>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +};
>>> +
>>> +&eth1 {
>>> +=C2=A0=C2=A0=C2=A0 phy-handle =3D <&rgmii1>;
>>> +=C2=A0=C2=A0=C2=A0 phy-mode =3D "rgmii-id";
>>> +=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&gmac1_cfg>;
>>> +=C2=A0=C2=A0=C2=A0 rx-internal-delay-ps =3D <0>;
>>> +=C2=A0=C2=A0=C2=A0 tx-internal-delay-ps =3D <250>;
>>> +=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mdio-bus {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <0x1>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0x0>;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio K1_GP=
IO(115) GPIO_ACTIVE_LOW>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-delay-us =3D <10000>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-post-delay-us =3D <100=
000>;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rgmii1: phy@1 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0x1>;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +};
>>> +
>>> =C2=A0 &uart0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&uart0_2_cfg>;
>>>

--=20
Best regards,
Junhui Liu

