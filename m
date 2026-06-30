Return-Path: <netdev+bounces-303243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e52PE6rWQ2qhjwoAu9opvQ
	(envelope-from <netdev+bounces-303243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:46:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A16E58AC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:46:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=acRZwUkm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303243-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303243-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 212C83061DC6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A643C069;
	Tue, 30 Jun 2026 14:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC140E8E1;
	Tue, 30 Jun 2026 14:41:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830472; cv=fail; b=iiKDTBldZ7gFTii/zZPydjyes+z4RlW2YnrRydijNFK0K+uB1sGhhW26In7KAL6QiDKOWbyRKUtZyXMAbjY2htwsZmmpxt4C8PfFUpVXtlc1YXT69x3d9gTTa8jvE/TCZiMjMI6nqUcquw0bHzJkW5K0O2CqwwmDYVooXvk76h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830472; c=relaxed/simple;
	bh=+3kKEATX3ESUfYh83L64zEzCKirDJE/Fecti6Iuk+y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bvvSt0tOeciL/IQ0sJKagN+/DHShrN9ifXdqnGIKaxyN1lXlQsRHVrgkmRYA5YoP43+2++r2JVpKsdl9+TLzo+5ThliPVD+upVgTe/kpR6djEnbEQz8m7o6zo6jQSUH2nqYcEByRWfySWyKRd1lTE+D7AH0qPAeklMua+K8Pv/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=acRZwUkm; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdAMwtByv6kFe5zjV6jU06yhYl7QunY5Qr7bxqYgN+kcCkrfcqEjd8LQCLBs7Ft+DUgpXWSTlQDIHOG6Mfe5jbz2wkbofYXW4ZGcY043MNINeE2IIsy7A87iLBcrgKgPX8B/itLSQmui3gQfJd+5Bk/ObxweiEgInVQJkxLtX2TQFvS2EsJQxYjgBzH9gUlaZ6K7kaPGfAT2pNhan9hMVu9PaI0Zo2q7a6mtBRbul9738o6zfTeDb+GwnNCfLaGa9dzW78XelQEDVSpnnBKdLZZujFYLUxA0moh6/pbX/s5/3Nggo/zJxT6QML4V6Ew16Ba/LI4hNocpVB5fKiR9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC8664PbmJ1iyN2lWGeAGQ949kb4PsjwnkV3u7iQS60=;
 b=HWo/ECznJrB9YdHsbXLG3vkJmZXU82VBckppEVGHM5LsdBWhMs7IRhoGjGzNMo+cdOv4KvO+uHihXXZvAh8MrDM5bhmaJFtZArKcINhSjzBsOLOyKsIolhHIN1dSYlQlrdIdNHeVtsTInJdoBQQtON6ASC8i33y/EoGmQs4KTLmONr8F02k6QE8lN4b950B77ewDq0cQTKyS4KLyX4r32N10/I0IF7Juatzy0YPuJA92YrGEX3ztF9t9xa9BdIXQU/acxhI0WkI7MQBy+RrBPndeJAt3ANJ2OhM1Q7ezA8aNG3u/5pWks7Xq3gcBXaclwJe1SyubhjnaX0q8eYMtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC8664PbmJ1iyN2lWGeAGQ949kb4PsjwnkV3u7iQS60=;
 b=acRZwUkmBAXuhf9SFg2RWxU+eDZUN55NZcGGOFExYKh9PLqKyO9IVwOf+fVdWJ8DHaxANKla7+1ZHO1e3WJ36ONnYlSHwN1nTv4qoDB+TAp7q/K4CPcUts6x6Mgt9sIOC5qwpq4J93wKj0n0udKuuPEBaaWlm+nTiLG3NEeS5GRTATwwKHdlmPKbQ7dR3JzspkzUA0+3w0z2W32zUwXpAofRnxxC8s/U8brpBBvm5CIF8bzqb3kPjNGj2JsbTFU2JCbz8rLU1BBikQRcMmPnM0zk5zCzi/lEFgLZrsfk8kzHFJGGskaAAEaRhP5Yx4P8P+u8X1HLDpIMx/8e0cTKSw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PA3PR04MB11178.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:41:07 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:41:07 +0000
Date: Tue, 30 Jun 2026 17:41:04 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 10/13] dpaa2-switch: offload FDBs added on an
 upper bond device
