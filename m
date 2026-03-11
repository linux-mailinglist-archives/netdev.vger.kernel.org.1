Return-Path: <netdev+bounces-266677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EICTJwCKsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:28:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E0D266812
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69E1C303D133
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B23CCFB2;
	Wed, 11 Mar 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmByQsAg"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7730E837
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242790; cv=fail; b=b+HfF2+DnNxqMXekAmh5Pl1gdeKglHh0fh864Ez2p3hhYlipXVUHoFqFypIi9klJZMGPuqUjC/hKYzPz7ihMg9f0qwdieL1YHeFeT9+vfVSZ3F7c9qEGjJ7XX7siO472yCx2Rm6JmVlC2Z4hR20NClfkjzBthUldNIpGcShSKuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242790; c=relaxed/simple;
	bh=H8JBVHNUX6SvEZCvLAUlsOagEoTy0cC+7pICYG0bptg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRbQjyY+KhxCvLQ7vM/6M0N8fM1ir0ty2FQw20Zx2zXToUsLwckLLLiupvvZGucBn323J0+c8dUaLvNuGX83ulV/ksHBv9cjrtdtPrgUMJs47dDY8wIszxFSvGJx/pz1abKIoccPvvIFYwP/wjeYeHcM4vGrG+Za4EXT6CY67eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gmByQsAg; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhUkn5Pd0WXCK1vnPH02BE8kGqPdLlZwzYnODO7yrRCmI38g+XXf4HOjAJDgm3paUkfZFpf2Brpf8zecXchz5qpoX2/FEIrE3tUdr938KFGZ9mOixI9HUWGPZlQ91O3tMIpgurgJ3+RihQJ/x894+9c3vDpOL2q83Vzh8CAxHfO+ARVURsEgFYcwXNBFnS5AFxuxRAzL8xhodVTwLiK7lW+ums+9U2M3mAgo/WP0y+cXuxPSqjI/TtXFlwp+WmJ7a/pPiyzkV43EOB5WEaUkAx6YUjmljdKGip6e+yZZ4QAFpvtVqeNreRJfcvfPjvES9qpRkgfMoQ7aY7VKppV5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxaSnL37mMnAVlglf9Og5ae0GZBMbZ36OWG6AE6/caI=;
 b=QgwlSSayvNgzDJ3Goz1S71//JHIIdYzlU+Qy77eElgiYoQxkUEdS1cUUJKss/Mv4uCQr5wNK9A8Rcl5E0IL1d4iyEwAvUxlddBnEY/7+qMaDgzMbLSLVbzrsD40tWC+nCyRB3hIe+79Ufgu2ChSYNvCny00IBqPaZqIo9M323KoqkFh3cgxCWbjIbTow6Z5DccdRcAwuLNU4cAOCB9qflN3vHXCreWIM6kMDR2rpgm3IWfewuVl5rCA2LQQAEegLcWl86Y65EDc7DbGdHWPD2c5OSTQPwMdWoaiYuoCVtyiBJU2PCvhehMH3fWwdLuz7kzGfp746xpCO9/EbOsJO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxaSnL37mMnAVlglf9Og5ae0GZBMbZ36OWG6AE6/caI=;
 b=gmByQsAgo4yG1zYuOqFUauC5FiRypyZYv+7gXIxUlcW1xDGBA9IpObTs/7h3bsFyqWYW9++4xKGVjge3wIIQAVpgyJ/nkg+I8KtH1E2qfsrwGL1WPkqfugdBdH1KPzhcMjjPJl6AebQiCLWspskMIyuMuB22iPGmGQvzwv+YsDFqH+fzRXkwxEgUPqH4yF/8LK7ag9A3RIUMt6Mw4wTAfMYouVIU38MjbuTql2whgr15LQi0297/AfEOYjDlwY4jRiELJoPDTB5/OPh5NMbAbJE82y0fmgwb6H8UaIY9+tt7QS6ebksDJcHnspXoHde8nLMbLglWoMQUf4g3Sj2Pzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:26:25 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Wed, 11 Mar 2026
 15:26:25 +0000
