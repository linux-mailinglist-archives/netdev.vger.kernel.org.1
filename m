Return-Path: <netdev+bounces-293437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLbtHZ1NHGrpMAkAu9opvQ
	(envelope-from <netdev+bounces-293437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:02:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFA616C02
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FEF43010142
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E1390985;
	Sun, 31 May 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YcKQzaBt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEC939023B;
	Sun, 31 May 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239766; cv=none; b=GvnDSFKERYa4+po+Q6+6yT7RYwXr8FPdHfCGJGzu9sLDSBtfSsiEFNJw7AKCZRGVDJmy52io+gpo+TLirxSxKDAWT0c6oqhdKoo2EXImWIDXxhwdyRLcuRLc5K50MgY1V/u3KPUAlQnyWjquoGX6m76pBJdYeGHXXb1/E6C7A+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239766; c=relaxed/simple;
	bh=rOp6Yx1W+JO1r8e6vKALcPvLAIBSMnpkQJy6wldjqUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4UCrWoCbadxttWcgOeuvMfpXkFt01zYXLlnsFxYPdppe+47+6tTNlf4VrdcuefYwRy0xVlAlUcjTRLyEh90AqXDEUEuiMTVypS72k1n3lifJ7EjJqp3NTLNjf3xLJvOASFZNBQZTEe+TVPVEZfC5lDevdAzfxvHbkn7qKP8CO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YcKQzaBt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V7NKKQ922540;
	Sun, 31 May 2026 15:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o4vQx0
	bV155pHWBIvJOUhbaD/1Mdd4XN5wjoNKa3mrQ=; b=YcKQzaBtJrG+EXnuvKmt8t
	83WUUPS04ns2lIQfmI2irZucZLFkUTyp+CNQdB5Jo1ypseGDog+CP2Q8Dp49gVK6
	VBxc/HxYL6zydbg+bUyK58lOxNuwLuRRPzGLmmHcUr9sg4sHHFzVPzYh3d2JRFkr
	iBmHz2iti043BeJ36jYglH23/aoW/bvTwdl0tycK+2bFgO9CE033JV4cIvNvzlNN
	bs12+HF55lRfgsFEqFBktn5GzqFdkuRR6EiooAsF5S6O0Bd0fXyDurVA+i4+E0GC
	CFxPA10qGljflruY6AvRH7bJuI+ms3BR+c5O4IbfTZ6N5E8QPmDvW0ApDCI/KGMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4mw4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:01:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VEs5TL027570;
	Sun, 31 May 2026 15:01:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jt3wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:01:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VF1cJ920906660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 15:01:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91DC158055;
	Sun, 31 May 2026 15:01:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 985975804B;
	Sun, 31 May 2026 15:01:29 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 15:01:29 +0000 (GMT)
Message-ID: <60f02eb4-0779-4948-9cdf-c3202c1845d3@linux.ibm.com>
Date: Sun, 31 May 2026 20:31:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] nvmet-tcp: implement mptcp listen socket ops
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
 <94d8286242b894e8bc9a9a3391c4d3db778f96c0.1779934709.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <94d8286242b894e8bc9a9a3391c4d3db778f96c0.1779934709.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: c8Ye7L-Aok1GhtIhOj6hof8odDneICrI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE1OSBTYWx0ZWRfX1DUpCQlYymqI
 DTEzlaASDrl251KE66amI/H2+4zYMmuGzFMQZLpWfZSr5POYELdB3Tc7fWnHkx+s3uVXSLcda1Y
 XOwKxdAUD5WDQ8b8im2wsM5CZHtzMZo7wpBvyOw1rkLC9o158VvJWs9NY76IGTS4InfYbgd2U1Z
 8oCr3oIT+ra9gruy5Lm8FQWeMxwtR29UrrzOaPjrm+X6Wrs1F0r9cld/NwOR0PzG2c+ZWVw/A5g
 vKK0DCS/Kbm8xFjNeZwVedF6WaqoGBLpQjUoAUeJLwsKawSGNKQCxj+GuMaNTqcGaaALXW3fKXp
 +BvNN4jR56w7P6yuWby8lxMK2V6iNihxlervOa+DIzQSiGasmGzjLvcBNAvdVbf0qBAtN5U2s2H
 ZhlNgoS1XxKsCxnIuP98wKaINhqVmv2pH9mPIQMjulPcllqcfIE+ema+8/oPAGgxMbAIpVT7hmX
 q8ElLU9XwkfHbPurffg==
X-Proofpoint-ORIG-GUID: izyVfQ-n9Gy4Sn2MaUchGig0_ZjOxhRS
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c4d55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=WTJdmG3rAAAA:8 a=VnNF1IyMAAAA:8 a=qRBToSlAEBA1CvdqRM0A:9 a=QEXdDO2ut3YA:10
 a=q3NGepEMMmKWaCv8Sx90:22
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-293437-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.ibm.com:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,purestorage.com:email,suse.de:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilay@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1ADFA616C02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 8:40 AM, Geliang Tang wrote:
> From: Geliang Tang<tanggeliang@kylinos.cn>
> 
> An MPTCP-specific version of struct nvmet_tcp_proto_ops is implemented
> for listen sockets. It is assigned to port->proto_ops when the transport
> type is MPTCP.
> 
> Dedicated MPTCP helpers are introduced for setting listen socket options.
> The set_nodelay and set_priority helpers set the values on all existing
> subflows using mptcp_for_each_subflow(). The set_reuseaddr helper only
> applies to the first subflow. The values are then synchronized to other
> newly created subflows in sync_socket_options().
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
>   drivers/nvme/target/tcp.c | 13 ++++++++++++
>   include/net/mptcp.h       |  8 ++++++++
>   net/mptcp/sockopt.c       | 42 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+)

Again same comment as earlier, split this into two patches.
One patch for net/ implementation where we define and export
mptcp helpers and another patch specific to nvme/ implementation
which consume those helpers.

Thanks,
--Nilay

