Return-Path: <netdev+bounces-281751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JBEEKqI8GloUgEAu9opvQ
	(envelope-from <netdev+bounces-281751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505148266B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D8C310B4AD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F13A8FEE;
	Tue, 28 Apr 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nbt4Lvw0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JLXV7ljx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DF3B2FDF
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368827; cv=none; b=tmeOT2h/nRe5PMhZGEdXqLWQq0AiU4PPDo7I/71zON4aqxI983WAYZjJfDHrFs+54MuAQAk++pYNUuDdV6gWPnFADHn5mJV6/mctIKwE9IKulv9xBX585UWmPvMfu/LwZEFyAJS7iYCRbjv+fexhj6kW6PLNSWFl4O6vd/PTurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368827; c=relaxed/simple;
	bh=oIbr13dvz6FiLflBaol/zAHIzoZKqMv762y7Umhxhow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlIQCQzJRBzGY2LjN1d28ZMhFUeqVXkzzB7SRM4OSt20QvKD5DWTGc36X7uEmPXrT1ESZKyofMSzineuxewTTTvs4EAKBTD/gTLsbfdpwyXsb0EFbP1BKGZ53eyz0xewQH7p441GUfcCO7HhTJhy7JiRG4cSehJPbgWAMNm/FwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nbt4Lvw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JLXV7ljx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S3kDfq2112409
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7+CxtxEpud+Zeipqe/WSGydjE6EdsOdpRmG
	W1twmMDk=; b=Nbt4Lvw0galBnSSUV7KpmPj1Ztk9el9UYCADB7q+7eENNsuMvd2
	WH6TmwEkOGF20ZZL3QvGADrVHS6wyUuRJ3mpiUbI7S57LGvVXE8XB8dz2cqG3tGN
	gPvaoY70jb2VEzvPYr9U4duULIGBbNtzJ0900R3e92Fn7DGdr/1+7UL8mHz97EkH
	SxVjh8lpc6ANch+XCZ0IT6zDAOVSYOCktMBVI3Ks6p4obAGWmw7zMsvzFJvq5EVU
	57IeRvGSeetcCeBx9gLuuX3BPBpDl+9TzyvTBSn6mxbpGCiE9CuT81IM5NNgVjXr
	2QTCu41PKJUg/0zS3GFg/H6tohFS0deHrTg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbjv7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:33:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50f13da9684so113690011cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777368824; x=1777973624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+CxtxEpud+Zeipqe/WSGydjE6EdsOdpRmGW1twmMDk=;
        b=JLXV7ljx3Ajm5cSbTaPDV86AAS1Tf4GxdIgNWxlzNnfmHU2Y8DM1pZHlUM2E0OG3e0
         uWIJYllexqcksSC4vxiuqJqw80/YaF2Mm51HvYq2KYi7A5gE74F0OGBCeQTLnWKlnSut
         K+s167NnoGn8tAcyUZh1rKY8WlikirJWlaQlsTGFErzcHlat/fgRGc+f+Xt2MsnuiSr5
         rTeVTi195etp2rsyhvhfVdzud94Z95V3AqCWXxOO7uM3CuxQ73fPch+GPfc1SL7BE60w
         mz4w5YXTPasrug/6xaxjoyQjUtQr1NsbpjTBO9nVDiXfAkIpmxmZRxq+oDMhnfZihctg
         bBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368824; x=1777973624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+CxtxEpud+Zeipqe/WSGydjE6EdsOdpRmGW1twmMDk=;
        b=V1Ob10dL1mwEsp530Dtv8ozOtWSXf7dKKKOj+cDrL9ekabTP6vA8NM5tWviZXDnlTl
         tUjXsdQIq5hMNN+fXKwGaapNRcgCmCRXNJOXvuji3s4mgAqJ5a5/tDFbSmCb8Q9VW50+
         qs7eDSFoL9swqoR9/XsEzIwPJNYuPVoPmS4S007haA6pA4tzyRnL7VWmJul0u03YKMqk
         bZYEMcvou5+bE0DhzctIToMjNFeOys0VU2tyxvYQoWn0lNxs3uYjaVsGizybP6huHNh+
         BuD1wF/pwJXR2rf6Dw1P/leilkdAnqvXp3zoJK1wbKDUu9SlUU7fDqD7+QISaRaIf3mo
         Yy0A==
X-Forwarded-Encrypted: i=1; AFNElJ+cuylgkm8dJy+0RPDP2Tm/OTDcGzIas3Qv22vPr54XVE6IvaZJVVw1Ify6nyfH3snb8NW0Xdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQcTTEs4ihHV66ihxY57hFfKRWTy2vKlHadA5hoBISBZJjWmyF
	qFhqwWoU5fGe/FJLpbISRyI/1DlbwZQdHBJShk6R7awXS5R63fOlSHTrkP4EjXppJy1Bj2kIiAL
	kjVM1EfFt3WuY+59KQrN8NClzDqu86AUnst289jJIfxPHV0BkZnoh8ysGBPI=
X-Gm-Gg: AeBDievzNpEFxVAklOuWK6ybnBCbO1BAXAw2GmmUUHnbjy5I56kUlnmvkc7IEdetRG/
	vhNkrmEP5FEa80v4yXgC2nzZdNWhCDLU50moBSjHttSv+O/m3m3QSsCEC8smpQCy6/5dUmSSo7L
	5fB4mav9+wvfSFGgC3/lc7zDDzyaVHbF6J0goWYf4+aB/fRmMj+59Ocxs8RjYAKzsCmdKBzwp1E
	r9pAgF89MuzXDnR+czxOgv77d5FBU78Rl/waEAsyFIQYoVDuqI9D8eUXb4w3UkyqDYchaRQXVJn
	hameJUncNAakbeXGQP9g+GFKsN6sjd9+WiwawAWImKsgZpjmmhy7AX6R4nWarsUPFcG8G5xvkvF
	pA3MuyTxjSYlw9rBE+3l+f4WBGsdE/Uo+qVawmUEVpblNWjQMdYFZ9ctYocg=
X-Received: by 2002:a05:622a:4899:b0:50d:a8f5:1bf8 with SMTP id d75a77b69052e-5100e1a9202mr28195221cf.37.1777368823892;
        Tue, 28 Apr 2026 02:33:43 -0700 (PDT)
X-Received: by 2002:a05:622a:4899:b0:50d:a8f5:1bf8 with SMTP id d75a77b69052e-5100e1a9202mr28194901cf.37.1777368823420;
        Tue, 28 Apr 2026 02:33:43 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:7473:f19:2705:c566])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7748ef4esm14522855e9.4.2026.04.28.02.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:33:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: brgl@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH net-next v3] net: mdio: drop unneeded dependency on OF_GPIO
