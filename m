Return-Path: <netdev+bounces-236374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E0C3B381
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F681890EF6
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49432E751;
	Thu,  6 Nov 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I68URC+G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijG9ssyF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E25B32E6AB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435698; cv=none; b=AmqyY80IJq2hxwG5+jZfDNTXKm6FuX/sZJ2DM5WUG1Q1gFZ3K3OkPAFAWsQL0g5+hjhL71m0xfjpSVm2Vtj+PbtyeTxrNmCk++jQNlT62m7c6HCKj9RweWFTTt6x5mAnsfU7KBSvS1magwT0i3hxbsYnscmJ8WqiXJbMHLX318Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435698; c=relaxed/simple;
	bh=2h1I5+IC5FJduxoWNinXYw0aN3SdJu1DaG7hWWK8DdQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r0IPSbWtT+x0vdJHS9QCo6VXfjZqsdExewgrrF0bWLfdJzCOok4Ppuhda+SZ3ZS0NBO+GtggJRGOeOQR/PheAwrVRlmRUlv8oanoulWtw3XvuiZOV0rFVQYddihKvCzAIGeoIZCo6T4CZna8AxXF3J8QT22chIqGh7rtA27eQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I68URC+G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijG9ssyF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6BlAPL4131373
	for <netdev@vger.kernel.org>; Thu, 6 Nov 2025 13:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o6mzQWJ7nU2gb68GlaeuTy
	m+gIZLvymtrF4X9C3SVhM=; b=I68URC+GaXWmwqL66JIfNanDe1iPj6smB/MKc1
	XbY6MwXTbIdpQ7u2MXpKLAhKeyFJ05cCzpDTRkC+ukaOJGd1CJ27QDRKSwHYLy+g
	ajioTRtj0quxs9BPp46ZcnWy2dTTR3PLXoQ/ypXT21IF/Flf+r2C3iSXFCypKdnE
	mo/cDkFx3MSo8/VvT01IcTiH/hC1M/i9Q4Z6nYdWQglJgXNDXJEiEqqy4nCGVRz6
	GTPUmUCwRhBmA4cG0F7Zs3TnBlcytdCgMstNyx8fR2XmY7uT4SYYHfMxh/fg9TdR
	7a/hUjixoGJqbkTCaqPy6pDf6JWG97I/zXEfm+l372zgw1qw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x085q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 13:28:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340fb6acc39so1357703a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762435695; x=1763040495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6mzQWJ7nU2gb68GlaeuTym+gIZLvymtrF4X9C3SVhM=;
        b=ijG9ssyFDBWY7dBarMTdgMq5JRtfSm+Lmpjksx3nVvl33+1W8qci0zG0CngWb/aKa6
         31/uNb/PPLOj2fAb/Y5UsRPz81YQRw82Ebu8nnHuuC4MjQsIGeUq7vx6X0XUtCa+T0n7
         i9VhN8gpT2KNxr02+yQkXPOOH79924ShhuxXja6+ytTcrSrzG8VFZEXLaLbzA9Qx0wsl
         NNkkLGXzWhVr2JIjnkClFPXDI2tFI7WOHOp3Cu/aiMbdCNd9Xkuwf/gOPOiPyMueykPq
         GY06VbcZ7QiikRq1+iBzCB7BMv4LsmMIao3amFbtf3jjfHyC4+Doe4I/kAHAyv3gqqWu
         /kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435695; x=1763040495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6mzQWJ7nU2gb68GlaeuTym+gIZLvymtrF4X9C3SVhM=;
        b=jGOkAxGjEu892UFfCES9c51pmCmVP4iHKT9MGJOTmfbbYfI5jcbo/eAY61AkNPTK71
         tqhy09m1zZhf4mqZT8cd8Oz7Kq1X2F7P4cruuWpcpAC6NKui4MG+Mcor9AxSrishivGW
         rRsNCIOCYyBFrkCQ2pKLOWOVESCH085z1zJFV/6s6lHT4WTTOupMzXlmTcf+VASUSflf
         gYf0pMlcmOhhym9wAtIE7vi5rchTmusGMH9jrACQRnrbJyRnyxldc5qETPUUBPQT+1Ha
         nr8C8kHE69XD+dWuM3iEn7UkcxqsQWm5GFVRKqONoJkNCiMIgWYznMxNb7PdFwxBzeT6
         oypw==
X-Gm-Message-State: AOJu0YzL3002ytDZPk0M0G5uUpg+uWm0KsW7ZuTFEkUGUz8ISEt9f2II
	KUWKdlZ1e2utnINIRR3lBBUfmrDubpBheaVp5qN5brKu/9dlWZRDqCPkXD5mcl+nY5jXV9sWgzX
	HqctSTd1zhlj+B4zlURfLZW2sG/Q1R/EZ3TMiyv8qq7YY1cjFGdj+iR8Qi0A=
