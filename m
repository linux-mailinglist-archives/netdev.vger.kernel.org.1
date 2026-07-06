Return-Path: <netdev+bounces-305034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r7IUGsWwS2pYYgEAu9opvQ
	(envelope-from <netdev+bounces-305034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:42:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F171165D
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 15:42:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Bx6/5iA8";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=U1aKr+cd;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305034-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305034-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C537D3076C17
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE73423775;
	Mon,  6 Jul 2026 13:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45440DFCF
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:20:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344055; cv=none; b=ts0n2gQxuKEpYRqqK78DsDAIwZDinLGdxUR0iRE0CbigjboNSggdEvFsY+Td2xkp1CiapfWj84ePn6BOAFQ7g+WVW/Hh80ifE0d3BjXk4d2O9o6oANL3cV6Ue+H5sZQNHuleNIhLCwkPeQYH2rlGFO6kIWKDGOBVkTNbqrBdSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344055; c=relaxed/simple;
	bh=px3gFNalJW0myw4JO8FxOi8xC4WUF57/BsmFQdIQdYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRrGKoF6n1q+xd9szVl7Wj7dRxlFpGgqXwx6MxclnKknN+CTJ2ngIXnr6jD/hmvVitH/R1ZX618hlAHRH3JxcPOfnFv2oui6W09l2FrIQiq1vz5LyQBtX2WAvkO0r8FAw7cTzYyhXHja8eumTDlH5h8qvB/wlJnHA9ed2XdN7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bx6/5iA8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U1aKr+cd; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxLPp367215
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 13:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vgfh2/38B3WhwVMaRw3DoRNAiK5OOTw4W1PNnpwazmU=; b=Bx6/5iA8yJdpooEK
	R2A+v9gulHZ0/xkiPZwpFWlwTCFG/s9Hpm1m8cPKBU5weMyM3ELRPL/80Q5Stnrx
	iMwvKi2tOtMu0gDZ8Jxt1DODBXblbCH6zbaXbl011l19fyRsvuCS308SV4KZ1vCL
	wiW8KzLanfWIPHYVTZrusFNdQdTaK54hkqDFTid3Ra5yu3FCJ46T6FWvzhZlTJhW
	CU87NG3zJ7ozueEYfJ4/gAI+3b4MK/VCd1h/6fSPzvNVOxKDbulHBkPyNi3tzaIK
	FMtZ8NewXu3R6g2Zl5hOL+oA+3+SEWa54HnCIvLSJJz1+E0+k5/92rkh9cmMxMo9
	DzIB5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891us2f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 13:20:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e820609d9so221038385a.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783344045; x=1783948845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgfh2/38B3WhwVMaRw3DoRNAiK5OOTw4W1PNnpwazmU=;
        b=U1aKr+cdoJckY9EUEwv52qe2bWUlmF5pWlotkT2qawFcVWlTiROWwjKiYPVo6xrC6d
         pkWeYqSJNZ1eQ0TMd6saF4ZIsGSYEin1DTAZiTpdP0jmMBTXncXrHTY2VIk0c4cSLjqy
         imeS3qhp69E57OkAmWak5c2hnjhEVPqlRgkisyVDlykyZgxK+riyE5Gq5CDousc7jHbD
         ER/ZcPNVGKo1CjpnlB67wjr+r4BTO381ll1lYARRIwyGzYNsdYFnvqil8ejFd9A65L2X
         EB5knaKz41Axs6rMqUYghfQ+eOjmlTz0CVLMt+Wd8qlacAyeKJBt1HNbG6ebWzzRCQWx
         xUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344045; x=1783948845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vgfh2/38B3WhwVMaRw3DoRNAiK5OOTw4W1PNnpwazmU=;
        b=Cp8cOZM2JZfRWPv7A/0QIymtRvGpP/cSo2zPA8kMi0TGOU1qvJtVATj4f6bUyarksm
         jzH4EGdrxz1Uj4bHIW/t5LQoRPVVxgULld8m40tMMrmRXXZdEsJayvS9XEKpWvIhEaMi
         r7OHSSjWDcpaYghhMdodHCHTsq1BThr3a/rYiPNE7vyQZWk6A0Px20FsOjVlK43gxjVN
         uNARr/hDJTeYiVlbn6mL+bzICF7HcUZEA27gRrQ6iNMyHQkIUqlFCzHA75m6rQdL8DMN
         1hq0XjcSrQA7sQshj9ded0y7vpJQU4VcK8Jlbm/PI7IUEqzzpjYB0OrDNITERCI0HxV2
         nJgQ==
X-Forwarded-Encrypted: i=1; AHgh+RooLHRpuxMro1/WmZU8Rr5soZS/u6uDa4njJEx7YMBP+nocBCM/qeAGBcOD1Tb+WDYDUsj5fww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsME1hBuZGeN4uoDMoGXukU5VqCEQomCa0S4CBrv736wfTqbga
	QKisms68ZY7ky/4wO2OiBqzUpKOLb1mcSC7c32IXMrouioknXe23HzTDlWMSqmqtlgYd2VtVEh4
	pdVYfkATuHH2J37iGzAD0QYypRQpQos+WqakTUO+TCcSR/Inub8i9X5sKTgg=
X-Gm-Gg: AfdE7cmZNLIJA8py1cnwprMKAw9lpTq2QALsyO7KdElY4wN17gYMbWPmYyd2igCuIRl
	LyqAEr9I8pOgiVcpH4/VJz8wsnEYtk7628ucRNhOzSrvJIeWvF2koTpQOgXbB99WzEsUGoRj2Bb
	TLJuufPoXMO6P0rCM6zxU9tq5R+/IRNKymX4v0ewuCgEH4vpLAtA5vqEWoYXIG7DHngaq3PmD55
	eK2lj2PnnpGyU2U5FVo/ZEGNm3/mBEjwO0mA3RaYIlP4SM0tc96Akf1a/97w1Nt32ly533sag6/
	ACgGA8j86LoDp5k+khCzxH3t8RnQTA3rlgcMuoL9eiwtShDdfB0DGxQkZfLrZYqh5sTidPnPRS+
	f/ZsB11imzh8UYL0ou8H044HGPSLHrooIQZ7tECTy
X-Received: by 2002:a05:620a:27cd:b0:92a:c203:471e with SMTP id af79cd13be357-92ebb4c940emr65807085a.9.1783344043975;
        Mon, 06 Jul 2026 06:20:43 -0700 (PDT)
X-Received: by 2002:a05:620a:27cd:b0:92a:c203:471e with SMTP id af79cd13be357-92ebb4c940emr65795885a.9.1783344043148;
        Mon, 06 Jul 2026 06:20:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ad69519c2sm25910584f8f.37.2026.07.06.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:20:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 15:20:17 +0200
Subject: [PATCH net-next v12 2/7] phy: qcom: add the SGMII SerDes PHY
 driver for SCMI systems
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-qcom-sa8255p-emac-v12-2-e3ab1ecf2901@oss.qualcomm.com>
References: <20260706-qcom-sa8255p-emac-v12-0-e3ab1ecf2901@oss.qualcomm.com>
In-Reply-To: <20260706-qcom-sa8255p-emac-v12-0-e3ab1ecf2901@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Radu Rendec <rrendec@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6726;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=px3gFNalJW0myw4JO8FxOi8xC4WUF57/BsmFQdIQdYc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6uchS4csS4YIcS0mi1Ifm+LIJhbGgTUvShSf
 ydPuYJXWmaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakurnAAKCRAFnS7L/zaE
 w0zzD/9SCsUE9nshAQyInqJLWoFIM8/bv54ACwjrQ2SLcq5ghDCutaXpCzCQFH79QU3gcsV7hid
 9WRL1B3pvXCNlRmZMDmiPdmHymy+1cCQ2nz0kzyELvhGm19aaJyIVRajtt2qkCdUFa9rJTnrL1L
 EHSieziZDKkw0UCo1GTEJZl4oq9Fb08FdSsJBMFI0aRlr8DrhYRVVE1Nj2qjHPRV+RWbNqmSf0K
 69XA2gEVSIYqykcHzGIi1V6hIoxhbwdoJsPv9KoAhoJqv7McGTZkRu2VpR31aH7rAWw1La5PFeH
 KU96pFcBkSvy8a+lh5eJ9ES5FPv/hth4mNWQtUdjugM9b0o1GGTOXkyId2OwBA6IqbaAz4dzKtl
 3u/I28s1UVntXT33yfliBNrV0d3ZVUYOqNXWhDx0yRCv70fP6LJiP8fitPovwynNOlTNHdOHSVH
 3Q+emhc9KPvwGauW5lipa3RqCqGmcwZQsMpyqNQh66czQKWB4V+HFkls+Ao55bX83NRZHK67g4W
 ur9Dokj/KleRMu3g2FU4zm3nR6sdWnRNacQS4MyBnxzSpdDxICRxC6udFodF0Xtw4Wk+jVZvqwX
 ZYoqv4ylO5Kal6ukUy3bUMkLTbCdLXdXPjNekUOOOkss7LcURiWU073B59r/QQSY/BGGwersAeW
 gWBpQTcQFWqJsaA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: twkrp72h4XY78H0dbLl1WxMqem0X2ZwP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX9KY9WK4573sA
 Qohq5+N540AFtexbvPaybeiVRt+NoJx0Op8JHortd8P2SZaCuXuBy6+nwbtV3J2wBK2Dzv1YXaG
 FicFuQxy9t9a+zo/Ds6azRSqaSWJoV4=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4babad cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ZvYg6ySBQLmwDIutsxAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzNiBTYWx0ZWRfX1NoABk+7Atkn
 K+8fPpEiKEoWWB2ufXyp4l1P02GzTFpWHSsT//w3/Jlomd2upSOJEYDumwsO/DnkkszyTKJN7+u
 ZkK68vBpn1kt9SBVtBC81c9K5WzLVXO8fUqeeRZoLPdRsDAS8kMSBYawU859P9f47QI/7A/snok
 CtagCB+DlF09Bt8RFrkJCEYPVjuHmQoERj60Fx0lAlXPRN+UFw2imjWAbSy9OJmz/eGm+HTL0Dd
 eTzLMXdEN7hDbM0vKRaE/0jvLA05yg9JiT5RPhk+rhrWIxzZ5fy2UEjk5DfAwlB6/U+5BFQhEBk
 O1+9JL0w71as4hqHya7D+lp8u1fsxip40VfLfQsSIv1IStLJU67ep8vXt9Cpa7Cje05Fgh7wY0y
 nzzNj0/h9q2Z9ap+qzSsj7eBDYa/p+RyAa/Yv/rd9YOtVu1KrXmf3MQ09FkkaparIWJ3eEb3r1r
 z3cd3nv8tmbqVZ5+uPQ==
X-Proofpoint-ORIG-GUID: twkrp72h4XY78H0dbLl1WxMqem0X2ZwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,st.com,linaro.org,baylibre.com,oss.nxp.com,nxp.com,oss.qualcomm.com,bootlin.com,glider.be];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:vkoul@kernel.org,m:peppe.cavallaro@st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:shawnguo@kernel.org,m:festevam@gmail.com,m:jan.petrous@oss.nxp.com,m:s32@nxp.com,m:mohd.anwar@oss.qualcomm.com,m:romain.gantois@bootlin.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mripard@kernel.org,m:christophe.roullier@foss.st.com,m:brgl@kernel.org,m:rrendec@redhat.com,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:dfustini@tenstorrent.com,m:linux-sunxi@lists.linu
 x.dev,m:linux-amlogic@lists.infradead.org,m:linux-mips@vger.kernel.org,m:imx@lists.linux.dev,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:jernejskrabec@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C92F171165D

