Return-Path: <netdev+bounces-275075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK17CNPLz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:16:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624539515E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB3013042634
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8853C9ECD;
	Fri,  3 Apr 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fK4mZTh5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/p6e8Qg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CD3C9424
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225493; cv=none; b=Uu2qH0/RIHhWS4TelRneOHVPCabx3qgFzOfI6wnTBPanny1RgXW6CDo8mSMSKddeNyZ9VqO4GioTytx9rqwYC4gH9IzYY5fJyrbus+zvBpmNnIrsly939d+ZudhdIbQJXxB1vwkoKuKmu3vrhPIRKPirJgRM348TpnTCrKGEjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225493; c=relaxed/simple;
	bh=pGXUSvvrPCaY9bNA8U6IJfdUVXNbpB60+57XVCPk97s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j0sllCufl+97LO1mHi/SGMOUOs04BGTeIPGFBLQNFAek/NtlivZySZqUl+LqMgWOpYWqPQlEln5CoCT7ZkaiDXmcwNB2THpfM7hzD3gx2c0y0K8BofnDaa/5BdgA9/e+IOc156HyFkyzy63XalSAaJGXAmCjYKuSKaT+V2A1WoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fK4mZTh5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/p6e8Qg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6336CkhO3772782
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 14:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b6KRvTM8QKouT3ovjp7AlioiifSQn5uRmptINln2W/A=; b=fK4mZTh5TGPYKExD
	oZm23RS5Zq2fnGuHku+FWwGyeVm2iXIYZD7P/MIDpnAyv6gIHevKuVOQBE7XIcSW
	CfJ/3K8LrBrDppN5wkdREqFYnCRrsMQKkSluWLnTenU1yXoCAhObCqTClaG9G8B8
	ohfl538ClU7uPWXn/7ZvWgSfyhZLReYNpDiSN4KQJx2ZICan9H+msh0RCRWlwS/I
	DxWDNINrQkOAzsodaxTJI53cAm0hO7zpY4gLHFgv/8WU5Vdxfd6qStLyq2zhC3lj
	C+WzWxIlZcgVc+8bGOpknwNJPoaMglQ3Yto7IbFGKYZ1YnIZtRGbwEEGcbqySVFY
	1FU3Ig==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9wcs35bx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:11:31 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-60521f54387so666902137.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775225491; x=1775830291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6KRvTM8QKouT3ovjp7AlioiifSQn5uRmptINln2W/A=;
        b=N/p6e8QgY3V3+PDMBMEd/9J79xG61RfoCLCU5k8++eAAs3DyWfCRP0CSJQjULelWsv
         RXwnJnbVOpvOvxnyfsQLrxlQj+6TbmHdnpsPW2cAP4vjbr7FSu6KtRSGpws1mtKRtoA2
         mqDcLmXEQ+GiLY12022R42wf+jjZWoS1i7FDBtaxUPfHOtit+EJg7HMxR2VE7PWGG9xy
         qcqQqKvb9fKNztKTnrD48YlEO+F0jMTXeeaTaX2Gb/g8VQ5nm4ViZxbQisCrBRjehKQU
         V6z54R1e+hKl8NQQIqKhZlc8hgu2fVplrOaYWVofNerlG2dnOvvfgJoL/JCQYtLg90Cr
         WVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775225491; x=1775830291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b6KRvTM8QKouT3ovjp7AlioiifSQn5uRmptINln2W/A=;
        b=ThXUQyV21cRtnUPgfSOOoRXtA+kRbgSeA4kNM16szAPZmdreAMxF6czGBumKO81SUP
         /SrNlo3xxp3F+8Mv+xJedmdDDQeh2EtbNHF68iEOiJD9dOGrDkSgDLHe1myP9xE/kVPb
         NTOiViHGmUfALTCFf8Lgl3X53tKTccy50PCQosZqPL1EuKKqq8u6XrJruxqN5B8uuXHS
         62NCetrb8yUi7QRoio/fjtdmQTORA3qSuTT5/dJ890/OF7ogzytkOoI/rqr/jKT10qsa
         23Q/un/leULrWFKx3lgUao9bBDjtHToZkHhAa9CxuLhgQtbxtpEV+O/yCc3Dn07otFNF
         dRTg==
X-Forwarded-Encrypted: i=1; AJvYcCUH1nmflf1wiTfmWQkMi0xmnHlIcbr6z99jg7OTdYvl/9LAv6wuGauwxGw4tnJTuwA8fxiKd+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMem4MgnJZrY/lRlK9efsmI6igEO3T4uTEKFk3z4B2Jy9hmGg
	LMVmUHXRBW2GkV4CDEXWDLzdOcUH/vpRMvIWs1gjO98Qa5gxUgUJtbUWQGoWqXpcBgYz9zt1rwT
	tzaRdpFlr8wuzoyNxlMrQoJwJkW4t9/31IsweqDCkmiwo8h0Naet1nTG4dhI=
X-Gm-Gg: AeBDies7El9M/QUk7NkdbBlw3mpKGg/Oc2w6rjFfg+bOxoqK3u1r7/5N5iVXqhJtsVi
	y15T932AWvP+WtGg/54Bzo/FNOigkc2PGDaw0UqJ+hJ/ARDd54B4qvaXXMs3sC8L/tM5cAqIM+9
	bRM5OQSBMPslanPnKmlJezXMLA58jsYWXMb5Ab1w32H/UtOvgSJeKI30kgfA3IyEMYzXb7iDIGN
	QEoOcGz5FHOlcXKGvjYQCDU7tNSFFp85EJXDZGtJ9yQ7wueDghVexDiWcuKLNij9/qdiEtmPFCj
	wfBv8pEEDy3YxW2Nx6a+5Ysug3L2KUZ0GWuKRNTPbuIFJQlC5GcI56JNtIQgOD9MSikUZV8MhrX
	aqIvB+R/ZKt/AxTkCtrnvGJXKeiaf7YIxMV7rWuut0w2Cy/w4W90=
