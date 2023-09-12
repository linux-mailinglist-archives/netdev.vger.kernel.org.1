Return-Path: <netdev+bounces-33399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A477B79DBEB
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093751C21046
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C9A928;
	Tue, 12 Sep 2023 22:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F333D2
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:35:59 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1B10EB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:35:58 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMZuOO012642;
	Tue, 12 Sep 2023 22:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=new/IQaHyzUJ5mbgAi1ELQnpQf++VPnkQVgikm0wU0k=;
 b=o/JhNQTvaliEH1Hna5IPQ433MY/C5DXJ/YdSq9fnNrQOiOOpwxFeiPqYLcwaLUyW7rlY
 lxs57wPEZfsY5C119B4ZKcPcSs/CFyYmpJWvpX/qkm6DYoJ8OmqBD/DNRxrgRB8MoSv4
 koOyzWSiLWaySKHesvPo2xc1FJVIfdcbgYl59L+TqXsITiUdcfZWPfqX1tSSTHWJt5Rm
 3tDxfk9dvOWsjUSHUb9DQSfrUmjtn9CEFb4vmP6Y0ZgPFXLfmga2+3oV2/FDSmYtyMAc
 zJXa4PXZnBkWkT41VGE9DpcVjaP95nd1JQITefJTioTZ5/vqx6A0KGn05U9g8cZFi0Tk Jg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t304xh040-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 22:35:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMF5MM011974;
	Tue, 12 Sep 2023 22:31:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1x1xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 22:31:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CMVWvY6423294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Sep 2023 22:31:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16CF65805D;
	Tue, 12 Sep 2023 22:31:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F1F58043;
	Tue, 12 Sep 2023 22:31:31 +0000 (GMT)
Received: from [9.61.27.31] (unknown [9.61.27.31])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 Sep 2023 22:31:31 +0000 (GMT)
Message-ID: <df083cc4-e903-f122-0817-b1313397e89f@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2023 15:31:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
Content-Language: en-US
To: "Nelson, Shannon" <shannon.nelson@amd.com>, brett.creeley@amd.com,
        drivers@pensando.io
Cc: netdev@vger.kernel.org
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
 <a7c39c89-c277-4b5f-92c0-690e31c769b5@amd.com>
From: David Christensen <drc@linux.vnet.ibm.com>
In-Reply-To: <a7c39c89-c277-4b5f-92c0-690e31c769b5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zyXLzvOJdEvtlNW2Qd5-ZRxvWgWYNRWO
X-Proofpoint-ORIG-GUID: zyXLzvOJdEvtlNW2Qd5-ZRxvWgWYNRWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_22,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120192



On 9/11/23 5:24 PM, Nelson, Shannon wrote:

>> @@ -452,7 +452,7 @@ void ionic_rx_fill(struct ionic_queue *q)
>>
>>                  /* fill main descriptor - buf[0] */
>>                  desc->addr = cpu_to_le64(buf_info->dma_addr + 
>> buf_info->page_offset);
>> -               frag_len = min_t(u16, len, IONIC_PAGE_SIZE - 
>> buf_info->page_offset);
>> +               frag_len = min_t(u32, len, IONIC_PAGE_SIZE - 
>> buf_info->page_offset);
>>                  desc->len = cpu_to_le16(frag_len);
> 
> Hmm... using cpu_to_le16() on a 32-bit value looks suspect - it might 
> get forced to 16-bit, but looks funky, and might not be as successful in 
> a BigEndian environment.
> 
> Since the descriptor and sg_elem length fields are limited to 16-bit, 
> there might need to have something that assures that the resulting 
> lengths are never bigger than 64k - 1.
> 

What do you think about this:

  frag_len = min_t(u16, len, min_t(u32, 0xFFFF, IONIC_PAGE_SIZE - 
buf_info->page_offset));

Can you think of a test case where buf_info->page_offset will be 
non-zero that I can test locally?

Dave

