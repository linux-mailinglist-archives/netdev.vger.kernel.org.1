Return-Path: <netdev+bounces-300204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3jW3E7zMMmqK5gUAu9opvQ
	(envelope-from <netdev+bounces-300204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:35:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A805669B6A0
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iba-group.com header.s=selector1 header.b="kE/rRTjK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300204-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iba-group.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9593D306715C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B534A33ED;
	Wed, 17 Jun 2026 16:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023141.outbound.protection.outlook.com [52.101.83.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DD481AB5
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 16:18:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713115; cv=fail; b=o5m6OrfiOhjrcAWN9pOfO1/liHdWYyiKppv+3OJ/9yvlwxCwMtie/G4k3t3cSIN9jpkj2xHWK22+L9w1e/SQ3n3S5dxqZcbmGm/T1ukY/IFvNLZb29pmgJbPSIwp7xH0BoQP/GxNmtHyGzPCQdrISsGkwXkbhVd/woH1aauTrd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713115; c=relaxed/simple;
	bh=kYhtVUR8WSD8I5ZmESnco3xro/LTnWFbcxVhiuzclZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcLRFvxVuyDJzTWtNn7Us3kZJJ/g8WbRgbpf6W92aYft/a2+M+4aZyO6X3yJMM3HAFvhhTFiJ/VGLLB1HYarb78zjKrJebVYyOmPrd+9V+M/KNRxIMR04wjmk1AlaGL1R/VrymJjLBNfxqA0QQ2eedzoZmaONj55iROTL9teZbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iba-group.com; spf=pass smtp.mailfrom=iba-group.com; dkim=pass (1024-bit key) header.d=iba-group.com header.i=@iba-group.com header.b=kE/rRTjK; arc=fail smtp.client-ip=52.101.83.141
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ramHJya7v2rZuCpgsAeriE0RrCeKSo0ijD/vSvIGuxs0tXjOnTFzuTDBL0kADR4a2CJIw4BcfOCV8+3OgpmeIH2VSIR5ncZOtomLrjs5oDKqPHJCpp6dklgd45n94ydDZXn5VWb8vFYgTCMY5ySaWqOTzMuaBP9OclNL6tXjZyMkiLdLdarRGncZAPxbIEgnzwOjtQz9A/WkFPOqHKv1TKJ8iOIjQmuO9b+TMgpwgjRTL5/+O6P6UoQ590KxOgVQB137DtSyPWCfk/AdXiWphqCDwEzZ/S7BNFNk1cPC6/yMOvzz6prurHrPQDSei58+U8OGp57pNDOV4PJrBieodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYhtVUR8WSD8I5ZmESnco3xro/LTnWFbcxVhiuzclZc=;
 b=RqgJO9EEuXTImH5NJHs+ouyPVtc6nhA7VOqiPUhe+9OzTlYw1L61DuNXqlYElWQ6jwScn1uBR6v487G8r2z4ptfOkC9+w8SbYLL40ZGN/L8HdLFa9WkrSQfXnXpH43vA6rrlSqkLVZ6L7swbytAxnsMfNsPuakZ70CJegNVNYpbmEq+qU42KMrZuSS94wtBU/ZRZDqbImlmaUD3QbZMVJRWIiJB1Hionr+GV4w0og1ce2ycW965RxNRBbfm1KJwiKRlrSdOjgo/oZR0MTUb1VF6zCyoh7m4DnKpkz+CkW2Y1/unazlt3Ex6Av4512xlJM93yuoXxnU9Z+Fo+6aClHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 185.185.229.160) smtp.rcpttodomain=iba-group.com smtp.mailfrom=iba-group.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=iba-group.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iba-group.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYhtVUR8WSD8I5ZmESnco3xro/LTnWFbcxVhiuzclZc=;
 b=kE/rRTjKQaT5Nj04eE4tpLyEIy+u0XxtVwx8fDwoBONNNrafP91iMsTUPKPbrld6egOK1gNcmwOU1K8xrSdyK4pYaUGqjVyJCGSXsmuylwlPbl43fPDdH9esxVzTXd85s4e61id5+Lek/a03SEcmahIUEp9dL8aqJjHA05ps3QY=
Received: from DUZPR01CA0301.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::18) by PR3PR06MB6812.eurprd06.prod.outlook.com
 (2603:10a6:102:64::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 16:18:22 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::27) by DUZPR01CA0301.outlook.office365.com
 (2603:10a6:10:4b7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 16:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 185.185.229.160)
 smtp.mailfrom=iba-group.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=iba-group.com;
