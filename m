Return-Path: <netdev+bounces-252230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIOJAPXTcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:38:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D596294F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFA050491E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061848B371;
	Thu, 22 Jan 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="C1/2o/8X"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548B48A2AB
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067135; cv=fail; b=qqezIdqjnAz0JHSz09HXY5BKu7B/qajtGNuPN2ZtmOGO2h1GcQXz1rqazo9QnL3HCuCRqKoqLPMMXK9CnVt7dK76ZoOnAN3jLUMgwTCC9w6MMTIdDQjrvU1DnDa0e5o2W/sJHdrC86brVzqJdq24ztM1iyKs6VFKl2AZ67oy2nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067135; c=relaxed/simple;
	bh=2bYEXdmLG7RKnXZEskXtpNPqVuv1zNdQyWuCMT/CfJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHZ6pp4KQKp1IIlKSiYg/6cE3ETdJFnNQW1yCGMv8i05BSBo+84VOwEyMQZ2Jy/V7xnS75DCvAGkAiP8GsMD5sB/gFzrzM14UUFLK8QXeFjQphwDkeDphqCe3xy+uBkXls5fT3mUVX8f0lbFEammrkcNW+qM0TplB3pUK8fiwaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=C1/2o/8X; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VleXAkR+DrFBJb4L13Q2YGIzJS7X6scI42OCt5JsbMdlX4m59XUOWsRLfKq2zJTTBzpMb8rzRuT4nGzD6HTGAfKqdNewY0srVq/M+RDsl+vSG5wpBqRyW7YplyntXPPvo6cA4W5C6sSpmhcNBBwjLWLEa2S9+nNaddK6oXD1vVUafVIYa7Nh/vIpYRaYL/rb86dUpd7ZWTcjnK5KwmNKNckggC7i6XRdat0sxUpwRJrNJZ72DRTKjq/5xOCAohPY8LRsnNsURZuil3D9rbNFyIbcHJwa7xpShOyAMpnmUUtQ2R/HcY3Zt3fOnJuNNkRdX5DIKLWDb5X/6quKBfQOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+IdR30lUeWYRH9XBE71ezJ0f4FJDXi9hlB2YE4pkqQ=;
 b=hpvPUMHSptSlasanQCFoeX7IauC23HTOC+aT6uF/sX6lgY+CyQ5dNnJyHe5dtEYyFUkhdxWqTVDHxUN3J9S5gGTuPGlKflq8jK9CI/j2wIY/AnJ6dIOrTFL9hSiCCY2n6qPTIXWXjZvjXvozSe1DZhziY061z10p9MR0yL15lS4tZ+RkLlgVxvDNqla4CWzFrgXBDWf3BuB7rQv/0VmI0OTVZVqy2piOeJsPtgDdJqu+goMJw0TKWdR9Ams+acut5z+E6syW5LQKnlVGhG0oT7VXAERSeGzpDVaCiZLvHU5oxsqpKCj1X2vMMu7aLQTLQKTI9L0UHwD8R53jD66TQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+IdR30lUeWYRH9XBE71ezJ0f4FJDXi9hlB2YE4pkqQ=;
 b=C1/2o/8XNkYBQ4JWAaZqJtiLCU5AGdWbCJ6PzIOs8ab2alIKWcC+sIauWShINTGdo+DcbZzyBsECq4au+5LlIZJV/WuFZvfBJH9z7lW/9di9o7purrPv0OiAZPzlSaNLQZgYAOb+GaYLq5SrWy7hJxTOfh/vVTeY4zL3HCkwXdDc9Ss6sd60Tee461H6AS8NZl+6GY8e7Zt/CrL7MwbfSF8fVznzMccEj+fqr/eHI3fS7AMLeuLP/gT9MoO27jdaQ6Jpb02Pll8Abl+hnYYdAU73GWeE9DR0INxuqHAiFYkKhlTr5IIg1JcrJHNyCwcWavOrawNIqgKfeXdqCnCSJw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by OSNPR06MB8306.apcprd06.prod.outlook.com (2603:1096:604:46e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 07:31:58 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 07:31:58 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus when
 it exists
Thread-Topic: [net-next,v2,09/15] net: ftgmac100: Always register the MDIO bus
 when it exists
Thread-Index: AQHcigZP8DCE3uwsu0OrjMZguO4jabVbGG4AgAK0otA=
Date: Thu, 22 Jan 2026 07:31:58 +0000
Message-ID:
 <SEYPR06MB513455F4FBCB9AF4F6E4CB199D97A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260116-ftgmac-cleanup-v2-9-81f41f01f2a8@aspeedtech.com>
 <20260120121407.795529-1-horms@kernel.org>
 <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
In-Reply-To: <8ab0e121-5ffb-4dd8-afc8-11b6ce3898bb@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|OSNPR06MB8306:EE_
x-ms-office365-filtering-correlation-id: 156495e0-9ea7-4047-0992-08de598853a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C1i8gBu7Re0AGNYq7UP5QwJoV2PS4Yj1jcS5EloMi8cnoY7aHQRcWb2yKP8v?=
 =?us-ascii?Q?5WYggkT34PCI8dGR1+6BaZ4N1N8KXgxrH37PBRYhxZa8h2HMhsGps2kgMP6/?=
 =?us-ascii?Q?4Yxw8YtcxWkQBuP6GBGiLaQBvumeg3wYDuzwEKJjbA/uu3C6A5jVPvwVnACb?=
 =?us-ascii?Q?OKD4tJQlNpM8RMqMu/ZHZaVJp/dZI6JuzBSC2VyBhom68GP3gXSW5MOUPW89?=
 =?us-ascii?Q?+WXqla2cyFeb9V+LFXAamNghy4okSSHB6derv3lbCCBjH2lufLGG574+5/FX?=
 =?us-ascii?Q?pKQ8b1eWw4qUiPwVyuCwJZtZN2r+YOAJ4kTwWnhy0ozvY7FIM1bgL8OSVfU3?=
 =?us-ascii?Q?aBkuBXVrUKfBTPkSK7tLAJBZ2cInorCsE7Cx4FTUDTI4BfpUqvKXsy7hKEsh?=
 =?us-ascii?Q?wZebbLXsHbrxMeEpuRxEk8ToeTO1IKZ4LnxNAPjJtKg4XNJSe37rJH1IKPkX?=
 =?us-ascii?Q?FflKjZJ47Cz5ApUcrjtB5EHRWLb+WUN2eljXQLLUI5W88oW0569wKcmomCW0?=
 =?us-ascii?Q?62l4aLysYtzAVuAx93w+6HoNqXBa0sSMDzBscfShf11Hhm2zffy48ZmRY7n3?=
 =?us-ascii?Q?tGrQ/dagdDdmazikJk4IjQcOJcgqD2lGz55f2hPdKLB87tF1gjmUphPjyN1O?=
 =?us-ascii?Q?bXIrJlcTl0C44k6uW07Oihu/9nZ/zn7mPMntmaXa+irhDRrMi2FKXr4pPooZ?=
 =?us-ascii?Q?3coDYFRQYYzJXkKg9CF6S8U8G1Qyv0Dzrm2hDXkoTUtn5qW8g8wMBxuA/Eok?=
 =?us-ascii?Q?mNIJifUMEWbPMLKRdVcsY71EG8zs2DaMzNnC793F/XefcvoUMxXwNG5Zu9xv?=
 =?us-ascii?Q?8lTWyqslfDAYuIluHzcN6VIe97dABYuaQzETZ/q40jMVfjaAXfgEpKaOdZK6?=
 =?us-ascii?Q?B9rwZKFl1AWDjlmiKZdAdv3ZEi7VHxom9ikJdjPRKzHvkvFb2iHeLBhSmkFN?=
 =?us-ascii?Q?Ycf2mzpaRsikgccGdXEtqQ1dMGOA+ykx4GhhiNAYSeID0K4QixZ0sYRwSDBj?=
 =?us-ascii?Q?MP/57ldx7QCpL9dx0sVWYtfl2nNWccT1oh/BW6RGARRKwxrAX4t2FIJvHWMO?=
 =?us-ascii?Q?yL18EoUifqay0mdmlxQyjnVpJTNLf4fqOxY9HvKjw5ZDbHS1FsJproIst+bh?=
 =?us-ascii?Q?7tSZkDUxZwnUSOOKkSj00uiQPcvamWojkyFU5LsHS7UFEhQLC1/phPxLRLFB?=
 =?us-ascii?Q?TdP/2Em7OFTJDyLGzbpaXR6itKkBTExOMbb50Wy7T3ZAQDmqMAPu/r8vP3GV?=
 =?us-ascii?Q?ZAwAvjoESQvS4Wsfx8zFpw+OEbMwMtADIfdslvbLsIgoDU0EDZYCo5bnLo9y?=
 =?us-ascii?Q?yeGzelidjhLpgjaYSq1IuvqrrttxEWSkevSKstZOwcx+caPfR9/HXCAw9YlZ?=
 =?us-ascii?Q?fEO8i7Gdv8orFg6cEa8+g9cIOFzsqSx+R8o9LkXlePDs+L536b54QWAXFhUQ?=
 =?us-ascii?Q?1Xz+iPSu2xKzyLvQlILjXtbsxo6BGsTbqv84zH2MKnYDWrvM9xVRokVtEw6J?=
 =?us-ascii?Q?CidYLn7lCmJ1FaB7YFAkmKuxOp6qIZIz2tRFDg25MvLPZ7rEM0q9wZ5VVVUZ?=
 =?us-ascii?Q?8ILRhlDETeg/yPtT1RQOxBowwljcuPqPREKwuj2LKPGytueEpPjaYBV/7Nos?=
 =?us-ascii?Q?df90CBz0yg1l84HjHuW0w3I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aEhaeIGLaar7VO1baJ7MitfEfvdyxNUNTxST51pIhiRJoD98wK6Zot3LVhXL?=
 =?us-ascii?Q?3VlUYuYw1BfyYvuQkzMozh7nDSlkqyQoakTdzMbouy8qUaT4phTIgW7ciOIY?=
 =?us-ascii?Q?i83pYZVyA0PKhGaK/66ztDKTVwk7O4JjdhNbrYY6jQnMfYfOWXvsOmRP6xIX?=
 =?us-ascii?Q?Q3BoADGQKb34sd3RnOOZhEZrTPRGzCD6IJ3VluVfehQXJA2dUQyE8GsCjBlb?=
 =?us-ascii?Q?05RxSnVYxWwTNcqej+6iVEAyo0UBzC5Wrc1MrWJZAfFF2Pk8jgdmctTiWlDz?=
 =?us-ascii?Q?J5cyhzCPxzo1DLZYe+h0FszcDH/HZG4S7dwR9GXyKI/kS/jcW9pv3B082kUx?=
 =?us-ascii?Q?k0e+p80wwUvUBsm7sneRsBOlg5AvSNnfeGP1JQ3+3jHs6VfRmoEwDG+YGVIP?=
 =?us-ascii?Q?KlTbF1Li7GtaIlX6Bp7hQXcTQwGhpXxUS7mGot/xjP7UuGYXrZX+8gndumUc?=
 =?us-ascii?Q?NxVEfl/PVagPC9hf3DnRYPRf2mLdxPe3jCMxuKEZ8qQ+N+0Cw+4gWT1mKJJo?=
 =?us-ascii?Q?rL3kAbZAxGgbb76aQ0K2rk6fxnacuAAgSioLLehQnjcsuVcOjPg484LwpVhh?=
 =?us-ascii?Q?jRlEGHR7JJyg0N3YHqjVnzK8VfFEPQuGmHxPAb2HdqZEAWoKPkPwTmYHuVTr?=
 =?us-ascii?Q?qsWnOWRlm6qJvahlmkK5gQ1IZenXwxALXC7hgIWhNnn5+9/li/ClYgLntHMw?=
 =?us-ascii?Q?hXXXWwyANOUx7DBgKiD0csrUe7jRUvj5h0D1kYhbDEIVeDwr0uuSh6IDvvay?=
 =?us-ascii?Q?hu4K7mgp8Cf45TSUg328xL8+vlCiyrfwuRAu9tKMLm2k9+xDji4XKeL/rBaX?=
 =?us-ascii?Q?NeZCXWnYSf2cVtgUKse5H9Tl8S5+ZVYHKBFwLyd5Dad39TTKtD7JKzVVgDfa?=
 =?us-ascii?Q?jOfhPtbbpdyVjyaNfX9UGHvHygwxzwTBAoigh4vovxHNjQzL4inG/WtE3lH6?=
 =?us-ascii?Q?/iAjDZ1T6vUZIHDT+iZyMzA0pET8sLuYiJT/Zx4aJYktWPVMdLsfcXL+zM2C?=
 =?us-ascii?Q?sul0aX6YSho5h7xTUgTM+CdofB+oLA8dOnpbLqQZ8l7bfY4aYDhu9XADeQpb?=
 =?us-ascii?Q?q4PfyqndfjI5ERQ+0ZxZUatPXt2nwA5d3aRoCjvSmxHNdcplOrodtq4RGtSj?=
 =?us-ascii?Q?Utok5j8UADHqCxhLm/OmC28iwOumlc2DIaVBQQnufoh5xCyXJdn2Pp9y6Nw8?=
 =?us-ascii?Q?Qfl4WBfgtZuKgDmEHMKDq4ozA3mvEbyeI5/VFIccIS4d9oY0k5wNBurBrHrU?=
 =?us-ascii?Q?MHqqXdUSPepJ876Wx5Ck3rnBdEL7+Z6ZjLP/eS4gsyHZwvvsfVvujXp244mZ?=
 =?us-ascii?Q?ykCMC7k18GSLxn35K/QNDFm26DkkZjfvUZD5p2MvXzD+wHoSXfXhOq71cC5P?=
 =?us-ascii?Q?f2f0aXOLNTUcQ4Atb2R8HSHseKMNyX1udZDmnvbZV+h6SK6J5kKrk9dloY4P?=
 =?us-ascii?Q?VZcBZvOU1051VCFsM0bDOXF0AjIXOYq0e+cAJ7XjVhY3ihnn6XwIXEDlPz47?=
 =?us-ascii?Q?muU69F1tTGqgGTcyjDbDIjFBbqbqTcP+5lLZ/ap3zr1VP17iOKIKRm8zAz2H?=
 =?us-ascii?Q?cPswJ5COnSW4elw2sAyyoiwWeKy6Jsjt17JS0gBqfzas+miuU4oW8926Ub7d?=
 =?us-ascii?Q?cHwPPeE9BQ2f2hpOtZnWUDTfabDOlUi8NqBcuI9oRylL4gBAhpFLJM58fAM2?=
 =?us-ascii?Q?q12arqCe/ElnSjydzo1q1brm3PLqEd9sNmce6OH932YKhbxoRYMT1ZThLSAC?=
 =?us-ascii?Q?TKicV0tSOg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156495e0-9ea7-4047-0992-08de598853a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 07:31:58.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjzM/vKel+odejIJdrOwN6Ike7Mcg116z+CpCKJI/OGxkjujtvKWbv42jhl+xmCqE5kK3OnSOZzS9php5rGYeRwXLTVpljXmyYPuOWwwXIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8306
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aspeedtech.com,quarantine];
	TAGGED_FROM(0.00)[bounces-252230-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,aspeedtech.com:dkim]
