Return-Path: <netdev+bounces-305944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgMTGhSWTmrFPwIAu9opvQ
	(envelope-from <netdev+bounces-305944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:25:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0D72978D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:25:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=gy1SI9me;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305944-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305944-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E9423017010
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719837996B;
	Wed,  8 Jul 2026 18:25:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F703438A2
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:25:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535122; cv=fail; b=MwgPQDYTVECeoHOWIjYFX0oQFSDGnYKkhl8VzJTZQJqdvYNtvK+8/mNRfsX95YuUe9tcdRgz66mwmMivIkFEQjYGUkOLfGW5iYxCxqOGpUrzsOZQ4m/W+DhcJyKpP+lDIl0de4heBnobZi2dmYiXRAIWS3MTZxKwyBPQGJ9Fzy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535122; c=relaxed/simple;
	bh=mfFXnOU6uRYvkP4D5Kfyr2WFdZYmHbfecgk/ZJvxzwc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jfbPhepLNRFCN3prU+02YdMT51EJkClt6mExtvWjjpnjhfJsHy7pPOse9eLpHnsliQqdZOFzgFhYiBBCeQliMVpPnc7/yjZPfgcsR23mr+Q5Vpupo/mUEyPFBuyTPnnKBbZOvd/WX0z6frMRNsEBeWh7S+5AaFLMatBzm6mPSCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gy1SI9me; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5uF4IK2l3YG46aDNNtcD7RUImllVWct6T4ZjUUlVermAPC1Zq63WoBBsCxFKVCwz4c+6Xbx+7a+l21wu7TSZ2O2QatyIhcjx6nAl+k9ZmQxUIwNLes/4tSQv0YD4Dk19+M33b0x7hFBWegtXcuCR+S5dxzMYNLAcfhyijpcaIh5HYuxWFQmZ4474RuhKXkvZsqtrZboxZdwmd56MjbMlOtf4/cpmNMoHigjhFtPsKl4gp0N6p/MIOkt7lLZ/hQYvLz4In9/grBOmTtWAo6aR0HMsxPdtUh/NV1ukilLT0OApWsVmFnxW7HVB5UFQJ83nh7XksQkgIjU8M89X4WZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCDe0xieHECmFfMnz1lSCIsvA1YQsgS2u8pNJvQEy4I=;
 b=WOSBix46bFhJg0GmESsW7vKSNfEh22WFY49TVwrAbaxDPHSjEpJJVnHEQ778Tw/aAxNMwazbQHW9ovHut4x5hjvCFPwBdSjiBQqv/jvdHaLF6Iz+FC/otdWk7ngA9zwyNmAvjj2HRqcoTsGRP14YNZoXWCO3isyKJQHvudY3H9r+JX/CBKB/YA2DY3w8tikKq9s0Vu1i19nncfqndQuTTi81H2VG9YVtsD4IYsCL9qgV0DMS9+GnPikyL6lt1cEoSmmUWe4golRbqJrd7JeM/GnDXxlPV6Igf8NIPSnSkADzS2oBoO8Dn4XhArJGl2Pbil3qfLESuDNFcvGJ4Vd5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCDe0xieHECmFfMnz1lSCIsvA1YQsgS2u8pNJvQEy4I=;
 b=gy1SI9meGHoaKJyUd9N+8A/CqJ4x8lk993NWO8nUWFJB/eCZlcO0yYrIWlgL9tCuZ4jiWx3dXwVng09Sg5z9LB1mSVHo/MmgANrj+vV+rA8F3VET61O//pd2F7TDKdW5/1Oug7VscKSsJS4eARj9ye6/P4eV5b1mxzK3dlyIdrQ=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:25:12 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%4]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 18:25:11 +0000
Message-ID: <536c1128-45ba-4d4c-866c-8ec8f1467898@amd.com>
Date: Wed, 8 Jul 2026 11:25:08 -0700
User-Agent: Mozilla Thunderbird
From: "Rao, Nikhil" <nikhirao@amd.com>
Subject: Re: [PATCH net-next v6 3/6] pds_core: add PLDM firmware update
 support via devlink flash
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, nikhil.rao@amd.com
References: <20260629230200.82092-4-nikhil.rao@amd.com>
 <20260702091100.93838-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702091100.93838-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0182.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::7) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 17311e0a-4104-4d82-2af8-08dedd1e3f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	a3fqSnLwNEkadADHyhneTKNGCBbRJSa9ue4mthxi4z8307Mw4e01dJenBpFhqg4zJFecNBFDKGuQnlJx0Y/qgAVMWM35rla/E62Fi1FLWxgHATKnYxJVUZHVzyxuhWaqUdw8BfhqhXbBuddX22GikOLI/PsIApMy9ReroyihC97cDID1ZRs2UceKj8dxlPjLTjnrjs0xdng3To3lV3Z7ZFSMH5k/NWIlY+GmbcW0VU//SeOa9Ic5FvFXuLfbcEPMZrqb+SsaCOYaX/86Qzekqyg6MRJIKrAlKp/krLhEO4G1Del/dNyzCHAiZJFQg5jO1HyWCYU94W0Em7c0wnaI6In90eXu4joXBgkPZdGT9TiLm10Xs8xD4rDmLD9RieKWz9SCu0xC2e94mSXumPeqbCkAIWyM0baiaa+mXwVxNnHVpNPx90AXuALuxM6OQ9vUO+7/gnHJ5BN8ONdCOF/hGHM8uvQd+NcuEd/3y1BPS+qkmLFoYbXjKXtXIY0/jdKSYXoQ2R70ApS6an3vTxAodqKkvx0cXLi0mwf5Zc1ZyDrm2wqBPcyTh/83iU7eD9W1k/ivWWCmmdTWbufG8ujSpkK/FVxl7Eq0gJOADunyXmbNQW7GfaJOEi1HmtNELkOK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG5nd2pLa2svSk1YRTEwdm1kZVdEeGFzUXFLMkNpZHBlUzduSVZwNXZ4Q0tw?=
 =?utf-8?B?blp4UFdVN1BTL1pHTVdTQ2xoaWV3RjNKeXB5WENGSC8vNG9IcnlmQ3pPK3ZV?=
 =?utf-8?B?T1F5eXRPd2kyQURvZmtrTVlHM0dmc0NXdWJYK1p3c3hWVXRVZ3o5R2wxdEsz?=
 =?utf-8?B?Wm4xL3VWN3lnNm5VMEQ3UVlQRWpQNXAveVZNM0hTT1ZtOVgyYmJVemJEY3Nh?=
 =?utf-8?B?WUc5VEdmcXFYcVZJSlp3OTdtRzJJTkNnNm9lblFYeG16Z1owWDZRK1FxKzZa?=
 =?utf-8?B?SHV3YzlLcHFLaDRUblJTbHlPb0RFSlZqOHRtazluNUdDb2NtUFBQQmpuMDgr?=
 =?utf-8?B?Tm5vaURVL1IyRmd1VDJtNlZONHh1U3N6ei8zZDBqcnFod1hjNjB6RE1QTnZu?=
 =?utf-8?B?RlFHZ3Y5amllSnBLS0tEQU1QWmxXQlBrNFJlb2JGZkFweVR0bHZEaHNoSUd1?=
 =?utf-8?B?OHIvbWVXUFFOWWZXT0pLYXpnTWRtRXk0T3hyang3Uk4zcGxLQUZUSDJ5dFRN?=
 =?utf-8?B?c0VOM2EzTk1hS0p2OHNDRk55dUNGaTM3UG9CNndseWlocXlmT25iK3k5YWcz?=
 =?utf-8?B?SHVrYzczTzRIYVJpeStHS1Rock9uMXI5TGQ0eWluSXdjOEFXbWxzaHNQeGJB?=
 =?utf-8?B?cGR1OG5weHhMczlocUZoNWpuVDBReFpVTTB2c3FZM2ovNDdhVXFNR29VOVBz?=
 =?utf-8?B?dHV2eU4va1BUOGN3UXpRRzVJS280djd2SkdkaTlUUXFIREpNRjZtUzRnR1lk?=
 =?utf-8?B?eTE3SndkdU96Ymo2KzdWOWxLNFFTY21panJxNHd4bC94bFZzdkhLQThBSjlW?=
 =?utf-8?B?WUlNYzlCQkxsbXJ5WFpVcDMxUmZ4N0JCcmQ3MGI1R2wyVTJyZ0t1MmNVS0RF?=
 =?utf-8?B?Zk5HUkZOUFB2S25JcjhzdG9zS3RRRWJNM2o2VmlhaXVSa3RDRjhUSUJWZlJH?=
 =?utf-8?B?clVRTitMNmtDQSs0RER3MmhGdW1rZ3NIczZYV3ZjOUJ6QTlHWmN3MFdSSjBv?=
 =?utf-8?B?dmpSQjY2anI2UUI0aEEzRkJZc2IrYjcyS1RMMXBuZVRqdzk1VjRpbE9mWTJj?=
 =?utf-8?B?SUk2czF6d1FXRlZjMWhXOFNEY2ZsUEpOa0VFUzRGa05PTGlUdlJRRDRzU2Vp?=
 =?utf-8?B?YmhIV2t2TDhUN2cxVmZlT04rMjFnVlc3YUdZbld6WnMxeWRKZjd1M3ZSdnRV?=
 =?utf-8?B?Q0hnRGlyeS91akd5VFRGVGRpZ2dSeWFJQ1E2Y0l3VjFiRnBDNDJ3NTZMSko0?=
 =?utf-8?B?cEs5dHpYMWNPSDYrbjZnQWdjTWZSOW1CT05ZSnNGUmQ5OWhYdlRkdGVyTE9a?=
 =?utf-8?B?YUtHNHZqT0doWWUzRnNXQ3hGckhWMTBvSzNYVWk5SEs2OGx4WTBCaVJiUDlD?=
 =?utf-8?B?ZXpiUUh5aDNBSUtheEwwV3l1ZEdMZUZOdmZNTk5JMTlNVzJydlU4T203Smtj?=
 =?utf-8?B?V3h3TUtYY1Q3S1RsZnI1cUYxdWdJbWYyVmY5MjNrT0VSNWF6Tkt0c2Z4ZVVF?=
 =?utf-8?B?ZVYzQUFmMzlWZUNXNVFrNlVpOUlRREF0Vm5reW5FTzdYMW5adDhQTVBPNEJD?=
 =?utf-8?B?TS9kaUVZbit5QlJmZ0hXOXQ0QjJMRkVIazJTdEw2YnlnZ2JLS0hzcGJMK09k?=
 =?utf-8?B?NTlQN05qZDY3QzJtTzVhenhIUkxHVkF1S2M0UlBIY2FIaTNxcCtoTjNMb253?=
 =?utf-8?B?RTBXRVdwV1dWZ1YzREtXNHNseWFINDJUUGwvWEdZU0xucnpOV3BBS0hUMU9y?=
 =?utf-8?B?d3JjbHFjaWpNOWFONUMraXdnaEpydlhXZFQ4Rms1Y1RNdG8rSlNHM1VTU242?=
 =?utf-8?B?L3p4THUxZmRmcmlYTFNxbVlYWGY0OFcyVGNJY01QSlV3MWlqQ0pkUzdNR0Zp?=
 =?utf-8?B?QmxRTjl2Y3ZIb2R0NUpJallmdmNJN1lHK3NhV2ViT3F3dDRwS1ppZzNmVUI4?=
 =?utf-8?B?ZTlTYTM4WndFWG9XUWJuYTBjc05PMDRrTFV6azBSRmZjV2hDN2tPY1cyK0Nq?=
 =?utf-8?B?VTlNOGZqNWE5bGVPeDhsVHdyNlJneEFCa1hPRDVUNUE4V2hrek96SGUrc1lw?=
 =?utf-8?B?RFZUZzZHMm9jTlNkWldOTStRa1gxNHE4Rm1Oc3pRN0U3WGpHMVFGWFE1RVlh?=
 =?utf-8?B?ZkxkckZGdHhQNHJxbXIzVVBDYVkwNFBRYWM5cnl1UTgvUDBDVG1RMnlUdXht?=
 =?utf-8?B?WlM1czhVR1NlYmdTNGUwTlpnUVRoMG5vQkNEeENYTEdHMXJBTVk2YldiU0ZR?=
 =?utf-8?B?TTU3YkNpd1NWbGFtaHMreG1na1E3QUJneWdiOVdhM2RkclZ1cExOdk9qOU9m?=
 =?utf-8?B?U3BUVGtsQ2ZybWFGUTNFRGdEL3ZqTFNrSGR2UDFPMDdlbHNwc0hwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17311e0a-4104-4d82-2af8-08dedd1e3f77
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:25:11.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5LKU8abo9Gx31O3NGT5UX0/ciE8Vo8TZWELXelmysBQ4PsNmOu1XIdaHI0aBdcf2hK0LHcjBGNAxUH4oWeIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305944-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:dkim,amd.com:mid,context.dev:url,fw.gold:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F0D72978D