Date: Wed, 11 Mar 2026 17:26:13 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, lirongqing@baidu.com
Cc: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH][net-next] net: vrf: switch to synchronize_net() when
 releasing routes
Message-ID: <20260311152613.GA2441293@shredder>
References: <20260310105331.2371-1-lirongqing@baidu.com>
 <20260311131935.GA2415888@shredder>
 <CANn89i+PK6N0VJPQ_NtvHFizpnnrWb9AOPz=M0WyzsQGogsUpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+PK6N0VJPQ_NtvHFizpnnrWb9AOPz=M0WyzsQGogsUpQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e0b812-65b7-431b-0675-08de7f828ec1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ne5PL3gUraYSlbkyWw9zQypn/p7CR075hru8m3ybZRrQkGTaQJkbQJ+/pMdY1R87UC8Uy6k1bl6mSBvzLxfw88wRrObDj9OGgkVod6fQw1AMk+XLbdOUR1TuYaYbGfonk1aH3+kxo+PYUz8zf2almGWPu20hLGp2LtwCbCqNehmwZv9qaF00jAx5qa+7XsqS2UXvkxe6CQTSOBFUyMZXSKC2W6CC2+rX+cl6U5Sn2iUlOMgZdmlYxexrCP9U2txNAHTUrENL+pVcGvdNbEF6UqA/0g1logcVX0b1VuP+FqR1GyJgk8xYchEV+1GTR6kjvXDQ49ySBQLWSvQLuTUrY6sIyqPqTxTRhYx20iP4krdhVBkLwt7kSWzrZMTj88A56ajrbydActNXeBvRhWlfPfcKowXmgR7MlTjczxIpIGDtyhIrZHig+zal/UyQ/3QeHKmy+Ckel/f+znx44LbjKIgVbnpfAkA3nHKrFxmm5H5jxVAFhwzGX48HeWEzJAdXLcTf1LLk7+z7LLdVRuphpnBj5au2KOTxJho9jQpVdHfAcoaDUd8EjuYJP57jwL8avCR/KY6I1p64S1dEebZjlANK7+h1MyRiqru99jYbCaNReuY2pq9UARpYyz9urpYeesrbbSpGCG7o8NxkNOx7ZGqEHWubCUz7DdyjPeXImTocqs95JGO1UBt77elY3dIAsPoXYHP2aTGY0Tujf06efUQlTqq893/eq6nujGx9bBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFRlc0IzWlNTOVNidDkzdFNIOVZVUmJCSjY4M0c1SitNaGlIb3hWcFJIUE0w?=
 =?utf-8?B?UUJ1TEQzMVRFbm96OVNLOHRoWm5yWUxzWXRHUE5WR2JmSnJaeW0vM1IxSjk0?=
 =?utf-8?B?TFhsMHQ1eENTSDVYT3ZHdEJGOVVzd3dPcG4xV0R5Q1ZWSFVvY3JHeFBFOTlI?=
 =?utf-8?B?TWhnREpNWGlLR1k0NWhZYnd1TFFxQjhzSjRYYUZoa29Oc2owZzhCd0xjejZK?=
 =?utf-8?B?MjcvK0tpdDVzWUNsbTM0cUhGaVhOS1h1aDIrTkF6d2ZHWkdDNTNiekRoMUlp?=
 =?utf-8?B?eU9JTDVRTW5VVm9lYTJWV0w0OW9ubDhlUHRhUUtjUUhxR2c3VStNem4vVTl5?=
 =?utf-8?B?Zi9mWnNnNnVSOHIyNjVGaVZwUDBJQWFlRlZGQ043ZjAvUG8vaWpIWGVSMmVE?=
 =?utf-8?B?eXI5Uno3Q2l1VFRrd1RvUzJhOFp0UzZNdW1NemxNZ1JZcEdFTExyZGFWMkph?=
 =?utf-8?B?cDA0Y1F5NzJoam4wNlhVN0VzZlA5OG5hSDFmNUtFQ1pwaTc2R25GcnJZK1RU?=
 =?utf-8?B?dEhpcitWZThvWDNpbEpkKytEQzM3ay9PL0U1anJwRUwxTmFXQXgwQ0ttby9L?=
 =?utf-8?B?clVzaDQyS0loU0ZnNE9lQ1JKOU9CSzd2eHJ0WVRYTzdHVnBaNUVWcDhubzF4?=
 =?utf-8?B?VXhQR1FLditORXJ6cU5GZmF2OExxV1NVQ2RxVDhoUHpiQlR2Ukp6eDlLZExr?=
 =?utf-8?B?ZmhQZ251bjllRk4zakcxcjNyYWs0TVQ5bDlYN3dNNGYwWUg2NHpydlVKTDEx?=
 =?utf-8?B?cVFkbHVqeUZUdjNKeit5djhzWWdSTS9LSitvZFFNaG9Ga25yUSs1QzBYWWlV?=
 =?utf-8?B?d1h1aXlXc3E0QzF4SlZKYUp6cTNyNDM2ZlhMZWZJUjJVTFZJdmlmYmVDWENC?=
 =?utf-8?B?VTRvMHRwdGNVM0pGMkRReld5dnZKMVRxM0x6emFieTNtMldURlhyYWNWRHhW?=
 =?utf-8?B?ZndPR2hWbWtPektNWituM0hBbHVaek9OUGdiUWdCL3VnSTNNQXZ3MjBRUnp1?=
 =?utf-8?B?ckU2ZmR4SXBhR3J5aGtBdUtIRml0WW5GeGZDRVNoSXhmNHpqU0dkZVlyVGFC?=
 =?utf-8?B?VTk3T1IxUzdsSlM5a1k5M3RNTGNuVzlGMGhBN3JXdmNvQVZzZktiTEVIVnc4?=
 =?utf-8?B?RUtGMW1BQStXWG9yRFp0WWtpalhObVA3a1FqRnFaZzJSWHlNdC9IcFlRWUEy?=
 =?utf-8?B?RGF2bDBGbHh3QjR3RXVLU3BQMmN1Y1pUNS9ZVm9xS1Q0VlUrd0R2cW9vaUlV?=
 =?utf-8?B?YThPRGp2K0ZNTmpSNUYyWWxYdDV5T0swd1JhTVJFOWNXcWxBOFIxTCtTVnNZ?=
 =?utf-8?B?cERlUDREbmx0a1JpUHJRKzN3U0tFYXhEaEVBcmdsYWJvOXpHRTEyVE0zSXNk?=
 =?utf-8?B?bFNyeXRrMXBsNHkwZWgzV1Fna2pOdUNXTnUrUHFQeVF3amtWZWlXYitxYVdn?=
 =?utf-8?B?dERYSHBrTGRQWWk2VWR2VlVJVzloU3dGbThaaXJ3VjgwbURFK3pVd3RtcDJu?=
 =?utf-8?B?V3hBU0FPbFpFcHdvZXU3dU55RlIyOGt6YUVDREpTckIzV0N1alp6dXU0WHZH?=
 =?utf-8?B?R0FTRXpUNGE0dE80b2VFMm14YUtuUW01UzRjN2FCUzh1QXZGQ080MDVKc2dv?=
 =?utf-8?B?RkN1TGJ1RVl1SGhDdnJKQURjVFp4QUJEczY4cVRQc2dac0RJcDlwSGdWTDNF?=
 =?utf-8?B?RzRkaExHVm5vajdhSnlJcEhUOHRuUitFYUp3cDl6UmJITXRhV0Z3WUxGbUFU?=
 =?utf-8?B?TnRHSW1pcXhFVS93RnI5QlpCMlV4NzRoVkxQeUc3b2hXbitINE9OUU5NYnVm?=
 =?utf-8?B?ODlzT3h6OTU4VlNqQWhTenp5cjgreXNqSG4yNE1QNHNDZjhPaEdvdDZxUnV5?=
 =?utf-8?B?aVhGY0FiUFBUeVZVUWFRS2svRFh6eTVUNEVON3NHeTEzeDR4dU5NVm1LWnBi?=
 =?utf-8?B?VllqeTVxVHJUU0tPSWlBYld1TGxyMjBrUWdqdFRkNWwxYlc0NkhOQ0RUa2xh?=
 =?utf-8?B?L1ZyYWtnVFovRUhUZ0ZIT1FSOHdzWE5qYjlsR1pMSHgwMkhsT1FUNWh6V3pU?=
 =?utf-8?B?ejlDZGlkQzR6TE1UUkRKZnc5c01iVkU4V1BUUmNtcGFBZjZObitxK3JhajBI?=
 =?utf-8?B?RVlNOFVvYXJvbzYvY0xoZ2hEdktLUjdjbmxQSzZRK3AwRzZFa25ON29hbDJC?=
 =?utf-8?B?K2F1R1RwZ3FEeWVYVVdSTC9Gdll1aGU1bHVMK1p5LzUzT3Y0TWdaSHFINERS?=
 =?utf-8?B?OGNvZmpGTy9FUVZTVkU1L0FVRldsYTdTUFZnUlM3cDcyU0NhQi9EN3owaXFK?=
 =?utf-8?B?aDhHdy81N3FTVWdhQzlvNzltN3FwNEszSzJDUi9wb3hlR0U1YXJ3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e0b812-65b7-431b-0675-08de7f828ec1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:26:25.2791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpIzMLzmOJ6NVm7tnfEA1BqrjMLX4xELqBN3mXAaoLjGQi3ysN8nYX4YtBoDSMKsx6UgZ6CvR8rQ0nyAitxskg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266677-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 56E0D266812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 02:26:57PM +0100, Eric Dumazet wrote:
