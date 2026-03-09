Return-Path: <netdev+bounces-265594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJB2DX7mrmlfKAIAu9opvQ
	(envelope-from <netdev+bounces-265594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:25:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D323B9C5
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27DB630236A9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA93DA7FA;
	Mon,  9 Mar 2026 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LP1UX689";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BMj+cJhE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB23DA7CC
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069874; cv=none; b=nuyXqyIVb8QzbRQNdVsCUL6MUWFsOLi9bCP6GOU8dvq4Nojn5oGeMYCKTxYRVjwSaMs8Ef9lh5GwIo+2JWKK40EsnVonXgaaPz6r37VROyPuAYWBVZUFvny9d0qmt9R2KadtDGHeE3uiHlTZXAnN5b1lR6wAcy8ptyZIKCR+8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069874; c=relaxed/simple;
	bh=zF/ZtSRqYTNTiJla1Mk2osrN2zkae+hDXhuv9dj2vx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMrEQjcDYMEa4wps8ANqK1aEZFqtpWjnuDfCJGvuUhjqRLf4RjuFp4NywHuu9t/EWhHW8il2ASm6ov/c5u2Nk4xSMDO608aUUb8pw3r33ele1ahlhP8N5oeDQoe5/0b/KPnSj8Ug0OhXaJ6Y7E0abIG42KLuGdU7Hmtn23er7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LP1UX689; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BMj+cJhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629F5FOs3773276
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 15:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Md0AAi37albUzSAboU61gZErEa4ooVARCZHWV8Dr0hw=; b=LP1UX6895G3AJzUN
	RHu50HwgSKNW81fnRg/8HtNdH6UH7a7DE53d94o4KDec/WL4MpaQ5wLA9xzjdoS4
	YFSsLHFX1kmcbAnmfchUUEl5fT8uSeJJtjnu8ziRzxEqJ25p3h89oxfLEkFGKHCE
	AypPkVDaOG3BucI7PK3rwgKsAgdXEqGKGqdcndJ7lpMYUh9SySTYG1XMNpnsYKSM
	whwEWRfbwn64v+Ex0tIBPHkGnYXvlXm3KyAeira2Pw13Z/Hk6uwU8vMGgM43V4As
	gFtU9TbgL6R7Y7aDF7s2tJDbJjGULO4yM2wErLzQMW/L7U01cAgiFFegt/fpYCxr
	uI2MnQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa9cfj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 15:24:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd85e08fddso1105759085a.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773069871; x=1773674671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md0AAi37albUzSAboU61gZErEa4ooVARCZHWV8Dr0hw=;
        b=BMj+cJhEARmxiXDSYxWmXLyudCA0kqMIaZ98gICOkeanmDauVQsvCzjvcPWmnsYs+Z
         w8dXVetrm/guWc8qPH6HmSlzlgqos1aNY5p+YNkFVK8xsRaO2gdbAYDnhH+KXTezQC2H
         7HrfjpkQLp4RbdsKypKqu8mCrNLXm+PNmn+rNcoOszqGrP0abwQy7pIrAnTnYKOyKbCK
         qIDnFZK8WFvTdMn+gthxglOof+Zmt6k4TbzgGRf/MyQvPhGqTdUVfvQS69dInSFPfMjM
         /qQTVZJI0oTXYC0ZVC9odoAaW9oVdO9IGrlQNoaTVO5Qc1DJGw2R8BcaYYiCaejBPCGN
         V+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069871; x=1773674671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Md0AAi37albUzSAboU61gZErEa4ooVARCZHWV8Dr0hw=;
        b=jrMt1I8AMLujGMG47fU6Qqa1V382Gglfis9qaLvBVzFuN9rtXac9f0IdmidxnTfKkR
         avbb8yntChijlxzsjcxwpLUvJov/Oj3HGBNVV8crg4NtqyObzvBBxPdsIFTuTBlRpAeW
         e7ZpCbRrjBDfdXGNRlU/bQlU7JpQ1hwvMBlYDEy8M5H8R6njfXcrx51hoKJM5u+YkTTs
         yIeMv6Is6dUz3w96veqYX4mhD+iBtnG6jRwY6S74tUtuiRC/hFhBpuxqXi+pm+iksEHV
         qauoQ73A7doy0czpGZOJiXgfzQ/KYBaTKXiZYx65TnuQE34BAwnzgtUQK8OlRHTMGUYn
         m0iw==
X-Forwarded-Encrypted: i=1; AJvYcCWAQPi+3BldKSB17qrDYrtwU/Hemy/LIVfomnK2yir8HExbCVlSNeKxyIu/dHCGzGJc7o9ln/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTa5UtpTlERoiZExWFp+64xRUxvuMnLxfFIWJbquJpfEiRJPx7
	u9fmQ71GZeVI0spBeSTKtSGnYlVXcJhc2c5CDWaK3nwgFBXD9mNL/VgOFqhdWqvjCeJfstgCpy2
	aMOzdgNBX26yzs7TOy4BqOA2CgC/Hf76tXbhvi4Mc45bNVZ9wgV3VgFuAsr0=
X-Gm-Gg: ATEYQzxuSN071H+m+fj3mPPg4Ll9uoxrW+HrGQh1TsimzLn0fK7HnFJBbOBn7jvclwI
	jLnHk6knbii5Cx2PLJZivgN4nrnuX6uoIaozu3aex7iWWCwJsmncbImVkstL9PxuLE0QadgckJX
	/7b39wYEV7ybdlL7VXCd2Z6iCPIo/F3mPCxhUbe2WLJ/McRLZsY8nWmlX/fukO31rnUNm2DVIYg
	pycI75jxQl6C6TF8z0K7oPfeWe8Zrno2uCUf2EwS5xMbjDWaLgqs0UVs0HUFbvRnHsFhtnv2Hbe
	skDetnF1a8JBmBJSWv49kcknK6JkylpmCGDMIgivpbGLUGscKkOhA9SrsoOvr+zAE1p8TQE838O
	WNMV7pqaeYIGpRyRTOBBxgH5+2jYKxOT9m5S6/sKTusbB4scya9aaoU4=
X-Received: by 2002:a05:620a:2844:b0:8cd:9322:d44e with SMTP id af79cd13be357-8cd9322d85bmr58486385a.73.1773069870887;
        Mon, 09 Mar 2026 08:24:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2844:b0:8cd:9322:d44e with SMTP id af79cd13be357-8cd9322d85bmr58481885a.73.1773069870372;
        Mon, 09 Mar 2026 08:24:30 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a59fc36sm192812515e9.9.2026.03.09.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:24:29 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/7] arm64: dts: qcom: Add Monaco Monza SoM
