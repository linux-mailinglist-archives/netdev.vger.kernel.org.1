Return-Path: <netdev+bounces-277674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bTwAA2IC2mlJxwgAu9opvQ
	(envelope-from <netdev+bounces-277674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BBC3DEE6C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0FAB300B445
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005EA2F6160;
	Sat, 11 Apr 2026 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CanAnbdK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6f13lY4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E12E8B8A
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775895134; cv=none; b=ZII4LoCDYapmThkieb95DBDvTms9o4AdzqqXWd6LwsmVxMrSd0rqb3DVuZui+vD61GPH1MYV+0Z+rBEvP7PT9rqgU9wMxaKf8de/+71ZSMgObFeQnRQak0oB1jo9NoQ6b6IjgJP+7OlhQNhMRAxcNOfKUvVh3tn5Gpxc/rQTDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775895134; c=relaxed/simple;
	bh=pQiqn3feSgaUicZyou6Fwb+8Rgys/xfH9OF2tMolgkE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sVR/n8t8bGaWVllvSNQZMuhVVQH04MIP5ZL4Ycqej1x6qjj36npyCim58/cUBX/ynF4haIpcSdX/rMzvlIkq9ZrxhVPkdqv8ciXegGoshtaj1VFHOig5/2jF10HSE2Z7R3Bncef/VC7bx+RrwrI4KSldnQeRp3vgMhmakxzwOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CanAnbdK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A6f13lY4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B47f7B1200627
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GlXtgT8e+zLgF6GuJlHYNa
	i0J4Taus7qR7tYmBgTmu8=; b=CanAnbdK9HXTrFUmKKxZuaKqMCELAqo37t2F6L
	GN7/lFrE96OCO9MkTg2N0vZMOfKjkAQ2n3ytZJsEIfgZVxl/xZZppUXlW5DhlDrt
	PtpRFKuCtsbpGspTUZcrS/R0uIyJLf2i7iB4rTwKuOileetU4kkJu61zdey9JRvs
	VemZtDbIn/S08ow0zQTKqU0Nf3RHdzev+qPaUN3XIlbZnrcBFuWib+qGaOjE5FYW
	sXq/0yBEdt0ZYmZISBvzrvUSzqtsuuC9WZJ2P3ysjHfs/QkiyYafQPPmVLmXZbgq
	32MHflpFiG+1z3ZyawyRtDt4GI2fMYVWQ05rlzLwGO2KUmIQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jrbv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:12:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a6906e35fso2192690b3a.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775895131; x=1776499931; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GlXtgT8e+zLgF6GuJlHYNai0J4Taus7qR7tYmBgTmu8=;
        b=A6f13lY4VTMplD/QZecg5VWMtuxVHqTuFCQi4b9rk7h4EWV9YS24zCTna/V3WtpIKA
         GbOG8s094fWYcDgwoKfaHq98dw+fNVvBfBy72dvxmTpZUKFypHJyfznkPo8Uls7VToZh
         nMQJZRbPgwAhqcRVsZoSLcI+pJf8V5JeXhxHz2PlI+HFGvFyF+JXqQKqT42D/GejXmPv
         y0GFiFLRUOaywkWV8Gn0v+BEhwR6aqBPSgpjEtsCZhQKYWfnaRgxhv1gYTSyBv9W8mH3
         ajhKsIoVtRAHuI6Diup30JFK1mNdQDQJCdQncgtBgR/HykBk/szrYlGt2tyE8x1vLDxI
         CeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775895131; x=1776499931;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlXtgT8e+zLgF6GuJlHYNai0J4Taus7qR7tYmBgTmu8=;
        b=KxJdqSOY70LfwlTZlc2oPzur+Ok9k/+CVI2EvTyTdd//d8CQkzls5s0RY2McvoNWhH
         i1kWyL44Bwi5N4EUgpolFktfjdE3q75vgZjxUFeaul1i3itWCFCksygdp/mpjdHA/nnO
         IXBcEhKXCkdBpO4YHbMGqdGnbxOliRdzi68KWxu6NqklPDO3cXNNrpPd65LgX2D+aTRn
         h23lJvVZV/TogqHeGuO1LRhQVrmpvSjpGz1DiIMdvyRI3ZyyqWCtF4mObwSmi1ujxnLL
         EMhKXtOM/Aot3VcJW+MnANLM6bvqH9KYOxJil+apxHcv4oENAfgZ2TjlNLbJyUlkgAV7
         bsYw==
X-Forwarded-Encrypted: i=1; AJvYcCVmxkYyB+cHpmgZinjKGQjAbe7AzGcvOXH4YcJHjlCe7yvKUyfIWGeAEn3/fXwqLgjBRInmoEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOP+D1ROEbNZ4Hybgg99tX6gSoHMmZB7kmYPnFLnoF6dhM/QdL
	gS4yexJr0Hmzoi3zMQWQIgAGv6a8IpGrXHN0sa3LBOdDEmUNo/ALzYrC87FOysL/R3yGUoiqOHJ
	RfEJSLFQ7M7o+9BSqs4cGAofKSes6fE0sz+HnMcahhUbrdqUl6G+MDQ6qR5k=
X-Gm-Gg: AeBDieuleqXiI3nW7QMO25zhoXrrNpao/PWabmrz3374Fk+8rlJOmb6wFJgpElwagJK
	DpdgwS2Mj3qD0Xp0tx1iNxksldh0DeDF1xkVKKqVdgFTuGU4siHzBjMGKLM+PL0vbTyMi+xd2Dw
	3Ws2DqbZXJ0uo4mgCzedibIvanPvqPNotuh/4tBX5Qk5g65YAmjdOjq5hJ/LKg/Sc2QGuEUBDZG
	bK8SD8BK7soq2Jg7kg+dcDi8sQV02TgP9TkZJhzM2KUKF9quLRy0vtx0eHsV8ogkO8FEqDzmyRF
	QFmHn0ReXCLi1yw6XT9JDU//VXQnrDNibHzjtYe2NiU6RcSmswnSxeO2J9rfuqk0jte6vEHiFrZ
	jKZf4pp7fb54k7R3kApmXUcI+FFq+3ENJIA6vhDqDv1UyjI+PpDV95LuH
X-Received: by 2002:a05:6a00:6ca2:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-82f0d10b602mr5122686b3a.10.1775895131366;
        Sat, 11 Apr 2026 01:12:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:6ca2:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-82f0d10b602mr5122659b3a.10.1775895130857;
        Sat, 11 Apr 2026 01:12:10 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee4bsm5410996b3a.2.2026.04.11.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:12:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/6] bus: mhi: host: mhi_phc: Add support for PHC over
 MHI
