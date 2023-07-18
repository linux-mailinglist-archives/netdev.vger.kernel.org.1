Return-Path: <netdev+bounces-18561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EBC757A20
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B422811BF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EDC2E4;
	Tue, 18 Jul 2023 11:10:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788ADC159
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:10:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31921720
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 04:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SACZOGGFEujjeAw42Tu2YJtBfecp0SqcxkTPqQe7wFP6VCaThr3RZjm8hKzl/bgqo/avFtLm+6JCYCkXQMXkUuET7eb8Q7QiE8/9lXkn7iJGxVzjI20f2G2/a+AVdmI4ZuG/2saivrZ2fTLjYmq+1uGYqCGeBioNBHkZvD4iG5qWTMSxKBvumlf8bvS+7/7RRkZo15o72xzKTBxfhyKCkX4ucnoR7si80NriNxQQBBb3nc0rhegd41FlzyeKayOoRocn4bHJwzhSFtWC/v2/G+YcFs1gdlz5zT+nmqNCvcsL+qYZvTg8NTpU03YLBLxjfy+6Czcr06uwchXxAAlGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK99CXWrtuY++gs8unVorJ8fcJ8POBF7z/6O9P5eBp8=;
 b=lDMJmiPG6Nsg47BEnR/eDduBr7PgwMLgmFDq08G9wbc66pcugu0dWBG/OLLO51mgI6BePiGtYH+lx9nZvVrreVLF2i24ek6Y5xSTjGFaT+O4oDSlegllXMiC3s1JJ0rllK7v5eyg1BseExFKFWW/rTRXrmzrx01tXjrW4JMJ3mc/6J7S5Zbo5IoXkp0q86YowSnI81QdpkOP4AaWLpb2xy7dWLPNEa1sIlwWSFbTLL39dysXTlI7SeEICjbEzHLlScr8pMS60aaeE5sRNj1PzkugAmBMu0SHjbKVuEcGaUrE8iENJ+5PVzAMQANyv2o3DJYcORGqThf07epND7nBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK99CXWrtuY++gs8unVorJ8fcJ8POBF7z/6O9P5eBp8=;
 b=I62EOfXJsPJgalfUFsuoa4uammv5q/7saMdzoVSQoIjerWN0nUI4ihzTy8lNMJsasxGHOSHwkwQNP6vSl1Nhp2DEupSjUhV58V8LTMXUytMA9TW2TppgNi6SY2JCkTAXoaWD2+vliwQtXxlYIjD7hJndW3jwjZ+Lx1QQLvuhwSv0BNHEqYyUHl/iRR+Vqb7/h6nVhzxJogc24GhGpR3bBNjbcM4NcNildOanhdbEymYG56VKReygYitfRAaa44ii05snkOaQo7jiABrBqtpmtvbpLiTftDclLb3pif9/MZJnFvRssJqFeyg8Y1q5IFPxn8TecuWGG6wGw8MrRF/BXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 11:10:19 +0000
