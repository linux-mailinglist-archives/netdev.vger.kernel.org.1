Return-Path: <netdev+bounces-306252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vxh8EzCqT2pwmQIAu9opvQ
	(envelope-from <netdev+bounces-306252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1054731EE6
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:03:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=W71BdmMv;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306252-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306252-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ABAB30F25E6
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C531F997;
	Thu,  9 Jul 2026 13:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DE2C237E
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:45:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604707; cv=fail; b=FxYgTzyZN2zut0KXFC7bJriWXeyvegW2mKzbOpGv86iD6f0C5E3H0ISft83Rrg6DttntbFXMX7AhrmGQ0scjyUzJ5z+t9pZ36Jn+iHLJDDIoiEySLNWIFCJ6KqjzHDZWTu9IuB5VZedFbSt9daTfu7VrRntpRxcefoTdEEGJU9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604707; c=relaxed/simple;
	bh=M66M8IThCU7J47n29oYeclrNTqqx4LatbFVR321b9/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=seaW7uSnw4ivXJ1CNTkF3ED7PYf/fjWOihs3pM15RdjzYLk2UBhPNX/Y04eIche7nEg2K1IgCm9d/owJr8ivyobSuUN+DEltO8sCZSFbnxg3M2/pPlxWkwqMEi7BcKO7XxS3O0PGiEucR32Swruom727fEQzE/OTcjvAekoxKPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W71BdmMv; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYXilofZP5167BgNqCLfA/RogLUeA0LYoliPThqoCHdZxg3WXKw/9FX7aECRzKcyHWninUDJYPyg7gjYxZXrQfJwR1fe+o+VI7WYBj6xJGAOc0PHCB9HYT4/DJX55Asb0eMJ3l08e0MmKyMIazbh3LYAVo7DvUKmY9+PATK7231NLKYMO5RTk/uTHzEiJGjJ7oMJydnQq3bu04SuVNJOrn6ZfSa4AHL/9Tc+BE3/znl+uoZlPfv1W7uIfSgrODV7zlZRM46QB3k3j9A8d+fidcxvRZ4euZkb6dZxZnwoXgK9E2UZZbngFCUnNfLGL52sKUgghUCWn05EopZ2+f5vPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTpS9ff5AFsV4NMEkakOo4GL4D2M72/OkcienFv8wic=;
 b=WiT/IOkkevfBCF+4yngHipXHRTEOOTA1+OaDyqNwPnD0iG5uM7EKsyGv2HzfYwCXdntKfoKuyRB5ZrTj/0LNYXZdcJ1++2Dg9fjgxNjbhXbjTHrrvbdnlBXo2SpfHhNMlebWZM/0R5y9x5mk3ugZIO2vYTjd4o0PiXvmvdZzy048EjF6afpmHcNNwJlmOPdZU6DsHGW+nFzXqq81WIWczdpWqj/Yobh+nR4Sh0iMoo3Br+tZSo3fekzEqym6XhfqKGHrZ3Tqp4QwHlHVs6qlQnDelNqjiqkSI1Ror7w70W36gIf17R/0JQBO0M9OKp8YdorRZhS+PmQO3qDtIl0wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTpS9ff5AFsV4NMEkakOo4GL4D2M72/OkcienFv8wic=;
 b=W71BdmMv8PkZH+ipPQ/rJ5EPbdh5OBEeqahEb09/Y2V+LypzdpUNI67dlG/EZhrDCRdxpth9z/3twIAmUh0Tzw+pdaz6E7isTTtw8z4dVNeXJWOH1vNtKTP29F65w12ZkuFlHJUAzDf/xj6aiNKEHnqnfXI741XvOtWaGtseBCTp0oNjyqtLFD66ap8h5DIgibTeR+hBuU3O3FokpRyKINpPdkK6+Emi267Yw6UfxYMetkyDg7mNYfIGIBCpd+ECtvu9JbVndGk+hNUzckONVhFjQmy4ettzHc7+M7Dg7YQDKybm1TSWUZ0P3OctgexjvLhYdav+GQMjAlDPHZCV+w==
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 13:44:56 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:44:56 +0000
Message-ID: <76b6a3e8-8b8f-4138-9c8f-e4959fd75561@nvidia.com>
Date: Thu, 9 Jul 2026 16:44:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>, Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-8-danielj@nvidia.com>
 <20260208062637-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20260208062637-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: a73e8421-44ef-44ab-c251-08deddc042f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z2T5t7329NCMcKGxyQntzpa4WguaDMrEq6Nm7KTsPyuvmVCMmKevhvN3CWzRvZrNLg77fyh7QYYCiQ2UIn0SPDYOelmkep19N5io30+WUBkciR1/f2nHKxjAOp/qRmxjnZTSUzT/p/gjEkdpiyFYbGnTLxjx9Aikg9pCCLwVCAHwBs5GgBNqFnML1DjmRrGTj9YOl3uCHmzHr+sz3gqTRAc882leBslC6eE4MSKfI9oT34UBs3g5al5ZxqkonGXZPREix3hLJ260iM9NK6zUPPdqv/RKI++h1azd2WJnYtkV9dTvzQveAauKMkbYDNLfiKNMAt6o7kjMfZZ5iK87M6bmLzALiN8yiWW5InApU/oqPs5AMSp9U0ZuraVCv43sArBmAo0wmrTRoS6x2M4qLOHzH/evoy3v8NvhkqX0FNbontbETswgtFMdVtBScDMSYtqnnppEjcHyuhV3kHyBLjM/HpFI3n6hIXudcx1dTIFcSziLUX3NB+ICtfRtzvyVO5p5OzXXKLFbj10ZivrYk3lKhPPfZQiwoy7jrEswzXvFBf36q9Kv4ktJKr0SQkTNQAFkVNq1N7PGm7EN9XemmTR/gOiiTDUsloFa/uWuTZg670Wag2D/PwQ96b0DkgGBP6McP3eP/WDEyrPruVN6+gSUuTR8cVQG7KGz++VOH58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZYZStkcjdCdHVpSHdXN3VuZGRZUFNKSkJGeDRDdDR4cmx5eW51ZVRZRG04?=
 =?utf-8?B?bjhQczIrVjk0M2wxRkRma1NOcUZ2QU8wN0tNVG1TYm4xTzFXeHZuZmxPMzdo?=
 =?utf-8?B?VGpaLzBobjFBVnZUTTlJQmxrdkRYdTB0cXRFR00zSW9odm9qOUprU2RMa1Jk?=
 =?utf-8?B?OEVaTVNIRjZWSlBsT2U0R3F3UkZLZmE1MlkzUE5SZkx3N2xFaGVxaXQ0WFhF?=
 =?utf-8?B?dk01TjhoQk1HdCtFMUlFT0g4Ly85eDhsN0JUck16YXNYUm1xUk5xbTJ6Rytn?=
 =?utf-8?B?TlNkZ0pYUUEza1lnajRydkhiUENYZGEvWW1iWW1IeEJhQjhaVG1Zbk5CQVRK?=
 =?utf-8?B?R1IvTUJpVU5HT0JEMldJWHhXQXlpVS9OT2xhUjVvYWpQOFg1SXZQYXNRYklw?=
 =?utf-8?B?am5URit3MWJLZHZLVE1qRk1GT3BXZVM3LytiQVhWRzA3UXMyZ2hiSDZIRisw?=
 =?utf-8?B?Y20rZXoyYkpTUFdFUnk1SEo1dHZUVERlaEFJdEdTbTJXZG51ZVdJOWYrendX?=
 =?utf-8?B?NGQwY2RCelFXUVl3Wi9OWWtyNUcvdm52K2JhMGhkM0NUWWNYSTRFZTNSSWMv?=
 =?utf-8?B?R2hUZzdYeXYrZVFDdTVlMDhIV3pVVzdqK1ZZZFhwcVpxTXhPdnQ3T1IzT2FY?=
 =?utf-8?B?YVhtSUdjL3luNk5rWGRzOUcrMWI1Tm5mV0xOUCtEQlpyK0Jsa2w5cXR0a2V0?=
 =?utf-8?B?by9jeHB5ZmMzbVQyajRPSUtJbmR3YlFBak1mNUZ3Q1c3YURKTHl2NzQ3Y0ZC?=
 =?utf-8?B?NUIwTDQwVStid3QzaUJ3eUFQcEsvZDZVYXYxelN0Mk9POE5IYmdFYnQyNFpN?=
 =?utf-8?B?V3ZOOWhJQ2s4WllNTlRXRkN0aVB3dWpEOXIzT01JMm4rWm5uNFI3aWE0bWpJ?=
 =?utf-8?B?c3dVRkt0NlRDQ01scldBWlRSR2N0Mnd3cDIxeDU1eWlFQnM1bGNJQXJMQzVY?=
 =?utf-8?B?Rm9GRUxDVlpVbDZ2ZGtGV0wzVEVwMkZoclJvUjJDZCtlK05JQk1EV1Q2azJo?=
 =?utf-8?B?T0g1aXNPeUorc3VadVpVay9hWUZ5cGpxQU5pdVg4bHVCTUc4TUJzMVdVK3Zw?=
 =?utf-8?B?OHJGay9xUXJIQWk3cXlQZjRMZC83SFhxTEtWQ3BMdEhxbllvei8renkvbE1K?=
 =?utf-8?B?Mjd2Ujh5emtTUFptMjNkR1JXZHNVeUNXSFVrdUxCVTV5aFVRN2dOeFVrdHc4?=
 =?utf-8?B?Z1N5Q09YdTZHYy91MFhBd08zeFNpNkh1cFYvZVJWNTFibFpTWjE3UVV5ZUx4?=
 =?utf-8?B?YkRnckFZV04yS3lUY3R5bTZHd3RPckx2MlJQdjFBYmw3eVI1bzlqMkVQeEFk?=
 =?utf-8?B?NHd3SVdxZ1Z1RVN4Mm9tMEtnTVZuUi8zWmpKL1c5eHZ6UWlBdkp6cXI2dTc4?=
 =?utf-8?B?enhZRFZzeEh6Mmp2dnlEUTUyNWdGbURVWW9XblpoNjErL0VaTTNsT1F6NTVM?=
 =?utf-8?B?WGVqNXlDTU13QjBuQlhFcEJnVUkrU0h0VXQwbUJuYTFFajd4aGhmRnl3N1Rp?=
 =?utf-8?B?Wjl5U3dTcDZpa1lnU2Z3RlR4eDFqeFh5SmhzMmJoZ0VYVWpNdC9IUEdJMkZC?=
 =?utf-8?B?MVd2ZWkzTmZHK0lvNWlONHIvMFBrOVJWL0RJWnk2NjdLYWJJcnJIdU1YNTFV?=
 =?utf-8?B?NHhTajFUbStRcDBtdlgxY244QVdLTEtYaW5Kd2FiQWV3S2lNRHNrbG1kYnpB?=
 =?utf-8?B?KytVNnNUSFRud0FWVW13YXpyZzJQNE5wZ2U1bHBtWXczRS9rR2pmbnljWmVX?=
 =?utf-8?B?Vm14NGJObE12a1RMVDFlT0NNb1hlNDZ6VHlqbUc2ZkpzcERXcjFGeUZxZ1hP?=
 =?utf-8?B?ZEdzeHBEQXYzSXluMVVYSFUzUFhBZHIva0JOM1IwS3RXeWRsT09YbkpZckdF?=
 =?utf-8?B?ZWJXOFZHbHVNYUFxZ0RQaVhkNDVPbWRRZU1lSEp4aExRVlhjOUdqMjg0bWg3?=
 =?utf-8?B?amRsMW5UWVgyUVZrZTdNdldUOHJ4YllpRE8zN2MxckZxR01DT2dTKzI4Ylc3?=
 =?utf-8?B?Q01kTUdKMHMzTllzdWR1cUpNUXNqQlRLeEdSNjJqdWYvNnYyeXFDbnhXMHpY?=
 =?utf-8?B?N1ZndlZubWxxTG5iSS9sWUVDa04zc1pBMDA3bnRQVWhrM3YwVFZPQm5xRnBv?=
 =?utf-8?B?TFdSMnpTb2ZKS0NsY1hKdzhYSmJLYjhRQ285aDBlWUU1Y3RXUG8vd0V3UXZ6?=
 =?utf-8?B?eC9vVlN0WDJXZ0VBbXZSU0xNbGFIbmhBNzlYVG1yQVF5NHl1VTB0bktPb1Vz?=
 =?utf-8?B?NWlKMmRxdXkvblN1eEdkMHV0WmpVN2hmR1B5amYyUy9OUmNRMVJaM2hMQkZt?=
 =?utf-8?B?eWp2TVZFNytSTFByNFhLajUvMHlXMCtvLzZXVkRnQkQ3K3NSSmRIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73e8421-44ef-44ab-c251-08deddc042f7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:44:56.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+zg18Usxd/jxokKP0Wgd8IPcnv9GQMK3eqPaQEOVDswjHbGj4gc3Hb/kSj3VYaoFbLmkHo52/UO4iSxJHebPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306252-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shshitrit@nvidia.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:parav@nvidia.com,m:yohadt@nvidia.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:jgg@ziepe.ca,m:kevin.tian@intel.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shshitrit@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1054731EE6



On 08/02/2026 13:35, Michael S. Tsirkin wrote:
> On Thu, Feb 05, 2026 at 04:47:02PM -0600, Daniel Jurgens wrote:
>> Filtering a flow requires a classifier to match the packets, and a rule
>> to filter on the matches.
>>
>> A classifier consists of one or more selectors. There is one selector
>> per header type. A selector must only use fields set in the selector
>> capability. If partial matching is supported, the classifier mask for a
>> particular field can be a subset of the mask for that field in the
>> capability.
>>
>> The rule consists of a priority, an action and a key. The key is a byte
>> array containing headers corresponding to the selectors in the
>> classifier.
>>
>> This patch implements ethtool rules for ethernet headers.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
>> Added rule with ID 1
>>
>> The rule in the example directs received packets with the specified
>> destination MAC address to rq 30.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4:
>>     - Fixed double free bug in error flows
>>     - Build bug on for classifier struct ordering.
>>     - (u8 *) to (void *) casting.
>>     - Documentation in UAPI
>>     - Answered questions about overflow with no changes.
>> v6:
>>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>> v7:
>>     - Move for (int i -> for (i hunk from next patch. Paolo Abeni
>>
>> v12:
>>     - Make key_size u8. MST
>>     - Free key in insert_rule when it's successful. MST
>>
>> v17:
>>     - Fix memory leak if validate_classifier_selector fails. AI
>>
>> ---
>> ---
>>  drivers/net/virtio_net.c           | 464 +++++++++++++++++++++++++++++
>>  include/uapi/linux/virtio_net_ff.h |  50 ++++
>>  2 files changed, 514 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 340104b22a59..27833ba1abee 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -31,6 +31,7 @@
>>  #include <net/ip.h>
>>  #include <uapi/linux/virtio_pci.h>
>>  #include <uapi/linux/virtio_net_ff.h>
>> +#include <linux/xarray.h>
>>  
>>  static int napi_weight = NAPI_POLL_WEIGHT;
>>  module_param(napi_weight, int, 0444);
>> @@ -286,6 +287,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>>  };
>>  
>> +struct virtnet_ethtool_ff {
>> +	struct xarray rules;
>> +	int    num_rules;
>> +};
>> +
>>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>>  #define VIRTNET_FF_MAX_GROUPS 1
>>  
>> @@ -295,8 +301,16 @@ struct virtnet_ff {
>>  	struct virtio_net_ff_cap_data *ff_caps;
>>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>>  	struct virtio_net_ff_actions *ff_actions;
>> +	struct xarray classifiers;
>> +	int num_classifiers;
>> +	struct virtnet_ethtool_ff ethtool;
>>  };
>>  
>> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>> +				       struct ethtool_rx_flow_spec *fs,
>> +				       u16 curr_queue_pairs);
>> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
>> +
>>  #define VIRTNET_Q_TYPE_RX 0
>>  #define VIRTNET_Q_TYPE_TX 1
>>  #define VIRTNET_Q_TYPE_CQ 2
>> @@ -5579,6 +5593,21 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>>  	return vi->curr_queue_pairs;
>>  }
>>  
>> +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>> +{
>> +	struct virtnet_info *vi = netdev_priv(dev);
>> +
>> +	switch (info->cmd) {
>> +	case ETHTOOL_SRXCLSRLINS:
>> +		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
>> +						   vi->curr_queue_pairs);
>> +	case ETHTOOL_SRXCLSRLDEL:
>> +		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>  static const struct ethtool_ops virtnet_ethtool_ops = {
>>  	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>>  		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>> @@ -5605,6 +5634,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>>  	.get_rxfh_fields = virtnet_get_hashflow,
>>  	.set_rxfh_fields = virtnet_set_hashflow,
>>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
>> +	.set_rxnfc = virtnet_set_rxnfc,
>>  };
>>  
>>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
>> @@ -5702,6 +5732,429 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>>  	.get_base_stats		= virtnet_get_base_stats,
>>  };
>>  
>> +struct virtnet_ethtool_rule {
>> +	struct ethtool_rx_flow_spec flow_spec;
>> +	u32 classifier_id;
>> +};
>> +
>> +/* The classifier struct must be the last field in this struct */
>> +struct virtnet_classifier {
>> +	size_t size;
>> +	u32 id;
>> +	struct virtio_net_resource_obj_ff_classifier classifier;
>> +};
>> +
>> +static_assert(sizeof(struct virtnet_classifier) ==
>> +	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
>> +		    __alignof__(struct virtnet_classifier)),
>> +	      "virtnet_classifier: classifier must be the last member");
>> +
>> +static bool check_mask_vs_cap(const void *m, const void *c,
>> +			      u16 len, bool partial)
>> +{
>> +	const u8 *mask = m;
>> +	const u8 *cap = c;
>> +	int i;
>> +
>> +	for (i = 0; i < len; i++) {
>> +		if (partial && ((mask[i] & cap[i]) != mask[i]))
>> +			return false;
>> +		if (!partial && mask[i] != cap[i])
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static
>> +struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
>> +						u8 selector_type)
>> +{
>> +	struct virtio_net_ff_selector *sel;
>> +	void *buf;
>> +	int i;
>> +
>> +	buf = &ff->ff_mask->selectors;
>> +	sel = buf;
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		if (sel->type == selector_type)
>> +			return sel;
>> +
>> +		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		sel = buf;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static bool validate_eth_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct ethhdr *cap, *mask;
>> +	struct ethhdr zeros = {};
>> +
>> +	cap = (struct ethhdr *)&sel_cap->mask;
>> +	mask = (struct ethhdr *)&sel->mask;
>> +
>> +	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
>> +	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
>> +			       sizeof(mask->h_dest), partial_mask))
>> +		return false;
>> +
>> +	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
>> +	    !check_mask_vs_cap(mask->h_source, cap->h_source,
>> +			       sizeof(mask->h_source), partial_mask))
>> +		return false;
>> +
>> +	if (mask->h_proto &&
>> +	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
>> +			       sizeof(__be16), partial_mask))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static bool validate_mask(const struct virtnet_ff *ff,
>> +			  const struct virtio_net_ff_selector *sel)
>> +{
>> +	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
>> +
>> +	if (!sel_cap)
>> +		return false;
>> +
>> +	switch (sel->type) {
>> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>> +		return validate_eth_mask(ff, sel, sel_cap);
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>> +{
>> +	int err;
>> +
>> +	err = xa_alloc(&ff->classifiers, &c->id, c,
>> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>> +		       GFP_KERNEL);
>> +	if (err)
>> +		return err;
>> +
>> +	err = virtio_admin_obj_create(ff->vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>> +				      c->id,
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				      0,
>> +				      &c->classifier,
>> +				      c->size);
>> +	if (err)
>> +		goto err_xarray;
>> +
>> +	return 0;
>> +
>> +err_xarray:
>> +	xa_erase(&ff->classifiers, c->id);
>> +
>> +	return err;
>> +}
>> +
>> +static void destroy_classifier(struct virtnet_ff *ff,
>> +			       u32 classifier_id)
>> +{
>> +	struct virtnet_classifier *c;
>> +
>> +	c = xa_load(&ff->classifiers, classifier_id);
>> +	if (c) {
>> +		virtio_admin_obj_destroy(ff->vdev,
>> +					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>> +					 c->id,
>> +					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +					 0);
>> +
>> +		xa_erase(&ff->classifiers, c->id);
>> +		kfree(c);
>> +	}
>> +}
>> +
>> +static void destroy_ethtool_rule(struct virtnet_ff *ff,
>> +				 struct virtnet_ethtool_rule *eth_rule)
>> +{
>> +	ff->ethtool.num_rules--;
>> +
>> +	virtio_admin_obj_destroy(ff->vdev,
>> +				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
>> +				 eth_rule->flow_spec.location,
>> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				 0);
>> +
>> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> +	destroy_classifier(ff, eth_rule->classifier_id);
>> +	kfree(eth_rule);
>> +}
>> +
>> +static int insert_rule(struct virtnet_ff *ff,
>> +		       struct virtnet_ethtool_rule *eth_rule,
>> +		       u32 classifier_id,
>> +		       const u8 *key,
>> +		       u8 key_size)
>> +{
>> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
>> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
>> +	int err;
>> +
>> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
>> +	if (!ff_rule)
>> +		return -ENOMEM;
>> +
>> +	/* Intentionally leave the priority as 0. All rules have the same
>> +	 * priority.
>> +	 */
>> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
>> +	ff_rule->key_length = key_size;
>> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
>> +					     VIRTIO_NET_FF_ACTION_DROP :
>> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
> 
> btw driver does not validate these actions are supported or did i miss the
> check? the spec does not say it must but it also does not
> say how device will behave if not. better not to take risks.
> 
> 
>> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
>> +					       cpu_to_le16(fs->ring_cookie) : 0;
> 
> 
> So here ring_cookie is a vq index? vq index is what matches the spec. but below ...
here we miss rxq2vq conversion of fs->ring_cookie. I'll fix in v21.
> 
> 
>> +	memcpy(&ff_rule->keys, key, key_size);
>> +
>> +	err = virtio_admin_obj_create(ff->vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
>> +				      fs->location,
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				      0,
>> +				      ff_rule,
>> +				      sizeof(*ff_rule) + key_size);
>> +	if (err)
>> +		goto err_ff_rule;
>> +
>> +	eth_rule->classifier_id = classifier_id;
>> +	ff->ethtool.num_rules++;
>> +	kfree(ff_rule);
>> +	kfree(key);
>> +
>> +	return 0;
>> +
>> +err_ff_rule:
>> +	kfree(ff_rule);
>> +
>> +	return err;
>> +}
>> +
>> +static u32 flow_type_mask(u32 flow_type)
>> +{
>> +	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
>> +}
>> +
>> +static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>> +{
>> +	switch (fs->flow_type) {
>> +	case ETHER_FLOW:
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int validate_flow_input(struct virtnet_ff *ff,
>> +			       const struct ethtool_rx_flow_spec *fs,
>> +			       u16 curr_queue_pairs)
>> +{
>> +	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
>> +	if (fs->location != RX_CLS_LOC_ANY)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
>> +	    fs->ring_cookie >= curr_queue_pairs)
>> +		return -EINVAL;
> 
> 
> here ring cookie seems to be a queue pair index?
> 
>> +
>> +	if (fs->flow_type != flow_type_mask(fs->flow_type))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!supported_flow_type(fs))
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +
>> +static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>> +				 u8 *key_size, size_t *classifier_size,
>> +				 int *num_hdrs)
>> +{
>> +	*num_hdrs = 1;
>> +	*key_size = sizeof(struct ethhdr);
>> +	/*
>> +	 * The classifier size is the size of the classifier header, a selector
>> +	 * header for each type of header in the match criteria, and each header
>> +	 * providing the mask for matching against.
>> +	 */
>> +	*classifier_size = *key_size +
>> +			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
>> +			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
>> +}
>> +
>> +static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>> +				   u8 *key,
>> +				   const struct ethtool_rx_flow_spec *fs)
>> +{
>> +	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
>> +	struct ethhdr *eth_k = (struct ethhdr *)key;
>> +
>> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
>> +	selector->length = sizeof(struct ethhdr);
>> +
>> +	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
>> +	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
>> +}
>> +
>> +static int
>> +validate_classifier_selectors(struct virtnet_ff *ff,
>> +			      struct virtio_net_resource_obj_ff_classifier *classifier,
>> +			      int num_hdrs)
>> +{
>> +	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
>> +	int i;
>> +
>> +	for (i = 0; i < num_hdrs; i++) {
>> +		if (!validate_mask(ff, selector))
>> +			return -EINVAL;
>> +
>> +		selector = (((void *)selector) + sizeof(*selector) +
>> +					selector->length);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int build_and_insert(struct virtnet_ff *ff,
>> +			    struct virtnet_ethtool_rule *eth_rule)
>> +{
>> +	struct virtio_net_resource_obj_ff_classifier *classifier;
>> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
>> +	struct virtio_net_ff_selector *selector;
>> +	struct virtnet_classifier *c;
>> +	size_t classifier_size;
>> +	int num_hdrs;
>> +	u8 key_size;
>> +	u8 *key;
>> +	int err;
>> +
>> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
>> +
>> +	key = kzalloc(key_size, GFP_KERNEL);
>> +	if (!key)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * virtio_net_ff_obj_ff_classifier is already included in the
>> +	 * classifier_size.
>> +	 */
>> +	c = kzalloc(classifier_size +
>> +		    sizeof(struct virtnet_classifier) -
>> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
>> +		    GFP_KERNEL);
>> +	if (!c) {
>> +		kfree(key);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	c->size = classifier_size;
>> +	classifier = &c->classifier;
>> +	classifier->count = num_hdrs;
>> +	selector = (void *)&classifier->selectors[0];
>> +
>> +	setup_eth_hdr_key_mask(selector, key, fs);
>> +
>> +	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>> +	if (err)
>> +		goto err_classifier;
>> +
>> +	err = setup_classifier(ff, c);
>> +	if (err)
>> +		goto err_classifier;
>> +
>> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>> +	if (err) {
>> +		/* destroy_classifier will free the classifier */
>> +		destroy_classifier(ff, c->id);
>> +		goto err_key;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_classifier:
>> +	kfree(c);
>> +err_key:
>> +	kfree(key);
>> +
>> +	return err;
>> +}
>> +
>> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>> +				       struct ethtool_rx_flow_spec *fs,
>> +				       u16 curr_queue_pairs)
>> +{
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	int err;
>> +
>> +	if (!ff->ff_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
>> +	if (err)
>> +		return err;
>> +
>> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
>> +	if (!eth_rule)
>> +		return -ENOMEM;
>> +
>> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
>> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
>> +		       GFP_KERNEL);
>> +	if (err)
>> +		goto err_rule;
>> +
>> +	eth_rule->flow_spec = *fs;
>> +
>> +	err = build_and_insert(ff, eth_rule);
>> +	if (err)
>> +		goto err_xa;
>> +
>> +	return err;
>> +
>> +err_xa:
>> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> +
>> +err_rule:
>> +	fs->location = RX_CLS_LOC_ANY;
>> +	kfree(eth_rule);
>> +
>> +	return err;
>> +}
>> +
>> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
>> +{
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	int err = 0;
>> +
>> +	if (!ff->ff_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	eth_rule = xa_load(&ff->ethtool.rules, location);
>> +	if (!eth_rule) {
>> +		err = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	destroy_ethtool_rule(ff, eth_rule);
>> +out:
>> +	return err;
>> +}
>> +
>>  static size_t get_mask_size(u16 type)
>>  {
>>  	switch (type) {
>> @@ -5875,6 +6328,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  	if (err)
>>  		goto err_ff_action;
>>  
>> +	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
>> +	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
>>  	ff->vdev = vdev;
>>  	ff->ff_supported = true;
>>  
>> @@ -5899,9 +6354,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  
>>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>>  {
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	unsigned long i;
>> +
>>  	if (!ff->ff_supported)
>>  		return;
>>  
>> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
>> +		destroy_ethtool_rule(ff, eth_rule);
>> +
>> +	xa_destroy(&ff->ethtool.rules);
>> +	xa_destroy(&ff->classifiers);
>> +
>>  	virtio_admin_obj_destroy(ff->vdev,
>>  				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>>  				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> index c7d01e3edc80..aa0619f9c63b 100644
>> --- a/include/uapi/linux/virtio_net_ff.h
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -13,6 +13,8 @@
>>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>>  
>>  #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
>> +#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
>> +#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
>>  
>>  /**
>>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> @@ -103,4 +105,52 @@ struct virtio_net_resource_obj_ff_group {
>>  	__le16 group_priority;
>>  };
>>  
>> +/**
>> + * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
>> + * @count: number of selector entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: array of selector descriptors that define match masks
>> + *
>> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
>> + * Each selector describes a header mask used to match packets
>> + * (see struct virtio_net_ff_selector). Selectors appear in the order they are
>> + * to be applied.
>> + */
>> +struct virtio_net_resource_obj_ff_classifier {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 selectors[];
>> +};
>> +
>> +/**
>> + * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
>> + * @group_id: identifier of the target flow filter group
>> + * @classifier_id: identifier of the classifier referenced by this rule
>> + * @rule_priority: relative priority of this rule within the group
>> + * @key_length: number of bytes in @keys
>> + * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @keys: concatenated key bytes matching the classifier's selectors order
>> + *
>> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
>> + * @group_id and @classifier_id refer to previously created objects of types
>> + * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
>> + * respectively. The key bytes are compared against packet headers using the
>> + * masks provided by the classifier's selectors. Multi-byte fields are
>> + * little-endian.
>> + */
>> +struct virtio_net_resource_obj_ff_rule {
>> +	__le32 group_id;
>> +	__le32 classifier_id;
>> +	__u8 rule_priority;
>> +	__u8 key_length; /* length of key in bytes */
>> +	__u8 action;
>> +	__u8 reserved;
>> +	__le16 vq_index;
>> +	__u8 reserved1[2];
>> +	__u8 keys[];
>> +};
>> +
>>  #endif
>> -- 
>> 2.50.1
> 
> 


