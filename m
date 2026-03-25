Return-Path: <netdev+bounces-271600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DpEHhX5w2klvQQAu9opvQ
	(envelope-from <netdev+bounces-271600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:02:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FF327689
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC8D630C680D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611A3ED5CE;
	Wed, 25 Mar 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="isA/AW7w"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAD3ED5A1
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449767; cv=fail; b=Wfogy2Pb8vOk7kl2VmHKC3kQ9DJfd7+Qz/r4YOstv/dYM6e5fLs5pqnQeuPEDep3qCMGniEoM45OQPKeQ4/aNquzmd1ZdF0vrsHdtPQ1MrqSMb/zcFghMppxJIWwpwtH7JWb9I6bDS/gSjUNUM4dngYsJITzktYnVJiFUjYjYVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449767; c=relaxed/simple;
	bh=7k5zcw2vYSsd/rZr6iBzlB8ilDUsGJi4duX1OVaXxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQPo1bvsqBqLDH+Kt4lznY1UauKcyfxPiYXG8TYvJkX8PDx5/yw8bYepBu6WYaxIyx7Bzz86xT1gCtud22UibJAMBX3mpKFHjgniGQ6dgJkZhaSiTR4CjS1S1YPnWcSXrintN1eeQoVzDbCq8Jk3F/wTBovVOWX8JVHrxvQz2+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=isA/AW7w; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDB6MbKKgwOj2XaQV1BVgZ+zDPkTHc3/1CJawqQup9fJyHapbLtve21tqYHXRcwFUunnFhNATh1zbangwoVg7ZqU1ktTzkQ3xX+T8FvKaGFUflnw4zEgXo3tAADQI7PWtbb8/7mwLaENUEPzarA/EbACNNtePRqOPL8o7Xax4dT0rWc4c+Pfa34X8AdZwrPsfdgDrJQvupAHYwIieQm3KLx5vFPKkBWVyZqEozpasMyjoh+Y2E+eNbQVhVxYyWCiakAOo7rm4qHCWQEfT+QAorCPIv/IwKCduUUvZrovTWyk4XPm53dkQuvxfCPsU8hQzk9JPTuGUnsJAignCbxOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvYKTc7la2KFJh2hTAqa3jfwn0aeVZKA481ARHeoS90=;
 b=aYXKrOkNo4IK1I/aucNm8VIdTE8SljMy8vLVdOdi9kblVPBuTGUY9UNJ+A0eGZy92YLFC7KCvEXxkPYhMcf5au5pCqPGetaq4WU+kjSrSZUWFgOYy/zcnQ8B8ys96tlLsq8wqhJEKdJWHCdOnK5rSCrA6GRtdBYUNSV1pjMmFCilMpL4PW8v+HuRS9MYzFNWW1LQAHdfD2bNrg4ruAM+OGUsKLwLAWkvq42gSs3+dexcPvzi8FP6zJKaKjbiptgOwNW02XRle5dPjZbJjWgFiBCJGZdE6weq9em8hywJqF9wIQY0uG8NeHKKwTK2RJ4m4WVkgWWXhs9yOwoCwxGc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvYKTc7la2KFJh2hTAqa3jfwn0aeVZKA481ARHeoS90=;
 b=isA/AW7wh/OarLsnQPJJJjPDEplLVRIrC0WINEShjKfkz1Cq4+sNDqBAkdNMv+DqpWpM1mmW75tSZWqAI/BXJAfUSBz68n4U6TYgbRi3bdAVtJ2b46jLELO+3jmOjtVnXCvwHbx9r295LS97+NZDllSqe+oQZMcs3V49zkCJc6Zix6IouLsmC4zUFkSwWroDCEovFfGEhwf/TL7KCzHtBZPooxY1kxOtV8heD5qIMCrc1XralxOm197lMBuTTHNyCf103Lkvc9/0Z8f3H8324vSsIZF0YG2gIEVh32zTIKpOJFWjiRXAN6g/sHBi5mmDIhv6rUkiGfgNOZqkP2ObWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:42:39 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 14:42:38 +0000
Date: Wed, 25 Mar 2026 16:42:28 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, petrm@nvidia.com, lirongqing@baidu.com
Subject: Re: [PATCH net-next 3/3] vrf: Remove unnecessary synchronize_rcu()
 invocations
Message-ID: <20260325144228.GA686135@shredder>
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-4-idosch@nvidia.com>
 <CANn89iJ9hD3vBiViEz886sVwuqQVbaocnE0UJHZMhchFHKiM-w@mail.gmail.com>
 <1ea4c187-9c1f-4e15-b472-07a82abd3260@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ea4c187-9c1f-4e15-b472-07a82abd3260@kernel.org>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e53c7b-1a7c-4aef-e344-08de8a7cc25b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QWn8KzcwGE2330VNB8jgbKIUOQUPo09lK6KK+QsuA4PE5hkMcEhtgjcgPK0TsTHyT27LNkfowH1w7TNPAl9jo0kBEqO5QYdQgv3ua6eNfSUrMr1b8ZXaauMVvw7i9NAsH4DuhrrxC3PzP7/dOhYW5NNGyzelHhdX1CuqTk/XdazimKi7y9MiuzL3nTQHxJCREsX2jZWoU36EITUAiF2uZiUZ8kvl7X41LVgDoq5TL2ANT/2rIu21Nlw61MIc2wITEXUz1DZ8pFrXqk8DgMVxFkfA/iEmSxxp/HA2zQ4FMpQjQBTOtWEUGQptw8/9AnDaB0ZRIXafSjAkoKPdb2ihrDZXl+FF8AIfVpBH8M4rZ+U5L8sWGRAIXan5gshz7XP/VJ+C1BrMAUO83endWLvPFzJfwdfkTRnJlkvopfM0GqRx5qbte86Rf/yA5O4Ts/2VOaPg4MXldmXKOL9BaWcPiwD3F7msQUsgKtb8MCwJAYAaKSxW4rc9xRNDrEcB8I2ZWKhUqo8jDIXZZH3aNh22Ud27brc66HBUSxDYpn6WePsuD4mSsJcbfxf4rsdg2IepeYFcK3jzjOgbh8xtDrfLaLd+T/3+S38KkF7Aut/nyLLnBDHlKidPURdxUilH9QDnJgWIZIYDzRYcVcVRlr2jAGaUpkgRZrTWS8W1lkQEsJMnp8EbzQ0FEU0tuy5r7UOZwW9+VeLbIMmeZiWQZqoHTitpu+QedS+Vn3fNNNJFXic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVR5WUlkaGFPYzZtY1Z3SFhIZHpXdEg0c0NKaWtOUVY5K25rc3VobDVUVFo5?=
 =?utf-8?B?dVQ5MkdDMDJxVUp5ME94OWRTSG0xNnk3ZkRVRHN3RWNLWlRNUkwxVS82SHI4?=
 =?utf-8?B?eXVwaGF0a2RMeU9ZR0kyMmZlczBPSE8vY0R3eVRsVS9MSUR6OEl5c3U2NG1t?=
 =?utf-8?B?RFIwekJNekNNcmQwUFNDemQ4TndOTDRwNmdrbm9mbDlLM09OcFhDYzJ1UDRn?=
 =?utf-8?B?Z2RjMDdZeXN3dWoyc2dSNWlzMFJUZFVGTDFKeFJjVXVNZHV4NkRybXM5dzFm?=
 =?utf-8?B?ZGVoTXg5L3dubDlkbU16OElSajBRbDhBTEE3cSt6eWJ2Qi92eEg5N3gvSzA3?=
 =?utf-8?B?SGJONXE5UmFTQ2NJUVlyRzdjTTRtUi9oWHp0WDFNMjUzaFIxVnpYK2pMV2Y4?=
 =?utf-8?B?QVM3SXpid2xEMlZCZzlUU0VPQ0hheFM3bVVCQnB3Ykt1MlVDNTFtWmRoVjBS?=
 =?utf-8?B?TUh3bXZXVTlHT0VmK2VKSUJ2cU1qclFyRmNSVFpYMno1UEZtcW9na1dwam9i?=
 =?utf-8?B?YXgrZlArNVJySU1iSTZsR29KeDVwSTN2RnNWQUhMWnlmOVJiT2lWS1ZNTkk0?=
 =?utf-8?B?VjE2bHFmaHFFcWJsbWNYTmU3MDdxR21jeDNFbTc4VlRReVpxeldTOG9WbGhk?=
 =?utf-8?B?TGFRb1NTMjREdzdld0cvSW5qMWpiV3ZsODJ2S0hUb0NCa3pzeW1FTmlvdEx1?=
 =?utf-8?B?K2RnTVJXdHFkY1hETHkwN3hpYW5sb0ZGS2F2U1lhV2tJLy9Dd3NYU3RpSUE5?=
 =?utf-8?B?MmdicGF3WkRlMHFJUk52eW5NeVNjSENVU0NyS2FsVW9hVHpYRG5Ud0NlRVdF?=
 =?utf-8?B?TWZTY3diekc1WkpaM1ZNTDB1T3hybnBTbnVYTE9xOGxOMytja2FGME9NZ3pu?=
 =?utf-8?B?MG41M0I3UXg1eTdGYjRtQmNrZDhmRFdnSVZESXo0d1hidy9nNFVwb2lsUGNv?=
 =?utf-8?B?TCtucmtrU293YjQ1MWJMWCtYa0dOYTVDYTdZMmttbnl5SWdqMXNhQWI3bDVD?=
 =?utf-8?B?c0N1Q3FOUDdScjdXaW5Xb3VWY0t2b0VvVG5WRUFOMVFqZVlEVllCR2Q4SHpF?=
 =?utf-8?B?YkxqbmVXbU1HNDhvQWxRUnowenI2clVYZURRVkRKQWlqYy9SbHFHVjlxZjJ1?=
 =?utf-8?B?bUVnWk85NjFrMVRPTkdTYWkweVd0TWwwcVUwRDNFRHpQd2lnWmFkQ0JVYm94?=
 =?utf-8?B?OGRzcy9PZmEyU0FkN0JSSHRlT3EwUGllQktudVl5NUJ2QnREQzdrNmtGTDNN?=
 =?utf-8?B?MHcyOEFWV1JQQytPaTJYL3dvb1NsZDBMckxUaURUVWRtTVFuUk50eTZKczNP?=
 =?utf-8?B?bUV5ZkNudVQ5MlJUMWVUVWVBbDdWaWdzRndpWTFoZCtSMGxGSjl5QllhYnZO?=
 =?utf-8?B?RkEzczk0OXY5eFl0bS9YR2dTMWYwYVZ0dXI5Q3p1cnNjWFlrME96VVFIUy9V?=
 =?utf-8?B?ZWQ3YWh2eXJ3R0dSRk00ajNqeGh4OFhqenpIbStNUm03RVIzazZiVGEvN1lI?=
 =?utf-8?B?d0ExNEFnbWVSY3MvaGhZWVpyMkFXbXkxTWN4YlJzWThaK2pmb2tMMGlVd2J3?=
 =?utf-8?B?OGdFZ2Nyd2JjVS9LdlhqYy9EUnIzbEkyLzJQUzAyWFY3STlXTWlVUXFZQXRm?=
 =?utf-8?B?SnZqOWg3SHB1dW83VFRjNlg2K0ZBaEc2T1cyWFZEclY1dFBPdGJidlpNT1pu?=
 =?utf-8?B?c2RxQlVRRCtLZlNzQXR4QnRSSC9FRm5pcHRvNW9la0p3cHlZbXZJa2w3amxy?=
 =?utf-8?B?TERMQWc4a2UwbDZRaFFDVXpNSHBiZ3ozczd2MmIzMkVZSTVNSDFUUjM5VzQx?=
 =?utf-8?B?djRLNVY4UFZxODhJK0xhWVpSWlk0N01HY0t3cy9xWEUzbDBvUkFFaTlUY1VE?=
 =?utf-8?B?UDhwTTE1M0ZYdE9DRHVHRWZKdFFZS3F2TXRublVKSzFPQzdlVjlJYm9BN0Y2?=
 =?utf-8?B?RmdSQUNyekNPV0N1bGs4VURCRElhRDBwUUFZTlBQZmxKbjEvVXR1M3lNam00?=
 =?utf-8?B?ZEp0WExIWlphN0xhQU1qNDRGZVM4UHI3dURpc0gzSDhlTEM1RmdaUVJtT3dn?=
 =?utf-8?B?Tk5GYlk0VXNKZFNWZ002QWtPeG1FeUsrMW9oYklLRXpMMU52MWZPelMwSFQ2?=
 =?utf-8?B?NlR5QnFRQTQ0U0hPaHNhaENybGtMM1UzWXdVZTV2OW1ET016L3BGZS9sZUZy?=
 =?utf-8?B?MldnODJFd3hXZ0thdWcvSXhscEU2UDZJcmYwSWcxRThhZGFDTEZjTExxOGVn?=
 =?utf-8?B?eUxFanNZWDNDTHRaN1drR2Z1KzZSRC9KTjVuVytvWmwxdTdibk12aFpvOCt5?=
 =?utf-8?B?MjVnUXZvVlJyYmpnZ0loRjBHQmhPWHlYOGxZUEI3QzJFcjZHMWJkUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e53c7b-1a7c-4aef-e344-08de8a7cc25b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:42:38.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSv3OptiZqzzBJYqgMcWLNPz1dPT/fWcCIHpDE8qA+fSjEgW8qVTx006pyaz4OdX5PhC30dYXIG1WQ4NoDRF5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271600-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: CF7FF327689
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:17:30AM -0600, David Ahern wrote:
> On 3/24/26 2:39 PM, Eric Dumazet wrote:
> > On Tue, Mar 24, 2026 at 8:56 AM Ido Schimmel <idosch@nvidia.com> wrote:
> >>
> >> vrf_rtable_release() and vrf_rt6_release() are called as part of the VRF
> >> device's ndo_uninit() callback. As such, an RCU grace period passes
> >> between the removal of the VRF slaves and the closing of the VRF device
> >> until these functions are invoked.
> >>
> >> Therefore, it should not be possible for any concurrent RCU readers to
> >> try and acquire a reference on the dst entry while we are potentially
> >> releasing the last reference via dst_release().
> >>
> >> Given the above, the synchronize_rcu() invocations in these functions
> >> seem unnecessary and only add unnecessary delay when deleting VRF
> >> devices. Remove them.
> >>
> >> Reviewed-by: Petr Machata <petrm@nvidia.com>
> >> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> >> ---
> >>  drivers/net/vrf.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> >> index bfc9ea91ac20..75edb8eba87f 100644
> >> --- a/drivers/net/vrf.c
> >> +++ b/drivers/net/vrf.c
> >> @@ -753,7 +753,6 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
> >>         struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
> >>
> >>         RCU_INIT_POINTER(vrf->rt6, NULL);
> > 
> > We could argue that the vrf->rt6 clearing is not needed,
> > or should be done before the RCU grace period mentioned in the
> > changelog started ?
> > 
> 
> AIUI Ido's point is that the synchronize_net() in
> unregister_netdevice_many_notify() occurs before the ndo_uninit call
> making the synchronize_rcu here unnecessary. There is also a second
> synchronize_net after it.
> 
> I get your point about skipping the clearing the poiniters.

We can probably remove more code than just the synchronize_rcu() calls.
Looking into that right now.

