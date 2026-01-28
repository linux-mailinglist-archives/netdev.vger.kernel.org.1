Return-Path: <netdev+bounces-254162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNvFNFnUeWm6zwEAu9opvQ
	(envelope-from <netdev+bounces-254162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:18:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D769EB8B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCD5300D142
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71434251B;
	Wed, 28 Jan 2026 09:17:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC8341AC7;
	Wed, 28 Jan 2026 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591854; cv=none; b=tuZ2PG9AgD3ZJgEwJDrUbkRq1xdKO/0TPg5MBFGnWa9wRx4KrXslBbLZ5d91Bf8CvdwzINerYheFuQMhgS6LGw6quvzEfc69IjIJcgsvOEp43qWqOPoRmidsXOxX3MCbgbrirhqvY6TtRq8yiOsyQwtVX8FVIbnMHHxIVQeJd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591854; c=relaxed/simple;
	bh=ob8qtxwG9Y9g/gSpFLd9qZ7a/1OCBn7jtdmVPJwL5hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxQVevsAXmiq8sDiDf7JIonLBSuY6vavL6KRLwbuqKS6Fwoxm7H8uhXZRlGav+jtanLnuOjQJnqYSD0EhFilbNwx5zLV4bkgfeSz6MkKIZi/UEAZHv6JioxVTBR/qx/eebZzdy474ce8JEF1R2dz9lOUSTsoZiZbTHbG6XCX60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.109] (unknown [123.118.222.47])
	by APP-01 (Coremail) with SMTP id qwCowAD3nmr+03lp6YiOBg--.8714S2;
	Wed, 28 Jan 2026 17:16:46 +0800 (CST)
Message-ID: <f73fc83c-b38d-4974-ba3c-80c5e5556e7e@iscas.ac.cn>
Date: Wed, 28 Jan 2026 17:16:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Yao Zi <ziyao@disroot.org>, Yanteng Si <siyanteng@cqsoftware.com.cn>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Shangjuan Wei <weishangjuan@eswincomputing.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
References: <20260128072931.875041-1-inochiama@gmail.com>
 <20260128072931.875041-4-inochiama@gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260128072931.875041-4-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3nmr+03lp6YiOBg--.8714S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW5Wr48GF4xGryDuF17KFg_yoW5uFWkpF
	WrJF97KrWqyF4fAw4IyFZrZFn3Zr47tr17ur1ftryfGFn5Jr95Wr1FkrWxGr1xCrZ3Ja48
	Z3Wfu3W3Wa9F93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYQeOtUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,disroot.org,cqsoftware.com.cn,bp.renesas.com,bootlin.com,linux.intel.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254162-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 28D769EB8B
X-Rspamd-Action: no action

Hi Inochi,

I have some comments below.

On 1/28/26 15:29, Inochi Amaoto wrote:
> The etherenet controller on Spacemit K3 SoC is Synopsys DesignWare
Typo: etherenet -> ethernet
> MAC (version 5.40a), with the following special point:
Nit: point -> points 
> 1. The rate of the tx clock line is auto changed when the mac speed
>    rate is changed, and no need for changing the input tx clock.
> 2. This controller require a extra syscon device to configure the
>    interface type, enable wake up interrupt and delay configuration
>    if needed.
>
> Add Spacemit dwmac driver support on the Spacemit K3 SoC.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-spacemit.c  | 218 ++++++++++++++++++
>  3 files changed, 231 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
>
> [...]
>
> +
> +/* dline register bits */
> +#define RGMII_RX_DLINE_EN		BIT(0)
> +#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
> +#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
> +#define RGMII_TX_DLINE_EN		BIT(16)
> +#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
> +#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
> +
> +#define MAX_DLINE_DELAY_CODE		0xff
> +#define MAX_WORKED_DELAY		2800
> +
> +/* Note: the delay step value is at 0.1ps */
> +static const unsigned int k3_delay_step_10x[4] = {
> +	367, 493, 559, 685
> +};
> +
> +static int spacemit_dwmac_set_delay(struct regmap *apmu,
> +				    unsigned int dline_offset,
> +				    unsigned int tx_code, unsigned int tx_config,
> +				    unsigned int rx_code, unsigned int rx_config)
> +{
> +	unsigned int mask, val;
> +
> +	mask = RGMII_TX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
> +	       RGMII_RX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
> +	val = FIELD_PREP(RGMII_TX_DLINE_STEP, tx_config) |
> +	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
> +	      FIELD_PREP(RGMII_RX_DLINE_STEP, rx_config) |
> +	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
> +
> +	return regmap_update_bits(apmu, dline_offset, mask, val);
> +}
> +
> +static int spacemit_dwmac_detected_delay_value(unsigned int delay,
> +					       unsigned int *config)
> +{
> +	unsigned int best_delay = 0;
> +	unsigned int best_config = 0;
> +	int best_code = 0;
> +	int i;
> +
> +	if (delay == 0)
> +		return 0;
> +
> +	if (delay > MAX_WORKED_DELAY)
> +		return -EINVAL;
> +
> +	/*
> +	 * Note K3 require a specific factor for calculate
> +	 * the delay, in this scenario it is 0.9. So the
> +	 * formula is code * step / 10 * 0.9
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(k3_delay_step_10x); i++) {
> +		unsigned int step = k3_delay_step_10x[i];
> +		int code = DIV_ROUND_CLOSEST(delay * 10 * 10, step * 9);
> +		unsigned int tmp = code * step * 9 / 10 / 10;
> +
> +		if (abs(tmp - delay) < abs(best_delay - delay)) {
> +			best_code = code;
> +			best_delay = tmp;
> +			best_config = i;
> +		}
> +	}
> +
> +	*config = best_config;
> +
> +	return best_code;

Is this really necessary? For K1 I just used the smallest step size.

It seems to me you have, for the smallest step size, about 36.7ps * 0.9
= 33ps per step. Theoretically speaking that lets you fine tune the
delay to within 1% of the 2ns total required RGMII delay (MAC + PCB +
PHY). In practice this number shouldn't be that marginal. 


