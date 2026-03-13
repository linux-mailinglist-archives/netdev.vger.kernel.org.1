Return-Path: <netdev+bounces-267399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM+vOGfqs2nadAAAu9opvQ
	(envelope-from <netdev+bounces-267399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:43:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C0281A91
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778023241B74
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF9390CAE;
	Fri, 13 Mar 2026 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bebmByIP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jlbbIkTG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9793914E9
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398344; cv=none; b=sU8qkNATHsSLVXUsql+B2UilIHfsvCrJmVRP3JK0du2loqYXmEZXFYwKMbP2xwlA2q+SyGP9tJ28OQfbg/G4w+wtFsPmyesgQrD6AuVtVZGyt+ms3IBZUXPJdw7I1NNyNuUuDFoRgmSlXWtUU386uBJjuvopGT9vB4bCVGHAtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398344; c=relaxed/simple;
	bh=FoqFSSAiTfyIAuZzoV7iXeidCJ9wGZojo02/RhEIEps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFI0NUZt1meSMvKiA3ZD3IV/8r7GZ9Q1WvPGRL4U8a/k6nVQkl58TxVIYkf1rgl9kjPF102MszCV6j5Qh51Tf4uzHccZauXshcYQqimlAFsvWpBwpp1VIDieVN/CMr7d0cC0wLpuXT5zQ2F3TAylEfsBa/ctbRusgo0YFdo7NWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bebmByIP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jlbbIkTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5taMY3229811
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WSrl/GiyTFY
	uo8iwDHPoqBFgN8PwcEDEUqLDvv0RTlA=; b=bebmByIPKFS6zIoSaioPiDaaHrA
	pbIBwV3xvJdq2qBVUX5CGIuju2+eqFQMTRjjn0A7W9sJBE8i4RYirphshtccZi9S
	YHfAnFAcujpKzw1c4Sot6ewPemK/CnuSjdNaRfbaFxiIYWOgOWybj1Sy4CAbFsKU
	97/DJQnVd23GcEqlBXQh0J9sMDOPPoggleRMf9SgIEo1pUGkDKJ2GI8PD1qqDX/c
	p+JSKab9okXZj0x6EBHoSjRxMbcI5uZOaTAoG4bnY0h9MGQa5XcrxwKlImudo6iC
	W2Epqe3WJkLqnV+B/Kiou8Em+/N4hOGD4yf8IPLdB4xIezj3jI1ch/PZaeg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7hs0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7de0e161so1375307885a.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773398338; x=1774003138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSrl/GiyTFYuo8iwDHPoqBFgN8PwcEDEUqLDvv0RTlA=;
        b=jlbbIkTGR6EBm6JeRIhsX27ve9WxunIffqbB/LvEUb12rDQEWLMLOdKoH3+mBvgdkS
         VH9tMsjgTKKH1J6GBJtM+nEnSF0lzMCr1vjNiBVmZcNMxhfZJWdocXITkr7mDjgytuh/
         bV0nBnXnocHD9pa1WaY1ibE0+6p8zO1szklTNcY7MH/9ewKPfd8a2bkNClqDjXoWRJus
         o1lfU8S/+umF1sV2Bq34vyQPWHC3sP8SCpAc1trFOCh6lGx8IrQKwWVQHAkHGSt76RfN
         7Jr2hd8BmNeNNJ0M1HzXS5EembLmKV60XHH2+veCNkPoYqJZFhGx/SQC937zMbvK7G00
         9WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398338; x=1774003138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSrl/GiyTFYuo8iwDHPoqBFgN8PwcEDEUqLDvv0RTlA=;
        b=gy+rJzSWykowf6jEm4dQXdbbYeOjWY034wwOc5GtAcB4NnmBORNQswDWLLh4dc463y
         ptbocczIb7GjCpR8/rs6YvS7DmLQGSEyd7zhE90hBjQ40FQ5mbXU9R+PRxiIPN+ecPAd
         KPU2bdeL3PyPNqsBt04G7AlTz+dwWkBHfkDoEPA2D0Gud6LnUW9Nu/33sKZaJciNBtUt
         KVR3knVJjRq1pGtBl5W1oSrrv/Of9f3YAhkijMg9VMveoaaWDQNMc19EobA5bE/1pxBR
         RqcZ/fXFe6h5xrF8vGty/Krx3unBZegDKHqrPxRpLm4+nI4paJivkq/ooPByZ1ylItHL
         AyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJQdQsiVBuTzhMpWREybiXTKQ0UB9o401dka8gz02A8FqYF4z5vpzF58zL4FXLdJU2F8XW5Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxu2JcgoOeWwIOPyskHzb8NmeO3W2CIJGM8BnMQ8uzFs+KZ8m
	g+F8bgTw94mYB4A1bbqQNcId3lDFOO7j9i+C1PqkxLytEP5kgfcFLHTnho/fco//HFKrCbadpTT
	VPHz1/xuMQOOgkixxpYy9Mq4dbtUSXxTkdyG1wRlekA4cmzXhjyS5+KnPC0Q=
X-Gm-Gg: ATEYQzzOOGh4yqvDWHgZLy2ppGHT1yJV198q3uLGbKMFZnePHPOSnZjaGTGspAbGrAS
	dGmnAw/F6wy/ZnEcu9y7Coi9MvWTC5kbW0EHVm0efaZBNFkCzlKn+gPeAZ/ZqqaQjjjCWfdfHRB
	J8BuBITAksWmNKffKrMr6EziEF5VWk/y1nodEYSYjaoSQp+oa+uJfO+Vzts3KNg9P77/K6FUoZe
	Nz7dkBZFixCPfD8H9Xd1rwWOX6lOyWVi0h+jmMuWUf3oxLcLchzzp9ZdEuv9ShP2XbjFzLbaXII
	gMX24LNxBOrOmYksUMVmTVfitBR9CHJ+6rVgfUm9ICS7qErv2deltoda0HapzISejV3osslPNdD
	JaJwJuuVggMkAqqJMALbG/h6s0tdCBOLYsmSEx7KX7EvV/Zrv46AyOow=
X-Received: by 2002:a05:620a:4092:b0:8cd:7fc0:ee1d with SMTP id af79cd13be357-8cdb5b23729mr387023785a.46.1773398337948;
        Fri, 13 Mar 2026 03:38:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4092:b0:8cd:7fc0:ee1d with SMTP id af79cd13be357-8cdb5b23729mr387019585a.46.1773398337375;
        Fri, 13 Mar 2026 03:38:57 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556426be9sm20183445e9.9.2026.03.13.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:38:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, r.mereu@arduino.cc, m.facchin@arduino.cc,
        geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 7/7] arm64: defconfig: Enable configs for Arduino VENTUNO Q
