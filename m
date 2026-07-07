Return-Path: <netdev+bounces-305461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqQlMwb/TGrTtAEAu9opvQ
	(envelope-from <netdev+bounces-305461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:28:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0471BE5F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:28:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=PtYWSB+0;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305461-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305461-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29443120A12
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AD7414DD3;
	Tue,  7 Jul 2026 13:21:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBE414DEC
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:21:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430513; cv=fail; b=JF9srUMsmNJhfr2Y1A6luOJtdFOcjCe9V+B+NJHT5O1EHtzQ7b40i/2FWLP1je63osf1vzv4gtbEXMz6V63mS0SiCJMdoFipKnt62Izn+Q+Q3Dia9THihB6aG2P225wEinNYxg3SbnxRQWP6o02uirwhE3UCgAKluP5337XcT2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430513; c=relaxed/simple;
	bh=I+VpM0T6rPkVngMqmL5ERBH5s+ABIqtIG3FPh/frdXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NMNsJK+rOpDSini+MMLV2L6kStpfDkYz1SGgeFwzRnVOH9WqYSTXIzqoonCC1/P36bFr4PjSp7Sm/4uxTTdTtqbD/oeBkbiOgYAYk/d1ehj8eIu2O3a7BxfeBJPO+z9vQEzlg84MESCS70m34ug90sm7FjopzHOxiyFIN6gMAqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=PtYWSB+0; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc1miNMMrmzAiNPg4dQQuYaLvTrVnHHBxGddcPVibj8w+SeUxiD+bmsqSFCvV4kJHiThIc/jnDmhXjnWlVkeIkh8S9mleLy56noLkZYnhcWoc04ULvAvG64k8YI3LCAq4oL+bwJ6gpkLFVbxpIitFrwaaRFMDtDC+J0B9veITWfK/wZlTwU6rFIxDkIpufK1AKomsaOI+bKlezQsYZCs4NvJQ1UVKHIS/LAEoVqP61Ek2r7vf0vHjFp5eExuwWceLtlWsdQfu5mjOirA9UVfNUD9kSsAhmzx8auVCJYTAtGj41+A6GU540QFqMNz470N6GkKF4E3mMP1q9bNbg8KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNarSVDK/LHLgqbOxUEvr2K1HJMzfxXpF7uLeLZJ30Q=;
 b=wW5hH7GHxIzvBwdQZJnzw2YD5zK7fwgVj/AI2EbyOwclI1gcGc1kpstphUZRIFSTc1UI+1FarrcljGu7y5vmndcc5+k6kyZTxEKUoprkLBWX23GZY1gQfkQ6K/tZaBDBfVNjuey240gDF/Vn1ZZZu8KXgvKxAexIaBSS/VZ1Y/PqKm+OKD4DCDfBzXySEy6xiwkQyBG/lLLGtB4+CMRZm/iCvSI/BdYCcKt8RKLqdHM7w/F8RGrLaIemrRtH/ZN1AnyJHx0ZPuWmcPU0G7zkKXcywH3TpVe+6/uY3lIAe62haNuYQzSpVjuFF1K1ivBb0U/PYoTsDllueRCRd6RkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNarSVDK/LHLgqbOxUEvr2K1HJMzfxXpF7uLeLZJ30Q=;
 b=PtYWSB+0njjCCE+mHODv68bbMUDu+JWlVAxOKOQFwR4q/3lwapFxvkUPAWXU/atptB/Ll27lHHFyTJeSAmah6QTaF0Szi3M0Lay355DpufZAng3CzdXP5O5PGPQkSmwLB9vKLhSuB+O9ywapkO5fo6o+/adR+jzMV7+RoimQm1nZpJ3+OjsWCnCtEzIyiQOZsyqg7EETeNgf8kVxrg5Y9F09imIQ2B7JKf2Oo0Waolj45EiElJnFqZsH/eKr5LBROqKJQPQgh0+i1R+BTN7CxWmo7QTf5VH4OMQNybKBPlq1+anUsqRyLV2tNKF4tZwQjxh9qIP9HbKPP/EJLuqzYQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GVXP189MB2077.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:69::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.11; Tue, 7 Jul 2026 13:21:46 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 13:21:46 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Xiang Mei <xmei5@asu.edu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: serialize udp bearer replicast list updates
Thread-Topic: [PATCH net] tipc: serialize udp bearer replicast list updates
Thread-Index: AQHdDV7Qgbp8iZbH7UaQICm4XbdYULZiB9SA
Date: Tue, 7 Jul 2026 13:21:46 +0000
Message-ID:
 <GV1P189MB1988C48DB0AA286E9DF62789C6F02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260706134716.3879-2-bestswngs@gmail.com>
In-Reply-To: <20260706134716.3879-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GVXP189MB2077:EE_
x-ms-office365-filtering-correlation-id: 6eaa819c-3566-487d-5f24-08dedc2ab1b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|38070700021|11063799006|56012099006|5023799004;
x-microsoft-antispam-message-info:
 FgskbLvzgc+xu9Uy/86gg3NHxerVjiRIapaVkTvKZ9KPDz7TJRsdaOfdNRsXhen/6tEEiHaJJ3b1olCw3+znJXRG+voOIOncwdlVToDg5vupZ53mwH8BSU7cOFRvow82j2SC6hLTiSng+pBA85cqB++c/yKVcwzneWKx64ydRlVwNRbUd5IiPqSP/pleKEgjxMq5L9wO6TO/k8OfWjKEGVwJKyHUi7IMq4TATXOxHSwYl0a3Ci1FfFmaqfQzh3RsR3r4WeHorZuziaSaWrRk5PAvIRpU2PH5nO7rfFv39y/314ljplE2AmOWYDoXIQn/S05TIzAFBh3oZjIZIO8i9IrbXEQB+AVQ3lp+hvRifTtAGZ7W7mZf+VgPKSTpPE8tYljGMiBj4muFIHoGv6UAXpLHKqzoDqtFCGm5XAtT2qZ58PLtecVs913XriP+kjVKGpeLh/2Zn+Yh5XZJjPlIjAOuH0Us8cEVwNI9/RNx/giQb23roHNjTU8gKMHIhLL/ukxwl2VToufQVvECfdxas20NqdxmORmdo3V+84qiVt6NA6rOMR/ApxEDdQQzceJWAjvmZuiQyN5QoeRthUEuy5C+D0UpFPus4fAgdMBcKLs/UCmfeu6XuHdTPjuzAC8b/sQRqmhlxN4BMpfZEBWT3hrvuKPWrMJQX58cVJshXVF6avWMltcAtKbZ13PAfIMii17CviLtPojPNU7PFf9b9f2aoeKIdUecRu2RY5jk8H0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7zBYJ8Bd59mEozJPu576uouApPIhQoYmRYcjxG6z3UuJ9IJDGCKZxkslY/BK?=
 =?us-ascii?Q?+A/pd6kspfeNvYoSU/RkMA2Z415hh+IiMRyoYWJDlKJcrL9uNaezpphI83oU?=
 =?us-ascii?Q?wqPTXw7k4wUWM9JdovfJ6IpOk8wIlsEie+lXTu7kuyUc9hgedYVuwGe/emN0?=
 =?us-ascii?Q?ZPSWto5j09aIARJxKyLFgmseVW/Q6VW3SuBxoRpYRi9PJ5M10PB0baDlxhkQ?=
 =?us-ascii?Q?w5KfWkohi2fsNbLlV1rKad2wxeN2GWrT0YXtvkB+yelY1s8mqQg9K9ER1hT3?=
 =?us-ascii?Q?bhay5N+6ApjXuAIaNNWtii04x0vwn6Nn6bFRXW3iVt9gnaTTXSeK1udcF+nl?=
 =?us-ascii?Q?rRNR0m3gxiVrq8X4FksCuV4+ntHkWtzjd4/ERm+7icEgT0b7n8WltgeEv3p2?=
 =?us-ascii?Q?QqIdprVHijGaKs1qvsN8RCjoSU3IGRayHn7tys5RQhoy9g7LpaGsIEUf1kBi?=
 =?us-ascii?Q?FqZ3ZuvoqaCN+3AojZoc3p5zM7KKafBQGs8Vw+NyQH3qo54G/t+8CCQgvyRi?=
 =?us-ascii?Q?o6kAwtwDE1ihVTqITcExckhgdBXp4okSA9o5sHBmhmIy4fOr2htKYg3hvEgS?=
 =?us-ascii?Q?+kHJTISS5rr35P7Er7fS1JcLPIPhBIpImcZsQoT3mR6+bSuU+MeWZkGaYcGK?=
 =?us-ascii?Q?u77MtWlUZ3H3HnfkqQ4GruvQT0NZhubAC0wcb2oSHGICB4KgRgEuGom82rdk?=
 =?us-ascii?Q?z4N0Xt+F36LPl9qXTqT60alLU/d5b2FCEt3j7JN883MN602XLvWXXeJ+iwAW?=
 =?us-ascii?Q?A30/u//szlrjNhiwCsjekb+rACAX1idAIgLUP5kustMwvZusZ1J6iU1ow6tz?=
 =?us-ascii?Q?bou9X9M7y4xyaXnISUBT8Y99goJIz740d3mQX3LDpCuO79z6l8V4bIR+iQ36?=
 =?us-ascii?Q?scGV1QMv1noOM6z4zXUpX7Yahq92wI0irEivMmBX/rjzj468F5NCsnNs10ZD?=
 =?us-ascii?Q?kTRpWsJ6gbNHZWGuCdyqq+w7p2rjoesv0jzBoCsunhE8uRjpFY0PdvXpKQJf?=
 =?us-ascii?Q?RyNvVSSlCgJs4nzg1q2xoExpG0cBeh9DvwrmDp8Vjhh0U9ihSYa0wgr+EKvn?=
 =?us-ascii?Q?7aa88GWUGgIVCErhDZ1mrdEyIaGLDB6iWx/UY6iWnLab23WWqHbuw55FVNFY?=
 =?us-ascii?Q?MboPUmCuQsREbEgGqjrUxFNL/r3Zq+eqVpluQYak+bULB0mqGR9j/PZymiLa?=
 =?us-ascii?Q?wue4pc/snis003K3q4zWS2+c7l3sAOLuuWtGWKy/KcSQFumwCqeIqEVeNIkF?=
 =?us-ascii?Q?w0FdqoBEMcQ4O+ba4sh/kgeowAflLZYsxKQfOcCSwYLlEjS0krTwHSfingoe?=
 =?us-ascii?Q?2aWs5pOCLlx3OJQFiRjQcpKuhejJ96uUpavpTX7TFqA0C1t7mNVBXrrzdsgi?=
 =?us-ascii?Q?3rEfjoePonpO4HErCUWjdExmMFLJBbnubTn+SyHflc0Gt7rvegWp6Wxedf/y?=
 =?us-ascii?Q?NlakeS8Felco+E8CKfUO2IR6YJ3AxNoB5HTqaX9AxZI/MQGshmUk0iDX1SYN?=
 =?us-ascii?Q?a7lABad2wtNm/8qnzzQacnOyara0RhJU0E9cBXxKIiq8DPDSUhRZoqUQUjb+?=
 =?us-ascii?Q?fjrWKzja9EbiLntdwFQ4Yb/EKjhvZGAdAgXZV3Gqeseg8Oo4XnL0TLFfSUJj?=
 =?us-ascii?Q?+EPcdhtysm0a3tle6lvArW1o5TEGbRcfw5xxOf+QJYtmCC0b9MH+WXQWGLLl?=
 =?us-ascii?Q?eShbMXzQDHEtvl2JavMkYDDXez5ByDhaPkg9MnAyYeGro7TEQ7INJtlvW8Wm?=
 =?us-ascii?Q?JuPKWKSCwg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eaa819c-3566-487d-5f24-08dedc2ab1b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:21:46.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAh7cwNKMOhpgIOe8ngRdWULXR1GSfEzBV9kXXHGKqgo4Xti4sKDjcCU+ldcOm3sXdz17NqPLWw+ov4Uf3/pH+iOqiImdgADF30LtdmiRMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:xmei5@asu.edu,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-305461-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid,asu.edu:email,est.tech:from_mime,est.tech:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24D0471BE5F

>Subject: [PATCH net] tipc: serialize udp bearer replicast list updates
>
>tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
>list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs=
 from
>the encap receive softirq (via tipc_udp_rcast_disc()) without rtnl_lock(),=
 so it
>can race the cleanup delete and corrupt the
>list:
>
> list_del corruption. prev->next should be ffff8880298d7ab8,
>   but was ffff88802449ad38. (prev=3Dffff888027e3ec98)  kernel BUG at
>lib/list_debug.c:62!
> RIP: __list_del_entry_valid_or_report+0x17a/0x200
> Workqueue: events cleanup_bearer
> Call Trace:
>  cleanup_bearer (net/tipc/udp_media.c:811)
>  process_one_work (kernel/workqueue.c:3302)
>  worker_thread (kernel/workqueue.c:3466)
>
>The bearer can be enabled from an unprivileged user namespace, as the
>TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.
>
>Add a spinlock and take it around both list updates. Re-check for the peer
>under the lock in the add path so the check-then-add in
>tipc_udp_rcast_disc() cannot insert a duplicate.
>
>Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/tipc/udp_media.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
>62ae7f5b5840..601174297a16 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -94,6 +94,7 @@ struct udp_replicast {
>  * @ifindex:	local address scope
>  * @work:	used to schedule deferred work on a bearer
>  * @rcast:	associated udp_replicast container
>+ * @rcast_lock:	serializes updates to @rcast.list
>  */
> struct udp_bearer {
> 	struct tipc_bearer __rcu *bearer;
>@@ -101,6 +102,7 @@ struct udp_bearer {
> 	u32 ifindex;
> 	struct work_struct work;
> 	struct udp_replicast rcast;
>+	spinlock_t rcast_lock; /* protects rcast.list */
> };
>
> static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr) @@ -301,7
>+303,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer *b,  stati=
c
>int tipc_udp_rcast_add(struct tipc_bearer *b,
> 			      struct udp_media_addr *addr)
> {
>-	struct udp_replicast *rcast;
>+	struct udp_replicast *rcast, *tmp;
> 	struct udp_bearer *ub;
>
> 	ub =3D rcu_dereference_rtnl(b->media_ptr);
>@@ -319,6 +321,17 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
>
> 	memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
>
>+	/* tipc_udp_rcast_disc() adds from softirq without rtnl_lock(). */

Remove above comment because it is vague. Caller of tipc_udp_rcv() already =
holds rcu_read_lock().

>+	spin_lock_bh(&ub->rcast_lock);

Move 'spin_lock_bh(&ub->rcast_lock)' to above 'list_add_rcu(&rcast->list, &=
ub->rcast.list);' because only 'ub->rcast.list' needs protection.

>+	list_for_each_entry(tmp, &ub->rcast.list, list) {
>+		if (!memcmp(&tmp->addr, addr, sizeof(struct
>udp_media_addr))) {
>+			spin_unlock_bh(&ub->rcast_lock);
>+			dst_cache_destroy(&rcast->dst_cache);
>+			kfree(rcast);
>+			return 0;
>+		}
>+	}

This is wrong because the code in the loop is never executed. tipc_udp_is_k=
nown_peer() already verifies address duplication.
Please remove above code and fix tipc_udp_is_known_peer() as below:

static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
                                   struct udp_media_addr *addr)
 {
-       struct udp_replicast *rcast, *tmp;
+       struct udp_replicast *rcast;
        struct udp_bearer *ub;
=20
        ub =3D rcu_dereference_rtnl(b->media_ptr);
@@ -292,7 +292,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer *=
b,
                return false;
        }
=20
-       list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
+       list_for_each_entry_rcu(rcast, &ub->rcast.list, list) {
                if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media_add=
r)))
                        return true;
        }

