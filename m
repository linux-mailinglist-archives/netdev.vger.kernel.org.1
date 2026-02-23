Return-Path: <netdev+bounces-259931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OcLCJ0BnGn6+wMAu9opvQ
	(envelope-from <netdev+bounces-259931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:28:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C638172A5B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E2A3002A0D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25831349B1D;
	Mon, 23 Feb 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="JpA1dGMF"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B918C03E;
	Mon, 23 Feb 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831588; cv=fail; b=YadYdH9b9tkKqxZvRfuBAFJQvZFhGMzmm+W5PtAZhFMeOBaNZz1Bzq11QzCxEujWhXK9jP75ORmzK7EC2tKph+sk3HcgiKoLqKG7oOM+8v6ROx3KIheNGeHwOCQdVvrbbwd1x0k/EvKyR7UXZ/4YaZdD1/AnaOe2r+E/2gWctLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831588; c=relaxed/simple;
	bh=73NIW3i7948rsZcsv4taOZ1WD9W1keHwdvtjNk0ws1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdFa06VL4Uqe7frNwdeefs+go0DQhe+cHc4X3KvKXpDjeeCDepNu1rxRvQNFBuj8VBEQ+KRGG4IcPpLpmJEtx+kRpGwL61iSNX3wlxpbxDElLMCuucI5tVPVM+h0byroRGqGhgyyGlL4mDeADKsld+7A3S4Ei8ZRpiRLKINTvxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=JpA1dGMF; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiPIah9uzm//CZ5M6Zk7bbUQRSnQy08yyu0RwXEc6qDZP1KsOYhxiY4QiXTthMDch6g6MG7OVoD6QYj06v8VWkAjyGXNTkwnudeIOwg0TQr5C4Uj6AWxnHtqNagLqUCYWALtdY1UewN64cg3arsoD7XTpyZB4g8y085Uc/V+yjtUqMUI4d4/eGP9PsHJ7mkkox71g8A/6H/mQlProZiU0n6xtu7DOM4SXPQXHdymrAd/HFPSTwesq2iD2kRa0/2GLgD9t8LINLUsndmj74dZKQKFmLinhQuoB57WoTdMqjK0fY+QFZnEluTv8HaOop5LtXlMD8K04iFaBeEK8IXJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiiw1pt7INKuVPHgFxEFJDMD++18aKxzdGzO/KVz97s=;
 b=ENVi0mclVKrLTtZSjMeBXn2yD1u+uyYrNcq8V+1ZZUMwIBIOwjaeJD27t5lH7t4htA1OpabI8WVEZjDtFVq4PDqE6dCxNt8KULJlBy4/F1OnETtF0Yon4VLs05RvhEpOLAS48zTF/raWwS5OaLoU/ZmE7H+9KAIKtzvHRe3O1vMQbXEf8yV5CHI/ZkKQbi2HrXvRZ2M1kcgi9e1dx9cVFQgxY8/T+shyxPHPqnt5TU8rF0vK/quBf9ty8+EP8phHd8kkoSSD9zb+BQdNoYj1ybsgsCQEKkabADfIJ4R0A6OHdxm+RlCJMXkVdrYubILSiECCJur4rZ/Te4ZXGrYu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiiw1pt7INKuVPHgFxEFJDMD++18aKxzdGzO/KVz97s=;
 b=JpA1dGMFiO3R0LTXLdGTHoepHC4Sfneuz0GPf//UtuVDoqmG5g4kcalVqRT1ytNvrFSe6UcpxwpHTHV9iCNNYUUl2zS0q1+I35cmiAxkGQwDcjtS/pz715OjWQGETgvI/OZV1l+8HHfDqGB05EY+61A4kkrkqqnQsQbVEjbinCVFLmxlRCKItPLBLRVHAd2CJUw0JSm56Xtvr5wb3dP1DWdOgnOot2X65AbHxHBiqbmMStzLJoh0jbci/Uv7lbmEGdbPBMmunEXb9fFVnnUNz3h61QYLefGI1aSfZN9jHBCmdsO0TF4ybw+2m05dbOzo8qmKzAQTJfdJNByfbqQ7Lg==
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by DS4PPFF596FC5EC.namprd22.prod.outlook.com (2603:10b6:f:fc00::b58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 23 Feb
 2026 07:26:24 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::22) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 07:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 07:26:23 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 22A00FB3EB;
	Mon, 23 Feb 2026 09:26:21 +0200 (EET)
Date: Mon, 23 Feb 2026 09:26:20 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ryasuoka@redhat.com, jeremy@jcline.org, krzk@kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	edumazet@google.com
Subject: Re: nfc: nci: Fix zero-length proprietary OIDs
Message-ID: <aZwBHFx7g7wbWOWJ@zeus>
References: <20260220112536.100017-1-ian.ray@gehealthcare.com>
 <20260220213419.3181677-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220213419.3181677-1-kuba@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS4PPFF596FC5EC:EE_
X-MS-Office365-Filtering-Correlation-Id: 67283b6e-8a45-43c6-1305-08de72acd970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|30052699003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGpBT294akVPNmFTOVlGbUhzTzVTQzJpZ1d4eDBFUnFESEJLZWlOWVlTMjFl?=
 =?utf-8?B?WVQ1dWkxZ0RjeVgyN0RlMG04SWF2UUNORzBCcWJCcmhqUEhVU1pDYm5PMTND?=
 =?utf-8?B?RjI0SzBjaHFZKzJJekdiWEtrcFFoUzZCbzh4REZQQ3NPS1RaU3VQNFE2c01v?=
 =?utf-8?B?STNOSFZ6SEVGVE5UNFR2NWlocG1DT0JRbVRyOExlN3p3clllNmtLdFE3VHhw?=
 =?utf-8?B?Q3BSYXlJWGl3VFQ5V0RIdGovT0pOYThwbXp3WjNTVitBbm9XaHhoOFdkVC9m?=
 =?utf-8?B?RGNLTTVGeFlsWk5UbXFTWlh4bVJ5cm1RWEJmSWNOMmhieDMxRFFTY21xdU5w?=
 =?utf-8?B?YTYxbXRyT2VYaEwxVTZmS3NzSlpvbmFjZFNES2daUHZqeURhREh1L1RQdjIr?=
 =?utf-8?B?UGJZNk1PWVBXNUtjWlNwV3h3ejFVcW1IVVBBMXFDNTJydFVFcVBIUU15Mjds?=
 =?utf-8?B?WVVWYXUvRlQ1TkR4WWt3YnF5akdCWERjWVN0VGhpS3dQVWJUWTRFeXhSMFAy?=
 =?utf-8?B?L0FhelVVUFl3Q08xK0dJVmt3ai9jYUJrOTBtbWxPMllEbFNyZUhUZElBS1dF?=
 =?utf-8?B?NzcrZ2krRXFTZmZJWnBtRVZTck5hYW1WRzNaaGRyZEJLNnM1NjhUSGxsSGNC?=
 =?utf-8?B?NW1oQVZZL2Z6YzBYZm9tT2dWckxGWDBiVHlGSmFVRUJIdDRZOHNlUHNEQ3dL?=
 =?utf-8?B?UVI3RWt1OWc0cXk3emhUVzg2UmFFVTdDTjRTdGN5OVhCaUpMSzNpQ0RGNDdQ?=
 =?utf-8?B?RVRRVWJIV0lpcENUcmFtZzFkdGFjbldzcThLVldZaHYyS2dQYUF5Z1lOaGFV?=
 =?utf-8?B?VFZsRHlDcjlreXVZTWRTam5uZXdCaDdIck9MNi9sTTB2UFFRd2h4WkdCUys3?=
 =?utf-8?B?OENzbkNjb3NNaWtlM05TUDVaa05iWlJ5Q0VVU1NpQ3VIZmNGMTBQVVlXNkU5?=
 =?utf-8?B?c05GWWhYNXZ2YWZmS0ZTd0VTV3Z2TmZIOUVIRGZyT2dEbmdJNDF4K3ZtUUxU?=
 =?utf-8?B?TkdCLzdXc1VQTlRUUlgvRFVaV0tXenU4RThOM0h0anp2b0txZ2dSSyt3WGRL?=
 =?utf-8?B?Q2s3eTd1bDF3eFhqV00zeHB1T0k4elhmcUxLaWY2Ymx4UEpncDRKTDBScEhL?=
 =?utf-8?B?ZTRoNGFXbmVQcnlIZFBHQ1pYa2xzd3ZxQkRqMGhIVU5vWE9IaVZaQ09GM2gw?=
 =?utf-8?B?eTZNaGtqUytHZFB6VDN2d1NCdGFTblFvRzBWelEwOFBBMDhmT0h0MW9FbkNl?=
 =?utf-8?B?ZklZVXZzd05MWS9IeklJdzVwdjQ0eG93em5kVlN0Umw0ZmU2ZnkyaHV5dk44?=
 =?utf-8?B?VTBPemt3YXhaVnYyVmhKSzB5KzBNZEpGNGFXc0EzU3dDZXlOL2w4aWV3cEd5?=
 =?utf-8?B?cW1RY25DM1Q3MWNkRFFRU3IvdU5xbGkyWDFjS0JSQll4Y2pDbStFb2ZwY0Mz?=
 =?utf-8?B?L2VyNTBKWmsxTlhjVTIxOWV6aURKaVRHZ3hGbUN0NnlJZ0NCdGZqeXNkTXVw?=
 =?utf-8?B?TldmZnA1NEprZFlIOFpCd1B0L1d5ZGYxNDVVakZ0U0V6dUtBU0xoYWhqdGlv?=
 =?utf-8?B?ZVFEMTdZUWRHcWpQTTRjSDhCZ3VvUDdWb3p1ZUNOQ05uYlVaYjNMMUs0TXh5?=
 =?utf-8?B?OEJ0MzE5Y3F0clBYME9yL1hXalJud1hwQlBEcWZ5RmY2Q3pSckxmMGpPN0wv?=
 =?utf-8?B?T0doekhCdTdYa3RpdnQ2N0xuSUk0aEFKWGhqWG5MaWo4MmJ3VThiMzdKQ2lV?=
 =?utf-8?B?ak5DLy91NC8rek1IL2t5Z3kzOXZ2OVdpd3BTNExYZFh1dEJiUlMyWFJHbFVu?=
 =?utf-8?B?eHVXNmpJVUhIdTdvY051L0o0aDZkTHRMMjdFZUZPdjdyQ1lhcjlUUlh3UXZu?=
 =?utf-8?B?M0RXZEhZTWlIaUoxUm1rUzdBd2l3N2hyYjVueUVrd0ZGRktJc2RqRnNzd2R3?=
 =?utf-8?B?L0JmWTNqQlRMbzkyWEFtSFVYRFV0MW5wWFNOczQ5ZFVPNm9mMDh5aG9HZFhh?=
 =?utf-8?B?cytoNGwxTGpPclA4a05Za0dmK1R1R0xnUmczbWRDNjNzRG5vSEQ5UTdlaWNX?=
 =?utf-8?B?emJRK3htaXU4M2ZsNEZSUW1vSkZ3VzU3L1pIQVk0QkhnWENSM3lBWlE0OFhQ?=
 =?utf-8?B?SVdzZXFiNzhKNUdkYWRQOGxTWXRMa0JJYUN0bk10aUNaZG1LdThkV1AzaFVN?=
 =?utf-8?B?NHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(30052699003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RgmdzaDsIyQR/m1veu7FuRpUGiePle/f6JYlXu4A/5g8wh8nQs5juwaQ+6QgwMgvhV076zYr/4sQGgwk10r5QkUcc8CHSFFLuXKpqHiO+8OH7X1ePGW8y7QU3dKNMPnC8j5a66YJ2A3knT4xHQZogqt1vHd0HERZVA9qCgufb/7P1sIlswK69y86/HdowFVm1hlGYBzuiQ7E8Zr+1t5piAUtc+sBF15RD4konfymK0PTkm9oIO35+ZizVxerz6n9hciSefz9pinPevqzlfKjVCEPGJyUsNWDWLJBiYi4ozcejp5iCpf+k4TNVI5X88LWJw+gcAdSgPvYF1QPWhEEftqvx5CBjHUneFc1VVYraPz2xdLzAcl9CeeatB1Tkgntl5e1Q8Se0lBBr553MKbScdTwXeYyibGtvK0oLPq/KtzwY7ZeHu0nSpNGlEDsyA4L
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 07:26:23.8313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67283b6e-8a45-43c6-1305-08de72acd970
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF596FC5EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259931-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gehealthcare.com:dkim,linux.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C638172A5B
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:34:19PM -0800, Jakub Kicinski wrote:
> CAUTION: This email originated from outside of GE HealthCare. Only open links or attachments if you trust the sender. Report suspicious emails using Outlook’s “Report” button.
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> nfc: nci: Fix zero-length proprietary OIDs
> 
> This patch allows zero-length payloads for proprietary OIDs (0x20-0x3F)
> to support the NXP NCI_RF_TXLDO_ERROR_NTF notification case.
> 
> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> > index e419e020a70a..78da0fb9ef3f 100644
> > --- a/net/nfc/nci/core.c
> > +++ b/net/nfc/nci/core.c
> > @@ -1482,10 +1482,16 @@ static bool nci_valid_size(struct sk_buff *skb)
> >       unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
> >
> >       if (skb->len < hdr_size ||
> > -         !nci_plen(skb->data) ||
> >           skb->len < hdr_size + nci_plen(skb->data)) {
> >               return false;
> >       }
> > +
> > +     /* Require non-zero length for standard OIDs (0x00 - 0x1F).
> > +      * But allow zero length in the proprietary range (0x20 - 0x3F). */
> > +     if (!nci_plen(skb->data))
> > +             if (nci_opcode_oid(nci_opcode(skb->data)) <= 0x1F)
> > +                     return false;
> 
> Does this validation logic create a buffer over-read vulnerability in the
> Samsung s3fwrn5 driver?

Good catch; the proposed change impacts:

drivers/nfc/st-nci/core.c : st_nci_prop_rsp_packet

drivers/nfc/s3fwrn5/nci.c : s3fwrn5_nci_prop_rsp

drivers/nfc/nxp-nci/core.c : n/a

drivers/nfc/fdp/fdp.c : fdp_nci_core_get_config_rsp_packet
drivers/nfc/fdp/fdp.c : fdp_nci_prop_patch_rsp_packet
drivers/nfc/fdp/fdp.c : fdp_nci_prop_patch_ntf_packet
drivers/nfc/fdp/fdp.c : fdp_nci_prop_set_production_data_rsp_packet

Restricting the patch to NTF only would make it safer and less
intrusive; I will do this in V2.

> 
> The patch allows zero-length payloads for any proprietary OID (0x20-0x3F)
> without distinguishing between notification (NTF) and response (RSP)
> message types. The s3fwrn5 driver registers RSP handlers for proprietary
> OIDs 0x22, 0x26, 0x27, and 0x28 that all unconditionally read skb->data[0]:
> 
> drivers/nfc/s3fwrn5/nci.c:s3fwrn5_nci_prop_rsp() {
>     __u8 status = skb->data[0];  // No length check
>     nci_req_complete(ndev, status);
>     return 0;
> }
> 
> If hardware sends a malformed zero-length RSP packet with one of these
> proprietary OIDs, the validation would pass (since OID > 0x1F), then
> nci_rsp_packet() calls skb_pull(skb, NCI_CTRL_HDR_SIZE) leaving
> skb->len = 0, and s3fwrn5_nci_prop_rsp() accesses skb->data[0] on a
> zero-length buffer.
> 
> The commit message justifies allowing zero-length for the NXP NTF case
> (OID 0x23), which has a handler that doesn't access skb data. But the
> implementation applies to ALL proprietary OIDs including RSP messages.
> 
> Would it be safer to either:
> 1) Restrict the zero-length exception to notification packets only
> 2) Check that all proprietary OID handlers can safely handle zero-length
> 3) Add a length check before skb->data[0] access in s3fwrn5_nci_prop_rsp()
> --
> pw-bot: cr

