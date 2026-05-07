Return-Path: <netdev+bounces-285386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMN3HUqv/GnlSgAAu9opvQ
	(envelope-from <netdev+bounces-285386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:27:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B86104EB016
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4C2D302400A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69124611CA;
	Thu,  7 May 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pngJchIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRTV/mo3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D3450906
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167497; cv=none; b=VWHkV8I7jaA+3XzlIk3HtNGQPAMx0fC5QxDSXQYakYQPqUqakoFnMP72ZMI2jQoc9RuN2PsKui0t1naZp68EtQGmkk9WVhVfgt6QYAflCpzpe3gdO1E5Z6n0suLLckEZTZ6BnZd6hc+GSGCMN2PESbckgUwJwEnPnHKc2IuAjHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167497; c=relaxed/simple;
	bh=RjAXLDtyeqYajrszhA7+nXfORAO+2o+t2+Lsa/IoOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGCA8t8XoEmC+iUCvbu7U0R4Int+A9UdeDe/KZBHwotKXIP5n7PY4RP7zbbZn7jU8mausyKpb4dY7H9D3rumyHJRafAme5ACuGKJU62pVM0asDYUWpE0xT4drZZYNdGLdHLAEimnTjs7ELgJO5kmh2Za3qve2fqnGletjzli09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pngJchIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRTV/mo3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647EITRS1424448
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=; b=pngJchIUuTR6hnjQ
	lUECzDHVo3pz1dlhpiqmaq1DuAFQv80gbFnsc430vvYvth4mo1bwdyR6UWKw5WdL
	WOpcq2EHSqx0x7SuRWqWe2LCyY625A/6sKNH2CPBz1+ERlw6lSn9VmVhjg3m2AjE
	9xjqaSAc6WqXXEOq/Srh54PIvF9/IBE1T0VyqUIqyRFa90B/3Dgo/n+591Morvba
	unefJ2L0hLpbQtFvm9AZTpw+nb43cU0FWeITrCo5GCw5BvFhhlt8ia+b3JuFJtgM
	lcihyLA5QdlvrdltBs6JtiQmmkeQ7kGuSsh/wQ29S1Y3j4W5t0tX7JFr9FIvJpJx
	E+BCeQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfsqv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:24:53 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-575346e50c4so1123030e0c.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167492; x=1778772292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=CRTV/mo3NE9KvXaj5tBP1qjtfldSrl9mDiZ3TPbOJ6Q+kfXCPSEe9PLb5PjUI7soL0
         WMIimb1Z+nfH79b2MOGlYiQdcRoL1kUHJZhzlVpDSVMhOZ9bqIWg4E78NqjEpJsiRjNu
         R4SRwtrWbwJzcf8wFyPPYTmLxCcUIrYOb9VVQyX+kC370bZzqrmhMpLUODoWL9pevPnj
         riGex3G5Vabf1DqNTwYxRHtLERDXl0F6HazZduX+k5hvi7vdwHwJvIXoMiL+NSJdeXG0
         pAibKaDw5Wrdd/3bd6C4d6IcwVnX+fExVFuWr5guECHzjOzkLQO2rshNnxI2CgZ98Lsl
         yS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167492; x=1778772292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7Clh3n6Vth4q3WERt/c3dsM43tyAEU24nXfs697yQY=;
        b=CnofNGAWTNJmGITWQWmhKHeI5XHFWx2KI3n0BFB8UWMt/69I0HfGhTrztDu/MaAKxH
         iQWNJZ9uCCsFM7N5OsDimCKPMrEryt2+yIy4NL0VFcbxUHZegKL5GOdWwYXdoSZyUpfC
         8SLzjMlvJJNvpv9bbO9pmg6/SSlMSpu9khY/CIXvZ6gRF3uywwP68d5LsculpPJGcT2V
         ZKwVO/T6Jz/j6a8+jNQ5BfuMjpR2vaYstgjRqBNF8uEty1Jyy9g7co/VLvvIFTahxaBm
         HAHt4TQZ7w8Th2CjMbbkRe+jY6wOIFHxi4IjESF0nus6eTKJxeTARc+BJItYjJbsrzTG
         Y7Cg==
X-Forwarded-Encrypted: i=1; AFNElJ9r0dTkXZm0GwgEWpPWBG355aADURhEVe1x/A955shiPZoEQ9HK+Mw0iynH2tbUZlBx4qEu2Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDcvTEmc3uW+yX3nCaF2kQFT6LCNbw8NHUj4XchLj5PSGXDBI
	B8a1fz7QkW8C/SVPH7d3xgiAcZfs3cpbVDv7zPX5k98+2Aly7SNdzEJswhYmxK7R6vfAgnQLCVY
	m7fz2CEdXeUmMvNgDfJsBhkSuTetJhjTKYfvOS17OLGtIaNiG8Kae5pYSsy8=
X-Gm-Gg: AeBDietHdD3nLPJJesQktGJKv9PbKS2ZWn16sOUOD12MrFpea3gNQAEgDQoAUQ7nphi
	tBilefBauzgSqVZjupiQOLdTN3ZhqJv4+pmf54ad+vdFmBFDd5nlchMmID/i18vohlNLECEph1Z
	JsG4evzI/+2Wn+qYBsWVb/Wcm89k/DPpj7VUXrMhA1Z1gzDYETuIj2yOBn7dSfgucFFzQn+DZgV
	Kp5ry4A76MJeDIXV7QXOWMftQLHWQu+edj6vl+NHmY04Arr1hRJmB/N6IHItRBSq6NHVg3l9TcS
	rHZUZt/62JV3s7ziZuopgWOJktHaahhh0ckp1DV2KNpRK4f97CwenLYfJmt1OGDFokTvOz4oYoI
	C6jNuOZU3arELsrWL1nNtdpe7feCH45FuY4Jygy1zQEivYcn+/rckS1BeDQdUKFmjDmwcgSh1fI
	w05aounW1smaZPPPcaxUOfcUxmE8c=
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5439027e0c.0.1778167492620;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr5438965e0c.0.1778167492169;
        Thu, 07 May 2026 08:24:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:38 +0200
Subject: [PATCH v2 3/8] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-3-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fcaec5 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX4gIURuRCbGBD
 +MzeF8etzi0Wq2BaPW6wBiN+tPMCQJjhhpJs1FE6451WjXGHw8LX6ARH2TnA1v72e54gULfivQh
 8VrAWxm/G6cnn7G2HwrddxGkmB5kEIMtcDbDYOESEBmX47SuXi2rQHHJVULtPgwtfZUjG5MLcYd
 XuLetLaMma0u76z09X8qOKFXoF/SYgLNIkJYRjBL4t3DmXg77coGMb/N+8MTat2StzpWFjwxNGw
 bsRllwDwHNKckFsijur5ljmUe/istznQXwlQFXT8wRWdk1pTJAJ1bt0JTq6gJPjUyw5OjyIyHpc
 ftELLVwNV/BqKNt46eZk8jtR9I34OxS6SW5wG0tdhx2b3BTK06+MuDsGGsnwlXoK+9gKW3xPW9Z
 FkumfAjzc/ouy8sbkxpntjxfZpTG7fnPDkFQDxz2U+JXBL/8I0LBaTgUPq3+KGXdXfgD3g91ZuF
 Fzgnml0LI+tFPD8XR+A==
X-Proofpoint-GUID: CB7aMUQ6sMrU1yq8fy40grVHFRcCjv_J
X-Proofpoint-ORIG-GUID: CB7aMUQ6sMrU1yq8fy40grVHFRcCjv_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: B86104EB016
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
	TAGGED_FROM(0.00)[bounces-285386-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1