Received: from SJ1PR12MB6289.namprd12.prod.outlook.com
 ([fe80::5ad9:1b6e:6024:b192]) by SJ1PR12MB6289.namprd12.prod.outlook.com
 ([fe80::5ad9:1b6e:6024:b192%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 11:10:19 +0000
Message-ID: <4cd81341-5d31-d0d0-0dd6-b247be057f21@nvidia.com>
Date: Tue, 18 Jul 2023 14:10:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2] rtnetlink: Move nesting cancellation rollback
 to proper function
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <simon.horman@corigine.com>
References: <20230716072440.2372567-1-gal@nvidia.com>
 <0df7419db6799e0ea9b896a52ae4a6c85ca34b20.camel@redhat.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <0df7419db6799e0ea9b896a52ae4a6c85ca34b20.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::41) To SJ1PR12MB6289.namprd12.prod.outlook.com
 (2603:10b6:a03:458::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6289:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: cca39cd0-bc86-4500-f9aa-08db877f9261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	swfky1DDCzF9xJ2w1waw5hSh9+AgloHdbIvEPSZKeDxXoA+TjZwMpUqYBBKpLitDhFbxsHyHzjzYxP4y2bUFAlZAcqKiTTXUryHGkeKCRiB7/1sePxtKyKladH8YvVHlODUQxAiPeXeJyXV6iaGdMqAGNqOGFpzox5jjqz727VA6Mfe4/zkOcF34Sqc03cUWBUVWCisKLgURaDHP4eJj9STj+ZMg/8/JKiwsXFV2VU4p+WOFqv2AM6epzzPv6PsYB1lMmEFj1uPjeFK0lmW5k594chxQCRx00lP4X1U9a2z24R0l6cEv81YZ2vJg5Nb1eAx+S8Uaal75s5uf8Cb6M+hOCBMKL42+l12aznKkBgmkuLNKsfhXMKrXyodm52QhzGddi+pcIAh+L3ld+Nifvy5zlLWYvv2T7q1+zRkMgOwGgF2wpYlI/NnJ3TSYWJjSL190p9kn2u/PS9/a4wmV02ObTEn2E8AZ0/IfAJ4yfC9HZbemiD/Z+H9neM9d29axM7y2eJlgn+cbTbVOLS6gJfiX/ZyrfUMxm9CLMspHGk24tksT0X2AkULuQ6ahf7P5nvo84OibTjwAM0DeaBsnURTAGlKkdBbFgvdp51ly12XBzIHUFsxmz6rJO1vjY4efxS/h2eNC7B96z85G4l95zw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(8676002)(8936002)(38100700002)(4744005)(2906002)(36756003)(2616005)(6506007)(26005)(5660300002)(53546011)(31696002)(186003)(66476007)(86362001)(66946007)(4326008)(110136005)(54906003)(66556008)(31686004)(6486002)(6666004)(41300700001)(478600001)(6512007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymp3eUZqZ1F0cFVhMjJXZlMydE9LWWoybWxQQVdRYzRQTEw1eE1HV3U1RFRp?=
 =?utf-8?B?Q2tKZ1NUaUZMekVBMkx4M2FUeElCWkVJdWFWL0hFU0VZZUhhRWc4Y25uZXg1?=
 =?utf-8?B?UWZaWUkwK3ZnS0ZmMjJLZjBzZEJFYWFhZVIyYmplbGc1cm1QUTFtOVBaQms4?=
 =?utf-8?B?VktabmMrYnJBVUFWNU05R3hyWnY2Vk1MUGk1NGVRZytIbzZmcGNhZmRqbU94?=
 =?utf-8?B?M25mV3gzS2JyS3JxRjZSS1d2dFVDM2dGRXB6bTNCSkhuejRFQVE1dFdyK2t4?=
 =?utf-8?B?cytkUERHNVNaNFdsM3ZvQ0E2QjZmVHpxcjRnWUxIWlJGZ2MvTXJDaTN5U2s5?=
 =?utf-8?B?Nml4U25TRGxCR09qelRDMTZJdHJrMEt3V3FhUjNTVEovNHlrWlJ3eXVDWWN5?=
 =?utf-8?B?T2pFNEJuY05BUkZKNXBiRlJ5YWxpVllsOVYyRlRkcFBqOW1wbk0wTUkwaUlT?=
 =?utf-8?B?Z3Q5djlKSW9wNDE5L1FTczM0QWtORU1RQ3N2Rkw0YnNCUW5wY1JaUzc4dXBD?=
 =?utf-8?B?aGkxWFZkY1YzWDlQenJnMEtVOERlMU92Wi94aUh3eEsvZ1JUbTJTc01Jek9V?=
 =?utf-8?B?MDBXcFoxRzJpNGh6OTRZamsvMUFNbjZ2Y2FxbCtrYmhRM1N1dzF6YTJFeU5B?=
 =?utf-8?B?N2ZyZXk0a2UzNjQxZ1V6cFZRbDBkcVRUWG4vdkZQQXRpVHlqMTFVbTBqOG5V?=
 =?utf-8?B?ZzhkZzRRZG9Ibm5VaGZITTl2bmlFMVBXRHRwZ0dPakN4aE5jalBFREpwWWg4?=
 =?utf-8?B?TW1pK2Jyd0w3V0wyZVNKSm5mRUoyYUFrODlQT0ZtWkZtNlVUUGdUU3FqMlNC?=
 =?utf-8?B?ZlBlTTRCTy9Qb0hjcmhIMndxVjloWFAzQUhPd0JBQTJDZnJoMVlVZ1F3RVdu?=
 =?utf-8?B?Q04wY09uL1l3dmJJa1RRTEliMXFiZllEYWpxTE1Nc2xvOWt1b2FEbUMrcGs3?=
 =?utf-8?B?VmpYa2g1ekVyZGV1NFhHQmpHK096aEZ1OEtYaFZoYmhsQ0Q5eG0rMDducWlF?=
 =?utf-8?B?WlJVZDNiUTVGYlRjYkRabWRPNEZacitjWkRwOEtuYjFRUjUvSnVPWDFNc2x1?=
 =?utf-8?B?Y2pJYWI3MW93WS9YSUQrZmVwaWNmODRSV2J2akxob0EyRVdhQmlkeTdNTFN3?=
 =?utf-8?B?eVF3MWFkMWlhVlVrQ1UxMFlQd0d6b2FqSUhGZ29MUjNOOGlndDhqTERUSGtL?=
 =?utf-8?B?blZuVWtCeW5kSm1vNUhJbmpVZ1F1WERGa2p1TkpHZEtRUnVLd3ZlbnhUN256?=
 =?utf-8?B?UE4rdnJYcytVT2J3c1JHY1dBVkl3YkFMSGlUT1lnVzBJMm1oQVd6K3lIUzRs?=
 =?utf-8?B?Q0g2WFh5NkF2dTlwRzdCeFFsTDZiMFgvaW1WTUk1MFl4QlUrZGJRWVExMG53?=
 =?utf-8?B?cHQwK0RrZVVGNnN2ekF6T1ZiM1J3bkJGbG94dTdKNWZ5eGtJaXpNeEpkZnND?=
 =?utf-8?B?TS9kMDZlZ1I2WHRKb0h2S2pvODFQa2pZdExnb2NPa1BVRGtKQmc0QmhsZ3ND?=
 =?utf-8?B?Ti9ZWnd2YmFHQXVSbHdZTHNnTXh1cmp3dTJOVFJ6RWFmTGl6SmwzTkppNHdZ?=
 =?utf-8?B?THF5RFdSZGxFNEJGMUc0bTNxRzFDd2FvV2tFYjVHWVNFOStra1pEeHVhbFBp?=
 =?utf-8?B?RVJSYnNQY3ZkV1lTVXNlOUhhWjZSeHVWSURXQ0VPM2NuNktXK2tnVis0YmNs?=
 =?utf-8?B?WjlpTk5uWXZpbnFjZXlJUVR3c3NEVnZicFJ4T01XZ3J6ZkFxRC9MN1lHdVZx?=
 =?utf-8?B?bmRheUY4Ym1OSWUrMVMwVTVwMlk2SHNoK0NxM0FXNjU0UnlFRzRES0RZcGV2?=
 =?utf-8?B?cDh1QmNpS3BKNk82NDQ2RmYwYnhjTUdvL2RSRW9CdEJreVNuTUwrRnd4azlN?=
 =?utf-8?B?NjNjbXlsbldFTmdyanFBcTlSd042SHN6ajB3TVF4RkFHbjFPM202cUpmWVlV?=
 =?utf-8?B?czlOK09uaTRjaE4vN05BSWZXcDhiUitpUXAvdERkRzlJTUJBSWRvOXVaYlNo?=
 =?utf-8?B?SUhSOFc2L1ZBc0libW9yUUdkc0duYVJJcU1LdXE0QmZCUGUzZnFSY09jQUZL?=
 =?utf-8?B?Tnp1UndUVjdnMm9BazBlZWdnWWpwRWVkay9CalNPL0MxT3RyOWp6MnlIYTBK?=
 =?utf-8?Q?tYxTCFKCj8oLFlM7VXrYsL9Oj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca39cd0-bc86-4500-f9aa-08db877f9261
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 11:10:19.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCiZIoRHTY11E4VdolHJK0KsOaBx8jqw31UaGqN2JoACKZA2DAal0Gx9HXNZdL9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18/07/2023 13:59, Paolo Abeni wrote:
> Hi,
> 
> On Sun, 2023-07-16 at 10:24 +0300, Gal Pressman wrote:
>> Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
>> inner rtnl_fill_vfinfo(), as it is the function that starts it.
>>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> This looks like -net material to me (except for the missing fixes tag).
> Any special reason to target net-next? 
> 
> Thanks!
> 
> Paolo
> 

Hi Paolo,
This doesn't fix any real bug, it's a cleanup, hence the net-next targeting.

