Return-Path: <netdev+bounces-300202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LHbYAqvBMmqM5AUAu9opvQ
	(envelope-from <netdev+bounces-300202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76C69B1FD
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iba-group.com header.s=selector1 header.b=YXO9d9sc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300202-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iba-group.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BED9313A6D8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFDC4A33EA;
	Wed, 17 Jun 2026 15:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021129.outbound.protection.outlook.com [40.107.130.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29C49553D
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:41:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710914; cv=fail; b=AcYG3Q1EUo2w7NfaselDWk+ivIiFtEvkhDa5gK8OswSUjUgGEAbUZqyrE1VrAIUtl3tWOJFmnh/JzakNbFlIF7eJ0xqwvBXXh6yWPcCwSDB0pm1JnUQR2wBaTbxmtUcNHqBL/kj1epNgfvRazlRltVyZC9BdopxHQcCszlUlGiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710914; c=relaxed/simple;
	bh=ExSO9fZB4niBkC9gwxRWh6spFPNwT6VEB7GmJHI+33s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtP0YHfEMiJ2R6KGxJzH7PcjB8FJgHEImx0LJBnIuubUM7rOkGygHUprXa/cEfAgv5x2k8b/CJiHi1nUKACdN3URPoyuC960gTZjacYZQqOTEzSDe0e5GkAjR+HuLgHw0dIWlzAAdqXYN1PuP23YfASHmjwI2i+lrf3U8F6X/cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iba-group.com; spf=pass smtp.mailfrom=iba-group.com; dkim=pass (1024-bit key) header.d=iba-group.com header.i=@iba-group.com header.b=YXO9d9sc; arc=fail smtp.client-ip=40.107.130.129
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjJFK3Njah1xrJbxqjyycMJ8fLL15NU7Yvs0tiu/hyUBmg5SV3++E6npDhXNBqF8tBWkcb1oNPWcZkaSfzFtv+evy6lBY013qGG9dQAis8hcwj0FtS38emhQO9hc6mARlUEzfWB+tq/RMLYf9HSRWn7JrQLIZypUU/4OZ/g0gvOhnF9bLQtGpKO8aiNwlivPSNEgtlwoK/mBGHkzRta5lbaKt5bPJnyhVc1LKabdoEcpfmQIyvWSIAPKTOdOCVE93dnnKSOjOIRBHC2fUwfoIMtgBfVcF/KJhIR2ZPbxdRi2edgUG9S9d4DWX7UAG4UPxH0O8G5f/30R6WXX04tcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExSO9fZB4niBkC9gwxRWh6spFPNwT6VEB7GmJHI+33s=;
 b=eX2L3X4Tk2bA2lnvJ26u2sdDqPvdDpuIKeYsCEOiatm4zwMx0Jl1quwwqAi+MzMxsRwYQmS1fER9S3fvGYshz+bh0oCmwdk9rkw+rzY74xMqHfK4bKl6KRl/gGKGRPFw+ywleT5IU9eD03AKd/K/LqCLdoTQM9lCoi7Xxunlf7Gr+NFsYMjLvEUB8DA5Sr8yPj0CL4Fyor8YgnhMPuPldqNRg7HELG9M0frzrw2ikpUwPlNcsgPH/wb3EeqSBqoQ+MmhkeTkn1GBKz2jzJrSRlzKpccPxpUKvy10kYHQ6EbBZVYZ9DkeFO72vrmoR0gJvRhDzULKOxyWWtN+Ui4Aww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 185.185.229.160) smtp.rcpttodomain=iba-group.com smtp.mailfrom=iba-group.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=iba-group.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iba-group.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExSO9fZB4niBkC9gwxRWh6spFPNwT6VEB7GmJHI+33s=;
 b=YXO9d9scsu78lg1zEoU991dv355RMtVWX4my/qkDwPeII18rdsVF4z+zfCyWekW7Vlu2f7wX/amdINGI166dq7d6T/YU7nZ5FSdwe98VakV34jAZCH90eAWD2qSNwd105fqVHWJJjrUEwJCn10CZlnRcpMykcwrOAlK5b2zznV8=
Received: from DU7P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::9) by
 GVXPR06MB9678.eurprd06.prod.outlook.com (2603:10a6:150:1e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 15:41:32 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::4e) by DU7P190CA0015.outlook.office365.com
 (2603:10a6:10:550::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 15:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 185.185.229.160)
 smtp.mailfrom=iba-group.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=iba-group.com;
