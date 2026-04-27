Return-Path: <netdev+bounces-281239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKiqFloJ72n14QAAu9opvQ
	(envelope-from <netdev+bounces-281239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:59:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA546DF41
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 049263003349
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559E38B7AA;
	Mon, 27 Apr 2026 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nunDnelL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZsvnSio+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02138F94C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273175; cv=none; b=M2lQ2CEj7OGU3eiQTWmkTzUWWk3mpGM12Pr957gmEzB4N8+HlpSTYUDOrNM+/h18vAqUD2jMa0aiYrimp8xuLeu8ePAMvoMyibpCPGz2DmPULdSEVw3JIdrgW5/qqAzr5XpnLGMKJ4gH20cQseDnEg3U5WWPrl9fOL4xkIjI+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273175; c=relaxed/simple;
	bh=aCugtkMf6aJ0OVMPv0dnDT1aFITKTjqn3PBqRuiiC1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EuXqGGnqZhOttdYO9/bHQ7dMh248j74PLqexlvlnSao9IJa49EYLHrC9r4DFpPW4DaAYS4dHVrbfziHNNchn67mLwR4Jm+cubtI4LrMndgxMd5NEhtLmwZdoCfuloZzajTwjTI0w/M+/LWon54ywGaAMZDNylXnFwH+vMrYi9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nunDnelL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZsvnSio+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMmBYa2431305
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ZR9Qj+ESn6Wxh+5MA18JF0X50lTB4LGYiCm
	X/zZ9vQQ=; b=nunDnelLOng8JDVZzdmF108i/jt2IZEeE9z+lAzyZ+hJelpyuQA
	76FMA7BpoiU4Eo+l1CmJHCvCFFKVLxg+NHdtBRrcdjj7vyA2aTwvhgJ7hfhPthrx
	5s2Q+xKZxet/C7u0AMZrLc7WlUOukRNDterJg9rd5Y/GzGu/qiHbxN5IXdGNA6Mg
	IwTyKRJmpuBUQAsgjd+VeRTQ7PooUbYX66FAvvDHIv6x/99jzYWWxOWImIKP658i
	mtB/4QhkHqL5IakGhXQuB0PFQFWCInHce/2ITWrhQVz/mPz3cRv/xaEJ2FxXyipK
	o90zUqry3clxZZzlrn1wlIwDU8upmqYkYbQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr4ss7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:59:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e575a50bcso103133311cf.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777273173; x=1777877973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR9Qj+ESn6Wxh+5MA18JF0X50lTB4LGYiCmX/zZ9vQQ=;
        b=ZsvnSio+Lpno0H95qkmqYBeiqBzUTwRxHYk7QUvDIDCaarsSNP/FSpceoPXlSW5D5b
         QcEn1ka2qZaa0yaKjBZn94S8Dgk1RgM7uZWJPKqc0GFhy3xyLrf9fPXYnP1GwkV2P6Xk
         KFYPoYwXr0I80OxqkoXQdFKHgBkZyu26zyigSOYMeDflbTLrfMUm3k/gwUobUhqH0reB
         6xgFB75L5y9gUAWJdWb9JHNa1ingxQpRwUGqOMGEKv8YclAFR5whxcLgp4PMl3tPdOSW
         KwTBWAobS54eAhaqqu8lcoriNGMNzgGoQ/Jm9BYUWo7UcRV9aiTCx/rmp1ERRvkQEvP8
         62Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777273173; x=1777877973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR9Qj+ESn6Wxh+5MA18JF0X50lTB4LGYiCmX/zZ9vQQ=;
        b=DqQ/vdKeaO0MyjajVJTzSrqqrSO3CV5Mygq3YaEVp4goNIgT/baqpmdGSxLXVOX+vW
         J8xCmF3WWvHD5l2YCSalHggSYt5/ASDLUXW6M3TO2J5hjkQ3n+OaXJbnQKbyEEWczCpu
         2rVqvOcY0O+2PdOE1mISbVkOVCLfcCQsVXF3aC6zlg/ZdQ0b+/34nhRuBmE7TGES/om7
         +5SSzcpBhBpmjVeUqAIMPa2cNeo+fESsq9b6gu7LTyFR8sajv3txE1qe0tR8R+UVpH2t
         jWaOdRo7qR/I1D9YQdxSclUG4xv+psaD448hkuOE4Hdom/JMEXGjwiB7oka4wnuJZyjY
         w7aw==
X-Forwarded-Encrypted: i=1; AFNElJ8KeLiWnLGGf+0kGvB6SrqxNaBkU4OCOjjacn118Iip7FHjtVSAQK6kUy9QTWVdOeEA+q63WkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyk9oV+gHZUli0x94AgybyOCW+AdFQtJgpFIWnYoTrk5BMPZlF
	soKVwQr3Husi6e03t4JM8/AST1PtZ8qOwKDZvSd+u5hwK15nBq2Tc9Mk1Ab/xVypOW3HqYdY1Fm
	q82a5kkrBroxFKeOCSBeK19gpcLYkEpNxgpcqO9Gcg5HgO8L4Jp3MUOZwo+k=
X-Gm-Gg: AeBDievuk1G1hwmbA1+rqBsbzCFceCLKFTk+gfKG60Sa3FfrOyhQDRQOHzmL2tA4XJq
	0O+c6+oLnGZq3woE+JZD1rebDcB8Xwfs38h6G/3wKbNsAkFlm/pwvytuVtUE94gpGFU2wCX6h/S
	Xvmu/uwPIElzgAJtbZ/WRTzJvwZHgcpd2L7weNWcpwmA86kJGLGnZSfL5rP+dt6siV6ulLTTKtW
	r4COWuUQajv9SZjKDG+Y71ZiqLL8aiOurtLzZQuW31rXOdtGQvEGX7qdSBJqRQQOf90TftooX5h
	xv8vtRFKp3BHWN/QzTd86sp8CiyUJphjJesNKG3qt6xomtIf+Eakmc5eBeWPBjNWNuCGirV715S
	YEFgZhjtrFLKM/RrJfsJjNMt6rv5C/TNuwC51cMkFYGsAdtj2DlAG/+KcVBNTw31CJnyWHlFwGw
	ZpTELerX/0SQ==
X-Received: by 2002:a05:622a:590f:b0:50f:b465:94ae with SMTP id d75a77b69052e-50fb465a5d0mr404239301cf.29.1777273172928;
        Sun, 26 Apr 2026 23:59:32 -0700 (PDT)
X-Received: by 2002:a05:622a:590f:b0:50f:b465:94ae with SMTP id d75a77b69052e-50fb465a5d0mr404239081cf.29.1777273172456;
        Sun, 26 Apr 2026 23:59:32 -0700 (PDT)
Received: from quoll (5-226-109-134.static.ip.netia.com.pl. [5.226.109.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6124d7e7sm458447415e9.5.2026.04.26.23.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 23:59:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next] net: Unify user-visible "Qualcomm" name
Date: Mon, 27 Apr 2026 08:59:25 +0200
Message-ID: <20260427065924.17520-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=aCugtkMf6aJ0OVMPv0dnDT1aFITKTjqn3PBqRuiiC1A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp7wlMcmFBiV+HF1D49v82ttgrfqX1KJdE9qEyV
 vZQUWvEDTeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCae8JTAAKCRDBN2bmhouD
 10u8D/9yWPp9QBcgO6m8pa/Zu3VAPhRRCw9oreRO2k8GVOwtUEf1XuSma2r2c0j0B0IJC4xTzZ+
 /M09abcqV1LXjenW9OF1cSZ6rUg8/lTYKukpnHFsU9qfccD96OpY101bdEM06X0e3U7OKfECyHq
 a0LvmRhPtWh3lkIBcSeZA67FGq/Ff36KNpdbuoO6ii/mRKYUkdGF9iNPok84xKYnMsWmRqNyopt
 i2Edtp0my8t3maMzdFCIi2jpq84b6xn5EeHnjH7NUFMAGz6DM5dOTJE5DsSZh8iIx0UpiFQDG5m
 y8YRPlc5fvM9Z3lVuqGzYz6KQ7e6cKlTqAkTzAWMJ6CXskwx5cHXR5fiAotGggYt79Pq/lx8cKS
 LVT/IetENWI1vKj5788odUGzWk1babHykglrvnUFAukHgqVX0HLqGRS7H+matBNLgHUOvFJJmpn
 mCt2L+m446LCXxXr4m6BEZl3gPlrjSq+C1Zf3117UB5/IJ3CortkSH/QnLMdxzaUkGn3U/VPORV
 qzmFXOzoeNsQMGzAjsBuUpNs0m4r2181nzQGFjkTs85GZyxlCcYYTZqBObyQqx21US49cNQPJvv
 UcOdFh2n8G1rwIOzLVjQOfDFJmBDIx9INYzshV0WPK49k8hG94mqqSslLz4FhwJAtsd3I9Eou7a pNizg7TcOHwyzpg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ef0955 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nnYKl1aPHK5ktf5uHVwi7Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hZwkdpzl5lozqrpNwogA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: CUpSYBr46NIxBptXyw8Fgw_BO3VydEYY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA3MiBTYWx0ZWRfX8NiBUgI4IzVP
 sdTyTTaa+iwyYsyE1E8QLDAzl3ebp9LlPcPaVqoFs76wtjVjrvOA3axiAuiqFXqBwtY6Fwc1uaz
 RfwHKLYdPEJBssrL/lolta+twP6iBhc6S1LORaHL0GEWqsunRA54Y7g7ejUZrc/tZCUDVomvqO5
 FSemmKfmERD/+RLpAvZCWdnQM0pfXZlh0lG2jU2aSZXljgFOmHejDwJh+2JFv6YObqBqMvkpQLJ
 NS/f4A75ZUMsLVr2u9TVaEd2ZQlOZDtoJZ637BZOeBmuwHrWMTRrftIyvD0qv+CzuuNT65QPGK8
 kecfrawl/6EId3NZ281ptQ0uyVFDPAeW96tLPTrhI3InubeQYLvv0RaRZAfOxwIPSTgTcPYlXXp
 4okD/XplYE2Z9VKR21tg+VaeLe3W5KuY+In5eSwuW8Cy817B2HercT/KcSbSq4wX6+3GA49hIeq
 yeDpvhNeV6yeidoubRg==
X-Proofpoint-ORIG-GUID: CUpSYBr46NIxBptXyw8Fgw_BO3VydEYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270072
X-Rspamd-Queue-Id: EDBA546DF41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281239-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/net/ethernet/qualcomm/Kconfig | 4 ++--
 drivers/net/wwan/Kconfig              | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index ba7efb108637..57e1984d20ee 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -48,7 +48,7 @@ config QCA7000_UART
 	  will be called qcauart.
 
 config QCOM_EMAC
-	tristate "Qualcomm Technologies, Inc. EMAC Gigabit Ethernet support"
+	tristate "Qualcomm EMAC Gigabit Ethernet support"
 	depends on HAS_DMA && HAS_IOMEM
 	select CRC32
 	select PHYLIB
@@ -61,7 +61,7 @@ config QCOM_EMAC
 	  Precision Clock Synchronization Protocol.
 
 config QCOM_PPE
-	tristate "Qualcomm Technologies, Inc. PPE Ethernet support"
+	tristate "Qualcomm PPE Ethernet support"
 	depends on COMMON_CLK && HAS_IOMEM && OF
 	depends on ARCH_QCOM || COMPILE_TEST
 	select REGMAP_MMIO
diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 88df55d78d90..958dbc7347fa 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -38,7 +38,7 @@ config WWAN_HWSIM
 	  called wwan_hwsim.  If unsure, say N.
 
 config MHI_WWAN_CTRL
-	tristate "MHI WWAN control driver for QCOM-based PCIe modems"
+	tristate "MHI WWAN control driver for Qualcomm-based PCIe modems"
 	depends on MHI_BUS
 	help
 	  MHI WWAN CTRL allows QCOM-based PCIe modems to expose different modem
@@ -51,7 +51,7 @@ config MHI_WWAN_CTRL
 	  called mhi_wwan_ctrl.
 
 config MHI_WWAN_MBIM
-        tristate "MHI WWAN MBIM network driver for QCOM-based PCIe modems"
+        tristate "MHI WWAN MBIM network driver for Qualcomm-based PCIe modems"
         depends on MHI_BUS
         help
           MHI WWAN MBIM is a WWAN network driver for QCOM-based PCIe modems.
-- 
2.51.0