Date: Tue, 28 Apr 2026 11:33:38 +0200
Message-ID: <20260428093338.35043-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jDb2DN8tKYlfC1BWImedqqRlUotnXRmQ
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f07ef9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=QQiAXlgM7YpsLHbulJgA:9 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: jDb2DN8tKYlfC1BWImedqqRlUotnXRmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MyBTYWx0ZWRfX0Hzj/n2WZCG4
 rbmoyUlnj5+p5BZ5shB6/r4Wi76DBFNnYL5eXpb0FVQyYMm7Z7+yT6C9tdCZGjggfDckwFdb+/8
 A1gJOP31CZTwS8P4uz4RC71odt1/DSv8N980Fehi0njhnPsjN48K6DsTCW6kQ5LRZmYB86Hx0ej
 GxZfVn8CYyReihStEzLH6r3aBIp0TDnqyL25kd0Wmplb3tiHYNluIQ6iPuL9c40JgBBZ99m9sCX
 h7qPrR7b0LM10axF4RCFQC2wLTVZpARvAD5V6PodAUYyTRif/UD2OXo5f0gcLRvmrTzb8nihKpn
 kOX3gF42sWS/MaGYa5LswyYlTGkWPflhHY3kPCcFTWHcP/RQKxntJIsmT5D6W8hnxVm5kHExJzg
 prZ4SIY+Z9DjVT5oIlf8/hvQP1Wtgntm/zyHGgMRuca/IALuDIv7EJUg3UmU5Jnn5lwWPIPeXQB
 DTg2Z09vLMV5ggfJ8ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280083
X-Rspamd-Queue-Id: 9505148266B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281751-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,msgid.link:url,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v3:
- Send the next patch separately so that it can be picked up
- Link to v2: https://patch.msgid.link/20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com

Changes in v2:
- Make gpio-watchdog depend on OF && GPIOLIB
- Drop picked up patches
- Link to v1: https://patch.msgid.link/20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com

 drivers/net/mdio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index c71132f33f847..c591eec8e97a5 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -254,7 +254,7 @@ config MDIO_BUS_MUX_BCM_IPROC
 
 config MDIO_BUS_MUX_GPIO
 	tristate "GPIO controlled MDIO bus multiplexers"
-	depends on OF_GPIO && OF_MDIO
+	depends on OF_MDIO
 	select MDIO_BUS_MUX
 	help
 	  This module provides a driver for MDIO bus multiplexers that
-- 
2.47.3