> On Wed, Mar 11, 2026 at 2:19 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 06:53:31AM -0400, lirongqing wrote:
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > Replace synchronize_rcu() with synchronize_net() in vrf_rtable_release()
> > > and vrf_rt6_release().
> > >
> > > synchronize_net() is RTNL-aware and can use the more efficient
> > > synchronize_rcu_expedited() when the RTNL lock is held, avoiding
> > > potentially long wait times for a standard RCU grace period.
> > >
> > > Since these release functions are called during device teardown where
> > > the RTNL lock is typically held, this change reduces the time spent
> > > in RTNL critical sections and speeds up VRF device deletion.
> > >
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  drivers/net/vrf.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > > index 8c009bc..92a0f4b 100644
> > > --- a/drivers/net/vrf.c
> > > +++ b/drivers/net/vrf.c
> > > @@ -755,7 +755,7 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
> > >       struct dst_entry *dst;
> > >
> > >       RCU_INIT_POINTER(vrf->rt6, NULL);
> > > -     synchronize_rcu();
> > > +     synchronize_net();
> >
> > I might be missing something, but why do we need synchronize_rcu() here?
> > The code below calls dst_release() which will only free the dst entry
> > after an RCU grace period (assuming we dropped the last reference).
> 
> Agreed, this could/should have been removed after
> 
> commit 4f04256c983a4f115417d2009b44dcb7d70a6375
> Author: David Ahern <dsahern@gmail.com>
> Date:   Fri Aug 11 17:11:14 2017 -0700
> 
>     net: vrf: Drop local rtable and rt6_info
> 
>     The VRF cached rtable and rt6_info for local traffic are no longer
>     needed and actually prevent local traffic through enslaved devices.
>     Remove them.
> 
> 
> 
> >
> > Also, I think that instead of using net->loopback_dev the code can be
> > converted to use dst_dev_put() before dst_release().
> >
> 
> Maybe in a separate patch ;)

Yes, separate patch. Another thing that can be simplified in this area
is the NULL check in vrf_rtable_release(). I don't see how that can
happen. It is necessary in the case of vrf_rt6_release() due to
'ipv6.disable=1'.

Li RongQing, can you take care of these changes?

1. Remove NULL check in vrf_rtable_release().

2. Convert vrf_rtable_release() and vrf_rt6_release() to use
dst_dev_put() before dst_release(), instead of using
'net->loopback_dev'.

3. Remove synchronize_rcu() from both vrf_rtable_release() and
vrf_rt6_release().

Thanks