On 7/2/2026 2:11 AM, Paolo Abeni wrote:
 > From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> pds_core: add PLDM firmware update support via devlink flash
> 
> Implements PLDM firmware update via devlink flash using the upstream
> pldmfw API. Adds whole-package and per-component update paths, and
> introduces a deferred-DMA list that releases buffers after timed-out
> devcmds. A few questions inline.
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
>> index b7fe9ad73349..c686f0bbbaeb 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.h
>> +++ b/drivers/net/ethernet/amd/pds_core/core.h
>> @@ -23,6 +23,14 @@
>>   #define PDSC_SETUP_RECOVERY  false
>>   #define PDSC_SETUP_INIT              true
>>
>> +struct pdsc_deferred_dma {
>> +     struct list_head list;
>> +     dma_addr_t dma_addr;
>> +     void *va;
>> +     size_t size;
>> +     enum dma_data_direction dir;
>> +};
>> +
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
>> index 5c0ca3d0b000..6082b28915db 100644
>> --- a/drivers/net/ethernet/amd/pds_core/dev.c
>> +++ b/drivers/net/ethernet/amd/pds_core/dev.c
>> @@ -206,15 +206,53 @@ static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
>>        else
>>                memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
>>
>> +     if (err != -ETIMEDOUT && err != -EAGAIN)
>> +             pdsc_deferred_dma_free(pdsc);
>> +
>>        return err;
>>   }
> 
> [High]
> Can the deferred-DMA scheme actually guarantee that the device has
> finished accessing the buffer before it is unmapped and freed?
> 
> The trigger for releasing a deferred entry is "the next devcmd returned
> something other than -ETIMEDOUT/-EAGAIN", plus pdsc_remove() and
> pdsc_reset_prepare(). None of these provide a hardware-level fence that
> the previous in-flight DMA has drained. In the remove/reset paths the
> free runs after pci_disable_device(), which clears bus-master but does
> not synchronously drain pending transactions.
> 
> The DMA_FROM_DEVICE case in pdsc_get_component_info() is particularly
> exposed because the buffer is plain kernel slab memory: a late device
> write after kfree would corrupt unrelated allocations.
Will fix in v7 by adding a config space read after pci_disable_device() 
in pdsc_teardown() before freeing deferred DMA buffers. PCI transaction 
ordering rules guarantee that a read completion cannot return until all 
prior device-initiated memory writes have completed. This ensures 
in-flight DMA has drained before buffers are freed.

