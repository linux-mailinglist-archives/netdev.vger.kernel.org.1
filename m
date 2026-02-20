Return-Path: <netdev+bounces-259721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPFLOPZkmGmJHgMAu9opvQ
	(envelope-from <netdev+bounces-259721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:43:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB1167ED9
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4111F3006396
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5390344030;
	Fri, 20 Feb 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="IZDckCJd"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41592346FC0;
	Fri, 20 Feb 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594922; cv=fail; b=s/R8LCOwzkLtsr2zE9GTcW7xR4OU7i8E4nz5jWcfOMrX3+WoaakigF6TxhwuWK2L5ObVlTrsCWcwGWhS6wUbOK0+uQzpy8N48gV3xgD+EkLKMVIPTNXAT/DqMoH3oemhEkh+XW4c6RLXW0i9YbHMBVm86w/UbSswAJK/woar3uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594922; c=relaxed/simple;
	bh=zF7C1JhLzThd0pGbAXn5xSMWhtGOC3Kd45h0UP/dKBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQV39oZDTFa/d9hQb5pk0QXCTCwqAiNyW3Uax9oeEhHjtcswiRxOHmmjYxrFUNzkDC0ItD8BGJNYU3bGAnKw1H8cXF4vwsLzYT6ehGT+g7F6aOdf+uxc9MNPoWQizyQO5IFRASzjFtqa4qTB5Yd0DK7/65Filhu6PFnY++SApN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=IZDckCJd; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/dEUKFfFCxm78nHWrvZHtNy8kmR/6z6P9wDOUHaQMBAJK9FugljdA6UQ5TWqt1lW5bqRCsiGkWfYDhFWoIJzNNvm0ILQ2byTf80eC+XuikL+JCA4AC+HlTNgiQ53xvyaA2WEiEXbvKdZXDAosFqfDdOe3YbFyzNXdqGeONAy7PeVH/LCwY5yuCpvM6rtSWdijZMNaewzQwTSmoyx7Htfxrj8wvoah3RgfL4mZRtks0Migax07iWKwTR+1wA3k0PaVrl5wiR/vIIXuN0Q77pZjlXkHfkdVkQUI+1F1/Q1vZ3gEShbB813r6TXHz1tkXmBJwBE8Pl5AoI/u1J10d0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRnfxOIv5XVz0CQGLKr1TE6ijmxM/DAnkj6UT6gYKZw=;
 b=I23q3th4jcYrhCfrlkzGohGiurdVMMAFWO7R97LBWB1bnqR4coqaTrEMVmftMKH3yCqNU4cvK3VXi1du0KGYqcKfQX+E0WR8PxhnyQTxM54zRh+ZeJ9QFWJ/beRgeGvsSROo8hHSsIoXBYv80JODmeurWM8Da7i9xPmWvd2RBacWUJKUlF/AzAurBtUfqIeH2iKEQoVGQGQJe4OmmyzcHuxrkAq1Jdde7M/HLOv4+PCHQBrCQx7nafbgDaUJNPhrFy+JlOlO+ulfcAM346Y1FNWbb5blmmr1NJF76F6OajlqJydih9ASttvr6/MdVn/8UiPLgHX01SDeta7Q3cEbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRnfxOIv5XVz0CQGLKr1TE6ijmxM/DAnkj6UT6gYKZw=;
 b=IZDckCJd+SioAHe7Y5qas7mkTXVo2QsUZuKXYv0SaoOISWeHgQkI932F5x4cGjbFGZXWeWge+7lwRVNlHx+EL+gLGchqjxxxrRucvjRt36NcZo9lZOg+QjJv+OySupZkYIPVVjR2zwvWroFqAzjLnsEqB9Q2uhznAeVNG8tdO2CiEEW7btxxjIFPaWYtme9NX+wU+u9NTHJhCQelnCsWbULF8f8Oq5NToJYrFw9gA8PH61QONIPkUgYtJLBvd5f6U3ac5Xkh82NrDrYoZ3BwIG4TdxS2ZV2lvkSuoPUV6prEQmOdi2+kDib0i6oTS87r6t0SqhSJJmOSwhGwpYwYCA==
Received: from SA0PR11CA0086.namprd11.prod.outlook.com (2603:10b6:806:d2::31)
 by CH3PR22MB4294.namprd22.prod.outlook.com (2603:10b6:610:180::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 13:41:55 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::ab) by SA0PR11CA0086.outlook.office365.com
 (2603:10b6:806:d2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 13:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 13:41:55 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 3259D1A2CC;
	Fri, 20 Feb 2026 15:41:53 +0200 (EET)
Date: Fri, 20 Feb 2026 15:41:52 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nxp-nci: allow GPIOs to sleep
Message-ID: <aZhkoHzK9YBoy6xx@zeus>
References: <20260220115906.102470-1-ian.ray@gehealthcare.com>
 <875x7rblmg.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x7rblmg.fsf@posteo.net>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CH3PR22MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 55352834-25c0-40f2-f8e9-08de7085cfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGIyeWhoZlgyN3hBMk5hc2VSK1Y1RWtkUTlaaDZXS0s5VklwQUZ6bTNDcmZ5?=
 =?utf-8?B?cmdzaDg1WmlMSmd6dURSUHJFeWFjQWVDVjBjSWRKSWlBSWVJMWlnNEQ0TXZn?=
 =?utf-8?B?a1VyTDd5OHphNmlKMjFwMWR1ZzBhVnNWU1hNSmduWkZxT3lTUkt3N0dnQ0ZD?=
 =?utf-8?B?L2ljMFU0ZisyckkwelVJN0ZLMHl4TFVIZXh4aWFBZC92MjkzYXpoTzEyVXRJ?=
 =?utf-8?B?eTJjazNzZHUzUUhFNUJWeHVabnNKbDExSjlRemFGNjQwazdkQjNFSlExVmlZ?=
 =?utf-8?B?MDhMdEJDMVlpdFBmOFQwNS8rRWJEWVpYYWptSnAxZ2Q5Uy90YXdrNzhBeWo5?=
 =?utf-8?B?UWc3bnYrNUFvQVZGME1TMUVockp2T1pubUxWempHVDIyQy9pcThZQUZ1WjUz?=
 =?utf-8?B?MXc1Y09sTjk2SG9FRGFQekY4R1dzK0hHVlBuakdTbmV6KzdSR1VXdEs4NWxW?=
 =?utf-8?B?VGg5NHo5Y2RkMWFsYklVZXg1UXc0RS9jdXNzUTBZRkwrSlYybHU3U2d1bDJU?=
 =?utf-8?B?UGFKTUd3UmdwM241QkRhS2Ixa0tINU5GZnlrTlNlSlJMaEF0aWI0RFliV2pR?=
 =?utf-8?B?VnpIcmE3UnN4QU9KN0YydkNHRURzV2dBOXVHWi9qcVFDZ3VFVnE3RGI5alhS?=
 =?utf-8?B?VGovRkVvMUFua2hSdXpOcS81VkxSQkxlaUtuTk5KeEwxbEtndXdMaFhmUGM5?=
 =?utf-8?B?VHFodUdUVDJRb3hTd01SRVVHSjNzZ29oMDd3QTJ3Tk55WmVZNzkrcThsODNH?=
 =?utf-8?B?ZTNSN2FZNXhoNi94NkVvL1VhR0F0SmU0SHRhZVBwVXdmOHo2dE0vcGdwZU5Q?=
 =?utf-8?B?dVlVWGM3bVVraEpGY3Zwdkg2VzFLRWErVWs0ejJBOSt1L25KclNJaG45Sk9w?=
 =?utf-8?B?TytQY3VXanRSNHpHK0hXQ2xDbzFnYlZ4YkFFUDBkTHFEZTdaSk0yTUpUMG5U?=
 =?utf-8?B?UWJxQkVaYkRnUHg2akFDeUxLT0xtYWtjc3lvY0cxVzVjUGgxSncyQ2l0UEFh?=
 =?utf-8?B?MFJzZmV1QUtJV0hFZS93Rjk1TjNGUnFKUlVVemQ2a2JqajRCaWdtTGEwNC81?=
 =?utf-8?B?ZFFvb01salhZenpEK0dLY2hMeGlTWmlYT1BCdlpYdEZVNGVpTnNvWnphdDVs?=
 =?utf-8?B?LzhzZ2hKQ2htSi9DT0RqTzRQN3VjMHZuQWRWZldyeHlmckNiajVrUjBweFo3?=
 =?utf-8?B?RFJEUzA0ekVxR1VLajcvZ3c2OXd5Q0VUbUl4WGlVVGhGZEkxSjJFZmVhZHh3?=
 =?utf-8?B?dm5KUVViOXlQSVJTcUNuekQ0R1JKRUYraU5BQW5oRjRDVnVFNGF6cGlxdDhD?=
 =?utf-8?B?WnFTbVVlYnRZSUszVWtKU3drbTlUWXI4R1hCNnAyUzg3WHp2SC9oNnpkNEha?=
 =?utf-8?B?aFhRa3NRZWdweVpYWk1abmNqdlREcDN5NU5nZ3VtME1ldnlrblFEZTU5MVo3?=
 =?utf-8?B?WG9rdktZVmxnZE15dUdIbENxVjdUMTdiQis3YlZZc0huTFZUeXErTHVoMkh4?=
 =?utf-8?B?cm5MS1ZkckNyV284OTlPK29SaDdrZXQrR0hYcS9MMlAvb2YrSi85dEl2bWZh?=
 =?utf-8?B?SFJTQS9tbXA3aE1WUHlURGNsVzFCVFJ4Ukl6N2xlUit1RjRYZyt4RW96dEdy?=
 =?utf-8?B?VlJKTG5PVTJubTlJUkN3d01vcWYwdkJWbzJNa0RWVXZkRTcyNXhRTENBL2Uw?=
 =?utf-8?B?M2MreUlTdVJXQWk1Q3FINHlkYktIdnQ0RUZMdjhjUHl6Y3N5cHB1cjd2aTE4?=
 =?utf-8?B?M2RTQnpMWkVDYzVZVjY1ZnNhNXdOb1dXQjJSdTZjRlE1N09YVG13U2d3UTU2?=
 =?utf-8?B?ckJ1SGN1anN0dTJaT1BCUXYxeGttQTlwc2p2ZG9mUzhUWW82TUJpNDMyMnZD?=
 =?utf-8?B?dUdURU4yNzFuRkdOWFhHZkc5RGFOUGtNMDRIR3MydjU4T1U4Y2RreEtXUEVq?=
 =?utf-8?B?S09HWHJ6ZFNvVHNxejg1NTRTVjRaNkwzSlFGMFJEMEhvUzVXZ3lFdGJmY3Q4?=
 =?utf-8?B?SlZGL0JMd2FyclNpWk9IRXVsQ1A5Z3VlS1p5ZThIMGNibU5DcDFoQ0NNT24w?=
 =?utf-8?B?RUdoUHl5QytNWXVnMFhrNWtuRy9QV2VQcFovRUxVUXEyZ2pLSzU4Ymk3QjNV?=
 =?utf-8?B?RkYwQ3ZaV2JKbHhSdlpBKzZSc2VZdksrVm5iWUpGa1Y2TjZlSm42M0grYUFp?=
 =?utf-8?B?NVRLOHJrc0RrT0c1enJhQ3NjV0dsUXR5MzdkWkl6QjJ6R3RLRGZ0RFhSOTE5?=
 =?utf-8?B?dHk4U3lxMUllanQxMW11anpac0RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7XiDaMGTuiR0QM2wvKq+evxmNMoGyPElQsbDzT672hkiDgQzIfhLwYoras0vV7q/gn/jYZBIrAx6ONo7pIAPwxpiB8qgHHSEsDO/HyK1SS6UaTlqhUUywWRQDJTnNMk6ZoSPdRzGbqrx6u4oo21SywTMDFHRdBFH3YV/9VqA2KvCd3gf5HcJsLGHqLILdvoXXR1uj0Tx/gPV7UF0OwtSQAZPU1h678Vf2Xn4OR0l3vbv+U+6YRgInhdpFmSmp/0rxgVhLkoj/LqMQsmbYHioNdaq2d4AXCMr63ra7NNUE8cuI/yco1bDjETXPZVwFttYiziGVT06TaP84DSlyHx+Y7EOwUv5O/Ug/0t3oRGQxmzSyXaJ1h7fCkC3GLNzRsehU44eVVjDblN/Y0Ob5D7mg1cxo123J9Fkp4U2lxKRXf4XNfvH73pqxbw+3wDBIV6e
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:41:55.0301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55352834-25c0-40f2-f8e9-08de7085cfd1
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR22MB4294
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259721-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gehealthcare.com:email,gehealthcare.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AEB1167ED9
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:16:56PM +0000, Charalampos Mitrodimas wrote:
> CAUTION: This email originated from outside of GE HealthCare. Only open links or attachments if you trust the sender. Report suspicious emails using Outlook’s “Report” button.
> 
> Ian Ray <ian.ray@gehealthcare.com> writes:
> 
> > Allow the firmware and enable GPIOs to sleep.
> >
> > This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> > connected to I2C GPIO expanders.
> >
> > -- >8 --
> > kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> > -- >8 --
> >
> > Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> > ---
> >  drivers/nfc/nxp-nci/i2c.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> > index 6a5ce8ff91f0..b3d34433bd14 100644
> > --- a/drivers/nfc/nxp-nci/i2c.c
> > +++ b/drivers/nfc/nxp-nci/i2c.c
> > @@ -47,8 +47,8 @@ static int nxp_nci_i2c_set_mode(void *phy_id,
> >  {
> >       struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
> >
> > -     gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
> > -     gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
> > +     gpiod_set_value_cansleep(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
> > +     gpiod_set_value_cansleep(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
> 
> Do we need a Fixes tag here?

I think we should, yes; sorry for overlooking that.

> 
> AFAICT this was introduced in
> 
>   6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
> 
> which used gpio_set_value() instead of gpio_set_value_cansleep() from
> the beginning (that is before transitioning to gpiod_* calls in
> 43201767b44c ("NFC: nxp-nci: Convert to use GPIO descriptor").
> 
> This piece of code is present on active stable trees. So you also need
> to Cc stable?

Yes, you're right, thank you.

> 
> Cheers,
> C. Mitrodimas
> 
> >       usleep_range(10000, 15000);
> >
> >       if (mode == NXP_NCI_MODE_COLD)

