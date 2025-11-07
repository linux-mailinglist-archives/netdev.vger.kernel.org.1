Return-Path: <netdev+bounces-236741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085CC3F9BC
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE6189014C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAA131C58A;
	Fri,  7 Nov 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="meYRNVo/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X7eXUY9j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F577307AE4
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513227; cv=none; b=OmF6tu/KHAuLF6jhhzf31/+Qi8LdSHNVoFTfhXxdlycEO1yGqMg69Hh34hLFfxuD54Qgh3Xk6aWYM0PXi8O6hJWjyA6pvTg0RVsOs/pA0JbWlGMZwv58ucYx5Fi0lfs9bE+/tpuOOzXiKlw0grgvv8BY1TwSrSzS2yJ7TfuE09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513227; c=relaxed/simple;
	bh=YP5Kx7k+Nd09x0w4SUTnReHV8qPMtlpM4hSGSOzvfg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRWT6Xy1bXnhj8/Zy0mICbl7NB5A+FP4mEaLfBNK69GUkU2rKeiQcYuMu+MNbV6XimeP6DPZmHeFcHtPjcpps40ZsN8OPVvK4IBgzfa8+kuP6tKCD07uyg8Hc6ced9w7/GmQ0JdKKw9JSOZ3ASN/1bJQnqTSEDRXHj+phjdc2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=meYRNVo/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X7eXUY9j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A73MwS51864986
	for <netdev@vger.kernel.org>; Fri, 7 Nov 2025 11:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Yxrppr7/emo5nMkfpN1y9e7bjiQLYqkReu/RHenH+8=; b=meYRNVo/ytmsLIw3
	9yLlW7GI4+rmzu1SkLLhvRhvP8rWpFv8etdCh6oOI0eghmA6tDSc4+hVriUcpmbT
	bvUyQrcf9TgGLMtQn9G+DabVKcab8kJVoyw9dkotpbWXALEFwxkESHu9/xGv20VL
	nacxkzyq6bconr1T4lWp2oNzE6cnmBNsSKhavXJQtBCa7T+USx4Ja6Uje777/aBI
	6S25I9Inyk4w65tWzgHYtI+hnsskEBJILnxbA1HqfHj1VXyZUvwbpaTp6JPz2umy
	TUX/veb7bU/ued1EGhEUm+QNtaAtvgdwI55azNJSswoyx0dkp6JjaiBc//hM8H2d
	w5LLEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a98ta18eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 11:00:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1f633955cso20333785a.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762513224; x=1763118024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Yxrppr7/emo5nMkfpN1y9e7bjiQLYqkReu/RHenH+8=;
        b=X7eXUY9jhcys6rCJKfWotZD5Wt6XLsFNZzhmExcenT54Ewgatl+zppHG4iTptUzHMq
         wu+EN+m/nYrv1wxWffmJcVrBxusDeXl9u6DihAtSYrMREzt3jAeCv94BW7bgm57UBOP9
         3GlNOXEN01GWK4f8CUN1cgvdB/b7TU7taLJoy2P1gfCbMDh0bCr3w1FltKUei+jjWtFU
         qLOf9n0UUxTMGGJ4BqWdgw6jjYlQfNhaoo4jxbzTOTDUvXpDlFrKjZQARPPLjnEnbWvf
         hK1J6AB9XW9d8hZzSMXXh6LBM6UUKnLAlBkU7NxWBJUjBveUStrHG+69YYYfEren+j8T
         ROcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513224; x=1763118024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Yxrppr7/emo5nMkfpN1y9e7bjiQLYqkReu/RHenH+8=;
        b=OQI3C7Bp3BG5t5I4wMToI2GobaYnrHzOwbc+DSgXYYf5UBD2+Pi9QeN4sNtQTOBBz2
         VYnJTq4OWVHMIaoVIs9pBocFV11gGmrxzG5DxdFma9asgpTL/7wsBZWzJl9MlTFIASp4
         53fsuWVSp9tLXxjS4BbrfCXisnkkkKy6Y0Ccj0ybe0h8Tw9DjqZYku9RA4ZplujIXH5S
         Ig7OwyHJ+dC6dU9J0JGGxjBjNM+bIUMENYrJyiQV7iP/JlUe9o5POt5sa50xh7vx8/g8
         mgA23+aHyJMOIs7JhjQRKSaar6qALVL/03xAfKpmUsijjqDuRgBAWhOx03ytZJbmBjhh
         FgPA==
X-Forwarded-Encrypted: i=1; AJvYcCWuXPh1vEkQJ6Y53x/XdtNMs00fnatdXMFtLAvtxhxEdrqLNmVZ5/lAMoF+7FRb0PTwzIrK9XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBwRHtU2LYZqeoo4HtTvsmHcJjzMrzxh+WC9XkfDivESIzrJSG
	bOg06FVnYP0tGELGcJARsQdBkSRanyrCnheYm4orR1SKrlyx7PiIyl3OJnKKBy5O7ZXwMiEUpaa
	i2mMHiGqgQdsClZKTEpxkQdL514mKSyki3fGjB2/mcpkIMjW9o0DcZAeUIOA=