Date: Sat, 11 Apr 2026 13:42:00 +0530
Message-Id: <20260411-tsc_timesync-v2-0-6f25f72987b3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAC2mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ND3ZLi5PiSzNzU4sq8ZN00C3PzRANjSxNjS2MloJaCotS0zAqwcdG
 xtbUAgUJrxF4AAAA=
X-Change-ID: 20260411-tsc_timesync-f877a0394393
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
        Sivareddy Surasani <sivareddy.surasani@oss.qualcomm.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775895126; l=3043;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pQiqn3feSgaUicZyou6Fwb+8Rgys/xfH9OF2tMolgkE=;
 b=lTlPwJWcvD0IDymoSKm3DjE49QlWNpIcrOJ7qka7GLcFWgChT+ARQ2FCwXSrhrCkzHW6BtNIA
 DCP/1hHeZgdDpha/oHEKOjiilyAhMdHCe3tJfSpX9f9yhTq/zdHWa86
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDA2MiBTYWx0ZWRfX9L10LB6KhmcR
 x4zxmqSXWRdkKn8/3YZHGRFg1q1jHxAe2Hv4NdVPrZxTAnLD94Fw4hzBLbaSSJb4q8qXsmVA9t9
 Hj0zH/W3ywE3zaIyOnpGs/P9vM5cQOvpFhB6BpvNt5cfJ8TRvfPH9vEK9s/H/00P8yQ54yjW8Sw
 /kHkJT2bivBlXzwgMAAqPOQ02VVdccBhttYtGasbLCDR0KTQUm2enKxT+4Uh8tGwPeurZij0liz
 /uOtpJtWYe50kZ7qrrdW7yBT2x24y5trAbnYfSTA+4JV3oAEhrkyt5hRNEt4bbczJlErqyNb96B
 hzklwTJ0JRX0Zr0OyY6cRAeJDK5+4fxAMcx5MgvZ078X5amYBgBficTLtkkRVFUb7mKmafX3wDM
 nwUaeMFa9POerJ4Pt5BJJuKKoK0vCLfDT5qQdviAjgUrN8OrmwS2QaH7nx8bb6POcWxW3HpUzIH
 a2SBTzz7XnNDdWFvcHA==
