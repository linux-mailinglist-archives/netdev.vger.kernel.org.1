Return-Path: <netdev+bounces-291694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEBqA46gFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDDD5D682B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 408F83029AD1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DE731E821;
	Tue, 26 May 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="g215Nu0V"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022128.outbound.protection.outlook.com [52.101.66.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4B4315A;
	Tue, 26 May 2026 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801669; cv=fail; b=Sdg/5QkzDE5u8kN0fD3BMWw78y+foWVcmfYER9NnACkyJXpw6k6NTy+m/b+kGcEe6JztPO0kvOf6X6h6mkGpWePXj9RcjYP932JMoVUtFfG9z+z4q3MxTSjqDRvCT2IibPlezjWEiiu3MR4qJ7ZXzpudjA6PcWZ00ooZQTBUkeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801669; c=relaxed/simple;
	bh=+AEBZ0mPIl5xH7tfQz0Tl7VQgfhDk84DBNyrGt5PCoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NonSbz9b1Lw9lbA7QqIwfeBkCKutfQLRWMjnEE+YdW1yjmjS46tKRS75tojuyjVH4RZ8rrXhgmbO0Fh8Ickt3G3c63q+lMUbk09cUwvtWmlgYOj+ejyPyWjjIQWn1BRmPuCf2jJ6R1LE9zznm1OnMffipW+whjbzCHGIp6FaO4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=g215Nu0V; arc=fail smtp.client-ip=52.101.66.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shqg+xMjFkqaviFCo4d52k5KR189oKthKutUl56TJlUluDr5sZlciZReRm7OJelqLh+3YbGU9yMUrWolvKAKXr8cw7lkBF+4bQ7IVXsJoKmLafYr4MxhQTTDKwV3NijFJdJUOVqKZ6rqPYf4ZXUzDfwFUrE4vZfwPTNOBUeObkjcYLHSo0C2QB5WNvVHHH1o0aF14jYuKK03qI4u2z/CxYsgL2L2T92MFRuGiwRxd3tB8kLRlx55g0rIsRMV85I8tLUaChF0hUaOjZE6iYh1FLOaCdsgucDVlvBPr9IN0J7oJ4ggjdbCcFwQh5NNgmT681h+7PtXLUJ7FJ8mPoukPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFav9DKCxeWQDxeHhoKVBTfQwFCrDlKSl1YHToo8jUI=;
 b=HJRbron+LSYflFPKnewjFgfDh4OBzpzMbvVXYTO0kt/yenxcZ3J/p72FGbCQPZliaafq0qWq6uyEsm3mBaWzWB9sPTFlYelGA/nIL9ap1bYCngK2zb5WsCb6HqtqrkIU6uVTTtWzBrqDyg2h3gC4HLc83HZhVmAdVTq7RV22qPiR7hmf/y+UCAfb3QxtlZ2nABEppjssAJXkDY4lGKrXP0Kyz4HUrhcFIqDGbJdfKMKjGtCyyRNAwDXne7EVZoUI6OHBz9t369V4gv+2usOVu2VThQc5X/MHQkqO++0xPa7WxDhOgjKU1WJUd7HM+sj6F5bn1kfnCWLSxkMA5rLC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFav9DKCxeWQDxeHhoKVBTfQwFCrDlKSl1YHToo8jUI=;
 b=g215Nu0Vp/fziEYPcR7skv9QJ5f+eeo3iZvpIOFShnnGV8zSQP+T5uNAg9Scpx6ZsQ+GNTVrl4EIl2SDORFr2ZG3EMXLQpLOmpw1HY335NbL2na05GVhXgIDlMxViIKGdq9DHmLOIx2TIP2fYxIdXvRsRso2VyB7o/DIPnbayAM=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by PA1P194MB2284.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:44b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 13:21:02 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 13:21:02 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lukeh@padl.com" <lukeh@padl.com>, =?iso-8859-1?Q?Marek_Beh=FAn?=
	<kabel@kernel.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx queues
Thread-Topic: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx
 queues
Thread-Index: AQHc7QSUKaL2ywNstkqnfN9ZgKxp2rYgPOeAgAAGbA0=
Date: Tue, 26 May 2026 13:21:02 +0000
Message-ID:
 <PR3P194MB1505D182F5C0D22C45A1F29FEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
 <20260526-net-next-mv88e6xxx-cbs-v2-1-13eb49c29b83@luminex.be>
 <c2e2ec6a-edc4-4eb2-8dce-a79858e6a1e1@lunn.ch>
In-Reply-To: <c2e2ec6a-edc4-4eb2-8dce-a79858e6a1e1@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Enabled=True;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_SiteId=8ca3018c-58f1-4333-afa9-a8744cbe7fc2;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_SetDate=2026-05-26T13:21:01.496Z;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Name=All
 Employees
 (unrestricted);MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_ContentBits=1;MSIP_Label_c759e39c-a1a2-4071-aaa4-c2e37491f9bd_Method=Standard;
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|PA1P194MB2284:EE_
x-ms-office365-filtering-correlation-id: 5cf57056-2299-47f8-b27a-08debb29a242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|56012099003|18002099003|22082099003|38070700021|6133799003|4143699003;
x-microsoft-antispam-message-info:
 lNlEH3I4uVYVWozZHDDU+5hO5UlG3lAoPPhsIMP9iw55/7YhCfiAvxUBWjxNRW0f6YMD3oRmVUubCJQ9AWwCGw1R7xBDBQsxC1Cxgt2DLGvLFZb7pkFcxg7ehL2toxWRZUAoV9USVWbhk9Sr7tHb/jTRZzMIA+SexH2aEGOrdPvkSjUgFxdW6zG7Tq+YFZrbiDFhtmNpQ0lx2q1R5TpwM2YHQVd1o/Alnn/7w/eaf57VjTBG9Yufywsfx8K6W0UdEOofvNZxtySYIVlA+EVf3IzYHXY/S0rRoeVcT47BL6ArN9+iYHpaEQh3chC/tvo9laux33s7aA9CJnPfDuhXBCpIQ2ZXIFDEr3YAw8nUTrXXXemI6rZLcJDTS0eHwMBYMqrMbDZYo/bniGUYVFKCPFbtqWARUs9JwZrYLtqPWFDzQaZNS1DS/m7X4+GjGZqbDClkTPJukZRm0nr5eAJigzedM4ovpek2RPXkVn/FX8adVJJuvHw9FdadM8tNvtX2IJnNk0gfxbLy62OCyQE/cA05oO3O2Kb+nyvfxRfgAA/iGwQKloqkvldOZm17kPy1bbHyJv/KobSkp2lG+91wa/LQMivMrIKwbhyJat6MIJVdcN1dsaedBLLUu4OmRmSmIdb1/35x1epUzdDTNcRa1mA/CsxZvIXXUCOB0rq/2Umo8S83vOFYyY3YjnEBshseypBVFFkZyd6gNs6tjuOPt5BuWQ9syG45GIJqlWvvvaHGevMscSBdJSbQhAZALifw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(56012099003)(18002099003)(22082099003)(38070700021)(6133799003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4my7wCwICRaI3EOiFtLDiStO5Cm7LBCbOTZPAU/smvrsRaNA0Gom7fcAaA?=
 =?iso-8859-1?Q?BiMgBIP6ukuJ58YhAOHppxOxA8MkFHuJDkUXm4t5KdpmcRzDD0kaPoFs1b?=
 =?iso-8859-1?Q?UQVGx8e3lEoDIaSBZygir7CW5Yx4la1ctw/y8tQHvyzgvEJjFVZUgASLDu?=
 =?iso-8859-1?Q?pT8APQj7mIzJ61xXowZPwIWqu99ywPXL77HHSN9CTko2ZRlumzZnSbNRPB?=
 =?iso-8859-1?Q?WMEUPjXUg4snZBXTiKW7Y4y/iUM5+VYWQetQwerkl8V1BWY2koJluzKjiu?=
 =?iso-8859-1?Q?QyQrje2jCAgvE0vZZ8sZgd1uDbM8TlJgC428STuFx21Z0NcV1RJkeDXYra?=
 =?iso-8859-1?Q?9UEtJ7Rc6DTMEHFSxdr0WGoZr/Ga3B6UH32GClbhk4xFoAj5U9cSK8Jses?=
 =?iso-8859-1?Q?DBgMBGI0Pl6OyoaN03EOn3JTSzuDxSD1Bfmeefz2IGv5RqtE4WisyFFaC2?=
 =?iso-8859-1?Q?8kC94wzYJnlO6ypAH316mIgKKH8qGT9uP6lC1+B5bcTSa/ZOqFlxn58C9w?=
 =?iso-8859-1?Q?PelOpsgIRSuWoj+hJARbAwC2srYRcS7Ei/AoUV9y9assr8K8KMOKkCjOdz?=
 =?iso-8859-1?Q?7Z51+z0B7Ls1vrdymCEW/RtA/ZuagG5ctb6KnHFm7kPtpLepDLy7cnE0xt?=
 =?iso-8859-1?Q?ejJqaXcPR5nnxuwIo4BtvVtRxUORnanyKn0N4IP4vkmOY1EqllVMVnhu8M?=
 =?iso-8859-1?Q?Md0zmz0yXN5hupVY8WGwhFA5a5FKb0ebHWjb/YeFrDtAy9G30O3L0h5uCZ?=
 =?iso-8859-1?Q?kcZch1miQjjqLU0XYBUjFcXYxTa3TvTSNk0pIMAhlUSau8Z0XVv9FziSBs?=
 =?iso-8859-1?Q?F1CwElPMazgERjXdY6YnbxPHREbSag4+UpAweF/RbbN1EhOyGFjRYGxbp1?=
 =?iso-8859-1?Q?IhVHvC16PTaWcvg8Fp984XIIg/HpmpsCpbR9ptnso7+o8PNJtyWPLbPXGf?=
 =?iso-8859-1?Q?8EcFQ8f6IWQ6mRenTOF945poxcAe8srxYmp1h493QVNLes1KX713hBU2tN?=
 =?iso-8859-1?Q?4OASLUO+jJKgxhnIQ/BCb7f+8+YLBYtv5twDeL/caufHT2VEv46JYsbZd4?=
 =?iso-8859-1?Q?gt6Q5dRZQMRSMGe1rJkIOJSH4a12iKu24T+6D9qxFyNRtEvOc+efqQshSh?=
 =?iso-8859-1?Q?z1EXdqRx+pfAMZ6ghWtzlZvOqUZoJ6XPVufLw91Or6DH2B4rvd23QgUHos?=
 =?iso-8859-1?Q?YHCkHx+hPY4CzZYhWUiTQFqvqU53Et/rbIh1chH8i1/FB/dh6fLQ1jK+Uc?=
 =?iso-8859-1?Q?nIyWF7v0Ill11zNEgjS7/et+O/IHIrbzk85jMk66NGa/f7r5pwM5O4XytO?=
 =?iso-8859-1?Q?Zd38ERZ7PSpaYwTBvCclY58FKi8SyooJT5C5eSaCYcWg7KrfqPvgPQmDd+?=
 =?iso-8859-1?Q?DDrHijejDn36whgZwTHG26PshiwswfSpM897RMFnVy2WQCZl7SW/KmrSiX?=
 =?iso-8859-1?Q?74hfzSZJSbkTTZiJdsYbJ9g47MxVBZTGL8pMbEWx7aT/hru1UBP60rn+tF?=
 =?iso-8859-1?Q?yLgnmD7+EVzq/dhpVBzk9bAhzTfFslEW5bj6Z96YHMaMbXgEcHE3eM4xyt?=
 =?iso-8859-1?Q?uoLvrKR4bLLeJeKO+IqZJFi4oYeR5QJZySh1SHoa2wHlUg61WyjjklTNsO?=
 =?iso-8859-1?Q?N6RXDkM8idyiBo4MBjDg4IUnvvUnYdFojfPWGOUePI3TULC++iJZU7BXMw?=
 =?iso-8859-1?Q?yxw8XT8wP6/6Qu79c7q9YYsUbaTNW7IeJe4aQ5xR+FKU3GZYirIbvPKkXQ?=
 =?iso-8859-1?Q?E3qBYT2iYRPFFJXHwqlbYiYJ/CUyM5WIfLt6NdlbxDYZZ/xVyz2uHTB3uk?=
 =?iso-8859-1?Q?/ypd+1wsiEK+S7W5JxjMlhoCgRK8rZ5jazFD0vzgvTe5ya5EpCw19Oz0/e?=
 =?iso-8859-1?Q?Vi?=
x-ms-exchange-antispam-messagedata-1: WRgLOUhw3/Jgkw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf57056-2299-47f8-b27a-08debb29a242
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 13:21:02.3015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mESGQPvt2qMfZ/J0mojJTsJmBkN5Gb61eG6nZ3knWtyIAmWAjMuGLId0dYZ1krK76pT97hdQrAwnBAE5iwhQw6eqfQ5qBsZ2iGpvi9+LxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P194MB2284
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,padl.com];
	TAGGED_FROM(0.00)[bounces-291694-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[luminex.be:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,luminex.be:email,luminex.be:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: 5EDDD5D682B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=0A=
From: Andrew Lunn <andrew@lunn.ch>=0A=
Sent: Tuesday, May 26, 2026 2:30 PM=0A=
> From: Andrew Lunn <andrew@lunn.ch>=0A=
> Sent: Tuesday, May 26, 2026 2:30 PM=0A=
> To: Cedric Jehasse=0A=
> Cc: Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo=
 Abeni; Simon Horman; Russell King; netdev@vger.kernel.org; linux-kernel@vg=
er.kernel.org=0A=
> Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use the hw tx q=
ueues=0A=
> =0A=
> On Tue, May 26, 2026 at 01:41:14PM +0200, Cedric Jehasse via B4 Relay wro=
te:=0A=
> > From: Cedric Jehasse <cedric.jehasse@luminex.be>=0A=
> >=0A=
> > >From the datasheets i've looked at these switches have 4 or 8 transmit=
=0A=
> > queues per port.=0A=
> > There's a PRI field in the dsa tag used to indicate which egress queue=
=0A=
> > the frame is to be sent to.=0A=
> > This isn't done for vlan tagged frames because this would overwrite the=
=0A=
> > PCP value in the vlan tag (The PRI field in the dsa=0A=
> > tag is used as the PCP value in the vlan tag).=0A=
> =0A=
> Maybe a bit more context would be good here. This patch is about=0A=
> frames the host is sending to the switch. Looking at just the commit=0A=
> message this was not obvious. It was only when i looked at the tagger=0A=
> change did i understand that.=0A=
> =0A=
> Does DSA_CMD_FORWARD vs DSA_CMD_FROM_CPU make a difference here? Does=0A=
> DSA_CMD_FROM_CPU skip some classification stages in the switch, where=0A=
> as DSA_CMD_FORWARD might pass through more stages in the switch and=0A=
> have the queue over written by the hardware?=0A=
> =0A=
>         Andrew=0A=
=0A=
Yes, this is what the documentation says on DSA_CMD_FORWARD:=0A=
> Used for frames that are forwarded in a normal way (ingress and egress fi=
ltering is performed on these frames).=0A=
=0A=
And on DSA_CMD_FROM_CPU:=0A=
> Used for frames that need to tunnel through Blocked ports (like BPDU's). =
No ingress or egress filtering is perfromed.=0A=
> Frames egress out the Trg_Port tagged or untagged determined by Trg_Tagge=
d.=0A=
=0A=
Cedric=

