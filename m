Return-Path: <netdev+bounces-186747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411DAAA0E81
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A76B1B688D3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBD2D29DC;
	Tue, 29 Apr 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Bb7Or9NV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602F2D29D7;
	Tue, 29 Apr 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935965; cv=none; b=Q6UgSTOUPjHqHQ97up/QwxPbS7T6Nxsvq5/D6mvrwrwENCFziVb8lxE8lFfm1eqy6W0808tW4oviTd1oka0E078WQ0pkUzUTUTWvpifzZhTErrcskqhs5D3bl/iLe5f4QsTL1LTln7lRAVzOO270nmki2YxWz+7xVLlkGPG/i7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935965; c=relaxed/simple;
	bh=2cwFB8DtoLlkXn0pVIrWf4KCKsrM4yJaSqWNCg1DZ6g=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qto2Lk1pbdkGW7otflwwo6YHHaOJqUPrZWuNuTlOECOM6knN+HqP1OO/E/dlAXwlrpTUx2tDF9b/CrcQtBQk5d8/XoUgKbWlvBB5QCJ3yGIE3oaNHy7ys+BAErp/gS57HPXOGb1QpoKtU3iIeTN9561LtSF1v4Zoadexqs2IAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Bb7Or9NV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1745935945; x=1746540745; i=frank-w@public-files.de;
	bh=imsoYydlGnAzqSvS+Cgaf9J/PO2EBb7ogqV0YK6n2ZE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Bb7Or9NVfzguMEnkuzp0m4GpQBTLG5zW9fGSeybTB5dL9qXZT9PU3phGLD3BeY1q
	 AnSeuHg5wxb6FowfU38f7J9BhSfPSwYe0ckI+JCmkX2jBtSlNUF13NKOsZDcTWZ+G
	 vxyz99NXJQuonSuJ5Fmpjlqrxc5E/TvxY23EqGgs5FMJ5aXV/v1hIqeEcpOS7qDyw
	 iCQ+rA0a4uUbjSw7hWte0RX9y7gilxZk9SeWwq46/l+hHLkymgtqXJnE5izS7JW9M
	 D/T8czDrtBHlcnFxYadqX2GhTHq819z7zpVNeyIAtjjiKgvUWkgfyGYP5dBuITumz
	 VAF3PoqH8odLqnYlWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.153.176]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1uMshd2CsS-00VQEL; Tue, 29
 Apr 2025 16:12:25 +0200
Date: Tue, 29 Apr 2025 16:12:19 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
 Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
 Sky Huang <skylake.huang@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net=3A_ethernet=3A_mtk=5Feth=5F?=
 =?US-ASCII?Q?soc=3A_add_support_for_MT7988_internal_2=2E5G_PHY?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <aAwV4AOKYs3TljM0@makrotopia.org>
References: <ab77dc679ed7d9669e82d8efeab41df23b524b1f.1745617638.git.daniel@makrotopia.org> <aAwV4AOKYs3TljM0@makrotopia.org>
Message-ID: <687380A7-A580-41EB-8278-73B9942E4280@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LCZ0cZToW3QDgS4il2LDpUb80XsrcmZ8Bs18A2wtEoO1pa2kLQS
 zYN+be3fphd6c2i93tEmaDrunFYtlUWaj/U0ncO1/kT+m4tztyCDr1V9yv8+XPv3+GOKp2G
 uXzoYIxQaIsttmpcrvsukm55jp7fm59kvMuzGy/Cns56pboft4pCVmE9HgSBaw0S8+N0LIJ
 STySUJpaJ30gtxJB71TKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LYEblK1YRis=;yPsTQbRPNKDUObP2u7qs6CGmfF/
 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

Am 26=2E April 2025 01:08:16 MESZ schrieb Daniel Golle <daniel@makrotopia=
=2Eorg>:
>On Fri, Apr 25, 2025 at 10:51:18PM +0100, Daniel Golle wrote:
>> The MediaTek MT7988 SoC comes with an single built-in Ethernet PHY
>> supporting 2500Base-T/1000Base-T/100Base-TX/10Base-T link partners in
>> addition to the built-in MT7531-like 1GE switch=2E The built-in PHY onl=
y
>> supports full duplex=2E
>>=20
>> Add muxes allowing to select GMAC2->2=2E5G PHY path and add basic suppo=
rt
>> for XGMAC as the built-in 2=2E5G PHY is internally connected via XGMII=
=2E
>> The XGMAC features will also be used by 5GBase-R, 10GBase-R and USXGMII
>> SerDes modes which are going to be added once support for standalone PC=
S
>> drivers is in place=2E
>>=20
>> In order to make use of the built-in 2=2E5G PHY the appropriate PHY dri=
ver
>> as well as (proprietary) PHY firmware has to be present as well=2E
>>=20
>> Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>> ---
>> [=2E=2E=2E]
>> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh b/drivers/ne=
t/ethernet/mediatek/mtk_eth_soc=2Eh
>> index 88ef2e9c50fc=2E=2Ee3a8b24dd3d3 100644
>> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh
>> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc=2Eh
>> [=2E=2E=2E]
>> @@ -587,6 +603,10 @@
>>  #define GEPHY_MAC_SEL          BIT(1)
>> =20
>>  /* Top misc registers */
>> +#define TOP_MISC_NETSYS_PCS_MUX	0x84
>
>This offset still assumes topmisc syscon to start at 0x11d10000=2E
>If the pending series[1] adding that syscon at 0x11d10084 gets merged
>first, this offset will have to be changed to
>#define TOP_MISC_NETSYS_PCS_MUX	0x0
>
>[1]: https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/202504=
22132438=2E15735-8-linux@fw-web=2Ede/

Imho this should be changed as well

#define USB_PHY_SWITCH_REG	0x218

To

0x194

It is used in mtk_eth_path=2Ec set_mux_u3_gmac2_to_qphy

regards Frank

