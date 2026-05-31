Return-Path: <netdev+bounces-293435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE0xAF9LHGqqMAkAu9opvQ
	(envelope-from <netdev+bounces-293435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:53:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D5616BAB
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CD9B300D72A
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73ED38E8B1;
	Sun, 31 May 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LuJVW/9x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A91BD9D0;
	Sun, 31 May 2026 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239115; cv=none; b=jDDbYpGcwGE9OZDEG9WEJSFbQQNODr+ahXvNsqrnGPEpP4DLCYXvpc4lUzaE/teuctZAYq/GG0D1vPKEg5VFm0dT3jtVXueA9fFJbx3x8DfF2ck2dVot0NR4HJh5fmhj0zJljmlaWGgsS1fmTuiX6pCaiw6a31SiRuuWdARzwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239115; c=relaxed/simple;
	bh=nADtvSbxwkyG7uIPKZjvw90LakZ8dSHmT0hvP+smpEo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fWU9lg4CQvQep0j/C1NaA4k0G9hHTheRmvgybvdR+BhH97yPek753vxyKum0HmjRsgMjp9rGcnqtxVL+ds5AFEVWJ/HOu/ldnKnQw53sWNjRpyzqhs6iH3gtL3MRP3AGt5A5KrlplrdCOTyQznaaLBfhMnd0oNYK8DYdmF2lJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LuJVW/9x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UDF20D3018752;
	Sun, 31 May 2026 14:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fq46AE
	+7jPfzsRmfmu+1wmuHUKMsVipvb8JZsj0osfg=; b=LuJVW/9x9IrnXfmogmPk8S
	/AHS90wSPXxY/aNwduo3ui+Uh4dYK8B5exlXi+2ziPww5H0ahiJDvzzeyCNvVmtx
	y5GmgWiZNRqRGz1X8+DDi0gO+q3KbYNRULyiLORemiIyv1dtps0ky5lY8eHBrqUw
	po4OynEOa22+B5YKNyijR1a4MC6UawspumrSWYCel2ffw1uEfx8fWTSDl54QH6KC
	IVQ++z/xl0qcO/ibTaN0y7cq10JlTb+XfeIbT1KDwEBHjwboU72A96S2cXGzLYRk
	SvOBFc2Ssyr/WDrEb5Pfd4aMOYgd1aBMh4FjWNxAfviCi2/NIeWC58RS4/9Wfzpw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4mv31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 14:51:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VEda0L013909;
	Sun, 31 May 2026 14:51:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvj6jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 14:51:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VEp2ac18416368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 14:51:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C308F58055;
	Sun, 31 May 2026 14:51:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78EE75804B;
	Sun, 31 May 2026 14:50:53 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 14:50:53 +0000 (GMT)
Message-ID: <872e80e9-ab11-461c-8b4b-630a8bd03bbc@linux.ibm.com>
Date: Sun, 31 May 2026 20:20:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] selftests: mptcp: nvme: add iopolicy tests
From: Nilay Shroff <nilay@linux.ibm.com>
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
 <51f054a6a573b9a771ed927eef34fa5ca083d009.1779934709.git.tanggeliang@kylinos.cn>
 <d23bcec0-70e6-484b-8c41-0174d1b5d09d@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d23bcec0-70e6-484b-8c41-0174d1b5d09d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4uqHCHqil5OAiqmp-ZRdaOjvwooT4hu_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE1OSBTYWx0ZWRfX8LHa1n/vgrlu
 sriiZA4R/ctkA96fiKdKFM+qkvQ5XE+DbJwGa1z+8vygJ5X1eU+ANLxvFV+ovPs+jA8rxOnPsZO
 G496Z0bAHys7w/Fk18K5y94R/7BWbW9ApMwfIAj49DzaD82Pxk9B3+qqpW9TrpyW18N5MoPDFyx
 4eV9v9Y3FS2aq5bJETxWyHT5f1ojRcXEP9N9oqa/b6ciA3pys+RPMXbwLglXd3OU/0E3D/DI6Wh
 Aavo9mQYQ2SDNaPa8EfkhbzeJH3SXFi4KZkgy/2QQD00fCsiEkGE2xA7bYJWBwuSrILRCY3BNAY
 Sk4S05NoXNdI+N80oFwKCCUdshjyVt6XJGj3NF/Y+L4fG8iN0Z4yMj/HFQVqSlynMsz8prulc5K
 TsfF7mPNhy/gwf7cx83OvA63q24Le8Y/+b/Yo1tss1pUwpI+jm03LnSDvzTyVOy9xmgVvoY1TwW
 x+dHcOIQyGjmqe9N+Hw==
