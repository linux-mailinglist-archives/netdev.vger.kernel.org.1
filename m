Return-Path: <netdev+bounces-221198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BEB4FAAF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61AA07B52CA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67932CF76;
	Tue,  9 Sep 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lyDQRsEf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t/OBt5/u"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFA32C324
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420550; cv=fail; b=gAvqOwcG1fDaAfjp6BCR56axWOIh9ZxeC1oKOuL2+8YcR9A29b4ojtcqrgx17kbf6KHaldyNKWWeNz7i2p45IUafpQXB6IPkrVRwXlArAG1Tl2a5pbL8Res+p2Xd9CwDomnQ7cpscsSlZtDGob72+8deNa2yCB8jurDwU/HeSF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420550; c=relaxed/simple;
	bh=vx3E0vEMozXgqIK5gBVEDAOBMAjiJV2JQzFH6KE3Vls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xp7SFFzJWg1xD+XJrS/hYBhACjWGsBOwainRhq4izBMHosgAo1CTHbQzz5m7y3K1z7tV8c1B7ONNk7QdbQFftYAbl/jMadAczxL1x5BdK5FFgfPFvO7nCmNE6L0GxHMpsPnedHDVKfv4sBxr2xxW17BROeqNfR+Fcs/0fvd0LUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lyDQRsEf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t/OBt5/u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Ag5lQ006786;
	Tue, 9 Sep 2025 12:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1dDoJyZMGRqQ/lKyH+97ZRyNfQYJe+bYovw74T1IJW0=; b=
	lyDQRsEffZ4iETgHCHruGLM5bufSUMcp2CMhQ3QV8X1oJ/XwgH3wfry+b9looEgB
	1HM5Mzt8VZqzGTw2vVKQn5qw8EGvM7sofGC2R+RCJZNM3+IAkNZbBFuSNVm+/A/J
	HS/ur98TwhKGii3++TDjK+CtvK7xnBeksAYeHVxVbXvDRp8e2760h7oUTf/8Adca
	TgMZR8Oz1gfCdP4wenvT+5q5LOmHsaNn9v3fs+oeqE7Ar7f8d6HmbnebucQ/70IB
	cgA7CImduWT4UAMeluwXdxZ0ZlqoOXfxE4Gr4t7Mlq4dQg5KRLu1I7E7Mg/yxaIS
	aRgGSg6G+fF1smfja38Mqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922961sqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 12:22:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589AXShh025946;
	Tue, 9 Sep 2025 12:22:19 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9hwn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 12:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egrhSqZJeTjIX0dzZB5JAlDnzCH6YP7KV689doMqZsoE1BXR9H8DcHEb7rvj7OW60fuCEtJmI5pew0pdVrXLnUZ243ne8i6KfWNsXMAmFYzDG0xtbZLz8d7tPWnHJhbpjWslNko/eY89vSa6KWg3iIkHBik9nsT5xoZUCPXVmBtm7reboEMCEmYa1Car/nzAHZhMvC+xYtu79/PjcZjaRc0A+96dIRGx0JR6HeVwDfnWXMD/v8Blm2lv+hSCp62VpMPa1XM9WmlPeAODLO1c7di78yhaDXRtPjO1QPRBkNMW3L9om7VD/e4/r+DeVcj1s6AMdRSKYHECX7ZGeoyVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dDoJyZMGRqQ/lKyH+97ZRyNfQYJe+bYovw74T1IJW0=;
 b=BCb7jxRNFkNPTvAMO+tAhVm1riPDeQEE1q21VXstXe8Te+kug16AfQszwJNawMmG9yqKHc9usBP3HtyBd4xYVU2boLye6HA0GfAg6BSKXq1bx+QHtYEpwzOWzx9j0hakPK9obytxoy9XdXTCYiq0JovdPZAeyxOiJEAzx81C112ecq1Jru8AjNE27dTORazGO7ey22vcl6/Tb1Wknaumm1ez3iE9CuVu4pkI2fZob9F5YGAJgMFaZAfJvZdX0XmG6E3GpYCdm7N5kvFX/fgP+qroBaDs1vMUpj2kJROvSYpfKFqQEYD0iqQ0WdChx1s2cbT+nyryJ1U6RCpwBYl+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dDoJyZMGRqQ/lKyH+97ZRyNfQYJe+bYovw74T1IJW0=;
 b=t/OBt5/ucpGmsGyL2KDLwUNQOOKkrfi9O/RVIAqXIrbIJuZ9tbptFnKM2KcBJycp1Ug8txBO1zNxeBHfS4KMghxgeHPYjEtzIlyk+DsaAOAdf7qJrxpj7F5tGCB+kTq4DD+g7ekjXifHnyNLbXguzQZG2+YYkHl5hCYYDVV85Tc=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:22:17 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.032; Tue, 9 Sep 2025
 12:22:17 +0000
