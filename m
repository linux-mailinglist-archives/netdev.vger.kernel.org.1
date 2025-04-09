Return-Path: <netdev+bounces-180574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA1A81B9A
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F574A99B6
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597D41B85F8;
	Wed,  9 Apr 2025 03:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819C84A3E
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169756; cv=fail; b=t9YMEeT+mjghC8/2yLdAx5hC+1fu66j1G9pNZghmt53ASiqeA8xCD7yDUJ5Y130gQKM+x/kZYMbLdq6W90eFKME3npY60ZHlP3nU1QhaAoDU+pTYNkrreWC4TiGV4KZHUaddcwhHL/gnrUt0lHHvTT7B8IJBMreAwG5SzfQFmH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169756; c=relaxed/simple;
	bh=c81aScnhIfm8T/7IndQYoQIBXFNPF/Zewgj5R/7echI=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=BTtird6PzOviJP2Nyf12Y2gCGLBjVt4oPf+f+X/Zs3vRPILyM7bFiFRWCTfNpLhGVHhH+X7DK7TWKc8AxTPQ1AR7CY7xvd2e1KJx8Zcj78OX2aRkiwkRIsYZNbha2pPVpn7Nq4vjjlFbrRqjg0+rYJ8Byv7ENjkZOzpRTqNyZnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5391OVFQ011193
	for <netdev@vger.kernel.org>; Tue, 8 Apr 2025 20:35:48 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4cprx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 20:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOkOt6Rc6I5bUopjXU00NTah6W0TBX0JUvXSPNXb8zReOZ0HPyQc/tBtq+N3uCE73C2j8s8IDwW+dFnOMuHAnOagetQNjDEGalA0UvQYyTvYtiMtYaTKevyPSWOyUHx/54kOsdeeGYWMjnMtpOCCd0geT/6Au1BFaxJUBgj0GEzHyl2fTeZVpqZrxMJbRJl6hACiuTxe7mKSDT3tW5YWbLIK+NwjhKYmMSA5a48z7vNuJOr2A0ZtreK5nrXmR37P1lgedCFKmcTVSVn5gJX/O0QKsfYUnwC/sjL36PbY+aGiWNrzPBtdhvSSHVwBmTdTDTe+01RO29VnegUCP2JrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuIlOlpWxXTXUuTYMTosHoSBz8BKhFH46LY16dXKcHA=;
 b=crApim4IPpf5P1f1DusvFTABeOB8S72D4/HyAfAolkbXc0fBl+qsTway9lzijUjpWwYDDzvf98zRS69RbdlNw3oHHKHfoG09GrgCpEXW8+ghMJsec7K+3jIREE+7yTgwkYJk+pbtYOEb5Ko++qFkF3ck88FDse3BffAWUEKv7MMuw8+P6kuL0bucqwqijkFDveEbW3yz3ycAqV6dQnpnH91SKo3dthkeZ6fDIU2ZaQfgg6mLACSvPGziToysqvrnEVqN38rus8dR4I9ROOGN6uUs6S6JIcNEgPdxba93BZ7viEJe6Nt1WYyjeALErXvRVmBBdJSrdm5omRfqX+hjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 03:35:46 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:35:46 +0000
