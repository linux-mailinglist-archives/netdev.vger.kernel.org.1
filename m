Return-Path: <netdev+bounces-268091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EH7Gq/Vt2kwWAEAu9opvQ
	(envelope-from <netdev+bounces-268091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:04:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0CA297A22
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 979C530022CF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2123EA8A;
	Mon, 16 Mar 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBz7g6mK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K8NX7pHP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A82338E12A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655457; cv=none; b=PF0xRCPnIoMlnG2IpfV1jIVpYPVYv+/oUEvFXMbjBql/6y8c2VNME0EQtclDluqbhotiUPZ1ztuGDn5b1yAOogZzB2LbSvo+UV7R2hD0SfUO+/fsvNU6IZp3/DuWY3FREyS30lv40Ih42UHGGI+mPGLwnnmLj16PrB07pPuW2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655457; c=relaxed/simple;
	bh=Vzkpe7geG0xidfsuHwfqehUOh5OVIaYZJGxp3ptoMX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U803hs7rGyRLggwr/Tln/pGqhXzjY1QFt32iJWKWl7YnjipmHgUFJnvKie8UAv+q+qZpQdavg92NCzu7STXRiBFEtG1QfvOSgduFfKMxHvM3kiYdNR9L1YB9NONtAKzzTGOzkx702nkHSZ/LVXh9W4N3auxqPmgtkjTdCDWsdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBz7g6mK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K8NX7pHP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64cxq662950
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2GNlj47tjtsxroH5RU+7zc
	nDisp3Zbgr4LYsCqrUc7Y=; b=XBz7g6mKBeRE7V2cXq3npr5cN0Ok7lhtTg6njF
	o0Bf7yLE9QyBBVGRacjn0zI3ZH4rjSfK8Zp0DG22oxIe6PYJl03Bl1OVmQ4Ix5F6
	N8bPjJPrK8wpN6vpytL47PChlYhFURwvaduG8paJyqFtRqEBCG3mTYkGl5V5jTf6
	Z2sA/urg+yuFDQs3McohZ0aJhIPFxsmo0A3fWb/zfKwEFPjR23E/wkERY3H/9jxo
	u6HoSgEDDqjoW/8jlXTc8A0HA4ibB4Qd1x53AFIHzHd0awC+eK8VJNHEQxLALFVn
	NpM+HtwjttZMTkAoEWXbiLxWJSvnWokzsqbozqs5+nBMf60A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043n4xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-509011403a7so242437261cf.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773655455; x=1774260255; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GNlj47tjtsxroH5RU+7zcnDisp3Zbgr4LYsCqrUc7Y=;
        b=K8NX7pHPQ9XbFS/r9AlvjVAfVHXVslQJpNYh24KVzjZhv/MH5OADZR/SC/d9BWCdKD
         qloJsAXvA5oap6g825jS636VeB9Er657pt0qWmI9gFWsIvTtujNUexgP6W9lnFRKz+AX
         BgecJz6lupf89K7SyQUAAhmXKUBt6cgW3lTAGVVMlD0pKW0dRSNRxjZER7Q8Hi9G9LMG
         vlTGuN+CKgVYZobb/ljDENTGxbYXfy5VpHz26rH6QrGBCYPQ2ZxPvwDi96ZdhGsuvgt4
         VtUjeI9XaBEuPvlJaS9HCbdx7Yb1svN9cc8N8XKKXFWOJmferv1srAGuqpIbeLTbqgrB
         IzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655455; x=1774260255;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GNlj47tjtsxroH5RU+7zcnDisp3Zbgr4LYsCqrUc7Y=;
        b=DjGigxf+jPuz1C5kHYtr64pJ33dD8zeN3iVNLsNZ0RoBTXMta7t6ixILbbIj/9sgDf
         VNYkm8kuXUyycALocMtGOeBDnO96cAqP4aVDTm2DJLz/je2bT9bD5GH3sJ0jx7oCTozo
         Ould0tdAl3HWu5Wu1wShPw3uzNDpKVDHlVuQuBDNArXobO+HgQl+DUi+lXqmb4upRpOR
         CKlvlK9Jxmu7Hd25XSuxz78K8vG62ndYaG+AknlLdsQC1dHnXV8OlpNDqr63ajBhLsn4
         nT1/r3890ecJo8wcYfmNbSxQzJOF4v0dBEAfoA5xw6RbmFZuAD3SGuJqA5Rt1n+zgHfT
         fXkw==
X-Forwarded-Encrypted: i=1; AJvYcCUjARX8Y7LEaXjDc0hdr+JyZxvhaxVLDeME25+A4dQ1ajyR2JEVoBUBMQUBorpvFJFfUjY2feM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefNYyD2TDxLYptL4MSxtBo5Bu32iojlG/PC/Z05hLyX+Vx2OU
	UWUkoKBOPUrNaLqT8KgYRJ1hwjpLeB9bvqQ5iFVl5Fl2dWTTyBdGPZINMeYW/yakFZytZIg7cxz
	R2ESCH21w4dUh4CoRVMVxq9pjZfu6lMzAVscKzY25mvdcFf4Gz+MDkXvLSNk=
X-Gm-Gg: ATEYQzwIYewb7m+6YCIoO44OS3G+Nx4fpFBULLMtkl1U+w5xuHDgOqVVm3FyRriBJVY
	rCfnlZTrkrz9yEBM6YC+1tmyiEQ1LbwVie/PQ1Uot9+0y8O6ewE9tOU72SeJXrMjxqcnjBeFu66
	EUL2i/ue9D5UaTyEBzS0wGMdY2mVuBvUX1Une3VuDx1vAheNhrHJLhb54m7s1g18mwwykv0VYxr
	kLjxy1FGh2Oh2CxQgZxyEzybyutD7vYXaQ8Au0FPJXukV/GPpIEqHDFYqYmoACoZbvo1NJ0foeX
	EotrH7qTYVE4ea8nFJtQ+XhsrYuIGpr5/RpV7VqpdeZci7/dS437W7sFbND7zsTwPNtIUODaNjp
	XWuw4GiW+f/bSrgTNsDIg9P2VGv/yqXjFeJx2fvxJuTwOVKu6uusl
X-Received: by 2002:ac8:7d0b:0:b0:509:272b:b3ef with SMTP id d75a77b69052e-50957defeacmr162015161cf.35.1773655454571;
        Mon, 16 Mar 2026 03:04:14 -0700 (PDT)
X-Received: by 2002:ac8:7d0b:0:b0:509:272b:b3ef with SMTP id d75a77b69052e-50957defeacmr162014801cf.35.1773655454180;
        Mon, 16 Mar 2026 03:04:14 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b457cfa07sm5065465f8f.6.2026.03.16.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:04:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH net-next 0/2] net: mdio-gpio: remove unneeded headers
