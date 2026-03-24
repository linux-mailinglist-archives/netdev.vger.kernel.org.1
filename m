Return-Path: <netdev+bounces-271210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L+hDOnOwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:50:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C021B31A53B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39D63303C902
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836038AC7D;
	Tue, 24 Mar 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="OMCJX2Ek"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022103.outbound.protection.outlook.com [40.107.200.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8A3D8111
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374585; cv=fail; b=JdDDBbPqCs1EIhiQfyOw+BTTA+be9TZzzOJ5IUDP4NgN6UHu9VXLrhoxw7sb9k95EQe3W+ksATlbl1n78aIOqcYW/h+Y7fVBCX0EsEP+2sRxONEtJzOBJxONqcum8hkj7VbdScoRTAvcQdFNFyTJrYUIy1FSREKRx43Nn7ozGpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374585; c=relaxed/simple;
	bh=uOR3cp36pRAkqTzqTYm9fsHDCWCqBBJMEsp2KnE1VTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AjUh8jTTWq/Lf7kwrLo1tBOE+sw034orWO01kP43XAgW0/Z9+X53ek+NUpfiOa7+19nkVNNNkFSScBahFgiC3B+IxTeOprZjM/BGFvtT49AN1jfi1jLoPSa2X8dvNFy6YYDLBUScX9ab5lWBI3cGE0VO1wI8qXhOshR/jMG8apg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=OMCJX2Ek reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.200.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQVf2Qr00rnOamIVAGid4VNHTsranFjsajL6a0UN8qUEiCsJjz9jEp6LwCAFpe/1sn2zx3ctyjRnT2qOlTuyJpRM/FnzUEfmYABW/AhDs04lbUp7JSugVLkog0e5kSJ5TFE2hWqtwtAzfDTX2U6ohP/gDrn0zTg1YsM82v9C28UTi/UX7NRJqUv0RNe4hrrdSepp3HUUTXAH5aQ3JGqXPAPqYwqfbp5ik5SsT6fZ1TBFGQ9QSaH6hWxXJLHqJMbX90GIPB+Z3rfe7d2TWdYOwreramClch4IV85GKoZpYSi8st5lrN2Q4ZacEXlHsOxBytsYtjdWGLhPsTRs8hYMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaCbTlZTaWQmprQq4pK/myCXI7+1KAvUpIfTFDOnkW8=;
 b=hdvvKYjzE3wtY/ss7pg7JyUMqyeQMNiMGrKt58+LkaZYSjCFPunPrIEP2IF6tC7pbVSJ/NAs2nRf8rA4dizOQgdsWXrgM+ODAmA0kYuiMQgD+OMDOXlPV97KaDXbOTYCDSHuMzYIo+Ni1N9YGWCJsxS+7+OJYOoOUra5fOCpuzcXmnl28zvPEP5n8Ci/qzVYoXQ/66QuZNzeLAuEFGeH91QqK3ZbCyq/6mFrPMcDo+OSb9AWk3lFDOYezvl91bRRXQBfYircERui/fxLYXAOx9KQUfMWfTkFSxawIzUejNKvfCPbjpyqpiecREEt0fWqeSQ0Ufs+FA5VFQ0lNr3JXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaCbTlZTaWQmprQq4pK/myCXI7+1KAvUpIfTFDOnkW8=;
 b=OMCJX2EkZ3JVVLurTpOxypcW1sy/7TPvEPOjxzdQp5M1xi37q4do000TRV2z7Kddjt89kI9qIuU8RVKbPn46UEQJ9DhfICcMRrhg9lawK0dD662N5ftPabOk/RTw5hEAw68ENVHL/WDXVxVmKCz6Iz0RHqsJUODfocCC4fj0yto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8244.prod.exchangelabs.com (2603:10b6:930:b9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.31; Tue, 24 Mar 2026 17:49:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 17:49:34 +0000
Message-ID: <d4d7aa10-10f1-4321-9476-266ce7fc7c31@amperemail.onmicrosoft.com>
Date: Tue, 24 Mar 2026 13:49:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 13/13] net/mlx5: Add a shared devlink instance
 for PFs on same chip
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
References: <20260312100407.551173-1-jiri@resnulli.us>
 <20260312100407.551173-14-jiri@resnulli.us>
 <bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com>
 <c37ee2a7-8e19-4aaa-aaf3-4cd5a9c171d1@amperemail.onmicrosoft.com>
 <ib6r4armffxw3f56fxxor3bg4ejhnsfg5ddg4dncae5u6lonty@ds6bfkjoykbl>
 <sim5ddxllwk5dwnbax4w4ieseziqnis7j2hr2vffaymzsvxcsw@b5q2r4shnlg7>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <sim5ddxllwk5dwnbax4w4ieseziqnis7j2hr2vffaymzsvxcsw@b5q2r4shnlg7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0087.namprd19.prod.outlook.com
 (2603:10b6:930:83::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 580bbbb6-914b-4b11-4fbe-08de89cdb5dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|7053199007|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	gKzf1NABvG6duOPLYv/tCVDzaY5L1EZQ+E06kxXLcpjKejOKx6Yw4Tf/xernytNhLGkmQe8OUgryo/L0DZLcHpf6/HKGVbiHgvsH6qtH0P2/xz+cv+imX1AwUG4ET8vZ6S6L0JJZXQmBVOJDtG29ws5KlHDjR9Bb7jnly6WVbnXj2sdZ1skF2inSHRpfakEIi+lVmu9eTsZTkkFex6smwHo+iS7Bj4th/jvBy4d2/8clYseD2/yKXKgQk594UfOaKM+/sRQOdrNp/XDTlbOkVKgpe5/HzhtDPcwbWpYtL2LaSoAo0u1wr6ZhWbNIeqXKQK5L+OZubO7Q7WT54MDKWycj+2c/Q6l+QCrWn6k+rmoRwGGEXEDMGM7A9nSUjlJxfyC7WRd0W9O1qWE+PdtExs5DZ38nFUfo8PjTn9usjQz61rVFoQdMD7hFvtk1ZTNY06TNLRTrLvE8DM6ajkt72/ggSXmpqt7XR3pPYir1vdV4K6DnRKTqMPo7wk2pt2QfxnS/betBNFLBJvhCJCH9RoHPL7vzQRht1Xa3Vf+nHhpbO0kITTispheNhZJlWDGBeu7LpM0yyhv6TU7cdpJv4yhK29iKm7hYKOtkJe8W5yLkPKVWmr8+ZwFFNgF0NCZ453EEWq9gN93RA4O9NBbj20yDM4LCWtIrQeqKMFNNU5KmMEokx5LfF3qrs39VfTCLu5vs7wCOPGslOcwXR6JQiVbjYhZddKAE/vAj+AVKhm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(7053199007)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXArSDE5QWcrMWdtYW1RV1pabnRrS3IzS0JlRTYrV0ExekpXMzZINnRmMHdL?=
 =?utf-8?B?ekRiN3d1MmEzN2xGRmZJRitRZUR6c25jV1BNYWxlbE9lZ29LcWUwRytBSjJD?=
 =?utf-8?B?VkZIc1FhcUpMNWVaTmlybzFPUGtXSk9MdXl5OEUvV1F6ZGlIRVE0cklPN2hL?=
 =?utf-8?B?TXMxMXkwTGpHNEpSTWVNRTBQcmphY1JaV1dpNmlaV1FMRUNBOTVVa2M4cytt?=
 =?utf-8?B?UERWVVVqQkw2K3k1Q3V2cGpvK05KZGIrWEZ2S0J1bWxpdUg5R3E3TGEybG03?=
 =?utf-8?B?dmRremZBYmFqc2pEbnorNUlYaU5ieVYyVHVXRnVINDluNXZrWTV1VTZvNUxj?=
 =?utf-8?B?d1E5UU1QRjNSMGJPaVoyQXo1aGp2R1Q3M2xobEN6TE5zZXcvSm1IZVcxd2JE?=
 =?utf-8?B?Y0dMV0p6V0hIdGZKclBweGhhbG1IZ0V3TnV3RGJ4NjIrblhqTDA4Y2RSSCtv?=
 =?utf-8?B?dHgrTlBaVWFIcnFqSHhrM1NZbzZyZmJ2QXNwL2ZIRjh0d1p5S1ZkZU4yaWxj?=
 =?utf-8?B?SU9SMi9ZSDlTRWtnNHNlT0F6WTFncmd6TXJHK0pZUmF6MWh0S2pWNExTbTBO?=
 =?utf-8?B?K3BMNXJQS0d5WGJDMDc4Zk5BRkVJMjBZSTJtY3JaUmcwbU9sbGtSTTlRQmha?=
 =?utf-8?B?c2g1WjBTMk1vUEZMeGpvYStiay9NZk9Gdkg5Y042K05KeUd3ZjVjdDJrNXRB?=
 =?utf-8?B?bitWUXVzcThYMDRPUTdNUHIwMjFoRTZ1dDJGekVhYzZacXhvaWhiektiTWVv?=
 =?utf-8?B?ZFhvcDVSdGxKWjNpWmZFVmRUbVNPeU5nVlV6RW1RY1VQV3lPcE1kMFFxMFYw?=
 =?utf-8?B?SmhFbHVncjBQU20rZVdHbzNvVHdqbnJvWkdjbjMwU2c0bkFFcE9UZ25nWXo3?=
 =?utf-8?B?MGI4Q3o5QTA2MUhwRk9qZTdoQ3dIeXdvOGQ5TXpPU0lLYy8xcXFBMjZaOEx2?=
 =?utf-8?B?ZUU1R0xMdGNtZTFscVRIY3QwVkk4TVkwN1c0b0U1ZVBEV0RtUW5uaU5BS1lM?=
 =?utf-8?B?cGR0M1dWUWRtV211VmVtUUhNaEo4a2J4VnlLRjJncUo2UW55UnU0VldrMTBI?=
 =?utf-8?B?dUc5djFuS1h4aUdtVDJoOFhYNS9HQTZsaWFDVmN3QWRMN3BWcUxUQVpSTnlx?=
 =?utf-8?B?UmVFMlpXa2d2SEI0anJtRXAxY2pIb1pwWmlQL2xqb0tjWlpHZXZjQXJ4Sy9Q?=
 =?utf-8?B?bGt2R21hQ3hLSXRUMy9TU1JqM01SV3RwTWJlWU5WK1psZm9mVTlaR0FvSWhv?=
 =?utf-8?B?alJtc0Rpa0JSQmxZNDRPNTJoOHZCRFhTeTJOeUkyODJNRzBUaFQ2anFVdkYx?=
 =?utf-8?B?ZHZtUm1SR1p1WG9DbFNQTkY0dTAvNDFqRmp3TWpsTWU4aHFVQi91VGEyL2s2?=
 =?utf-8?B?WmtsZDNzaG0rRWlqNHhaVHYyS2JFRHlpYm1ObFFUWC8zc2t2RXhHaU9XQzJF?=
 =?utf-8?B?QTMwbjZMWndDSmN4ek1yWFFvMVhwT2pUWW81enZ2U2dXRVpBUnpQVHFybGR4?=
 =?utf-8?B?SGdpSHZFZ2pHU2pVYnk0Qm9yVXc0bzB1RUdpMVFqQjRCZHpkOEEyeVlFV0Zt?=
 =?utf-8?B?V3VkSzFUajU4ano0aVF4aDVuLy9nWk1yLzlBR2F1STcwWlpTSkNrMHdUZWJY?=
 =?utf-8?B?YjRIK1AzWU0xM3lURTd2Y2s4aVhJV3VVc0JRaDJqWm1Zb3N5VU9USUpBTzFX?=
 =?utf-8?B?ZFl2M0pNQ0RWQ1BNVWhEOVA2cjdUYWdCK2J5QnhubVFwQTA0SEFsVmJ4VHRz?=
 =?utf-8?B?TzhWcUcrWXJJdnZFVTExMkNXUHZYdHR2cURjMklYdlROcVNYT25kWnRLT21W?=
 =?utf-8?B?Z0pxblV3cGR6UG1JeVhpQmdxeHU1R3RPT09nSXhRajEzRVh4WmFGRi9nc1JY?=
 =?utf-8?B?S3QybFVYYzhMVFVTSWk2aWJPMGYwaVJ6NXIyd2orQk12KzVsdmJYM3lWRnpk?=
 =?utf-8?B?OXF5UHFJeVU2YnBjTU1LcDFYRVJIa2ZCMi8rVHE0MFhTMHdTN2JMNnp6Q2dC?=
 =?utf-8?B?TlVXVWdmWXRCVEFiSXNKUE53NjR3WFpSYk1raUJoZFhRZU1GNDFIOWV5cTI5?=
 =?utf-8?B?STlvVVdkWFYwV2dTVGRRM2RvT0FqS3JZbFlWOEVlQUxzNExBNDBvWjNVSHhH?=
 =?utf-8?B?RU5YeVhBZVBhdk4xNUZOT3FMeGJkb0I3bHlhS1RJRjNrck43TmtmcXVBZVNM?=
 =?utf-8?B?Z2dCUGVQS0pkZW1WZGVvZTlUTllqS2xPL1hkRVRXdFJnM3NBOUF0cVdnMjNz?=
 =?utf-8?B?L0EzSmRpZ09KVVNOTXlhdDZYZWRGMXZyZjRqUHZjQUFUeG5EN2xwQWNNNjFN?=
 =?utf-8?B?OE9pZElrVll0aHFxLzJWUFplME5YRnk5dVpBMUlmTzJkdkRvUm45SWFDbkEy?=
 =?utf-8?Q?ODDfBI5uVq3p+7lVwCxbomTBpvp+r85F/g9syEeEqmHI5?=
X-MS-Exchange-AntiSpam-MessageData-1:
	ZA00ToYghs21Ctf6WyaaYgJhy4QhZrMK696+EIh4lqQsfxOy4wa8wEXV
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580bbbb6-914b-4b11-4fbe-08de89cdb5dc
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:49:34.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEVTa5+tBg6TheJe9pG4svTCfJlmKIKPgJDl5zuafGnHFq7C4x3AfxWccZ4rq9kMojBO5MkQY2SSCBY4Xt7KhaV3f4+dwgaWzvicgU94/gFMxyU8vQTYsyDe5+br4fvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8244
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271210-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[onmicrosoft.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,onmicrosoft.com:email,mellanox.com:email,resnulli.us:email,amperemail.onmicrosoft.com:mid]
X-Rspamd-Queue-Id: C021B31A53B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 09:02, Jiri Pirko wrote:
> Mon, Mar 23, 2026 at 04:05:19PM +0100, jiri@resnulli.us wrote:
>> Sat, Mar 21, 2026 at 12:37:06AM +0100, admiyo@amperemail.onmicrosoft.com wrote:
>>>
>>> 0005:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family
>>> [ConnectX-4 Lx]
>> Cool. Will try to reproduce this locally. Thanks!
>>
> Hi. Testing this with:
> 08:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
> works fine. What's your output of "devlink dev info"?

Running on 6.18.6:

# devlink dev info
pci/0005:01:00.0:
   driver mlx5_core
   versions:
       fixed:
         fw.psid MT_2420110034
       running:
         fw.version 14.32.1010
         fw 14.32.1010
       stored:
         fw.version 14.32.1010
         fw 14.32.1010
auxiliary/mlx5_core.eth.0:
   driver mlx5_core.eth
pci/0005:01:00.1:
   driver mlx5_core
   versions:
       fixed:
         fw.psid MT_2420110034
       running:
         fw.version 14.32.1010
         fw 14.32.1010
       stored:
         fw.version 14.32.1010
         fw 14.32.1010
auxiliary/mlx5_core.eth.1:
   driver mlx5_core.eth



>
>
>>
>>
>>> 0005:01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family
>>> [ConnectX-4 Lx]
>>>
>>> On 3/20/26 19:16, Adam Young wrote:
>>>> This breaks on my system:
>>>>
>>>> On 7.0.0 It boots fine.  With net-next/main currently at this commit
>>>>
>>>>
>>>> commit 8737d7194d6d5947c3d7d8813895b44a25b84477 (net-next/main,
>>>> net-next/HEAD)
>>>> Author: Lorenzo Bianconi <lorenzo@kernel.org>
>>>> Date:   Fri Mar 13 17:28:36 2026 +0100
>>>>
>>>> I get:
>>>>
>>>> [   21.859081] mlx5_core 0005:01:00.0: probe_one:2017:(pid 10):
>>>> mlx5_shd_init failed with error code -2
>>>> [   21.863266] mlx5_core 0005:01:00.0: probe with driver mlx5_core failed
>>>> with error -2
>>>> [   21.866360] mlx5_core 0005:01:00.1: probe_one:2017:(pid 10):
>>>> mlx5_shd_init failed with error code -2
>>>> [   21.869937] mlx5_core 0005:01:00.1: probe with driver mlx5_core failed
>>>> with error -2
>>>>
>>>>
>>>> I am happy to help debug:   what do you need from me?
>>>>
>>>>
>>>> On 3/12/26 06:04, Jiri Pirko wrote:
>>>>> From: Jiri Pirko <jiri@nvidia.com>
>>>>>
>>>>> Use the previously introduced shared devlink infrastructure to create
>>>>> a shared devlink instance for mlx5 PFs that reside on the same physical
>>>>> chip. The shared instance is identified by the chip's serial number
>>>>> extracted from PCI VPD (V3 keyword, with fallback to serial number
>>>>> for older devices).
>>>>>
>>>>> Each PF that probes calls mlx5_shd_init() which extracts the chip serial
>>>>> number and uses devlink_shd_get() to get or create the shared instance.
>>>>> When a PF is removed, mlx5_shd_uninit() calls devlink_shd_put()
>>>>> to release the reference. The shared instance is automatically destroyed
>>>>> when the last PF is removed.
>>>>>
>>>>> Make the PF devlink instances nested in this shared devlink instance,
>>>>> allowing userspace to identify which PFs belong to the same physical
>>>>> chip.
>>>>>
>>>>> Example:
>>>>>
>>>>> pci/0000:08:00.0: index 0
>>>>>     nested_devlink:
>>>>>       auxiliary/mlx5_core.eth.0
>>>>> devlink_index/1: index 1
>>>>>     nested_devlink:
>>>>>       pci/0000:08:00.0
>>>>>       pci/0000:08:00.1
>>>>> auxiliary/mlx5_core.eth.0: index 2
>>>>> pci/0000:08:00.1: index 3
>>>>>     nested_devlink:
>>>>>       auxiliary/mlx5_core.eth.1
>>>>> auxiliary/mlx5_core.eth.1: index 4
>>>>>
>>>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>>>> ---
>>>>> v2->v3:
>>>>> - removed "const" from "sn"
>>>>> - passing driver pointer to devlink_shd_get()
>>>>> ---
>>>>>    .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
>>>>>    .../net/ethernet/mellanox/mlx5/core/main.c    | 17 ++++++
>>>>>    .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 61 +++++++++++++++++++
>>>>>    .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
>>>>>    include/linux/mlx5/driver.h                   |  1 +
>>>>>    5 files changed, 94 insertions(+), 2 deletions(-)
>>>>>    create mode 100644
>>>>> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>>    create mode 100644
>>>>> drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>>
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> index 8ffa286a18f5..d39fe9c4a87c 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> @@ -16,8 +16,9 @@ mlx5_core-y :=    main.o cmd.o debugfs.o fw.o eq.o
>>>>> uar.o pagealloc.o \
>>>>>            transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
>>>>>            fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o
>>>>> dev.o events.o wq.o lib/gid.o \
>>>>>            lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o
>>>>> diag/fs_tracepoint.o \
>>>>> -        diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o
>>>>> diag/reporter_vnic.o \
>>>>> -        fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
>>>>> lib/nv_param.o
>>>>> +        diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o
>>>>> diag/rsc_dump.o \
>>>>> +        diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o
>>>>> wc.o fs_pool.o \
>>>>> +        lib/nv_param.o
>>>>>      #
>>>>>    # Netdev basic
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> index fdc3ba20912e..1c35c3fc3bb3 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>>> @@ -74,6 +74,7 @@
>>>>>    #include "mlx5_irq.h"
>>>>>    #include "hwmon.h"
>>>>>    #include "lag/lag.h"
>>>>> +#include "sh_devlink.h"
>>>>>      MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>>>>>    MODULE_DESCRIPTION("Mellanox 5th generation network adapters
>>>>> (ConnectX series) core driver");
>>>>> @@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>>>>        int err;
>>>>>          devl_lock(devlink);
>>>>> +    if (dev->shd) {
>>>>> +        err = devl_nested_devlink_set(dev->shd, devlink);
>>>>> +        if (err)
>>>>> +            goto unlock;
>>>>> +    }
>>>>>        devl_register(devlink);
>>>>>        err = mlx5_init_one_devl_locked(dev);
>>>>>        if (err)
>>>>>            devl_unregister(devlink);
>>>>> +unlock:
>>>>>        devl_unlock(devlink);
>>>>>        return err;
>>>>>    }
>>>>> @@ -2005,6 +2012,13 @@ static int probe_one(struct pci_dev *pdev,
>>>>> const struct pci_device_id *id)
>>>>>            goto pci_init_err;
>>>>>        }
>>>>>    +    err = mlx5_shd_init(dev);
>>>>> +    if (err) {
>>>>> +        mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
>>>>> +                  err);
>>>>> +        goto shd_init_err;
>>>>> +    }
>>>>> +
>>>>>        err = mlx5_init_one(dev);
>>>>>        if (err) {
>>>>>            mlx5_core_err(dev, "mlx5_init_one failed with error code
>>>>> %d\n",
>>>>> @@ -2018,6 +2032,8 @@ static int probe_one(struct pci_dev *pdev,
>>>>> const struct pci_device_id *id)
>>>>>        return 0;
>>>>>      err_init_one:
>>>>> +    mlx5_shd_uninit(dev);
>>>>> +shd_init_err:
>>>>>        mlx5_pci_close(dev);
>>>>>    pci_init_err:
>>>>>        mlx5_mdev_uninit(dev);
>>>>> @@ -2039,6 +2055,7 @@ static void remove_one(struct pci_dev *pdev)
>>>>>        mlx5_drain_health_wq(dev);
>>>>>        mlx5_sriov_disable(pdev, false);
>>>>>        mlx5_uninit_one(dev);
>>>>> +    mlx5_shd_uninit(dev);
>>>>>        mlx5_pci_close(dev);
>>>>>        mlx5_mdev_uninit(dev);
>>>>>        mlx5_adev_idx_free(dev->priv.adev_idx);
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>> new file mode 100644
>>>>> index 000000000000..bc33f95302df
>>>>> --- /dev/null
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
>>>>> @@ -0,0 +1,61 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>>>>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>>>>> reserved. */
>>>>> +
>>>>> +#include <linux/mlx5/driver.h>
>>>>> +#include <net/devlink.h>
>>>>> +
>>>>> +#include "sh_devlink.h"
>>>>> +
>>>>> +static const struct devlink_ops mlx5_shd_ops = {
>>>>> +};
>>>>> +
>>>>> +int mlx5_shd_init(struct mlx5_core_dev *dev)
>>>>> +{
>>>>> +    u8 *vpd_data __free(kfree) = NULL;
>>>>> +    struct pci_dev *pdev = dev->pdev;
>>>>> +    unsigned int vpd_size, kw_len;
>>>>> +    struct devlink *devlink;
>>>>> +    char *sn, *end;
>>>>> +    int start;
>>>>> +    int err;
>>>>> +
>>>>> +    if (!mlx5_core_is_pf(dev))
>>>>> +        return 0;
>>>>> +
>>>>> +    vpd_data = pci_vpd_alloc(pdev, &vpd_size);
>>>>> +    if (IS_ERR(vpd_data)) {
>>>>> +        err = PTR_ERR(vpd_data);
>>>>> +        return err == -ENODEV ? 0 : err;
>>>>> +    }
>>>>> +    start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3",
>>>>> &kw_len);
>>>>> +    if (start < 0) {
>>>>> +        /* Fall-back to SN for older devices. */
>>>>> +        start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>>>>> +                             PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>>>>> +        if (start < 0)
>>>>> +            return -ENOENT;
>>>>> +    }
>>>>> +    sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>>>>> +    if (!sn)
>>>>> +        return -ENOMEM;
>>>>> +    /* Firmware may return spaces at the end of the string, strip
>>>>> it. */
>>>>> +    end = strchrnul(sn, ' ');
>>>>> +    *end = '\0';
>>>>> +
>>>>> +    /* Get or create shared devlink instance */
>>>>> +    devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0, pdev->dev.driver);
>>>>> +    kfree(sn);
>>>>> +    if (!devlink)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    dev->shd = devlink;
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev)
>>>>> +{
>>>>> +    if (!dev->shd)
>>>>> +        return;
>>>>> +
>>>>> +    devlink_shd_put(dev->shd);
>>>>> +}
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>> new file mode 100644
>>>>> index 000000000000..8ab8d6940227
>>>>> --- /dev/null
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
>>>>> @@ -0,0 +1,12 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>>>>> +/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights
>>>>> reserved. */
>>>>> +
>>>>> +#ifndef __MLX5_SH_DEVLINK_H__
>>>>> +#define __MLX5_SH_DEVLINK_H__
>>>>> +
>>>>> +#include <linux/mlx5/driver.h>
>>>>> +
>>>>> +int mlx5_shd_init(struct mlx5_core_dev *dev);
>>>>> +void mlx5_shd_uninit(struct mlx5_core_dev *dev);
>>>>> +
>>>>> +#endif /* __MLX5_SH_DEVLINK_H__ */
>>>>> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>>>>> index 04dcd09f7517..1268fcf35ec7 100644
>>>>> --- a/include/linux/mlx5/driver.h
>>>>> +++ b/include/linux/mlx5/driver.h
>>>>> @@ -798,6 +798,7 @@ struct mlx5_core_dev {
>>>>>        enum mlx5_wc_state wc_state;
>>>>>        /* sync write combining state */
>>>>>        struct mutex wc_state_lock;
>>>>> +    struct devlink *shd;
>>>>>    };
>>>>>      struct mlx5_db {

