Return-Path: <netdev+bounces-260581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HXhD9zMnWnfSAQAu9opvQ
	(envelope-from <netdev+bounces-260581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:07:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A911898D7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76902306C123
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A923A7826;
	Tue, 24 Feb 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMNT2RV2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE563A782B;
	Tue, 24 Feb 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949273; cv=none; b=RwWQLt8ROIhuNWy3nZDAJA8iXBsV1IorrQJofZhf6w4PDP6QP8qdCrL7dFwp2J/ZIlzX7Kb34uXKLSX/g92kVpG24ZMhBTSVNqB4JH8YBRGMGsXdLqTGODZpcjF6uuQNp6A1DId5BdK++c/U7J7q4dsA7a3TlfyR5JpTQNGE0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949273; c=relaxed/simple;
	bh=H2gxLrvjhQO+awFZBVIGpkeWP5KCInTd/GEhUPzEe1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNJDsoKzQq1v9P/oZ1FX0NCDmld4iatDGv0v6QjrExhasDorEKU9sn/xYWM+5wjwmQguaD6jUjJznRV98RqmmKMaS5xmqbZUrayobMNdSDcAjBZRlEgm3PPqMrl67TWA0QgQmnVR+2nDkA2Nx+gh+lbb+jEtCud/rqlDWq20G/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CMNT2RV2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O91Fdx2495026;
	Tue, 24 Feb 2026 16:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y9+Qyvr3MRBE2N0qYbpHjPsw/T/XIt
	QtL6iJg7JvaX4=; b=CMNT2RV2Zv6Z5P0CB64avamBiHv9LfPoW05e+2hBYiEShK
	JofimA33XUmHGMpZJWHrCZOLaSGUCm9bt/GVwoOXxrBK56gM9IXysAnByVSX+NBM
	zPYage+3IUb+HCJfvM72qRYeszKggnTCUKD9YPpO+wTIgeSofLJHmBnjA6BNsimh
	kzNKNQkD4UnOlsZ0X5RFg0uUc8Qxk0ViSNvXkP7IqIiAJJ0ENobRKjoKSQW8tPMv
	i0J3gvdzZuZpza0HfCqdvdwJ+uf9/jj9Es+1Km4VmFt5TMZjVGxl2wGgNq5+Eexy
	VToZbct6n+6Dwmf9S/tfxv7kKIs7WOZLko2qWaUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c3shr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 16:07:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OCieCT002215;
	Tue, 24 Feb 2026 16:07:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n1h7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 16:07:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OG7XDU57475552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 16:07:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF1B358059;
	Tue, 24 Feb 2026 16:07:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CFC258053;
	Tue, 24 Feb 2026 16:07:33 +0000 (GMT)
Received: from d (unknown [9.41.102.181])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Feb 2026 16:07:32 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/ibmveth: fix comment typos in ibmveth.c
In-Reply-To: <20260224153601.17534-1-abhindeka@gmail.com> (Abhilekh Deka's
	message of "Tue, 24 Feb 2026 21:06:01 +0530")
References: <20260224153601.17534-1-abhindeka@gmail.com>
Date: Tue, 24 Feb 2026 10:07:32 -0600
Message-ID: <87v7fmyvjv.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDEyOSBTYWx0ZWRfX1kT/VFtPPv7f
 lCELi2+Geia9GPneRwaurVn+7j9FZOb8sDTdJjcDFlTti10+bJqlTnKyxcmI2E0EJQpxa1smxf4
 ZbvPjnnN8Q3/bm+KkGU7w4DGQIZqs7CTpFT58UFRrrw8WmW0TAr6e2W0BFKSpDDCQm5zK4Ey0X9
 q8HgWse7gSSFT8CyPdrit7y6Ygwzm1HSGmo6iqMIe8x3jADMlcGleyfc4Sl6ofdfO5UoKrRHQEY
 ssF2ZsYX2l0zV+WQhpr/YCnotvHy+jOfMc8xT5qe7JFSjrSMZzGn1UBfOkdGA9o3ubLKHn/pBUj
 1FRyT81KO6qw1mz/nWpBmdBKZNlEliM/TpNJ0FH3DM7wIcD8BVYeZEdxO5jxEz4qpHKjcK185M3
 4DCTpEhYh8sp0EJ5KipUm24pLwGZWxD6ts3Ynmmj2pdV2sUvqTvIlCwCUtpTvh70kZCwPvecwCY
 kJcXsEhcgfuMfRp0xTA==
X-Proofpoint-ORIG-GUID: EmJTXNl2OWZQe0kPcioqbjhCBuHrjs1A
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699dccc8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=ipUitfybjZBOWcLre3UA:9
X-Proofpoint-GUID: Sl8BzQk4AMyS-9oqVHPk4Bcf7fHbesLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260581-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davemarq@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B6A911898D7
X-Rspamd-Action: no action

Abhilekh Deka <abhindeka@gmail.com> writes:

> Correct spelling mistakes in comments:
> - Fix misspelling of gro_receive
> - Fix misspelling of Partition
>
> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 3108bf50576f..b2a578e6ff31 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -355,7 +355,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>  
>  		/*
>  		 * If multi rx buffers hcall is no longer supported by FW
> -		 * e.g. in the case of Live Parttion Migration
> +		 * e.g. in the case of Live Partition Migration
>  		 */
>  		if (batch > 1 && lpar_rc == H_FUNCTION) {
>  			/*
> @@ -480,7 +480,7 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>  	 */
>  	if (!reuse) {
>  		/* remove the skb pointer to mark free. actual freeing is done
> -		 * by upper level networking after gro_recieve
> +		 * by upper level networking after gro_receive
>  		 */
>  		adapter->rx_buff_pool[pool].skbuff[index] = NULL;

I'm not quite sure why this was a v3 of this patch, but anyway.

Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

