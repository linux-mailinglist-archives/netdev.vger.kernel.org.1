Return-Path: <netdev+bounces-299844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e5WZLqJKMWqrgAUAu9opvQ
	(envelope-from <netdev+bounces-299844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:07:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9468FC04
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iba-group.com header.s=selector1 header.b=V1GIxmr0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299844-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iba-group.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D00EB301E987
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5753655CA;
	Tue, 16 Jun 2026 13:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021124.outbound.protection.outlook.com [52.101.70.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFA2E7162
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:07:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615263; cv=fail; b=NjGLGQqBOZ31DQy6J0oS/TM3Iny17rFiekWL+c3FHmKNgEZZPpM7/11P5ncSmLAty0mM5dPrMZ+BNsqJxi1MB/OJBc1qDOdi3GP9BUR0PG1TsnHbbvyK+w0dnkpf4dSxsP6OveX68ODxj7kA/TygJaj+klCCwENixSuImVFSzG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615263; c=relaxed/simple;
	bh=PnJrg5BciEkgGcbzqhCnQ+2szj+I8Pzyc04pM63pyEY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Sb5cLof2n+9B/W5WZeEuXZl6ktfEmDzAX9uYCNsL4W7LgpNz0+TbvbIFW87HGXkHH2U/9GrG3FHCd9VnaoXwRkL16AjBscAt4Lnl9fqqhoWxDQaha35S8xD/x+vyGzOhupUe6GOHWYkBcjoRgB44JaeJsO4Pe525u3SauomzjMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iba-group.com; spf=pass smtp.mailfrom=iba-group.com; dkim=pass (1024-bit key) header.d=iba-group.com header.i=@iba-group.com header.b=V1GIxmr0; arc=fail smtp.client-ip=52.101.70.124
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owKF+cBMvlMGKnJkxSOGFoG4dNsWq6evg+Rmw7NpK26uxHIkbQJyIHZCwDYU4g2FgaHg1YAWXJ9v43VSm/v+g6BiqQB14M+LF3K4H5IKQKC7vO9zAxQNOi2N+JducHfSVHFAJpshyV49TN41+QGuiPPi4SLbJ35r8AZURWS2WTO80DjrV81LjBVmDO+696SEknZgk+xcaYNRqh/50R4Ru9mZtGBtNyjUHCwT5/ysW4FKhEYPVjOsPAgb5xbvb6VptQHiKDDUFsuVOL2cntTRRpgR1RdxRXi8ZWminMIDzgOBR6meyXgq3rCZF/A3U3HhKJzI2KSzz3qSm/GGJTBPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnJrg5BciEkgGcbzqhCnQ+2szj+I8Pzyc04pM63pyEY=;
 b=sBZFf+lNMny/2jYnOAghAi7iU5kss2oT70SWq3PRbR8nOQRcjOQX/A54y24vN+LwUSZNTDjidBJurR9cI0TuhoLqexXgxsFrn8pCu57ttxjJIp2kjsW3tdCHou/VS6PTnnrkE0nM5I9OfCvq4vLxwD0EP8ldXZpNCcOVFltKp0r5lN4ud05KeETrs8ANeXeHaL6Imz8RgW8U7E8OaBqCfV5haMfo4IaTuwygtTf+3u1rFagD/zAfCfGaM6hyw7yUoMH6VxTWN/YRyz3Jue8h4ktoBUoG6I8UGtlXO3BpL8lMXfNa4o6YUDvqC6ONoVO9CudtWHMERaV5F/jzrSC5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 185.185.229.160) smtp.rcpttodomain=iba-group.com smtp.mailfrom=iba-group.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=iba-group.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iba-group.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnJrg5BciEkgGcbzqhCnQ+2szj+I8Pzyc04pM63pyEY=;
 b=V1GIxmr0dOXn4rIrp/kRyG6L8kYsRjaZcz86ESXP1EUXAFP1XKoBsCa0RgtFvQg6MK06Swe0P41OFw/DTCh0vGPBuIXL/3pqoetL8bD6Sph51uVLJ92AGxS2EL12YV704ZKG4y16TTRgPmSSrphhG5ZhjNATMrisa150TSS+wfs=
Received: from AM9P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::19)
 by GVXPR06MB9439.eurprd06.prod.outlook.com (2603:10a6:150:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:07:35 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::2) by AM9P192CA0014.outlook.office365.com
 (2603:10a6:20b:21d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 13:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 185.185.229.160)
 smtp.mailfrom=iba-group.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=iba-group.com;