Message-ID: <mgeidxs6f7keastn66rndkli2gqiwwgvhnq6h7hsifuhvc4jzs@ilxiosephsow>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
 <20260629112309.154328-11-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629112309.154328-11-ioana.ciornei@nxp.com>
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PA3PR04MB11178:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c8707a-e04d-494e-3fc8-08ded6b59ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	o/NQY9sw7ci7bwXOOP2URzCpLY+ryePAWP+BIx2L6/9qiGKdn/B3YSSC6W0xeP0NmhX/gpRaaXo6UEtHu+RcHIwcgpz97psKFfuX8yuVmG3j9KT3xoaeHIMT3iOZndBNEocHJ4AjyoyUnTjks3W9vGdZ5qyZBjOkCVgM9v8WZ/EkZ9MnenatQ4/XS3q8KYivf0lTGcLZCR+13GDtiO3J6RIEgupiIaWUDGF7E+m+ObUiYi+oeI5ZLRuH8XDhz7RtkR15PyaITyYVVoLRcl8KUPg/CcfGzwJ96gD+2UYGD+aSkwd+rVcdj7n8z8evOlqGlNdCyoKQi4J3UpqJ+/J/du95xkwnisa0JOgE1RgboGq9os1ASdJ7KDm9pL9YJ+OFEzSVZWrM5AsDQAryJp0sIPayRDw/HjRAKwHX/OSYKV5lSUKrKdgDcFotQ0KX5LTrl/eI27fr2Mva6WdWziqcwb8m3vj7jP76OLGK+lMUqADvDszuFN+ZABHQC8iUQJU024uty4Cj14Y4Lp5EVgom0J8d0wkj1Iz7fQo+ReXb/i4Z3YG8LbKf2YTb3BD18gU1PlQMedSRdj4lcTJUl2GAeLh4dIcq+QoX5e02z123iJd2/yPQTOOrMuJfTXGnMQTDzAbQlUuxI67FY6ZoteVEZMDxWwtaQm4qWC/dg5GtldtDQXFqQAfpWm+bjp6qE6TcbyMNKjlqhhKBc/Przarijw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DolHoaZAcIOS+sktvKl1PfX9CSgVMLoJnYewpXxXxexLl2UG9vu4AAhIdIOa?=
 =?us-ascii?Q?GY7yHSZ7q3/Be0j+N1lYUzUltiVsd6EElJ0u7jggXX22dZtC3uukwp5r2guS?=
 =?us-ascii?Q?Py91PDZohXDkRsHHL2IDAnqgrvCJoZHooYODQroKF521fH4wXlwuGsWlqv4k?=
 =?us-ascii?Q?GMsGeAdKePRtbQ5gi1GFI4siZFYECrYWt70KhNQoIINrlwaiyftObCiHOAUR?=
 =?us-ascii?Q?sMbIrK+EHTyovNoOmCFaB1yN9IMfGhvEhA2vMHC48J1esYgkqCVM7SBoyHS7?=
 =?us-ascii?Q?QvCrq2w0ZWkcj+yrEQVg26UPfJtue3Dnr/uCyPkQlV7mByCKRA3myCiykmh4?=
 =?us-ascii?Q?Bqr+OL1zDKcPJyL6OKuF5/kSkn+EZn/6H/K0kMMYJ9H5mctmYWFDuoUX5KIg?=
 =?us-ascii?Q?9RWEkxNVXvFSjTch/OdWjYG+qOAmhOsYPH1nBV8ptzHk8EVu5DVPq4S2b0vr?=
 =?us-ascii?Q?2p1u/MKh+3VGTrAOOeOyHAbb7oHdPV4JlZvRmwGEW8XIv9QwiT1Zch0p3iIX?=
 =?us-ascii?Q?uEpsAAZrhnA3uBnyuV9Ekwo+MQTUjyVEi9xMO2occbEeGSHMdvMxVb5h3m1z?=
 =?us-ascii?Q?zpizUmKXLm5tdzYYvxukBTpiWp1Lu2sehnfxGnxpJfldcqMwACG3foYhebpF?=
 =?us-ascii?Q?SXhT4Z/gqsxBTke92Yndd+DROvOT6YpqPa6OmXndbAhKhjrMZU9+EJxG/5KK?=
 =?us-ascii?Q?7ZAba/JqDFUpO44R1HRLPgEvDpnq8VhrupyIirK1Xf/W4y4SGcqZumW7NqA+?=
 =?us-ascii?Q?Of/Y8OxPdd5aTPHjcO+ZEtMvcHxo47xgvAA0okMJp7J7GiWkSu9+gcvZRJWS?=
 =?us-ascii?Q?TfT0jnijsSAMROGmAJIalyEsbWKfNQAFx/37Z/VpKbNWF0dQF1NNBSkGX5FH?=
 =?us-ascii?Q?k0Jf2u07OrN4oRJ13Qx8XJmlrbqOlMzjl5aF95hQl1DNCwUzvrhFLJdAVUpp?=
 =?us-ascii?Q?qGA9J+vSszBaa4aDNNkc+WSi9OG3WlVWUqYUf5aUFRVzp8tj2/MdPqO7IUI2?=
 =?us-ascii?Q?MH0BbyGtxCdqCov61LUoDzIGXg+C3cUIahT/HR8LOfG9rXcHLkm00cIEOsDT?=
 =?us-ascii?Q?9ZCcct0RUWg9DdZqY4tL5N+7eguEZ+8iEJn0Nt8wr4BKLitTCeyFTQOSCFHX?=
 =?us-ascii?Q?nughZ5HJyuhFax7gIhGoOGVIzMhS6nC149t2KQ+sT+azAbIfYxj3bgwUsc6P?=
 =?us-ascii?Q?CtBWDvEyki38xRHKPqg+vc78M+EJpfjjE3HlnQG6mDsGdcuRy54TluUYDc7V?=
 =?us-ascii?Q?jtsKfRfTMUfHrIy5/gPbdLH/LqpcSiMyPvqrmtL8gn7cyeMKUcU2RBNowWRy?=
 =?us-ascii?Q?/RZJmhlidsZ13gt/+ccwI64Zin2DzhlzSMqJUnJ52gtbu92IKJPyYGNMcx9O?=
 =?us-ascii?Q?RfguXpfdgiCNePBYyTjnhGcB2tUCTNF+aUXU6K5FmzuKsJhHGLtMDCp13TjK?=
 =?us-ascii?Q?zDJIrsT3ewTT0E6KhLNJkiJb7uw7WsuyAlRx3BziwZeFOr2OeJp2+d3Nx7VV?=
 =?us-ascii?Q?0G7GKO4t1clTz9f1k8ik3UQ9kTFWg7YOC1dkpxCxxX/CA6OyOWeHG4JsXjkm?=
 =?us-ascii?Q?4a11o4cHyEd/gIxCKgCq0dtFBmAkHKxSaSVI55Xye1baqpCXKs98qfO0zf6C?=
 =?us-ascii?Q?E0+eCM+4ip+mGWoAsKM+RgUwqu+ZAAG8J3IIDjphy9yoHtC7IcZOI5g33wKd?=
 =?us-ascii?Q?Q/MuqFoDvCC3Cx7M236Q4ecBT6X25iQO6kR5UW/+PIJKDkwRqoKFPm1gUNup?=
 =?us-ascii?Q?jUcAV/ZrAg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c8707a-e04d-494e-3fc8-08ded6b59ee2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:41:07.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iwtpqm6zEkthSQHGPsRW0xJXWciqv46c+9hycHZE4+97SXUpEH/l1G13/BTHeuhAazENeT4FhkD2VtiQ7asvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11178
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 989A16E58AC

