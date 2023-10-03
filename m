Return-Path: <netdev+bounces-37802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB47B73E9
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 36DFE1F21587
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD223E462;
	Tue,  3 Oct 2023 22:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDA3CCF5
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:06:01 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9194CC
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:05:55 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393LmxCF001744;
	Tue, 3 Oct 2023 22:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=swHC/CW7eH0CHwVtR59dgULcmvMPOlcMu37WGGUgSqc=;
 b=j+wmGYEJyTul6WpEXJ129r6DYezdIUmZVeMcUmeXVMyzY1FhDl5/75ikyzJo6dRR3P6m
 qEH54Ww+qwuEVHbvAVO5dxYqKLrd4Ffw9z3f6u0aaVU4FFZej1/Ypfh3tbsKuIRGrYiM
 Wp+Y4V8BInOnIkulByvIW/Vj4g8yM2v5AFxgE4JVTMZhbJn39SDMhbGV4iQQASi6ifex
 UwZLJxIe8mhsc1iIQXDBu6/KkWQtCN6nIi2srTYli6f5j6BABwVHpVYL8Qb5t3lvPCrb
 2qMSw1Xt+PZr/e67upeb/tW/ow+4f5/gA3a/jSU/7wPHp0Xc0a06TGH8AMIs0tKgIHNL aQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgu70gf3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 22:05:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 393L4ruj025205;
	Tue, 3 Oct 2023 22:05:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcy6bg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 22:05:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 393M5qKD5636734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Oct 2023 22:05:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 927FE58052;
	Tue,  3 Oct 2023 22:05:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381CA58065;
	Tue,  3 Oct 2023 22:05:51 +0000 (GMT)
Received: from [9.67.160.196] (unknown [9.67.160.196])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Oct 2023 22:05:50 +0000 (GMT)
Message-ID: <09dbfd72-0efb-0275-9589-6178c9aca8a1@linux.vnet.ibm.com>
Date: Tue, 3 Oct 2023 17:05:51 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] net/tg3: fix race condition in tg3_reset_task_cancel()
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, drc@linux.vnet.ibm.com, pavan.chebbi@broadcom.com,
        Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
 <CACKFLinpJgLvYAg+nALVb6RpddXXzXSoXbRAq+nddZvwf5+f3Q@mail.gmail.com>
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Content-Language: en-US
In-Reply-To: <CACKFLinpJgLvYAg+nALVb6RpddXXzXSoXbRAq+nddZvwf5+f3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klGU1R7L2aVImWXGgJj07174plL5atU9
X-Proofpoint-ORIG-GUID: klGU1R7L2aVImWXGgJj07174plL5atU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=608 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030167
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the review.

On 10/3/2023 4:37 AM, Michael Chan wrote:

> 
> tg3_flag_set() calls set_bit() which is atomic.  The same is true for
> tg3_flag_clear().  Maybe we just need some smp_mb__after_atomic() or
> similar memory barriers.
> 

I did not see it being used in this driver. I'll try that.

Thinh Tran