Date: Fri, 13 Mar 2026 10:38:22 +0000
Message-ID: <20260313103824.2634519-8-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8Ttg0E2N0RLSiTECdnYoal1XYxBBSQO6
X-Proofpoint-GUID: 8Ttg0E2N0RLSiTECdnYoal1XYxBBSQO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MyBTYWx0ZWRfX31z2Kv3GCI5R
 ktzuZsqI+smi3jlUw89ERJSoH+ebIf7hoQH2UrX0v8TxQRT305ViXLsNB+gQaE7LFnb1MHWzx++
 iciRZ1fR1iz/6MYaZCpoL0QnBa/HJDtCoVGWvLfD/54spGkLtUH0+I60LChABsV/DJ6k9hjsiLk
 SFItToMAOPzwGVzzSL3P0vHKFeEdSzkvGV1FJFbNhmRsUhEspTG7sAV4S8LN+5D/0VlQU6NZ2Zm
 tUHoyIKzOLmZ5tQY7E4x+/xm5VuK7lGPiuVaJ8894u331NxusKR1F/nv1AgGFFfUe4+xxzDPCBb
 22XmldrCP9WZwY3OjMcQpaR3+7gspZI1sdgCoCqPV7RIGDKezeQQSIPA2+CfERhNITUXuvQRQqi
 PQqgPM4x4+Tg/d6cSAUkSDLS0poPpLAFTC5QHLus0V97tjUi1RSf/hgCTcB/1EnfhmvrTo8p942
 tMCTFaQoHf1JyBerd8A==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3e942 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=rO3wVDe-YCVyVCuK1RsA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130083
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267399-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B5C0281A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable ETHERNET PHY and Analog codec configs required for Arduino
VENTUNO Q board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4ed70ab7ee85..aefb8a81b78a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -416,6 +416,7 @@ CONFIG_MARVELL_88Q2XXX_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
 CONFIG_AT803X_PHY=y
+CONFIG_QCA808X_PHY=m
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
@@ -1145,6 +1146,7 @@ CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_ES8316=m
 CONFIG_SND_SOC_ES8328_I2C=m
 CONFIG_SND_SOC_GTM601=m
+CONFIG_SND_SOC_MAX98090=m
 CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
-- 
2.47.3


