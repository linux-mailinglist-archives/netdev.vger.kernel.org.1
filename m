Return-Path: <netdev+bounces-278193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOyLDtVO3WnYcAkAu9opvQ
	(envelope-from <netdev+bounces-278193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:15:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930273F3088
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F380F3004C68
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330A8363C77;
	Mon, 13 Apr 2026 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rikXMC+Y"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B41D95A3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776111197; cv=fail; b=aYaFgcABf5NNxOuwojhP8lCNJTvJHlGrAHCO/l/IiNHTgYe0lFUAlW+FJ2fWaZ1D/ourrVTJeQJ9RsRpabcd5uyLR4CIR81pn1bKwhmGpo6aE9yfvTF3InoCpHYVwc2e1P1E85JKvNax4C5KKnImYqwUqwGgnQHYfNZ+8EOrR3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776111197; c=relaxed/simple;
	bh=8si5pugOvW5xyJ0P6iz4jKhzCNLIv8pVEPYJsVn/5QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lE6SaXWw5EXuifvugXL/AGwqm5GmQsGEhxIoEi712xFcX1g+WyvL4d2u7O3hfOdZ5xbP+z73pkmz7pc4l2LJWPK9dOrbXiQYqU/YNYe8xvUR5ZFgzo0bVlC0S8jQTNGZ3Nb1ISEbLa6bspkMzVAKGToAUOayOUtyqYXfNcM6ofo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rikXMC+Y; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiosGWEe5zD3L9wpKpUeKhu+8cp6MxssJC3jgWBGt/oxFc5vxQ3zTJLX9VtAh+T/Xgd8RJVOzH6ZNqErFsFthIj5G2pIRlOcioD/tMykQOp7Ks5abTqON8o5z+8nX7MS3nU1OR87y38KEtbWVkB2E4kb8jXQtrJzikL8Yzt2VKsOq+vw/DVe5N3ulQsyTh9bW+WN2qLRYi5Da0l9uuAAsE7oy2HqojdjgvPjC4c9n5a2y+SR2NFmh+15IwCdqcghat1CeVIUezy2wA7SoCfKUosLe8XRhF8GvPYgi0oIAQ5NW3FKArw9GRnKPrbt3V68bXuGjie0eszLaGOdCMm5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/zJthC4yRRa96KlUq+qVfdNrL89Aubre6VjYTr/wd8=;
 b=nOFoKmPPK85g66+TUKzirg7rC9GEFy3s3ny9vRdL/sGjnuORsC79AKJGIpgq7aN47YMdafqRzMOYb41wtgLCW0vsFZLU+10L9ZpiULbCKTx79dLuQisLwWJyd2v/tmZm/boAr1SvA6S5l0kRUzldIZRzpFyMBUEbigRG+HvBOm1RJRBS5Xuh8Mynx/sTWC/z5MKda/8Zi5vMPD96x1bVI0+k6J2YHEkP7F3GR4okWdiHtVxyz+HoYCjrUAzAXIwalznStGQSmIYLTrOJAEMOB4FWZB28zDEpj2VB1erw2sPkiMGFzmm4kMhs0QfKbbHk0JXiN1CRYHZ+Ngr7UxCYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/zJthC4yRRa96KlUq+qVfdNrL89Aubre6VjYTr/wd8=;
 b=rikXMC+Y1MyDDocNBZsrkPQPxy+2erWrtnhCyNs+E/udQJo7Q744mwSwUFrde26uSKlzOyiTRbsoNQHerBXi42yh/lnQH7ayrDgPWKr9tuFN1iI3HSu+ycGcm3TuL2iB81nWOhPJJesZa+01mVuNLUyUP5EwB8z32fIdpX/IE5DRim22b6sFb4BWG5dmWaW6MB1MI0EL6qFzdQCBD46SF2nDJNXzX5rb+AkbVj5nzbm7PrJbMlS82yVa4jU3rTv63s7qyGkw+6t54RgrpwZ/DG/+4mXn7Ndpywp28ipNp1lf7ZSHKCBEFIdnUH9DrAXEfnPwEio00f/nn2m+b7Nd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Mon, 13 Apr 2026 20:13:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 20:13:12 +0000
Message-ID: <78b617a1-fe03-4d52-953c-29ce72143bc2@nvidia.com>
Date: Mon, 13 Apr 2026 23:13:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlx4: correct error reporting in
 mlx4_master_process_vhcr()
To: Alok Tiwari <alok.a.tiwari@oracle.com>, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260409092754.508880-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260409092754.508880-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: f15f9036-3362-4a93-13fe-08de99991661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	o+fk9pt0XNGBwH2nSsrFbLRs8ytFzU86xGlbwunjZAXcSYYkKeFY9pknWd3J6QD9kPPEFE7fcmx10nbweuxf+E1/C8luH+hmpUIdNljPb68p4CeJGoAwt3NTmlRDt7E57uN4H70sZCE1VsVMIw76N8oYsbBJOHmA8NzDp3VJQ3vg/r0GB+rI7tdFABKxCkDzZk7DRh4n8EfSi3Kzn/E6c/wUQKrOWsJvOCS4mTjf14D17mKeCtQv47GofwICI/WvE1cmDhL951lp0By/1ElJyRr8c6CeWcM5o0k8pKYj+UzbCXP3Ki2CaiJhWwfx1E+R+tnR3zTOucQV3yV7oHl/lJcVIVOkjOlPdcktOCoScMjDkTXJDZq7LuW52Vej6SpGxt/zoDPjrQejLBOyeUgVVTrwnGMTG41qZsh7KrMuRqDHpfEr5bLu0//mDGfv3e4edgLzoDCUgIWGqlpcJrGyPCPfGywxMuE97mHfFOpmuUpS0S2PApZQeNYKWs+9Q1rt9MSHIUdTP2LK3K1BONzseLPN7sCjQaCrYsVRJ6SdO93zhL/bZypJIxLinO3MPQ1uOm+BEfzQWlvPfSi8fSZHhcRObu0NQJJdZQ9KR3EsSy9wEOUG1JzUyorIQyKJlbu/xv5hoVq6T2SACSgxHvW84GZcAank8FyWekWlo81xgs0hROqLzm8DWOCfPJavbZmzAxZkafpnp9kjyoc/Xh+sLPTaprs5eQA0CFNznHzmfw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZitEcXNNVW9zdUhIQVJzdU1Wa1BCckdrc20reHBLVnc1UC9seDdvTllyWml1?=
 =?utf-8?B?NUJuNHE4ckpuWWdOcVlsZVBvL1dwRHVjUFZKUFVnZFMwTjdSZmVGK05RdlFi?=
 =?utf-8?B?aXM2cnZLM3hGUktoVHQ5SlMrUzEyeGF4THdnVEhoMURoVEE5K2lzaFp3RXJ1?=
 =?utf-8?B?WlliUmk3RWRZQXRCc2swV00ycnRjOG96My8xVnZzYlhNUGJjanRMZk1tbTc4?=
 =?utf-8?B?Q3pVYkxWRzVqS2ZCSjVYd1ZXd2pCdldJUUZtWWpLbU9vbG5tb2J6UEZQODBq?=
 =?utf-8?B?aklmZlVPZUJFMXdWUFB3Ymg3cHpFL2VpUlFVMXp4Y2xPVTZqWjRhUWwxblpH?=
 =?utf-8?B?NVRHN05Eelc0ZkFDeU1rRVk0dGlPclB3OUNNb1A0OHlPRTFBS1RCWnNCVUR0?=
 =?utf-8?B?OE8veTRaZEVJTFRnTnVEL0Z6ZGFPdGJndVVOb0FCTnQ5aWxRU2srekkvS1BL?=
 =?utf-8?B?dVprbHR2MnlZMUhtVy9hWDlYT3RsdUZrQ0tDVmpKaUtEelRxckFDK3RTY0xY?=
 =?utf-8?B?WHpIOUp3TVQ2cEZjdVFSVkQ0L3Y5bWlaK3FsejBvMW5COUFXTytiTEpBVWkx?=
 =?utf-8?B?VDhySXRYakoxUUY4N2ZDOHZiL1YzSVBwalVOUXFRQnYzNDZobEtWbytaa2hp?=
 =?utf-8?B?bHp6T0JLeVFLV1duRzhIVURubGE5TW5pQmJsWCtHV3lVM0lDK1VlK1RZN216?=
 =?utf-8?B?RWVTTDVWTngzcU5MUTJnZTZld2MyekVuTUw3a002TXNvMFpVM0NUeTg1MHEz?=
 =?utf-8?B?Rlh4ajI5ekphUXVnY2xGbk1rQlFrak9zVUgwdHc2bXJLaG9PbXlhVSs2YnYy?=
 =?utf-8?B?VjZCOWhxNzBUVTUwK2JEQnZ4UWErbm5qenkzUUUxdGU0Q0ZFcWxxMVZEWEJF?=
 =?utf-8?B?WnRDVkJVQ1ZQOW1JY2JuYkc1VzF0Qkh6UGlISVhaOEVnSTZlTVpzUUJhQUl2?=
 =?utf-8?B?MmZDc3BhVkxrRlEzamkycE9PdnRranVPWmtwSkNUOEpFanBBNUtTT1ZYeVBL?=
 =?utf-8?B?QnMwSHJnM0tza3J4Y0FlQTdjMGNFR3JabVpsYkJhTlpLNTNDQzdlWk1PbkZM?=
 =?utf-8?B?UWkwMFk1aTNnMjMzbWpPSXV5YW8wbFpwbi9lamE2cjZmNnN4Y3pzTFpRcFlE?=
 =?utf-8?B?aFR2VnJmZE85cjN4aCtFWmYwZmJMQVBpSy8rSUp4QjZRMytyZnE2dWcxeVVz?=
 =?utf-8?B?R0lRWnRWbHhZOVZVcGhDMHNDSE0yMWpxZ1l5bzJITWNHZ3dYcml1eEltUVMr?=
 =?utf-8?B?SWRZZnRiY2t2WGlEU3JYRGlPYXVmK3hmQ3hhNDd4NFA2R3NvOEJocktFMFlv?=
 =?utf-8?B?VnRzanRnZldBV0JpMjBUN3RsRVJaa0lQWnJzZFZmZlpJckRGMGZ3WVVBa1cv?=
 =?utf-8?B?bGpiMFVXaHU3UWVXQndmVDZ2eHBKVStUc01mSkgrWnRCcWFtN2tsM2s0SWhv?=
 =?utf-8?B?QU9OeGFUaHp4dVdSck5YazArUm9nNHRjcWhVS0V2V2ljdStFMFRVNE9xRm16?=
 =?utf-8?B?ZW5UdTE5dTdjSVB3MHErcDdjVlF6cTBYaVkzSURZcVkrMk1tUnY3MmlnNzlU?=
 =?utf-8?B?Z0xYVzdqSVlRRVU5b25MSVN3ajhtSjdvMGUwMGJHdGFCbnBMT2wrWS9lTk9k?=
 =?utf-8?B?anRXcFNqd25PVmhlNmJRaVB5cFlXNjA2OGZGT3dpMXhuZDlwSzNmUFluUVVH?=
 =?utf-8?B?b0pBUUFjdnVCM0VOeTBnMGYra3pxUnFNNUhBWi9vUW5NN3pIMzVnTUpDWFVs?=
 =?utf-8?B?SHhXWkJBL25yNTdZVkxZWUlackg3R2dzRDZRdndVUlVGU21CaVN6ZFhzUGJh?=
 =?utf-8?B?QllvS2ZSMjNQbzYyMWVmR29PdXVWTnBxaExkcWIwTmtoSkJmRGNUTC9RQ0xV?=
 =?utf-8?B?M0tFcmRGRXNjU1gvUWFxUWFnQzR2emtEQ2xJVXFqM25zTHdZeTJ1dG56ZXBj?=
 =?utf-8?B?YzhXdnhYYlNoSzM0S2ZReEFqQk5XMldoQWF4a3RETnM5ZU5ZMmNtdW1mT01V?=
 =?utf-8?B?RTJBT1JLc2JaOVdhaUZWK3JDSlRHc0tqOVNqYUl5Tmdib0sya2w3US9xdlFR?=
 =?utf-8?B?OHhMdExoU3BlY2JWbENHZHZjQURIeEpPVlNFMHJhTXpBVG1SdFdLeVhuRDlh?=
 =?utf-8?B?YmdMWVdtOGkybVc1bWJNRWt6NHp1U0JtaHlHbEJMNFBsV3QxL0xraXgxMzdq?=
 =?utf-8?B?eUVyVTZBOS9iOGJZdy9nMElHRDQ4ekVjQXZ5UVFxUGR2UlNpWUpHbDJmZmp3?=
 =?utf-8?B?bUQ0V0lOWnpjRDFRUUtHNzd6KzZrQjVuLy91TDQvSkVINDNCaGMzOXhUQVhM?=
 =?utf-8?B?YVg3YUdSQzJITTE1WkFrSFBGYlhMelJtRWlQUUlyeGl2SzY0QzExZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15f9036-3362-4a93-13fe-08de99991661
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:13:12.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLhuL/f8WP1qXlQdWHfSfnI7PG2GvkXzKAgLFtjzIm8E+YfFTyKhP3+8X5PlpzlLxwkT+oOTneAvtdPPRxTFaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278193-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 930273F3088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 12:27, Alok Tiwari wrote:
> mlx4_master_process_vhcr() logs vhcr->errno on failures, but this field
> is never populated by the PF path. As a result, all failures are reported
> with errno 0 and err print in status case which is misleading.
> 
> Use the actual return value (err) instead, translate it to FW status
> before logging, and report both values.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/cmd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> index de0193d82ec1..bdaf152e6712 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> @@ -1782,6 +1782,7 @@ static int mlx4_master_process_vhcr(struct mlx4_dev *dev, int slave,
>   	}
>   
>   	if (err) {
> +		vhcr_cmd->status = mlx4_errno_to_status(err);
>   		if (!(dev->persist->state & MLX4_DEVICE_STATE_INTERNAL_ERROR)) {
>   			if (vhcr->op == MLX4_CMD_ALLOC_RES &&
>   			    (vhcr->in_modifier & 0xff) == RES_COUNTER &&
> @@ -1791,9 +1792,8 @@ static int mlx4_master_process_vhcr(struct mlx4_dev *dev, int slave,
>   					 slave, err);
>   			else
>   				mlx4_warn(dev, "vhcr command:0x%x slave:%d failed with error:%d, status %d\n",
> -					  vhcr->op, slave, vhcr->errno, err);
> +					  vhcr->op, slave, err, vhcr_cmd->status);
>   		}
> -		vhcr_cmd->status = mlx4_errno_to_status(err);
>   		goto out_status;
>   	}
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