X-Gm-Gg: ASbGnctd59bM50lHlHeMLEA9GPMA+CV2GJKOurzqM2hHFd9+S4PPqp92Lb+YMX7jwTD
	cZKJZ+Nft4aIxiucd9PM+kVO5siz51vToyDOh78ss9aciobLmVGd6Y32oCQ/bTCf0nNfwyomrWj
	NaaeYUs+VtCQ7I6HtvF/6SbzRv76pJgqobQZfzwEjwwKlR/K9pyniWtwADsRI7cGgd81XDuwi2f
	ma7kZ3ybSMKdV94dWrdJXl5JZrrp38ZubrAfBlsSu26RL9LdhRoJWEKb5lR+NZuQFHHYmlljQaz
	mOSAnKTtRTOJsFwCLZNKjJll2U7u2ZJfsIivby2HkadkCvyjVXR921fVUSKZnpYvftSLKUeefHL
	gZFvLF8oyeRMaiPViodVUhlDODA==
X-Received: by 2002:a17:902:d584:b0:294:fcae:826 with SMTP id d9443c01a7336-2962ae9e353mr96453065ad.59.1762435695305;
        Thu, 06 Nov 2025 05:28:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSFxsiJ9uoiJUwbYs+c1n6AQH0+KN6pf7n2+/tZuBDDoIN/SDu6tuMS3691C9fjWWe+K+SGw==
X-Received: by 2002:a17:902:d584:b0:294:fcae:826 with SMTP id d9443c01a7336-2962ae9e353mr96452765ad.59.1762435694673;
        Thu, 06 Nov 2025 05:28:14 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm28770225ad.94.2025.11.06.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:28:14 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Subject: [PATCH v5 0/3] drivers: net: mhi: Add support to enable ethernet
 network device for MHI NET driver
Date: Thu, 06 Nov 2025 18:58:07 +0530
Message-Id: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGeiDGkC/zWMQQqAIBAAvxJ7TtDKoL4SIdputRcLDQnCvydBx
 xmYeSBSYIowVg8EShz58AV0XcGyW7+RYCwMjWy0UrIXCSkZT/clfmXo2gWi6vTSOoeDhRKfgVa
 +v/E05/wCfzajDGgAAAA=
X-Change-ID: 20251106-vdev_next-20251106_eth-dd145c3bbd9a
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762435691; l=1362;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=2h1I5+IC5FJduxoWNinXYw0aN3SdJu1DaG7hWWK8DdQ=;
 b=ZwpGqEXZUQmUg6ICYqqWCw9x0Kokox8JXNsLBX1vf2dZG4LAgl3f8PKnrOe11Qr31Ydc4dqAK
 lXB7mcsCjtCC8eNC1Cfp4x8bgHz5dxK2yApUZ62b/XdBoyevAxj7Ser
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwNyBTYWx0ZWRfXzsHZc5UqTqyz
 zfNIIhzr7HEITAHvT4Qj1vBH8BWPB2tbsQKwVnpHk0k+8/usnxRsiEAGmTqC2u+PwcDsM8+LEua
 HeG6pRtce2LoBhWtrJBcAqFXUOBYGtTotNFDsgN6GHr8inRM5CTTCT7RiaR2LA/p0SB3bTUFgqT
 FgO+gQG9nC4Nde9snYKvOEznwdSWapIwvsETsETE/34rWn4TTxspqd2MvL4gU1/BR7uPAsTRGpG
 xaX19K82xpIjgX50lO2ZUlx/yyMw0wA3rNyYNdH6FjQpeEDoDeXth0Nzs128w0nYWTmzSwy0u7u
 rDKxrCZa3WvEqBEujYE90p1FLQ9elPLHAN8Q5U5yR0vPZENhygWxryM69hmSjfIedHeEuELP3Lr
 xsWyntfXESeImYp+dY/31NFHua6r/A==
X-Proofpoint-ORIG-GUID: zgqHdlOqbAQ-cn9kbiupoKtu62HV7FQH
X-Proofpoint-GUID: zgqHdlOqbAQ-cn9kbiupoKtu62HV7FQH
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690ca270 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=veql4nHwU9hKf8MHYCYA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060107

- Add support to enable ethernet network device for MHI NET driver
  currenlty we have support only NET driver. so new client can be
  configured to be Ethernet type over MHI by setting
  "mhi_device_info.ethernet_if = true"

- Add support for new MHI channels for M-plane, NETCONF and S-plane.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
previous patchset link: https://lore.kernel.org/all/20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com/

changes to v5:
- change in email ID from "quic_vpernami@quicinc.com" to "vivek.pernamitta@oss.qualcomm.com"
- Renamed to patch v5 as per comments from Manivannan
- Restored to original name as per comments from Jakub
- Renamed the ethernet interfce to eth%d as per Jakub
---

---
Vivek Pernamitta (3):
      net: mhi : Add support to enable ethernet interface
      net: mhi: Add MHI IP_SW1, ETH0 and ETH1 interface
      bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for QDU100

 drivers/bus/mhi/host/pci_generic.c |  8 ++++
 drivers/net/mhi_net.c              | 87 ++++++++++++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 13 deletions(-)
---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-vdev_next-20251106_eth-dd145c3bbd9a

Best regards,
-- 
Vivek Pernamitta <<quic_vpernami@quicinc.com>>


