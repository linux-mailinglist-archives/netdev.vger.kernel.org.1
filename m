Return-Path: <netdev+bounces-35886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219E77AB79C
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D2806282450
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3584368C;
	Fri, 22 Sep 2023 17:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C142C1F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:33:06 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDC1988
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxFY4JgiovmRpTeODJBzrhxp+WghqOu7idw/3K3C7Ni92H3xVtazI6zroV1vrt0W8xHA5NHze8Y7GTPPHW1hDHPJOw4KcJTPOtEdjNcG3jHGopagBWUQET4QS+E7Tx9qvrNHXmu9TuoQV/8BBZAkHmaucyIMvnMAJX7qsKCkeW2Chl4BLd6fOQHe3icS+gpa1ZEi9HyljfuXATyy2mTY37P7SYabO1KidY3cJFqJqZb8+ru1OnAwVFubk5Xl6N0RVbzcuedhhwOTuMMH+B+vJCTyUfaTl7YqHHcSg1uKF+jv33uYjc2xDiRmtvfVpWIawi/GABdmUacK3mbqaQmJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PUuNi0qzwDSyTUhfPdD/sQqTox3BkHffR3fNTgq7ns=;
 b=YI7ZyakxFATF1yL1YpS9FfVq3gm5ZrTJF04H/R8OLazPbUV1SKOEDLDsVF6OwFiOS4Q0cjeFWNmBfbMLvRp/sIoPZRS3pZv2adJfYSvSQroWPNPqCFlRwdE4HcAD3Jk4K0m2zY550Z4YgpAmzvLyD8TJ+JKcEsOUU+Z2beudp2Vrnrdo4kfvnAicfXl/zw13oQ4WMB5tn5y2h66x6CJklf3Dtk4IWRJ2nq00x9HngrYS80aBtKdA6KIsozAQnAFbUS09l/0L7Y6+ZUBezMb6/F9yD9YF3tWPHIfkPBHig3cXhKvOE6GU4fsretKxQIwvy3/wP/MI34IR/V3SnziyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polimi.it; dmarc=pass action=none header.from=polimi.it;
 dkim=pass header.d=polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PUuNi0qzwDSyTUhfPdD/sQqTox3BkHffR3fNTgq7ns=;
 b=14x+bdgmI6Al6JRHXj/Gzi39JdQbdTUZZLuDdjQd31qGdNPmLVEnIHJm2flMa1sk8O4qvGXHUcAXILHY51tPdr4Zlrzz6dElvtKbIc4x5uNb/K7xX/s+ruTXRIp5CSNkpm7tLoWmwothR+6EmqbG9LLl2YMs1mCxNtqRVJCT0ok7HSlq/MxU+EMlSOUe4vuHyndahLAJEqTBnnkM+ABkiYrWfbC9eCge0PTZwPQBEUyJ6PxmhEx/j2opfGuxByhGsuuv+741NzVHk+z5xzZVuAM4fAiQ5ZIUC+3lSkadEClpyS2tcNghcHmnhQjzQMVfcT2lFXJIi20bIuGmSqitJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polimi.it;
Received: from DB9P251MB0389.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2ce::14)
 by GV1P251MB0745.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:32:59 +0000
