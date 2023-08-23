Return-Path: <netdev+bounces-29941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C32B7854BF
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CCC1C20C79
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D0AD3D;
	Wed, 23 Aug 2023 09:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F73A92F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:59:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A5DF
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 02:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y08YofGGGd8UxQDwpeylRfqOY5ITReDCky++VZ7PBWCik/1QXSwddhbKd2ovQLKo/eM1JYToxZZxJW7oxcQ2Sd7OSuiVWRoH4mpkfSc6dva4DDjTrwhgn2epb48777mnwLLGOloDGsJN23BqX5q3rx+PHyVIQfm194hG0k2qe5Oi+gLTj4wxLUpFoq7EAQFTwjgaSuudHJHw+ZfO5oWVVsDByy5HTETxh5WD9/THCxaqm9KTi3TSpDlmRir2A64UJN+cVAj1FtLYRvaNTdtqp1JBGtLILsVKZwExUgzoKQJsyMLzHuURpUqWPyOexeD834RIE3SFwB7otWdg2wKuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7GPABLg3rpK2iXCAQuKpq+7SFdO5hoxN1PiQf3y8ag=;
 b=PIVB2dYtoBGMMwm67QoLziFdMFtiHwD3lBUmH8baNLA4uuh6T8d+lucSzwwAMt1nx/jVy8sCIKjDvdxGyNVqGWTj12PHomPx/Xa+4i4dm3YqOaq+hDOsFM/s0jKiz1yMOmQ08E7TQD3mXJ+IBl2fRdAM8UpJwzYwkl8J1lMejB3efPeiDmXRH5CSsmEuX2S+shuPpUMlXoUF+9Tv+6+pKKz617lbIs43z4EvZPeTGWBJ5b6g1RRyvxb3zk5QHQPpvCv88qZ1Ho5y1VnJaSvm1z5dO4SPjEyfqW7UAkASzdh5UzPVTyIxQWdNXakQwmIbR3m7dlHknlBgnfgsEmQ7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7GPABLg3rpK2iXCAQuKpq+7SFdO5hoxN1PiQf3y8ag=;
 b=OMuR1CteAxv7K+Mb1SBfpnSTW3Lf5D4Ws+rHg7DZlyG9sfJu7VQuHhyOa6StyQg8tAOd67Z00dWbX0kcBcQAyMISEWTt32U/6zyvXGoWX1vopY+9OJOPEtAd5mYytRySYF1GZD3fZQYiR7eFWOQKT0pm8Moq9gjfHTaL1lNp3lmf+O3MVPTEI+tgHs2NLnby9OfjoGmhIwWfHsw5Xv4OYVgcHzjaAHWxm6DqXFJVsNKRsMc6aFYPNOE4x2ojgYW2iUhfprCY4H0N1wJSTUJCdEVQqXB8UTAxAGIAeWYkU8KwzRpBXGGKYJ8KQp/GgoFggaGpkBIhE9jBzbM1JenyrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PAXPR03MB7633.eurprd03.prod.outlook.com (2603:10a6:102:1db::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 09:58:58 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 09:58:58 +0000
Message-ID: <57e5868a-1913-b438-e7aa-ab6b064c45a4@uclouvain.be>
Date: Wed, 23 Aug 2023 11:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next 1/2] tc: support the netem seed parameter
 for loss and corruption events
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20230822140417.44504-1-francois.michel@uclouvain.be>
 <20230822140417.44504-2-francois.michel@uclouvain.be>
 <20230822084348.48ebc808@hermes.local>