Implement support for the firmware-managed SGMII/SerDes PHY present on
Qualcomm platforms. Do this as a separate driver from the HLOS-managed
variant as they don't share almost any code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/phy/qualcomm/Kconfig                   |  11 ++
 drivers/phy/qualcomm/Makefile                  |   1 +
 drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c | 161 +++++++++++++++++++++++++
 3 files changed, 173 insertions(+)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 60a0ead127fa9f08749e1bc686e15cc5eb341c28..a7cf348f6a7aa18e8b3f39f109b02ea672ae4177 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -232,3 +232,14 @@ config PHY_QCOM_SGMII_ETH
 	help
 	  Enable this to support the internal SerDes/SGMII PHY on various
 	  Qualcomm chipsets.
+
+config PHY_QCOM_SGMII_ETH_SCMI
+	tristate "Qualcomm DWMAC SGMII SerDes/PHY driver (firmware managed)"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	select PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Enable this to support the internal SerDes/SGMII PHY on Qualcomm
+	  chipsets where the SerDes hardware (clocks and registers) is owned
+	  by the firmware.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index b71a6a0bed3f1489b1d07664ecd728f1db145986..032e582f2e1af96687484ce28aaba0c2ef73e754 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)	+= phy-qcom-ipq806x-usb.o
 obj-$(CONFIG_PHY_QCOM_SGMII_ETH)	+= phy-qcom-sgmii-eth.o
