Return-Path: <netdev+bounces-15426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818A7478C0
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 21:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B121C20A6E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A7D79CF;
	Tue,  4 Jul 2023 19:38:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75026128
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 19:38:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05810C9
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 12:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmjO8RDwsSi/Zpxn+T9tvqkjstxYNqyqif1vwQOljqZPGzUxCWpNpAVrOuTd/+EvYjwvcAVPOyGI6EurrG9UbgHfICx5SeNisg/cL1Ax5fQn4pYNXYwyeXMt/f9aTUPObo4FEPWMISK5/zE9MhScsyD2+v7VVdrck7FP/U3nQN1K8b/fZjG3nPwKw51mOJoxSsVqfYis+flW8YXyeVHduJujXacYB8smjtmaSZagrGuJ1v9dq6I460C6SCZ75TTRE4ed8Fzle+VAanrZZAGEnqlCjRWymVAB8KAvzj2TSeQYyc0/aU4px8ODXCn6TNrJDbbH63pg+y/22/haGABWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UdX8wH55Z3YIpFKgkRfEk6JCIIfWE1UKgfLrNYsZXQ=;
 b=bjtB9iNhoLNTGsF3pdRcjfIh1LEkt/8cqVmF4MlSq5R0mn4Tmm8nj70/RpIDOhBMQBDhaU7dRtuE2+PSJBARbqpt8F+eA8vhaEBSyDe4maIuFqA9QgvAALHC8OfgW/9atb9pik2Wrc3jmVVW/qW0Th1fjVmZRJ8GDnWIBmapYec960QNZ6LeL7pYU51KXd6VECeEwhgtS8vpgOEpGQLvmCQYc//aJaPlLulrofoUqpcl63hN7HKn0NN7DJEX56WtgjIc8jsEWUfIpPcxWuttauL+YheQ3pAaZ/fA5FASNxO5QAIPBKB5Nf6oVN3w2MzrzJ249U1KMzFIxarNcygwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UdX8wH55Z3YIpFKgkRfEk6JCIIfWE1UKgfLrNYsZXQ=;
 b=MCR9XnzxPqVKVWkhCAiKIiqeOzOkN2A1g6bWYKjBBQGR9RZU0iJpU+gr/v23yzE0wBXtAj2TPagrA0xwFaI2rhWAPQin5BReL/ZlL7rVVyJ7h0NGUDG3k8tVq0vaQ7vxWCpkjrXM6QbX3C8OBztqyViK4X6FRCCJKU79CW4/9nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV3PR13MB6359.namprd13.prod.outlook.com (2603:10b6:408:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 19:38:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 19:38:08 +0000
Date: Tue, 4 Jul 2023 20:38:01 +0100
From: Simon Horman <simon.horman@corigine.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrew Lunn <andrew@lunn.ch>, kernel@pengutronix.de
Subject: Re: [PATCH resubmit] net: fec: Refactor: rename `adapter` to `fep`
Message-ID: <ZKR1GfkhHIVW+iov@corigine.com>
References: <20230704114058.5785-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704114058.5785-1-csokas.bence@prolan.hu>
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV3PR13MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a990833-527a-49b1-4bae-08db7cc63204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4kij2OuUj2obe1b8fQ+9AHInR32/FscZgvI2U8vaN+MMoZmzvqWbcBMD7l66gFTtySRWd8AFtVeF0sMPOQnm+Wp/wufwDE2nNp3ZD5YG4ntseVOs8pCE0/x7+vJTEs+H03itN0Sax0tJQ1I3j4dmGsy9DMjPClcNRsAa9tv5pikt2cgXl7082vT8gpGDbhw2g4ERdjm7psnN9F4tlt8dptUDCknidOoDNkS6zRKwbFG+/cH/Sslj96g4J25TttyWGYNehcn4uVjQCHo5W74i6BcISz5N3698Gqf+EE7FpD0j4bGOt66Rx2sWoF0BVzsRXpISjfM5180J6mpWSsxAoPCBUJjjCwjktCMzyAH5GfR0YVue+xDvJlzwRQfAxmXeSsCDozHlLEXUFcx6rfGVarnGhNSJyjqdQ9IbgLShtDbTKDhHoBWde7B5856dFarfrQMUgZtA1h2KumCyem46BTg5kvQNIeC04NGOhfBzA2/raprMZ+oLt/XUkXNLuOrcb2Bf5lloKOHYdV2FXfAD5JCO0AvtjirGZjV+u0B/Nt2ILubJaBSUujFqvLinW9qBeNOFgpalnzxotBW8/ur3TYtY2zg9S9GpeBk7OKOf6oCzOoX+ta4LkWCTtpWZ4zPlkJAT5JXDcp8RkuFaRkwOGoaAAM7YxzPv2AIMWfkkofs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39840400004)(376002)(451199021)(41300700001)(4744005)(38100700002)(6486002)(6666004)(2616005)(186003)(83380400001)(26005)(6506007)(66574015)(6512007)(966005)(54906003)(86362001)(478600001)(6916009)(2906002)(36756003)(316002)(66556008)(4326008)(66946007)(66476007)(8936002)(8676002)(44832011)(5660300002)(81973001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXFVaFR6dDlZT2l3clVMYVJUdVpJYmNvQmNKSllNZ3pqZld5aWZMc3d0K2Rn?=
 =?utf-8?B?VForSVFDY1ByQ1lodWV3WlZzdlJFZE1YOTFPdjk1T1NqNzlCakVVT2RKeTJo?=
 =?utf-8?B?MWgrZFE3Q01ZRlg3NmpvTlAxL2NLemxtZjBUdDNZTTlXQUlnNzRIWHhRZW1N?=
 =?utf-8?B?aEY4U25MSzJqaEx6RW1vcWR6cll2RTZ3cWNBREFvTmo1OFNWTnc0cS9nTUxM?=
 =?utf-8?B?NnE1a2tJd1ZxMjNWOW8vbFJXajMyZ0s5aGZOUHV1WlhtTXVLMW1MREMzWFc3?=
 =?utf-8?B?bzVlWU1wTE1xeGdnWlcwNjBBd29PRTE0czBKRzNDbGFzMHlvYklOQ2p3MEQ0?=
 =?utf-8?B?NDFTTmkwQ0RFNmdrbEF2RVhBU2ljcjlVakFGRXJRUXFnZVZtMGVsV3ZFTmFp?=
 =?utf-8?B?MTdWYzE4OWRwNlUyRTFPa0tRdzZHeVlkeXQvUTE5ellnQm1ya1lESWVQVlV4?=
 =?utf-8?B?L0xBYTc3VlUrVXZNb2Q0Q2JER3BpWlg0UnNXZFE0ZjBqc3Z5c3FFcDVNY2ZU?=
 =?utf-8?B?cjRIRVZnTkV0K3RkOVVxRmt5a05ZRGtFbnV3TDlIUDFkUm54SVBJR1ZDZml4?=
 =?utf-8?B?bkFFVGkwWXovRWxuZGJpWUpVdEVqTmlMUUdZalNmRDh2TE1hVWNhTzJJbEdL?=
 =?utf-8?B?bWdDVGdONzRHRXhnMnNSb0RXYUFSN0QyejZYc2RIa2NVSXJCSy8vcEo5TUhZ?=
 =?utf-8?B?bHdMeC9yUDhDRGxiaUcrZi9WTnlyZnNxcGprQTcyU1VkK1IxZk44YytvaFZV?=
 =?utf-8?B?QlR1cGpPdXJxSlg3UEN4VkJCdld2KzEzcWxQazYzQVZ0V3pneXB6NmZFUmZF?=
 =?utf-8?B?QStHOGNDUFJxZVNtTTY3WUpjVlkzMGNNbjNyMDJRZnZjcVppSTdTYU1TeUlo?=
 =?utf-8?B?OXk3RlI3RUFUbEhqTENDdStBT1dlUVI3bWQxUFBCMS96U1hvTkdwb1F4VGRB?=
 =?utf-8?B?eDBvdFBhVzd2cFJpbVlIOExaM2xRczFqVE9SYU12ZjBSZlJsemxyeTBQZEk2?=
 =?utf-8?B?R1VPM1dYUldwQzNMKys0OUxyMnl4NmdzRkwxZWU4OTQrbEZSVDU3ZUNsV1V5?=
 =?utf-8?B?UG50dHBZV3c3RmN4dFREQ1hFTDQ3QTU2YVBmdUd1bXhwUTYvcXZROHZSQ0kx?=
 =?utf-8?B?WE92Z016R0IyRFNjRHQ0RzF1M3RMbExFbmw3YWhRY1pnVFpWZjF2dU1WZDRC?=
 =?utf-8?B?N0tKeGlucnZXeHpkOXpGSE8vRXplVjJzZGJRdHBna1BhaGZDck9mNDZVTWJI?=
 =?utf-8?B?NXpVVWJQVzkvRzNlOG9zSFY5OXc4aE0wODJKRlJDRXQ1Ny9OR3o4ZkpmMi9m?=
 =?utf-8?B?VDBpUm5RK2czd2RabUFOZnVYenVMOVhYYkFscE03V0J3ZVF2M3d0WU1YZGRx?=
 =?utf-8?B?cFNGaURpWUZXRVVRTGNLa2ZmSlNFSjNpaFdNSXhKc2pmRCtHU3J3Rkw0MFZR?=
 =?utf-8?B?NEk0KzR2amVaUmJ5T2Q4Q21Pdlc3VS9YMFVmUUZVbmZPbjhHd2ovNkVycFE5?=
 =?utf-8?B?SVd4RTVEV0N3bUFjZzNPeEFFaSs0WGZ6dGd4dk00UmVKOE1UcWNyVjVlWHc5?=
 =?utf-8?B?TVdoUnlkTWdqWHZSTHErMFN6TW1jNENUaUhsYmVGTlFtcnF1dllqODZrV0Y4?=
 =?utf-8?B?VkRhM0xVQkhnVWdmVDZsSnY0cWFMNTBIZTh4TmRxT0I5S2twWi9xajgvMVRn?=
 =?utf-8?B?LzZwb1hzTHlENzU0RWg2WlJuaHc1U2NLNlJ5UWhsQWNMdU1RUHVlOENMYnZ3?=
 =?utf-8?B?NkZpWURWQkNLVjJEanFzWEVIaDZMbHZ4WU5qSDRGZ3NMdm5KSUpuUEJ5czJR?=
 =?utf-8?B?bkpOa2hNaDhlUGZrWThGa2hPTDlucDhEcGIvWFR5QnIyNUxSZCtxaXovN1Y4?=
 =?utf-8?B?bTVUYWpLUFd5cDBkZFkzRDRaaDhZRGpPbnEzY3RFWjQ4NE56cElVdHdqazNw?=
 =?utf-8?B?a1V3UUVUbG4vOW95ZENQbUpBRHJzQjU0bXpTbSsyMHhiTkllU0dhcldkbXFG?=
 =?utf-8?B?N2FZNkhuSHFsOHJMWGJiWUZrRmUzdTcrcHIwSzRMWWI2Um5lMjFUTlh1RUtJ?=
 =?utf-8?B?d0RuRTU4RFRlSmJwL3JxMUJrOEhTZ1BJZHFpL0FBdE1qZWZsTmlEbWdHNWVm?=
 =?utf-8?B?bmkrdXJMdmtxN2t0YkRkQnNaQUVWRDlEQnVmUXJLcnZ5NzRHY29yRnZQU01z?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a990833-527a-49b1-4bae-08db7cc63204
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 19:38:08.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XgNNJ2eqFhC6pczbfjN27B5nXg43nO9jkcnOAoNMkZCV1As6f3m1LK0DvqHC2xS8r9cv2nGe5BsHCwa+dPn6jevfWzc3P8arHhdGChh6GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 01:40:59PM +0200, Csókás Bence wrote:
> Rename local `struct fec_enet_private *adapter` to `fep` in `fec_ptp_gettime()` to match the rest of the driver
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>

Hi Csókás,

I'm assuming this is targeted at 'net-next', as opposed to 'net',
which is for fixes (I'm never sure with documentation). In any case,
the target tree should be included in the subject.

        Subject: [PATCH net-next resubmit] ...

If it is for net-next, then please repost when net-next reopens after July 10th.

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: deferred


