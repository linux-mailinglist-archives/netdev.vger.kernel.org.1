Return-Path: <netdev+bounces-271494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AONmAai+w2kRtwQAu9opvQ
	(envelope-from <netdev+bounces-271494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:53:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B65823235A3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 143A530B3AD6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FA2394794;
	Wed, 25 Mar 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLFZJPce";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibU6wSrj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685731E852
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435478; cv=none; b=tUDX0qa16anYNCoBNEVPm8LgGtc1H0TnGMo7w+m6L/lDwMJ351sGFrV4c++hT9kVG+b5zl1fp/ekQlCIw98Xos074fAC2nxJoaHdNwlBbyqdA7xacDsEBwuU1FSZ6oB1HN6Z1d4egt+lqJfIvdcqM1x6JwRUGMbsvfUnaSiOjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435478; c=relaxed/simple;
	bh=1g/d5t4YEJn3vzLByvqFm7wSQmFj5knlf1Q4e1jTPPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktN/9WOs80Jt4xuhN9H0mTwu++KRPsClYeUw2VuqPv7Ey8ZTqhHQAXVvgzhsBb03Q6PD6BwA/TdIu2nTyiuQFL7lZP4UIHyM/wfBqZl7LxbEV5I4HZaFt+ACKeWJ6enkb9x9+MaR+CxQrUI0+oLbDBUehPeDgaCpV1NMtpgu4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLFZJPce; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibU6wSrj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PA2rIN560023
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aCnhiuUucRtnccc/6ZULQYlbkRL3io779F7
	YrPH1Boo=; b=NLFZJPcejrH8hZPD4qaFKq5QKEuQacCmIFLMUNqI+WeTxMB2Q+b
	BisiQeeDqr6t5WzrlSAMQevDGQdJuFFQ744wovH2QCyUH8i39MJFIWUIguZky9FL
	SQERvfo7gER1/J44mIoHqOL+q/DpQxCrt2UX+mvZfJV/94gjv3jp2z0Ol9AuI7wA
	QJo5w6aklsnoV1DnchWwjpgE4b3as0ACSwAWTpYtjBRRBFjuQu7nv+LSv1PTBWHz
	wgrHLM1b83re/Un0VdJl4jJjInKDKb/7Qpc8kNnqQANIlzjpB8Hl8V8khxBFLfoY
	QArD8wGOcSNR+1wm4zN58kfD1dg9H21dIPw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2r51t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:44:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c675116f1so3618226b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774435476; x=1775040276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCnhiuUucRtnccc/6ZULQYlbkRL3io779F7YrPH1Boo=;
        b=ibU6wSrjK7zMQBMwFUGaeF2eJfNsab82zA1Zs0n2qdsdk0EzF43oUK8oFHE3+fSjcW
         3hOrFvlqggfQWDNVDnjGEHJgzoCHMD1Y86fbqk5T9OGpl9jslq/K9i+kjwZSOtnn7JKs
         Ta19NgO0eLhrYfQS2pIeIzcXP14k8zfDSUqX/O5U6Oab2RgUl3XQ4p2LYeKaBTINaqGK
         51jAL8hZ90Yc2nBdhYOwMnW6aLyC7GEmr+UxxaLtra/uJAwZ0tTnAC6rvGf0HIW7F3kT
         XyYDV5vKklMagAyVF2oYuyzXLf6D28E/vK6Hg6n4GeJ8mExb+mcWRCFKnt5oloiGA8vR
         AihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435476; x=1775040276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCnhiuUucRtnccc/6ZULQYlbkRL3io779F7YrPH1Boo=;
        b=qWnQDc8dPOTBs4Pr0d6Qy9JgBYhX2iVVBytKRKOE573wF6mMGEpnJ0kk7OPNJ6evXb
         fxjG5dZ186ffcW/wTZl5lgZddvlD6rsftAAialwjMawLHcEn37mllxoDEjzBZXG3ut2a
         r2tqJVupFEUFLd8r2Xo81vNl/V7doATfxQM4gdoWMjN0y9frOklkBghxdqkPtd7v0H6D
         G4LQ/DD5ghrYiV71dLrC/wJF7bVJW79i4/NBjcORh5lmk3J/hhO8dvK4P0tTi8CAYVgJ
         IQrzRmHbscav1LCnKCv/evFHNPZAbltH8wlPFeMJlLN9QjWCu1f5QjBCwF/tm2zwmw1a
         Aokg==
X-Forwarded-Encrypted: i=1; AJvYcCU9RKfrR7nvY20Hfroc8z9TJcz0dW41zyGZm7tsOi4HrVctKcmDp47GmhDKVa12sTrL7w8g3wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVqVQfAhxGqZ3HSgPNyGQcVf5xVTgeFr2yjVwGMHZzI+zr2oJ
	k5vQ4VJiZ8ZPFeCY8VPaXsxrbO6yRc/zZMY/jh7xVT2s43rQ1Az3Ydbq0pQ3FiiYlFfv9dLz9/Q
	3JMSWexNUiGPihqWfgrSvynYlt9/vojlQVJus/Gq1iDswu0fyPWsdJNVkCw0=
X-Gm-Gg: ATEYQzwJ51ZasnKhgQBMeJviVSELPPR8WzgqYoCTw8C2x29Ap0HdVsR2zBrxunVJEPa
	xiY0Oovnj98cb4Mw7ACsz8lteg6wM5TKDqutux5Dy0vBEzApORHXSZ6O0rJ/vNenFGu66xfWdcD
	ucuj6AmZUXN+WqNxYOiDttFTNERaEVav/p+aOxukB1Z9yE0vp3MAO7rrNU9E338FCPPR2TY9pLn
	0RHk2BAVJatEwafbONOKE+wZywB3kbOsTwG6v9BURx/DPsYxhIaX+rHyQelczlaoP+AvTZdYtcy
	0vVNZaeQ7wwa2d1l8NE8anZGH1CsaPhBIRAPSSSp95ZokWQ70XOaG8DDzPqkpmbBYGuC/gXCfKx
	SkiLc9kF2r0u22YJD9jIHNmQ2b5zCE1pz7Z+3
X-Received: by 2002:a05:6a00:a88e:b0:829:924c:3482 with SMTP id d2e1a72fcca58-82c6e0c86f9mr2995339b3a.53.1774435476273;
        Wed, 25 Mar 2026 03:44:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:a88e:b0:829:924c:3482 with SMTP id d2e1a72fcca58-82c6e0c86f9mr2995305b3a.53.1774435475725;
        Wed, 25 Mar 2026 03:44:35 -0700 (PDT)
Received: from work ([120.60.74.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm17867251b3a.32.2026.03.25.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:44:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        yimingqian591@gmail.com, chris.lew@oss.qualcomm.com, mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] net: qrtr: ns: Fix unbounded server/lookup messages
Date: Wed, 25 Mar 2026 16:14:13 +0530
Message-ID: <20260325104415.104972-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3NiBTYWx0ZWRfXxonNp/eKnFQ5
 yvBAJ7PFmx0AtquERh3G3zsY0QnipdEC5eXEIEbGm0TgRhYWHZU8a+BizYKZhlxuxaeoFEdd/Gl
 EY6r2Znr/XAPuJrYUY48uZdp9NGMll57ktgqzoQb4gPe727ssFrIQRqG0xpuye5318nJzYcAM36
 my5f9p2krJuqAw98//wwFQCUmeRRnA03Eo4e3DyGmPucMC3RLg5gfV+CgDjRhlnIVdOFnSNRTS1
 oShs5OA6aPOqRFWbB1TgxAyACyZSWL39zpsbZzTe5ADhmcGC/suT+NTPwz6tczRvSOOXXcKZNLw
 Z80mwFlEsHuaACZI7Qu741xA8q+obJtnXJ8vzYZBrIMOzchQOY+5hrmBQ5MIXB33RcupPnFKc3o
 8Aattq7ImtaQOWLANPfGEjq9fZSRH7pr7BSm/+X39IuHXyMrjDnchvpJWIXAEqDZe22LA3odJsR
 hSoRAJKLwJlQjyYpl2g==
X-Proofpoint-GUID: TxIa23Tf_o-9DuhweryBCCmmEhdwN3C4
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c3bc94 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=DfnuZq+CPLWApegUcJV09w==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=f4Wm403AlyDKAX-waN8A:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: TxIa23Tf_o-9DuhweryBCCmmEhdwN3C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1011 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250076
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-271494-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B65823235A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series fixes a couple of possible memory exhaustion issues when the
nameservice driver receives a flood of QRTR messages.

Manivannan Sadhasivam (2):
  net: qrtr: ns: Limit the maximum server registration per node
  net: qrtr: ns: Limit the maximum lookups per socket

 net/qrtr/ns.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

-- 
2.51.0