Message-ID: <80486f87-2be7-46c0-a6fe-7cafa5c6823d@oracle.com>
Date: Tue, 9 Sep 2025 17:52:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: udp: fix typos in comments
To: Simon Horman <horms@kernel.org>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org
References: <20250907191659.3610353-1-alok.a.tiwari@oracle.com>
 <20250909121100.GC14415@horms.kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250909121100.GC14415@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9c7c31-ed6f-46c4-fcaf-08ddef9b8413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1hWUTk2OHRlVG0ybDA0UmZBSmZ2VmhWdElXYjdlWitjTmRBRXhSeWpaN3hs?=
 =?utf-8?B?OU9MN0cxaGlXS2hXdzZ6Q3BJakdrVmt4REFXbHgwS2twSlYrVXg1OFAzUXBF?=
 =?utf-8?B?dVdIRHQ2M25hUjVZbmRhNzFUU1VTbTZYWmtaZnIreU03TWpEc3YrUmI5YnhE?=
 =?utf-8?B?SlFLRzdPcXF4WXNRODhFem04U011R1d2elB0cDFpRjQ1ZkRyQVdHZDR6N1E3?=
 =?utf-8?B?RUNpRlZHdVB1ejBSdytSR0hzSEkrRDJ5dGVaVDhpQnVFSTR1cmxzcnF1WjQ3?=
 =?utf-8?B?S3FOMUNVRVU4TFpZZk9ycDBLN0NKcHZKNjdZbjhYckN6elBCMXVSQTJGSWFY?=
 =?utf-8?B?WjY3MWp3cHhka3hET1VseXlBK0RicVY3RWRocStpM3JHMFhhL3dNVFUzNE5X?=
 =?utf-8?B?anFDZU9qNDJHVkRvL0tKWUdyVnI3amgwaVFuTjFtS2hHOS8vSzF2TXpOSXNk?=
 =?utf-8?B?Zm5nYzlzaGUzdlBpOURaNTNXYXpMTy9YMmN1TDVPYThERlR5L0hCSmZHd3Fz?=
 =?utf-8?B?dDJkbHZjRERFSzZzNDUzT2Jpbkp4ZFVPYlpKK3NSbE11Tlh6YUoxMURnV1Zm?=
 =?utf-8?B?UWFXNHcvdUF4dGZnUXVNS1lUMkFadmh3NzNqSmJ0ZkllaHpqdWREcVdzZWcy?=
 =?utf-8?B?aGNkWFQwRE9zQUNFTHRMZ2J4TW1ZV3VMcDlTdGVqRzVZaThJMFFPQ1FxTU1Q?=
 =?utf-8?B?VnJJUm44ZTU5TGhJUDUwZmJueVJlenN4bzdzTU9QYll0VXIyMU83K21FaDhz?=
 =?utf-8?B?M0ptQXNuMTBlUUxUOFpyNXVST0JQa0daSm9UR1hHcC9XNzRTSnEwQjBzUlBP?=
 =?utf-8?B?bkpZWS9PcGRLeHFsSWNNa24vUFd4ZXJtbjZaamxJVDc2MWJtdWZJMGFJNlJx?=
 =?utf-8?B?cGk2MjRqdTNNN1puTWNhTFJhaTRmYlp0aWE3Q3NaSmg4c3RUMUdGcVJIV0px?=
 =?utf-8?B?VzJhb2VkUG4reUxBTE9mK1I2RHFaZ1VxclFiZktSK2xJZWJMdEpTY05EUkNN?=
 =?utf-8?B?TlhWRklpaFN3a2JpL3lkL2lkSm9jbmFGN21nbVpFekpycGJneXRzU0hBVktE?=
 =?utf-8?B?eENjVEpuTitwZW9aUXN4WWNTSUxudUZGRGYxZkRrL3lxWTE4NWNsdDhwVVRo?=
 =?utf-8?B?ajNHYWxuaFhoMVdJNHk5MmZoL1JsV3FPbDYxbUJ6V3o0blFkYlhjeGRJRUpE?=
 =?utf-8?B?Q3RVVjlEdEtIT0duT3c5Z21BajRLVURZMExqSWFYbWRudlliNEhneEZBUUxt?=
 =?utf-8?B?STNGNk9uUEZ1NnZmY1Z6TmdWckswdEVvd0JkSU84aXpWTEE4cFNQdWxvZG53?=
 =?utf-8?B?eEV2WG01UDdyMm9XK0tXUWNaUkNjeG9HdW1PU1hqb21reUJuVVVJekNhb3NC?=
 =?utf-8?B?b1JINmNEeUhCb3ozcVdGOHJpRW5XRGRjakluL1EwSmhrejdQazZ5ZnVLc0Ra?=
 =?utf-8?B?SzJVbGVKUUpyVStGZDVRRTI5RGVUQko3UkZLNzZHbmptanFmckR0cGdCdXJo?=
 =?utf-8?B?ZFoyOU94UnBhWngwSTVLSXpmeWRVNWE1NGgveEJyUDk0UE1jWEx0OTY2RHhp?=
 =?utf-8?B?OXdoMEVjOVVkUlBnSHVyRGFHbzZ5ckd2eWd5cE4zdWVDOXNoVHNCRTczWWFp?=
 =?utf-8?B?elcrZ3h3MVZwWnN5a2lzUFZxcG1PaFZIMTRIWDlmZ0w0RU81dmdDZ0pISmZE?=
 =?utf-8?B?eXpkUEo0NDBXUVlaSE9ZMldORUZDVmV5K2NQMSsyd3MxWnJOcWxNRWs5TzJ0?=
 =?utf-8?B?ZFluZ3FOVTJSRk9jT3ZxT05sMHVBSHozUy9sRDFFSjdWZ1NiSWdFdDgxVTdt?=
 =?utf-8?B?eTA2U05FS21sUFRMSmhuR2JvL293ekkyZnpYMnFNYlVUMTRCWXhYNGZMV1oz?=
 =?utf-8?B?ZWxCdGZyMkEwalFMUUZnREV2WGRNaCt6ZzJTd0s2RmNFcHFMNUNTcFhBdi9O?=
 =?utf-8?Q?dt0E/TIMeYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VndTMGZxcHpyY21aN1NXZDdIVGpyYXBsZnhJTzFKSngwQktHOHJXNC9MU29q?=
 =?utf-8?B?ZTY4YmNuWjF0cDZxT2hRMUFZQjJYZFZ0UWxXTzVzMm5FYVE4aHM1ei95RWta?=
 =?utf-8?B?RzE2NlMvMm0rNCtPZjBnRzRSbXJmR01yei9LMkZzV1NsYW9oVVdXVTF0c0xD?=
 =?utf-8?B?WjNlcmFUQzd4dHh6VGR5TkVzeERFMXNhTVdyRE03dFI3eThVQ0ZoVm9DditW?=
 =?utf-8?B?UWFrK09oQkJ2YlJ2ajV0QjJUbDZHV1VCNGhrOEl6V1VCYjh0bnNGWlNvNk11?=
 =?utf-8?B?OVBiUWw1RWprZ2dWYWVjMGI5SlFiTWdsbE8rWm9aVXZocE8rNUtML3RkTytZ?=
 =?utf-8?B?bXY0TXp0YnQ0NDlIL3EreGZOdW8zMitBdTY5VFphcG5oVmlHWUY0UkNtVEow?=
 =?utf-8?B?NkZNMjJPL1JyV2g5ZUlTM3YwRVlPOWxTL0p0ejBwTEdZMG1GNk9EbjFMT1FJ?=
 =?utf-8?B?Nm42MmV1V2doMEI2Uy81Q2E4enAyNEg0OHBVZUMrV0N5VFlJOTlCalZtMWhp?=
 =?utf-8?B?UVNLNTNSR0xJUnQrWlhYRDFvaWd2QUo1YW5XTU5oTURwT21pTUNubUFkaXNJ?=
 =?utf-8?B?bGtBWmo1Tk9TOFhmTzlFNEZyaXp6QlF3Mm9FZ2dZVENYNFF0V2s0RGZLeUtI?=
 =?utf-8?B?MnJHa3U1azNhVksySitydXFrR29rOG8reDJSc28zL0xMeHgzZi8xU0NXbjhC?=
 =?utf-8?B?dHZNRC84Rlk5blBONXVjeTlra2NJZE5yZzd2ek9xWkxHa0NkcGtqQ1RQbi93?=
 =?utf-8?B?RXpVai9qeVNXUlNyczlvTXNIa29CN09FKzVZODBua0NIR1JGenozZ003c09C?=
 =?utf-8?B?OFArUEw2SWVkeWRqN1J0WjdXdU5YbzZmZjdWaGVsc2MyNldodE12OHpqajZn?=
 =?utf-8?B?MmxZV3diSzU5RnNEUnhuWVdybmsrQjI5RDJDTVJNUGpKRXFKb2pvcDhVaTU4?=
 =?utf-8?B?ejJURWR1cncybnBrNHB0QlJJY3JsM3NrR1F3cDB6dXB2ZWZjRDhnM2k0eFQ5?=
 =?utf-8?B?aGl2azRUN0gzb3F1UTN2NVhGcU9kdUZ6bFN6dCtmc21zZ3d5THVXOW9GSnBO?=
 =?utf-8?B?NGpqNWRsdlJ1cFVJaFRUOVp1U1VwRXVuY3pDRkFPQm9wMjNpZWZmNHdpUFlq?=
 =?utf-8?B?Mis4THZ3QWx3L2p4MGRaeVl1aXhJWVl4eUFFTlJxRm1HMTk5bFlUbEZFbHgw?=
 =?utf-8?B?elAzV0lrcWlSNXNseEZIZk1BZ0syOUtjRWJnU3BFck9sMkpsbEpZVHdVd0JR?=
 =?utf-8?B?enBvVmZsOGJhVXJqay9LRk1pVnRtbUZBdjB4VmtZUG4vMjJ4UWU4d2FORDhs?=
 =?utf-8?B?QzM2MWxiQ0Zaam9XNmpwWUZDSVhxeER5NmxqRGJqSUx3VWQ5cC9iTzJ6cDNL?=
 =?utf-8?B?d0xNck5rK0E2WlRrbDhVcnFYbnlmWGQzL3h4Qmd5SjNycWg0Qk1SdlZUaGRD?=
 =?utf-8?B?WjNtTkNaWGRPamhUQVdsTG84U1puWFVCelpNNzZmZDFQZmFxOXM5OWdGcjg3?=
 =?utf-8?B?VER0VE1pTXlIQURWOGJZL29Ha0FGUXc2ajB2SkE1QUdSWkxSMXpPT3Z3OEdS?=
 =?utf-8?B?d283OTIvSzNlTWRJRVNiT3pHWUdzLzJkWWV1ZGNtNGhidGgyb3dmK1JObm9i?=
 =?utf-8?B?dERyaUNieDJQYWtXNVJKNlJDdTFXc3ZqTDdTMS9MZHFJWCtnNTRTa0JMOW85?=
 =?utf-8?B?bFhqdi8xTTd6ZlI1Zkk4dzdVeSsvTStKQXJzS0pBSHB0c2V2TE9JdXFXbVp2?=
 =?utf-8?B?Tm9CUVd5N2xrWU1SbVFhYnA4RndPM2tKeVFyVmlMS2VCQnlVa2JGR2pZM0tE?=
 =?utf-8?B?VlE1WmsyczlvQ2VUeW9YUnAxb0p3Y1VnREJrK1E4MG5QQnFQdEVHNVJBNFI4?=
 =?utf-8?B?ZldJUzNtc29PcXIybUcvQWdDUUEzSTc4ZXFkTTNja0JxOGxqSWQrOUhNRC9K?=
 =?utf-8?B?dFBKaGR3ekQ1d20rYUx4QjdOQ3U0ZXlwYzh6eUtJMnVvTkVpUUtuNGZwL2NG?=
 =?utf-8?B?WWo5aGg4Z1M0RE1lRnE5TWFuMktGTXBmd3BTOFVKaklFWW5idjJqZ3FtZlV3?=
 =?utf-8?B?ZU9wT1N0RTdrY2E5OENxQ25PU28zK05McGg3ZWxrYzdmQmg5dkZycSszRXVJ?=
 =?utf-8?B?aVMyT2xLNHR1LzZZNUszT3hZT1JuTlNobjF1VjE4OVBEdFNBbHJDZ2N0ZGdD?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kts9y2eB6/kqWkiNVacB14e/rymbjj9bId85AHNbGFO7d2Tc4aWNJgdqgTODKZ2G4ha248giM3X0y8i2mZEmRjfXYpdLvS6DCAtiNiUnLfOaEtny31tZ70c6SvgZvhtx88s9vlVORNb9xppoObAZRnpKoD6B6CUTobgzndcFbdXjJJhf8VTtEC3/1j8Pj/YAPmooHHW2orW87cHJu0feR3mI9R17tXx1+anOMDHun0JjNQ5d7H4hSGmfqqe/4Vw8TALNSlfnv+Y7AEV9QyCNoxHV/OyUT+BZNJfMegFHBE91EyuB1eesJm3PTsVBIjMdY/K2s0P/FJlq2d/SZPhi61UPKA0hxQdmb9hNh12pmst1MWtDU0W19n2IF6+RH1hQDY2+tB9HiqH5EKI97bPpm/1PWARHwYTRhc9rZ/N8s7YGU+YWjsm2g+IvFdqWcoubzvxqFcpYEJT3oAFKdyDFq7FvfiwdLVgaHSsXNQgWL+OFvYHoP0ZaOCAHGoEoQAg86AQlHIsUI8m9N6hrI6CsTD6JHiB69AMwa/ZDk9TrSnL0b118GSxBnoT7HDhy8Khv16GBCNODIXh8n2HxK+kSN3JmQin7lH7eHBJIDv0hOqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c7c31-ed6f-46c4-fcaf-08ddef9b8413
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:22:17.4188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LODk23Nt87jRGqb9Vc/GlM2MHlChi6byOHPKJ4BxuD3nFMisnuNI4j+In5WFXerKHoPekM2QUrxXdSKnhZEGW5UvQM0K6afVeANy1QHEZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090122
X-Proofpoint-GUID: DcoNJjj1-8Q0aRqlCM3RTXcIE-6cM5S1
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c01bfc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=xQIX8RsSxpClGtwelmYA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfXya/IWhv4h9g7
 JVMZwSdL8IvBS5uQTv6OFYvlN81WRf9RODNUknrTv5zQYsPe93Azis9EQ9dvdPqRZ+yZ45rXg4k
 xMxkKCp88f9ZLm4124phrlrL7LY6j+WiVrP93UMyvL7PA+DPsKuubz8++9XrSDbAMJzmMkLTp4G
 tLlsLUbzFZTvJdeqkuews8GPwhJ2Ln0kph/dyUSq5JKA9a2+EmhVakmXCCzKnuhgsEBlcs7EfmZ
 +0I+p3FoSeJwq9yLmvGWwq0+340ZfoCwC1iY8OAxWAlagpb0g+ioY7GnJdpAvqHfXF2OWUVp4HQ
 z8JKTJNWzbvzCkIDKPRSfswLA6y68PFCrTYypEdxLBWLpVqXhsmZ1KpKGr0bYHEbh0/uDy6i2aP
 qdqs29dHcTfsIKzfqjhqmpKqRRgxYQ==
X-Proofpoint-ORIG-GUID: DcoNJjj1-8Q0aRqlCM3RTXcIE-6cM5S1



On 9/9/2025 5:41 PM, Simon Horman wrote:
> Hi Alok,
> 
> I'm wondering if you could consider also fixing the following while
> you are updating this file.
> 
> measureable ==> measurable
> 
> Flagged by codespell.


Thanks Simon, I will incorporate this change in the next version.

Thanks,
Alok