On Mon, Jun 29, 2026 at 02:23:06PM +0300, Ioana Ciornei wrote:
> This patch adds support for offloading FDB entries added on upper bond
> devices.
> 
> First of all, the call to switchdev_bridge_port_offload() is updated so
> that the notifier blocks needed for FDB events replay are available to
> the bridge core.
> 
> Using switchdev_handle_*() helpers is also necessary because each FDB
> event needs to be fanned out to any DPAA2 switch lower device. This
> triggers another change in the return type used by the
> dpaa2_switch_port_fdb_event() - from notifier types to regular errno
> types.
> 
> Handling of the SWITCHDEV_FDB_ADD_TO_DEVICE/SWITCHDEV_FDB_DEL_TO_DEVICE
> events is updated so that the newly dpaa2_switch_lag_fdb_add() /
> dpaa2_switch_lag_fdb_del() functions are called anytime a port is under
> a bond device. This will allow us to manage refcounting on FDB entries
> which are added on the upper bond devices.
> 
> The DPAA2 switch uses shared-VLAN learning which means that the vid
> parameter is not used when adding an FDB entry to HW. The current
> behavior when dealing with FDB entries with the same MAC address but
> different VLANs is to add the entry to HW every time while removal will
> get done on the first 'bridge fdb del' command issued by the user.
> 
> The same behavior is kept also for FDBs added on bond devices by keeping
> the refcount on the {vid, addr} pair while the HW operation disregards
> entirely the vid parameter.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v4:
> - Migrate FDBs in case the primary interface of a LAG changes.
> - Use lag->primary instead of determining each time the primary
> interface of a LAG device
> 
> Changes in v3:
> - Update dpaa2_switch_foreign_dev_check() so that we check if there is
> any port in the same switch as dev which offloads foreign_dev in case
> this is a bridge port.
> - Add mutex_destroy on the per LAG fdb_lock
> - Make sure that all FDB events were processed on the workqueue on the
> .remove() path.
> - Delete the refcounted entry in dpaa2_switch_lag_fdb_del() as soon as
> possible, even if the HW deletion would fail
> - Access the port_priv->lag field only through the proper rcu accessors.
> 
> Changes in v2:
> - Update dpaa2_switch_foreign_dev_check() so that we check if between
> the switch port and the foreign net_device is an offloaded path. Before
> this change we also checked if the foreign_dev was offloaded or not by
> the switch port.
> - Update the switchdev_bridge_port_unoffload() by passing it the proper
> context and the notifier blocks.
> - Add dev_hold() and dev_put() calls for orig_dev
> ---

