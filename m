Return-Path: <netdev+bounces-293209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MlxCAXjGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:03:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C31CD607A57
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B02E30B1724
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF8847799D;
	Fri, 29 May 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="UW/tU4Es"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007E47ECD0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080116; cv=none; b=h+pO37rDep7RpdTzqd1yU8INWZ6LiYi8MP1hkYrmrXfTn8Fjy/usAn7V4Q+R30FbdGD9d/Rtpjo/LWFuUSHjZU0T6gRq8LC46TubnzbaWDdPDz9GKHjj+lb1kIYHigQtTesu/JN27Nf/AWy1z+UdFYwSDZ5m1wBy7jTlQR/zPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080116; c=relaxed/simple;
	bh=uva3Wh2G41ZjJ7s3C9OQsVwYKWq75QhraT6FmWMwLsM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vEFXvlmwbhKq1W7llgLtMUNkWOdO8ftz+t1j2Vw+92NuliyNg7L+v8EJFb+WWl1OpfvJMv99khphJaJAM+RSdcVPVVxFggNcNEeVQ3TSyOB51x6qe1eb6BuVI6Jz0U8zBxV/D58MlRElJhWLsnVbHrbr0oE4x8nxVxmTUifd4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=UW/tU4Es; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lwrj/ywtXNjbe0dHgmLhjk3odes4syGRReRu941q9DY=;
	b=UW/tU4EsU8eI8kxzNWhnr9/C2/VNGBLo00+H1QezDsCIYPEw53EZq+54gcyWQOdy6VmRQz
	Gw0BWJooMo3G6V1VAY/qPg2J3+6H2DrGD9582MTbAlaNQ5uAXftoF8eFgN6J0sWQGu7QvY
	UqPdu4fa2agvgVVqSiLRAQ5o9MW13/w7BAmNkhVz7ORyu3ypQLbPDVQfmWmq605TfKOGEL
	hfqrnIbhLT09RvF1Uz26X4zZDibRUr5BzW5A0ioJkHoBhLKTl8tePsc1fFYVcA1+ubsR56
	wMOpe1RXMirJq+ehuzrKTBSqzA6+r8mauj6LWhwkaAlLfeO6CSMBsRTagz9HOg==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-16-ZrT7QEqgOUCilplPWza9BQ-2; Fri,
 29 May 2026 11:41:46 -0700
X-MC-Unique: ZrT7QEqgOUCilplPWza9BQ-2
X-Mimecast-MFC-AGG-ID: ZrT7QEqgOUCilplPWza9BQ_1780080102
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:38 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:38 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 14/14] Documentation: networking: Add timestamp
 related APIs to OA TC6 framework
Thread-Topic: [PATCH net-next v3 14/14] Documentation: networking: Add
 timestamp related APIs to OA TC6 framework
