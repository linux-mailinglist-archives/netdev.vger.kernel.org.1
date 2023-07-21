Return-Path: <netdev+bounces-19817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA475C7ED
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DE282193
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7A1DDD6;
	Fri, 21 Jul 2023 13:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC41DDC9
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:37:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D7F10F5
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxReC0N5GQ9quWcp8FbJKtDgd1a83L92rc15Q+UvosdJvWmkX78rNQCQgep7jByNkq7io69xk0bh1j0LVIlkXRV5EDPhzop73+ZWf+6bRsL+yGz2qVU0TxdXklZlEAr2z0EuZC9AYPd3yRU9JllIriDzkAKO3wFY4g1g6ZQx13MsUb9RlHl9ZrdfRyPatFKjEcfoEC753HwvUQhYUPpoyQVG2i7lpmjOty/C/dKU1/ASj6fKAZwFtM1N4PgMY48re6EMAOqvrXrZ53g4uMHKu8NGSKRHHJCFggK/7MDqvf98clJ12SyBe8uyMy0gL6boWhvBypTKcGmARrNU1dQZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ogel/E2vlxXNfhEdUkyIfrmt8ujtqcdyLaZfSCnjAyw=;
 b=Qna6e6oeLxQgZNxjsvCQGSRvP4L+PzaYpDgrFSFjwjWbLHKBTMZbSl90wPUF0lZzZ0a6DQpAA+Shhx9ti4MQ1GNn0Ncw1DWxeHVTPcNUkSqM8uzIB4T7dF3BqUg3u38tPf6e2qYr/q8m3YsZ6rZQ4LX/outshweNoNvAKrbytQsi2G3UomPlWI4Hmcev+/jAOypaELgufEMSNnxo1s1S3E4DWaHG6edh4hLHKYN1rV/J/qlwTIgO3sA7jXzNN1ffTezQJuqRrRJBFLDUd7xhAfzbahPTKR37bJs7xsaj87x6iwAwzNIMN9+Q2ROrgmDXz9FeipwZGNimDAa1ff9rDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ogel/E2vlxXNfhEdUkyIfrmt8ujtqcdyLaZfSCnjAyw=;
 b=AsG6aYfTCSASMF8uDhx3ftUPOja7nnVhfuw0Z9sl8wvJIrArwGz8uMRdruXBRGsPQQJz4dcY40g+IjzM75em+BljI1cUMBwsbJFHsHmABlwYmzMS26KCfaigX5LviVZ4T6gV4h+cML39kkxQQWEbrmxzZtz6Q4hFh5/55kMEQ9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3688.namprd13.prod.outlook.com (2603:10b6:610:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 13:36:56 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 13:36:56 +0000
Date: Fri, 21 Jul 2023 14:36:49 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
	Coco Li <lixiaoyan@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 net-next] ipv6: remove hard coded limitation on
 ipv6_pinfo
