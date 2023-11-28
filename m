Return-Path: <netdev+bounces-51512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06057FAF3F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 706CBB210AC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1410EE;
	Tue, 28 Nov 2023 00:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U8U9yFo0"
X-Original-To: netdev@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43D11BC9;
	Mon, 27 Nov 2023 16:46:34 -0800 (PST)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C40D66071EF;
	Tue, 28 Nov 2023 00:46:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701132392;
	bh=Eeg9oUDddZqUuX6q/CcF6TKjx0iJq9WHFuJnt6xhc90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U8U9yFo0ZWD4RxBlvSJgRHnNu3XlZJvZGIFX020I0AgT9pcnbHCOkqCX+s2miUHw/
	 cyPtbMGx+BPEMM1AfbCPwAup6OtyUArfgQTsCTS3I+UYnulTfVrXnZkVjbU+Yejw3J
	 XWPbz4JoNJwZmOqutwxoAM48bboHVXYPgUe98v+wGHLU7aPrPDrm7USoAh9g5TJyeK
	 VJaLUaTMniAgs3MbcZ2d2+xlXql/Im1fR/xQ7WC3IT9At/ZC3cvHb98twErBAJl9el
	 flJUuEVRI/kN5NndmVC5xItOsyooC1q1dpCS9hve7KN9+XHEbBJA4ULDvawOkDtX4b
	 VSXLnSkIfF4QA==
Message-ID: <2c8b044f-dc17-4f71-89bb-7d50d02bb4cc@collabora.com>
Date: Tue, 28 Nov 2023 02:46:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] riscv: dts: starfive: jh7100: Add sysmain and
 gmac DT nodes
Content-Language: en-US
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-10-cristian.ciocaltea@collabora.com>
 <CAJM55Z-1ibownJG-pEuUx5VvPfnuV0+kT-6Fo3VnVs2YycNEEg@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z-1ibownJG-pEuUx5VvPfnuV0+kT-6Fo3VnVs2YycNEEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/23 23:15, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> Provide the sysmain and gmac DT nodes supporting the DWMAC found on the
>> StarFive JH7100 SoC.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 36 ++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> index a8a5bb00b0d8..e8228e96d350 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> @@ -179,6 +179,37 @@ plic: interrupt-controller@c000000 {
>>  			riscv,ndev = <133>;
>>  		};
>>
>> +		gmac: ethernet@10020000 {
>> +			compatible = "starfive,jh7100-dwmac", "snps,dwmac";
>> +			reg = <0x0 0x10020000 0x0 0x10000>;
>> +			clocks = <&clkgen JH7100_CLK_GMAC_ROOT_DIV>,
>> +				 <&clkgen JH7100_CLK_GMAC_AHB>,
>> +				 <&clkgen JH7100_CLK_GMAC_PTP_REF>,
>> +				 <&clkgen JH7100_CLK_GMAC_TX_INV>,
>> +				 <&clkgen JH7100_CLK_GMAC_GTX>;
>> +			clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
>> +			resets = <&rstgen JH7100_RSTN_GMAC_AHB>;
>> +			reset-names = "ahb";
>> +			interrupts = <6>, <7>;
>> +			interrupt-names = "macirq", "eth_wake_irq";
>> +			max-frame-size = <9000>;
>> +			snps,multicast-filter-bins = <32>;
>> +			snps,perfect-filter-entries = <128>;
>> +			starfive,syscon = <&sysmain 0x70 0>;
>> +			rx-fifo-depth = <32768>;
>> +			tx-fifo-depth = <16384>;
>> +			snps,axi-config = <&stmmac_axi_setup>;
>> +			snps,fixed-burst;
>> +			snps,force_thresh_dma_mode;
>> +			status = "disabled";
>> +
>> +			stmmac_axi_setup: stmmac-axi-config {
>> +				snps,wr_osr_lmt = <0xf>;
>> +				snps,rd_osr_lmt = <0xf>;
> 
> As I also noted on the JH7110 patches these are not addresses or offsets but
> limits eg. counting things, which makes a lot more sense in decimal for most
> humans. But here you've changed them back to 0xf, why?

That's a left over from v1. Will fix, thanks!

>> +				snps,blen = <256 128 64 32 0 0 0>;
>> +			};
>> +		};
>> +
>>  		clkgen: clock-controller@11800000 {
>>  			compatible = "starfive,jh7100-clkgen";
>>  			reg = <0x0 0x11800000 0x0 0x10000>;
>> @@ -193,6 +224,11 @@ rstgen: reset-controller@11840000 {
>>  			#reset-cells = <1>;
>>  		};
>>
>> +		sysmain: syscon@11850000 {
>> +			compatible = "starfive,jh7100-sysmain", "syscon";
>> +			reg = <0x0 0x11850000 0x0 0x10000>;
>> +		};
>> +
>>  		i2c0: i2c@118b0000 {
>>  			compatible = "snps,designware-i2c";
>>  			reg = <0x0 0x118b0000 0x0 0x10000>;
>> --
>> 2.42.0
>>