> 
> Also note that pdsc_send_package_data(), pdsc_get_component_info(), and
> pdsc_flash_component_chunk() only defer on -EAGAIN/-ETIMEDOUT and
> immediately unmap+kfree on any other error (-EIO, -ENXIO, ...). Is the
> device guaranteed not to have started any DMA in those cases?
Yes. When devcmd returns -EIO or -ENXIO (or any non-timeout error), the 
command has completed, the MMIO read that retrieved the completion 
status acts as a DMA fence. The immediate free is safe because command 
completion implies DMA finished.

> 
>> +void pdsc_deferred_dma_add(struct pdsc *pdsc, struct pdsc_deferred_dma *entry,
>> +                        dma_addr_t dma_addr, void *va, size_t size,
>> +                        enum dma_data_direction dir)
>> +{
>> +     entry->dma_addr = dma_addr;
>> +     entry->va = va;
>> +     entry->size = size;
>> +     entry->dir = dir;
>> +
>> +     spin_lock(&pdsc->deferred_dma_lock);
>> +     list_add_tail(&entry->list, &pdsc->deferred_dma_list);
>> +     spin_unlock(&pdsc->deferred_dma_lock);
>> +}
>> +
>> +void pdsc_deferred_dma_free(struct pdsc *pdsc)
>> +{
>> +     struct pdsc_deferred_dma *entry, *tmp;
>> +
>> +     spin_lock(&pdsc->deferred_dma_lock);
>> +     list_for_each_entry_safe(entry, tmp, &pdsc->deferred_dma_list, list) {
>> +             dma_unmap_single(pdsc->dev, entry->dma_addr,
>> +                              entry->size, entry->dir);
>> +             kfree(entry->va);
>> +             list_del(&entry->list);
>> +             kfree(entry);
>> +     }
>> +     spin_unlock(&pdsc->deferred_dma_lock);
>> +}
> 
> [Medium]
> Is it intentional to hold deferred_dma_lock across dma_unmap_single()
> and two kfree()s per entry? This runs from __pdsc_devcmd_locked() on
> every successful devcmd while devcmd_lock is also held, and
> dma_unmap_single() can trigger IOMMU IOTLB invalidations. Would
> list_splice_init() under the lock followed by iteration on a detached
> list scale better when many entries have accumulated?
Will fix in v7, using list_splice_init() to detach the list under the 
lock, then iterate and free without holding the lock.

> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/fw.c b/drivers/net/ethernet/amd/pds_core/fw.c
>> index fa626719e68d..433b0a8df4c1 100644
>> --- a/drivers/net/ethernet/amd/pds_core/fw.c
>> +++ b/drivers/net/ethernet/amd/pds_core/fw.c
> 
> [ ... ]
> 
>> +#define PDSC_FW_COMPONENT_PREFIX             "fw."
>> +#define PDSC_FW_COMPONENT_FULL_NAME_BUFLEN \
>> +     (sizeof(PDSC_FW_COMPONENT_PREFIX) + PDS_CORE_FW_COMPONENT_NAME_BUFLEN)
>> +
>> +/* Driver-defined component type to name mapping.
>> + * PDS_CORE_FW_TYPE_MAIN is NULL - handled specially as "fw" without prefix.
>> + */
>> +static const char * const pdsc_fw_type_names[] = {
>> +     [PDS_CORE_FW_TYPE_MAIN]      = NULL,
>> +     [PDS_CORE_FW_TYPE_BOOT]      = "bootloader",
>> +     [PDS_CORE_FW_TYPE_CPLD]      = "cpld",
>> +     [PDS_CORE_FW_TYPE_SECURE]    = "secure",
>> +     [PDS_CORE_FW_TYPE_FPGA]      = "fpga",
>> +     [PDS_CORE_FW_TYPE_SUC_MAIN]  = "suc",
>> +     [PDS_CORE_FW_TYPE_SUC_BOOT]  = "suc.bootloader",
>> +     [PDS_CORE_FW_TYPE_UBOOT]     = "uboot",
>> +};
> 
> [Low, Low]
> The documentation table added in this same patch lists fw.gold as a
> driver-defined component name, and the kerneldoc on
> enum pds_core_fw_component_type says gold variants are "reported with
> a .gold suffix (e.g., fw.gold)". The table above has no gold entry, so
> pdsc_name_to_fw_type("fw.gold") returns 0 and pdsc_pldm_firmware_update()
> rejects the request with -ENOENT. Should fw.gold either be wired up or
> the docs clarify that gold is read-only?
Will update documentation in v7. The component for fw.gold is "fw". Gold 
firmware can be updated by specifying component "fw" with a goldfw 
package file.