Content-Language: en-US
From: =?UTF-8?Q?Fran=c3=a7ois_Michel?= <francois.michel@uclouvain.be>
In-Reply-To: <20230822084348.48ebc808@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PAXPR03MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 482a1d6f-559a-4edc-2a65-08dba3bf917a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vcwj3BEVv7HDaUZT+mkYqSMfX8fSUWv4wBrWDPFyMOZNQz9cP70zpzvyqdMEJQvFqp8DbghvIJUmB6j1r8BJF23h+E4aCDDA1b0AyX3WCcxitFdOgD4L4Iv43lU1R+DW94sUdzb2ZuyWVmXipJgf8wQL1bU9l4DcHT7PIONaG85xRwm2d6zlfYnObYIjtnN5cMq0yFYWm41hULU5/wnQT9NJ5UudqRoufY0kRUbml1QGowAvpHR90hSIT3HpiImkpuIX2d//o6qubIhM+p6Tvb50Xv1hSgx0FDX68TKRS2sFXQJJHfbW3hECb2Q56piL8fPWI49H+iv9VgHS0UMypZ4vSkkPJS1KG9YDNVOruAMhfPhzZCPX2XBxt9L3Soqm/rkY0pFAOJsAyYwdfrGV9UomRkKUyi47eQy2qqHvsho0y8/rtuJFuDG48jKNR8zIagT3dPz3glTsd2lyFx4PMUkmWVvtcdrpbEwQj5cB6d652BxJmM2W3QZl4DY6PVHPHPmqKak1uAjdDmo3GwJp8L3zPs/iaYeHpS9r3/m4utG8NqkXtTopbmVoQBYF3+1a9lt38p0sP2vjG7dLvPWfc5m1wgeXdrPhi6e+4sz0QZEGTYKavkis/HmgT438d8qvxpZfuzQzN2Zay56+APU7lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(1800799009)(451199024)(186009)(2616005)(83380400001)(4744005)(2906002)(6916009)(6486002)(786003)(316002)(66476007)(6506007)(66556008)(66946007)(478600001)(31696002)(86362001)(36756003)(31686004)(5660300002)(8676002)(41300700001)(6512007)(38100700002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXBqN0NFenZGbjBJMkdjU3pHNGF6b3lHNVloMXlHK2s1cmxPcXMyM25neGRU?=
 =?utf-8?B?TStGeHpqYlZReThBMFRndHgyTmtlWWdmTVdTUFROTFhMQmdCSEdPQklqR2dh?=
 =?utf-8?B?dUtrRDhwcS8wKytlbmF6ZVNOTHp1WHFIS2RjNWhnMkZUQnJpaHNwb250N0lI?=
 =?utf-8?B?a3VhY1NMTzl2Q3VCSTVaWGNlaWZZTXlOc2wwNFpNbGw2UzVzYVR4MC90UkRa?=
 =?utf-8?B?ZkVCQitYQXRkaDM2c1FUS253Z0E2VDNlN2p2Rys4YW5hY2ttV3J1OTg5SWVI?=
 =?utf-8?B?a1N0N0pyUTFYbngraUY4WEZWK00xb3JpckFTZFNSWjZRWUo1RHZYWTNMU1lC?=
 =?utf-8?B?NllLaDBSc0QxTFFSOUZNWUR4YmxXUHRRNGFmY2k4bnF2NFRjMXdja1o0K2da?=
 =?utf-8?B?S0ZhUzh6cGhObUZ4RWY0b2crZmtCQmFhR25VVGJLcDZ4L2lFbEVjM0VTUlov?=
 =?utf-8?B?dE53Uko3MXdMMUZocXBmTGxKZnpUUkxDRThYREdnMjRnMlpCUmRmcWpEQzhZ?=
 =?utf-8?B?OU95RDZaL000VGtWL2ZNZEpPVXFoQWtyM1JQeVgzUldDVTd2MTdsdTRtbmFl?=
 =?utf-8?B?WWpBSDl0V3Nsc1kxZFRzSVh1MVFPOU1SSVFBcDl3WEQxUjdmcjFtemQwbGM2?=
 =?utf-8?B?S3VyMTdqalhPTm9GN082OFVQeGsxZUc5VWh4WTBDUXFEYmVxajk0WDF3RkFz?=
 =?utf-8?B?VkhGYTI1R3pBb1VUK3lJQkREYlRhTlhOaFB0MmxWT2s0UERXaWJMa0hiS2dB?=
 =?utf-8?B?Nzg4MTNUb0huQlA3OUFTeDN5dTdZajVmNmVyOXh5ZkNXRmZmQW4yc0p6OFpi?=
 =?utf-8?B?UkNGU203UWNFeW43Z3U2dGFYdWx5U0lNYmt6NGN5eDh3cWZTYXdUdmNJVzJV?=
 =?utf-8?B?OVJxZUFaY0dsNnJYNTZwQlRmZllqamtNN3ArUDJIUmpxY3ZlMlVuZE1GeVQ3?=
 =?utf-8?B?RHpBZkhkWThFWGQ4cnN4ZkxxMmI3c0dCN2NJcHNlcXZ3UkV3dzhzMmsvVmpX?=
 =?utf-8?B?blZNWnZ2TVRjVzI3S3Zmcm9zY21mUUZuTGFLMHY2QzdzZjArcVZBUjIrMTNp?=
 =?utf-8?B?cVpTYVNGeGdwYVRwSjNnUm12TDRjdWdEbHBxbHNKaHNaamY3NTN4QVY4aGJB?=
 =?utf-8?B?NnRsSkdUbm1UdG5hVWVaZjhUVEl5VytpUW1qWlcwVXFCTlNjcWJQMHRlRXRY?=
 =?utf-8?B?YzRpTzNCSW40aFV2YWRsYzdrNndKczVEZjd5L1dYbS85ZXVzRTN3RjJJQ3BZ?=
 =?utf-8?B?Y3Q1RVoxendmeEhVaXhYc0d0WE9vZWl5QzB5dDl6aVdWWmtoNURKWmhEMFVL?=
 =?utf-8?B?OEJwclMySkRsUFZhSDVPYnZHYjE5TXpYVTJIZDZ6RE0yMEpWYnZ6WlFQS2gw?=
 =?utf-8?B?NE9ydHpvd3ZKMitzTTRhcWUvR1B4V05sWVhWeFg3R3V6Q0ZKTkYyZmlCbC9t?=
 =?utf-8?B?a2tKWE50c1pzVG1iUUxsb2NJckdTZnRWZmZyNlJmYVQ5cmo0VVR5OVVoQ3pC?=
 =?utf-8?B?QVNCaTZxcTNWaFRuUFpmQjF0akQrelFaa0VYcERKdExCMVMvSjdYNmQvcStk?=
 =?utf-8?B?TjJUY05WeGQyYmZyb0JQTG5jTlJSWExYVG5tNlBVSWk3VmI1TXFvQjB3bEZL?=
 =?utf-8?B?TU95WFBmY3hsZ3ZLL3pvWTdOSnFHSExJWThnelRpdXpMRWVYZTJnZE9TTDFs?=
 =?utf-8?B?clhUTDVYOFBHQlVPdmZKVTNzTDhYK3VnOWE4cWtxYXpvRElhS3RHRDM1L1V4?=
 =?utf-8?B?R01kSEdLWWFQUHA4R3cvUGE3N0hXMnJwY0Eva3VhUXFxTGdmbjNGMmp4SXJl?=
 =?utf-8?B?UVpzQU82NlY1eEtUcmplc00yVEk0NHMxcmtDTktSMy9BSW1rTmlzQk1DZjVG?=
 =?utf-8?B?OEpqdWNFSk9TaGRMK1E3SUp3am11ekNSYzNpNUE4OE55OHBTWHNxVHZQT1Jr?=
 =?utf-8?B?b3FWbkFuRVVFbmRuUXk0THpsWUZIcG4rd05lelhHYlhHKzFEajZyaTBRbEZ2?=
 =?utf-8?B?eVU4M09idGRGVjJvejRMNXdGeTJGcUNtc2tzQU9IOThrM2JCazNJaU9SRXFW?=
 =?utf-8?B?aFJUY0JjaW1TOEd2QzFEOVFGcXNBUFpGbHoxa2xJbWpETFdFT085VFJIY083?=
 =?utf-8?B?R1I1cUJmTnlKU3NDajZPNG04RHJDbnVhQVFBZEkvY2RsclJ1YlhuWVJKdEs2?=
 =?utf-8?Q?UX6qIkIjqRrdHI71t/AtMwQtOtYKjbXOuyCHY43zoipj?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 482a1d6f-559a-4edc-2a65-08dba3bf917a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 09:58:57.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpozQlv+RcIzSY7OvyLxlV5fW7AT3hhTBinuby0TcxhwuXOlRxzm3bYcL0GFxXyOE/hsBC6hIZzlX5ZbiJqqsj2IoLOuyLf/mI/gaN8EX8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7633
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Le 22/08/23 à 17:43, Stephen Hemminger a écrit :
> On Tue, 22 Aug 2023 16:04:02 +0200
> francois.michel@uclouvain.be wrote:
> 
>> +	if (seed_present)
>> +		print_u64(PRINT_ANY, "seed", " seed %llu", seed);
>> +
> 
> Since seed is after slot in the manual, you might want to put
> it after slot in the output.

True, I updated the code and re-tested. I'll submit a v2 patch now.

