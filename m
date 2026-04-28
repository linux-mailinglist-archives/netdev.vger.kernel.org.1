Return-Path: <netdev+bounces-281923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAMAHMDK8GkKYwEAu9opvQ
	(envelope-from <netdev+bounces-281923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:57:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87F4876EB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE933064AA7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55A441022;
	Tue, 28 Apr 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WW78sBvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfEeCoYe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07F44BCB4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386200; cv=none; b=Eps2lL61QJZWAyksj7JI/9PR4bi7u2/18pL6uMPnlBXzWSwqGkcDg0BowcRTN+9VGag8/QMyputWzFsgsr0RLy6THGggUC4hpproK1c80CdqpTQ0R4cm36cLon7MvZQDeDqOikPbOSNs5+vNMT3taerLSo1KC3HZT7Isklzcq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386200; c=relaxed/simple;
	bh=dzIl8YppqJhB6Od+T2zCGC/CJ+cKszHfDpLPF2geGtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PioeJEPhbtrU2qwRBl4XsJWo2UnFNc8RFp16nign7J5DIwYSmWgFGGc6ETAanHXoqhAqVCumhLnw0mhlGl2eo41EflqfJ48p+GprdkNB5vwxafL4Aloyp2JNJ+cipaJCUlLImFqqiniuvYLx0PQXejuHjZiSd6SVCGv07S9UreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WW78sBvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VfEeCoYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9u83C2112686
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=; b=WW78sBvIUBy1eVFU
	njJYuxlMhWipbbcVudjhYGGP+XiDYinoeKFVUBhnPDAEGLfcScUrldggbPiLQx4w
	yRGYnTpOVRigSrjJgWenphU9HcLPtD80UsQ0NPNBxJCNY+Y2nRA0oaebXe1yf2ET
	XnvV+zwf2g5DC3bcqTe4l+IIwbQ6DCiXA1shrVwUbs6Je2t1uHc0Urky9gWUYWuV
	TWmdr6s7Zws1UD2ea8CbD5W5+zyyqfWV/QYthqt5G2CR7BfPyZYhNd+ZBIO8Mmek
	Ci+ElfzTMJxdzLH8mj+xDSTUQDkGLtZwg4YwdNwabusIJW1pSgyugppW5hNzLx5u
	Ey/iMw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbm0gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e5a336b44so153509831cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386196; x=1777990996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=VfEeCoYemwkTM59YTf0RVou51QvqCcBtqzIklZk7eUfFk/u/P1sJaeKwZ4ID0BT5aG
         RSwxEQReUAdmnQYKwKrhsCAb44buIOCLX2sSggIvrRASgtkc8LqLVR43JbzcwAyeMF8F
         4XN9Su5y+RAc1sgudX1dTFpfvN4RrOhnLIVatpRnC8oXYW2F/miRyXpffCqluLU2f3uy
         Y/IurEEyTmGO0psUeAAhAaQzdQbxK7YdsprsS+Q1P4VWbBOpjOSeGV/Ka98DIflKk6fJ
         JjM1WHzd/evBduwmKHf62e0wyZmaIBpbjd90oDShmEiBcTd3GYmWcI9FDk45kYYK6bek
         jOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386196; x=1777990996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=V1bwgWYCiT1lWA7FeiT2OfHlpl8rdgQe1/OFfqnDefevqbYU8OoQfzuC1RLkm1JKBM
         WOYfcNH4ZsV/dHDqJAryNYMJ4zS18U8llMWTiN7XgPvYo29HBkXn/bPnZX4dBzI+23JW
         NwJ1A1lmTy+QNC57BN8TgVWqq2mynTXSotSU7LNAkCZZyMzsitixKIfNtXdHjk60GMKk
         VYE5p4aWTit353+BjfN1FfHo648LkTwu/YJdodVndqpTLDGluDq78eCLEajKmYrgCU5W
         spBtC26MrA7Mf5WspaIVMne9ALZGH0kvhKplfQHgJLnBTCZ2fnzE+cV76oPNSVzRg+6B
         eXzA==
X-Forwarded-Encrypted: i=1; AFNElJ80aK7Aj8GIYJrClIad4UjdwKYxfQmfwAI63JDK4tKbU4pVZIYoc8FRPIAzvHnpkaoj8oygW6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGOD89H8b4zad67cZqr58++aTa3z/LA2mcnzEbs/F1gToDZ3U
	kkAWjS+eFufd+3cxGXA8OYXLtisjrwGHH3QJ1sNvgMXJm6BVrmBnXV7lE8V95XfRLFrSTvU+/6D
	9h3E+d/9C9nV0fZLGSDKNL0RwN2O7gY8l54HdnkfiQoNdm4hG7crez1dlQR8=
X-Gm-Gg: AeBDiesR/hBciBbCfG84iEV6/keX1aZqW+kBituLbXv7N/LStpAJKHyKSGdCaF2UM+G
	hwTgZ2fSFRtL0mk6qjr6U4RtPVZXh6KBO9iykT0uRCyrl8XlRIWeaXg0xqdUhI79LCf65eMY+rT
	9KLLfXGIEHtGhjevC6Lvb42EDGcxS/Ml+U0Tl0adI/UfYfD4bwd4Hmu6r7igTJDtICgayNW/tLV
	6DDkDxa3I68VEbjp6jvSLxKQDR3jdtlpIatXGOf38Pl60h6kCJHMq8Z+fjou2MLmHVvMKQqMHZq
	2FTg5FCFlPpA0Fmw6WPU1Lo3UUCIEKA2lPCBXnCVLI+7deOjA7WUKGcM8dpV0j8T15EipgFb9ZJ
	6UNAxoh8bLqVxdHzGDH5v7eHB3Ne6SZsNxEBjFSFJYcJxooFUGZWUH821ql55lNsCVJB/1RBsNt
	luinWvAq69GAjyWqaBui0Bx3dkCwQ=
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39310991cf.37.1777386195910;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39309901cf.37.1777386195170;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:07 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: arduino-imola: Describe boot1 NVMEM
 layout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-2-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: NXF11wzklQdSRDp-Ode2Db2hilvkeAgz
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f0c2d5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=gjCkitBQ8UzLeNF7HDgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: NXF11wzklQdSRDp-Ode2Db2hilvkeAgz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfXy1zOqSZUETBp
 vg5MCMWVF4OUBlhsZ7ilD+n1WzDUvE1k3h1aXGMjBXQege/j6tdnFnv0jJPYDIdDDiuX3neXOv2
 t6ub4pvLus63XXEZe9lR7+4/5hbsWmjY3UBduLHJxXAwQWm/2WSPPnC0co8604W/ze9++CAmjFj
 O8LV4/Mn+qeKrNbfOQ0xd+PDamSO3Rq5QC+uuMrUMJZ2jfBRWY/4Nqk/epzPlwQ8op/boF3HDqm
 T9IsNqY1PYI++WHz4MfLmJqwkQheTy54Tz8Y3NakRIXT3kfW5Rn4Jm4Oa3HvsbAsMYujPwjzg2O
 r8D1sC0y+rWXi0/ZaiHjp3UKgUhileDZxh97lYnK/SvfH5YEWs0Nt082jglCVN9uTl8Ihy50T3M
 aviYoiIaliHk4unNqFaIN8p7bGR/1wuFjhDy9qIeHhgHkjmPwYjm6vEFR2hTYIDcMbI5vnAhkD0
 lezn6yfq/h2KJ4FNU1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136
X-Rspamd-Queue-Id: DB87F4876EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281923-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.17.48:email,0.0.21.24:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.0:email];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[30];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_SPAM(0.00)[0.070];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are realively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and
Bluetooth addresses.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..dc85cf94f71cac8666cab30ccf37cc2d2f8fd941 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,31 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					reg = <0x4400 0x6>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					reg = <0x5400 0x6>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {

-- 
2.34.1