Received: from DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 ([fe80::3840:de50:5c8b:d14]) by DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 ([fe80::3840:de50:5c8b:d14%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:32:59 +0000
Message-ID: <be02a7af-5a00-fef7-2132-0199fad6ba7a@polimi.it>
Date: Fri, 22 Sep 2023 19:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: john.fastabend@gmail.com, netdev@vger.kernel.org
From: Farbod Shahinfar <farbod.shahinfar@polimi.it>
Subject: question about BPF sk_skb_stream_verdict redirect and poll/epoll
 events
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF000013D6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::e) To DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2ce::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P251MB0389:EE_|GV1P251MB0745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee86482-a552-475a-a076-08dbbb91f6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	75/8LjK7ttNokCItzDkakRZGxoru8tW4CX0LoNEBRQ4aDdfjAfpiYWk8rAzMnkfFNQu92ZU2XKY3nav62CHxtKAxb93mljTQUFxBHcQgG319v83M9V4Vm4oPupcYP0S0oWm6Z7kcTYEUbLJ2ELjxTWGrBerPJrMMBCzMu1P3wjIRxoda3mBcd0defUrDbBsSdoWrJpLcUZYdDbnCmTCKxNY6vrxYSnUDPubjcrsqqmb6KZlN7O1ZVn0sCEDt7irIGIJbi1Y6qFkKOGsnUFd4Gun7wZGWNrJsSfoXFLYwYlumO1uhZWgWPZQp6WmH+xMuMTGtHozYyavxjpByvF5XzVY2B7/4Ayy2LU25ICmXPP+Ywq6dIsQKNJPTUL7vhuD46zyLPZbfTvB07Rf494/CmmsM5MmCyjmzfCmEDnWsGp+M4fjbM+aqT2x2I3H8lJrL7PIhHUT4V77VzBL7Sy/8xE0XRwoka+kJmTDWnANY6mq8FXbBOdFFhDRXdolnG0E67jBtoZBcsJ8KbKSMZdsMuJsS1RE1KEGrNvpZarQGovzJRdh9yyH8X3WaChcspZQjKVcXlsUBLVEXUCHH65eKn07vA63SDbzyunZ7ZK6hRDyTyuY9X7Z7Vz9hoQcRtRHmboD1L3Ec7Cb+llxMOFhNbQXGAHAnNih9g+0qTieGtaL9IsBqkP9peaPLnPmYBTp1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P251MB0389.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(8936002)(31696002)(8676002)(31686004)(4744005)(86362001)(44832011)(38100700002)(5660300002)(66946007)(66476007)(66556008)(786003)(36756003)(316002)(41300700001)(2906002)(83380400001)(478600001)(6512007)(26005)(2616005)(6506007)(6486002)(6666004)(43740500002)(45980500001)(554374003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDlaTDVRQkFNUG1PQjd6aGpHLy9KaHNlVDhQTU9FdzBCbjE2NkZiMVJDYlIr?=
 =?utf-8?B?QVorYVhJanFhZGliMGYwYXpoRjREUzlRWUdNMm9OK3RRRytPK0FVQnRPWGg4?=
 =?utf-8?B?Y215NjMzYVlPUCtsaVo3SWVTTXpkS2lnTEFDcG92bVFSeDZ0OFhxSUQ1NXh2?=
 =?utf-8?B?VVUxNTNTa1UrNWdJVFBsU2FibzRQa0FnUE41QlREWmowNDBzMVhDbHdOZ1pw?=
 =?utf-8?B?Q0R6V0J0cWdhWlJXbXZZYU1WeVBGbUlzaWtjYVN3YmkzbGh0WnZWek51ZzVr?=
 =?utf-8?B?ZXR0OXA1SGpkelRsak8yZitiUENHdjdjL1dqQk5mRUlSaW9GZ1k2VWhyeW9p?=
 =?utf-8?B?Q3QvUW8vSHA1TEIxSDJLdTFqaE9Wc3dUeHdMVmppQUV2bnVaYUZCeDFrdkdh?=
 =?utf-8?B?YUVzQVBKbDlRZ1pQTXN1QWh3dnFSYWFqNUx6K29saWRSdWFRODNPei9Vak5D?=
 =?utf-8?B?bkxEWVdKTkJGdGJhaENLQ0xsang5Q09sZmVoVDBhQldRcjUyZGh0M1FUbVR3?=
 =?utf-8?B?SjJRbkpWUEtxc3dRYWhrTU82dHE1b3NzWVZTa0luc0hjbHJoTmpDKzZVOFJ0?=
 =?utf-8?B?aEl2QkJjbXJPZ1F4UU9xZUJiZVhhaFVKYkUwRUxoQlVlOWJTUXM3dXhtVTln?=
 =?utf-8?B?ckhhUjNnSHI2TmprdzNPUFZ4ZEt4dDdjaXFacDQrTVFGQWIzSTZMcWdaYzFp?=
 =?utf-8?B?WGl3REhnek90Nkg3N0QyL3VlbStuYm1obDJDdG1ySklFMGtVeTBOQUZsV1Yw?=
 =?utf-8?B?Tm1lL0J3U0p4cXNpRXd4S0hQaHY4QS9Dak91VWRPRUhaSjhBWDNROGV2c1c3?=
 =?utf-8?B?a0F3cloya0NDVEdWSENWTXZWQmZTYW04NXA0aGpJUVFxVCt0SXJuQmpGcmYr?=
 =?utf-8?B?YVdtZHhvTUY1NldJMHduR1BtUUdkc2c2b0Y4cmtYK3FhcnM2RmJnZEJnb01z?=
 =?utf-8?B?TlRQY09YMFFmUlhBbGszUlZQWUxndkhIWmlabGNVZ29BRmlCckkyak12Mk5x?=
 =?utf-8?B?Sno0VVlzbjVxTzVOV096aGJBMm9YV2N0TmVVZXg4QjFDOXNST0xmdHVRNS8w?=
 =?utf-8?B?OStRZ1QvWDVISXJwVFAyWDZ3aEljWU92YXVLaWhRN20vTktjSUlTcEo5SWNU?=
 =?utf-8?B?cUZIN3p2bk5LbWJIREd6TGthclM4U05qaDg4dDc2Q1RqdXZxVVdwdzZ2azBG?=
 =?utf-8?B?d0luaWpjNHg4TWdpUGwxMHJmaVhXRWhFbGw1dktzSDI3WjRyanlxMTdnNG13?=
 =?utf-8?B?WVhqQzIydEpDSE5sbDJnVk9KUUhKTVpTNnd1VlNmVmtzRWJBSzNuNUhrdzdM?=
 =?utf-8?B?SFpQT2lvSExBNExrdC9TekhMUUVnVG1HZ2NxdDlmdzN0NzltTEZKRXFPdnh5?=
 =?utf-8?B?MjlhK2lhNHR5OFcvcFAvbkdvUUhqZkt3UTlnZkJaUjdKT0xwd3BpREFDUEZL?=
 =?utf-8?B?NjFuTWZuTjA2NzJ0azBnY0wvbC9PRFUxZ0RsUFBSZG1PeE9JSFBUZXJtSU93?=
 =?utf-8?B?UEJ0ZXllT1A3MjBnWnVnZ3FqTjVEc3lHcllWOHh5MllJTnpJU05TcGVON0M2?=
 =?utf-8?B?QmVxREZvelZCajIxZ2FHNGlJWDRCam1NdkZtcWx5aDlvUStFZnVhUkp6c2o5?=
 =?utf-8?B?OEgwRC9vWHpKUktXSE1rVDdNb0p5Y0x4Q1pqVXhiNmpob3BsRjN1d201OHRH?=
 =?utf-8?B?OXB4Q3VLdFMrSnpYOWRWblVBNWx3bkR3ME1zeUR2MkRLdDUzaE5Qb0VWY3BI?=
 =?utf-8?B?NU9DdkUwa0JSMkxmZUhaTm9Yb1VEQ1p0VFZuR3FrbC8xVjdMb0NubVRxRktu?=
 =?utf-8?B?RWxxZyt5R1NEdEZzajhBTzdvT01LNHhhSjNieG9PU0VMb2VEOWFvT29ZZ2Fu?=
 =?utf-8?B?VVZERWI3UzQwUHRrUVMrOGh6eEx0SjZhVmRrUzE4dFp5MlR6Wjk5c2lnZy9r?=
 =?utf-8?B?bGNueUdWdTByeERPKzhodndPWlJRcCt5Y3ZyaHY4Q2doWEZBL2xMSW5rTGFK?=
 =?utf-8?B?c0IxMEN6Qjc1TkRtQm9nRmEzNGlJOEtlVFYyVUhMamxkeTRDNS9jWXhOTGEz?=
 =?utf-8?B?WDhkMm9KbitObHJyRDFBWnBsU3JIR3lab0tEMG5yUVBFN1B3M2lZZE0wSFVr?=
 =?utf-8?Q?8omfdu7zd3yAYTfeUlgeg8uHu?=
X-OriginatorOrg: polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee86482-a552-475a-a076-08dbbb91f6e2
X-MS-Exchange-CrossTenant-AuthSource: DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:32:59.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0upGBxdLzHD9oZ1dy8QfTVkSt81nh6arb9HyvSWbk9JepDR1Ej3UFLIWOOZAO2leyoNVqxM8eY1rR4H859We9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P251MB0745
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I am doing a simple experiment in which I send a message to a TCP server 
and the server echoes the message. I am attaching a BPF sk_skb 
stream_verdict program to the server socket to redirect the message back 
to the client (redirects the SKB on the same socket but to the TX 
queue). In my test, I noticed that the user-space server, which is using 
the poll system call, is woken up, and when it reads the socket, 
receives zero as the number of bytes read.

I first want to ask if this is the intended behavior.
In case this is the intended behavior, my second question is, what 
should I do to prevent the user program from waking up? I hope by not 
waking up the user program I could better use the available resources.

Sincerely,
Farbod