Message-ID: <ZLqJ8bUGfYrTp/9P@corigine.com>
References: <20230720110901.83207-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720110901.83207-1-edumazet@google.com>
X-ClientProxiedBy: LO4P123CA0166.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3688:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f6da7d-6d8d-4a51-0b80-08db89ef8d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+2bQjlWVaDQSicBlBRzGt23yTc3+FRR8pyn025OW22RePK3lO5UkyHwAXdVBpPd2NVrWsA4GRALKHB1d7BgBuBqRDAfi95FqgQlzDBiBp50aGuZjZIv4T6YHRlVCQO2WEVCbJZgAUA/Kx4s0NlsGBg91afAofNP+oypBXa8Z5VOkHkjCVuTWE0fnSEm5htqalfwCuJjF+EOgWB717PZlm8i1BC1eQ9yUGsuHgxqd1CjSnI2uqqUYzYG7IcofKFcRwyylXiBDv3dNmX2RDrNjVaYnL3F6e4FQcrjAzBHcCRoxOxoKNoKt5wyZiDTYGL68yRBZ5PwmMB+nd80CL52DWXw/BvdVXW5Y/ZRVIHDpacSyzEcL8SJt9cS3YqxmuCo9Y6xcU/mtc0NIcRyxkJO2UFv2jmVH9P166CHgEFF0w/YCQc3ZAttDGAE0rO9pYlrMqc3C62fXZHk2mOj9J1PxpbgN8DHG8+XOwK5B8+tVKWqi1Fr5xVV7zlolprmU95MQTvCJeb42pK0BgyYS7Ft3CEROshM1v/CGI9x1Cs1+JVtzaIbrE9YjQ+UrA/tbVprMjqvX9lShoeZMCzIi9NCGqaT3l68MMVYUHWnm5+q0nRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39840400004)(366004)(136003)(376002)(451199021)(8676002)(5660300002)(8936002)(41300700001)(4744005)(7416002)(44832011)(316002)(66476007)(66556008)(2906002)(66946007)(6506007)(55236004)(38100700002)(26005)(86362001)(6512007)(54906003)(6486002)(6916009)(6666004)(478600001)(4326008)(2616005)(36756003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K6laeSv34hsZirp/8kM4G1aj2ANozd1sRSQ0+P8shkAXhKGmlkn3kljqakWq?=
 =?us-ascii?Q?ZMka7WuzGrY8oLTwD0AQ6cu5B+44dzGY8i0q8XzFCxeYciyaTLjdEb7AQC8R?=
 =?us-ascii?Q?qWCzD8zkk4X3oibdwogZdSSiKmFv8fA4Hy4RG6JFWMWTvUdQN/bsMJr3nMvp?=
 =?us-ascii?Q?MI3aKDchSaS1Tyj2+wrmX/3l1W7K7UgMTU8O/JUVF/lM3O+Gu4cGDv939Ail?=
 =?us-ascii?Q?gZv3WZ6bRoeBgcfskKZx7AMMeG9OCqTiPfzMG2p5Qur7KdqhVl1Dgu7z3fCl?=
 =?us-ascii?Q?ew/meCy6DEjqjYK1d8ljjRPZrva/An5P+GwmQtBdesnlgUyC3ETaA9XIqy+Q?=
 =?us-ascii?Q?2hdaEdRz7YaRwp5iCF6nBZuBi7U5xmYjN48DTlTkVVIXTt3DJBluCB5DZYCA?=
 =?us-ascii?Q?JExR1M85h1qJgcYwV3ssOeBtcUDCwJBIk2kOOu1D4CEuFNWGpg1bnDWKB3Br?=
 =?us-ascii?Q?TpGGHgmyKHL1/h7WnKkz4a7E2RsoJYP44ledR60MYsmgyj3MnARh0y5dxmd1?=
 =?us-ascii?Q?kKlGkkHEazRquz/fe51RL3+GK4FOmr+LVNXTkkhSQV+EnRbLu3ZNHJjrjD8p?=
 =?us-ascii?Q?ZcqofY4zlypFbzmqM+8qAIvozGQmeV0jc4YBi8N77YUPstmDVCQpO4MKPW/w?=
 =?us-ascii?Q?9jDqxKcsITNwedG/Qxm9sdOD5eqDSCi9+s1RkzefxmWHlLLZBjaKv+rEnL18?=
 =?us-ascii?Q?JIObhlaIkVac4HhP3n7WjVZ+wYRgtt0c1WcKRXsoUCEoypb68+suwQrgqU7A?=
 =?us-ascii?Q?sgtTff4CEbBC/Wf7KKwrx2IfA0z1xWTQN+BMCfO7wb7cb+9eHRCDMjrsxtqv?=
 =?us-ascii?Q?yR/xhqTnDxK+iM2+Qwdrr5VJ+Bh6CktDCTMfS6c2fN6vyBWQuEPklVAecLwA?=
 =?us-ascii?Q?X4pV6Bnz7J6UqdEMzXTAM25XHRFXyvLTZWApxuRjf+tyG4hu/QpXTyRUP9mi?=
 =?us-ascii?Q?Cl/XNfYgtbNiv6jUAsPHjgZuG7OrN2mYip6pLgZ1Gc2vgAGrZ8s7Mikxxa//?=
 =?us-ascii?Q?Faof/bWUjtzGV6jW062g+la6Gj9xdOHm8QAykvBCKaBjFk8sPLR74pQNoGWi?=
 =?us-ascii?Q?u3RXuHAuHvKf7OZKkPrIkElkwhUm1W6K2+Hs/T92JsuQyT54BLp+szDplZ3V?=
 =?us-ascii?Q?Y4t4yRIRvz6oecchcCNZUX/tIuZ8wrKERskUeRz/HJ1M5EpG6MDiza/xM/Qh?=
 =?us-ascii?Q?imL6gIaTyNnm7CU2d1NgqWI1e7gCD/k6bPWUds8YLXMCWJCVeDVBqIKKyeDo?=
 =?us-ascii?Q?reY06DtiVgRtB+TM+muyKJRJPSfYXCu+i52LchA5lyxjNa+bNcP0J0OTZa0u?=
 =?us-ascii?Q?SydHwapCUhlVZtmfpk7BgBKLTFn6xGBRoWOqTWhntnCcCVVEYACD1eqNTA05?=
 =?us-ascii?Q?Wy9GyRtg1icnyInpPGiQpKSY+jio3nRo0qdQ06PAtGqYfgOcvAMu3L1xS34u?=
 =?us-ascii?Q?eY3BFNPqg7UDeFWSkc0jl0xW7HENxxdu1Efh8pBmHWkk8rmLKmpxLE06Lrg+?=
 =?us-ascii?Q?54KgvDvCsrLB8Y+VnG/kYkMOvU64G6bxS2Nhu/CtRn5qRv3WucsQUkVWjGIW?=
 =?us-ascii?Q?lkYBPwi8gmn/6msFbH7eeROp2a3XWGSrTiaoopGeidRMALeUXQq9h7UyY6Bk?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f6da7d-6d8d-4a51-0b80-08db89ef8d08
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:36:56.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0VCAQwbQBq5rBS9ylVGEHSEQsREmvfRYyBiCMyuEObkvM6YrNBNd037nw4eiEkVcBIh21FpoY3oief4xuainpajWRyyNH+RG0+SWJzBH+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3688
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 11:09:01AM +0000, Eric Dumazet wrote:
> IPv6 inet sockets are supposed to have a "struct ipv6_pinfo"
> field at the end of their definition, so that inet6_sk_generic()
> can derive from socket size the offset of the "struct ipv6_pinfo".
> 
> This is very fragile, and prevents adding bigger alignment
> in sockets, because inet6_sk_generic() does not work
> if the compiler adds padding after the ipv6_pinfo component.
> 
> We are currently working on a patch series to reorganize
> TCP structures for better data locality and found issues
> similar to the one fixed in commit f5d547676ca0
> ("tcp: fix tcp_inet6_sk() for 32bit kernels")
> 
> Alternative would be to force an alignment on "struct ipv6_pinfo",
> greater or equal to __alignof__(any ipv6 sock) to ensure there is
> no padding. This does not look great.
> 
> v2: fix typo in mptcp_proto_v6_init() (Paolo)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

...

Reviewed-by: Simon Horman <simon.horman@corigine.com>


