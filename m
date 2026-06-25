Return-Path: <netdev+bounces-301992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kgJPB2ZEPWoh0ggAu9opvQ
	(envelope-from <netdev+bounces-301992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 657ED6C6F0F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uclouvain.be header.s=selector1 header.b=X3csyrHB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301992-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301992-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=uclouvain.be;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8DFE3023DD0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C2F39281F;
	Thu, 25 Jun 2026 15:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023139.outbound.protection.outlook.com [52.101.83.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228292E7394
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:07:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400071; cv=fail; b=Xn+7zM6FuE8KN/8ptWGbGcu8rA/fv5p4HuWBOYAwfUtTzUgkDdYFXS60/2Hj3maQTmFOi4sdUCojZcvycSEzjAAQoooKpSpI8rkhtf9MRJG+oC6G5a/FYdZGIn4cz0fsQHXT8fJcRgJ8vUq4MX0moP22prOljaxoXL87yZvC8Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400071; c=relaxed/simple;
	bh=XG2mckQjASRolrrlamGVP6YOzni4oy1B1GIg3OpJmJg=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=NIQZXiFKhYbVbxFY9D0JPaCL7Y8RPYF2IyGyow5pr5ZLkrh+18zv3/0jTyZcvV6VyXmnQ2gUi7/WcWtVNxdX9rq0nx2eFHM9BlDQRLKknNsoH9C6e1GDhTBDd0b/thw0X0/UlphE49oKKu09xdnv8BP+JztRrIox1IdFXBUVkV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=X3csyrHB; arc=fail smtp.client-ip=52.101.83.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwPoiBL0EstwLSYH40A38ugtXd/KvzxBsesqGjXu5Ov/IkMuuo/bxe8Z5gi2KhrpZt9s5naCCILHqpw1nF5YdVHtsqDsEn2PXmze60nKV/ffkMPn0nD1N9oJKTsZZVQukpbZVXD38Ak8MH80nAvlaM3LXI5ROpKE9eiu1VdeaW7fokN3fO+rhlmEibh7K2t7i1zvTQSnBJE3URIxlNQFYaeHa6Wn4/gYkKJX/41nWnBYzJWouCn3hYe7oLFgwqegGf+w4jK6bhkq6No9fEzPtho6pIHskX6HBPxOVoHJ7ITAi+YId1cBPl1UcosoOPoTIYOiQQVVt9/YslrxIPzePQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpND3ahC3nX4HxXhaiIBXvo5MEGnzuqfzZGNFBvYM5A=;
 b=WTBOjsUOlC4cVgSIlrLLgoTwWp+UAxk56H1/VlvSbWoOEYdcu+NBkdlfosZxsD8f82vkh4HFVlwpyAOHyigH7MJxvtamTaE+Pb6tdZkcdcl8pxmQaAXpTU5etvXeqpc9kVgi6KLKSw5wj7qs2xX049ZI0BXlFz0uMdSrQgx2GFM34AyGEEg98qObrtEq0sPSV5ZjELpVGFj4XF4nVWvn3fSsVI61S9dwnm8EgD+0843JqMJn91FzK1qg6b3n0YW1JC1RZkmkJ1lrVJeiZLKts4cuUbeX3REzSr5qR0YGLUfcS7ELZjtYIbE0Ksgajmos86EtkqwAHx+BM3JF6EjnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpND3ahC3nX4HxXhaiIBXvo5MEGnzuqfzZGNFBvYM5A=;
 b=X3csyrHBFumYgqZWfhEebNvsnNA7zCgcTVc68SB5SLroP/a9sT76RCccpLcIsL6qzaMiwEFX0aH7lXwiaG2IrcnzlDk+/owpYHcGaQrwXSkpyKUdBfqZINHUmFvxvMFGlIBRYwfcAAEDBnYJfIjp/IPTBsGJmJhFGiJoupRoCJclIiLKU1+ALzzDvWbmOn7iOCfNNK6cOXrKsWj+4YRelOq3QW1aHIw1kluWmOP7WJDdKrkBl/1o54PObg5ui6NtQZCNCZ3YOv8IXxdE+Uv1aqVV2CzC7zoMTZgjIcQNscCt+PUQww3acF403ek8MAMUVP82IdSVJxESwZORXDpwEA==
Received: from DU7PR03MB10969.eurprd03.prod.outlook.com (2603:10a6:10:5b2::20)
 by AM9PR03MB7489.eurprd03.prod.outlook.com (2603:10a6:20b:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 15:07:44 +0000
Received: from DU7PR03MB10969.eurprd03.prod.outlook.com
 ([fe80::75fe:525a:1f14:22cc]) by DU7PR03MB10969.eurprd03.prod.outlook.com
 ([fe80::75fe:525a:1f14:22cc%7]) with mapi id 15.21.0139.009; Thu, 25 Jun 2026
 15:07:44 +0000
Message-ID: <036a0c95-f5d4-46ab-88e7-1eab567d7a84@uclouvain.be>
Date: Thu, 25 Jun 2026 17:07:41 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Anthony Doeraene <anthony.doeraene@uclouvain.be>
Subject: [Regression] Broken MPLS routes with multiple nexthops
To: davem@davemloft.net
Cc: kuniyu@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::29) To DU7PR03MB10969.eurprd03.prod.outlook.com
 (2603:10a6:10:5b2::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR03MB10969:EE_|AM9PR03MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 68429750-0f11-4ad0-8bdb-08ded2cb823c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|786006|1800799024|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ffdw8uIKPczrV/wolt/UXNMWbadcfmA9+WK5AnfL4DCpZCR+mZzuj5svRyYtnPqQOlWWz5TKyWt7JMaxz9B/BUKi1B1gUZXtwV9V1LkEyqrIzn3vI+cDG1TQXor2m3kOpCQyAL+KIg6Kb9kEuN7GFDicQpKYKLcdOtyoL68rEzsTtTfovPmNimuCohsAN4/pILIoCaFW9PYubJH9bDrDFcjAwH4IrqRR7HUbf9p9LEVzmC5/Z6k0U5BoygTJSJ3Hrv7N62UpX8an6D3l557xjBoa2EnLrdNFvtuOrpvJEZX9SWxT/7pwaL12AUGjZqbV2vgDGMwnpeVUY0gVqtjrZi2vOv1GgkmnotujOBQluRkLYTlo3kVXpSFvT63F2bkoKZrNhhANMM1xxGCLWzzfcSVxjz7/8mRBsS+CKO37b0/S7xw+nRbW383F6kFlKkYTYFJuZ7p4w5SfGeFpnJUc5d76g0WhiIi/eAY5knlBas3p5XiLKJUiGuzG/KM/PNw1NPjNYRkDTePgyK6rw8yhmBlX+n4lbMom0lop3CXxV9ra53ADf+b19oLQCF6uXIjeYPrM63rsi7ziadNXc2sq99QtmW3wbFGtlVE1Lew0agrdcW9TLw7LVFFKD7NLIafhms7OiuAnYNt321QegoRQR/WVzlmy9oi8x2AuCXItQEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR03MB10969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(786006)(1800799024)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjhmVTMydUUxZ0JIV0Nlbnh2WGgxRHA4RXJNQW9BS2g1SUtZeXZYRFFuYU9I?=
 =?utf-8?B?Z2d6R1hEWkg3ZGNOMHFBUldiUzRpY0JuNmRyb0dUOXpNUnFLeEN0RVpZckY2?=
 =?utf-8?B?QnpXZ0VxOEJqYi9jRlhiMzNib1RMSVRYeStWVG9qb3ExdUVXWS9sc3RnaVlm?=
 =?utf-8?B?RDNUL0RZOVZ2NTNicjBNOFdwb2ZLN0drbG42VUNlZ3YvZDNmdlFQcVVKZVhu?=
 =?utf-8?B?UHBtZndYTmZLUlFtNWZKa3NKNUZRMnV5MDFTcWN6aVBSOUEyZDVnWVNQeUln?=
 =?utf-8?B?V21WRnFMUWFFd0dXRHFIZUFoR1NXUWJUUHUwNXV1U2VwYlJGT3R0d0taNnYz?=
 =?utf-8?B?K2doMUpQbzRKZEkzS0V2aVh4QTBPUXJJdlFuYTlhdEk3OWVWTXY4bXA2cmhq?=
 =?utf-8?B?bitQNWJOd1BnejhoTUNscnhndUlkeng2b2haaHB1RkhUY3JFKzIxL0oxdm0v?=
 =?utf-8?B?dFJiTTl4YmhJUTVkSHA2TGJGSHIwN1dseFZSRCtrMHR3Y1lreG90VmIzQXZF?=
 =?utf-8?B?T1MxeThyaFBENnl2MTR1eU9jMWc4ZitWRVIvOUlPY1ArcWxONHV5MkdkSS9U?=
 =?utf-8?B?ZHp0Wk9jV2Y1RmlNSHBKSU1JRlB4ZmRHcVVSSzliR0pWUkdVb1FHUWJNblVE?=
 =?utf-8?B?azltSmhuTFRrNVYrMkJ3aVczeDZJSVJJMXZoUVR1bWZIaEJiL3BES0dNeThw?=
 =?utf-8?B?YWdKNmFjWURYM3pSVGJlM0dmV29zR0dwSTFYenF6dHJHSkFmWFArMUVMbHRY?=
 =?utf-8?B?VkI2TW1jWmxTS25zMHUyV2cxTTlDZUErWTFuY3pJOUp0cC9mMWNDZHd1TGZW?=
 =?utf-8?B?Y0VZUUJvZytzVTVSSFl2ZW0yZ1d1OGdkZ0N6bi9BVDVOMElsN3hDcCtkOEpB?=
 =?utf-8?B?Qmx1aStnNXFaMmdaRkFrS0g3Q2J3V3IvWFdHNGtYdnFBb05xVkNuZW5xKzdh?=
 =?utf-8?B?RHBDc3VtQ1QwRS9lczRQL0NEaDFXa0F6VzBDZVk3STMvTXh0QndsU2ZmWlRZ?=
 =?utf-8?B?dG5aYUJrRTlzWkREeGJZNjdaZ3dvQ01LR2xqSmdIekZzUUUxYTdTWUdGVkRW?=
 =?utf-8?B?OGFpTU5ZSDN1cVJsWjlKTDEwR1hlU24zQXJ4Qml1Yjk3ZEM3MzdPaW14Y1Zh?=
 =?utf-8?B?QXNta2tsbTBOaTFLNEpXUWJJZkRDZWQvYlhXeXFROTdJT0FsKythZjlRcGsz?=
 =?utf-8?B?THpGVVc0VnBoaWwwYkhFam9pYTdNZlBQOHBSYTJPTzlZbitUcm1YRVREUEx2?=
 =?utf-8?B?YVJYcVZBR3NvTzRNTy8ybUtBZEVxOHU3RjJjNnliK1gwTW5XcWQ3RVhxM1Rq?=
 =?utf-8?B?SWxFSURjZ3VhUmsyMWtmWWlCdFp2RmM0MzZoK2Zvcm5Gb2pQL3Q3OEVJV2k5?=
 =?utf-8?B?eWN0ZElXanRsZVo3ejFqajJ6dDI1Tyt6cStnbXBiblNYVk5ocFh0VUpKWExZ?=
 =?utf-8?B?aVRJdnZWSklBK2hYSXFCNlhMQ2hnbWFhSFhleHFHams1dnBsNHA2Qjh6Vk02?=
 =?utf-8?B?VnBxRHIvdDZpMGtqMWhVZ0tHb042NU5VekNzK1NzZGRpOEM5MiswTnkxcno3?=
 =?utf-8?B?T1djSHVaVXdHSkZZZWRpczRRcVJCYXN1KzJ6TzFoWHdzYWpwcWxiR1M0eUMz?=
 =?utf-8?B?Ym5nOVVjMWwyTlltdFkxeWE0UDNMTEMwdmlETkt4aCtYeG96NUc0bzZCTEFp?=
 =?utf-8?B?ZjJpeXJnM0Z4VXovb2hTcFVBU21UZW9MRm5KNUZOalhwaU5GYU1TVG5iSnhm?=
 =?utf-8?B?MHIwblZPLzBtbXcwdE5SNFBMS2VBZE8wZ3lvOUpmSTNXUmJHZDE1Y2JIYWpK?=
 =?utf-8?B?QzM4ejk4RENFYTBJOVpaYzZ0L2lPZllXenRJUjhLNHBlbWV4NmJJT055VmVY?=
 =?utf-8?B?ZEFrRjhJbmtUQTdheDdsOW8rMUwyTHA1NjlPTTdnVGRTQkFQSUNGcENRb29m?=
 =?utf-8?B?Tm96MGRiTnk5NiswOGxiR25haFVXZk5wQ0FzVlhIcnIwZ0p6Q2pIUmo1Tkda?=
 =?utf-8?B?MGFObEZNNXlBY0JMYTdXZmVJUHdDWGRPOXNNM1NQcjJmeFBCMDVydWJ0Nm8z?=
 =?utf-8?B?aS9tVUYwUmwxVm9GTEdtampHNUNaRzhubXpZN0lKZnNRcnY4R1pEcVNGRUlZ?=
 =?utf-8?B?TkNDRFpJdW9VK01hbk92UjVoeEZxcXM0c2k4MVlaNTZic05FbFV2Nko5U3BP?=
 =?utf-8?B?YVorQUdTYkJUbGRHVjlmeDJCZWFmSWxUQWFWaGZsOUNzMXpwVjhTY3g1V0VE?=
 =?utf-8?B?Q21ZbWduSFhSQUdHVy9reTY3TUxPYzBac2xIR09TYjNUS1plT3BXemZZYmJw?=
 =?utf-8?B?RStuSXVSSzV3SnVDUkJLYXdabjdlcWRGL2FRYk9qTG80ZG5nbTIzL1FFc0lh?=
 =?utf-8?Q?U5elkQlNWEFcrVDg=3D?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 68429750-0f11-4ad0-8bdb-08ded2cb823c
X-MS-Exchange-CrossTenant-AuthSource: DU7PR03MB10969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:07:44.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9AKY4u7zGK/B0HfhDFEiogwoZUbB4UobJe2sJyedY5+tsPFfqkFNZSPbApyJJhEYptKpoOI9kvlg4yDGTKMjIrJfJXCcVom8MpYUuwpaRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7489
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[uclouvain.be,quarantine];
	R_DKIM_ALLOW(-0.20)[uclouvain.be:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301992-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuniyu@google.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[anthony.doeraene@uclouvain.be,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[uclouvain.be:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.doeraene@uclouvain.be,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uclouvain.be:dkim,uclouvain.be:mid,uclouvain.be:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 657ED6C6F0F

Hello all,

According to my experiments, it seems that ECMP with MPLS (i.e. an MPLS 
route with multiple
nexthops) is broken on the master branch of the kernel.

Indeed, whenever adding an MPLS route with multiple nexthops, ip route 
show the route as
a dead route/link down, even if nexthops are reachable.

Example to reproduce the error (tested with virtme-ng and the master 
branch of the kernel):
```
modprobe mpls_iptunnel mpls_router
sysctl net.mpls.platform_labels=100000
ip link set dummy0 up
ip addr add fc00:1::1/112 dev dummy0
ip addr add fc00:2::1/112 dev dummy0
ip -M route add 16000 \
     nexthop via inet6 fc00:1::2 as 16001 \
     nexthop via inet6 fc00:2::2 as 16002

# Check the route
ip -M route
# Output:
#     16000 dead linkdown
#
# Route is not present, even if accepted
```

 From a git blame, it seems that commit 
f0914b8436c589b7ab32c614d8d7868eb4ebd5bf
broke the core logic for building nexthops.

This commit modified function `mpls_nx_build_multi` by setting 
`rt->rt_nhn` to 0 at the
start of the function. However, the loop `change_nexthops` just below 
depends on
`rt->rt_nhn` to know the actual number of nexthops that it should build. 
As `rt->rt_nhn`
is set to 0 just before, **no nexthop is ever built**, leading to a dead 
route. Even if we
remove this modification, this commit incorrectly increments 
`rt->rt_nhn` at the end of
the loop (`rt->rt_nhn++`),  such that the loop always end with an error 
as it tries to
constructs more nexthops that actually provided.

Commenting these two lines fix the issue, and allows to create once 
again MPLS routes
with multiple nexthops:

```
modprobe mpls_iptunnel mpls_router
sysctl net.mpls.platform_labels=100000
ip link set dummy0 up
ip addr add fc00:1::1/112 dev dummy0
ip addr add fc00:2::1/112 dev dummy0
ip -M route add 16000 \
     nexthop via inet6 fc00:1::2 as 16001 \
     nexthop via inet6 fc00:2::2 as 16002

# Check the route
ip -M route
# Output:
#     16000
#            nexthop as to 16001 via inet6 fc00:1::2 dev dummy0
#            nexthop as to 16002 via inet6 fc00:2::2 dev dummy0
#
# Route is accepted and present !
```

Overall, I think it would be interesting to discuss what this patch was 
trying to achieve,
and how we can conciliate both use-cases.

Best regards and looking forward to hearing from you,
Doeraene Anthony