Thread-Index: AdzvmhThHuxCpdZnTFeuAkMveDpFww==
Date: Fri, 29 May 2026 18:41:38 +0000
Message-ID: <CY8PR02MB9249D1ECBA54A1083D404A6D83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: b6f5a404-cf72-4ede-1272-08debdb1eb15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|6133799003|921020|3023799007|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: payaUazXmY21C/7l/1HsBMT+V2CbbEhUeS/DjM2aok9l1S1uhTGikYPyhWt7q8LScAPkJFaUOm+QBzzV5jluBC8FrIQMlTMdjheNWpA/Fd0l5NzB4vzSXkYdXwDxn2wx8+Vz9yNoXyrNAsqmQlHE62qpCA4148573x8rYCYBdMdHSkLaGecvYud03p/qNnkhTd+wuaZwrmj4CrebjjznoFD43XO/Fj825+QY0AaM2ytNWRQXtpUrTIPjggeJyp3icy7+WNYizmeQXfgd8BOIOCRwiRSKCq5vcoQ6/N4o73QU9qUU2broXXZqIlRi0jvQ218EWLBVc8VqC5xwJqbeusdoknqq3BBymnk3YianK64XieKwC7yFXLXZ5ykd91dPh+830Al1R1UKVWFSxaaqMK1ov9aFtJr4eX0usA0r62mA1+3JPlBFmtBl3cM42DxfZr74rcGZpZF4kzFDp+0ajAeYhzCTtqIaQwkcNxurr9aZitwbLmUL/Dg1IAdqbBLn7rIRYOmW3KgV0/6/kWI6ldEB+aDbVyu8T5M578EWWKzeuUYBg839nTwLRX6fNFgn8S9fdL3oAb3wfSI/sSm623eE4BG6AQqZWr75R+H1zgOzMtbtYazOM6WFZzsY1DacdBo0RpDTVkuT17d6z/DKqiZk9opeeflyIgryXoeTlo98LlCNQ3C0SRWPJjVlNVqj3QiCHlW7XHtz70WQHCPoxcS3nA31BzZmQI2Dacg6xTQTg8kU+NcPHkPm8N3aXkzhwaPmuXAnq1b7+nAwTZih5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(6133799003)(921020)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VnQJdF44vOQbG9Ott6xR++WSA2NW8xIyfTXqGIGyxRqoqMGFeypHW0H4w3IC?=
 =?us-ascii?Q?1BEQdk9VzHrGeFEMtFDIBPAWkf8fBbcy4sdh72CtfTklkTe1HPCGV954/AdY?=
 =?us-ascii?Q?+XnXuX5MQx+pKTAugWUuVkIlrckZrUaj+aZE3EqUqu9pX6mMAcAoahN8Quvv?=
 =?us-ascii?Q?6h3/kJAnL6ZUs2wM2uAob+1fHnFy8Dk3sIqQkOgG3+2xiQ4qojp4/2XiRw38?=
 =?us-ascii?Q?K5HKTtyFNmbCKRkFl41rKhvuxvNooza7RFW1+pL81A+ijjmMAdaVI+kSbzJx?=
 =?us-ascii?Q?l6/883W6GB/L5YYCjN4TNQhC88Y6I/7c/jOXFIzWi3tbfI1T19UBOSUpjvkh?=
 =?us-ascii?Q?+7VgwLQIn3op38qVKggn6Hceski0WcSRrHl8uQKzFDVgL7Rfhcq+o0/CsQDF?=
 =?us-ascii?Q?Y+jL2RGNZ21Sa3FwhsAWWwKzxlY+jhsZkJAlM1J/1t+wFyrY92qbaWdSiyHE?=
 =?us-ascii?Q?oFKccbFw34j48CQ2Qotk6T3ZU+ce+2pDlPBXO+g1tWtDDrBUk0j5tCMhhTqq?=
 =?us-ascii?Q?kdqmRF38wavlCcwZCKhckpTBY7MHAAs7DS5oNCB3IFG2/uWBkasp9tVA77ED?=
 =?us-ascii?Q?jwz0PL9LMTAAIFIZ0SgZeIyk0LlJw7jeWeXlx2ItM9Fw16WzDTOl0whjK+vP?=
 =?us-ascii?Q?qCVvUweiz3szUFgtQhuLAKURBRT7XYtMWNtCZQZEmBXjHVa9oTQXA9uAqy/k?=
 =?us-ascii?Q?Hh2QK1REtZGwMqKsaWIcNR1VVKCuoKiLVBNP8pZeljEK1/JxJgQaSVNs6fj6?=
 =?us-ascii?Q?jt4Sj1Cis0MxP9b6NtYY/BNFsPzUC0WwwyVCNbZtYKREEO6IRs4ho2d2V4lh?=
 =?us-ascii?Q?mPQXsfnMZ3QwDeC086MpJ0Qu3ktjGcR/O7L+ctUfzIQP5OKEl4zzov5zPPor?=
 =?us-ascii?Q?u9tYnMO2T2+yyxRRooPz/GY4MMYSjNOXkfte5YkbIac3QIPyC4O8aQMwi0Sl?=
 =?us-ascii?Q?qrO5E2vAdq6hHmVfdiOiFhW1DI1312c9s4MH/6d5hr92vlg30HgkxA2OMXK9?=
 =?us-ascii?Q?sRRKQkNswtQVsYkBX1vbPjdBoNAy/h5Djp199DCY3E+vqYGO3BB09Drd8Ggy?=
 =?us-ascii?Q?9RX7YKsmKyVss40puE8zwjM37DJPzIaV52BxnOWGd9DiAFLrZmSHte+BDDD2?=
 =?us-ascii?Q?HWfCxCiNdcCwTHMZ0PkKXr4Lt0na5FY40OWmfiZn4V8JAtqzp5JOd8aitbxm?=
 =?us-ascii?Q?J6IhIe2bDT9cYvAFvAWqu9EhIKtFUgdClCeP2hxglDibuCtWyXObbZ+Rt+e+?=
 =?us-ascii?Q?yO7w9CYcywkk2SmXZMFwBk2brzhQ1I0xbpMNDxI4OOxToOIXp+z407+sRddn?=
 =?us-ascii?Q?jU9rU6m02Oif5SGDnfrkKkzDmsyY5ErRMrAt3qDyfDbzwH+jvgxHEmL5VyMM?=
 =?us-ascii?Q?efDWCFuEbyL/6rXhw0CtetEcmIGOhF14ybl7UG5m86zq+SNnkFgFaYoSduC8?=
 =?us-ascii?Q?pHKLAi0EsL5VTNpzb/2aN1wqJbl9dXTWAw/hnmQCUcBI6G3SbzUmWjWp3iWK?=
 =?us-ascii?Q?rpmAKgRABp6DPmTpG7niHszU6eGHLJuYEd/ZeD1G3SPeL2IGHKVLKpp5JKSS?=
 =?us-ascii?Q?LUbfBW7YdERz724NSCtd0s5coAvLvEBZ1wvMSkZjkaidZ9qewPl2oCQc3gEn?=
 =?us-ascii?Q?w3XJPzAqbqN+TlQto1bVN7qYRZESYmhnAVqeeqQntpydJ+RIdW0vhRnkImHd?=
 =?us-ascii?Q?hJF8TZnxJXLZMUj/hBYP97YUDudLhRJ3gvzLXnf3Ps0HAt67V/Me1HQMSLDP?=
 =?us-ascii?Q?HuMpiurvvInBYX1AiPU9CQpO6WB3/Q0=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FM+uFontxu3rxoka4VyFaUkeDeZ0jhptjEjeiKNDUu1t13iy4PHE5qIQhj99MH8IWkvHtsM1IKxe3e7C08185HgVcMyLPGec1OGsjqbIx3HZ/iKBy9iF0OyILLUEbHovpXGHvawaANp1aqU4h+x9FhZwF7eja1DRkYPjwltGCr71I/XR2mG8jWq16qxcwAqCFLlhHSozXymoXqeZ7WKBc417Gv9aBJ7btCCJtdBJMW2ti6m7+u8pxQREIFu+AjeF9u83oNNPWFprxmgpkkUd1UjjtiD4e+Hp3KYEjAihcQRWVoiDRhvT5vdsZy4o7Sbpi6GofSS7Enf5d3psrB4HDQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f5a404-cf72-4ede-1272-08debdb1eb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:38.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hHwAxpJ/L7m016O1hVI0Q2XuZBnNxip12kmSS4LNp0j27rfZuL4mK/CipJg1hh7EbHQ3qA4345SHddGsTmt4kP7rHE515oAk4475+iZmBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CjzTqaUeDASBkM7-cNQ3efWHRMJfDzj_a-R1XP62w2s_1780080102
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293209-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: C31CD607A57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Added new APIs to support hardware timestamp feature as defined in
OPEN Alliance 10BASE-T1x MAC-PHY serial interface specification.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 Documentation/networking/oa-tc6-framework.rst | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/=
networking/oa-tc6-framework.rst
index fe2aabde923a..9e6aff408a92 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -153,6 +153,10 @@ OPEN Alliance TC6 Framework
 - Forwards the received Ethernet frame from 10Base-T1x MAC-PHY to n/w
   subsystem.
