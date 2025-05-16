Return-Path: <netdev+bounces-191043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE14AB9D64
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CAD4A04AC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0CD12B73;
	Fri, 16 May 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyrndIXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F68F6C;
	Fri, 16 May 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402254; cv=none; b=G2XDkKF996UIplx4WnS8KQZqkYkRktsWG7loLmiDEtqZf7oq2kFnHeSpPSWd3JM+9eMXHXrXEU335OzwaArOOkobAnJ6dIK/hM2KWox5Mv3ZJj4/rTmc/jovqBaJLkov0Q00zRn4coVB1b91hN6aMXtJHc985KVZpJJWjgIoT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402254; c=relaxed/simple;
	bh=QAn6oY1ndhlOR/BpQNIMi0vIWRm7eyDLSPPh3kNhCfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qfjWBv+0W1sSzQMQ8sYQiPjRa5nt7DmsYDFdg1/9RtEV2Ib6ysHWigqRR70RFkiiRH9FEmDIW3w51BW8gNtbzrzIn5S40Ez1T5ldbY0ejkeStP+LcSg81iRa/EQTcden6QaW52GxZRjy0rz+X2q6brUme3AURJFdnJUhMYbRscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyrndIXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A50C4CEE4;
	Fri, 16 May 2025 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747402253;
	bh=QAn6oY1ndhlOR/BpQNIMi0vIWRm7eyDLSPPh3kNhCfs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NyrndIXrT2F54tXajQ/zVFqnvgRy82fBTKhucLENL/5/xqUetlmfiZkH3fKR++YBv
	 2Ruv8R4l3x2dk1xRxOcuLaB46AAl7FoNmQC9eyERRK7X1vGA3LopvTfpLS6AJABczo
	 Pzk8dlcPEmjQz1ZOFJ+ZPGICrJLbEuHk3LkkzdGARjaAP8lfdPxk/4kac9GDdiRjGH
	 DEYOoMkSOukEOXE+AUl2AMzzYunI6aP9sJbE4+YSgftNEZAkx7lvbI+adBMbiFzcBP
	 1Z/etCz91Likf1FQUdiP8VC/2eu9ghFN9I3HlVh4AJCAwAoT2bXDEhomPRt4tGjOfT
	 9sK8rEFMhdG4Q==
Message-ID: <acc244a7-54e8-49d0-848e-6eafb850c93b@kernel.org>
Date: Fri, 16 May 2025 15:30:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL]Re: [PATCH net-next 2/2] net: pse-pd: Add Si3474 PSE
 controller driver
To: Piotr Kubik <piotr.kubik@adtran.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
 <036e6a6c-ba45-4288-bc2a-9fd8d860ade6@adtran.com>
 <4783c1aa-d918-4194-90d7-ebc69ddbb789@kernel.org>
 <45525374-413a-4381-8c73-4f708c72ad15@adtran.com>
 <1305689f-1673-4118-935c-f91705d17863@kernel.org>
 <c23d2b2e-6ebb-4a44-bd23-5a66b2cb4e38@adtran.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <c23d2b2e-6ebb-4a44-bd23-5a66b2cb4e38@adtran.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2025 17:58, Piotr Kubik wrote:
> On 5/15/25 17:40, Krzysztof Kozlowski wrote:
>> On 15/05/2025 17:20, Piotr Kubik wrote:
>>> Thanks Krzysztof for your review,
>>>
>>>> On 13/05/2025 00:06, Piotr Kubik wrote:
>>>>> +/* Parse pse-pis subnode into chan array of si3474_priv */
>>>>> +static int si3474_get_of_channels(struct si3474_priv *priv)
>>>>> +{
>>>>> +  struct device_node *pse_node, *node;
>>>>> +  struct pse_pi *pi;
>>>>> +  u32 pi_no, chan_id;
>>>>> +  s8 pairset_cnt;
>>>>> +  s32 ret = 0;
>>>>> +
>>>>> +  pse_node = of_get_child_by_name(priv->np, "pse-pis");
>>>>> +  if (!pse_node) {
>>>>> +          dev_warn(&priv->client[0]->dev,
>>>>> +                   "Unable to parse DT PSE power interface matrix, no pse-pis node\n");
>>>>> +          return -EINVAL;
>>>>> +  }
>>>>> +
>>>>> +  for_each_child_of_node(pse_node, node) {
>>>>
>>>> Use scoped variant. One cleanup less.
>>>
>>> good point
>>>
>>>>
>>>>
>>>>> +          if (!of_node_name_eq(node, "pse-pi"))
>>>>> +                  continue;
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +  ret = i2c_smbus_read_byte_data(client, FIRMWARE_REVISION_REG);
>>>>> +  if (ret < 0)
>>>>> +          return ret;
>>>>> +  fw_version = ret;
>>>>> +
>>>>> +  ret = i2c_smbus_read_byte_data(client, CHIP_REVISION_REG);
>>>>> +  if (ret < 0)
>>>>> +          return ret;
>>>>> +
>>>>> +  dev_info(dev, "Chip revision: 0x%x, firmware version: 0x%x\n",
>>>>
>>>> dev_dbg or just drop. Drivers should be silent on success.
>>>
>>> Is there any rule for this I'm not aware of?
>>> I'd like to know that device is present and what versions it runs just by looking into dmesg.
>>> This approach is similar to other drivers, all current PSE drivers log it this way.
>>>
>> And now I noticed that you already sent it, you got review:
>> https://lore.kernel.org/all/6ee047d4-f3de-4c25-aaae-721221dc3003@kernel.org/
>>
>> and you ignored it completely sending the same again.
>>
>> Sending the same over and over and asking us to do the same review over
>> and over is really waste of our time.
>>
>> Go back to v1, implement entire review. Then start versioning your patches.
>>
>> Best regards,
>> Krzysztof
> 
> 
> I didn't ignore, I replied to your comment, since there was no answer I assumed you agree.
> https://lore.kernel.org/all/38b02e2d-7935-4a23-b351-d23941e781b0@adtran.com/
> 
> Thanks for a reference and explanation, I'll change it.
Coding style has it pretty explicit as well.

Best regards,
Krzysztof