Date: Mon, 16 Mar 2026 11:04:02 +0100
Message-Id: <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPVt2kC/x2MQQqEMAwAvyI5G6h1t8J+ZfFQmqgBjaVVEcS/W
 7wMzGHmgsxJOMOvuiDxIVlWLdLUFYTJ68goVByssc60jcMxyooLFUyUMMzsdY8YOtO5luhrhw+
 UNiYe5Hy/f1DeUPncoL/vB1NEZ85xAAAA
X-Change-ID: 20260316-gpio-mdio-hdr-cleanup-c70763dd52f4
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vzkpe7geG0xidfsuHwfqehUOh5OVIaYZJGxp3ptoMX8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9WVCsE0yohCW46N0j7/WwSEw8nfedQvFTjrv
 40ufqL4lVSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfVlQAKCRAFnS7L/zaE
 w7CtEACCMt+TIN6Tgz8uDkLBYyqORaFP9hjbU5wEoGl30u9jIJgIcd+EeTbxsrNs9R0Ho29Ex9J
 m4KWmuHa8Wxln0iQ+DbcqN8XHcpoSU/V43Px6SfGvs/VvgXMQHZFtcUtfF/1flZDZb0dwtJZnfP
 vdDCd0eoiPg97pasuppsn5tmDt8t83kulqNmTq8c2jfv6sqIJiotuUcEiu6waAUQziOZ4E/DYhS
 WM3Tv6iQsmNAFF6ORd7Z3BfHSIgJU3k9IumX6zlakhjD519o8osANyZ4wv4dvhaQIAOWx34VeWw
 qBb3KJxAiCR77JTuf0b7dYyK0wUNJl6kLgzQ3+OW8vaJeXaxRm478PTeDZCCWQFYjcmZnwMD5Qu
 2kc0L9cKIpnT1sePn4TQr+F6/eclCwL0YuhBSSh5NHiFwQEQPiHy3jbG87IaLEVKKp0VWCqF2lP
 K7317+Gplwtvjy7+zv3L1u8DiGGxspKMgI92ks8vvg60Uq2YOmtviM7Z68tkkrOKVKWw/hGRTtH
 nNaPdxHaxsuPLcI9t83m/m+d12cbjmdq44gKlnpZBoOsJSZ06tftrzcSmoWtjfbjrY4oL2SjnpP
 atL2Nmb21aReoScLtRmlELwlK0oJwZ+QuN2c4aHkZzb/jC6WkGYKeVsX/QJSpZT69rdeIdfO2FI
 /9MGRXke26m5Iog==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NiBTYWx0ZWRfXyxbKRJmYqait
 KlcZ9mbgH3zEIPRW4qR3XJ9WKDcZO03chbgrjjfidc9jAk0idBQLADUAy/O/1kTxmTfoeLQnjm4
 /Iaoh+z0hkeeZS7zF1cLmWhvULucZSPxJwt8JtN3ZT74xgMljWcgp+HM7GAKsworXa8Ip0k9BNQ
 Ie/FHoTJCF3BUgL4bP1d41XBja80Rj+fTbkpec4OFLQ3HvASKYCpxtbk69ggCi2Zn3MRegQmiNJ
 x0lESR5aXjrfc3fk4tATFULa5w90tlnscR/uc0kquBUrhWszMMrJbOZ+d/VMDHsRMWRWoMIyAQl
 7CL8k4fdWxCJ/Yt8mYhZ5dd2vFm53cO3tDdc2e3UY1xksJqz+BCXbI3ahewJDfWKU/dH1DF83nN
 EB0O4C1FjWg6o2xUhLvfWm2+CQgN3ihFtqnOBSDtsSja+HFD5H3TowIX9uuGVw2wmWsTNkmrgKR
 zpADaK9uYpoFMP522hA==
X-Proofpoint-GUID: ABs3sHX0BaZQGJE_NNr56WQyBR4X8rFi
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7d59f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=6y6Yt9arbg15dqQ8V5AA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ABs3sHX0BaZQGJE_NNr56WQyBR4X8rFi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160076
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC0CA297A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This removes linux/mdio-gpio.h and linux/platform_data/mdio-gpio.h as
they are not needed due to the symbols either being used by the
mdio-gpio module alone or not used at all.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (2):
      net: mdio-gpio: remove linux/mdio-gpio.h
      net: mdio-gpio: remove linux/platform_data/mdio-gpio.h

 MAINTAINERS                             |  1 -
 drivers/net/mdio/mdio-gpio.c            | 12 ++++--------
 include/linux/mdio-gpio.h               |  9 ---------
 include/linux/platform_data/mdio-gpio.h | 14 --------------
 4 files changed, 4 insertions(+), 32 deletions(-)
---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260316-gpio-mdio-hdr-cleanup-c70763dd52f4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