Date: Mon,  9 Mar 2026 15:24:13 +0000
Message-ID: <20260309152420.1404349-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cEeIQ0v1AY_sFuLW1NB3LHPjuxHlX_Ky
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aee62f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=wMphO_-U-tlnGu-niZMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzOSBTYWx0ZWRfX/sLPs+MJVUSl
 VcskYlaQlYkeH01dqHYPxyumcFPvhMhTyxI9MEwx1LN2+GtDpoitJJot2HiOe0iClDbaQ996a3Q
 PqMzxzyfBlOhU32hfnkVnRKUvrAZnprYGC/19DJFVyrIGvjOSCfOGtaHIdh4HmaUlFT4/BXqLVb
 Miit62svTDDflA5UWeZtEiWH+2DWM1BQKP6d/kYAZrZsID2482I0OgURN0sweuc6YKwVIEQE8zR
 7ceVBXfX65xYUhDVVBWnwv3gLNHJqSpvxYeXP0KJ6TBgs6jUkjQ30uBaKV5y4Y+UvwMNXKPUrIa
 Aln+IuZCikd3RrU9qssgzxEqx3hVjWeOMB5yrEgYL1p7R7NIQsxq1FlftQDipb1f2xfi8t47LUl
 /HvNHq6wDPgb75zT7fXh2yQ7/AOqid2JuzDmcQYS4zwONFEZLpJV5CI0/RtsnLDjyNQGyEQEobc
 D2vJPRqxrniRYZeyiWQ==
X-Proofpoint-ORIG-GUID: cEeIQ0v1AY_sFuLW1NB3LHPjuxHlX_Ky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090139
X-Rspamd-Queue-Id: D38D323B9C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265594-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Loic Poulain <loic.poulain@oss.qualcomm.com>

The Monaco Monza SoM is a compact computing module that integrates a
Monaco/QCS8300 System on Chip (SoC), along with essential components
optimized for IoT applications. It is designed to be mounted on
carrier boards, enabling the development of complete embedded systems.

