Return-Path: <netdev+bounces-267392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGtKFjvps2l6dAAAu9opvQ
	(envelope-from <netdev+bounces-267392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:38:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F263728192B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F6343012D06
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C973859EB;
	Fri, 13 Mar 2026 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OiGuWd9J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIs7SzMo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0436CE19
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398328; cv=none; b=htjt74QYF2ll6WBH64KheJkHH5A//boKGBCkH0MHCAgTwni8RtVUkYnakIQ+p8DM9l6cEgk9VccpnsF++3tLDFN9NUq0guzJD+K+r3EDCQb4+uCcvvC+Jb8dAcNy4AhUat4UiMt4A5WSVHvrNzINqr4MRg54Cv9Hu2t95tybBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398328; c=relaxed/simple;
	bh=/apXl+wEdWI9TNJSFXK9WU/cWaESxhnBixndkHgUKlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RWayKrLxyFy3AgwPlRPhz9pl7RpmM3W+tQerVOi+AobRbOMkwsslA9AUSNdmHbu/D47vkusCdA0Mgoq+T+nbt3JSDtCLW4ufR+bJOfgdCUqwR7wUDX6hnImPXibp2GGuqiqrcnUldC3DMXG/87Y8i4l980boWGTxfpfmFnouYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OiGuWd9J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UIs7SzMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7iVhH2262758
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Kfc3k63+7Rkyz026nLt68e
	yZr5UsJxH+6rDO6dEDtRU=; b=OiGuWd9JHs2NsBF5g5/m6qor2ZCCICMwx4fLlZ
	rev76dnhyurgT/MqSasY5VO17l3gs0M2jQOLsufWMfE6Y0pgDmYXjskS7aXXYCgc
	Lj0exHeeJGFk9NVX9nWVeC/w0lise9/WBn9lRySe8lVzZBW4tiQKJzE8pVcc0iw3
	Qkl3QZY4pHATgMx+9VAlEhO4Pz4hPmsMWY8dSPhzlGLTvhko5KlAe8KAVjLaNYn8
	a3NRnDSmdlqBBfYorZ83lSYbWlkjDMJJBnhyi922YGG71IKl0jSRR4NrtEMdeKzd
	M1eC0d0eYI9QjVhOknMh+Ip30ll/bfF2wYzfha2xCzOqsrMg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4rm9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:38:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd820c6a4fso1665521685a.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773398325; x=1774003125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfc3k63+7Rkyz026nLt68eyZr5UsJxH+6rDO6dEDtRU=;
        b=UIs7SzMocOOJ5pwvigRmIAaDoAbA/Q/OZIJbQO+eIgwjAJpzKPflNzdG5+s45daGSd
         G7mSjCtz6Q6RfZpsa1uf+q/hOBhxPxSIhxtKT1FBksEXLsso0vXfZry2zQczdiIt4UwV
         60pqY8qpTIaUqFKVso8mfePVWAxmjIWR6rxuQawS97ixfFEfUqZS3lgDkvuKzojOBqcN
         yNVnJa+zVX8apKj5hG8Sx/6PiCcAUmNtHDHKu0qIxjTCCvIWJmT+Z1jGsMTjGytn8Qbi
         Fr4RoqLX7Ksnq4oMhp5hb/Xgi9yF8VO3lmjqy8OjFgNciTLTY4HkQ5SOx5lRE/cHTMps
         bGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398325; x=1774003125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfc3k63+7Rkyz026nLt68eyZr5UsJxH+6rDO6dEDtRU=;
        b=hqMD7/fNLJI8WKe+BkYt3AIU27oir6fbQZznv+zsgCNt4hALILWP0iAaBU9Ew9mywU
         3W0c3xfDbqzJOMQVByCNe/y7JiYQMYyyI+vdLb/YwnsaWQf68RNB2ijEu5xUsLvUXwjt
         RPgJs1nIj4H6rz1C6TbDeaF+rJkGSbAJQsOf1tslscxBAy5cq83YXLhtMoaAd1nKqaXt
         gHDJ5ZL+27IYxlpSQkmlZEWJiK0FEzMOEsV3SWc24IzlWn9nVG/AahKJi/edhPcd24gY
         RJpvrehKnLf1Wk0w3KvbOZAqu/V8ItuR3+OWHfE1yv6K3R0y+0M7H1zy8QE7XW2m5jK4
         sm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVSjxZd2cDhjxotihW7vbMH2EKVhRrfa3MzRNw8s5a+uiFOEvRQow0zEw/e0ZesGS9HlRBcDyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoatjf6WOqDcDgsmDuwfEalRwWGZRcDxd0DNYJzi/ZSYO2Dc9
	gUhn3XUSy2zGL4Ekac9iQLgE8YoXEtCZxEKbNIBC9VNhB9hjFLLUWPqlx7Psahc8Sy3gx+dSULP
	lHOZJoy0VVE1Q+jQrPUWreNGekCCDQxR5AqtbB/3tx2YU37VQKSpCvDrGQiQ=
X-Gm-Gg: ATEYQzzWd3GyZ8a6VmQJTE49q0J+G2SUUwl+9MccswoQqMEHueS3JdF+/03bfeU7WLm
	PGT+brqL93ZUbZRMlZnMCRwcSLBXgG/ipWj00HnbgLCBeWhEXSofYZRFdfv5KFEHDegUi/eeZZy
	DRHKlmGi3SjbyN6qK0MNOsJ9kdlVAsmIzN0Kp9Alp6aK24+gMusAIr6I3uVq/c9Od7vi/7JaZ83
	9i3gYz2B6dtTXXmQ6s8b9GSrZ6rsdHIBdKf5n0zBsojL8kDtqqkCzDzn5D/qqZGHeyAtT2fcaHx
	Zs5SSTj5DElcJSUkDYwRDdl+4cOc7TkGPHEl6u+aLF0IaD7Po16t7VVayFFwlH2E1pBjN4HG/RR
	7V9ICGspBVHBzBwxo/KW0TEDsYVgT4vOmRqfsBA68Y0nW8H4eajWMZyM=
X-Received: by 2002:a05:620a:258f:b0:8cd:8785:f00c with SMTP id af79cd13be357-8cdb5a4abe7mr368796485a.13.1773398325287;
        Fri, 13 Mar 2026 03:38:45 -0700 (PDT)
X-Received: by 2002:a05:620a:258f:b0:8cd:8785:f00c with SMTP id af79cd13be357-8cdb5a4abe7mr368793985a.13.1773398324858;
        Fri, 13 Mar 2026 03:38:44 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556426be9sm20183445e9.9.2026.03.13.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:38:44 -0700 (PDT)
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
Subject: [PATCH v2 0/7] arm64: dts: qcom: Add support for Arduino VENTUNO Q
Date: Fri, 13 Mar 2026 10:38:15 +0000
Message-ID: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CADAiTmI7jMSubFGrzmmjkGP1hlBXrLL
X-Proofpoint-GUID: CADAiTmI7jMSubFGrzmmjkGP1hlBXrLL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MyBTYWx0ZWRfX7azyFyO0Cmdp
 bcNjIjzQMFlDqVE0kkxfzg4u2Xz0u33l47mLGSjWWyCSl8r3tcmT8ql9rmjGPOFJsMh0jIVTtIT
 +/N8RguL4PzzlGgO5yf5i6+tKGo5zK0NjQT3ZMJfV97JadCt7S2hXEUGd9u94uWKYj/orsvTUe+
 dLgtnGOB41seUsX4twXVMxET4h/HoOAZRADrDMEWSHij2t9OhE8H0SKrRd5dN7b+7yvUkgbJN+i
 wac65lJdiPwVtGqYTqJMUwdJzFr0nHxgPT2k3Zc9fsnk4PY3OYDkt6sjZ9XZyD9pLukBJDKSG+o
 6apCYCLqSoeb7aEEJrKsCvGgrp7pAitCC+bMlVmQelqTcMCfOEPyGvOtaNv5a7x8ujFmRd8y7WV
 ccsYRNPDpY7KGgwewxK4+okGW0QhF4pXcM9NLf2HqIuEpAvYwl84VC4bzZMl+q+FABWF7F67zId
 kzJtGY8M66IbDTOUzFg==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b3e936 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=Ar_5JxPjAAAA:8 a=c6LsSBs3Enp-imJLyUMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130083
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
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,arduino.cc:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F263728192B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset adds support for Arduino VENTUNO Q board, which is
announced recently [1]

VENTUNO Q board is based on Qualcomm Dragonwing™ IQ8 Series processor
along with a dedicated STM32H5 microcontroller.
This patchset adds support for below peripherals
    - USB Type‑C connector with dual‑role support
    - ADV7535 DSI‑to‑HDMI bridge
    - MAX98091 audio codec
    - 2.5G Ethernet PHY (HSGMII)
    - PCIe0 (to onboard WiFi chipset and USB bridge)
    - PCIe1 (to M2/nvme)

To make dependencies easy for new audio dai ids, I have used numbers
instead of defines.

Audio tplg is available at: https://github.com/linux-msm/audioreach-topology/pull/55
Branch based on linux-next kernel: https://github.com/Srinivas-Kandagatla/linux/tree/arduino-VENTUNOQ 

Thanks,
Srini

[1]: https://blog.arduino.cc/2026/03/09/introducing-arduino-ventuno-q-your-new-ai-robotics-and-actuation-platform/


Changes since v1:
	- merged audio card chagnes in to main dts
	- removed usb-c connector node and all relevant nodes as the firmware
	 to support is still evolving
	- removed usb max-speed property
	- moved usb-role-swith to base dtsi.
	- renamed fixed regulators as per bindings.
	- reorded dt-bindings for monza.
	- converted space to tab in makefile

Loic Poulain (4):
  arm64: dts: qcom: monaco: Add HS/SS endpoints for USB1 controller
  arm64: dts: qcom: Add Monaco Monza SoM
  dt-bindings: arm: qcom: add Arduino Monza, VENTUNO Q
  arm64: dts: qcom: Add Arduino Monza (VENTUNO Q) board support

Srinivas Kandagatla (3):
  arm64: dts: qcom: monaco: Add missing usb-role-switch property
  arm64: dts: qcom: monaco: add dt entry for lpass lpi pinctrl
  arm64: defconfig: Enable configs for Arduino VENTUNO Q

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/monaco-arduino-monza.dts    | 466 ++++++++++++++++++
 .../arm64/boot/dts/qcom/monaco-monza-som.dtsi | 323 ++++++++++++
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  90 ++++
 arch/arm64/configs/defconfig                  |   2 +
 6 files changed, 883 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
 create mode 100644 arch/arm64/boot/dts/qcom/monaco-monza-som.dtsi

-- 
2.47.3


