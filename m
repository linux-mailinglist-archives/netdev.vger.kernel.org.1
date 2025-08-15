Return-Path: <netdev+bounces-213971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4311FB278C7
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA361CE7A18
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C229288C81;
	Fri, 15 Aug 2025 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kllvPuZw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0925334B;
	Fri, 15 Aug 2025 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237920; cv=none; b=qxpy9I10Q+C/2GfN+vtnSBCeCO8chzY5ARb2Rly6O4QSZIjwoHlE8Xd6VjFljEi+XlI52r/VQROarH3luiEnbRmS1M2GDAeYIgHbowYfr7JCoS2DjkZjnr1Y7+qaeAeEkg3ZCKETyB9NFQN3YQlELzhwl9V9SZDi3eyh7nAkRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237920; c=relaxed/simple;
	bh=yTQcmNIN/VvgA8Q36hNqkRMmGQohgKcXOjpdoM0mOL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGmEa+wJWwZ5YuneWTonleKXvRawfZz9iqaa/jC0d/7YgWelPnrQ6d4oV4W6DxyLW3/ztZPNxOQBxni02lVoRexQbGduR2EbJaltTHumRHyEdZSyPTGQT5+Zv0R+KdU1/CM4JOlasTDrwJ0lAQR9wvpPL88e38g1Ud8BZPNLs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kllvPuZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4483AC4CEF4;
	Fri, 15 Aug 2025 06:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755237919;
	bh=yTQcmNIN/VvgA8Q36hNqkRMmGQohgKcXOjpdoM0mOL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kllvPuZw0FL1+4uxxDTXdseXW4cN4rayzjyy7AeypGp3egpPAZ/pBM7v1Tx3IVgic
	 XLk1ayha77yqniWw+KZOpqTk8OxMV0+MkWNTgZtbtbZ+8sa+RhH4k/bR4zRM65RWu1
	 QSFJcR+tunt76s9KBrKrZx90WFa/opDmJttR0y1K5HXlklW1/xnVezZ/O7D8lE3DXm
	 S5/0yg53xvOtz7meKTiredPA5eodn93y2o1Rj+EjCyS4RRgbZPfTxESDPb0reYawhY
	 sKLTVnjXE2ulNWc+VtrX91S1zMUyo+In7OKOPV+MtgzkMFUTbcl3KD9nsMkWfgNcKg
	 Y2D2Ba27YScJg==
Message-ID: <cf531bbd-dc07-4c13-9dbb-774c8dfca70c@kernel.org>
Date: Fri, 15 Aug 2025 08:05:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, shawnguo@kernel.org,
 s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, kernel@pengutronix.de
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-2-wei.fang@nxp.com>
 <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
 <aJ4v4D71OAaV3ZXy@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <aJ4v4D71OAaV3ZXy@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2025 20:50, Frank Li wrote:
> On Thu, Aug 14, 2025 at 10:25:14AM +0200, Krzysztof Kozlowski wrote:
>> On Tue, Aug 12, 2025 at 05:46:20PM +0800, Wei Fang wrote:
>>> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
>>> Integrated Endpoint (RCiEP), the Timer is one of its functions which
>>> provides current time with nanosecond resolution, precise periodic
>>> pulse, pulse on timeout (alarm), and time capture on external pulse
>>> support. And also supports time synchronization as required for IEEE
>>> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the
>>> PTP clock based on NETC Timer.
>>>
>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>>>
>>> ---
>>> v2 changes:
>>> 1. Refine the subject and the commit message
>>> 2. Remove "nxp,pps-channel"
>>> 3. Add description to "clocks" and "clock-names"
>>> v3 changes:
>>> 1. Remove the "system" clock from clock-names
>>> ---
>>>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
>>>  1 file changed, 63 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>>> new file mode 100644
>>> index 000000000000..60fb2513fd76
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>>> @@ -0,0 +1,63 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: NXP NETC V4 Timer PTP clock
>>> +
>>> +description:
>>> +  NETC V4 Timer provides current time with nanosecond resolution, precise
>>> +  periodic pulse, pulse on timeout (alarm), and time capture on external
>>> +  pulse support. And it supports time synchronization as required for
>>> +  IEEE 1588 and IEEE 802.1AS-2020.
>>> +
>>> +maintainers:
>>> +  - Wei Fang <wei.fang@nxp.com>
>>> +  - Clark Wang <xiaoning.wang@nxp.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - pci1131,ee02
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +    description:
>>> +      The reference clock of NETC Timer, if not present, indicates that
>>> +      the system clock of NETC IP is selected as the reference clock.
>>> +
>>> +  clock-names:
>>> +    description:
>>> +      The "ccm_timer" means the reference clock comes from CCM of SoC.
>>> +      The "ext_1588" means the reference clock comes from external IO
>>> +      pins.
>>> +    enum:
>>> +      - ccm_timer
>>
>> You should name here how the input pin is called, not the source. Pin is
>> "ref"?
>>
>>> +      - ext_1588
>>
>> This should be just "ext"? We probably talked about this, but this feels
>> like you describe one input in different ways.
>>
>> You will get the same questions in the future, if commit msg does not
>> reflect previous talks.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/pci/pci-device.yaml
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    pcie {
>>> +        #address-cells = <3>;
>>> +        #size-cells = <2>;
>>> +
>>> +        ethernet@18,0 {
>>
>> That's rather timer or ptp-timer or your binding is incorrect. Please
>> describe COMPLETE device in your binding.
> 
> Krzysztof:
> 
> 	I have question about "COMPLETE" here. For some MFD/syscon, I know
> need descript all children nodes to make MFD/syscon complete.
> 
> 	But here it is PCIe device.
> 
> pcie_4ca00000: pcie@4ca00000 {
> 	compatible = "pci-host-ecam-generic";
> 	...
> 
> 	enetc_port0: ethernet@0,0 {
>         	compatible = "fsl,imx95-enetc", "...";
> 		...
> 
> 	ptp-timer@18,0 {
> 		compatible = "pci1131,ee02";
> 	}
> };
> 
> 	parent "pci-host-ecam-generic" is common pci binding, each children
> is indepentant part.
> 
> 	I am not sure how to decript COMPLETE device for PCI devices.

I don't know what is missing here, but naming it ethernet suggested
there are other functions not being described in the binding.



Best regards,
Krzysztof