Received-SPF: Pass (protection.outlook.com: domain of iba-group.com designates
 185.185.229.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.185.229.160; helo=mailrelay-lnx.goiba.net; pr=C
Received: from mailrelay-lnx.goiba.net (185.185.229.160) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 15:41:32 +0000
Received: from dc1v2pmailnx2.goiba.net (localhost.localdomain [127.0.0.1])
	by mailrelay-lnx.goiba.net (Proxmox) with ESMTP id 085A7350FB7;
	Wed, 17 Jun 2026 17:41:32 +0200 (CEST)
Received: from cernunnos.lln.iba (unknown [172.30.1.178])
	by mailrelay-lnx.goiba.net (Proxmox) with ESMTP id E5C3D34CAEA;
	Wed, 17 Jun 2026 17:41:31 +0200 (CEST)
Received: from localhost (unknown [10.100.28.183])
	by cernunnos.lln.iba (Postfix) with ESMTP id DDC491124;
	Wed, 17 Jun 2026 17:41:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id CD2EE60449;
	Wed, 17 Jun 2026 17:41:31 +0200 (CEST)
Message-ID: <3b073409-9096-4467-9baf-11196a70c014@iba-group.com>
Date: Wed, 17 Jun 2026 17:41:31 +0200
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
In-Reply-To: <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8G3EXdfS5bAy6qps0UNWJh8f"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|GVXPR06MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: c2591320-9cc1-40e4-e7be-08decc86e807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|6049299003|376014|3023799007|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	ebJ8MK9g0oarpeWdgOFnRRKVo2HQgxgJ4LdrgAZ2e6j5AygD8uPRRzcY/e+yseKl/LoUym1x7yYS0lHK7GSDUXg88PByRn/E7Drp/VyYOrZgBqOl65eF8A8zZOWCW6fNK8+Mqjx6e73eCzlKk/2rIVyuxh5Kro+0jokWbDu1SiyW73zoHUyo1XVxuQ3w1SCn/z9fyAg1Kojt0vEabeBsirSSotLH/yquHN7xrreVtB4d059rL1nKK4jBGOrgRpHctmcFl0gXIS3DxSjCpqAi4J3Z9Yl6qXAhg9ub94M6sDwze4v1VUUQ1OCkWtaBhi/XG97xz9WsLY9194YVtHp9knGW9hz9m06Fqya0l3GpJFDjMM+d+efQ3lCd+DMxHUJ9nxNKvQmiZUcBNJDvq2NGKseb6iYvc35q7OAZtf2bwhmjTW3WktzqaUBsXPCaoKh1NzB7IvVkkkhOTNRptZ2EJ5QS5mX3XASYAAJQJTIW+kWWDm1pz6ngR+UURujGFVHuH3Gjw+y2V30KNMUkiONtQNfUxAvPGR8uGCXYBfy96ap/XVN+e5z9+Sc6yHIvsns7qWt0rIlfu+8RxjXBTH5zYZZHVwi8AvrP+fIQHAMj3wsTHhnNyQUjUBvx92xew1wcb3TPhC6FyUKXKaYhaVGEiwQ5M15hEXcXw/9g+VHa4kAGB3anhSgXDL3h0rsBMASX
X-Forefront-Antispam-Report:
	CIP:185.185.229.160;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay-lnx.goiba.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(6049299003)(376014)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(4053099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OvcNwgq+4BhXn1jDuHoIi2SRoPNFrWcNWcSNJ8gmrfWcRftXgQyvourhhTlvpR8gWc5LxIKgZthHcfePs+TGqQo16wCxD84o/zrYqNmGt1UdE/mRieeA+6EpAHP53Iig42dkxm64CD97pkDMexU18GIMUMev2I9t4r9UUhKe4vbJG3r6kMk5w4VMkvnrUVm4kW9zqpgqVU1zXopleTxH/uO1+9SXJ7SNr6GmUrIg+3M8iGM5v6Qu4vz5FpiPEp/d1i45c/TCOF3T/9DW9fPgATOmbraMLlQ6XpPkyhCmMighdvpytE+M5ZXaLr+r41uqvMwpKpDq0TkjG7rAJQN4sKG9Ae49eWIdBBUM7HGWUoVs6My0RF8XaBHndh8vNHZM5H80I4Shn46GQcvur51SbCkhDQ2trfyIHEdLRKJoMjowL4hCdh8DsfowHaBOUr4S
X-OriginatorOrg: iba-group.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 15:41:32.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2591320-9cc1-40e4-e7be-08decc86e807
X-MS-Exchange-CrossTenant-Id: c2a8770b-ad33-4215-bbe7-ec4185e9587b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c2a8770b-ad33-4215-bbe7-ec4185e9587b;Ip=[185.185.229.160];Helo=[mailrelay-lnx.goiba.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9678
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[iba-group.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[iba-group.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:Ludovic.Calmant@iba-group.com,m:Fabian.Noel@iba-group.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pan@iba-group.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iba-group.com:dkim,iba-group.com:email,iba-group.com:mid,iba-group.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iba-worldwide.com:url];
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
X-Rspamd-Queue-Id: 5D76C69B1FD

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8G3EXdfS5bAy6qps0UNWJh8f
Content-Type: multipart/mixed; boundary="------------HYSOhExcZzXKXSFl0Wp0i6MF";
 protected-headers="v1"
From: Philippe Andersson <pan@iba-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
 =?UTF-8?Q?Fabian_No=C3=ABl?= <Fabian.Noel@iba-group.com>
Message-ID: <3b073409-9096-4467-9baf-11196a70c014@iba-group.com>
Subject: Re: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches
 (too small inter-packet gap)
References: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
 <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
In-Reply-To: <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>

--------------HYSOhExcZzXKXSFl0Wp0i6MF
Content-Type: multipart/mixed; boundary="------------tJRR5Au2nfyEFBz9q0SsfcIo"

--------------tJRR5Au2nfyEFBz9q0SsfcIo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYvMDYvMjAyNiAyMTozNCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBBIHN1cHBvcnQg
dGlja2V0IGhhcyBhbHJlYWR5IGJlZW4gb3BlbmVkIHdpdGggQXJ1YmEsIGJ1dCBpdCdzIHVu
Y2xlYXIgYXQNCj4+IHRoaXMgc3RhZ2UgdGhhdCB0aGUgcHJvYmxlbSBpcyBvbiB0aGVpciBz
aWRlLg0KPiANCj4gSG93IGVhc3kgaXMgaXQgdG8gcmVwcm9kdWNlPw0KUHJvdmlkZWQgeW91
IGhhdmUgdGhlIHJlcXVpcmVkIGhhcmR3YXJlIChQQyB3aXRoIE5JQyB1c2luZyB0aGUgJ2Ux
MDAwZScgDQpkcml2ZXIgYW5kIEFydWJhIEFPUy1DWCBzd2l0Y2ggc3VjaCBhcyBIUEUvQXJ1
YmEgQ1ggNTQyMCBvciBIUEUvQXJ1YmEgQ1ggDQo2MjAwTSAtLSBwZXJoYXBzIG90aGVycywg
d2Ugb25seSB0ZXN0ZWQgd2l0aCB0aG9zZSBvbmVzKSwgcmVwcm9kdWNpbmcgDQp0aGUgaXNz
dWUgaXMgZWFzeTogcnVubmluZyAnaXBlcmYzJyBmb3IgYSBmZXcgbWludXRlcyAodGhlIFBD
IHdpdGggDQonZTEwMDBlJyBwbGF5cyB0aGUgcm9sZSBvZiBpcGVyZiBzZXJ2ZXIpLiBZb3Ug
d2lsbCBnZXQgYSBjbHVzdGVyIG9mIA0KcmV0cmFuc21pdHMgYXQgdGhlIHN0YXJ0IG9mIHRo
ZSB0ZXN0LCBhbmQgeW91IG1heSBnZXQgZnVydGhlciBjbHVzdGVycyANCmF0IHJhbmRvbSBp
bnRlcnZhbHMuDQoNCkhlcmUgaXMgYW4gJ2lwZXJmMycgb3V0cHV0IHRoYXQgc2hvd3MgdGhl
IHByb2JsZW0gYWZ0ZXIgb25seSAxMCBzZWNzLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPGN1dD4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDb25uZWN0aW5nIHRvIGhv
c3QgMTAuMS4xLjIxLCBwb3J0IDUyMDENClsgIDVdIGxvY2FsIDEwLjEuMS42MSBwb3J0IDU1
MDk2IGNvbm5lY3RlZCB0byAxMC4xLjEuMjEgcG9ydCA1MjAxDQpbIElEXSBJbnRlcnZhbCAg
ICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUgICAgICAgICBSZXRyICBDd25kDQpbICA1
XSAgIDAuMDAtMS4wMCAgIHNlYyAgIDExMCBNQnl0ZXMgICA5MjMgTWJpdHMvc2VjICAgNzAg
ICAxLjQ5IE1CeXRlcyANCg0KWyAgNV0gICAxLjAwLTIuMDAgICBzZWMgICAxMDYgTUJ5dGVz
ICAgODkxIE1iaXRzL3NlYyAgICAwICAgMS42MyBNQnl0ZXMgDQoNClsgIDVdICAgMi4wMC0z
LjAwICAgc2VjICAgMTA2IE1CeXRlcyAgIDg5MSBNYml0cy9zZWMgICAgMCAgIDEuNzQgTUJ5
dGVzIA0KDQpbICA1XSAgIDMuMDAtNC4wMCAgIHNlYyAgIDEwOCBNQnl0ZXMgICA5MDIgTWJp
dHMvc2VjICAgIDAgICAxLjgzIE1CeXRlcyANCg0KWyAgNV0gICA0LjAwLTUuMDAgICBzZWMg
ICAxMDYgTUJ5dGVzICAgODkxIE1iaXRzL3NlYyAgICAzICAgMS4zMiBNQnl0ZXMgDQoNClsg
IDVdICAgNS4wMC02LjAwICAgc2VjICAgMTA2IE1CeXRlcyAgIDg5MSBNYml0cy9zZWMgICAg
MCAgIDEuNDIgTUJ5dGVzIA0KDQpbICA1XSAgIDYuMDAtNy4wMCAgIHNlYyAgIDEwOCBNQnl0
ZXMgICA5MDIgTWJpdHMvc2VjICAgIDAgICAxLjQ5IE1CeXRlcyANCg0KWyAgNV0gICA3LjAw
LTguMDAgICBzZWMgICAxMDYgTUJ5dGVzICAgODkxIE1iaXRzL3NlYyAgICAwICAgMS41NCBN
Qnl0ZXMgDQoNClsgIDVdICAgOC4wMC05LjAwICAgc2VjICAgMTA2IE1CeXRlcyAgIDg5MSBN
Yml0cy9zZWMgICAgMCAgIDEuNTcgTUJ5dGVzIA0KDQpbICA1XSAgIDkuMDAtMTAuMDAgIHNl
YyAgIDEwOCBNQnl0ZXMgICA5MDIgTWJpdHMvc2VjICAgIDAgICAxLjU5IE1CeXRlcyANCg0K
LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLQ0KWyBJ
RF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAgICAgICAgUmV0
cg0KWyAgNV0gICAwLjAwLTEwLjAwICBzZWMgIDEuMDQgR0J5dGVzICAgODk4IE1iaXRzL3Nl
YyAgIDczICAgICAgICAgICAgIHNlbmRlcg0KWyAgNV0gICAwLjAwLTEwLjAyICBzZWMgIDEu
MDQgR0J5dGVzICAgODk0IE1iaXRzL3NlYyANCnJlY2VpdmVyDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPGN1dD4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCkJ1dCB5b3Ug
bmVlZCB0byBkbyB0aGlzIGluIHBhcmFsbGVsIHdpdGggImJhY2tncm91bmQgbmV0d29yayB0
cmFmZmljIiBvbiANCnRoZSBQQyAoc3VjaCBhcyBORlMsIGZvciBpbnN0YW5jZSkuIFdlJ3Zl
IG5vdCBiZWVuIGFibGUgeWV0IHRvIA0KY2hhcmFjdGVyaXNlIHRoZSBtaW5pbXVtIGFtb3Vu
dCBvZiB0cmFmZmljIG5lY2Vzc2FyeSBmb3IgdGhlIHByb2JsZW0gdG8gDQptYW5pZmVzdCBp
dHNlbGYgYnV0IHdlJ2xsIHRyeSB0byBkbyBzby4NCg0KPiBDYW4geW91IHJ1biBhIGdpdCBi
aXNlY3QgZnJvbSB0aGUgbGFzdA0KPiBrbm93biBnb29kIGtlcm5lbCB2ZXJzaW9uIHRvIHRo
ZSBmaXJzdCBrbm93biBiYWQgdmVyc2lvbj8NCk5vdCByZWFsbHksIGFzIHRoZXJlIGlzIG5v
ICJrbm93biBnb29kIGtlcm5lbCIuIEFsbCBrZXJuZWxzIGFyZSBnb29kIA0Kb25lcywgYXMg
bG9uZyBhcyBvbGRlciBQcm9DdXJ2ZSBzd2l0Y2hlcyBhcmUgdXNlZCAoZS5nLiBIUEUvQXJ1
YmEgDQpQcm9DdXJ2ZSA1NDA2UiBvciBIUEUvQXJ1YmEgUHJvQ3VydmUgMjkzME0tNDhHLVBv
RSspLiBUaGUgcHJvYmxlbSBvbmx5IA0Kc2hvd3Mgd2hlbiBBT1MtQ1ggc3dpdGNoZXMgYXJl
IHVzZWQsIGFuZCB3ZSBvbmx5IHN0YXJ0ZWQgZGVwbG95aW5nIHRob3NlIA0KaW4gcHJvZHVj
dGlvbiBhIGNvdXBsZSBvZiBtb250aHMgYWdvLg0KDQpXaGF0IEkgY2FuIHRlbGwgeW91IGlz
IHRoYXQgdGhlIHByb2JsZW0gaXMgc3RpbGwgcHJlc2VudCBpbiANCjYuMTIuOTArZGViMTMu
MS1hbWQ2NC4gVGhpcyBpcyB0aGUgbW9zdCByZWNlbnQga2VybmVsIHdlIHRlc3RlZC4NCg0K
SFRIDQoNClBoLiBBLg0KDQotLSANCg0KKlBoaWxpcHBlIEFuZGVyc3NvbioNClVuaXggU3lz
dGVtIEFkbWluaXN0cmF0b3INCklCQSBQYXJ0aWNsZSBUaGVyYXB5IHwNClRlbDogKzMyLTEw
LTQ3NS45ODMNCkZheDogKzMyLTEwLTQ4Ny43MDcNCmVNYWlsOiBwYW5AaWJhLWdyb3VwLmNv
bQ0KPGh0dHA6Ly93d3cuaWJhLXdvcmxkd2lkZS5jb20+DQoNCg0K
--------------tJRR5Au2nfyEFBz9q0SsfcIo
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

--------------tJRR5Au2nfyEFBz9q0SsfcIo--

--------------HYSOhExcZzXKXSFl0Wp0i6MF--

--------------8G3EXdfS5bAy6qps0UNWJh8f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRNaVrpkigRgJ/qxSZ6SvhOD0kfbAUCajLAKwUDAAAAAAAKCRB6SvhOD0kfbLlr
AJ9yIx+Xu72bokN6tTxSz2THZ0UmOgCghcDbZUIM5NrHdvuphXQ20cOb7jI=
=FO6Z
-----END PGP SIGNATURE-----

--------------8G3EXdfS5bAy6qps0UNWJh8f--