X-Proofpoint-ORIG-GUID: L_Klrh7BPvFMaGqu_uBtkcXYqxRL0wZx
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c4ad9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=tG9-xVZLEdW8CX7s4vEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310159
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-293435-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6F7D5616BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/31/26 7:34 PM, Nilay Shroff wrote:
> On 5/28/26 8:40 AM, Geliang Tang wrote:
>> From: Geliang Tang<tanggeliang@kylinos.cn>
>>
>> Add NVMe iopolicy testing to mptcp_nvme.sh, with the default set to
>> "numa". It can be set to "round-robin" or "queue-depth".
>>
>> Test results with 4 NVMe multipath paths and round-robin iopolicy show
>> that TCP and MPTCP achieve similar bandwidth:
>>
>>   # ./mptcp_nvme.sh tcp 4 round-robin
>>     READ: bw=455MiB/s (478MB/s), 455MiB/s-455MiB/s (478MB/s-478MB/s),
>>         io=4665MiB (4891MB), run=10242-10242msec
>>    WRITE: bw=455MiB/s (477MB/s), 455MiB/s-455MiB/s (477MB/s-477MB/s),
>>         io=4633MiB (4858MB), run=10184-10184msec
>>
>>   # ./mptcp_nvme.sh mptcp 4 round-robin
>>     READ: bw=445MiB/s (466MB/s), 445MiB/s-445MiB/s (466MB/s-466MB/s),
>>         io=4575MiB (4797MB), run=10287-10287msec
>>    WRITE: bw=445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
>>         io=4572MiB (4794MB), run=10267-10267msec
>>
>> A "loss" argument is added to simulate network packet loss. When loss=1,
>> each veth interface is configured with "delay 5ms loss 0.5%" using tc
>> qdisc. Under this scenario, TCP performance is reduced by multiples
>> compared to MPTCP:
>>
>>   # ./mptcp_nvme.sh tcp 4 round-robin 1
>>     READ: bw=144MiB/s (151MB/s), 144MiB/s-144MiB/s (151MB/s-151MB/s),
>>         io=1909MiB (2001MB), run=13231-13231msec
>>    WRITE: bw=100.0MiB/s (105MB/s), 100.0MiB/s-100.0MiB/s (105MB/s-105MB/s),
>>         io=1397MiB (1465MB), run=13980-13980msec
>>
>>   # ./mptcp_nvme.sh mptcp 4 round-robin 1
>>     READ: bw=428MiB/s (449MB/s), 428MiB/s-428MiB/s (449MB/s-449MB/s),
>>         io=4524MiB (4743MB), run=10564-10564msec
>>    WRITE: bw=431MiB/s (452MB/s), 431MiB/s-431MiB/s (452MB/s-452MB/s),
>>         io=4513MiB (4732MB), run=10481-10481msec
>>
>> These results demonstrate that MPTCP has better resilience against
>> packet loss compared to TCP, as it can leverage multiple subflows to
>> mitigate network degradation.
> 
> There are a few observations I'd like to raise:
> 
> 1. It is difficult to reason about the throughput results when NVMe native
>     multipath is enabled together with MPTCP. In this topology, four NVMe paths
>     are created and the round-robin I/O policy is configured. As a result, each
>     I/O first goes through the NVMe multipath scheduler, which selects a path,
>     and is then further subjected to the MPTCP scheduler, which selects a TCP
>     subflow. This means there are two independent schedulers influencing I/O
>     placement, making it difficult to attribute the observed throughput
>     improvements to either NVMe multipath or MPTCP.
> 
>     For throughput comparisons, it may be more meaningful to disable NVMe native
>     multipath (e.g., modprobe nvme_core multipath=n) when testing MPTCP. This would
>     ensure that all I/O is sent through a single NVMe/TCP path while allowing MPTCP
>     alone to distribute traffic across available subflows. Such a setup would
>     provide a clearer comparison between TCP and MPTCP.
> 
> 2. The current test uses only a 128 KiB I/O size. It would be useful to include
>     additional I/O sizes as well, such as 4 KiB, 8 KiB, and 32 KiB, since MPTCP and
>     NVMe multipath may behave differently under different workload characteristics.
> 
> 3. The fio runtime is only 10 seconds, which is relatively short for performance
>     evaluation. The results may be influenced by startup transients and may not
>     accurately reflect steady-state behavior. It would be preferable to run the tests
>     for a longer duration, for example 120 seconds, to obtain more stable measurements.
> 
> 4. The tests are run on the same host by setting up veth interfaces and running
>     host and target under different network namespaces. It'd be useful if you could
>     run this tests between real host and target systems.
> 
One more point forgot to add:
Current tests uses symmetric path characteristics (i.e. all paths experiences
same loos or ratelimit). However it'd be useful to simulate a scenario where
paths exhibit asymmetric behavior (for instance, one path experiences loss
or increased latency compared to other). This would demonstrate the real world
network failures and it'd be interesting to see how mptcp performs compared to
native NVMe multiapth.

Thanks,
--Nilay


