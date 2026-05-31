Return-Path: <netdev+bounces-293438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E2n+AxdPHGorMQkAu9opvQ
	(envelope-from <netdev+bounces-293438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:09:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7B616C0F
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82C830160C2
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09F34FF41;
	Sun, 31 May 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7+BBswN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C823ABB9;
	Sun, 31 May 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240148; cv=none; b=jLZfWwqEReOpA0e2u2NN2BNtS3kEndeqyuU2lsDuMRjZQXp976Bh0RDWi9ErAUn1jXWY/S/N0au454f/QvZuv6Xm0KjexmjO8YgmTbpAuMhpomZS959U1y+RZ0M5IrznYjPf7gjvlxbnYX4xirjgtvsn1qyczzsVzIs5L+0jcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240148; c=relaxed/simple;
	bh=10atqYrLaJGKgBQC6NCNUd6KWom7DAv3DaumGRIe6l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gn3pIshov5yGWNyS6avMIIsy34S24kT5PoEk/cBWIcqpfhFiKg+Bgay8+p5Azru46lw2XwJDR0lVwEm3IEnl8jNWoLnTEWB1flIxqHXNpyoZEytj1+J5pp7YUo32x69tkWoxImwcYBF65/ZNWQTYBnwE6uTdqBT4/iygUAred4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e7+BBswN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V47FZb2292720;
	Sun, 31 May 2026 15:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d8RzpE
	SidvKK8rHOAWFW2Z2XR8DQggNk9Hq1RIAx/gs=; b=e7+BBswNi0VdCDPFHdbCbS
	5yxqGjH1+dg0l+dbh3d4lI1g9QHXtRHXHGBRNJ2iupNq1J/s572870mD2ztdbKif
	7iI8L1aXBciIgkLR8oJrAGMnne/nPUlLpSOOMEjjwhwKxB7NSujr9SB0ZwHSVasl
	oUXkobkHdtTiIbojN8JCDuGTYchGoXEuI5/eyP9pWRemTSPjD04cYKFcQ3/GDwpM
	ih5VQO8xLy/e6Ni/+wHqLRAG5tHVs0nrqQbJlM7SBmOBTw4J4W2G1T5OOgy3iYUP
	N1KVVFHntkhxf6pM8c0h9UNuAWiY3DZMyMmRtH5Psks62f5f0PoLrP6ab06fuARQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjpvwdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:08:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VEs6KV002699;
	Sun, 31 May 2026 15:08:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh21q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:08:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VF8W8c29885056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 15:08:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A4FD5804B;
	Sun, 31 May 2026 15:08:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D4B558059;
	Sun, 31 May 2026 15:08:23 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 15:08:23 +0000 (GMT)
Message-ID: <822b40f8-7e23-4f91-a048-c2872e04dcb6@linux.ibm.com>
Date: Sun, 31 May 2026 20:38:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] nvme-tcp: implement host mptcp proto
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Meneghini <jmeneghi@redhat.com>,
        Randy Jennings
 <randyj@purestorage.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, Hui Zhu <zhuhui@kylinos.cn>,
        Gang Yan <yangang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
 <a3ceb2b974d74b78d205731353f5e3bbeff2acf4.1779934709.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a3ceb2b974d74b78d205731353f5e3bbeff2acf4.1779934709.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: T3buCMTza_xDN3L0rI9flmIQtNB52e7k
X-Proofpoint-GUID: FdilKW1GDCBjTaKIn6fpNZxz9Qx16Dk0
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1c4ef3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=WTJdmG3rAAAA:8 a=VnNF1IyMAAAA:8 a=ZCWZM8ohGpsOdJoV-x4A:9 a=QEXdDO2ut3YA:10
 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE2NCBTYWx0ZWRfX+2cDxE3MPPKT
 yrelqQyp0V4LBWbpZUfAbiQkSWkPI31IxdOLQKQN3tfuYNyZEzjkq10psN16Av36Q+JpUBWi7Hq
 QLumPfx7rPYYVjH9ktjiB4NoazC0NzAVuTKEMBqXpJpK6YkdHe56HJxYvxsh/neV79jbh+hCaWa
 fNeeJApiZ4dNzC+cVTsS70tb3hIrEftEQt1oCj6bntbLEyinZQVhII0oGpKvNkcszcvjFbEeEi3
 CSHlMwxFcbPE4EF0N+ZG3EMXxxUvXD2OkaYCvK1hyfnnYHqOpJqXtXdy8O/R/aXCfnJlIIPA+U8
 Xt3tzr3uZuH5zaTWJQJ7uJKTKXLXQEqsT4V2lAexTHb32pe9iIJOn5JUilZ0PWHK+tHCQ4NjGlF
 gGzEqGRKB/j7KbcZXuDNIjZaxdyy19FAHHFHepuBgpPI7v5ehk++UbgfRu4rvMe/gZLDy/i6QW4
 pRsWDOUBtxC12GTz/Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310164
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-293438-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.ibm.com:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,purestorage.com:email,suse.de:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 54D7B616C0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 8:40 AM, Geliang Tang wrote:
> From: Geliang Tang<tanggeliang@kylinos.cn>
> 
> An MPTCP-specific version of struct nvme_tcp_proto is implemented,
> and it is assigned to ctrl->proto when the transport string is "mptcp".
> 
> The socket option setting logic is similar to the target side, except that
> mptcp_sock_set_syncnt is newly defined for the host side.
> 
> These helpers set the values on all existing subflows of an MPTCP
> connection, except for set_reuseaddr which only applies to the first
> subflow. The values are then synchronized to other newly created
> subflows in sync_socket_options().
> 
> A separate nvme_mptcp_ctrl_ops structure with .name = "mptcp" is defined
> and used for MPTCP controllers.
> 
> "mptcp" is planned to be introduced as a new NVMe transport type into the
> NVMe Base Specification in the future.
> 
> Currently, the Discovery Log does not yet recognize trtype=4 (MPTCP), and
> will show "trtype: unrecognized" for such entries:
> 
>   =====Discovery Log Entry 0======
>   trtype:  unrecognized
>   adrfam:  ipv4
>   subtype: current discovery subsystem
>   treq:    not specified, sq flow control disable supported
>   portid:  23106
>   trsvcid: 23601
>   subnqn:  nqn.2014-08.org.nvmexpress.discovery
>   traddr:  10.1.1.1
>   eflags:  none
> 
> Cc: Hannes Reinecke<hare@suse.de>
> Cc: John Meneghini<jmeneghi@redhat.com>
> Cc: Randy Jennings<randyj@purestorage.com>
> Cc: Nilay Shroff<nilay@linux.ibm.com>
> Co-developed-by: zhenwei pi<zhenwei.pi@linux.dev>
> Signed-off-by: zhenwei pi<zhenwei.pi@linux.dev>
> Co-developed-by: Hui Zhu<zhuhui@kylinos.cn>
> Signed-off-by: Hui Zhu<zhuhui@kylinos.cn>
> Co-developed-by: Gang Yan<yangang@kylinos.cn>
> Signed-off-by: Gang Yan<yangang@kylinos.cn>
> Signed-off-by: Geliang Tang<tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
>   include/net/mptcp.h     | 11 +++++++++++
>   net/mptcp/sockopt.c     | 30 +++++++++++++++++++++++++++++-
>   3 files changed, 74 insertions(+), 1 deletion(-)

Agian the same comment as earlier to split this into two patches.
BTW, it seems another approach would be to club all mptcp helpers
in one patch (may be the first patch in the series) as prep and then
use those helpers in the subsequent patches.

Thanks,
--Nilay





