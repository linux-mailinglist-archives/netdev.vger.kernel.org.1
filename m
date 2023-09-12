Return-Path: <netdev+bounces-33379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5C79DA3B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D997281E22
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A209EAD49;
	Tue, 12 Sep 2023 20:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965779470
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 20:48:23 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5108E64
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:48:22 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKcZjP012289;
	Tue, 12 Sep 2023 20:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oOSKy2fXEKU4kke+jvAtbOQZHSrsPXPADKhFi8+T9dU=;
 b=TGymTd1uDwUMxJEqfI4YHsHCNkHsAV7VVKBPKaHSnPB/sU+1DkWZhTksZnmR8ChH8wVx
 WN+AU6akFkCGEXSAVNi6uzOs034MxMndMXeOam6DHZqqLKizFCVWwHO1vAlwjbqzcBAr
 Qm169hnWHclxKfa/7ZYKTVHtKc0LpoCLhUxETDr7wSLY7gGoKd4usxmIgWJ4BFl/jO1y
 KFovB98w/ZOrtRSIrpP5H4+uxpIL1jirQhb2Icv2+B+9UVJlImQpNkEac5HkJ8zHZ8Cy
 bSQqqHMD0YPineJVcv+qAE0MPIOElATYllTNAnpxOZcvWU3O52T0wo9L5AfokRoX8lp8 Xw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2x2j25b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 20:48:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CJegF8024080;
	Tue, 12 Sep 2023 20:48:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131t6f79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 20:48:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CKmGGE5964484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Sep 2023 20:48:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76A0458059;
	Tue, 12 Sep 2023 20:48:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1644158055;
	Tue, 12 Sep 2023 20:48:16 +0000 (GMT)
Received: from [9.61.27.31] (unknown [9.61.27.31])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 Sep 2023 20:48:15 +0000 (GMT)
Message-ID: <331b81ab-7a19-0055-088f-d2f595c26303@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2023 13:48:15 -0700
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
To: Jacob Keller <jacob.e.keller@intel.com>, shannon.nelson@amd.com,
        brett.creeley@amd.com, drivers@pensando.io
Cc: netdev@vger.kernel.org
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
 <943d2f39-b933-b77e-fb18-4c695c1c4bf8@intel.com>
From: David Christensen <drc@linux.vnet.ibm.com>
In-Reply-To: <943d2f39-b933-b77e-fb18-4c695c1c4bf8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CviwL6cztTYgKMeZd1KcyFUGGO5s1d_u
X-Proofpoint-ORIG-GUID: CviwL6cztTYgKMeZd1KcyFUGGO5s1d_u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120174



On 9/11/23 5:14 PM, Jacob Keller wrote:
> 
> 
> On 9/11/2023 3:22 PM, David Christensen wrote:
>> The function ionic_rx_fill() uses 16bit math when calculating the
>> the number of pages required for an RX descriptor given an interface
>> MTU setting. If the system PAGE_SIZE >= 64KB, the frag_len and
>> remain_len values will always be 0, causing unnecessary scatter-
>> gather elements to be assigned to the RX descriptor, up to the
>> maximum number of scatter-gather elements per descriptor.
>>
>> A similar change in ionic_rx_frags() is implemented for symmetry,
>> but has not been observed as an issue since scatter-gather
>> elements are not necessary for such larger page sizes.
>>
>> Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
>> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
>> ---
> 
> Given this is a bug fix, it should probably have a subject of [PATCH
> net] or [net] to indicate its targeting the net tree.

Will resend v2 with updated Subject line.

> 
> I'm not sure I follow the logic for frag_len and remain_len always being
> zero, since typecasting unsigned values truncates the higher bytes
> (technically its guaranteed by the standard to result in the smallest
> value congruent modulo 2^16 for a 16bit typecast), so if page_offset was
> non-zero then the resulting with the typecast should be as well.. but
> either way its definitely not going to work as desired.

Sorry, tried condensing the explanation too much. I'm not sure how 
frequently buf_info->page_offset is non-zero, but when 
ionic_rx_page_alloc() allocates a new page, as happens during initial 
driver load, it explicitly sets buf_info->page_offset to 0.  As a 
result, the remain_len value never decreases from the original frame 
size (e.g. 1522) while frag_len is always calculated as 0 ((min_t(u16, 
0x5F2, (0x1_0000 - 0) -> 0).

I'll update the the description in v2.

Dave

