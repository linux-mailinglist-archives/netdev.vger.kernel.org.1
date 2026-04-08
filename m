Return-Path: <netdev+bounces-276214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD50CRuh1Wnk8AcAu9opvQ
	(envelope-from <netdev+bounces-276214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC62F3B5AF4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014E93013693
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC611258EE1;
	Wed,  8 Apr 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EeapWI4I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FF946C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608087; cv=none; b=EW6X+eUNcSb8Ojwxxmtg9AaMy0szZHU8YNzix7Sc8x5bDCnOTSXehY98vhMQ1FxaF+Z0vjPcAccX/f3mVE7xFx7mbwgCyZpNsg799VVaORgsUhr+hbTkvV947XIy319t/Zp68bhmCbKoXaLPXV+dY1u/jmDZr/G6E3nmiATF+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608087; c=relaxed/simple;
	bh=e2+jsbOzfqYPkKlVYAm82qfqErfZxtXvTuGiht2gEDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fmjC2vjBeTAsuKBeuRD9ZyUC2Sgq7Vrm+GUOCuKkmnZydxVYkSXQKBv5PB37s9uDky9ODzA0MxN6LqaYRIGOJW0eTocwDZfiZgT6zrnNsDRNbIq/fsNsnKVkOvwiJGCTVbEjG7fOC9RNqtG4V7776oGpWze7r8uQIzojVZLsSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EeapWI4I; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637LAwlZ3122740
	for <netdev@vger.kernel.org>; Tue, 7 Apr 2026 17:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=9T9c1yN2SOjCcS/gjM
	S9r4uUQmXJK8+FifOPqIimOI8=; b=EeapWI4I7AAmUeE64PZaoW3Cu4Hl/RxMmX
	OyFmiu2pelFr59G7z1AcN/nxKsYIP7UCxs2phTEoyZRt00yMeFvqFxnyrNQ9bdvc
	upHCpx0WzT3z7nJH4kX/Dsc8XGgzrk4/2bPF3/Kgqe+5UpPuj8gjP+ok9spKZnNk
	CQTL+TNnqP+fm/QptLLa1KTHPCWkoNXCCZ+w9wCdLs5vgRVQXvq5xGfXxx4nzmEd
	RaLfI17YatML5GGl6lpddVbnenNQLICXGuTJlHTJ6AqlNNUwQCZHxRp9qq8kTRy4
	Jr6u//ue7cR+Ja/AbPYRlIQWEwq0ESdT9tWyOQT+JP2yuXa83Hgw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dcv8rdxnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:28:05 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dbbb806e10so9865213a34.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608084; x=1776212884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T9c1yN2SOjCcS/gjMS9r4uUQmXJK8+FifOPqIimOI8=;
        b=OQWeh4Mcj21l9jzBkJzifoEGELvLxJjSuTH+gVmHiSvfpXTXELZHXyzbkG1yMavBlU
         fYEVBSWH2HY4QCMkW5YNbGIgTGpJUn1+6qxxEIG4wVe/Ua60N4gBbQcAwUKDIebEOH9E
         Hw+kHylVtGcW44qP0f3Vunl8JKqmPFE9KXgKlDb6Gp/rOtPZwGhBMdeGQAiXHC0hbeEV
         EJVGKzb/1npLMzpgOEQHCWSJoXluhzkg+OSga+9IYb5QLcq9KuJflltdouEMYYJ6JLch
         U49U+O8LEWVEObznVvksf4vC5Ny9UJx3uQ7I6u+aBOKcRs/HJxaIDuOnI9LdDj67mTGl
         pOkA==
X-Gm-Message-State: AOJu0YygKQv8P4gtCTSAo+92sHpIH0rnKyzcAaPW1yEI6bCXvOFusjce
	ohwjcSfcm4CZDFuRHcBzLC29k2tACr86yCBbrJxrCinNKXYTq1IkaW8f070QQKz52e2wdb5/OMM
	pTO4DWypMclZZF/g7DpEyLMBKGezzP8UaYXArpMHLBZs9YnE4zcWZL0sFzxF/hVcovoXYWEiJwM
	SNKwL3D8PRBhYwYOJyiEmb+uE4C5eZDprfW4ud
X-Gm-Gg: AeBDievhMghJG7uUFgJ7YrnsuFN0bjdkdtB72ZF9grIElFUm68JBYT+/BjHDxquTgXk
	B/msSWf6lyBgMH7ghnW01qbNem7ykvFWNM0USgrDHJydzSp7g/F6EcXcjc96uZiCmfpvPzNBMqt
	t1b9i1Jk7b73CyK9k17Kn7pYh/qMRHS5/M90k6bSq2VjinwIzfXL8ndK/x8VIOkG10ZNx/mBnpW
	DqSvQeTCa6tiUwh0qQ4GhoQXDUqeohJXxSNmqbs4O7rvBS54cXmj+WF6a8MH5Gt9YD/3dINF3+3
	8uC3ABV+D13x0/ysM3umOsLbdtoZz/kLV2mAj6YUSBniBgOERs63k8ET99WJqDn5ENL71peNpLD
	pxasJK7X2+A==
X-Received: by 2002:a05:6830:2546:b0:7d7:fada:89ca with SMTP id 46e09a7af769-7dbb70cf2aemr12124483a34.15.1775608083957;
        Tue, 07 Apr 2026 17:28:03 -0700 (PDT)
X-Received: by 2002:a05:6830:2546:b0:7d7:fada:89ca with SMTP id 46e09a7af769-7dbb70cf2aemr12124458a34.15.1775608083533;
        Tue, 07 Apr 2026 17:28:03 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb40b1507sm11892876a34.21.2026.04.07.17.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:28:03 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/2] tcp: rehash onto different ECMP path on retransmit timeout
