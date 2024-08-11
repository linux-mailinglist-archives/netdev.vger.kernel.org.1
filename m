Return-Path: <netdev+bounces-117478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54894E150
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA51C20C02
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDF1465A8;
	Sun, 11 Aug 2024 13:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF1145A12;
	Sun, 11 Aug 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723381775; cv=none; b=dymUDRaPgLQjvaoG51tSKJaUFCDAnozUPI5IyJaRE4R+nc2gu8MD+oi1tN/LQECyNuTb+DeOiKg0dUYmN3CmEpCuNvKku7N8Dm/+I2JaSsbs4dH5TFj2ZLWgIAVx8IGbJlFcpETeeLWqaqvgnxmJKFphpz4bu4Wf8DoK17aHnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723381775; c=relaxed/simple;
	bh=CwSzN2T6LANVllh1CufNDmu9zUGYFb619dg2U/od1bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgRAWJ6zrFLS/v8KxhGRFFizqIMsFln/s4vAloo4YR13NcTMPO34teyHzsHXnxSnNVMz9e7GwIdQEQIQxLN+7+nbYirTOr6LrBOcv/P5z0f2bPBiUOFpsUtw64OZjFjnPaLxa36k8ikUTOjScjY9aDphDQPFCbtbWrd3dl6FNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YoAuuBe_1723381760)
          by smtp.aliyun-inc.com;
          Sun, 11 Aug 2024 21:09:21 +0800
Message-ID: <b18c7f09-dd57-4b30-a8ff-fa6136d613ed@motor-comm.com>
Date: Sun, 11 Aug 2024 06:09:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuanlai.cui@motor-comm.com,
 hua.sun@motor-comm.com, xiaoyong.li@motor-comm.com,
 suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
 <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>
 <f18fa949-b217-4373-82c4-7981872446b4@motor-comm.com>
 <e9d9c67d-e113-4a10-bd18-0d013fe7ea92@lunn.ch>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <e9d9c67d-e113-4a10-bd18-0d013fe7ea92@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/1/24 06:14, Andrew Lunn wrote:
> On Thu, Aug 01, 2024 at 02:49:12AM -0700, Frank.Sae wrote:
>> On 7/27/24 02:25, Krzysztof Kozlowski wrote:
>>
>>      On 27/07/2024 11:20, Frank.Sae wrote:
>>
>>           The motorcomm phy (yt8821) supports the ability to
>>           config the chip mode of serdes.
>>           The yt8821 serdes could be set to AUTO_BX2500_SGMII or
>>           FORCE_BX2500.
>>           In AUTO_BX2500_SGMII mode, SerDes
>>           speed is determined by UTP, if UTP link up
>>           at 2.5GBASE-T, SerDes will work as
>>           2500BASE-X, if UTP link up at
>>           1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
>>           as SGMII.
>>           In FORCE_BX2500, SerDes always works
>>           as 2500BASE-X.
>>
>>      Very weird wrapping.
>>
>>      Please wrap commit message according to Linux coding style / submission
>>      process (neither too early nor over the limit):
>>      https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>
>>
>>          Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>
>>
>>      Didn't you copy user-name as you name?
>>
>> sorry, not understand your mean.
>>
>>          ---
>>           .../bindings/net/motorcomm,yt8xxx.yaml          | 17 +++++++++++++++++
>>           1 file changed, 17 insertions(+)
>>
>>      Also, your threading is completely broken. Use git send-email or b4.
>>
>> sorry, not understand your mean of threading broken. the patch used git
>> send-email.
> Your indentation of replies it also very odd!
>
>>          +      0: AUTO_BX2500_SGMII
>>          +      1: FORCE_BX2500
>>          +      In AUTO_BX2500_SGMII mode, serdes speed is determined by UTP,
>>          +      if UTP link up at 2.5GBASE-T, serdes will work as 2500BASE-X,
>>          +      if UTP link up at 1000BASE-T/100BASE-Tx/10BASE-T, serdes will
>>          +      work as SGMII.
>>          +      In FORCE_BX2500 mode, serdes always works as 2500BASE-X.
>>
>>
>>      Explain why this is even needed and why "auto" is not correct in all
>>      cases. In commit msg or property description.
>>
>> yt8821 phy does not support strapping to config the serdes mode, so config the
>> serdes mode by dts instead.
> Strapping does not matter. You can set it on probe.
>
>> even if auto 2500base-x serdes mode is default mode after phy hard reset, and
>> auto as default must be make sense, but from most our customers's feedback,
>> force 2500base-x serdes mode is used in project usually to adapt to mac's serdes
>> settings. for customer's convenience and use simplicity, force 2500base-x serdes
>> mode selected as default here.
>   
> If you are using phylink correctly, the customer should never
> know. Both the MAC and the PHY enumerate the capabilities and phylink
> will tell you what mode to change to.
>
> I still think this property should be removed, default to auto, and
> let phylink tell you if something else should be used.

The property motorcomm,chip-mode will be removed in next patch. found that
phy-mode property in dts can be used to configure the serdes mode. when
phy-mode is set to 2500base-x, the serdes is refered as always in
2500base-x, when phy-mode is set to sgmii, the serdes is refered as in
2500base-x or sgmii according to media speed.

>>          +    $ref: /schemas/types.yaml#/definitions/uint8
>>
>>      Make it a string, not uint8.
>>
>>
>> why do you suggest string, the property value(uint8) will be wrote to phy
>> register.
> Device tree is not a list of values to poke into registers. It is a
> textual description of the hardware. The driver probably needs to
> apply conversions to get register values. e.g. delay are in ns,
> voltages are in millivolts, but register typically don't use such
> units.
>
> 	Andrew