=20
+- If supported by the hardware and enabled, updates hardware timestamp
+  in skb, when indicated by one of the three timestamp capture registers
+  through TSC fields of the header.
+
 Data Transaction
 ~~~~~~~~~~~~~~~~
=20
@@ -495,3 +499,37 @@ the MAC-PHY.
 Zero align receive frame feature can be enabled to align all receive ether=
net
 frames data to start at the beginning of any receive data chunk payload wi=
th a
 start word offset (SWO) of zero.
+
+.. c:function:: int oa_tc6_ptp_register(struct oa_tc6 *tc6, struct ptp_clo=
ck_info *info);
+
+Register the PTP hardware clock related functions with the kernel. The mod=
ule
+simply registers. Hardware timer related functions are provided by the ven=
dors.
+
+.. c:function:: void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
+
+Unregisters the PTP hardware clock related callbacks.
+
+.. c:function:: int oa_tc6_ioctl(struct oa_tc6 *tc6, struct ifreq *rq, int=
 cmd);
+
+ioctl interface to control hardware timestamp and PHY related commands.
+
+.. c:function:: int oa_tc6_get_ts_info(struct oa_tc6 *tc6, struct kernel_e=
thtool_ts_info *info);
+
+Provides timestamp related settings to ethtool.
+
+.. c:function:: void oa_tc6_hwtstamp_get(struct oa_tc6 *tc6, struct kernel=
_hwtstamp_config *cfg);
+
+Returns hardware timestamp configuration. Part of net_device_ops callbacks=
.
+
+.. c:function:: void oa_tc6_get_ts_stats(struct oa_tc6 *tc6, struct ethtoo=
l_ts_stats *ts_stats);
+
+Provides hardware timestamp related traffic statistics for ethtool.
+
+.. c:function:: int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6, struct kernel_=
hwtstamp_config *cfg);
+
+Helper to set hardware timestamp configuration. Part of net_device_ops cal=
lbacks.
+
+.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
+
+Helper to map MDIO_MMD_VEND1 command to vendor specific MMS (Memory Map Se=
lect) value.
+
--=20
2.43.0


