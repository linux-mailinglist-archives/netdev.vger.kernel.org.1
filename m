Return-Path: <netdev+bounces-282385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGM5BTAE8mlYmgEAu9opvQ
	(envelope-from <netdev+bounces-282385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51181494956
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A5D03021FD4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F63FD140;
	Wed, 29 Apr 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DYbvHdIJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ei0n/wAF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034E3FCB15
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468330; cv=none; b=AQEmjb8sxbJqMbFsxqul0/NVUdq6P/GlfpHb03TeXf5lZ0qRgSqrzwhx9dLMypRAq6GX8+nOc5sd2J0sB3n/nPQFrQFhYs+bIRgbIiis/2K8RS3eDu24mv+OsAzdjery1NYPr0VfCuHpHWdlucGM+LQjgFzcfdPJXzARlk1rnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468330; c=relaxed/simple;
	bh=sQlnEyALeWoqRjlSzoDym4TcWUqFIQse80DmfyA5AD8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lOFsyJsduYIw1YVVK8CU0h1qUvcfmxOADjaWniFDnZsroqsk2+Jn1obHpdDqqpfZpQMAf3i7b8y+OXqYYewzc49c/RQjyhg2uIQaSb7Zk0o1itCvE0KRvowldMOObLqhtHNg556w8p+0ugkQczvLYxM/kivarP5iRjVBtw/AZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DYbvHdIJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ei0n/wAF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8puk23752544
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5tcVTdVxFKWbPOvQ327MhX
	Y5HFY4B6nwROt9RjHUiXU=; b=DYbvHdIJcGqExfaDDBYQUX7jX+Vir7hdxBd5p7
	7/pKhw2zw5n0m07CDrDmI6b0rwqlM42pJW8VWTW44DKp7cHsX5CG9VuITpw4PUqj
	nR821edgiZD+ERbiBdn+bA2KT74o1P2MHK4s/ryvtNUb++ONTOriqfpyYLUDeswO
	GWAzELzslsnAK6JcdOv1L7smgGX0Bi+JBb+0Y/t7pCWzJPSudQmaXHtkm+p6avCx
	OUxligeTEwh7hQrAd122QYz35Vxlh90yA4nzOacjCh7rKzpQiM0Gjv1rtfRCYwdm
	6fYtCxWuBoCDNhUwHAkxv7EGQlL+fKzj9BJQoTTAgbGzEdow==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1hmdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:12:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c798e905c29so5460174a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777468327; x=1778073127; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tcVTdVxFKWbPOvQ327MhXY5HFY4B6nwROt9RjHUiXU=;
        b=ei0n/wAFqVFlFXKZJQ2NXcWSxBKbLa2IXzZG07og+f1MqyX9AWkP+ptrt2TYf8bzGd
         MRQRl5N146VKOJjnn/ZJ7KnvMbjy6KNiWKwKEN95kFbv0LcAxfsRWXFQmrP8Fo44ckFm
         gIniL7h4jTsPmM5ICmBL26HzWq1MEDuVliKu0qR/UqjrcB2nNgXSQHtGZFCj9mhnRCBe
         bvrHKWh09DbbmonzgDQKJbI1zLuHULMzAl2x2Mz7509yOmK7vcReZ15ZAAayxDq8baRI
         6xylOdWVtNR/JQO3f9mzSi+rKowYQ3ujX9IjHvfSToN/hka0TamhOCY5Z1txeMHlafZk
         hEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468327; x=1778073127;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tcVTdVxFKWbPOvQ327MhXY5HFY4B6nwROt9RjHUiXU=;
        b=sRg59v4PQus+Cb1sQtBXoclew0fV3a8UvKgkDY7jVo83oZSF5ptljJqUVaViKZgTrp
         WEYLCtVh+hcg2U7I6haqanqAsvMBUO0Bc40ZkXS5yThpSTc2u9EEj4WbC9A+hg20e6g0
         XXLvYE+ktKUKO7kTzrCdcIQTLdpKrgM9I2mMEKtuyyR0mXHVx/7gXGsZCGZU2e2Is3Ld
         kdfHvDwJXA8017z3GW99mTyrmaK5hKNI/mWRbiVNUZGwOS8TTGqBIM2Ij0CNZiJ78ned
         uRfuJS0Efof80wI9XVs3A+Mq0jnbYmrhzXvyfZN96+US8zXga1hUNALYCS4AzNSAs++N
         9weQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SIzi2xJpPWPWmbR8hSp4CU9fwIffBuY0Hgj/bPJznRBK98U2XkOuh0RiclP3Zo44NdOGdPlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2AKjGt+lgy9Gy+wzFT3jcTvGq6eNxOeWAEt/GZrlDb2oaSB+
	aauXm3szzhvzpt/ZkUddx3J8zN6vLsPL/hxcIZfq3taBZ0uyH8pmEgg0I5tlnU+mK4yzUx3Ku/n
	bnLyqc19WdynykuOmkhfIkkRgKFHTdYTbuq7R9sZaBj2pwlNBfNblxWxj+bA=
X-Gm-Gg: AeBDiesfnti0UZ+AoDkZ4vS6lOrXYi4ztV70E0QifTUkd7gDkMjQ3kpDav7i62Gy7/i
	Eeg4WJ9Se9dcvU0rd1RhSteYnUeRB56NYsFH99i7EDeyNJXtXHA8dgq7a/a7Lvm/QuH1tC0WnVa
	Ob+3icpXElxgAHae3MWTOZzwewW8+2iRHyXbHPrRyH6id4uXR8XHn6AA0HZdPUZQmrrBR4ITEH+
	7vdEOShROdx10JzWwmsuGndj0A1XcgYjbSu6OeaysSnLL6OLiiqfug3qGkZ+R3rHjbe8TZdVgkK
	FaemzBHereW156z0j9pOnYGbBaaLaEyZK0pLMn/Fsu1tRWbfIhF/0N2ID90FJt7yo9M4dNInNuK
	yr0XyL35isUQ+mbaVWNjHOMk8nLShpBGo4cRvquvxDnTnNFI=
X-Received: by 2002:a05:6a00:b610:b0:82c:7356:f45e with SMTP id d2e1a72fcca58-834ddbefc57mr7895795b3a.31.1777468326518;
        Wed, 29 Apr 2026 06:12:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:b610:b0:82c:7356:f45e with SMTP id d2e1a72fcca58-834ddbefc57mr7895749b3a.31.1777468326058;
        Wed, 29 Apr 2026 06:12:06 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6decf3sm2063025b3a.31.2026.04.29.06.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:12:05 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH 0/2] pinctrl: qcom: Add support for Qualcomm Shikra SoC