(...)

> @@ -2454,7 +2564,6 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
>  	/* Build the interface list, always placing the primary first */
>  	if (primary)
>  		cfg.if_id[num_ifs++] = primary->idx;
> -
>  	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
>  		port_priv = ethsw->ports[i];
>  		if (port_priv == primary)
> @@ -2477,11 +2586,32 @@ static int dpaa2_switch_set_lag_cfg(struct net_device *bond_dev, u8 lag_id,
>  		lag->in_use = false;
>  	}

sashiko.dev notes:

	Does this leak the dynamically allocated items in the lag->fdbs
	list?  When the last interface leaves a LAG, lag->in_use is set
	to false here, but the elements in lag->fdbs are not freed.

The mechanism initiated by nbp_switchdev_unsync_objs() will remove all
the lag->fdbs automatically without the need to add extra code which
frees manually all entries.

>  
> +	/* When the primary changes, migrate the FDB entries from the old
> +	 * primary to the new one: remove them before reconfiguring the LAG in
> +	 * hardware and re-add them on the new primary afterwards. We do not
> +	 * touch any refcounting since the intention is to change the HW entry,
> +	 * not the parallel software tracking.
> +	 */
> +	if (new_primary) {
> +		mutex_lock(&lag->fdb_lock);
> +		list_for_each_entry(a, &lag->fdbs, list)
> +			dpaa2_switch_port_fdb_del(lag->primary, a->addr);
> +		mutex_unlock(&lag->fdb_lock);
> +	}

sashiko.dev notes:

	Does dropping the fdb_lock here open a race window for leaking
	FDB entries?  While the lock is dropped, a concurrent
	asynchronous work item could execute dpaa2_switch_lag_fdb_add(),
	acquire fdb_lock, add a new FDB entry to the old lag->primary in
	hardware, and append it to the software lag->fdbs list.

	When this thread re-acquires the lock below, it will loop over
	lag->fdbs and add all entries to the new primary. The new entry
	would then be programmed on both the old and new primary ports.
	Later, a delete operation would only remove it from the new
	primary, permanently leaking the hardware entry on the old port.

The LAG primary changes only on bridge leave which will not run
concurrently with any workqueue events since there is a
flush_workqueue() in the pre bridge leave event.

>  static void dpaa2_switch_event_work(struct work_struct *work)
>  {
>  	struct ethsw_switchdev_event_work *switchdev_work =
>  		container_of(work, struct ethsw_switchdev_event_work, work);
> +	struct net_device *orig_dev = switchdev_work->orig_dev;
>  	struct net_device *dev = switchdev_work->dev;
> +	struct ethsw_port_priv *port_priv = netdev_priv(dev);
>  	struct switchdev_notifier_fdb_info *fdb_info;
> +	struct dpaa2_switch_lag *lag;
>  	int err;
>  
>  	fdb_info = &switchdev_work->fdb_info;
>  
> +	/* The lag structures are freed only from dpaa2_switch_remove(), which
> +	 * first flushes this workqueue, so the pointer stays valid for the
> +	 * lifetime of the work item. Only the dereference needs the RCU
> +	 * read-side lock; the FDB helpers below can sleep and must run outside
> +	 * of it.
> +	 */
> +	rcu_read_lock();
> +	lag = rcu_dereference(port_priv->lag);
> +	rcu_read_unlock();

sashiko.dev notes:

	Does this sequence leave lag unprotected against concurrent
	teardown?

	By dropping the RCU read lock here, a concurrent call to
	dpaa2_switch_set_lag_cfg() could set lag->primary to NULL and
	call synchronize_net(). Since the RCU read lock is dropped,
	synchronize_net() would not wait for this work item to finish.

	If the work item then resumes, dpaa2_switch_lag_fdb_add() reads
	lag->primary locklessly:

	dpaa2_switch_lag_fdb_add() {
		...
		struct ethsw_port_priv *port_priv = lag->primary;
		err = dpaa2_switch_port_fdb_add(port_priv, addr);

	This would pass a NULL port_priv to dpaa2_switch_port_fdb_add(),
	potentially causing a NULL pointer dereference.

Again, the flush_workqueue() avoids these kind of concurrencies.

Ioana