Message-ID: <a3e3643e-48e6-4b51-8449-2725722ad038@windriver.com>
Date: Wed, 9 Apr 2025 11:35:40 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Changqing Li <changqing.li@windriver.com>
From: Changqing Li <changqing.li@windriver.com>
Subject: About package version of brctl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0046.apcprd06.prod.outlook.com
 (2603:1096:404:2e::34) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SN7PR11MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 17283150-2b5f-42f8-820a-08dd77179d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUQrakxEQkFuVlNDeTJDN1VNT1hOdVViK3VuZ3NsclNWUDVaaXpUN1lMZ3ZW?=
 =?utf-8?B?V2tlZFJaVDBlNmhhcEFCdTBZeDk4cmxCQU5KSm1JUGxRdlE2d2tKMmhyTGF5?=
 =?utf-8?B?RDh5L3AvWTQwbU02aHg1ZE0vVnlGdXVveTRKdGgzZTRHNG5vU25BZXFRSGhW?=
 =?utf-8?B?YXJlbytZY3g4cW8vTG5WWURIWklseXpONmdVUEJxT2xlT3J3V29TQVgxMCt6?=
 =?utf-8?B?L1ZJSFFaVFZVTTR6blhTL0x3b29kNTMyQnZMUzBobGpDNXl5Uk5UVFh1OFNm?=
 =?utf-8?B?K3I2ZUI5bVZjNmNSOStNd2FTWjhFbm1melFBaUJ1Z3ZadFlhcllIeUZzZ0NX?=
 =?utf-8?B?eXBoNGZjbkVlWXNZZWRhYjJWK2JBVm5iOXlMbmlCcTY5dmlZZ0k1Y0NQS1lx?=
 =?utf-8?B?Y1ZXdmxYSlFqalBBZzBjdUszMTNubUlKOC9jaUFxa0JpVHp5MzdabGVZS0Nm?=
 =?utf-8?B?akd4MHpsQjJTV3ltVUR6RUNiSXJuc2ZPUDNiTjR6bDEyZW04MHhhTEd1VmJR?=
 =?utf-8?B?KzFiT05RR0dad3VwaTM2aGVHWEs2LzZzZHRSalpLZjJPNk5KdlFqbGNicDZu?=
 =?utf-8?B?cE13RVhjK3pYcjZ0M3lKUGRINXliY0t2QmJ0VytKVis0U0VkeUw3RmtNNWh2?=
 =?utf-8?B?N3AyTFdMelVLQllURi9ZMlZzR1o2UzJHMnozTTRGeW5WRDJmMkJ4a21nbTJS?=
 =?utf-8?B?NHF5dDRxRW9OYnhwcVFCWXEyY2NnOXNqcWZFRDdMTlRrWmJHdEVzRDBMSC85?=
 =?utf-8?B?Q1hzSC9VdHh6ZmFISHVpSnYzMzFkSXA0UFBZRStVYWxyZ1M5Q1NjbUlIM1R5?=
 =?utf-8?B?YzlBL2pqakpnaE1vTVZDMVg5SzM4dUJxZVR1QlNQS0srR28vSVFxYnY4elZD?=
 =?utf-8?B?aWM1ZkZmNDNBZldiSU90ODhIOFdZQmdGdmdpdVF2T1BwZ3B1OFhEKzVPd2p6?=
 =?utf-8?B?TVF2TDFYdmR4TjBwaVZzRDFOVVRHYlhPL0prelNsQy8veDNQVGZhREVvSXdl?=
 =?utf-8?B?TTYxSklsbUpLenhyRHl0bnFscnhERjBlbUF3NUl0QXAwdWdobHFZcDRsOUQ5?=
 =?utf-8?B?ZnZidXVMZS9mNmlKWFRseFhIMFMwcjRiQmtFNkVBblBUTURSMDljTTVOMGVE?=
 =?utf-8?B?RWxHVUVrQzM4c211TUY4eEltUGswaUVNVlJzaXlmQzloSE1XaVVQaHRtalZW?=
 =?utf-8?B?dS9BMlEvQ0YxN2hrdi9HdFZuZC9ETnprR2Z4U3pMS090eEN4Y1kvTVp5Yzh1?=
 =?utf-8?B?WlVhNUVnVmRXWC9tSDdYcEtSN20rdVAxRDlWTXNyNExKMmR6NUpMN3pGd3hO?=
 =?utf-8?B?NEVwS0RVNkhSZTRXZmRBMUZ3eEwwKzVORmw5WW5SRWZWM1ZWb044QVc3RkFh?=
 =?utf-8?B?QWpFZis5dndMeE4rbnJkUDRwbjNsWk5sMmREalNtbWVjR2VxZTBEb1B6SnVw?=
 =?utf-8?B?bXJKRGFDYnFjemNDMkcvNUpEc1hOaWZmdWgvUzhBV2J5MzJTNWhrZzVFcEoy?=
 =?utf-8?B?dHhJdmoyQXU4VUlORmlTcWJSRThGV2hYbmFtMmNCTXZLckhpb1NnOFlUUG1Y?=
 =?utf-8?B?aXg1eXF6RHBiWi9ETFVRcmExV1htVllibmlyb3JHaWZqcS93WFNmSCttdHl5?=
 =?utf-8?B?ZTNzNTE2TmFITTlhK3ZOWGEyMlFtWURNK01EQXVkRHdLbXg4NVhhWjJaZjlE?=
 =?utf-8?B?dVlyelRuUlVqd05DTXBXbDI0QnVXYVB3S0ZoTFM3WXJwTGlmQ0RMMnUzZjNY?=
 =?utf-8?B?dndpT1lDaC9EelNQcWZtcHBqaHZndnJSWGRpZ2FCd050eW5Sb0xxWVhEWE4x?=
 =?utf-8?B?dnVGeDRFYUhhM3lRdW1iay9CQlFmdkJ6a084R1ZmcTBadXRURU9IZHhsQjlx?=
 =?utf-8?B?SytBeGQ4VDA0dmNuVHNRaVdFWkJCU2NlWDFqMnlwOTNiZWRpSGZjd1F0VlMv?=
 =?utf-8?Q?mbeSmyitdk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGg4UThXK3dZZ3lIeWJpNFBiU2d0YnQyNkpNUnZmNEJxamVqeStlenF4RWwv?=
 =?utf-8?B?QzUxS2lHUTlEY3ljSmxWMjJmZDlxUWIxdmNHN3dmSldwbHgvWU1HYzJvbGV6?=
 =?utf-8?B?T25vVHBQM3haN2E0dFdydU1HUmx1MDdRc3poTGVMa29TczhTNFRJQWs3NU5X?=
 =?utf-8?B?cVEwaXlrcXBlRml6VkZlZGswempSQUFJQ1NtVWpWZ0ZKYWpWT2Z1V3BmNVI3?=
 =?utf-8?B?YUtvZ1NGaEZTdWZwdFRyU2hIbmhTK1pWSkJWRWxlNFpCcEZmTkkydStJYjda?=
 =?utf-8?B?MnpUNWJuUHJ6U0N6Y0ZxUE8ya29lVmtLTjBTV2JZUThOUXdSV2hPU0RQRDBS?=
 =?utf-8?B?ZlIxNmp4aVlLTzhUVVNzVTYxdGQxZUFFT3VFV1Zreit1Yzc1bk04RnZFSjNo?=
 =?utf-8?B?YktITU1sVHNPUVBhUlc2TGxIY2wrU1dhOTA2ZG92OFVCMlBtSHhaWGVaU1V3?=
 =?utf-8?B?T3NKSStrNHRPbkpXZ3RjN3Fta1EraG1OUkJadHBoaW8vSU14NUZXMVVrazBT?=
 =?utf-8?B?RU9jQ0VJK2JGUDZUeVQ2aVAwamlzaXdnWjhiTnU2THdrYlVGOUhPdXJGc1FM?=
 =?utf-8?B?YXQ1MUFCSmFWSXZlRlNMVWh6eDBvdXhvYzYrb1ZSOTZOVjNiMU5MZ1ZKMEth?=
 =?utf-8?B?UjNDU09maGZoTHlJSDF6VHJxUGFtUGVVYmJsTXBOaXlWN3oweFRwNnloR1hj?=
 =?utf-8?B?U29nZkNQZzBnMzcyeFBFcTJtUVhzZXovVk9jY3ErekEvdUM2NzBCeFJteFd0?=
 =?utf-8?B?RXN5K1BGN3ZyVnRlMzZLU2lidEM2MGRleUNKczBhL3pPRk1NWnIrWnlxRytX?=
 =?utf-8?B?U3FEQ3NpcVBqTkJHbk55dmVpaTVoQk1RL2FlSzFFVlp4cUFobDB5aUxlUlh6?=
 =?utf-8?B?R0IzaXBhTjZpSmtadDBKdFFnVC9pYktFZHI2RHdOMGFTQkxmK0ttRkhBR01t?=
 =?utf-8?B?TzExbUlNQUVZTEhZTS9rN3cxRmN0NjJxYnRhVkd4SFRyZU10UUlHMStMam9q?=
 =?utf-8?B?aDdsNFM1K3NNdVZaWDd6WFNIY3dLYm5FbittcFp1b2RwcGgyQ3pYM3ZWYzdF?=
 =?utf-8?B?MlFHRGJzWGc2eFVxd3lhTlF2bSt5NnJrNER2bVR3Zi9nbTVsTXlHdEJ5S0xl?=
 =?utf-8?B?UU02SkhJTlgzTnQ2dm9XZmU5SnY0b1lHRC9uc3hZaWFJQ0luQnYwUVd1aFNY?=
 =?utf-8?B?VzlBbnlxbzh3OHFqc2pnY3BaVlREWlNPdjAyRk1SY01xakhvL0ZTWW5RdkR6?=
 =?utf-8?B?SDZPVitxbXQ1a040aG1qb1kraEFWSkdLT3dZM2JWS2JBSUNRSWVuejl1Nmg3?=
 =?utf-8?B?VGFmNDNDZFhVVUgxMEJrc28vblVLZjgwK0dqaDV5eUR1L1FXa1lCNlc2ZXo1?=
 =?utf-8?B?aHA2T3hIYlFrTmp2Nm5pVVZQYmp0TXZPRXNzVUxQVmN4UXR5TmhRQUtJVis2?=
 =?utf-8?B?ZnIwV3lpYXNLQlM3ZEp4ZHY2TklNTW1sV0xFdGtuQXV0S3FLRGEzdGk1NzVQ?=
 =?utf-8?B?V3dlL1ZoMitObVBoWUt1Qklyc2dhSERnS3N5K3RNNTFLRUNDS3hvMlB0bW9o?=
 =?utf-8?B?SGVDb2wwcDNmejN6YjN2dHFvTXZ2Vk9uZjlIWXkxZjNoeDI5RndDQ082YXJ4?=
 =?utf-8?B?UDk2SzU1cHBkbFFDVHJXQ1BhdWt5L2NkbjQ1WDlacjQ4alVmUC9VS3A0YjVG?=
 =?utf-8?B?R0p5djI5UFpCV1I0cXpXSFJZNkp5QkNHRjVjT0V3cFc0eHluYVdxTW04N296?=
 =?utf-8?B?MitVa2lCcHI3L1VzSGlySDQwL2dXeFdEVU85RGVFNFFHb2tDZXdyNlRZY1ZH?=
 =?utf-8?B?NmRvZE1lVitCb25GNXdYRWlSK1psZ0lZVlgxOWRzSWx6V1V0Tk01M0hQdzR4?=
 =?utf-8?B?MnJmY1pVU0dBaE90R2xvUGFGTDcwVDhYVmh3VUdlTS9UQjk2eGUrVUJQVlJw?=
 =?utf-8?B?eXUwcVRnNzY3VDFycHFZcy9iRmhRWUJOQktINGxqS3ZUR2hPUkEyL2pXVkJa?=
 =?utf-8?B?WXBJamI4eS9wR2daekZGb0JpUUM2ZWRXdDBZU1VCVGxMUjhxR2xjdk1KSHpw?=
 =?utf-8?B?dlU5YjdWa2tvM09sL1JYUTRBdFppRTdKbTIzY0NRN3JGbUd0R2tiMU5lbmdE?=
 =?utf-8?B?M3hwVWJQZG12bXlRSEdBaUY2NTZVTGZNREpON2VUbGxOT3o4dWY1NG5mRFZE?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17283150-2b5f-42f8-820a-08dd77179d14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 03:35:46.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta6/TyuwBzpKItrrujtKCW5LWfyAssQ8cWH0HurJgFC+LzmB/JdRrRWPgAZQLTr5dkzczp6gyfktLpYo20D2DFId/AGzuqdBleQ0mICnaCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-Proofpoint-ORIG-GUID: 0Qvbk13lZbFuI3sfNqyzOfGmGEOBxURu
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f5eb14 cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=gwE7-LGZynbAF3Exno8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=viKdkGZzq4a8N62-mIcv:22
X-Proofpoint-GUID: 0Qvbk13lZbFuI3sfNqyzOfGmGEOBxURu
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=808 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1031
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504090012

Hi, Dear maintainers
I want to raise a small question about package version.
in configure.ac,   PACKAGE_VERSION is set to '1.7' by AC_INIT. So,
$ brctl --version
bridge-utils, 1.7
But actually,  I am using 1.7.1,  the version is not quite aligned. How 
about change to 1.7.1 in AC_INIT.

Regards
Changqing