> PDSC_FW_COMPONENT_FULL_NAME_BUFLEN is defined here but never used;
> pdsc_flash_component() uses an ad-hoc sizeof(PDSC_FW_COMPONENT_PREFIX) +
> 16 instead. Should this macro be wired up or dropped?
> 
Will fix in v7, using the PDSC_FW_COMPONENT_FULL_NAME_BUFLEN macro in 
pdsc_flash_component() for the component_name_buf array size.

> [ ... ]
> 
>> +int pdsc_get_component_info(struct pdsc *pdsc)
>> +{
>> +     union pds_core_dev_cmd cmd = {
>> +             .get_component_info.opcode = PDS_CORE_CMD_GET_COMPONENT_INFO,
>> +             .get_component_info.ver = 1,
>> +     };
> 
> [ ... ]
> 
>> +     if (comp.get_component_info.ver == 0) {
>> +             /* Don't support backward compatibility as version 0 has
>> +              * alignment issues, so give a hint to users to update
>> +              * their firmware
>> +              */
>> +             dev_warn_once(pdsc->dev,
>> +                           "Incompatible get_component_info version %u reported by firmware\n",
>> +                           comp.get_component_info.ver);
>> +             err = 0;
>> +             goto out;
>> +     }
> 
> [Low]
> This branch returns 0 without populating pdsc->fw_components. The caller
> pdsc_pldm_firmware_update() uses:
> 
>          if (!pdsc->fw_components.num_components) {
>                  err = pdsc_get_component_info(pdsc);
>                  if (err) { ... return err; }
>          }
> 
>          if (params->component) {
>                  u8 type = pdsc_name_to_fw_type(params->component);
> 
>                  if (!type || !pdsc_component_type_exists(pdsc, type))
>                          return -ENOENT;
>          }
> 
> so on a device that reports ver == 0, the cache never populates and
> every per-component flash returns -ENOENT. Should this branch return an
> explicit error instead, or otherwise prevent the per-component lookup
> from running?
> 
The dev_warn_once message tells the user to update their firmware. 
Per-component flash will fail with -ENOENT, but the user needs to 
upgrade firmware anyway to use this feature. Returning an explicit error 
here would prevent the basic flash operation from working on old firmware.

> [ ... ]
> 
>> +static int pdsc_devcmd_send_component(struct pdsc *pdsc,
>> +                                   struct pds_core_flash_component *info,
>> +                                   u16 info_sz, dma_addr_t addr, u32 length,
>> +                                   u32 offset, u16 slot_id,
>> +                                   union pds_core_dev_comp *comp)
>> +{
>> +     union pds_core_dev_cmd cmd = {
>> +             .send_component.opcode = PDS_CORE_CMD_SEND_COMPONENT,
>> +             .send_component.ver = 1,
>> +             .send_component.operation = PDS_CORE_SEND_COMPONENT_START,
>> +             .send_component.data_pa = cpu_to_le64(addr),
>> +             .send_component.data_len = cpu_to_le32(length),
>> +             .send_component.offset = cpu_to_le32(offset),
>> +             .send_component.slot_id = slot_id,
>> +     };
>> +     unsigned long timeout = 300 * HZ;
>> +     unsigned long start_time;
>> +     unsigned long end_time;
>> +     int err;
>> +
>> +     start_time = jiffies;
>> +     end_time = start_time + timeout;
>> +     do {
>> +             /* prevent noisy/benign devcmd failures */
>> +             err = pdsc_devcmd_with_data_nomsg(pdsc, &cmd, info, info_sz,
>> +                                               comp, 60);
>> +             if (err != -EAGAIN)
>> +                     break;
>> +
>> +             /* if required, subsequent commands check status of
>> +              * PDS_CORE_CMD_SEND_COMPONENT command, which returns
>> +              * EAGAIN while the command is still running,
>> +              * else we get the final command status.
>> +              */
>> +             cmd.send_component.operation = PDS_CORE_SEND_COMPONENT_STATUS;
>> +             msleep(20);
>> +     } while (time_before(jiffies, end_time));
> 
> [Low]
> In the STATUS retry phase, only cmd.send_component.operation changes
> between iterations; data_pa, data_len, offset, and slot_id remain set
> to the original START values, and pdsc_devcmd_with_data_nomsg() also
> re-issues memcpy_toio(&pdsc->cmd_regs->data, info, info_sz) on every
> poll (potentially up to ~15000 iterations over the 300s timeout at 20ms
> cadence). Does the firmware ignore data_pa/data_len on the STATUS
> opcode, or could it re-initiate DMA from the same buffer? Could the
> status poll send just the operation field?
> 
Firmware ignores data_pa/data_len/offset on STATUS operation. Only the 
operation field is meaningful for polling completion status.

> [ ... ]
> 
>> +static int pdsc_finalize_update(struct pldmfw *context)
>> +{
> [ ... ]
>> +     start_time = jiffies;
>> +     end_time = start_time + (PDSC_FW_INSTALL_TIMEOUT * HZ);
>> +     do {
>> +             err = pdsc_devcmd_finalize_update(pdsc);
>> +             if (!err || err != -EAGAIN)
>> +                     break;
>> +
>> +             dev_dbg(dev, "retrying finalize_update: %pe\n", ERR_PTR(err));
>> +             msleep(20);
>> +     } while (time_before(jiffies, end_time) && err == -EAGAIN);
> 
> [Low]
> Is the !err in if (!err || err != -EAGAIN) intentional? err == 0 already
> satisfies err != -EAGAIN, so the condition reduces to err != -EAGAIN.
Will fix in v7, simplified to just if (err != -EAGAIN).

> [ ... ]
> 
>> +static int pdsc_pldm_firmware_update(struct pdsc *pdsc,
>> +                                  struct devlink_flash_update_params *params,
>> +                                  struct netlink_ext_ack *extack,
>> +                                  const struct firmware *fw)
>> +{
>> +     struct pds_core_fwu_priv priv = {};
>> +     int err;
>> +
>> +     if (!pdsc->fw_components.num_components) {
>> +             err = pdsc_get_component_info(pdsc);
>> +             if (err) {
>> +                     dev_err(pdsc->dev,
>> +                             "Failed to get component info: %pe\n",
>> +                             ERR_PTR(err));
>> +                     return err;
>> +             }
>> +     }
>> +
>> +     if (params->component) {
>> +             u8 type = pdsc_name_to_fw_type(params->component);
>> +
>> +             if (!type || !pdsc_component_type_exists(pdsc, type))
>> +                     return -ENOENT;
>> +     }
>> +
>> +     INIT_LIST_HEAD(&priv.components);
>> +     priv.context.ops = &pdsc_pldmfw_ops;
>> +     priv.context.dev = pdsc->dev;
>> +     priv.params = params;
>> +     priv.pdsc = pdsc;
>> +
>> +     err = pldmfw_flash_image(&priv.context, fw);
>> +     pdsc_free_fwu_priv(&priv);
>> +
>> +     return err;
>> +}
> 
> [Medium]
> The extack parameter is accepted here and struct pds_core_fwu_priv
> declares a netlink_ext_ack *extack field, but priv.extack is never
> assigned, and none of the PLDM callbacks (pdsc_match_record_descs,
> pdsc_send_package_data, pdsc_send_component_table, pdsc_flash_component,
> pdsc_finalize_update) call NL_SET_ERR_MSG_MOD(). The legacy path uses
> extack at multiple call sites ("Firmware wait timed out", "Segment
> download failed", ...). Was the intent to propagate extack diagnostics
> on the PLDM path too, including for the -ENOENT returned above?
Will fix in v7 by adding NL_SET_ERR_MSG_MOD calls to PLDM error paths.

> 
>> +int pdsc_firmware_update(struct pdsc *pdsc,
>> +                      struct devlink_flash_update_params *params,
>> +                      struct netlink_ext_ack *extack)
>> +{
>> +     int err;
>> +
>> +     if (pdsc->dev_ident.version >= PDS_CORE_IDENTITY_VERSION_2 &&
>> +         pdsc->dev_ident.capabilities &
>> +             cpu_to_le64(PDS_CORE_DEV_CAP_PLDM_FW_UPDATE))
>> +             err = pdsc_pldm_firmware_update(pdsc, params, extack,
>> +                                             params->fw);
>> +     else
>> +             err = pdsc_legacy_firmware_update(pdsc, params->fw, extack);
>> +
>> +     /* Invalidate cached component info so next info_get refreshes */
>> +     pdsc->fw_components.num_components = 0;
>> +
>> +     return err;
>> +}
> 
> [Medium]
> What happens here when a user runs:
> 
>      devlink dev flash pci/0000:b5:00.0 file foo component fw.cpld
> 
> against a device that does not advertise PDS_CORE_DEV_CAP_PLDM_FW_UPDATE?
> The dispatcher falls through to pdsc_legacy_firmware_update(pdsc,
> params->fw, extack), which has no notion of components and proceeds to
> flash the entire image.
> 
> The commit message says:
> 
>      Not all components support per-component update - devlink will
>      reject the request if the specified component cannot be updated.
> 
> Should the dispatcher return -EOPNOTSUPP (or similar) when
> params->component != NULL on the legacy path, to match that promise?
The legacy path should reject component parameters, -net fix [1]

> 
>> diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
>> index 619186f26b5b..5a1fafaccf20 100644
>> --- a/include/linux/pds/pds_core_if.h
>> +++ b/include/linux/pds/pds_core_if.h
>> @@ -279,11 +299,20 @@ enum pds_core_fw_control_oper {
>>        PDS_CORE_FW_GET_LIST               = 7,
>>   };
>>
>> +/**
>> + * enum pds_core_fw_slot - Firmware slot identifiers
>> + * @PDS_CORE_FW_SLOT_INVALID: Let firmware select slot based on package metadata
>> + * @PDS_CORE_FW_SLOT_A:       Primary firmware slot A
>> + * @PDS_CORE_FW_SLOT_B:       Primary firmware slot B
>> + * @PDS_CORE_FW_SLOT_GOLD:    Gold/recovery firmware slot
>> + * @PDS_CORE_FW_SLOT_MAX:     Sentinel value indicating no slot resolved
>> + */
>>   enum pds_core_fw_slot {
>>        PDS_CORE_FW_SLOT_INVALID    = 0,
>>        PDS_CORE_FW_SLOT_A          = 1,
>>        PDS_CORE_FW_SLOT_B          = 2,
>>        PDS_CORE_FW_SLOT_GOLD       = 3,
>> +     PDS_CORE_FW_SLOT_MAX        = 0xff,
>>   };
> 
> [Low]
> PDS_CORE_FW_SLOT_MAX is added with value 0xff to this wire-protocol
> enum but has no references anywhere. Should it be wired up to something
> or dropped before the enum value is locked in by firmware?
Firmware uses this value internally as a sentinel. The driver doesn't 
branch on it (relies on response_code), but defining it prevents future 
enum additions from colliding with 0xff.

Thanks,
Nikhil


[1] 
https://lore.kernel.org/netdev/20260708163649.128620-1-nikhil.rao@amd.com