Date: Wed, 29 Apr 2026 18:41:55 +0530
Message-Id: <20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsD8mkC/0XM0Q6CIBTG8VdxXMeGQKK+SvPiAIc8q9TAXJvz3
 aOsdfn/tu+3soSRMLG2WFnEhRKNQ47yUDDXw3BGTj43k0JWQsuGp54uEfhEg5vjlQdvSrAVOl8
 Flk9TxEDPD3jq9o54f2R33sc/2xZftP6haXTkOUgDqGpnDap2Kd+qhYTcjbcbzW2hGiN0ECIYb
 cCCKnUmmtoIewy+BieVgAYgsG7bXjk/B/HgAAAA
X-Change-ID: 20260429-shikra-pinctrl-fd71ab6ecd6f
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468321; l=981;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=sQlnEyALeWoqRjlSzoDym4TcWUqFIQse80DmfyA5AD8=;
 b=7suvmGo10znQ7hExo1MntSioSaikQqdZrIl8e00sFPl7ZeISuX5I8CZDGfMcHFtqL7p7E2xYc
 QQJdMSBePMuACWmZgCYMwlMcwyySOCTPJjyARq+m2RVKH6RsNa5tjcw
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f203a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RKqVp3ilHWDC27yp5dYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNCBTYWx0ZWRfX2hSJDsA6LwpP
 0wxnEsxiE5HR4jG4WZFCAljd1AdQVmKTvvDyxq7fV0ioUAdss/SvFPICgUcb44bhDyNCaR5aOTz
 nx4jRzkuvQJe1gHHvLOI+6c4MCeO1nj82tsOdj1HF9jMfHq8L47Oog9dIJFD+u5XGhugeiAT9O2
 uzLVwpUHoyp6YT4POuaLJueY0hIClP0BAHt+X89NRRVPgSlDdHbIQapiM/KQgDHRbltwj5Fg3of
 gBfStrvCT7HM3OTNu/gRmQVma/YpQbkweUHTxSEUt/g5mkPUPba+Awtwc8CLcvymG4j5/P4/9ak
 Y2Ht13ksMGJJK9d1iSTwrPZSJntfRBkV4VY/lxZo6xrR1Ft5tp6HnFTG5Fb8AuXwWvqpFrg0F81
 V1L2g2ntWPKwxmA2wSpQmd5l7Q3c465xWNDg1SFQxxMdSG73smkdsIBfcaCcZcHdr2c8PQ1a+rm
 yyJv65qIaNkQ1bQxong==
X-Proofpoint-GUID: HUa-UBFSgoQ92YQLAaC5AQka5fwJXkDm
X-Proofpoint-ORIG-GUID: HUa-UBFSgoQ92YQLAaC5AQka5fwJXkDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290134
X-Rspamd-Queue-Id: 51181494956
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282385-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add the pinctrl driver, document the bindings and enable the
driver in defconfig as default.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Komal Bajaj (2):
      dt-bindings: pinctrl: qcom: Document Shikra Top Level Mode Multiplexer
      pinctrl: qcom: Add Shikra pinctrl driver

 .../bindings/pinctrl/qcom,shikra-tlmm.yaml         |  123 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |   11 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c              | 1280 ++++++++++++++++++++
 4 files changed, 1415 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260429-shikra-pinctrl-fd71ab6ecd6f
prerequisite-change-id: 20260428-shikra-socid-a27ae38cb7e3:v1
prerequisite-patch-id: 843f28095c0d42d0d60ab7000095c64dcb2e90ca
prerequisite-patch-id: 1069d6880c3ff91c230c20fcd876738001c6d35d

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>


