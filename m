Return-Path: <netdev+bounces-44222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C47D7240
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491E0281CCE
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408630CF8;
	Wed, 25 Oct 2023 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QcTD+V78"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E432AB2B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 17:25:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA813A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:25:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PFheFd006979;
	Wed, 25 Oct 2023 17:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GzrZae56WJEID7zzHKBAA4hMdKclOlQs66hq7oenuc8=;
 b=QcTD+V787AWZKvFAXG+EsbRZGum0TFtfV+S5Jx4fuHMJas8/5Q+mzu864HdFsnHZvO0A
 DT3+yNa6Q6Kel4DZlXLjKO1bI7Kv2YYoDkQojLofSOAzOKPSDoW6cmgdY3HtDcJhDPri
 itJYmk/1lj92bApi5lwiOgfAZJk0J42GZ5dmK/8GwHSsD6YCL1eReC/6O4Ez0UEvwNH1
 wHtOI/8HSPytYBhhMDyFArk5ojT+Wzv0zxcnCkx0bhS2Zwth3R42+7y8pEos3S9QTNBR
 EuvHNzxPH+KFqxf9GIYtgvGbmCL7XQwH6qSEN1DuMycTu3Bw/ENi0ZWLpHo88PErvcYx 4A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ty5wdr9dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Oct 2023 17:25:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PHPG2x006752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Oct 2023 17:25:16 GMT
Received: from [10.216.19.58] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 25 Oct
 2023 10:25:13 -0700
Message-ID: <08937fb2-b77e-4103-9980-5e8058a5bc4e@quicinc.com>
Date: Wed, 25 Oct 2023 22:55:09 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: vmalloc-out-of-bounds in ipt_do_table
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
CC: <mark.tomlinson@alliedtelesis.co.nz>, <pablo@netfilter.org>,
        <netdev@vger.kernel.org>, <quic_sharathv@quicinc.com>,
        <quic_subashab@quicinc.com>
References: <7ce196a5-9477-41df-b0fa-c208021a35ba@quicinc.com>
 <20231023112008.GB31012@breakpoint.cc>
From: Kaustubh Pandey <quic_kapandey@quicinc.com>
In-Reply-To: <20231023112008.GB31012@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R59wwINImJ8Q9bcQ2KnyIUiw3_u7RPN8
X-Proofpoint-ORIG-GUID: R59wwINImJ8Q9bcQ2KnyIUiw3_u7RPN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=709 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310250152

On 10/23/2023 4:50 PM, Florian Westphal wrote:
> Kaustubh Pandey <quic_kapandey@quicinc.com> wrote:
>> Hi Everyone,
>>
>> We have observed below issue on v5.15 kernel
>>
>> [83180.055298]
>> ==================================================================
>> [83180.055376] BUG: KASAN: vmalloc-out-of-bounds in ipt_do_table+0x43c/0xaf4
> 
> Whats this?  See scripts/faddr2line

Unfortunately, I am unable to run faddr2line as this is on one of our customer builds.
I will have the fix tried out which was shared by Pablo and revert back with results. 

Thanks,
Kaustubh