X-Rspamd-Queue-Id: 67D596294F
X-Rspamd-Action: no action

Hi Andrew,


> On Tue, Jan 20, 2026 at 12:14:07PM +0000, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/ai-review.html
> > ---
> > net: ftgmac100: Always register the MDIO bus when it exists
> >
> > This patch moves MDIO bus registration earlier in the probe function
> > for FARADAY, AST2400, and AST2500 MACs, simplifying the code by
> > registering it unconditionally when the hardware has an MDIO controller=
.
> >
> > Note: These issues appear to be fixed later in the series by commits
> > 8961daa5f2c0 ("Simplify error handling for ftgmac100_setup_mdio") and
> > 046e51399f0f ("Move DT probe into a helper").
> >
> > > diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> > > b/drivers/net/ethernet/faraday/ftgmac100.c
> > > index f1cb5dc37919..931fdf3d07d1 100644
> > > --- a/drivers/net/ethernet/faraday/ftgmac100.c
> > > +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> > > @@ -1957,6 +1957,14 @@ static int ftgmac100_probe(struct
> platform_device *pdev)
> > >  		priv->txdes0_edotr_mask =3D BIT(15);
> > >  	}
> > >
> > > +	if (priv->mac_id =3D=3D FTGMAC100_FARADAY ||
> > > +	    priv->mac_id =3D=3D FTGMAC100_AST2400 ||
> > > +	    priv->mac_id =3D=3D FTGMAC100_AST2500) {
> > > +		err =3D ftgmac100_setup_mdio(netdev);
> > > +		if (err)
> > > +			goto err_phy_connect;
> > > +	}
> >
> > If ftgmac100_setup_mdio() fails after of_mdiobus_register() returns an
> > error, it calls mdiobus_free(priv->mii_bus) but does not set
> > priv->mii_bus to NULL. The goto err_phy_connect then leads to
> > ftgmac100_destroy_mdio() which checks if (!priv->mii_bus) but finds a
> > dangling pointer, resulting in mdiobus_unregister() on freed memory
> followed by a double free.
>=20
> The call to register the MDIO bus has been moved earlier. That means the =
call
> to ftgmac100_destroy_mdio() the bus also needs to move earlier on the err=
or
> cleanup path, before err_phy_connect:
>=20

I've been thinking about this part. One possible approach is to switch to
devm_mdiobus_alloc() and devm_of_mdiobus_register() instead of
mdiobus_alloc() and of_mdiobus_register().

With devm-managed MDIO resources, the explicit cleanup via
ftgmac100_destroy_mdio() would no longer be necessary, and the error paths
would become simpler and safer.

This should also avoid ordering issues in the error cleanup paths when MDIO
registration is moved earlier in the probe sequence.

Thanks,
Jacky


