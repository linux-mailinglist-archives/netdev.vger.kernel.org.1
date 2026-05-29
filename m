Return-Path: <netdev+bounces-293130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEWiMOGbGWrFxwgAu9opvQ
	(envelope-from <netdev+bounces-293130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D36032F8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8225330151D5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747B348C56;
	Fri, 29 May 2026 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CnCar2uh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAF367297;
	Fri, 29 May 2026 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062780; cv=none; b=k0NdXGcr3vbGy/8GAx6NqVQOnLNXsjHnL8yoivfcYsb/hGHwq6QvkvcGGH7wV/TS83bU8HXrrAND3WM6yridAOvgQBoNTvQMU5jQwR2ZiPYs6tmJzdS/vcNy6BF/6NpeDj0TL+o9+c10PSuRX6GiY77FfcyQoCjbHdFPOXBjDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062780; c=relaxed/simple;
	bh=aLvcWmA3OcUhqIQn9JEjyeDx2QoANKgjDZ9tvQzlguc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CFPXSoSJzyamwzgzirlollcMVJa/lrA8lUpY6/EWZKAaQEqo3G+it8Xh1lrMG2NCqx8tXkrIefH9D7dus5qt9izKFFMhKwdj/qjF/q1TmrnGCuCCDurCj6wWutbk/HK7xILxrFRKyvw76fzBuw8KeQtQDwFgyVmf1pkEagmck5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CnCar2uh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBtRvt2777177;
	Fri, 29 May 2026 13:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=v6tSeFw3xOoCHYBHVcs075rlQPMC
	g0Hk5WCeRicZvOU=; b=CnCar2uhVHeE9qo0qBFKON6EKpb5E7y8ZnjiDBKS+a80
	AT77v/VdVMEdV0QzWi0qDOtSipqqiMb3AuhQ2aIMsC2wwfbi4USmP1se/4LrEVCN
	L04vHe9lHaUM54C6Lbw2XfqUl2c+ktMPFoflgLEazIHL4q6NkvVS9blL5ihuEcFO
	zpVog2qIdx/wArjABGOFUZzi0luGu7qbmyBfvDKujUzZ5PKzxckRvFpfqSgo1Eg9
	fA3arkxO81l6PN9BLPa3wag96fgCoEYaPp+Bo9xU4a4Jsk0zRW7i8HVPl7wpnLA2
	xVwcCND8+INz437IdMR2XuYDnHZlziOZ7I6oY7iotg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889gjwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:52:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TDd96s020547;
	Fri, 29 May 2026 13:52:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbdub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 13:52:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TDqavw59507010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 13:52:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367C858050;
	Fri, 29 May 2026 13:52:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A776758045;
	Fri, 29 May 2026 13:52:31 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 13:52:31 +0000 (GMT)
Message-ID: <d6cb7128-3cff-4a9f-ac9e-410009b2890e@linux.ibm.com>
Date: Fri, 29 May 2026 19:22:29 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [mainline] selftests/bpf: struct_ops_assoc test hangs indefinitely on
 PowerPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NO92FGkBQqdUYgI90IARzL4agbYXgZUZ
X-Proofpoint-GUID: NO92FGkBQqdUYgI90IARzL4agbYXgZUZ
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a199a26 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=qbdj7LMxSyKbK4Z0454A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzNiBTYWx0ZWRfX7t+dZM0TSu5D
 3qAm0nC6CYXaMArtVipIak4kI6TbSkgJTcUF8FTyggDm5F6ze67SbfvN2+K5my5klbCCTzlpxpq
 /zyJ0Ttt0Vxkh8DiMCBtlByjgl4PDLBdUuiSeofXNH+fZOkxV9Z8vywhIH0QJthhoqcmtoWNFxd
 1X/S2LbXoMirr9av38B4ThsHPNMZCLgnEAzUDU9NA+rLmR/5B/cX6gVAwqjR00tg83wivQ3FWXE
 Bttr7NJZZoik0fpcDBkBSIx2A08v26mcG348abhe7D4fKmNHcT1mh3fG885boE0AUwwCIUcbyhH
 4tgaJ0O9xk+Nn34vGqxonLtASVVG0GU7HIiEDmj5BwhgGW3Lua9sNMIyuA1OHePPFkK7YS5ePDc
 FjeqetL9sjkjhe/K5pCVS7Y6Wy9cSWwPTeAO1J/Ta6Lca2XQv5ZQBcbVX1IpVK5T5RfaM6rCJun
 trbdtQsZSdMeK1gOtLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293130-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3E5D36032F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greetings!!!

The struct_ops_assoc/st_ops_assoc_in_timer selftest hangs indefinitely on
PowerPC, spinning in sched_yield() until watchdog timeout.

**Test Failure:**

./test_progs -t struct_ops_assoc
WATCHDOG: test case struct_ops_assoc/st_ops_assoc_in_timer executes for 
10 seconds...
WATCHDOG: test case struct_ops_assoc/st_ops_assoc_in_timer executes for 
120 seconds, terminating with SIGSEGV
#445     struct_ops_assoc:FAIL


**Architecture:** PowerPC 64-bit (ppc64le)
**Kernel:** 7.1.0-rc5-00149-g8fde5d1d47f6

**Symptoms:**

Test hangs indefinitely in infinite loop, repeatedly calling sched_yield():


Stack trace:
./test_progs(crash_handler+0x34)
linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0)
/lib64/libc.so.6(__sched_yield+0x2c)  ← stuck here
./test_progs() [0x105ae220]
./test_progs(test_struct_ops_assoc+0x88)
./test_progs(main+0x7ac)



If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