Received-SPF: Pass (protection.outlook.com: domain of iba-group.com designates
 185.185.229.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.185.229.160; helo=mailrelay-lnx.goiba.net; pr=C
Received: from mailrelay-lnx.goiba.net (185.185.229.160) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Wed, 17 Jun 2026 16:18:22 +0000
Received: from dc1v2pmailnx2.goiba.net (localhost.localdomain [127.0.0.1])
	by mailrelay-lnx.goiba.net (Proxmox) with ESMTP id 02B90351117;
	Wed, 17 Jun 2026 18:18:22 +0200 (CEST)
Received: from cernunnos.lln.iba (unknown [172.30.1.178])
	by mailrelay-lnx.goiba.net (Proxmox) with ESMTP id E0B3C350F4A;
	Wed, 17 Jun 2026 18:18:21 +0200 (CEST)
Received: from localhost (unknown [10.100.28.183])
	by cernunnos.lln.iba (Postfix) with ESMTP id D61CD166D;
	Wed, 17 Jun 2026 18:18:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id C5F7B60449;
	Wed, 17 Jun 2026 18:18:21 +0200 (CEST)
Message-ID: <886bbdd7-3a0a-4f61-b2b2-2b8c37d8e71d@iba-group.com>
Date: Wed, 17 Jun 2026 18:18:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches
 (too small inter-packet gap)
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
 =?UTF-8?Q?Fabian_No=C3=ABl?= <Fabian.Noel@iba-group.com>
References: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
 <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
 <3b073409-9096-4467-9baf-11196a70c014@iba-group.com>
 <ee384978-4eca-4a49-b1e7-55be7698970f@lunn.ch>
Content-Language: fr, en-GB
From: Philippe Andersson <pan@iba-group.com>
Autocrypt: addr=pan@iba-group.com; keydata=
 xsDiBD6tQKQRBADCF1oXR0PqOezJO/Oh+15ZQZAEQ+R7blg0Y6ExRnCEQopb81Y1MUMFAAFP
 3FNIZdlp1909wW9bbJklb1O8vwZ2VuvDyn9Min4NM+f6BRIKnGiMpJQW7UO+Zgk9gGzRsTxm
 /SN+aALQnjhXo1GZigDB2sglxtr2GTQcQwsDrQosjwCgpZ8f5oBoqQcICnU5hEoaL+s6qj0E
 AKeX3/Ir7950jxN6uyCtdIkDK5g8l2GKj7siga0lGhP43QLqR7k0SJPvxCyqSaozTPXsV2Qd
 UvHXdcifl7Uo3kbd746HF4zYlGKAAx+spZ/e8Fl6RW1YMGsGA+Li9010QEZZyl7hlVywiYaT
 U8y4mKxb8NUzJgPPP4GilGiUsj/4A/0YB2Ny1KjOEnqe8WFdbACURMbIKBg/I/wYfeiD7kfi
 lkuVr7WRbwc9YeT7fzxbJN4ALdsBIvbie6pfLFwFbqTgXdVUHgUmcd/K0o5FyzFCrPOEdf33
 HqxXU+dfNeuF9iPspo2+gpoOug9WSS0iyloEg1lY+hULTJnJlT6a278cN806UGhpbGlwcGUg
 QW5kZXJzc29uIChJQkEgVW5peCBTeXNhZG1pbikgPHBhbkBpYmEtZ3JvdXAuY29tPsJjBBMR
 AgAjAhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AFAktsINACGQEACgkQekr4Tg9JH2zTrgCg
 n8is5vSqE/TUTOppZXeKssLSjtUAnjf84a1oqOg+DFe3nOU0iiroE1f5zsFNBD6tQOQQCADj
 r/uEPaONzqm+1UmMlH6wR31Ie+7oTWyrALbjP0gzuHcM8WnitFUxo2XnAvEfWqO3yvATutUE
 JJkYveoMLaKJIDvqzpM3nCNu7pO0qB6Z/yWbPzFg8ubJacwkjkUofKNWmyu0+4tLS0KeYwuv
 V1o+EhXsnhNTlCuGIufOMTNUE85WfGy2KYkTWw+noqW9BurMNflX1jN3PrA8qRMTnURSgxd7
 oUBAg4zG89j6KQ37Y/dKApSlm+1wJtM+KHL434iQWHL9hnRslKFHbp+RAyXV/38poDci9Ny8
 /+y94h+o6TEcw80FYT5rmssJ8qp2ZNQoPvlthjyPbTTPz+oM3c4HAAMFCADDVsXBsVgAfG1/
 JnN6/Di5YHUomFVV62xtuY6K3g2tiZfKr1ZO/yHjdKRZRW3fbwJzwVk+xS1XrxCDiVWJS7mB
 oPcu+C5EBT9bK6QDa3eAxVGDEni8p5PK+ygJsz+QSQ2K3HhefsjnkFx9fergHyOqa2lhdh4o
 TCUrQ+GvB8sZTyJSWlCt/Hu5TgobRCV/39PKLTLp6qGR4yOxsLIK90WhHwAYG0DjhGJKGgU2
 lXBRnS46u6ODbVErjeq6FDGbSgex6cJaC8VTtAoa2mO19xVrxLNJB0DhRx/jmOE6TrzmtIDN
 siYlZsoas/6zf7F1vX4SKl2JKkyeCKwDuXYpyXQswkYEGBECAAYFAj6tQOQACgkQekr4Tg9J
 H2wfgQCfdauuX5AeyiMqHhcIow/cF/bU8zkAnR8nm6iG4F3cUlPh4vHpI2YM1d7i
Organization: Ion Beam Applications, S.A.
In-Reply-To: <ee384978-4eca-4a49-b1e7-55be7698970f@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QhnE6tPmV3cyNIMvmVDannwe"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PR3PR06MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1cca05-5894-4c6d-6f7d-08decc8c0d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|6049299003|1800799024|11063799006|56012099006|5023799004|4143699003|6133799003|22082099003|4053099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wLGUzsCNshumMEFWwQaTayXxE0nT+c1j0M8JUcPfmCkZrbvUY6z7Wu9jyx9xsksT2tKpvvh2U1uZdwtZHw3Bb0m5dEMpIHFw/o/70cbcURR2o4/fdqUnOb/FBCXVo5Q/gjS/ABoU37uWh1s/7EtUV9nqBhfXBmXFx8KggT6Kc3Zw9M5+iYUEztk85Nn0T5T22a9Duh5sa04RvdUand+zAG40B/aotDQ66d8bOdjZnhFheFpyF6MFggJ4faWSqMFoAQR/b9X7WLKB058YSh45c4FXAlrvPs5JqBm/HxjzZ/7ASoWO7Zbzkc31uufbs9GAuGAJkaooZNP478+Tqxnu5UsGdsXZQiv60R0gUwNLUtFvrRlm3ZsmkqisSyvmUq0TFR1e7+G7Xr4G5POQpHSJftlpKTDYnUjGCTSjtxvWGVybYA5L9xhl/wzh85Y921/xJdXAteS8FxieGtmOb48ShTsRHKmoMKrvnevHnXdDHY4wGZXWJEiHHbGCsLfztfqefdNVhG7h5FJwh8gFAYfX26zsSPZ5/jW9njw6Picvk1pgU8m9tvbxiqUHnO6KSgFwQ9d+vsbl++a32gGYDOZC0UivIi2QAZnGJ764MFbtevdNvtV0HZ5DBw1RUCUgBZ3gs93BjBJSScBfA8v7Bq7/3q57wfYHtCoO4FMuXhO0twUrATXDuBTlV8ykLBWrM1qC
X-Forefront-Antispam-Report:
	CIP:185.185.229.160;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay-lnx.goiba.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(6049299003)(1800799024)(11063799006)(56012099006)(5023799004)(4143699003)(6133799003)(22082099003)(4053099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XNYbd7lTE++0Mn9jGbq8MWXK47kieTiwppoz8twjGa6zOaKNtIaHdy451bsvrlI27x5GTN6suiGezC31w7U+NHgcm2YvLqEpl0dlztsEt+G0YYNlAXRHkRoUc+5+dy88ZQv+TlOpkdre98/7D7yPEsw3E2J8W2FELYH/NmK9gFF0/dmfZgegYm5KyIBEKPov1kpugM75m89huPJG8+wgf/16CJtLiW2Ykonl+hghgtMBYZdZoyA0pnS1dpqCp0v8ENlvcDQXbwD9LwVEUe5RFQIKk9hSYscpuIop9ZvhpQ3lYVN1qhatZcZKwI2W8ajlLxaF5k814injGX8+VSW/rX0TdqWpqL46mRmza9kVt3gKPrSHoIMuILJemMulyXKbb7fzhDRt0/23FR237KVJEP1zjV3jnveFaFTweNxCgJNlsaVoZXY1gcsKq8iCu8+B
X-OriginatorOrg: iba-group.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:18:22.3739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1cca05-5894-4c6d-6f7d-08decc8c0d59
X-MS-Exchange-CrossTenant-Id: c2a8770b-ad33-4215-bbe7-ec4185e9587b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c2a8770b-ad33-4215-bbe7-ec4185e9587b;Ip=[185.185.229.160];Helo=[mailrelay-lnx.goiba.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6812
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[iba-group.com,reject];
	R_DKIM_ALLOW(-0.20)[iba-group.com:s=selector1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:Ludovic.Calmant@iba-group.com,m:Fabian.Noel@iba-group.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[pan@iba-group.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iba-group.com:dkim,iba-group.com:email,iba-group.com:mid,iba-group.com:from_mime];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[iba-group.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pan@iba-group.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A805669B6A0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QhnE6tPmV3cyNIMvmVDannwe
Content-Type: multipart/mixed; boundary="------------0JYujaSSf2ZSi81qlGHsgoW9";
 protected-headers="v1"
From: Philippe Andersson <pan@iba-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
 =?UTF-8?Q?Fabian_No=C3=ABl?= <Fabian.Noel@iba-group.com>
Message-ID: <886bbdd7-3a0a-4f61-b2b2-2b8c37d8e71d@iba-group.com>
Subject: Re: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches
 (too small inter-packet gap)
References: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
 <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
 <3b073409-9096-4467-9baf-11196a70c014@iba-group.com>
 <ee384978-4eca-4a49-b1e7-55be7698970f@lunn.ch>
In-Reply-To: <ee384978-4eca-4a49-b1e7-55be7698970f@lunn.ch>

--------------0JYujaSSf2ZSi81qlGHsgoW9
Content-Type: multipart/mixed; boundary="------------0RjlSy8b9IWOTzAp2eeFaVlG"

--------------0RjlSy8b9IWOTzAp2eeFaVlG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcvMDYvMjAyNiAxODowNywgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gQ2FuIHlvdSBy
dW4gYSBnaXQgYmlzZWN0IGZyb20gdGhlIGxhc3QNCj4+PiBrbm93biBnb29kIGtlcm5lbCB2
ZXJzaW9uIHRvIHRoZSBmaXJzdCBrbm93biBiYWQgdmVyc2lvbj8NCj4+IE5vdCByZWFsbHks
IGFzIHRoZXJlIGlzIG5vICJrbm93biBnb29kIGtlcm5lbCIuIEFsbCBrZXJuZWxzIGFyZSBn
b29kIG9uZXMsDQo+PiBhcyBsb25nIGFzIG9sZGVyIFByb0N1cnZlIHN3aXRjaGVzIGFyZSB1
c2VkIChlLmcuIEhQRS9BcnViYSBQcm9DdXJ2ZSA1NDA2Ug0KPj4gb3IgSFBFL0FydWJhIFBy
b0N1cnZlIDI5MzBNLTQ4Ry1Qb0UrKS4gVGhlIHByb2JsZW0gb25seSBzaG93cyB3aGVuIEFP
Uy1DWA0KPj4gc3dpdGNoZXMgYXJlIHVzZWQsIGFuZCB3ZSBvbmx5IHN0YXJ0ZWQgZGVwbG95
aW5nIHRob3NlIGluIHByb2R1Y3Rpb24gYQ0KPj4gY291cGxlIG9mIG1vbnRocyBhZ28uDQo+
IA0KPiBJIHdhcyBob3BpbmcgeW91IGNvdWxkIG5hcnJvdyBpdCBkb3duIHRvIG9uZSBwYXRj
aCB3aGljaCBjYXVzZWQgdGhlDQo+IGlzc3VlLiBCdXQgaWYgaXQgbmV2ZXIgd29ya2VkLi4u
DQpTb3JyeSB0byBkaXNhcHBvaW50IDstKQ0KDQo+IFRoZW4gaSByZWFsbHkgdGhpbmsgeW91
IG5lZWQgdG8gYmUgdGFsa2luZyB0byBib3RoIHZlbmRvcnMgYW5kIHRyeSB0bw0KPiBnZXQg
dGhlbSB0byB3b3JrIHRvZ2V0aGVyIHRvIGlkZW50aWZ5IHRoZSBwcm9ibGVtLg0KVGhpcyBp
cyBwcmVjaXNlbHkgd2h5IEkgY29udGFjdGVkIHRoaXMgbWFpbGluZyBsaXN0LiBNeSB1bmRl
cnN0YW5kaW5nIA0Kd2FzIHRoYXQgdGhpcyB3YXMgdGhlIHByb3BlciB3YXkgdG8gcmVwb3J0
IGEgcG90ZW50aWFsIGJ1ZyBpbiB0aGUgDQonZTEwMDBlJyBkcml2ZXIgbm93IHRoYXQgaXQg
aGFzIGJlZW4gaW5jb3Jwb3JhdGVkIGluIHRoZSBMaW51eCBrZXJuZWwgDQp0cmVlLCBhcyBw
ZXIgdGhlIG1haW50YWluZXJzIGxpc3RlZCBpbiB0aGUgY29kZS4gQnV0IGlmIHlvdSBrbm93
IA0Kb3RoZXJ3aXNlLCBwbGVhc2UgdGVsbCBtZS4NCg0KPiBNYXliZSBzZW5kIGEgTklDIHRv
DQo+IHRoZSBzd2l0Y2ggdmVuZG9yLCBzbyB0aGV5IGhhdmUgYWxsIHRoZSBoYXJkd2FyZSwg
ZXRjLg0KVGhpcyBpcyBhbHJlYWR5IG9uZ29pbmcuDQoNClBoLiBBLg0KDQotLSANCg0KKlBo
aWxpcHBlIEFuZGVyc3NvbioNClVuaXggU3lzdGVtIEFkbWluaXN0cmF0b3INCklCQSBQYXJ0
aWNsZSBUaGVyYXB5IHwNClRlbDogKzMyLTEwLTQ3NS45ODMNCkZheDogKzMyLTEwLTQ4Ny43
MDcNCmVNYWlsOiBwYW5AaWJhLWdyb3VwLmNvbQ0KPGh0dHA6Ly93d3cuaWJhLXdvcmxkd2lk
ZS5jb20+DQoNCg0K
--------------0RjlSy8b9IWOTzAp2eeFaVlG
Content-Type: application/pgp-keys; name="OpenPGP_0x7A4AF84E0F491F6C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7A4AF84E0F491F6C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDiBD6tQKQRBADCF1oXR0PqOezJO/Oh+15ZQZAEQ+R7blg0Y6ExRnCEQopb81Y1
MUMFAAFP3FNIZdlp1909wW9bbJklb1O8vwZ2VuvDyn9Min4NM+f6BRIKnGiMpJQW
7UO+Zgk9gGzRsTxm/SN+aALQnjhXo1GZigDB2sglxtr2GTQcQwsDrQosjwCgpZ8f
5oBoqQcICnU5hEoaL+s6qj0EAKeX3/Ir7950jxN6uyCtdIkDK5g8l2GKj7siga0l
GhP43QLqR7k0SJPvxCyqSaozTPXsV2QdUvHXdcifl7Uo3kbd746HF4zYlGKAAx+s
pZ/e8Fl6RW1YMGsGA+Li9010QEZZyl7hlVywiYaTU8y4mKxb8NUzJgPPP4GilGiU
sj/4A/0YB2Ny1KjOEnqe8WFdbACURMbIKBg/I/wYfeiD7kfilkuVr7WRbwc9YeT7
fzxbJN4ALdsBIvbie6pfLFwFbqTgXdVUHgUmcd/K0o5FyzFCrPOEdf33HqxXU+df
NeuF9iPspo2+gpoOug9WSS0iyloEg1lY+hULTJnJlT6a278cN80vUGhpbGlwcGUg
QW5kZXJzc29uIChVbml4IFN5c2FkbWluKSA8cGFuQGliYS5iZT7CYgQwEQIAIgUC
S2whfhsdIFVzZSBpYmEtZ3JvdXAuY29tIGluc3RlYWQACgkQekr4Tg9JH2zeggCf
XuGUS457brqIhoIY+HL/lnLHGXMAnjBRfUaO0TkJ6FwwAJjVLkzk1zJcwlkEExEC
ABkECwcDAgMVAgMDFgIBAh4BAheABQJLbCDQAAoJEHpK+E4PSR9s82oAoJ7XGE5M
rEWmbjRtgKTp5bNkO6L5AKCOcTD5GCywwrg5zdtLWIf6pRUlccJZBBMRAgAZBQI+
rUClBAsHAwIDFQIDAxYCAQIeAQIXgAAKCRB6SvhOD0kfbLeeAJwOyibVJNq7O+Yg
CSshaWyP/N7zHQCeLtlXr2Ig+UHq9858TB8tPuUmMB/CWQQTEQIAGQUCPq1ApQQL
BwMCAxUCAwMWAgECHgECF4AACgkQekr4Tg9JH2y3ngCgkrsM1dzXJ07DeRrDPWYu
0gKxMIoAnAxZ48tyh1KyI737kz9+cGUIuo9NzTRQaGlsaXBwZSBBbmRlcnNzb24g
KFByaXZhdGUgSUQpIDxwaGlsaXBhQHRpc2NhbGkuYmU+wkkEMBECAAkFAktsIUgC
HSAACgkQekr4Tg9JH2wH7gCeLxyt54ImIv2FdrbVpECYTTg14i4AoIbht8+aBE7C
E16xjaD8+lwHN4QNwlwEExECABwFAj66YZ0CGwMECwcDAgMVAgMDFgIBAh4BAheA
AAoJEHpK+E4PSR9sJmkAnjkTDX055kbiznA64uwdTeZPFN8fAKCij+Yys/fGcMi4
PeJPvTM7FSq32s06UGhpbGlwcGUgQW5kZXJzc29uIChJQkEgVW5peCBTeXNhZG1p
bikgPHBhbkBpYmEtZ3JvdXAuY29tPsJjBBMRAgAjAhsDBgsJCAcDAgQVAggDBBYC
AwECHgECF4AFAktsINACGQEACgkQekr4Tg9JH2zTrgCgn8is5vSqE/TUTOppZXeK
ssLSjtUAnjf84a1oqOg+DFe3nOU0iiroE1f5wmAEExECACAFAktsH/QCGwMGCwkI
BwMCBBUCCAMEFgIDAQIeAQIXgAAKCRB6SvhOD0kfbNY/AJ4+BtPysDzHwAg1ub2m
yM6WwLHbLwCfZ0TofLNXnTTwVn4p2vbbcvGjRWnNPlBoaWxpcHBlIEFuZGVyc3Nv
biAoUHJpdmF0ZSBJRCkgPHBoaWxpcHBlLmFuZGVyc3NvbkBza3luZXQuYmU+wmAE
ExECACAFAktsIJICGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRB6SvhOD0kf
bNhwAKCbXq4YuwXEx2+QFGmxMzp3W9TGoQCgkvB2QmBr72P1XB1G/b9b2Is0vArN
NFBoaWxpcHBlIEFuZGVyc3NvbiAoUHJpdmF0ZSBJRCkgPHBoaWxpcGFAc2Nhcmxl
dC5iZT7CYAQTEQIAIAUCS2wguwIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJ
EHpK+E4PSR9sGgAAnjYrl9Vgxv5rov87xUjs8BK7yXzHAJ4rSN4b+8pRXfGuKa4t
TVsZVORFbc7BTQQ+rUDkEAgA46/7hD2jjc6pvtVJjJR+sEd9SHvu6E1sqwC24z9I
M7h3DPFp4rRVMaNl5wLxH1qjt8rwE7rVBCSZGL3qDC2iiSA76s6TN5wjbu6TtKge
mf8lmz8xYPLmyWnMJI5FKHyjVpsrtPuLS0tCnmMLr1daPhIV7J4TU5QrhiLnzjEz
VBPOVnxstimJE1sPp6KlvQbqzDX5V9Yzdz6wPKkTE51EUoMXe6FAQIOMxvPY+ikN
+2P3SgKUpZvtcCbTPihy+N+IkFhy/YZ0bJShR26fkQMl1f9/KaA3IvTcvP/sveIf
qOkxHMPNBWE+a5rLCfKqdmTUKD75bYY8j200z8/qDN3OBwADBQgAw1bFwbFYAHxt
fyZzevw4uWB1KJhVVetsbbmOit4NrYmXyq9WTv8h43SkWUVt328Cc8FZPsUtV68Q
g4lViUu5gaD3LvguRAU/WyukA2t3gMVRgxJ4vKeTyvsoCbM/kEkNitx4Xn7I55Bc
fX3q4B8jqmtpYXYeKEwlK0PhrwfLGU8iUlpQrfx7uU4KG0Qlf9/Tyi0y6eqhkeMj
sbCyCvdFoR8AGBtA44RiShoFNpVwUZ0uOrujg21RK43quhQxm0oHsenCWgvFU7QK
GtpjtfcVa8SzSQdA4Ucf45jhOk685rSAzbImJWbKGrP+s3+xdb1+EipdiSpMngis
A7l2Kcl0LMJGBBgRAgAGBQI+rUDkAAoJEHpK+E4PSR9sH4EAn3Wrrl+QHsojKh4X
CKMP3Bf21PM5AJ0fJ5uohuBd3FJT4eLx6SNmDNXe4g=3D=3D
=3DM0xV
-----END PGP PUBLIC KEY BLOCK-----

--------------0RjlSy8b9IWOTzAp2eeFaVlG--

--------------0JYujaSSf2ZSi81qlGHsgoW9--

--------------QhnE6tPmV3cyNIMvmVDannwe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRNaVrpkigRgJ/qxSZ6SvhOD0kfbAUCajLIzQUDAAAAAAAKCRB6SvhOD0kfbH0L
AJ422CUOyZWX7lxTBXfbXhNNAJNPLACghYlXRIlJoy21XMDxzQl/JduEwho=
=3gsK
-----END PGP SIGNATURE-----

--------------QhnE6tPmV3cyNIMvmVDannwe--