+obj-$(CONFIG_PHY_QCOM_SGMII_ETH_SCMI)	+= phy-qcom-sgmii-eth-scmi.o
diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..8ee62189556fe4ff0d8aa2f8b105175e08000b7c
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth-scmi.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Firmware-managed variant of the Qualcomm DWMAC SGMII SerDes/PHY driver.
+ */
+
+#include <linux/delay.h>
+#include <linux/ethtool.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+struct qcom_dwmac_sgmii_phy_scmi {
+	unsigned int perf_state;
+};
+
+static int qcom_dwmac_sgmii_phy_scmi_power_on(struct phy *phy)
+{
+	struct qcom_dwmac_sgmii_phy_scmi *priv = phy_get_drvdata(phy);
+	struct device *dev = phy->dev.parent;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = dev_pm_genpd_set_performance_state(dev, priv->perf_state);
+	if (ret) {
+		pm_runtime_put(dev);
+		return ret;
+	}
+
+	usleep_range(5000, 10000);
+
+	return 0;
+}
+
+static int qcom_dwmac_sgmii_phy_scmi_power_off(struct phy *phy)
+{
+	struct device *dev = phy->dev.parent;
+
+	dev_pm_genpd_set_performance_state(dev, 0);
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int qcom_dwmac_sgmii_phy_scmi_validate(struct phy *phy, enum phy_mode mode,
+					      int submode,
+					      union phy_configure_opts *opts)
+{
+	if (mode != PHY_MODE_ETHERNET)
+		return -EINVAL;
+
+	switch (submode) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int qcom_dwmac_sgmii_phy_scmi_set_mode(struct phy *phy, enum phy_mode mode,
+					      int submode)
+{
+	struct qcom_dwmac_sgmii_phy_scmi *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = qcom_dwmac_sgmii_phy_scmi_validate(phy, mode, submode, NULL);
+	if (ret)
+		return ret;
+
+	priv->perf_state = (submode == PHY_INTERFACE_MODE_2500BASEX) ?
+			   SPEED_2500 : SPEED_1000;
+
+	return 0;
+}
+
+static const struct phy_ops qcom_dwmac_sgmii_phy_scmi_ops = {
+	.power_on	= qcom_dwmac_sgmii_phy_scmi_power_on,
+	.power_off	= qcom_dwmac_sgmii_phy_scmi_power_off,
+	.set_mode	= qcom_dwmac_sgmii_phy_scmi_set_mode,
+	.validate	= qcom_dwmac_sgmii_phy_scmi_validate,
+	.owner		= THIS_MODULE,
+};
+
+static void qcom_dwmac_sgmii_phy_scmi_runtime_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_disable(dev);
+}
+
+static int qcom_dwmac_sgmii_phy_scmi_probe(struct platform_device *pdev)
+{
+	struct qcom_dwmac_sgmii_phy_scmi *priv;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct phy *phy;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->perf_state = SPEED_1000;
+
+	/*
+	 * Enable runtime PM on the provider before creating the PHY so that the
+	 * PHY core enables runtime PM on the PHY device too. The single SCMI
+	 * power domain has already been attached to this device by the driver
+	 * core, so runtime PM votes propagate to firmware through the genpd
+	 * device link. No register or clock access is done here - firmware owns
+	 * the SerDes.
+	 */
+	pm_runtime_enable(dev);
+
+	ret = devm_add_action_or_reset(dev, qcom_dwmac_sgmii_phy_scmi_runtime_disable, dev);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, NULL, &qcom_dwmac_sgmii_phy_scmi_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "failed to create the phy\n");
+
+	phy_set_drvdata(phy, priv);
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider))
+		return dev_err_probe(dev, PTR_ERR(provider),
+				     "failed to register the PHY provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_dwmac_sgmii_phy_scmi_of_match[] = {
+	{ .compatible = "qcom,sa8255p-dwmac-sgmii-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_dwmac_sgmii_phy_scmi_of_match);
+
+static struct platform_driver qcom_dwmac_sgmii_phy_scmi_driver = {
+	.probe	= qcom_dwmac_sgmii_phy_scmi_probe,
+	.driver = {
+		.name = "qcom-dwmac-sgmii-phy-scmi",
+		.of_match_table = qcom_dwmac_sgmii_phy_scmi_of_match,
+	},
+};
+module_platform_driver(qcom_dwmac_sgmii_phy_scmi_driver);
+
+MODULE_DESCRIPTION("Qualcomm DWMAC SGMII PHY driver (firmware managed)");
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.47.3