Date: Tue,  7 Apr 2026 17:28:00 -0700
Message-ID: <20260408002802.2448424-1-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7707qzXsIiIpdUEgyn313kbcLHf9SA7_
X-Proofpoint-ORIG-GUID: 7707qzXsIiIpdUEgyn313kbcLHf9SA7_
X-Authority-Analysis: v=2.4 cv=PZTPQChd c=1 sm=1 tr=0 ts=69d5a115 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22 a=hM0cxhbbTpHyH0yoP80A:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMiBTYWx0ZWRfX8fG3CLzxJHgC
 4BWTLJMAUc4X3E7gfBZpya/s7Is0ZFssvcpLRUnr1T05JbKGwx8md1uEOZgRzaJShUS58yl94TK
 IxJ6vsYnWiNbrOWqjmLFCzVUAj9Ymw/VyfXwqzhVOO25BpTbrZE3gyFUugW1vGe25avRX+EKUWZ
 kOFJAoosvqXzWRFdvranXWKEfwVhse9nbbceXsmtHjgsNU9Z8SzCavJAQjUUg1PCmZeJSkRLueI
 RKdDLucUYp3REGWO16poAFhQufONk+uBnxJUjsadP/zZFpyS63WIptp4QMeIe3ScwfVCeH87fdk
 xmfF4ykoZM9QMxQfK40phtQA1FopN+L4b6g4k69e5UDEmwnSQdwPt2s56i5cSoNL7saWFS066H8
 avhKEwSFh0iLOzNejf4fqLJYTmTkT2x1M2ecFIZqUm0Xi8QN3i3r+gzeJHRkP/rNKzMyD+sjpJw
 Kzw3X/EGpr5VOKsgX4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276214-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC62F3B5AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I configured an ECMP route across two local interfaces, expecting
autoflowlabel to adapt when one of those interfaces is blocked in
reaching the destination.  However, it did not.  This affected SYN,
SYN/ACK, and established traffic.

I was able to make this work as I expected it to by calling
sk_dst_reset() at times when txhash was updated, and propagating
sk_txhash into fl6->mp_hash so fib6_select_path() uses the socket's
current hash for ECMP selection.

I expected autoflowlabel to apply to local ECMP routes, and think
it should, but am open to feedback if this isn't the right way to
do it.

Patch 1 has the kernel changes; patch 2 adds a selftest exercising
SYN, SYN/ACK, and established connection rehash over a two-path
ECMP topology.  The selftest retries a SYN 26 times, so has a tiny
(~3e-8) probability of false failure if repeatedly unlucky with ECMP
path selection.

Neil Spring (2):
  tcp: rehash onto different ECMP path on retransmit timeout
  selftests: net: add ECMP rehash test

 net/ipv4/tcp_input.c                       |   4 +-
 net/ipv4/tcp_minisocks.c                   |   9 +
 net/ipv4/tcp_plb.c                         |   1 +
 net/ipv4/tcp_timer.c                       |   1 +
 net/ipv6/inet6_connection_sock.c           |   8 +
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 354 +++++++++++++++++++++
 7 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

-- 
2.52.0