>+
> 	if (ntohs(addr->proto) =3D=3D ETH_P_IP)
> 		pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);  #if
>IS_ENABLED(CONFIG_IPV6) @@ -327,6 +340,7 @@ static int
>tipc_udp_rcast_add(struct tipc_bearer *b,  #endif
> 	b->bcast_addr.broadcast =3D TIPC_REPLICAST_SUPPORT;
> 	list_add_rcu(&rcast->list, &ub->rcast.list);
>+	spin_unlock_bh(&ub->rcast_lock);
> 	return 0;
> }
>
>@@ -679,6 +693,7 @@ static int tipc_udp_enable(struct net *net, struct
>tipc_bearer *b,
> 		return -ENOMEM;
>
> 	INIT_LIST_HEAD(&ub->rcast.list);
>+	spin_lock_init(&ub->rcast_lock);
>
> 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
> 		goto err;
>@@ -819,10 +834,12 @@ static void cleanup_bearer(struct work_struct
>*work)
> 	struct udp_replicast *rcast, *tmp;
> 	struct tipc_net *tn;
>
>+	spin_lock_bh(&ub->rcast_lock);
> 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
> 		list_del_rcu(&rcast->list);
> 		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
> 	}
>+	spin_unlock_bh(&ub->rcast_lock);
>
> 	tn =3D tipc_net(sock_net(ub->sk));
>
>--
>2.43.0
>