The following components are described:
- Fixed S2S 1.8V rail
- PMM8654AU RPMh regulators (PMIC A and PMIC C)
- Display subsystem/phy supplies (DSI, DP)
- Enable GPU, GPI DMA, IRIS
- PCIe Gen4 for both controllers and PHY supply hookups
- QUPv3 firmware declarations
- REFGEN always-on workaround for USB2 HS PHY
- Remoteproc firmware names for ADSP, CDSP and GPDSP
- Ethernet SERDES supplies
- USB HS/SS PHY regulators
- On-SoM eMMC

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../arm64/boot/dts/qcom/monaco-monza-som.dtsi | 325 ++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi

diff --git a/arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi b/arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi
new file mode 100644
index 000000000000..9c4f515337de
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "monaco.dtsi"
+#include "monaco-pmics.dtsi"
+
+/ {
+	/* This comes from a PMIC handled within the SAIL domain */
+	vreg_s2s: vreg-s2s {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s2s";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pmm8654au-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_l3a: ldo3 {
+			regulator-name = "vreg_l3a";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l4a: ldo4 {
+			regulator-name = "vreg_l4a";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a: ldo5 {
+			regulator-name = "vreg_l5a";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a: ldo6 {
+			regulator-name = "vreg_l6a";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a: ldo7 {
+			regulator-name = "vreg_l7a";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8a: ldo8 {
+			regulator-name = "vreg_l8a";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a: ldo9 {
+			regulator-name = "vreg_l9a";
+			regulator-min-microvolt = <2970000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pmm8654au-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_s5c: smps5 { /* LPDDR VDD2H */
+			regulator-name = "vreg_s5c";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1c: ldo1 { /* LPDDR VDDQ */
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <300000>;
+			regulator-max-microvolt = <512000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c: ldo2 { /* LPDDR VDD2L */
+			regulator-name = "vreg_l2c";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c: ldo4 {
+			regulator-name = "vreg_l4c";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c: ldo8 { /* LPDDR VDD1 */
+			regulator-name = "vreg_l8c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c: ldo9 { /* QFPROM */
+			regulator-name = "vreg_l9c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&mdss_dp0 {
+	pinctrl-0 = <&dp_hpd>;
+	pinctrl-names = "default";
+};
+
+&mdss_dp0_phy {
+	vdda-phy-supply = <&vreg_l5a>;
+	vdda-pll-supply = <&vreg_l4a>;
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l5a>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l4a>;
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcs8300/a623_zap.mbn";
+};
+
+&iris {
+	status = "okay";
+};
+
+/* PCIe0 Gen4 x2 */
+&pcie0 {
+	iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
+		    <0x100 &pcie_smmu 0x0001 0x1>,
+		    <0x200 &pcie_smmu 0x0007 0x1>,
+		    <0x208 &pcie_smmu 0x0002 0x1>,
+		    <0x210 &pcie_smmu 0x0003 0x1>,
+		    <0x218 &pcie_smmu 0x0004 0x1>,
+		    <0x300 &pcie_smmu 0x0005 0x1>,
+		    <0x400 &pcie_smmu 0x0006 0x1>;
+	num-lanes = <2>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l6a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+/* PCIe1 Gen4 x4 */
+&pcie1 {
+	num-lanes = <4>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l6a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	firmware-name = "qcom/qcs8300/qupv3fw.elf";
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	firmware-name = "qcom/qcs8300/qupv3fw.elf";
+	status = "okay";
+};
+
+/* There is a HW/FW issue preventing proper REFGEN hardware voting
+ * for the USB2 HS PHY. As a workaround, we force REFGEN to stay
+ * always‑on in software, matching initial bootloader config.
+ */
+&refgen{
+	regulator-always-on;
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/qcs8300/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcs8300/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp {
+	firmware-name = "qcom/qcs8300/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+/* Ethernet/SGMII */
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+&tlmm {
+	dp_hpd: dp-hpd-state {
+		pins = "gpio94";
+		function = "edp0_hot";
+		bias-disable;
+	};
+};
+
+/* USB0 HS + SS */
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l7c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_qmpphy {
+	vdda-phy-supply = <&vreg_l7a>;
+	vdda-pll-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
+/* USB1 HS */
+&usb_2_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l7c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+/* OnSom eMMC */
+&sdhc_1 {
+	vmmc-supply = <&vreg_l8a>;
+	vqmmc-supply = <&vreg_s2s>;
+
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+
+	no-sd;
+	no-sdio;
+	non-removable;
+
+	status = "okay";
+};
-- 
2.47.3


