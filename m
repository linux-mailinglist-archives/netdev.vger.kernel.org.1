Return-Path: <netdev+bounces-24429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223077702B5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29202826BB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D358CA50;
	Fri,  4 Aug 2023 14:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB4CA43
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:12:34 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6589246B3
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:12:28 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EBxXf014779;
	Fri, 4 Aug 2023 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ez+zCuiHg5ftrugUaoIDs0IXwuyEnO46UjQFIJP4lfU=;
 b=hZMNmk7e6RpC6nSk50qiPgL4pToLE7vE7kwZjZWQGvPQCBP2g4CMqksPu0LeuHoYl9pj
 CvgiM0PsG7QSDbcjV3zA2HVa9h8FtdstuXPnZJonZ/UI/Avh0m4fa3Dk4N92Zx8AZBS5
 Tjq5MfsrLMUAIIhrdNIRSdll9LYlZCgaBXtJMrgW0fON5+yCeMT3kT2hCH2OoSxzyg3T
 MbkPFGLtRbT+LxPvKLm8FCKMEQHkR3aYT0WvLQZk7LNaUBvrhNyEevdWPMiFfCXFB3ir
 +Pvb8wxFlv83pfgRhj9JyGyGFvZ1dnUSYTErL2rJpXyJoInmftVyNotn41c2yLrPMBjj gQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s92rk8fu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 14:12:04 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374E8Hkv021689;
	Fri, 4 Aug 2023 14:11:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kmce7ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Aug 2023 14:11:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374EBhXQ36504220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Aug 2023 14:11:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EAE65805E;
	Fri,  4 Aug 2023 14:11:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80DA5805A;
	Fri,  4 Aug 2023 14:11:42 +0000 (GMT)
Received: from [9.61.119.132] (unknown [9.61.119.132])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Aug 2023 14:11:42 +0000 (GMT)
Message-ID: <6cf04916-8e55-42f1-bf07-3dc80c8408a4@linux.ibm.com>
Date: Fri, 4 Aug 2023 09:11:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ibmvnic: remove unused rc variable
To: Yu Liao <liaoyu15@huawei.com>, netdev@vger.kernel.org
Cc: liwei391@huawei.com, davem@davemloft.net
References: <20230804092143.1356733-1-liaoyu15@huawei.com>
Content-Language: en-US
From: Nick Child <nnac123@linux.ibm.com>
In-Reply-To: <20230804092143.1356733-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fc6XuKxz9OCxWLV2LWpACfleAew4oC8w
X-Proofpoint-ORIG-GUID: Fc6XuKxz9OCxWLV2LWpACfleAew4oC8w
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=661 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

LGTM thanks!

On 8/4/23 04:21, Yu Liao wrote:
> gcc with W=1 reports
> drivers/net/ethernet/ibm/ibmvnic.c:194:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
>                                              ^
> This variable is not used so remove it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308040609.zQsSXWXI-lkp@intel.com/
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Reviewed-by: Nick Child <nnac123@linux.ibm.com>

