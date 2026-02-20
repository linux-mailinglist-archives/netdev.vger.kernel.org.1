Return-Path: <netdev+bounces-259718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INKIOfNjmGmJHgMAu9opvQ
	(envelope-from <netdev+bounces-259718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:38:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6D2167E33
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8F0C3001CD3
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92812345CA3;
	Fri, 20 Feb 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="FM5n8X8X"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7E34106A;
	Fri, 20 Feb 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594734; cv=fail; b=O/AJwE7wji9rhidX9BWYbymKXkbPDnrbMo+WfYRuhdm5MusNg3jVBtLe34z7uknnMkRQVOJwrNbW12ODnkSv6ILGN5kiJTfwThtJ1s8zMsG9OKqpyb+SxCZJmoyqIFH7xK0VZT6kpGcb9R2ofcu7jmcp6F4c7U/M8d8U1uv4ubM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594734; c=relaxed/simple;
	bh=u/jOwwaHdizkZIpDAkTTJ7BkcNiu+khTkcSLHdrMSrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iISvO93+fARAZzIxxZXDbUvHG2Y7VhlphcTbvieAXh5GJmcUTDmECL1cy0tQnEEZHjydAHWsemXWJdjkowsZ48CEg17/5i88NZGiUWF/sEY3ttNdd5Q5ROz+mvwEJJNvljCuVtFmye69Em2AEmoMM7O59nSYpSKQ0dxwlWfaY8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=FM5n8X8X; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPnsz0WWglKz4YlU13GsMgmWNopLdsDClkpo+VecpHwxgL70/wcI6PPE2rzmzaNO8eNwC2zoRWkAjmz8/k7Jun7kK+96PSWptkAYIut2di4ldQ7alowJ1kyMQtdi3FUpDOhCAy7me3fChZJx+rOqonUvv5dz2GmfyEo6pd+09qvF5ioIg7iyp10dOd84p97A3H8i31UmaOTMzYfFLmEsKK25rtsqJJIFSy+Wk5jlq0oPvvw637YF04Us7+SB3D/rtGMLlSvVLgds9J4rSwre0rXIiBbirXwj26sU22SLtgfoeO1JuGTM4xZSp4SHAxS+qUKGVh55bxXZlfDk5BTD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43NqWC5UYmCCsYY4oaLwFOxdwOUzcMbO6+TnWkr7ff8=;
 b=UwMH2xU352WfEZw4PpCgXILRr3v73wycY5BdcOez7CM10A5ziHWWvb5If85oUbis7rWJLsG5VqExUGeZcwdEXPT0Tx28PZ5aulf9E3SVnpr8/qEnCvUlQdBMMad30vvAySYt/MPsA9Rtsx4Zy7WQ/BNoNWLh6cSnCkDn3RUCRh5pVAR4Pp6fP6FhsB1HtPJTI/FyF7JfZSg1bC4RXC/zBf/VjyqDucflcWssWq4taCPeiaWaKSHt1Ka5aaW4LQUNU5PMmcC3aQSrIJrA0NStGuF2bQ75QAy0J7YG7sUb2dT60kLeBfyrSQclmbw0FQHNV0AudJlr3/olodS4uqpHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43NqWC5UYmCCsYY4oaLwFOxdwOUzcMbO6+TnWkr7ff8=;
 b=FM5n8X8XzkAd9U68+k6YEFY0GOyAV2N5LbUTubyUCP2qX3wir/n2fjZKXPvWUuh01qFqL7nri/HLWEg/W11w9j6Xyg+kkcGjZNQGxZ9IrYVBcE/gyOy6abUhasqFTRGmmB46OE9SOi0GM4PnpYfYDgF9FAbzK87KQeANKjYtQGmQR29uKMgzgoPlf7w/tKZqBoyjfKOYSQnY4BmtNf82ifcRuZulN91ikev7eJjGgh+DAPed+8ijc1S3879W/EtfMFpg1zXhLHpoV5yvU4TNnt/6kLazBZSAt8IuAHIxVd4bxHZwC2+4F9G2ojMVRqYEypDZzTPyAT76pt8VnmRzhA==
Received: from SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13)
 by CH3PR22MB4405.namprd22.prod.outlook.com (2603:10b6:610:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 13:38:48 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c4) by SJ0PR03CA0188.outlook.office365.com
 (2603:10b6:a03:2ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 13:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 13:38:48 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 67E871A2CC;
	Fri, 20 Feb 2026 15:38:46 +0200 (EET)
Date: Fri, 20 Feb 2026 15:38:45 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nxp-nci: allow GPIOs to sleep
Message-ID: <aZhj5Q_kM53uSvr_@zeus>
References: <20260220115906.102470-1-ian.ray@gehealthcare.com>
 <d991e47a-0275-4f8d-afef-0e26fbd2bfdc@lunn.ch>
 <aZhhljVG907fI6jC@zeus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZhhljVG907fI6jC@zeus>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CH3PR22MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 7698d217-4631-49a0-a55a-08de70856092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUFyM3Jpang4aGN6dVNHSjBuMUljcXJhb0tHUEJrV3V6WHJYYzVxSXZSelk4?=
 =?utf-8?B?Wngzd0xQRS9jR1FNdWFUcC8xVHZJaStUWWx4aE5LazUveFlDMnhnSXduRGJC?=
 =?utf-8?B?NVVuYVFqbm1XR2t5ekFLMFNtT29tTUFzdTZzUHlZcWJuNGltWEpDZWk4RUNC?=
 =?utf-8?B?MGpHUTBLNzlac2k2cXAwY1ZPQ1grQ3cyT1RBS2JnRUtLY29UMGJBSGtXeC9H?=
 =?utf-8?B?aXhzQklpK0ZHMm0vdEtlL005MHJJMjJhNE9MU2RIRXorM2hIbTVaVEVtWXRG?=
 =?utf-8?B?VHRhNXAyZEdSK1d5eUtiSkRMaUs0Tlc5ZzVKeHJQbWRvYXVXMnRrTVdhR2o1?=
 =?utf-8?B?aGNldk55TFlObnRvbTNFUGEyRlFzUU45blF6VHA1dksvZ0ZHd2NkNDk4K0lE?=
 =?utf-8?B?a0liaDNOa3p3UjdxR2RBV3NUUk5VbWdFaHNxbXA0Y2NzNGU5dDkzZktVWHUr?=
 =?utf-8?B?aFMzNEtVWmxoaEpwamhpcUFUTmVSOEo1OE1oTGxVQlBldW1yazgySVJ0dUln?=
 =?utf-8?B?UFdILzlINVA3MkNYbmxmNm0rM0pSWEdzcnNLM0hDNmV5bSt5MlVFUkgwaVk4?=
 =?utf-8?B?NE1pbXFqN2IwUGhYTWZlQnVWTHpYWWdUazI1RTVOUEo3Q0pvTThyUDdHdVVJ?=
 =?utf-8?B?djNic0hjb3VvdHJYdDhkcXJYVzA5TnlEQVNRenplbDd5RFZ2OGF5L29JaU94?=
 =?utf-8?B?Y2lXM2xiU2ZlY2hRRU8vSUFTWHhidGtlZGpaUGRVZ0Q1cjliYUJNUmFMSEtu?=
 =?utf-8?B?ZGxQNHhJYnhoR04xSWY3eWc1VGlzSHpKaXlDcU9kMWFpS2xRdEZ6SlpWMjUz?=
 =?utf-8?B?QU11OXA1cmFmQ3l5QU9VenJRYkpDY2pydlQ1NzBjd3I1ZVJ2RHZHYVBhSDcw?=
 =?utf-8?B?MHR0ellVMm5UbERSZnd3RVZGTHZJc1dxd2ZXTjZReHJ0a2Rvek02TWVvbHIr?=
 =?utf-8?B?dmtaUTJVOUloN2ZOcDRMNXJvdkdSY2ZsNjhDbndOd29SWGdzNFdBQ00xdWsz?=
 =?utf-8?B?M0xqczBlWFRPakFGU1dpM05ZekhVUERjWExndTZSR09HVUFIK2lGK0NPN2tR?=
 =?utf-8?B?ZlluSVhCbnRQZkU2d0FKOWpqVFJpMWFMNUQ3Vm1sZUpEcDNrbUJHMUZCZERk?=
 =?utf-8?B?RW55MkVNeHhray9mdWJESVU5MmMrbkI0bm5UN0dlZUFPcVdQcTFuOGFCVSt1?=
 =?utf-8?B?cmJKUzFrT2o5R3FVTm5wVzNRWGdNMXMzWEVUK1RnZ3ZIV3hmZnNoamFjTVp4?=
 =?utf-8?B?MnNDN0lGd0lPZmtWcmNOdGI4U3FZWGprM2w4U1R0alJwT0wvNDdIQWF3U3px?=
 =?utf-8?B?NHZBZG1sUWx2VW05VFRFOGNaN2dSR2JGQmx4Z3BQQzYzaC96SnBENWRnTTZ6?=
 =?utf-8?B?V3MrT0I2Q0lFeFNmOW5SbFVTdEpNYUd5TWd0aGhiVFN2ZjlsOFdIcGt5RElo?=
 =?utf-8?B?d2VtY0lKUjAvTmUxdW9wVS8yc0RrYnJFd2dsaWR6YS9pYWUrbDh5encxSnVa?=
 =?utf-8?B?YkNObTQyQzBXQnpENjBZbVA5UzFNZnVoNmd1dkR3eVpqTjZha0Q0MkI3QXFG?=
 =?utf-8?B?RXV6bkZqSW01TGZNV3ljQ2ptSks0ZUp4c3R5Y3dPNk9tZmhsS3Zna2dWMWxO?=
 =?utf-8?B?NGpMNEkxaVRuOUYxNmxYUzRsclMxQkhXU2tyMzhvSWludVRUTXhWMjJUVnhH?=
 =?utf-8?B?Vi9qY1ZhNlh2ZDVtTW1TUEZlMlVNZzZxNmpITk54T0JLbXlkY1QwWm9wTWJv?=
 =?utf-8?B?djlLaURJcEg1WlgraXlHb0dMOVcvU3h6eEUydUozckVnZGthWkhHa2hjNHIw?=
 =?utf-8?B?ajVrSjFMSmJrcGx3cWFBbVlOMEVDbkpLYVhYK05TdlRzaEZuUzQ5TDlYWi84?=
 =?utf-8?B?bW9rRFdzRHpMRGVWOTFaT2xNbldZYXphbEF2UHd2OC9XeTRwd2FBei9kbVVX?=
 =?utf-8?B?b3BFRlRaVUptLyt5RzVlZ1lBVW8wVFN5S0tWVFJiSlFqak5FVzVWZmthbmtl?=
 =?utf-8?B?eVJuWWV6OW9BeXNvSWtSd29NTzduS2JxZUoxL2JjNjVJRkJPWlJGOG1iOWFD?=
 =?utf-8?B?bEQvbWhmM2Q0T1czVVdHWWFIbkFwVVo5bmRkME5lckxObDZUMzBHNnNzV29j?=
 =?utf-8?B?K2twcktZWCtyYnJHNWZocXNMWmwzczBNOHFOV1RqbGEzTjFIRjFKbHhLS0J0?=
 =?utf-8?B?dW5IUldQaGtFUWpackE2cUJ5N0ErRGszZTVLbFhZekJVQWovTnhaZUJJZExB?=
 =?utf-8?B?L25JcjA5U3ZQQnluVTlVcmpjWFZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mFFh9j8suggqwV0Z7Zz4+PANINd3UOOeIg3lPcIo1/goQ9pkYhr2HST9ukv3uogOyMSUmgI62mh73skpFzHibg7RN38cHSYohnXi/rkmG2fWjSo7PLXEeX/hiSycbGk9K7DKir1DZcU296Xg3/WxL9mU25WChPY8HfvXNk2MkS4SP+ftARcP9O/wbbYjivFnYHusQxCpaqq7MPHUrhW0tsHq3mjlba/eTM6KjSZaXMjY1Pj4AJFz11EIdZE5gr8nfZSOCYs8GTPTn0POPsmvDmKlMqFKqMIWppYdPsVSiAwGLwdkwaCdqCiiZd1WzLv4OfUbe4EVLe8WroSpWtHnjPXNotFHgrrXtbbYAdvu2l8OdOqeVIOGEzI/bewDgNrBo7hhhBr+IXK1s5GYqWtxavDMI/cnobwIC6YtAkYF7baBX7hHGQcYgEJeft2Dn6zt
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:38:48.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7698d217-4631-49a0-a55a-08de70856092
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259718-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gehealthcare.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D6D2167E33
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 03:28:54PM +0200, Ian Ray wrote:
> On Fri, Feb 20, 2026 at 02:19:34PM +0100, Andrew Lunn wrote:
> > CAUTION: This email originated from outside of GE HealthCare. Only open links or attachments if you trust the sender. Report suspicious emails using Outlook’s “Report” button.
> > 
> > On Fri, Feb 20, 2026 at 01:59:05PM +0200, Ian Ray wrote:
> > > Allow the firmware and enable GPIOs to sleep.
> > >
> > > This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> > > connected to I2C GPIO expanders.
> > >
> > > -- >8 --
> > > kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> > > -- >8 --
> > 
> > Are there in tree boards which have this problem? Should this be part
> > of stable?
> 
> I could not find any (I am working on a board which I have not submitted
> upstream as yet).

Argh.  Apologies, failed search-fu.  There are indeed a few boards with
compatible nxp,nxp-nci-i2c.

> 
> > 
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > Did you use ./scripts/get_maintainer.pl to get the To: and Cc: list?
> > It is very unusual to see an empty To:.
> > 
> 
> I did.  This driver is marked as an orphan.
> 
> >         Andrew
> 
> Regards,
> Ian

