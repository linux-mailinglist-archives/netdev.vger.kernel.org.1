Return-Path: <netdev+bounces-299342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ol7F3aiL2o1DwUAu9opvQ
	(envelope-from <netdev+bounces-299342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:57:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2948683F9B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:57:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=MZ8jdYFM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299342-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CACE8300F131
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 06:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345283B19B7;
	Mon, 15 Jun 2026 06:54:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E43AEB35;
	Mon, 15 Jun 2026 06:54:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506447; cv=fail; b=HUv12nDQOrDlAdOLUss1eSDfzPcA6+Si6I7g3NqA/DFY3Pguy4j7wKKknxWGhLj/RiuhEMSF0cHwS0FF6W8ht+64ioRLKRK7SAA67cYkk16LE07biWp4E4YfnPxVJkFLjyuKJL/apdm6PkpNX9Mb4cfStmNzHZw1yvQJHVZQCv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506447; c=relaxed/simple;
	bh=Bb79avXE0YVBPES8AlBWStN3O2nOB78U62nETa28YJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVh+TOixuJeLMakXUklP0lcDG13kQH0B/WbawwccVNHWP28W2yR3WMqNvMEX3cd+k+42awtbBDFalV+xbWOtbJAeRtjc+x73Oaw0bmanwE9we1CQGJmRFwoI97Z0JlHIeMwzCJTWwo72SV/Tt/3DeTKvB75HsNxJg2u7/VkrHLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=MZ8jdYFM; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcYLWOc3lDXDtcTP/jQBiPOM+wdKcPFfViplp9qgVZC3rJ2sGJyQYkgqxVN94+ZwgA1xhIrWzjtpKjCpUDFaN0UaWx1ogVf9Z2cNjSTQk8Muitq+yksN9dX9TAyyJpQFQZ/o4eTUmsJ1dgO2lNre3sDQPPeyM5QeoSAiu3GbCfQUNBr+c+Agc2fNhFMNFhanq+eYCvJewbqGXBWfhc5PGRPNlSCjtP/c4tm+VU/NtvK6DUK5GwHncPkBZtfrWF1oBjSd3Fcjo7SfEo7oTzkJ3tJrPGQXSbPDDfgvfbUqwsXrNeU+Tbp8S2IvA854rZ5kQj85iACb2TPY+mfrdCu2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWbe6npVx5FLRtUXYmvrRGmpZ6i+z8O7EnuSx78qDQg=;
 b=ywg4x2MTM0YDRWmVg6WzUrY3sledht9Q15dADtM5RrAYyGw4LBKvOkEttFuHaO7Yy+uav5D9XO8dFOF5qoIwGqIaR8vqGbxpKBZDjoszcYL03FWaqkCPGbz1o19F0FhmsQbpJpLug1vDSgx+telJCzjpSDdq6f+jPdoQTYFTgcGubyX13s2KAWTnNDQZabS7oKyK8Z+Gc+VlAn/ADLZJ3NS5JEC0A3/P1UQzzuPnJah0IjTfTtcmt0CQlWdm+MmPzI6mCCi/o0SlcqKc9jDXj7E3FgasTkg5EZE4T1cq3vxR1841OW4VcEviQoIjRMuNX6hIiAbaweOZ4dM2UaeWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWbe6npVx5FLRtUXYmvrRGmpZ6i+z8O7EnuSx78qDQg=;
 b=MZ8jdYFM3WZXyZCWed74SKeMrmVJYNTYRkl1NwjWGtuZNvPigx3t0zk4U5msXf0zbws2kMkYU4uubqZ24rL5zn2eKaGx5/xCPGckS7gbWgsNhCfIkfRBb9HqLHu0TMSGfWYewj2R3k707+d3VH0h6MIS8IDsoneSwdTFslMyec6N5SFtbcw9ZBJXTZz1Aj0FTJl4prID2MITeWr0AqESWFeqNEO43S68pQssaoJ9dnQbemvrxQD1hg09tmWX5xLkI4Te6fY1OSRcUTfXjs9FHDLfxXpVwia9F+IdwcDcI0LgyTdjkDqxZrYRqaQL2coDNvh+DG5eKsj9srgwOUgPJA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM0P189MB0819.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:19a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 06:54:01 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 06:54:01 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Thread-Topic: [PATCH net v2] tipc: fix slab-use-after-free Read in
 tipc_aead_decrypt_done
Thread-Index: AQHc+RTOyMkQg45BZ0atzvBgrVOC7rY45MwAgAXjDoCAAGxEMA==
Date: Mon, 15 Jun 2026 06:54:00 +0000
Message-ID:
 <GV1P189MB1988AABD9D26A0EF0C5481A3C6E62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <GV1P189MB1988B2B662DC781F7347EBD4C61B2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260615002211.90694-1-doruk@0sec.ai>
In-Reply-To: <20260615002211.90694-1-doruk@0sec.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM0P189MB0819:EE_
x-ms-office365-filtering-correlation-id: 0ca52de0-c79c-4381-54aa-08decaaae18a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 b1wvbBsJiC47G57cE/XTqhE6jsfauwVDnKCtq3Ba0qscBtNJJg6S26zPwDPL2KHa5Akru4r+0hV/RTFqFZUFh+bXpbDIs36vRoDFPYoMdgbxko6mebtDAtr4ydzRzDDMkO7oZvJWP76C5uqy3kJRHjQaQXOM91ulVv0KM94jf1VWFMYoOmK+hQ8tb4pUjnoycthuhyCZkyc8qF39VRG9DJvblHkX7rILO9ubd3llWwJTuqLSXL1tpDZu2xaq0dvS0VEes+OJREWXEGYn2G15dlXjnBiE30R7bcoPAgV1KrJwaxy6hTGqAL54DM09T3VDaeggfZ0Ib53m8bjrDGaxynCK4h6t0j78J7ZX6Dl0GFRIbf7FG4R8mjPS9BQlG2EU2CgVtNr89t8h/Zg9WWWuoKJrPXeiWeAM737YjfsY6H1UhGayJVeuYipCWnlJscWsczF1We9m0z6/6Tx/lhzPuVwl6cfJAHE6xj3fzMEqvazr13G78AAfPcy+V1ySeRntxzacHOCbOKFe8DTx2x9hKCe1YNgfm8XRU8Ji71yaSNVm+I6DRxSykCWMCBzMjHc6ZnuYEfgs3nESd56XX5LI7MyMleN9iFcUyVLUMtC9CJVk8m/uhG9vMrE3dNtQPJGLKkauDCDOzzJA1F/76IRilf9RDxqULfa8gKIL/qkguEPAdM20as8W4S4k7bOLsZskYgMblVSVCzI3OrpMVu5VgLqhtcHdUaJnK8jaMav9Zm7zbBlyVNURlSxk82RTRQ3T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RtlE3+KG31wcG7rQDdReuMFnsZUyakOlX5lSZ1wv8Pe/hRz5X1ewgAZFHCgb?=
 =?us-ascii?Q?QQuNBO0Z8n37L0S2Yeze4sZJlOf8fFFth2yudQAFJtQWHWVP0c9pCLb3JhPf?=
 =?us-ascii?Q?XJPiQXzU9huLLPmmMcql7vJzU1IjNfTX4GCGew63Z+xScWLiToaDfxd2ky6g?=
 =?us-ascii?Q?IJFinKnlmI7KhSzuC87JTgqVXawS5RwAZgW6lmNhgjsZOmminXzlMbEiskJI?=
 =?us-ascii?Q?bLBf6SORAvKNOEt4jDYagQKdvQkNGSOal+5WRN/xOa0FAqdr3gTb6CbZfNpx?=
 =?us-ascii?Q?tpkfpxApspcC/O83wI9YfRjdK37goGir2OMuhYtDfGGz0gKf5Wr0xbUIjDNP?=
 =?us-ascii?Q?0zY92kjme5QYWqa3hUuLrQYBrydaTv094dEddUB+qvy5e8LUfKJEolilmsFZ?=
 =?us-ascii?Q?xjYdESUj8nvUFmClGGHCND2k3huFlAzU8r6D4nujEMZ2s8jR46kZV6eCQRXg?=
 =?us-ascii?Q?I1u1QifjLJxAod+v+jMPwyEfd6U+4CDMJbWnr8uHaTSc2v+6k2XsmuYbkFee?=
 =?us-ascii?Q?RC2GKHV8ZjzhM+0SJxVJdATYEoA4nntU1GYYqcSBxllTxE9BbPhAxqetXDj0?=
 =?us-ascii?Q?miXdFizzdTGvp4WSGCy9Fd2gdwa6ypNybzd6xTATEvjyOKFQMVC3w9pXQlKm?=
 =?us-ascii?Q?ds5QxAiyx38oKIb9MvKoxb6/NgEAh3CdtXbSDolpZzUzpeRm5Q4Mu1KehrTS?=
 =?us-ascii?Q?ccyuhhyEtg0trXJ6MS1HUR9edAZUpQ4Hm9DN47AjFKpPjaqJwvZA0MExe9NI?=
 =?us-ascii?Q?2A+CO6+81b6JY9OWzOQ9b9L4ZQ1r9wcTeJK2kyBGRN6OCgxJxL/gH67shFA9?=
 =?us-ascii?Q?4QZNTqhoLzfdzz8THTnRZvMg30VHGlAbd9QZWe5Ri4tC1QE6Y636W3aCrkSt?=
 =?us-ascii?Q?HUpIhbt1FkXjvvSjJv3uXeHsOed2OC2cUJs7sf8RwL9g3DEVu2vNM7+165dZ?=
 =?us-ascii?Q?DmYTFT1Su0Rip5R6xJpbh1rg1xz7WE9UyTeWASJMpdUAM0lhKxYLVEJfrGJg?=
 =?us-ascii?Q?E9Xe2D2QUBq64izduIniU8kMzGtlSKJKcJKod5fbefckSn2uFiLimIs+yBSO?=
 =?us-ascii?Q?Lft2O7VlSfOpjJSoG8HE40ktroZP6cNiRAYKc+eoo/IOuq9ReBYT3rQ5Zemx?=
 =?us-ascii?Q?7Pke+yr3oquOc2mdqyyojQQ3R223yyYHfhNRMXdezwzThRxWSKppZRmrQns4?=
 =?us-ascii?Q?SQiMUfCC7MlWPQVp8VNI0RH7oc50hxH96F2Q5e9YobzAkIJLqtw0Pk1T4g8P?=
 =?us-ascii?Q?rE9ByijOOUvCiXXWni8CB72nkWHIHJYrPRn1Gz4zQgzyuB1GNC1MTQn6wn4n?=
 =?us-ascii?Q?sklVXchzhTYR4vAKiJcSXWcemJU/yJfrY+XsvQSqiXSFl2eHKdvY1NLtF+CQ?=
 =?us-ascii?Q?Bjuop1P0peK2dLvm9ROlSfdEIzQ0s0wZ+R71pgdTmuOH7El4cqH972AMMMCK?=
 =?us-ascii?Q?E9PQ2Mqo16ADhsqqPUm3yUtjF9tFQ7qnx/1sFoNLFew+74CerGygTg8fodl7?=
 =?us-ascii?Q?eRNxD/+l2hmhYUPbdQ3Gh7mFeHoAUhmIDhyx7JY7p8ewz/hPlQ5YuZG73Qtf?=
 =?us-ascii?Q?7gaw7nY3AqghbWeN1b7njmZ49KhcOlit2ZxM5+/XOOdYxLWzFr218e5Oklem?=
 =?us-ascii?Q?39eF0ExtHWmBbxo3HrJCnn7pm/ga5FCp87Bw8xYy9wzBGGxVssBMrwNkN+3M?=
 =?us-ascii?Q?DOrBH4EPC966klAgG+0K2cZIe3itkPyt3PCp9d5pKWVgwzyFm48IeBqB/BzD?=
 =?us-ascii?Q?ukKRYyo0lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca52de0-c79c-4381-54aa-08decaaae18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 06:54:00.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nG5LYUuYRYLugy2meYRT5nam3qC8FIjBkLKxKv5Mvn4ID728KAhFqaDJizs5wxJ7IbQjvdyo6raDhpKwgniv0E6L5n5K8sAQijx6STTETo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0819
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-299342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:jmaloy@redhat.com,m:aleksander.lobakin@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2948683F9B

>Subject: Re: [PATCH net v2] tipc: fix slab-use-after-free Read in
>tipc_aead_decrypt_done
>
>On Tue, Jun 10, 2026, Tung Quang Nguyen wrote:
>> Can you decode the stack trace (using
>> linux/scripts/decode_stacktrace.sh)
>> for more readable text?
>>
>> Is the issue reproducible on the latest net branch, or just on the old
>> v6.12.92 you mentioned?
>
>Hi Tung,
>
>Thanks for the review. Answers to both questions below.
>
>1) Decoded stack trace
>----------------------
>Decoded with scripts/decode_stacktrace.sh against the vmlinux that produce=
d
>the splat (6.12.92, CONFIG_KASAN_INLINE + CONFIG_TIPC +
>CONFIG_TIPC_CRYPTO).
>The use-after-free read and the allocation/free sites resolve as follows:
>
>BUG: KASAN: slab-use-after-free in tipc_crypto_rcv_complete
>(net/tipc/crypto.c:1917) Read of size 8 at addr ffff888104c8c808 by task
>kworker/3:2/70
>Workqueue: cryptd cryptd_queue_worker
>Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:123)
> print_report (mm/kasan/report.c:378 mm/kasan/report.c:481)  kasan_report
>(mm/kasan/report.c:596)  tipc_crypto_rcv_complete (net/tipc/crypto.c:1917)
>tipc_aead_decrypt_done (net/tipc/crypto.c:996)  cryptd_aead_crypt
>(include/crypto/internal/aead.h:85 crypto/cryptd.c:772)  cryptd_queue_work=
er
>(crypto/cryptd.c:181)  process_one_work (kernel/workqueue.c:3264)
>worker_thread (kernel/workqueue.c:3339 kernel/workqueue.c:3426)  kthread
>(kernel/kthread.c:389)  ret_from_fork (arch/x86/kernel/process.c:152)
>ret_from_fork_asm (arch/x86/entry/entry_64.S:257)  </TASK>
>
>Allocated by task 1550:
> kasan_save_stack (mm/kasan/common.c:49)  kasan_save_track
>(mm/kasan/common.c:61 mm/kasan/common.c:70)  __kasan_kmalloc
>(mm/kasan/common.c:378 mm/kasan/common.c:395)  tipc_crypto_start
>(net/tipc/crypto.c:1484)  tipc_init_net (net/tipc/core.c:73)  ops_init
>(net/core/net_namespace.c:140)  setup_net (net/core/net_namespace.c:357)
>copy_net_ns (net/core/net_namespace.c:512)  create_new_namespaces
>(kernel/nsproxy.c:110)
>
>(The captured report has the KASAN read trace and the Allocated-by track; =
the
>free is on the netns teardown path tipc_crypto_stop() <- tipc_exit_net() <=
-
>cleanup_net(), as described in the changelog.)
>
>So the freed object is the per-netns struct tipc_crypto allocated in
>tipc_crypto_start() at netns creation (crypto.c:1484), and the cryptd work=
er
>then reads it from the async completion: tipc_aead_decrypt_done()
>(crypto.c:996) -> tipc_crypto_rcv_complete() (crypto.c:1917). Immediately =
after
>the UAF read the worker also faults dereferencing the stale node pointer i=
n
>tipc_node_put() (net/tipc/node.c:319), confirming the object is gone.
>
>2) Reproducibility on the latest net branch
>--------------------------------------------
>The bug is still present on the latest net tree. I checked out v7.1-rc7 an=
d
>inspected net/tipc/crypto.c first: the encrypt side already carries the
>maybe_get_net() guard from commit e279024617134 ("net/tipc: fix slab-use-
>after-free Read in tipc_aead_encrypt"), but tipc_aead_decrypt() still goes
>straight from tipc_bearer_hold(b) to crypto_aead_decrypt(req) with no
>maybe_get_net(aead->crypto->net) and no matching put_net() -- i.e. the exa=
ct
>gap this patch closes. So the decrypt path is unguarded on 7.1-rc7 and the=
 UAF
>is reachable there in the same way.
>
>I also built v7.1-rc7 (HEAD at v7.1-rc7) with KASAN_INLINE + TIPC +
>TIPC_CRYPTO and reproduced the UAF live. The workload is the same as on
>6.12.92: a UDP bearer with a cluster key is flooded with crafted encrypted
>frames from an unknown peer, taking the cluster-key (pick_tx) RX decrypt p=
ath,
>while the bearer's netns is repeatedly torn down. Decoded against the rc7
>vmlinux:
>
>BUG: KASAN: slab-use-after-free in tipc_aead_decrypt_done
>(net/tipc/crypto.c:999) Read of size 8 at addr ffff8881056258a8 by task
>kworker/u16:2/51
>CPU: 2 UID: 0 PID: 51 Comm: kworker/u16:2 Not tainted 7.1.0-rc7-00020-... =
#15
>Workqueue: events_unbound
>Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)  print_report
>(mm/kasan/report.c:378 mm/kasan/report.c:482)  kasan_report
>(mm/kasan/report.c:595)  tipc_aead_decrypt_done (net/tipc/crypto.c:999)
>process_one_work (kernel/workqueue.c:3314)  worker_thread
>(kernel/workqueue.c:3397 kernel/workqueue.c:3478)  kthread
>(kernel/kthread.c:436)  ret_from_fork (arch/x86/kernel/process.c:158)
>ret_from_fork_asm (arch/x86/entry/entry_64.S:245)  </TASK>
>
>Allocated by task 169:
> __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
>tipc_crypto_start (net/tipc/crypto.c:1502)  tipc_init_net (net/tipc/core.c=
:72)
>ops_init (net/core/net_namespace.c:137)  setup_net
>(net/core/net_namespace.c:446)  copy_net_ns
>(net/core/net_namespace.c:579)  create_new_namespaces
>(kernel/nsproxy.c:132)  unshare_nsproxy_namespaces (kernel/nsproxy.c:234)
>ksys_unshare (kernel/fork.c:3242)  __x64_sys_unshare (kernel/fork.c:3316)
> do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
>Freed by task 8:
> kfree (mm/slub.c:6566)
> tipc_exit_net (net/tipc/core.c:119)
> ops_undo_list (net/core/net_namespace.c)  cleanup_net
>(net/core/net_namespace.c:704)  process_one_work
>(kernel/workqueue.c:3314)  worker_thread (kernel/workqueue.c)  kthread
>(kernel/kthread.c:436)
>
>The freed object is the per-netns struct tipc_crypto allocated in
>tipc_crypto_start() at netns creation (crypto.c:1502 on rc7); the async de=
crypt
>completion then reads aead->crypto->stats from it (crypto.c:999) after
>cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() has freed it -- the=
 exact
