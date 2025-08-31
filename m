Return-Path: <netdev+bounces-218531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C49B3D08D
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 03:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714FB3BB310
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3A156677;
	Sun, 31 Aug 2025 01:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFC433A6;
	Sun, 31 Aug 2025 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756603824; cv=none; b=aURAHVWR2J4PmIiR5T6fk35UxnBYGQDdocKsMc7RaxdINgmC6cSPAXEzIyHBPpg4xTh08nOHu9R159+QYvFFvuDVvJO+HCPUgLUsE0CLHC4+dor1WIG35FC/xzBjIP3rQMenqtDC8Pw76nRGkzixSWJOr7cK+eY+lrQR4KweOkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756603824; c=relaxed/simple;
	bh=8S/O4oVfjEdL65OQNYJJz8P7HcQuEj0ndZSyix0+LT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4V/ZYOALyrCw3tMrjelYONt0c2d/xCSq1bV7YYA2xgwcN9kzQtkvGRCtTMfaSX7lc9juSejkJkrtmKjqEZMJ23lMeyNETvzJVXNaIVCrvU2qXN6/pDIGfRxOS6tgucmBgM5lZkVxDC0DrcD51UVeJUzpMJpwwcjeTqiZOMIgHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E7C4CEEB;
	Sun, 31 Aug 2025 01:30:22 +0000 (UTC)
Message-ID: <abac67ba-7aff-4ed2-937e-b483cffc635f@kernel.og>
Date: Sat, 30 Aug 2025 20:30:21 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: Agilex5 Add gmac nodes to DTSI for
 Agilex5
To: Matthew Gerlach <matthew.gerlach@altera.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 dinguyen@kernel.org, maxime.chevallier@bootlin.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mun Yew Tham <mun.yew.tham@altera.com>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
 <20250724154052.205706-3-matthew.gerlach@altera.com>
 <13467efc-7c79-4d06-af1c-301b852a530c@altera.com>
 <a70d060d-f1c8-4147-8f1b-1c7ce6360252@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.og>
In-Reply-To: <a70d060d-f1c8-4147-8f1b-1c7ce6360252@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/11/25 10:40, Matthew Gerlach wrote:
>
>
> On 8/4/25 7:57 AM, Matthew Gerlach wrote:
>>
>> On 7/24/25 8:40 AM, Matthew Gerlach wrote:
>> > From: Mun Yew Tham <mun.yew.tham@altera.com>
>> >
>> > Add the base device tree nodes for gmac0, gmac1, and gmac2 to the DTSI
>> > for the Agilex5 SOCFPGA.  Agilex5 has three Ethernet controllers 
>> based on
>> > Synopsys DWC XGMAC IP version 2.10.
>> >
>> > Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
>> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
>> > ---
>> > v2:
>> >   - Remove generic compatible string for Agilex5.
>> > ---
>> >   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 336 
>> ++++++++++++++++++
>> >   1 file changed, 336 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi 
>> b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> > index 7d9394a04302..04e99cd7e74b 100644
>> > --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> > @@ -486,5 +486,341 @@ qspi: spi@108d2000 {
>> >               clocks = <&qspi_clk>;
>> >               status = "disabled";
>> >           };
>>
>> Is there any feedback for this patch and the next one in the series,
>> "[PATCH v2 3/4] arm64: dts: socfpga: agilex5: enable gmac2 on the
>> Agilex5 dev kit"?
>>
>> Thanks,
>> Matthew Gerlach
>
> Just checking in again. Is there any feedback on this patch (v2 2/4) 
> or the next patch (v2 3/4)?
> https://lore.kernel.org/lkml/20250724154052.205706-1-matthew.gerlach@altera.com/T/#m2a5f9a3d22dfef094986fd8a421051f55667b427 
>
> https://lore.kernel.org/lkml/20250724154052.205706-1-matthew.gerlach@altera.com/T/#m3e3d9774dbdb34d646b53c04c46ec49d32254544 
>
>

Applied!

Thanks,

Dinh


