Return-Path: <netdev+bounces-16794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3274EB7B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773D0281213
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB1182B1;
	Tue, 11 Jul 2023 10:08:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5737182AF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:08:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932639E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:08:30 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B9xuNc019009
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=sMbnsRrPDBfNIlKxcT4/DAxF9Vuy/N30ZHTRcME+mwU=;
 b=F4FEiPaRZ8X2bld1TpsMRqLOzmiNZwIelougqHqlvoPPGqsXw/agAwRceXa0piO1+/mN
 OYvvxerBRUIYTr1qWZtC/WbLOnCc/JPdaO4Y5Z6TUfCr2Sv8umPTnxezdlA78FLkHV9D
 oybCjmS6LtUUOlFZP2YOWLecY+cMy7EDFTtJapg1zYLN0UTavVRxuCSGnCQbh6vKWUMy
 m8mQ4X/ot3s3xvqH3EeZ5ewFCjn0AssiTIo8mDeSNclSSG+nd0rBc+f2TKsfgmiO4kEK
 V/r3bwwWjiYs/G8nKKsOUSjJ05Fu4ojCqtkvB/vPahkLgW5Yt+P9A/mLELQLT4FnVIZW 5g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1e40f5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:08:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BA8TNv024725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:08:29 GMT
Received: from [10.201.207.19] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 03:08:28 -0700
Message-ID: <a06afc03-41fb-63b0-7ad9-71e8df6294c7@quicinc.com>
Date: Tue, 11 Jul 2023 15:38:25 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: <netdev@vger.kernel.org>
From: Harish Rachakonda <quic_rachakon@quicinc.com>
Subject: subscribe netdev
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vSoOHJQsCp09S2Y60sBAwqNZM6b1FRPB
X-Proofpoint-ORIG-GUID: vSoOHJQsCp09S2Y60sBAwqNZM6b1FRPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 mlxlogscore=259 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

subscribe netdev