>read/alloc/free triple this patch closes, now on 7.1-rc7 rather than 6.12.=
92.
>
>One note on the harness: on x86 the in-tree gcm(aes) the SIMD aead wrapper
>used to register via simd_register_aeads_compat() is, as of the aesni rewr=
ite,
>now registered directly with crypto_register_aeads() and decrypts
>synchronously, so the cryptd async window the original 6.12.92 splat used =
does
>not arise from the stock aesni path on rc7. To exercise the same async
>completion the changelog describes, I forced tipc_aead_decrypt()'s complet=
ion
>onto a workqueue in my test tree; the unguarded aead->crypto dereference i=
n
>tipc_aead_decrypt_done() is what KASAN catches, and that code is byte-for-
>byte the unpatched upstream path. The source state is in any case
>unambiguous: tipc_aead_decrypt() on rc7 still lacks maybe_get_net(aead-
>>crypto->net), so the completion can outlive the free on any config where
>crypto_aead_decrypt() goes async (e.g. cryptd offload).
>
>Reproduced under KASAN on both v6.12.92 and v7.1-rc7; the decrypt path
>lacks the guard on the latest net tree.

Thanks. Please submit v3 with updated changelog (decoded stack trace, remov=
e v6.12.92) because we always prefer latest tree to old one.

>
>Thanks,
>Doruk