X-Received: by 2002:a05:6102:358d:b0:605:9ece:8d74 with SMTP id ada2fe7eead31-605a512bfe0mr919731137.24.1775225490714;
        Fri, 03 Apr 2026 07:11:30 -0700 (PDT)
X-Received: by 2002:a05:6102:358d:b0:605:9ece:8d74 with SMTP id ada2fe7eead31-605a512bfe0mr919720137.24.1775225490248;
        Fri, 03 Apr 2026 07:11:30 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:129d:59e8:f7c9:47ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1b19esm30127315e9.6.2026.04.03.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:11:29 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 03 Apr 2026 16:10:55 +0200
Subject: [PATCH 7/7] arm64: defconfig: enable clock controller drivers for
 Qualcomm Nord
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-nord-clks-v1-7-018af14979fd@oss.qualcomm.com>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
In-Reply-To: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=770;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pGXUSvvrPCaY9bNA8U6IJfdUVXNbpB60+57XVCPk97s=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpz8qB9rA6oEtfhw5E1F2I9M0SZW4hSH9QHKa8+
 OOr9TGSwh2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac/KgQAKCRAFnS7L/zaE
 w+lAD/sGSyzHSiDLl10lrRqWadTn4ar0xcomvKgXlKXHrjSyctiLQH7te2z7srmzG3lfa1h5s0B
 ikoyEIhTNdPpNk8zWeM30ZUNk23lMbfKS87V+qhENK4zFL742sDpLqODNjBOhpJ7fi4t2FZKun6
 xBfJ2Zbggg4dR5ZmogMqsUYXqesjtNSAWaygJFKibSthKiKPZud/XbDVE0H3MtpSw2XlHqIxoTQ
 6QK5XqwrEeOTrNxa6htGAIMH9USIKfJwO2UPsT9wfR2uwunj2jhkCMulINf8iPnH16T1ytPk9j4
 pq3EV89gi9n7md1MKxxWV3vRcGP0wQDEtej7ugQhcbKAb5IldMGUs+WXhQRUjN+ou1gcB0s6VZ7
 U98HFUsmHWcLewH7FyTlBYOUgvPpD3c0UZCqFLMx0BI2qthJfhcKZEUO6Fj83jK4n2NsQOLe8zm
 n/+97BVz5PLtIjYGOCzl+mvcMr2CCcoJt78rL+sBg1mUIbz2qgESjMM/sZG2bgFpWQDkhm73zod
 46BA0mEeNU6VRIVIEoPHWUTCx+qbGeCy4gqWE5JDUu6kJMPEj5s2C5Q/ewXuzwCgXjhVVTMeP67
 C7/khGdA8PXqsRwqHzN92IOrsBVaQ93NUGYURs2sFwXerP0uUsiwk+E7DTNZMbpN0v0VcEbijO8
 ZJSu7skSwQLJjWQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 2oaVlbRISjpjY7Jbmsf3i8MdfUZPSu6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyNiBTYWx0ZWRfX15yPwLRBd+6i
 +LmIz0MKlwUepIl3czGGhbY+xdoJeQvvMUVAt0gADXunPZJ+JFOhTm66m8DrIkTI+SffLF2ksHU
 8gXQevjNJj9aNQqnzqAVOlBoL5mjWNNugZa3mjMwhZirxZe5jiBPMaoFNYzDp2Pa1hG0773tN6t
 ZLnSOj2ZPtTBI/m1qoLBPRjv9ywKNByuNxZCA44L7YjWTknJXhhy/VY/dJfxf7BtYOP6bs+6Hvq
 cukpQeSPgmfxpxTWgwka4wibojZJOV9wV80a27StNNAx9enm8lCBN50Z3JLPpOkO1OByciHErNj
 5igrdY+kZh8IV0GsYts8WfZ2xDPY90A9Rio5hnKgJGElQCJZ/JnYjYWCyLKJdNq3/yZVGA8KHRd
 jU/fIl/XTC20aUiRkFTbFPwoZFbHUsfzV1b/6lFcfNjyjCczCiWBtY2leSsIOMh+sX1zVBEmLNR
 dGX/Axdqs0af6EE/e8g==
X-Authority-Analysis: v=2.4 cv=ZuPg6t7G c=1 sm=1 tr=0 ts=69cfca93 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rO3wVDe-YCVyVCuK1RsA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 2oaVlbRISjpjY7Jbmsf3i8MdfUZPSu6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030126
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275075-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8624539515E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable the clock controller drivers for Nord platform from Qualcomm.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 163b7f0314c90fc45eb6c4aa5e8faa549c60fdf7..f1a3333bb07482ef4f8b4ea9154b0f2c74587a04 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1483,6 +1483,8 @@ CONFIG_CLK_KAANAPALI_GCC=y
 CONFIG_CLK_KAANAPALI_GPUCC=m
 CONFIG_CLK_KAANAPALI_TCSRCC=m
 CONFIG_CLK_KAANAPALI_VIDEOCC=m
+CONFIG_CLK_NORD_GCC=y
+CONFIG_CLK_NORD_TCSRCC=y
 CONFIG_CLK_X1E80100_CAMCC=m
 CONFIG_CLK_X1E80100_DISPCC=m
 CONFIG_CLK_X1E80100_GCC=y

-- 
2.47.3