X-Gm-Gg: ASbGncsuLIq267EQpMN2HJ757wqNSINBrG35kHUn9hdSaphmloUsXF8G5VgZGZxh+Bq
	Njm9HCfMizu0Crxdb7fSM78W7TcUJqC/piZH8HyzB/R56bwJrnqHiBsN7zqJZY4ltmhGZjhZZaA
	sdVljtZt0ra0G3JLuMuIWnEjkwBzpHrBAQ5a49DuISjvNoYMylR+OUI7DMxwQt9PzFNbXOxU6Gq
	ArD4Upc0TdSD8UVbTT8b7cv0OidHhY9Lg1WECv68iprAe0kYbaQfUrCrobO48BBTb8sPQwS35WH
	2K3tvg8Ff9ZGT6Cx18cfcaa894FuWQ/BRzlQNCxuCikX6M8uqyqJPvHFTiIbBgDaPuhc+1RZrEH
	h0cj/HOGRc6wtIZ2mMQ/hff7ppb+SJkH0HGKJ7epdqbjCFgiAdmqXPLhq
X-Received: by 2002:a05:620a:4049:b0:85f:89:e114 with SMTP id af79cd13be357-8b245280933mr239715385a.1.1762513223996;
        Fri, 07 Nov 2025 03:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH34Ma6AlYFANasFLA7REiIDlipeT0LBwxV1S1iyIGEImmErkoaBKdKchVkLndS6HBNKbTjKQ==
X-Received: by 2002:a05:620a:4049:b0:85f:89:e114 with SMTP id af79cd13be357-8b245280933mr239705785a.1.1762513223227;
        Fri, 07 Nov 2025 03:00:23 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc874sm216910666b.54.2025.11.07.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 03:00:21 -0800 (PST)
Message-ID: <14f95efb-0eb0-48ee-9132-df35abddfcc7@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 12:00:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] net: stmmac: qcom-ethqos: split power management
 context into a separate struct
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko@sntech.de>, Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Minda Chen <minda.chen@starfivetech.com>,
        Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shuang Liang <liangshuang@eswincomputing.com>,
        Zhi Li <lizhi2@eswincomputing.com>,
        Shangjuan Wei <weishangjuan@eswincomputing.com>,
        "G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        Clark Wang <xiaoning.wang@nxp.com>, Linux Team <linux-imx@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Swathi K S <swathi.ks@samsung.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini
 <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251107-qcom-sa8255p-emac-v5-0-01d3e3aaf388@linaro.org>
 <20251107-qcom-sa8255p-emac-v5-6-01d3e3aaf388@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-qcom-sa8255p-emac-v5-6-01d3e3aaf388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4OCBTYWx0ZWRfX8KQqBJy1yZmF
 bJo6p/Bfg2Fl83lHr6qcnFFsLdV/chENUWTm1i2NNYjGKykYrFcULegMNTL9EAqfSwyADtMeuZw
 R7lQW+4tpl2CLTRhpBcXaAsRlznO6Mqm6qX1dGq+cEnfMATeumWGpB5PiP2cYz4fznwTNzGIrvG
 L2ZOwZbgN///3iOUBizWOieDRIHtmn0wsfpoyZmVaGUkBCg46EG7IXJV5J6mRc8MvZXT2dAKfyC
 De5Vfim6O0guWkwJs/Xbgz4YJ8u9WCjrmsrTR7LBWWp9cBLl3hMn0211SL4K6B/uEG7M7G2zkT/
 NyHlffO+NrhPMf8PDJegfhmalXPE0i270s/c8hFpCYRHy48v+fXspW3VHQxIgHObo3To75AvA9X
 Auuj/nhDPS0yVeAId6Oq9vUkAPkCQQ==
X-Proofpoint-ORIG-GUID: PeYDLMTVFQarw52LVNqAYwM9nQfOn6vZ
X-Proofpoint-GUID: PeYDLMTVFQarw52LVNqAYwM9nQfOn6vZ
X-Authority-Analysis: v=2.4 cv=G9IR0tk5 c=1 sm=1 tr=0 ts=690dd149 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iTm1nGh4yTgqJnnOKdQA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070088

On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With match data split into general and power-management sections, let's
> now do the same with runtime device data.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 46 ++++++++++++----------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 1f00556bbad997e2ec76b521cffe2eb14fabb79e..09f122062dec87aa11804af2769ddff4964e6596 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -105,17 +105,21 @@ struct ethqos_emac_match_data {
>  	const struct ethqos_emac_pm_data *pm_data;
>  };
>  
> +struct ethqos_emac_pm_ctx {
> +	struct clk *link_clk;
> +	unsigned int link_clk_rate;
> +	struct phy *serdes_phy;

What is the benefit of doing this? PHY APIs happily consume a nullptr
and NOP out, and the PHY is already retrieved with _optional(),
similarly with clk

Konrad

