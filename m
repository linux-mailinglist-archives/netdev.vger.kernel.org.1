Return-Path: <netdev+bounces-236738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 817C3C3F938
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 11:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3274F4EE166
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BBC31A57A;
	Fri,  7 Nov 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j19zi5vc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aVpK38KF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86C209F5A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512601; cv=none; b=W++Pl/DkU0LuO7RVi5HbPyDgi365ToF54iT43r7e5YJUo5iYFlbWra/mTmYslStKpL/ymNndz4KZFFEbLRqhIJJIAbNOofxoIT6NeBQCoKDuacbOLnKVMrSlJEWv9QtqZRYwSiEbJsVwyQED6Ho2LTQgBYuSdzW1lLuJ4OfnO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512601; c=relaxed/simple;
	bh=k6CWVoo79rJIhFxcP1Zi6lbWRJyVheMfi9XXd+LkGTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSIdpaODtB+aHqFtUck7++UOHqOORLRFoUTAFIohWEhlW4A+OIW/t09SfNo+FYnmeun2xH9i9z2WRe8t673OGonOKqIoOsunuQNJh4Fg9gXFhY3AkNDtOKJFHNbu/v/wb7r7HTnYWe5zCDSVqqV6HeVRoy7EUcbZISi1OMycq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j19zi5vc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aVpK38KF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A757e0v2273380
	for <netdev@vger.kernel.org>; Fri, 7 Nov 2025 10:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qy4xZjaDaueCuwPTRvX9IC7D9BFWUmRUOg/PJT9rm94=; b=j19zi5vcZvZc+J3h
	eil5EXgb7o+MHafKBi9Slf1MAsHwht9ShJKuhVBN4IuNbfkFvOasu8HUs+laic1i
	ApQFCQDDkr0nR1Z4s/mFsEJRFNaTWW7B62zkTCNyqa8FVCGzmDgnRi4aJaWpx3yo
	7YBrhqEKVuWBhNuAaoE60NFeKFuxZH+p+rn0tyDvgwMCTDDPUaOdyqcmIN20Yni7
	e+FAQn327eA/EMJkdOZ1oKcI5NWQiBeaIRCP9KmnXRYAWj3UM/IlF2kolv1vNI8Y
	9Rr7K9olNJaawFxFkksQTdDzKZOepplYR1QpfkBYS3jwKcxtOTKS7ODirqnsgtuo
	rorS0A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9abmrytc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 10:49:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b22253132cso21447285a.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 02:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762512597; x=1763117397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qy4xZjaDaueCuwPTRvX9IC7D9BFWUmRUOg/PJT9rm94=;
        b=aVpK38KFUkFW6kHSwtDvmqmr+IpLTyoG+3Gj2IH6kwa7KJ9sRechIttPb6jEiqRkIT
         shiAQol5uzyZL7OUgnKhrLYoTq3W8g+FmNJbcRgmFmtueqEFfXqKIkbSdm79N+EIESeI
         aF+3ys97Ay+qY41i5G/AJleovoe3ssLGjj3GCoyw+2fE9EiRwzWu9P6n2/XX4K/FXjED
         qsJBWCUkM/9u6u8IC4/xzcXdaxlS43MobCRNrBQD58R2Sf8BOZLdDCMqwfNQF/EeLQJB
         5EZ9ecmojBYR+VkpotxpmrkAps9jZPwIdB5DOTLaN0M9TgkFTXgSrepDr+q0gJ9yWJMy
         KY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512597; x=1763117397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qy4xZjaDaueCuwPTRvX9IC7D9BFWUmRUOg/PJT9rm94=;
        b=SUFUIZMupqCBJn6xETbZwODzCuQnLagmZMmEtbyMtg7lBOPYp6OXQXNQkj58G3IrCR
         3zs62BR8JxvhdKYp/QsvSnOZmA0izZV8LuOfGI3gK+HPNFcyp2Sp7oiSTVLgbO0s9WDX
         KwJqDpPqxWp5HmTdvf4MxKXkRAkFKkLQpvaZj4qQJJxLtBNZzCm5HxfMHKEF1YJLGDCJ
         sfRVkGFILl4IkuyjXZTTDVacLQyYkOEloM8CeqBBD34UP428g+22Fs64FklmcM11QIoU
         t0ewK08pVm7ehsOk4PwXrw+dauUEmBGqqQrhhDK+tQZWw1IjMtWWvTVrek4dYKyZc/m7
         Cq5w==
