Return-Path: <netdev+bounces-296512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u1f1NBexJmr1bAIAu9opvQ
	(envelope-from <netdev+bounces-296512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7E0655FC7
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=SrT4oLgh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296512-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296512-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB0863007F60
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03D372ED2;
	Mon,  8 Jun 2026 12:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB06372696;
	Mon,  8 Jun 2026 12:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920264; cv=none; b=rimlEvqBeN95fjZEORQTI8MJGMZpuVZbdFHV2fuXr+tQ/wzDhZd8YFFf5202XAfgZuJHQQCMuONYDWQotLL2d/oTLEWfQLSP4ZFXQOdOVTdo91nVudfShOOwxK8kjcPL27KDpNIgTuWgcuSGSoPGMN6OPmtAXTaWUH5GZzw7odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920264; c=relaxed/simple;
	bh=VFTY71FmyyBAF7QSirUul8eLh4ywEUN3jYudm65Gopc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ec9krYYN+4ACQVdJ16jlYT8cl2sdT3u9dlXbsyjwqLEXyRArXYPJUlmA44kHWOuBuxpH8qlXQwI2PhYxDinzL2yoOPRs34lK9C87RI1lnwoblRuCr+BaZ42FlSNZy2B52Y2Qpyuz0JFYb0Lu/ZsoTtcFnVH93LwcxmJXL6X3w+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SrT4oLgh; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587nmSv1596687;
	Mon, 8 Jun 2026 12:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f9Or2Z
	z0HzX2sqdKsSO0pvkM1+40p2vgkpOS8tr1vAc=; b=SrT4oLgh+Lz6eI7v/YRqHW
	w+0f2niJT6mn8/nIcNdgIZJeNNVbp3fZ5kEVN7LVCrYNrBccK1c7BpLjR5GrJKUu
	6/fULpxC3Y5pJ/dPooP9VnDHyjiBjRzKUpy1CAHJykTwDHvPlGeqC0djeVVmbFYP
	CLvKSxDS9UE3Up3/fPFq9cqA5pwhWFEqM8A3WpH9zgeyITFuRxO2DHdo/Ox+Jb+t
	fN6QsSXci+p4RaFLQs1IfIrKkZ7ukdyDHIJHCpTipgC573gWnGBezoomH8yo16dT
	vXYriaUu/oP7WbwpCX6FPuolSWFM385e9WFaUnHlH/E8yD3jvkaC9T2czeobu2iw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qf2rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:04:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658Bngsp023861;
	Mon, 8 Jun 2026 12:04:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpwae1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:04:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658C4H0p22020820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 12:04:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5A4D58067;
	Mon,  8 Jun 2026 12:04:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415E258056;
	Mon,  8 Jun 2026 12:04:16 +0000 (GMT)
Received: from [9.123.9.7] (unknown [9.123.9.7])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 12:04:15 +0000 (GMT)
Message-ID: <fdef9aaf-af56-42b1-975b-19a4c19472dd@linux.ibm.com>
Date: Mon, 8 Jun 2026 17:34:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] kernel BUG in team driver: buffer overflow in
 team_add_slave()
From: Yeswanth Krishna <yeswanth@linux.ibm.com>
To: netdev@vger.kernel.org, venkat88@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3ad19e86-234c-408f-896e-0d6c774fea49@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26afc2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6i1IRE6oVdN0yyl8cBUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fYkDlWuD2UVKzKd4I3KTttXR0ut-jb0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwOSBTYWx0ZWRfXzNH1u+l6N4uG
 mGMm3mzOVvIvR2symKd0+harZ2tuIyyJf9SQp4r9N8uLgHyH9Vd1AuRyBRqksJUuNkcL+36wHEI
 Kj3VSQWQzBd006tsWpOKkndWqpD+0Aym+XF2AXiBjr2DxNlHrImtZgXBs9+la3hIliCJdHUunOl
 74XA3mqvTb8c8bCpYEt8QZHbKDCKnPZyhE5OviAasY8/C3xW/0tS6O6ff5srkXuwnn8DKv1ES1J
 2n9LGmv1Iy/cL2hW7FHiM7cW1Y3fiuZeepM2fXnvhBvzSCIjY7HF4ZgNnYymfYTPXHfNjYUkwjm
 2dFR1WEyXsCP/Bt/n51dQxC07WwD5m/J6F08aZ9RQVWJenY4kZYEXNTOtecBFm/50wdTaIXtXen
 +1TFF/w7kU0nW6xk5ZhUbMRgPagWri6UaYfkkqp6/ojeGN5UUYTbxHScrCVlyfG3zLE7cJxb5Oy
 4iSXKWkC4lyi2FGt1mA==
X-Proofpoint-ORIG-GUID: fYkDlWuD2UVKzKd4I3KTttXR0ut-jb0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080109
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:venkat88@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeswanth@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F7E0655FC7

Please add this tag Reported-by: yeswanth <yeswanth@linux.ibm.com>

On 08/06/26 3:30 pm, Yeswanth Krishna wrote:
> Hi Team ,
>
> I encountered a kernel crash while running selftests on kernel 7.1.0-rc6
> on a POWER10 system. The crash occurs when adding a slave device to a
> team interface, triggered by FORTIFY_SOURCE detecting a buffer overflow.
>
> **System Information:**
> - Kernel: 7.1.0-rc6-160099.42-default+ (commit d548c6f4301b)
> - Architecture: powerpc64le (ppc64le)
> - Hardware: IBM POWER10 (9043-MRX), pSeries
> - Config: CONFIG_FORTIFY_SOURCE=y
>
> **Crash Location:**
>
> [ 3492.897824][T77143] kernel BUG at lib/string_helpers.c:1044!
> [ 3492.898057][T77143] NIP [c000000000ac1120] __fortify_panic+0x18/0x28
> [ 3492.898096][T77143] [c00000000efdb350] [c00800000b857a18] 
> team_add_slave+0xc60/0xcc0 [team]
>
>
> **Call Trace:**
>
> __fortify_panic+0x18/0x28
> team_add_slave+0xc60/0xcc0 [team]
> do_set_master+0x19c/0x240
> do_setlink.isra.0+0x388/0x1450
> rtnl_newlink+0xac8/0x1030
> rtnetlink_rcv_msg+0x450/0x530
> netlink_rcv_skb+0x74/0x1b0
> rtnetlink_rcv+0x24/0x40
> netlink_unicast+0x2e0/0x430
> netlink_sendmsg+0x210/0x580
> ____sys_sendmsg+0x30c/0x470
> ___sys_sendmsg+0x94/0xf0
> __sys_sendmsg+0x84/0x100
> system_call_exception+0x154/0x2b0
>
> **Reproducer:**
> The crash is 100% reproducible via selftests:
> ```bash
> cd tools/testing/selftests
> make -C drivers/net/team run_tests
>
> Please add below reported-by tag:
> yeswanth <yeswanth@linux.ibm.com>
>
>
> Thanks,
> Yeswanth Krishna
>

