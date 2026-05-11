Return-Path: <netdev+bounces-286693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJzDGSXuAWpHmQEAu9opvQ
	(envelope-from <netdev+bounces-286693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:56:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA89510AD5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1D2301B158
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9333FFAAA;
	Mon, 11 May 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="kb/fl/cS"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021140.outbound.protection.outlook.com [40.107.208.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D3365A19;
	Mon, 11 May 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511170; cv=fail; b=DUlR3UqucWnq2aCI2VZSlcWajw+1UT5tLAyP84fdwuhboJ8FILaNO+HXAh8xxH2vM8HMEMaWebFa+F2a5Jt1B9XZE1jBtAr1oZHR0EsJLOPg34OQz88hNkhpPNNiC0C4JvWgkimtEmKjMWTwgzaY1jFPsyfcOXRIJ7ECsyVlbnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511170; c=relaxed/simple;
	bh=BIHHu+koiD3agFQ6HbMNm0hq8f4hIa+24rJsPKw1oXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYM+ueH3kM1E+oHTXGSswJfn56D7XBak1KRTclRuoHIRdz+OERi+vdAKwZUlbadKUG1GTUaH1V4LYt0xfmSuYPa/IvOySU52TYlQ2An1z/2fXN/YM2UY8z8m8bECjWCufYMVfDF0CsFbJzFDDcsYGOeZVeE0p0bUOLlIS2nJ/bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=kb/fl/cS reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXGuVRq/uM/Nmdc8tw7svXuZ+1Kh3tjdlAp/sHbuuL/aCndP7D0JZyKaIGWHs72Q9XyRRGmRO4w2PrfZ95hi0G2ccV1wCH8G54ECXZFuDu+8Ph8PQMDKU8J5HcyOOjQ2sZTijpJwR5fCQ6MnAM0ppjNo7PCwTzUMz4wbhlbV7TJMAYcU8IePrsOMtwIDY2YrCbYo068SXWSwPJKe8EPTu9Kh95c6H2ayrG7KAigLqTIMUyjnqqQeHHhVjM0mzcxfdg0gXtEXoqxXVscPtKnpJs/JucEthp4lqgM7BeDjMdfkvRrPZLOuVN2lyUCjSs0mvhttEZgSRvWm4pVpv//Dsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDhkzCUcnOIaqPjWW/nh8IiKSdoLQBD41DcXGwRMFV8=;
 b=IiGN6lKrIKVgmtZH/HcJSGqSijjCNETK4mbRoMCs76Z4rzvbSfTWzHct5ETkriBbVpPCQKCOqXwHD8pwRilpz0UEEUGHZpIvUqCOfvupyzdZPUEXfPuRHijHffK5rP5bDXozC/Ye+fGYtfImtjIWJMYnZLHPKgaZRdlr1I19Qnz6Be4HU46BZJqvouYGi7cZ4/rg27JJphVKE1ywhAQhM42jgQHB8FwUqclVj8K974/iMRDRwo2rMC/jyeqNrnphAf2NbISvkYWfhqWpIMTF/gfd7KiP216Pl3EAKNbqS8yGjAv+b5EUcA//PSNxSbJ6qqcmdk5xZLFZuani1DTB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDhkzCUcnOIaqPjWW/nh8IiKSdoLQBD41DcXGwRMFV8=;
 b=kb/fl/cSVQ65eiXqYn0YnmpuISdSaht9sq2A5lANYwf+dg5Uc42mSOmGCRpgwypp6SPDAfnM4eNvskbSs8cIUdq4i7ei8xbQNsdOx8a6eYaPSCdnGsxj17/FJfsvba8GymQiKUQ6ONFaD1dBxWJmlLgrCsm6rnROQKX3H494yBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CYYPR01MB8290.prod.exchangelabs.com (2603:10b6:930:c8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Mon, 11 May 2026 14:52:36 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 14:52:36 +0000
Message-ID: <9519a497-c10c-4abc-bcf9-414467f74ba3@amperemail.onmicrosoft.com>
Date: Mon, 11 May 2026 10:52:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v41] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260510163228.443778-1-admiyo@os.amperecomputing.com>
 <9f4d364ebbbbbb697fcee022991a546e60692f11.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <9f4d364ebbbbbb697fcee022991a546e60692f11.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0075.namprd19.prod.outlook.com
 (2603:10b6:930:69::19) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CYYPR01MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dad21d-7489-46e3-56e3-08deaf6cf0a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|55112099003|56012099003|11063799003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kYCLkONBhPwpsRYA7MK7CLX6HFvBhpewscnYIo6s31Ci5n1EVjmGJE9hLlYZe+lFp60wVjS09QxTnC4CwSBgoh5mCTFMYrqFWCuCPwL4VCTe0EawHSEL3QkZ4Mr78kY8VQPoCgW1Ikds2dNfQeF6s3nZ4mvgVNwWaRwX89ZEVOZ96x5TbMw1/5p7yRvTdrvdUL8XSlVWf5liUy9KJ/jp5xc7WXIHxGubg0yGh6b1BjCTHnrmQQmqeBKN19zszm5M32H9XAjyBN5dK1+rjaf+YNOI4juzMsyDlTANTq2YitwJdjkJK6IuaVfWD37/vW4oUdpYkhVfhTFESR9anhRnMJUXCmPTyQ+ujKF7NyeQ5A6EaNB9klUfH+LbA0nsbdxRH4AzTo6yRSaGn2k5TpqtYAat+JclL9/leP7a9fxr8JF0BvzrS0bkx9HyvbYxubavN4W9hvKJoHHDV1own0XmeAgISrNyWEmlEr+zCACKf0ozH1wh5/oXY6O22xDjIhEov8djEbh+yktpExzi6TpWasOWsXvK2UWY/DAMS3FRxC8ScL1bCMBa7YEkBmgWFsuQTVUC+FS0n1pT1W2J0QlpmYb2yAtYTAe70pN7Bp7F1jS80FM0qVgD7GqTw9q8qvwKKU4xLLSXkKT6giE+dZbQDdsRqvE3QiY8NfkApeU3/bjaZlFbxcmky+rhxJ9eMUlC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(55112099003)(56012099003)(11063799003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1qVUVuM2ZMSHJnMjIwdWRYK0R2UGxqemVSWE9EQ3gxaThGREs3SHVLdjZX?=
 =?utf-8?B?QkNtSW9uRTIvdWJqd2dLUFhBaytmcGVNYVBES1BXUU1aM0FJR3hUZGtYdkpK?=
 =?utf-8?B?WjBwM2dTM3Y4Q2VCamsxSm95dzdUNnZmNDNiVFNjeDVDTDc3dzBEM0gzMGVz?=
 =?utf-8?B?SXBkd1RKZmUxVHI2OWhmTDJOcUpTWHBTSkROamhQbkwzNDk2dkZsdmlTYlND?=
 =?utf-8?B?TWMzM29vc2d3WGxVMWloSXV5cEQ0a3pHdjVKcjVKR28vKzYvTURuQUFxaW5Q?=
 =?utf-8?B?RDdVajMyOGxUVUVwZGNPby8wemVmdnNaamZ3U3luTE5ISkxlYnoxcC9UYkRh?=
 =?utf-8?B?S2F1ZEEzZ0dJQlVuYm03MEkxQUNoRXZQUm9nZXdtNTdUaVlWaXFCb2RMODhl?=
 =?utf-8?B?SkpZT2FJTEZKNnJxaWdnTVFIS3QrT2NMcE9keTBYVXlqVHhyWDZLTlA3N2Vo?=
 =?utf-8?B?YWNGK1hYSlgyNXRENVR6elVvVGEzTnBMa2QxRDRFRm1HUy9zakEybG9tQzZL?=
 =?utf-8?B?a3hzTFdSemdGQXNHVnVqTnpVaXcvVzdJUGtQQmREVEtERU45ODk2YUpvN1JF?=
 =?utf-8?B?K0o3SXBBWDVhUlB5R3MvQnZQZHF1UTBKUjFhYzdHVjAyTEJERkVuRStZbDUz?=
 =?utf-8?B?Slp2RDlLTmtsL3NhNWRHcnZweDR4QVpTZy9zOHJoblpxSlZkMEFKN2VJL3RW?=
 =?utf-8?B?UmR3UW9IdzI1MythdlFpQVQ2OUpRcDJKQUJTazVrQ2lKNWF3bWlWLzU3eE1E?=
 =?utf-8?B?OTdPZXd5NUx6Y0huMmlka1NKNGM1MmFmUDlvMW5iOS8vL1RmVU43OVhoTTF1?=
 =?utf-8?B?YmcyT3AzRVcvdGFnUlhtNEYrZm1tZjROa1ZhUWhDRUlzUzdaVlFWK2M3alds?=
 =?utf-8?B?WFRIWGxMTzN5ZTZaY3prWC9XRXppMm9mcDlaalVXS0JyTHBINitWZzh1NVVH?=
 =?utf-8?B?djI2Zjh1Nlg4bWQxT3BjeERRSUpRNW5PZ01KZWRKcHNMV3A5Vk45NjFsTDlm?=
 =?utf-8?B?aEcwa2J3bmRaZkhQNHFWZDJaUWdIQjVObFBuY00yRkpWU243NGVGckxGZ1dm?=
 =?utf-8?B?Z0dpNVdLaTJsVjdweU1heVFyUDkzdTBGVFJqK0RhTEhwd00wMEtzViswNVY4?=
 =?utf-8?B?MEwyeTJEbndXTHdLa1QrVjBUeVlRVDN1dGdQU0p3a3FFekxMREhwNng5d2Zy?=
 =?utf-8?B?clVtVGZFZHBnWjlVS2FKZjkvNk5MK0t1cnlyS2xyRS9ldWEwMmR1bC9TS2dN?=
 =?utf-8?B?UFV0cDFBZnFBL3ExbHRNMTcrOVdXTGc5NkcvYkFXZ1ZxZXFyUFFyUjVUNUN5?=
 =?utf-8?B?ZFdiVkRQOExsZjRLTmpvVGtwUysyZEZqaXgvQ3F6VGpsandDTXNQVk1Gc0lz?=
 =?utf-8?B?dlA0RzcyalpzU3VycnUrRlpiV0swUnlqdDQyQkluQW5DaFZDUG5mRXJLbHdH?=
 =?utf-8?B?bHpyTG10bC9ONEE3UWFVNW80L1AyeHJ1aEpqMzY3Z2VHSTlhdDZ6UUFjNkVq?=
 =?utf-8?B?V003b3k1NXVEcWthcVZ1aHB6VHY1eHF5NjhOeHBWT1lveXVOeWxrZDQwaFBl?=
 =?utf-8?B?MFh3RnozRDN2RXJRc3BYV0lZRmk2akxnT1FlMjErOEdhalFaVGx4ZEdvZThs?=
 =?utf-8?B?UExmeitVQnM3OU1yVWswTWcySDFvdzV1VmhDd3dqekxWUVJWb0k2WXc3eU9Y?=
 =?utf-8?B?QkJKbTVJQzRmSHM3ZS9lS0RVbzh6TjRSWEJrRGExdFR4d05hbURlOXg0R3l2?=
 =?utf-8?B?dG1Eb3haNEtEdWIxeTZrLzNBT2F2bUVMQUF2ZkV1ZHhhQU9HUGE2YVo2N2pl?=
 =?utf-8?B?QzZ4RTg5TVFySXVJTWdXaFlTWW9VVkNEbldqWFBBajgxc2wvaGpCWDJqdzN3?=
 =?utf-8?B?ZDZCRzJwZVNVYTUvMW4zb2Jsd1FPVlNDaGhQVlEwRjh1VzZuWVk0YlZhTzJH?=
 =?utf-8?B?M1hDa1hwNDhZZnVIUi9QNDVQVEFBejBFTnN5ekNRdzBISjI3R0N5NGg0TFNr?=
 =?utf-8?B?UDh3MWtVMXhSa214T1BmV3NENnNUMU40Q0VvTkZidnREYzdGZU5ucE4rYXQy?=
 =?utf-8?B?Q1czLzJVUytkSFRyUGxGc2RsM3YwRGlvamNsRzFUZHJ2YVp4ejJObUxiU3dn?=
 =?utf-8?B?SzdINE1uRkgyaStoQWZINXI3cWRSaTRuTXNBRnRoY1Y2UlpYVlk4MlYwYmdI?=
 =?utf-8?B?STc1N1lwalkweU50cEpYS3ZWMEM1bDZVWTNyUWlsOVdaQ3NUU2dQVzNYcTNN?=
 =?utf-8?B?SHppQ2ZPbmJrbTU5TzRmclg5S3UzRVVxcGNQN2crbGJ6Umk5dWV3cHVRSi9M?=
 =?utf-8?B?OE0wbFEramtLOEVMalhta3dmVUxBUTVKT0tSOXpETGRGdU1uN2t2SXBzY2o5?=
 =?utf-8?Q?6dJBWSYooT/zvDleNVGNLPd0l/EXrydOxwStEfDSN8w7L?=
X-MS-Exchange-AntiSpam-MessageData-1:
	j/1hfaPsSW0Ftd5k3OYxogh304lPxMSTNUSQu2ijvW7dLjawsGIo0fc0
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dad21d-7489-46e3-56e3-08deaf6cf0a5
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:52:36.5432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5fL5YsgxQ6Cew5FEeuu0bDKjEu7d2SxnkHbnm6uQ78IK7ctZeqb76J6l7/+mXgN2f+A2ZMqQvOYpDRqFGcNIgZBUzOIuVM6GtPFcmQMY/PMT3lCmPt0YY3C2iMK3dSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8290
X-Rspamd-Queue-Id: CFA89510AD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286693-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[amperemail.onmicrosoft.com:s=selector1-amperemail-onmicrosoft-com];
	DMARC_NA(0.00)[onmicrosoft.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amperemail.onmicrosoft.com:~];
	NEURAL_SPAM(0.00)[0.769];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@amperemail.onmicrosoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkstyle.sh:url,amperemail.onmicrosoft.com:mid]
X-Rspamd-Action: no action


On 5/10/26 22:19, Jeremy Kerr wrote:
> Hi Adam,
>
> You keep sending out versions of this patch which have not accommodated
> items of previous feedback. It is not clear if this is intentional, but
> if you do disagree with some request for change, then respond to that
> request, rather than silently ignoring it.
>
> Alternatively, if it's not clear what the request is, then please
> respond to that thread and ask for clarification.
>
> Seeing changes without previous change requests either implemented or
> rejected through discussion is making the review process pretty
> frustrating, and is a primary reason why this has taken 40 versions so
> far.

Sorry, I should have been more explicit here.  I am not certain what is 
going to happen with fragmentation, so I want to be protected against 
future changes.

The check in validate_xmit_skb() is good, as it protects against the 
current set up. So my option was to put a comment in here and hope both 
changes happened together, or to just try and get this portion of the 
driver solid against the change.

And I thought that was what you were suggesting in the comment. The 
original comment sounded more like an "here is an optimization" instead 
of "this is important enough to kick back"

As for spacing, I get that there is a style, but it really should be 
encoded in checkstyle.sh or something and automated.  My own tendency is 
to put way too many spaces in to chunk things together, and I end up 
going over-draconian on stripping them out to try and meet the expected 
layout.

So, no, I am not intentionally skipping things.  I am really, really 
trying to catch all the nits and get this driver into an acceptable 
state.  I really appreciate the effort you have put in to review, as it 
would be dead in the water without your feedback.


>
>> Changes from Previous version
>>
>> Remove check for skb_is_nonlinear(skb) as it is done in skb_linearize(skb)
>> Removed comment about BE support
>> Spacing changes after gotos
> This change is good, but hasn't been applied to the part of the driver I
> had commented on.
>
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory pcc_header;
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *inbox;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       u32 header_length;
>> +       int size;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +       memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
>> +
>> +       // The message must at least have the PCC command indicating it is an MCTP
>> +       // message followed by the MCTP header, or we have a malformed message.
>> +       // This may be run on big endian system, but the data in the buffer is
>> +       // explicitly little endian.
>> +       header_length = le32_to_cpu(pcc_header.length);
>> +
>> +       if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
>> +               goto error;
>> +
>> +       // If the reported size is larger than the shared memory minus headers,
>> +       // something is wrong and treat the buffer as corrupted data.
>> +       if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
>> +               goto error;
>> +
>> +       if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
>> +               goto error;
>> +
>> +       size = header_length + PCC_EXTRA_LEN;
>> +       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +       if (!skb)
>> +               goto error;
> As I mentioned on v40, space after this.
Sorry, I have been reformatting a bunch.  Added it in and then removed it.
>
>> +       skb_put(skb, size);
>> +       skb->protocol = htons(ETH_P_MCTP);
>> +       memcpy_fromio(skb->data, inbox->chan->shmem, size);
>> +       dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
>> +       skb_pull(skb, sizeof(pcc_header));
>> +       skb_reset_mac_header(skb);
>> +       skb_reset_network_header(skb);
>> +       cb = __mctp_cb(skb);
>> +       cb->halen = 0;
>> +       netif_rx(skb);
>> +       return;
> And one after this.
>
>> +error:
>> +       dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +       struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
>> +       struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +       int len = skb->len;
>> +
>> +       /* Consolidated a fragmented packet into contiguous memory */
>> +       if (skb_linearize(skb))
>> +               goto error;
> You have removed the unnecessary is_linear check, but the entire
> linearize is unnecessary. From v39:
>
>    skb_linearize() already has the skb_is_nonlinear() check.
>    
>    However, you don't need to call skb_linearize() anyway, as that will
>    happen for you in validate_xmit_skb(), since the driver does not
>    advertise support for nonlinear skbs.
>
>> +
>> +       if (skb_cow_head(skb, sizeof(*pcc_header)))
>> +               goto error;
> ... and, if you're going for spacing updates, may as well do one here
> too
>
>> +       pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +       pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +       pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +       memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>> +       pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +
>> +       if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
>> +               // Remove the header in case it gets sent again
>> +               skb_pull(skb, sizeof(*pcc_header));
>> +               netif_stop_queue(ndev);
>> +               return NETDEV_TX_BUSY;
>> +       }
>> +
>> +       return NETDEV_TX_OK;
> And here.
>
>> +error:
>> +       dev_dstats_tx_dropped(ndev);
>> +       kfree_skb(skb);
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *outbox;
>> +       struct sk_buff *skb = mssg;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +
>> +       /* The PCC Mailbox typically does not make use of the mssg pointer
>> +        * The mctp-over pcc driver is the only client that uses it.
>> +        * This value should always be non-null; it is possible
>> +        * that a change in the Mailbox level will break that assumption.
>> +        */
>> +       if (!skb) {
>> +               netdev_warn_once(mctp_pcc_ndev->ndev,
>> +                                "%s called with null message.\n", __func__);
>> +               return;
>> +       }
>> +
>> +       if (skb->len > outbox->chan->shmem_size) {
>> +               dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
>> +       memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
>> +
>> +       /*
>> +        * This packet could still be dropped in the PCC layer,
>> +        * But the only place that could deal with that is mctp_pcc_tx_done.
>> +        * That is called from the Hard-IRQ handler, and it is not safe to
>> +        * call stats functions from HARD-IRQ context.
>> +        */
> Your other option, if you prefer, is to do an irq-safe stats update.
> This is essentially open-coding dev_dstats_tx_add(), but using the
> irqsave/irqrestore variants of begin/end. Something like:
>
> 	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
> 	unsigned long flags;
>
> 	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
> 	u64_stats_inc(&dstats->tx_packets);
> 	u64_stats_add(&dstats->tx_bytes, skb->len);
> 	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
>
> (but your current approach is okay too

Thanks for the approach.  I will possibly incorporate this in a future 
patch.  I have another approach in mind I want to try first.


>
> Cheers,
>
>
> Jeremy