X-Forwarded-Encrypted: i=1; AJvYcCU4qu1jOjLhC0V8sisiy6l3f0SuqyfVs2RBKetBQkTusUZCjT9+uN6gSyKwpYfhVT44YeueQe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdv/eeuU7QQyrONMCtE1MF3Ew5oK4Q+usQLNGRuJUPFYUpIHpX
	qL3kxYSKjV2SgQNx2GqlvInPnmHrS/e1xMzICCXVAg/mHvwIyNEy6yVeNTsCMCnPkgTNdnkpgdX
	kZzPfF34RU17scHgLP15iFQqgqIQTpkLZllkOBbGzL7A7QiDxAGefY5Mrjgo=
X-Gm-Gg: ASbGncs2ojDlxxOvYjiXSIPW7lVjufaQdVkNFVsIuzG9YqhdDyfy/50rSU4f0g2MDwX
	5EQaVWukJNkFnT86abGt32NXzstgTCqBjVA+wnm9ZozLFUtGuz/bAgZxM/cjQYcdRvMzSrjaG05
	1AAUaGcXBoBzhbSkc6i0pHEvCs53/YIsfCNIhGnZ9uOBocKF6sNpifJDLezDA+s9kciteRaaCx/
	tSC0GGKbpBcgtwAOKi29vsGb0Oo3Mq/1aOKEbd/5CNpHv2373H3t6DH5kn8qswI2qKFIVzYCPYR
	diIEUuabtPKWjdd4jKrG7Rnx+1Vxc5G/OoEVS23OUUtmX+D+RYCJy6LgfQWdA6baI5btXMkuKom
	RVjjn6faD5EAI/+nyckZyusKN87szIkO6QXA1VeutrZuPw724bbr5cp1o
X-Received: by 2002:ac8:5a51:0:b0:4e8:966b:459b with SMTP id d75a77b69052e-4ed949bb0f9mr18063361cf.5.1762512596826;
        Fri, 07 Nov 2025 02:49:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb3Xbou/G0Zzd63eLA+eutWoqm0V75Q2RL/wdtW4sHDSzQGKhPaQSn2W6oLQojU83FQkCi9A==
X-Received: by 2002:ac8:5a51:0:b0:4e8:966b:459b with SMTP id d75a77b69052e-4ed949bb0f9mr18062921cf.5.1762512596362;
        Fri, 07 Nov 2025 02:49:56 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bc2fcsm204678566b.50.2025.11.07.02.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:49:55 -0800 (PST)
Message-ID: <21a3d269-76e6-4da9-aa25-bfd1fb6dfb07@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 11:49:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] net: stmmac: qcom-ethqos: use generic device
 properties
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
 <20251107-qcom-sa8255p-emac-v5-2-01d3e3aaf388@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251107-qcom-sa8255p-emac-v5-2-01d3e3aaf388@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WCs9JjPlQNwFfwdKb3zWHqWd2uGlSG0C
X-Proofpoint-ORIG-GUID: WCs9JjPlQNwFfwdKb3zWHqWd2uGlSG0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NyBTYWx0ZWRfX/DLBMf2DNO2K
 u6p9A+uhZr+tWl9mtKcxMEHcZVe1zuiQJrKKGqWwEyzRISh/8tfSFkMgKuGniIEITqcEoidifk5
 l/RoJfeB8CZ8z/woXP+T1tEXPtgHo8XXbLByCpWattZR0jVYkiuAvq0xeHPumFF2iwNnemRRBOQ
 ahoUSBpex6d16X3ttpaGrRVcSbE4Ksqhu06IjtBCL1EkGeUxzL6ZkTpe2XfnlSJG/3pO4SBfSUK
 pPT+N875l9E0QTnNmaEDgPFGG3eBjhK9M3hi49bL4sbAP3bHwOr9HKLuVRLWjiDxd2ao658sv3c
 Uiw2oJNPAhjvCZEpbhGVONills5cpSosYxAmLR6cu6w2kjUPOQ8MVmHND/3lC+gwPgLpgmJc6UJ
 ZbW948F4j4FmUCOoTUW6IzOs3usv/g==
X-Authority-Analysis: v=2.4 cv=HPjO14tv c=1 sm=1 tr=0 ts=690dced5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=xTS94RJRWet4TjKJq7QA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070087

On 11/7/25 11:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to drop the dependency on CONFIG_OF, convert all device property
> getters from OF-specific to generic device properties and stop pulling
> in any linux/of.h symbols.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

[...]

> -	if (of_property_read_bool(np, "snps,tso"))
> +	if (device_property_present(dev, "snps,tso"))

This is a change in behavior - "snps,tso = <0>" would have previously
returned false, it now returns true

although it seems like it's the plat driver clunkily working around
not including the common compatible and inlining parts of the common
probe functions..

Konrad