X-Proofpoint-ORIG-GUID: iTDhy2y80hHhxQGjYUJZxJLKQjzjN-8D
X-Proofpoint-GUID: iTDhy2y80hHhxQGjYUJZxJLKQjzjN-8D
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69da025c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=iDy-gfMDp9cvPA8IE7YA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110062
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47BBC3DEE6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces the MHI PHC (PTP Hardware Clock) driver, which
registers a PTP (Precision Time Protocol) clock and communicates with
the MHI core to get the device side timestamps. These timestamps are
then exposed to the PTP subsystem, enabling precise time synchronization
between the host and the device.

The device exposes these through MHI time sync capability registers.

The following diagram illustrates the architecture and data flow:

 +-------------+    +--------------------+    +--------------+
 |Userspace App|<-->|Kernel PTP framework|<-->|MHI PHC Driver|
 +-------------+    +--------------------+    +--------------+
                                                     |
                                                     v
 +-------------------------------+         +-----------------+
 | MHI Device (Timestamp source) |<------->| MHI Core Driver |
 +-------------------------------+         +-----------------+

- User space applications use the standard Linux PTP interface.
- The PTP subsystem routes IOCTLs to the MHI PHC driver.
- The MHI PHC driver communicates with the MHI core to fetch timestamps.
- The MHI core interacts with the device to retrieve accurate time data.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in V2:
- Rebases to the latest code.
- Patch 1 (bus: mhi: host: Add support to read MHI capabilities) which
is dependent change was brought it here as the series which this patch
is part need to re-designed and will take time https://lore.kernel.org/all/CAFEp6-0ik4B20cRyid9w0f+UgibGciPof9HCWTJ=uBOPvHG35Q@mail.gmail.com/.
- Link to v1: https://lore.kernel.org/all/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/

---
Imran Shaik (1):
      bus: mhi: host: mhi_phc: Add support for PHC over MHI

Krishna Chaitanya Chundru (3):
      bus: mhi: host: Add support for 64bit register reads and writes
      bus: mhi: pci_generic: Add support for 64 bit register read & write
      bus: mhi: host: Update the Time sync logic to read 64 bit register value

Vivek Pernamitta (2):
      bus: mhi: host: Add support to read MHI capabilities
      bus: mhi: host: Add support for non-posted TSC timesync feature

 drivers/bus/mhi/common.h           |  15 ++++
 drivers/bus/mhi/host/Kconfig       |   8 ++
 drivers/bus/mhi/host/Makefile      |   1 +
 drivers/bus/mhi/host/init.c        |  60 +++++++++++++++
 drivers/bus/mhi/host/internal.h    |   9 +++
 drivers/bus/mhi/host/main.c        |  97 ++++++++++++++++++++++++
 drivers/bus/mhi/host/mhi_phc.c     | 150 +++++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/mhi_phc.h     |  28 +++++++
 drivers/bus/mhi/host/pci_generic.c |  46 ++++++++++++
 include/linux/mhi.h                |  43 +++++++++++
 10 files changed, 457 insertions(+)
---
base-commit: e774d5f1bc27a85f858bce7688509e866f8e8a4e
change-id: 20260411-tsc_timesync-f877a0394393

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


