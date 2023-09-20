Return-Path: <netdev+bounces-35148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770C7A74DE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C7A281DA3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB4C8D2;
	Wed, 20 Sep 2023 07:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25C8484
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 07:52:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8EC2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 00:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP0L8Q0W81ymPiU+3SIlDxAH69hCg0Yyp4fZrEftqaDNEFudzpMyK3ExsIAFTD8Jo3AS2VHlyqWWJ01mJ29nSn2ed1nKgO81y5osaIPay1V36nzXwxWklpJPqPXSi5SxmOmemk0aWV9eP/g4tI86dqThtFuyMANG0dnIyTgHObMzbOi0c5gZy58FxPagR+ocaPjoWF0TVQiC+FERlsN4UArMNN0gIeodchc2LoAneWi03yscXSwMDJLx2e5DGrrDpKbvGrO9q55Q+uQBzJqiHwXRjH6AsfPPDy6ttZ44DRxkFHSP+LdtuuH/KYU7p2mBLa5UlAbse6Zn21YbSh/tzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3wuhHjGKYA+vn9BXuNoccu6Dad4krf+JL5j+IxY66E=;
 b=cRMABe7bDxAFEzHCTct+6GcmirW8up0/nsBWdJyHLrbngmPUUKtMOHQ+f8JM5WNEAvskqIhwGLU0nDLmKEO3d816cNZNRNHPqDB9NmMMAUVk64LsEICDp2YyaU8RztHxoccT6h2i60WyDv6ioC0FtqhyD+i8VyokgIAzHgpTAbzsJpoXaEMVB/a7GN8ypNFu5jxLRfEx1DyGsLucWrRQDGElXaus6wQpXUyF/HSwn5dfpq45UgvxFJoi97ox0F8JOQ8bCt2oJeJMnrLcyBF7IDzJEQ3VmrmSAuL0GKFDg60gx9Zrro5dzaCNLZgukOL/6orOoO8oQE/8M8b87/iaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3wuhHjGKYA+vn9BXuNoccu6Dad4krf+JL5j+IxY66E=;
 b=hPwkf8ltk33JkXEOQvGhGyLcL+etyDs/At4PzrN7uFJzXyLwx8ETkryBtXG4X6MaMmqyn7ntKbXu9IZbvN9luE7H2J8FX65jjRomfLBAWXgAqEvO285OLvROhfU7YefdW0I1eyV84BbDQ/pp9Zwqk3/F2Q9yh9SRnfFGPyRUT24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:155::18)
 by PAXP193MB2010.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:52:31 +0000
Received: from VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::579b:2:bf1f:24d]) by VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 ([fe80::579b:2:bf1f:24d%6]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 07:52:31 +0000
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Linus Walleij
 <linusw@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  netdev@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH net-next 54/54] net: ethernet: xscale: Convert to
 platform remove callback returning void
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
	<20230918204227.1316886-55-u.kleine-koenig@pengutronix.de>
Date: Wed, 20 Sep 2023 09:52:29 +0200
In-Reply-To: <20230918204227.1316886-55-u.kleine-koenig@pengutronix.de>
 ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 18 Sep 2023 22:42:26
 +0200")