Received-SPF: Pass (protection.outlook.com: domain of iba-group.com designates
 185.185.229.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=185.185.229.160; helo=mailrelay-lnx.goiba.net; pr=C
Received: from mailrelay-lnx.goiba.net (185.185.229.160) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 13:07:35 +0000
Received: from dc1v2pmailnx2.goiba.net (localhost.localdomain [127.0.0.1])
	by mailrelay-lnx.goiba.net (Proxmox) with ESMTP id E53EC34A2AF;
	Tue, 16 Jun 2026 15:07:34 +0200 (CEST)
Received: from cernunnos.lln.iba (unknown [172.30.1.178])
	by mailrelay-lnx.goiba.net (Proxmox) with ESMTP id CF408347807;
	Tue, 16 Jun 2026 15:07:34 +0200 (CEST)
Received: from localhost (unknown [10.100.216.112])
	by cernunnos.lln.iba (Postfix) with ESMTP id BE1DA89B;
	Tue, 16 Jun 2026 15:07:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A0D55603AF;
	Tue, 16 Jun 2026 15:07:34 +0200 (CEST)
Message-ID: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
Date: Tue, 16 Jun 2026 15:07:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr, en-GB
To: netdev@vger.kernel.org
Cc: Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
 =?UTF-8?Q?Fabian_No=C3=ABl?= <Fabian.Noel@iba-group.com>
From: Philippe Andersson <pan@iba-group.com>
Subject: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches (too
 small inter-packet gap)
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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WI20o4XgV8RNrqONhgrGWfkV"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|GVXPR06MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5ad457-9d0a-44e0-8e9c-08decba83bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|6049299003|1800799024|56012099006|11063799006|18002099003|6133799003|4053099003;
X-Microsoft-Antispam-Message-Info:
	DBa4L5Y29fRdlJDG3GTaUAn3mFOJo3ULccJZeXUmeZeikQE0YFbNFuQesY9xrTfLWntl9z9DnN09AA+2qnQ1IBAsPGNfyAInKHnC9jRZgboZecrBwE+12YGrVJW4NlpBXx6iGPR9McVHGblnEc63N6V2/aUk6nIMzX+h4f8l7BTgVjcYTjpEidJJUq8IkGdvUjbw/qgkl48YG45NSTgWebxEypRHQf9iTwWCECnpOTaOaf1vm1CTnOtSoNIBXgKykKpdu1mQbCksLqn54asiXFsOYZUxKXazD7mb9mfUh3064Se/XvR7INWgJjTW4PI+9HQkgvD9r3TxhJUfgONtuzIuxiikPcJcCZaiV7qDLNJ7UT6Ir5pLS+w4wKFfCZbtH6I+Pv4LIoyo8BS+9y37X8hFN2ME0Ly19j6YgUhN69N1i4XT6he6b+N4wKwxjCvb62Jiyra/3Y1TVy5cti84mBOJIuoj0InImiTfs43haMd0j4sNxaGq4LGWBXSaREz5Y4CopRhdkKldwuibWwJmBYBmX7zwcu8T8qxuKf0DzR3tRbFQY/DpbSOk26Ce3vsXJZiIaqDBCcM1cZ/aBvJYjaY86liZ5xSIeQBCQ4SkS+WRnrghDKP1SF3L2P27HxASlTE2eM2dvNguYbDG4EjXKD54XUO6GJ65AT4xAGAwhwJo2mzGrq6WMhWVbJe8r2Ng
X-Forefront-Antispam-Report:
	CIP:185.185.229.160;CTRY:BE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay-lnx.goiba.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(6049299003)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003)(4053099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sQCMNuDBz12KwwpGo+twb2BYI7RLW26bjb+Pj9/M8rgIBDJrZGHmQEcGsBbEX+UD4AYN+R2B2MrL0SHbvoKtR4mXsFTHxxQgSUza6iiTrzuw00SLTbF99Hkm21PmNqP3Gwlr34zp/Wf/icwMs4PM8BG3GBJCEarlTQJL9WKHebcp2rOLz78nTejChfm/3AfNKR1S0q0IKC32RtQnD/56LYiHfeRjVCOLIohrt3puDpC8JkS2DTtE/66VFIzC2DVqilrtSTWBsbgs/G+W02u6SvX+97aArcaeCqM7oglWOdVtJTmE70Btoi7KsmAuVSbiXBisn0cvzcSLDsWbGI8bg/a3woErMpy/pusp5P7kF7KmG59qWUawziLCCffLM4ek8QoQz464BZ5Qgn8f0bpLFvDWFpmmCrEfp+yKrGNJmBEul5JP+F/AV6+YDFAZaFHI
X-OriginatorOrg: iba-group.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:07:35.0915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5ad457-9d0a-44e0-8e9c-08decba83bce
X-MS-Exchange-CrossTenant-Id: c2a8770b-ad33-4215-bbe7-ec4185e9587b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c2a8770b-ad33-4215-bbe7-ec4185e9587b;Ip=[185.185.229.160];Helo=[mailrelay-lnx.goiba.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB9439
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[iba-group.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[iba-group.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299844-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:Ludovic.Calmant@iba-group.com,m:Fabian.Noel@iba-group.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,iba-worldwide.com:url];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[pan@iba-group.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pan@iba-group.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iba-group.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DF9468FC04

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WI20o4XgV8RNrqONhgrGWfkV
Content-Type: multipart/mixed; boundary="------------be6rpG1Kf4PayK3DQxpf0Qul";
 protected-headers="v1"
From: Philippe Andersson <pan@iba-group.com>
To: netdev@vger.kernel.org
Cc: Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
 =?UTF-8?Q?Fabian_No=C3=ABl?= <Fabian.Noel@iba-group.com>
Message-ID: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
Subject: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches (too
 small inter-packet gap)

--------------be6rpG1Kf4PayK3DQxpf0Qul
Content-Type: multipart/mixed; boundary="------------Ssxc1k2ONtCV35h9BQ2IZsPE"

--------------Ssxc1k2ONtCV35h9BQ2IZsPE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCk91ciBwcm9kdWN0IChhIG1lZGljYWwgb25jb2xvZ3kgc3lzdGVtKSB1c2Vz
IFRDUC9JUCBmb3IgdGltZS1jcml0aWNhbCANCmNvbW11bmljYXRpb25zIGJldHdlZW4gY29u
dHJvbCBzeXN0ZW1zIChQQ3MgcnVubmluZyBMaW51eCkgYW5kIA0KZWxlY3Ryb25pYyB1bml0
cyBvciBQTENzLg0KDQpXZSByZWNlbnRseSB1cGdyYWRlZCBvdXIgc3RhbmRhcmQgbmV0d29y
a2luZyBlcXVpcG1lbnQgZnJvbSB0aGUgb2xkIA0KSFBFL0FydWJhICJQcm9DdXJ2ZSIgbGlu
ZSB0byB0aGUgbmV3IEFydWJhIEFPUy1DWCBvbmUsIGFuZCBzaW5jZSB0aGVuIHdlIA0Kc3Rh
cnRlZCBleHBlcmllbmNpbmcgY29tbXVuaWNhdGlvbiBpc3N1ZXMgY2F1c2VkIGJ5IChvciB0
cmlnZ2VyaW5nKSANCmxhcmdlciB0aGFuIHVzdWFsIHBhY2tldCByZXRyYW5zbWl0cyBzcGVj
aWZpY2FsbHkgb24gaG9zdHMgdGhhdCB1c2UgdGhlIA0KJ2UxMDAwZScgZHJpdmVyIChJbnRl
bCBJMjE5LUxNIGFuZCBJbnRlbCA4MjU3OUxNIGJvYXJkcykuIFRoaXMgaXNzdWUgDQppbW1l
ZGlhdGVseSBhZmZlY3RzIHRoZSB0aW1lLWNyaXRpY2FsIGNvbW11bmljYXRpb24gY2hhbm5l
bHMgSSBtZW50aW9uZWQgDQphYm92ZSwgYnV0IGFyZSBhbHNvIHNlZW4gZS5nLiBpbiByZWd1
bGFyIE5GUyBjb21tdW5pY2F0aW9ucyAoYWx0aG91Z2ggaW4gDQp0aGlzIGNhc2UgdGhlIGVm
ZmVjdCBpcyBub3QgZ2VuZXJhbGx5IHBlcmNlcHRpYmxlIHRvIHRoZSB1c2VyKS4NCg0KSGVy
ZSBhcmUgdGhlIHRlc3RzIHdlIGRpZCB0byB0cnkgYW5kIG5hcnJvdyBkb3duIHRoZSBwcm9i
bGVtOg0KDQotIGFkZCBhIHNpbmdsZSBBT1MtQ1ggc3dpdGNoIHRvIG91ciBvbGRlciBuZXR3
b3JrIHRvcG9sb2d5LCBjb25uZWN0IGEgDQpzaW5nbGUgRGViaWFuIDEyIHdvcmtzdGF0aW9u
IHRvIGl0LCBzaW11bGF0ZSBhIGNsaW5pY2FsIHdvcmtmbG93OiANCnByb2JsZW0gcHJlc2Vu
dA0KDQotIGluIHRoZSBzYW1lIHRlc3Qgc2V0dXAgYXMgYWJvdmUsIGNvbmZpZ3VyZSB0aGUg
RGViaWFuIHdvcmtzdGF0aW9uIHRvIA0KdXNlIGl0cyAybmQgTklDIGluc3RlYWQsIHdoaWNo
IHVzZXMgdGhlICdpZ2InIGRyaXZlcjogcHJvYmxlbSBkaXNhcHBlYXJzIA0KKGlkZW0gd2hl
biBwbHVnZ2luZyBpbiBhbiBleHRyYSBQQ0kgTklDIHRoYXQgdXNlcyB0aGUgJ3RnMycgZHJp
dmVyKQ0KDQotIGluIGEgbGFiIGVudmlyb25tZW50LCB0cnkgdG8gcmVwcm9kdWNlIHRoZSBw
cm9ibGVtIHdpdGggYSBzaW5nbGUgDQpEZWJpYW4gMTMgd29ya3N0YXRpb24sIGEgc2luZ2xl
IEFPUy1DWCBzd2l0Y2ggYW5kIGEgc29sZSBjb21tdW5pY2F0aW9uIA0KcGFydG5lcjogY291
bGQgbm90IHJlcHJvZHVjZSAoaHlwb3RoZXNpczogYmVjYXVzZSB0aGUgImJhY2tncm91bmQg
bm9pc2UiIA0Kb24gdGhlIG5ldHdvcmsgaXMgdG9vIGxvdykNCg0KLSBvbiBhIHRlc3Qgc2l0
ZSBhbHJlYWR5IGVxdWlwcGVkIHdpdGggQU9TLUNYIHN3aXRjaGVzLCB1cGdyYWRlZCB0aGUg
DQpEZWJpYW4gd29ya3N0YXRpb24gdG8gRGViaWFuIDEzIChrZXJuZWwgNi4xMi54KSwgc2lt
dWxhdGUgYSBjbGluaWNhbCANCndvcmtmbG93OiBwcm9ibGVtIHByZXNlbnQNCg0KLSBvbiBh
IHRlc3Qgc2l0ZSBhbHJlYWR5IGVxdWlwcGVkIHdpdGggQU9TLUNYIHN3aXRjaGVzLCBmb3Jj
ZSANCndvcmtzdGF0aW9uIHBvcnQgdG8gMTAwTWJwcyBoYWxmLWR1cGxleDogcHJvYmxlbSBk
aXNhcHBlYXJzDQoNCi0gc2V0IG9wdGlvbiAiaW50ZXJwYWNrZXQtZ2FwIGhpZ2gtYXZlcmFn
ZSIgb24gQXJ1YmEgQU9TLUNYIHN3aXRjaDogbm8gDQplZmZlY3QNCg0KLSBhY3RpdmF0ZSBm
bG93LWNvbnRyb2wgb24gd29ya3N0YXRpb24gYW5kIHN3aXRjaCBwb3J0OiBubyBlZmZlY3QN
Cg0KQSBzdXBwb3J0IHRpY2tldCBoYXMgYWxyZWFkeSBiZWVuIG9wZW5lZCB3aXRoIEFydWJh
LCBidXQgaXQncyB1bmNsZWFyIGF0IA0KdGhpcyBzdGFnZSB0aGF0IHRoZSBwcm9ibGVtIGlz
IG9uIHRoZWlyIHNpZGUuIEJhc2VkIG9uIHRoZWlyIGFuYWx5c2lzOiANCiJUaGVyZSB3YXMg
YSBCVUcgbm90ZWQgZm9yIHRoZSBzYW1lIGlzc3VlIGZvciB0aGUgZGV2aWNlcyANCndpdGjC
oEludGVswqBJMjE5LUxNIE5ldHdvcmsgQ2FyZC4gVGhpcyBpc3N1ZSBpcyBvYnNlcnZlZCB3
aXRoIA0Kc29tZcKgTklDwqBjYXJkcyB0aGF0IGFyZSBub3QgdG9sZXJhbnQgdG8gc21hbGxl
ciBpbnRlciBwYWNrZXQgZ2FwLCANCnRoZXNlwqBOSUNzwqB3aWxsIHNpbGVudGx5IGRyb3Ag
cGFja2V0cyBhdCBjZXJ0YWluIGludGVyIHBhY2tldCBnYXBzLiINCg0KV2UgY2FuIHByb3Zp
ZGUgcGFja2V0IGNhcHR1cmVzIHRoYXQgaWxsdXN0cmF0ZSB0aGUgcHJvYmxlbSBpZiBpdCBj
YW4gDQpoZWxwIChidXQgaWRlYWxseSB0aHJvdWdoIGRpcmVjdCBlbWFpbCwgbm90IHRoaXMg
bGlzdCkuDQoNCklzIHRoaXMgaXNzdWUgYWxyZWFkeSBrbm93bi90cmFja2VkIG9uIHlvdXIg
c2lkZT8NCg0KVGhhbmtzIGluIGFkdmFuY2UuDQoNCkJlc3QgcmVnYXJkcywNCg0KUGguIEEu
DQoNCi0tIA0KDQoqUGhpbGlwcGUgQW5kZXJzc29uKg0KVW5peCBTeXN0ZW0gQWRtaW5pc3Ry
YXRvcg0KSUJBIFBhcnRpY2xlIFRoZXJhcHkgfA0KVGVsOiArMzItMTAtNDc1Ljk4Mw0KRmF4
OiArMzItMTAtNDg3LjcwNw0KZU1haWw6IHBhbkBpYmEtZ3JvdXAuY29tDQo8aHR0cDovL3d3
dy5pYmEtd29ybGR3aWRlLmNvbT4NCg0KDQo=
--------------Ssxc1k2ONtCV35h9BQ2IZsPE
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

--------------Ssxc1k2ONtCV35h9BQ2IZsPE--

--------------be6rpG1Kf4PayK3DQxpf0Qul--

--------------WI20o4XgV8RNrqONhgrGWfkV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRNaVrpkigRgJ/qxSZ6SvhOD0kfbAUCajFKlgUDAAAAAAAKCRB6SvhOD0kfbErc
AKCQbo21Ij8A4cFhHMjL9NPBTXJdmQCcCeTWnrx7A3X4tD4CPFrLSzvGzVU=
=9Szx
-----END PGP SIGNATURE-----

--------------WI20o4XgV8RNrqONhgrGWfkV--

