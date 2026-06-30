Return-Path: <netdev+bounces-303108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VCjhHvCmQ2pFeQoAu9opvQ
	(envelope-from <netdev+bounces-303108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6216E388A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:22:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=eJ72Yp8l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303108-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303108-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03AF0303CFB8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA440B380;
	Tue, 30 Jun 2026 11:09:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022092.outbound.protection.outlook.com [52.101.101.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9D40911F;
	Tue, 30 Jun 2026 11:09:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817781; cv=fail; b=E2PeE1m4jpkBhX0SQCtY9MezwwWCxCjPExWOXH5NEPcvw5DSVz/KgV8jk6SGE6bWrDvrP/34NSGF3wOIz2Jnnvtht3msbZ6Ozy4sB5J82TVgoH9apdlqaOx7YfLwboehk1nXMf2lsF6FIPJBWUFnzz2aGTURyf+3dH8bUzNJ7GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817781; c=relaxed/simple;
	bh=mZi0wOdAl6ltWcfYXLbRJGspqXAr9XfeCPV+n/zGi/U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c3cjXP52bxbDqwyNn5wnMkcPSPNfd+eR/OkrNkcfTL/xBYxqasgTb4KarMG47ejwlagqpRGo07108ZQPW5pmYPDaiLhVbJbEuAcLr6lJcR1DxAC8DEh31q+xOo73FeQ7WJvcc37jxNDCyFmWbVMw6+9XRbJLJU3aHpnkkNaKxH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eJ72Yp8l; arc=fail smtp.client-ip=52.101.101.92
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPxzE55LfysXqJ5EDpbNYMGzy88xbJBlUf3GBEvT6I/YP6tfKiq7VS2OhPtmujmwGNlztVtXs3VhovMgfLi+n5saSRNwDGUMEHiKYqwNk2TBYmNzLbAcOkvxTjJHdqM3pYXoA3q7GLQ8Kh+eZE3vQW6b+JPUc16CWjJxaRAvI3lsDSLGhjAmZKsyoFCtw5YA13aJhacpj4BYgZrkNHiQX+kFQkv4VokhpGHH1bS4JOQFG/pfY6WfCalia68b0pmATk/i5OC693QY8Y8FssQ2VmKsWKyMFlX4h9zO9/v1e1fpC684Aka0nOEAxqZE0eVARdm5T/fDUA7ktcHuhjMVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHfkMFMpSH1VnzQiLr9LFl2Mm2OsGRKsbeBDWeJFlV4=;
 b=rpZOlU4yRwgyNuqKYjSk0gqQSIMm0a4WBdRarRvZdL+aOYTlVM/mIKyu90uOphL5t9dj05AxoSDjlyFLCqC9H01CeIz19Kc4oxpbb+uwqrHz6DF4hTJeOhQ4+g/8T6mlgAwrMZjulQNFd2ZjzpQ30pYlOq/QNgC7/jStpsEBC9ub0Y3To7hr5vWE2N4bxs8t19ethWuAGJaZ4kh9NP5EvwH2uxn2SI96OAx+Dw0wpovCI0YaCZJGgR1BhfSfTI8UcU5MEX+bkh4/4BsYqv9FX36MzIENNPSzAp4Zlfz5kvkHc6C2LBtzm43W6I5VVbq8J7gddalwPHEH7kRGHa+JVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHfkMFMpSH1VnzQiLr9LFl2Mm2OsGRKsbeBDWeJFlV4=;
 b=eJ72Yp8lHkzYGjI2Y6ITsNaKl6OsRyXi7e7ff6bYMqt+e+euCCLnXOY2XWQTw4UizCMEtnUZu640r8/DjtdLAksRJ+WuxuL6iZosEqowdP32tGud5ihRl7Wakg6a3uiVqg0Da8TqiAgv8dGavYamNg66cCibXXfyNLEHF5paNlk=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7689.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:09:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:09:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 30 Jun 2026 12:09:04 +0100
Subject: [PATCH v2 4/7] mlxsw: don't keep pci_device_id
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pci_id_fix-v2-4-b834a98c0af2@garyguo.net>
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
In-Reply-To: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 GOTO Masanori <gotom@debian.or.jp>, 
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vaibhav Gupta <vaibhavgupta40@gmail.com>, 
 Jens Taprogge <jens.taprogge@taprogge.org>, 
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-scsi@vger.kernel.org, industrypack-devel@lists.sourceforge.net, 
 netdev@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782817763; l=2806;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=mZi0wOdAl6ltWcfYXLbRJGspqXAr9XfeCPV+n/zGi/U=;
 b=B8fn6woD2OvyhxH1hz8x5AsUDxibNW+tqlKMhmD1E5xFONvCfrLyWfY6YZHF7hKM0YodWiDZV
 nQcUx0nGaK4AikkQFCTtITZJEgrMnLDQFgyH0H13fF2ud3DKabNeiRe
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: e0baad27-b2f7-4773-e112-08ded6980ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	UUlVwOa2f0FEg8q9YwZQT6DtcjQo4QUkWXAtH+QH0+9j2sNbqXxrQCJMuTemHfmJ+5rfsPJuNjRkViak01ceZKL5DUzGmwOCQhT92WIjpHhANHZH/AgETkl7778Tt5mAoYWyJgF1LuKxcIz2x57RUmyGGhwWPKsxGfNkHC2zYVhJ3NBfQW2MIdKhZh+6nxIY8R5fyUv7V0liU76rYsohlwsF38Nw8Uaqdnxy/Y2O0bZzZuKnCLFMgWv+XdsX54nX0IJDkomfzk0mUMVa6arLe/Rj13c5ycc5iWsPaiPZwv5Ikyv/wMU0NNFNBjnqIc32cOONAY+Ag2qye1bV/atZ3ZU8aSVvBJPAiPLaF12rVM1WwotvCJzSiwlBdwvSh2MmLmneJPZ5IgiVon94Jez4Amgs6AskzcVRs/6z4fOcr6fSkLf5M5/WGC2T9eYacZrGYm4PN31qqzhajXJv8GVGdKUmpXRF915tVfuVjcWrs7GOPGXxxIeau2F+wm5SbPn0OrzDp9L7xn/goeX+ms3X9botrUVOFGvCBSwcLFCTy5t6ZhNWl9J+Lxi3QOjJ1adjnR9OE7Spp3rUdGpp7HMf2VEdNoU/DUgQZyZ/ZdkCrq/0F3+CvUQY2BPavjpNbJKM3RFaC1A4ACQR8pa2ryP6cc9UJmUihFFeRxxV75T/7RoCVD4WwSOtVN62t/gDef7SpMtZTinMdNmQZZRtey/icA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(5023799004)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtaaWYxdHJGZGxYdGhiNHU1L0ZwQmNaVUdlVXd0Z2tOayt6ayt4aVdUMFR4?=
 =?utf-8?B?bmRRSnNxazRyS1lUWG1iTUcwSHREcTZTejg4aEVoSy9VR0NmRkt4SlZrUi82?=
 =?utf-8?B?bE5ORWN1U1E2RmtBbzB3c21oL1M2eTVvQlhoN2Y0U1F4cUkwaUluUjVGS3o5?=
 =?utf-8?B?M09JeEN3S3l1cFRaUXBxd1ZHSHFOS3pIVUYyMnNkWHZ5b1VsVXg1MEY2ZzBH?=
 =?utf-8?B?K1IwbUtWb2JORnFNaWRWTnpZeHF3VnJDdWJKN3FhdzAxcFNpMHpocklOWHJs?=
 =?utf-8?B?YTNKaUMrbjZFS0drMFN1M2Q1ZG4yaDF2NTlneUVPK0lWeWRZSSsvL0JtcGtM?=
 =?utf-8?B?SjZ1aGxyK1lnSjRNdExwR0xFa2Nnb0lDTWh1aXV5YzV0SzJrUktCVHFxVW9B?=
 =?utf-8?B?eVVSY0NKOVhNM0podmNIS3RBMWdZQ2R3TnFrTm9MWnZ2K05md2thVGlVbWFE?=
 =?utf-8?B?dFVvQ1lTeWJTbHZmZlovS1NFYmtLM2VoMC9SbjBhZkM5WUJ5UFZidzZaZjky?=
 =?utf-8?B?Yy9scXRXNG5lS0J5Y29TdU8yNTBoRitWckFHM3Zud3RTeCtGNDV5V2NwQ0pO?=
 =?utf-8?B?akV5Vis5dGZRYjlzZTVxdFkwcVB2TGRYOSsvL3E0OThwSkUxTEN6bUFOaUJB?=
 =?utf-8?B?OUdxTFZDNmVVbURGNHVqSDg1dTVSc0tpQjFGdUtCaVV6R1VIbENvdjFVL3ZX?=
 =?utf-8?B?QWN6ZGRTL1hLNEhZYy9wR0Q1NzJWOXpiOUFSNnZXT1IwMlU0ZTVPdTEwRjhG?=
 =?utf-8?B?TThSNytMdzE0bnFLcjU3cEwyMGQ2VmhueGVaSWpScXZObkZLR0g1dS92emJN?=
 =?utf-8?B?WGpNTzk1L3BGbzBzY0NlQktqR3l4QWJacWtMZVQ3cklURm5Yb25zNmN4bW9V?=
 =?utf-8?B?U1BqOUlJSTFkdktlU09KcDJnQ1RBbGRCckRZbGkrVldOMHZZb2I4cDdxQnZG?=
 =?utf-8?B?NUZrSDNWV0htd3FEWWp4cHJXOWZVRnZ2L1FVZTNGYlFsK3BQbFErSFdIdnA4?=
 =?utf-8?B?cmkzbGRDQ3kvREtQaW9pVWxrV2l4YnNOK25qK205OGU2OXdBY0h6c0hibnMx?=
 =?utf-8?B?bWRCL1N1WVdkbXFNblcybmc0UllmbDRBRjdQWFVvK3B1b2Y0aDZueDhrS1lj?=
 =?utf-8?B?bk5XVGVDUVNuVkNRZ3d0ekdhVUo0MjBJcE5yRmlMdHJvR0toZGp3SDVCL2NV?=
 =?utf-8?B?RDNSdnlFMWxPTGZEOE9yWVdVM09wYy91THZVNWJhR2ZVeWVnYk0yNlZRcmVh?=
 =?utf-8?B?V1ZJVG50VTRWME5xcUtHaDExMFdVVTJ5OTlYS3pmNWh2UFRZSEtUMmZERjlk?=
 =?utf-8?B?dTBZYTdyZ1RYWFEvaWNQdlNZdisxY1Z6S2FicjFuMU9IaUpDb3BGdnd5SE9D?=
 =?utf-8?B?L24vKzFCR0w2UDJkTmRtdFhnS3VjYUhOS3BzZDYyUmk2dU9ScndnOGRwbzVF?=
 =?utf-8?B?L2tXVnBZZGo4QXpmN1RsWUNyeklxUEhabFJOK1ZaZFliNUJ3enlUcjMrT09Z?=
 =?utf-8?B?R0VZNHAxNGYwTFFDMlpKOXBScjRvN2M0WXd4MDIyaEZvSXZxa2FURkJId0JS?=
 =?utf-8?B?eHBHOGxYanNwaHhQUmdnTWNGMkVZckw0dmx4R0w0eFlwZ2RySksyMEYrQ2xY?=
 =?utf-8?B?ZklxaVY4ZklpOFA2MkZ1cEsraDcwY2tVOVB4d0RyVTMycUVQd1FjaDd4ODM3?=
 =?utf-8?B?c20zc3ZOZUpRMlpldk9mUlFJcjNVMUlaYVNiTW5IbC9WUVpiTlpTNGlPcHFh?=
 =?utf-8?B?SUtHcE5xbm4wVTBDY3cyZjRPWE5weUhPTVVzOTU3YXdPVUJ0MXdhVHZ6a1JM?=
 =?utf-8?B?VXFsZ1pBQXlma0I2c3FrSm1ZK0lncU5qTk52RkFicFNCYm5yamJIN3ZGeGJZ?=
 =?utf-8?B?L0ZZdnlMVm1yRGZieXpCRzRidlJuQkswQWVVMlZDQnExckFkRlhxdGR1T2t2?=
 =?utf-8?B?QkpUeWdtdjNhRVR0WW9wTzliUS93dVhXR0JIcFowbVlvcGFWS2Y4SnVxSGRK?=
 =?utf-8?B?N050dFVROVYybXZlNmYrRUh5UXRKUVRZZ3dVdk15SFVSSTNKRERGYjNaTEJD?=
 =?utf-8?B?aHg2RXNYSTJ3RDIwYzFib2ptNko5KzhGdHNTbW5TN3Z3c0wxU0ZZT0dsMGJT?=
 =?utf-8?B?aS9ESTNjd1U2VHpuUk5sZXBKZjU4SnVORXQwemNHSFg5dEVnMFhGRng4OFZu?=
 =?utf-8?B?a2I0cFBxOTdkKzg5NzRzWVkzQ3RxT2dVVHEvM3hBcXNLeEtmN28rbk9tRFNX?=
 =?utf-8?B?c1Q4OGVjK2pudnZTMHVhbkZJcExJSjdEczNyaWFIWXdiYXhoVFYzYUE3T2lv?=
 =?utf-8?B?dllIdktYRldVRDkzbER1K2Ura21PekEvNHN1cXNBYTNkQmIrOUdNUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e0baad27-b2f7-4773-e112-08ded6980ba9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:09:25.2893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQDWVYIDS5dfMZZ+tJ5gaoNpFP4VUnJyJXqjGj/iUNfUKxRSxeO6HsBkeNMrr3bm5m9IZt1JeoSwLcN/Y/RCwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7689
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303108-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com,linuxfoundation.org,kernel.org,debian.or.jp,netlab.is.tsukuba.ac.jp,HansenPartnership.com,oracle.com,taprogge.org,nvidia.com,lunn.ch,davemloft.net,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:zhenzhong.duan@gmail.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:vaibhavgupta40@gmail.com,m:jens.taprogge@taprogge.org,m:idosch@nvidia.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-pci@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:industrypack-devel@lists.sourceforge.net,m:netdev@vger.kernel.org,m:gary@garyguo.net,m:zhenzhongduan@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A6216E388A

pci_device_id is not guaranteed to live longer than probe due to presence
of dynamic ID. This stored ID is unused so remove it.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0da85d36647d..bfe3268dfdc1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -130,7 +130,6 @@ struct mlxsw_pci {
 		} comp;
 	} cmd;
 	struct mlxsw_bus_info bus_info;
-	const struct pci_device_id *id;
 	enum mlxsw_pci_cqe_v max_cqe_ver; /* Maximal supported CQE version */
 	u8 num_cqs; /* Number of CQs */
 	u8 num_sdqs; /* Number of SDQs */
@@ -1768,7 +1767,6 @@ static void mlxsw_pci_mbox_free(struct mlxsw_pci *mlxsw_pci,
 }
 
 static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
-				    const struct pci_device_id *id,
 				    u32 *p_sys_status)
 {
 	unsigned long end;
@@ -1839,7 +1837,7 @@ static int mlxsw_pci_reset_sw(struct mlxsw_pci *mlxsw_pci)
 }
 
 static int
-mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
+mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	bool pci_reset_sbr_supported = false;
@@ -1848,7 +1846,7 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 	u32 sys_status;
 	int err;
 
-	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, id, &sys_status);
+	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, &sys_status);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to reach system ready status before reset. Status is 0x%x\n",
 			sys_status);
@@ -1880,7 +1878,7 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 	if (err)
 		return err;
 
-	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, id, &sys_status);
+	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, &sys_status);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to reach system ready status after reset. Status is 0x%x\n",
 			sys_status);
@@ -1932,7 +1930,7 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (!mbox)
 		return -ENOMEM;
 
-	err = mlxsw_pci_reset(mlxsw_pci, mlxsw_pci->id);
+	err = mlxsw_pci_reset(mlxsw_pci);
 	if (err)
 		goto err_reset;
 
@@ -2464,7 +2462,6 @@ static int mlxsw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mlxsw_pci->bus_info.device_name = pci_name(mlxsw_pci->pdev);
 	mlxsw_pci->bus_info.dev = &pdev->dev;
 	mlxsw_pci->bus_info.read_clock_capable = true;
-	mlxsw_pci->id = id;
 
 	err = mlxsw_core_bus_device_register(&mlxsw_pci->bus_info,
 					     &mlxsw_pci_bus, mlxsw_pci, false,

-- 
2.54.0