Message-ID: <m3a5th1dtu.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::18) To VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:155::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0685:EE_|PAXP193MB2010:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7c4908-4807-4342-6e9c-08dbb9ae8b2f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TTolALwxGSonSk5tlZKAWcQ598i0nbrFcqtgsvUzAYlrwcPuYysTQY+6xkFppGjFo4yNUe3ZMsB5zjZp00oeZ3kWJ/ktbU+QrQSYZ+Stgr6dVmcQCivYLMOzarSns5ZLM3MBXcNMboPx5n2fhq41oeg+8G6U0mzdloTKrM97HCAoI2iH/rjEhgcWC7dFtxL2tqjHJOKjdrWh6JycB2sOstXPIWxfD0Q4m63S4nBevMkApMT016OzIzXJyBzdAjyuQ9ehmsEeIOFuHXVURtgadTp0EwGzU1AhknSOO/vClvhHIb2SyQVysjEv8fKK0uPi7X2wIuWvRFble4ZCHm97CAmoe06tKOQ0CyCwXDNnoPa8UNId2kRTthmwCXTATQXQocRWkxybCCU9IxeohoMe0uuCbeMwN1MsTxt2KlE8VOXyv8+F0t2bC/gYMnqMOI/5B+VjXP/wOIYoG0pPasMOAF8GQ5osFEACshlCUJnb1G7QGs6qmVIi40MIKsIKbMzkUqPsPlXjSspqJrsl6v6F/6B+fBc2MJNEiSv6kZ79+95UPFPfGhLAJlNLTa1GuqJZD0GE1FDorjXOfcBJUr5IdFofsb48qEVlWi3R+mXZzgYivjCXUu1jIQa/nIxrg7rf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0685.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(26005)(83380400001)(42882007)(66574015)(5660300002)(54906003)(786003)(316002)(66556008)(66946007)(110136005)(66476007)(8676002)(8936002)(41300700001)(4326008)(2906002)(38100700002)(38350700002)(478600001)(6486002)(6506007)(83170400001)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0pqZzc2eWYwSzk4UzVNcnBTeTNaaXNJWVlHa3Z1NTNGYktJaFBDQ3hzd01h?=
 =?utf-8?B?WE5UUGRnejJxazlEN2RrNzRLcm1OaEdoRGZnZG94THJscTRhL0JUa1NUYWto?=
 =?utf-8?B?Z2dXMDVOQloxOG81UDBSRW5FT2ZLM05xU0hyYTZxaFh3NjZoRWFVem5YcERH?=
 =?utf-8?B?MHFvRllLaUNvQzdCTzR1K2hIdE5vdzVMWk5wb3FNTy9ySnVUOUhsTTBsbVFX?=
 =?utf-8?B?OXYwSHc2OVd2ZFBLbFpQdFg5ODBsTVhkUlMvM2E4cFBidlgvQ3h4Q1VqRXMr?=
 =?utf-8?B?SE5tUEJ1bWdmRWhqL2puRFhXb0pZcFNpMVg1T0VwTjVQMXJ2WjhnQlpoVnY3?=
 =?utf-8?B?cVlFNzV6UmtuZHFXbnU3MlcwNVpLTVZSMTJtaEQ2UjFZb3lVVll2OG9TMUF2?=
 =?utf-8?B?MmErdC9pU1h6U3ZUaU9EREY3dUdjTkw4SEJyWTdrWEhKU2c3UnFYRTd5OHo1?=
 =?utf-8?B?aDNhNlZnSitsRUc3K04yWVRwMWszOFJWZlJ6VEpJR0x2REpqKzZDUldDQlFI?=
 =?utf-8?B?T3N3L0pWbmM4d3BvTWp4eDc0Y0I0OVdULzZ3eUQvREJRaTMrVXlCSVpScnlW?=
 =?utf-8?B?RlhwTmVWWlFxNXlFeE9OalNwNllENHVoOUNoZVI4YUNlckhkSnhlRUErbVFU?=
 =?utf-8?B?T3oyVUVhV05VbTNoaGdVQWt4eU84UTRpZG4zNTY5SitJenBEU1JDSnNJaDVY?=
 =?utf-8?B?SmtCalliU3gzUy9VNTBLR1lPMCtLeVNBNm83bDBNTWpybUpPSEducVFnLzB1?=
 =?utf-8?B?Y1U5clRWZVl0YVVyVXVZcGY4cSt4cFRVNlFzYVA2emF2enVaalNDa213MStq?=
 =?utf-8?B?eWl6cFp4di9LQTR1dGhaTnhEUHJZL1g0OHlLSTgzWlVzZWJNN2cwSldwQjE0?=
 =?utf-8?B?UFRYeDU4VTdOdi9wY1ovMERYak0wVkJLRitsMndFQWhRZ2NKS1FtZGQ1R1lX?=
 =?utf-8?B?ZzVpL0ZaUzJqMDJSUGJ0TzhCcHdWaTlMM1VNQzFWS2YzYXVkWk9XbW5IOG42?=
 =?utf-8?B?b0p2QTU0SDRTMmlDMHozNk1Cd2JqRE5VbFJ0ekJRNDdXZUlRNFFkNFhMZFpQ?=
 =?utf-8?B?dExPV0hWbTBUSjcya0tjcmRZNnkxUWpnMUtvdDczRTl5R2lCc25tQ2lzNzNK?=
 =?utf-8?B?UEZGQnlKd0JLTzBDbkxwdFFDYlNabXpuSTlrWStLZGNTSXpzcDV3alNXQmlW?=
 =?utf-8?B?UE5yL25pS0xNMS9vOFdqdVpTdG5vWGhIOGJJTjdhbkdEcXdCSDd0cHJZSnl0?=
 =?utf-8?B?ekZmMW9NVlFncVJPRTdrQ3IvckV5c1NNelpSb0IxTFB2eEZ3NzBxRmZDMHFJ?=
 =?utf-8?B?VW9XKzZybTlQN21lQUgzVWhEa25QTWkxSzk2L3g2dzJxSjVtWXorckVSVVph?=
 =?utf-8?B?WkV4MG4vR2dGWGlvM1NBWmI5Uk5ScWZ2Qi9sdXJ0T2tHaUdDc21vQnR6SEI5?=
 =?utf-8?B?b0pjRzdsWUhMQ3RxM3Q5VkFuM05WcGtUQVJ1V29TWHBpeHRnT0l5UmtiU3Zv?=
 =?utf-8?B?VEh2cTAzaGtRZ2VWeUkzaVFyWDVhN3g5cnpnME8xSTdBcEdkc2RwVG5pSG9i?=
 =?utf-8?B?aTJsNkpIbjgyeFZ0Q3NOWXNqRzJMeXk5M1JDdFlXK3JrMWw2WUZ5Ny9mNmVW?=
 =?utf-8?B?QVNrOUdmcjF0YkM4bWE0QWxkQ21jM21CY3R6ZnFrNEY5bjJDc09XWm1qRFo1?=
 =?utf-8?B?UTR4WlVuUGNycWxNc3NwSXVZamdWcXJWTkl0MU1PUG1TcThOYU5SMVJBOG5k?=
 =?utf-8?B?NE9LYWRlRVJBNGpkRVZPVWFvdDVkdVg2cVpNQlZSdGZtdHRYd05vV3pyRVdH?=
 =?utf-8?B?NjM1djE5ejlpZUJiU1hub3B4TEZsOUd6dTVwaVREK1I1eDAxTkRjMzJoOG16?=
 =?utf-8?B?Ymw4c2p5b1dPdTJScE5iNWpwcWdPNUx4RmtBT05HWnU3Ry9EQ29rRCtkbEhG?=
 =?utf-8?B?Sm9kOGdTc044Sm9GLzQ5WkNLT056ZjJOdE5lY3hTekFKeTQ0bHp3R1pPMHhK?=
 =?utf-8?B?YkFNZWI1d0REQkxaM0JaYk1wR1hYdjFpdDdad1FsM0FGKzgzblBjdnlNU1lH?=
 =?utf-8?B?d2NFN2tUdVdPdHNCMUFFSGtwN1V3dDM0MllaMEZkTjZSQWh1UURqQmtzOC94?=
 =?utf-8?B?dGhjaWd0dlhRQ3J5T1pneVdRZ01yeEtFdXhNcm9aL0k2S09TWVF6eXpFcXlm?=
 =?utf-8?Q?q7R3UYcf0KL3yja/c2u6+wsLczoLufoNSSEyxEUlM1OM?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7c4908-4807-4342-6e9c-08dbb9ae8b2f
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0685.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 07:52:31.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDdxv/tQ2CP101SvbZVGUBPxoM3Gf6r2c3ObzHHdSg4goLDQAM1cCmrvFsdZjhuX3L7nSJ2LtuXx/nc5Z5luUXZ96Y1gmzUxxKi8uGxJD71K7P5cNl7zeR4OQe8wgOHfwYqmascRqTPtwl8Avezc2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2010
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Uwe, Linus,

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

This makes perfect sense of course.

BTW, Linus, this is a separate entry in MAINTAINERS (INTEL IXP4XX QMGR,
NPE, ETHERNET and HSS SUPPORT). Perhaps you'd want it as well?
While I still have access to IXP425 and IXP435 hw, I haven't (literally)
touched them in years, so I guess there is very little reason (or rather
none at all) for me to linger as a maintainer of anything related to
IPX4xx anymore. If you wish, I can prepare a MAINTAINERS patch, or
something.

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

> ---
>  drivers/net/ethernet/xscale/ixp4xx_eth.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

