Return-Path: <netdev+bounces-286807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCkRD4svAmq/ogEAu9opvQ
	(envelope-from <netdev+bounces-286807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:35:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B4515299
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F5613052CA0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89047CC7C;
	Mon, 11 May 2026 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="iPTsiGmx"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EEE1C84A0
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528130; cv=none; b=IfXHGaY5Lg/CsSeQZPG8v/H6sKdbB3GCmQ+xEI/9Oj0S3S5X0cYaRQwurhXj7+YT0099RP1BcXnVLHoCT5AQaelp9Rfwox0Q4kPH5XMbRQHzHgeD9QxzdJJG6qDzAv/KiCHjYT1855E4Q3GJ/5atTh1fW2HlM3KMhw0F/SrIsUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528130; c=relaxed/simple;
	bh=nE0nSZVqJAP3tjRO9YuW+tEOJZW7IecEs65GomFirZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RxUvS7PbpZP3yeVVfigp86a3RCOqkmNdtfXaYi35PcVXP+fJCmZIMq6f6iIadOqNz9IjpLhFnDy+PVHxkHOC+KiZYdqfA7Ik8sAzOOv5LKX9iVdtUPYZLhsuYCK9yY1p7jTdS8zTo37/hGdEmfgm3rrl99zvaIHlWoH7rocU6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=iPTsiGmx; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1778528127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE0nSZVqJAP3tjRO9YuW+tEOJZW7IecEs65GomFirZg=;
	b=iPTsiGmxEj/QgVncE6n+Jje+pO34lY5WAVafePUGPzWdBsLCNJyn8+ilYJZyu+Ylujio5E
	nqLOh/cNTmxx9ugKFtVx7AUj/ZJdn6x5jeB0H/lgNAjJB02oqNjTRYvZUJpIOsg9tt6Fb8
	DCQn6HbmOaNaIFvRlGHMs9CI2UFYKVp021WewXupqxbVuciGy+0O1+me1jDArQXf1FiQ26
	FNnEfhEhDagl2rb0UWRElL9T6QeiVzyd3MhEGxTA4K8TKexfbBmrnX0dJbk2Uq2veQcjxY
	CuLB3z0DQQkjEwgFtZPNmQYTL0Yqc1JOBSNs1HPwkiIxkYZNEWTzBQ4pyRKFBQ==
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-29-Tm4UDrkvNL2xc8mygWlMmg-2; Mon,
 11 May 2026 12:35:23 -0700
X-MC-Unique: Tm4UDrkvNL2xc8mygWlMmg-2
X-Mimecast-MFC-AGG-ID: Tm4UDrkvNL2xc8mygWlMmg_1778528120
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by MW6PR02MB9912.namprd02.prod.outlook.com (2603:10b6:303:245::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 19:35:16 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 19:35:15 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Thread-Topic: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Thread-Index: AdzhcNrMIlF1yVpURhiYlSATodqMaQACw4oAAABKvUA=
Date: Mon, 11 May 2026 19:35:15 +0000
Message-ID: <CY8PR02MB92493D7EA2E83DA6FE73B10583382@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249195FE5BD6D7FA31F4D1B83382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <b6af67df-1217-411c-ad47-f9c3e556d345@lunn.ch>
In-Reply-To: <b6af67df-1217-411c-ad47-f9c3e556d345@lunn.ch>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|MW6PR02MB9912:EE_
x-ms-office365-filtering-correlation-id: 2ec62220-afec-44c4-9200-08deaf946d62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|11063799003
x-microsoft-antispam-message-info: gjK28WkrS1s8ubO23sBLK7+SheXEBp+pyYdz7Ux0YGUKmVIz2ITrYx/bwXE5iqVJxBZci6Pp3uYKd/8SJDRzR5IhSlVNNLfBGfVUt2AYIW3RK1js5ZBzCNrV0M3DOhSs1nnEzEJqpkkG73Pvc4rctd+rObi1ViXaS18JP++/GFqYBsxHBPfPNF7KwpyEpDOLWhmNFOORb053AKjzqNT81vuuDNelFzCH8glZiRcVjA/rra3dnJVgjXK2coletn+zL+I0ENk49GGyRtdbHbmWl1JXuftxERmhtSltCZkxR3pEzSLtf/Fwj+iSorXP+l3eIlPp4cjEaCrHAGBsnQz2WUz3aJ/qFHgwbSy09/yf7Vfb9cS5Z8VOg2moNKoLfWYPgu875mQc7ATM+bP7IFgkidCkNIDrvTUgo5lMjPeXUjJigg2FY6kpAHMiDcIOzfdjhjAwgnsr7S4BB80+8JRNGGLZCWWFZe16ZglyqWfGbhxYKznFGbQU78FRT0U3qLH+K77TVdXbEpe857vID+MrDHZ1l1A0JOWMWwCpYUlK60v2pL+Gpr+8+cKVB+593Iq4rnssmJiAzXOZiGVMcCyFSuuJUT3EspUZTcPoYZyg4l+0bx9L5sB7Z9VLFrW1nvfE7xq9+8OBtJ6gSnLar81DoynsaNoJDygtYaPNzbmNjmmEWLX6DJd0TsbsHNge/CKFrgqtWnziJZPXnca/tqrxSnEF1BLkSJF7NaSes2wBKj8KqqrO7tDhf5lUeMCLPhEN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZmdnV3d2haaTFuTEhJd3RPYlpLaVZPN2JYSTZoNFV3bXRzMkUzZnFVbEQ0?=
 =?utf-8?B?R1E5K3lZKy9kYmR0bW9qdGVLM3p6MGZvUEgzdVFYOVN0MjA3SHA1aXJXbnBI?=
 =?utf-8?B?ZG0ydTh6SzBhcFZMTWZPb1A1cjNUemppbE0vdVBtdGtJaXRMYm40SkJ2cC9w?=
 =?utf-8?B?eHJkUEM1ejB3cFpUZVZwa0Racmtzc0ZJVDRHQmRtd3BJM0VUQlYrUzBQdmZJ?=
 =?utf-8?B?aWVDSURERkhJWUFJVjBlSUJFaVU1L054ZlFmTk9xZXlReHJBYmhYU0pRYnIy?=
 =?utf-8?B?Um1wUkhzTm9kQVBVMS9OclR0c0NSY1IrZ1g0WUM0S1FhbnVKY21pdFdrVXhu?=
 =?utf-8?B?OHBlb0JEWXU5dW5PYVhjT3NOWWlGRkRwVFUwMndVelRWRFF0cTVVNmpuTFhR?=
 =?utf-8?B?UG1NaURrSUQrZXI2bWRHMXpuQm1Ncm1aU0RqblpoL0d1TzQ2Y2wyUVNxdWxN?=
 =?utf-8?B?SmQxRXg0S2JhditxNzJUcllacTVMU3FoRkhra0Q4Y3pvcVBkcXFoTTVGOWd2?=
 =?utf-8?B?bHZkMDJkZ0FhRGVMQk90UDNqNFJZbWJ5RUFoQUZ3S3ZHN25JSWJqVWRxay85?=
 =?utf-8?B?SjZhblRwU1BDYXJna2VJODZpbkFkbGlwaXpkWGtNUXFQNWFTdllBSjJUNDYw?=
 =?utf-8?B?RFk3Z0JBNkpqTitxcDNZQ1BnRmI1dE15b3duVkowSWlHdE5HSTd0YjNwMk1T?=
 =?utf-8?B?Q25Zd2NoY0tXUGozR0FHalE5c0MxRTRKSndvSDZqMVdPWnk3dzZrQm5XTmcz?=
 =?utf-8?B?QVFuZFhuV3pYalN1ZzMxMmMzY2dqOVFjV252ZUlGTW5NdWthOEt3VU5lNkQ0?=
 =?utf-8?B?RzBpSzNZWWxDc3NPaU5yYTB5M2RBUVZlU2lsaHdUMW1aWVAvSzQ4MVQ3Qkcz?=
 =?utf-8?B?Z29QK0tTY2s4TGpCZ0tYQmd5UXlEWW9sZGlic1FZOHVsSTRNU2RQRGFJY1pF?=
 =?utf-8?B?M1pCRitTRlhveGJISldpa1J1cEhYR1hKWGJleGNoa0VOckZSSGxQWHRTR24w?=
 =?utf-8?B?Z0UwdDJyZDI1TWl2aStoRnVGK1l5cWUxMzhOa0xlOWNpR0J5SGxqYkkwUkxp?=
 =?utf-8?B?SURpUG5FYWF0ek03UWdiSHlMNmFDWnYyb1drc2Q0eVd6K3BwVjVhS1UvSXN5?=
 =?utf-8?B?eUh6NmNVME9wb2phR3dxQklkOGpPTmt3QmllMEdyWXp2b1krRjlnWmlJTUp1?=
 =?utf-8?B?K3pYS0Ezd1dPYXpETlFzSVF1dEpuWktqKzFhaithdkMwbDVsaXJqWUs2SkpG?=
 =?utf-8?B?TStlaVAxWVZPd1prRWlnNklXWjdEUHBnR0dETEFUY1RVRFZnODd5aCtRMGwz?=
 =?utf-8?B?Mk9RaUw1T2ttS0FNUWRpa0hwbElHK3hqMU1wbVdFRjdNcUVqckYrdnltNy9H?=
 =?utf-8?B?UmZHWHZsa3BMYVNXalYyVU5wMjVjbGhPakNGbytXSWRHWWp0bVBKTXdoN2li?=
 =?utf-8?B?QkZJNUlzNmw1Sm1aMGRjZHhUY21MU01wUnRFaUNDUEtNelZ6R3hCVlFpWXF1?=
 =?utf-8?B?Smp1ODU3UVZPdGhGRjU1bVQxeUEydHhNNzgxWnZ4eFN0bndNZ0o0YS9rMjVZ?=
 =?utf-8?B?b2M5Wm50TGVVeU5ocFhlazBhZlRxQ1dndnZCMGVjb0tVWXZLYk1PSVNwaWty?=
 =?utf-8?B?aUNROXRUYVpKTzZyNHBRaTkrcVBUM01RRnFPZnozcFp2V0xFRExqR0VQOEV6?=
 =?utf-8?B?RVA5c2JFek9EeVBaN0FnMCtuWFZOQUs5SENHRzNCOGpqTmlxNHhpSmI2cUJu?=
 =?utf-8?B?Qkp0SjZ3VldRVXNWb0ZNWkI1N2ZmdXlqMXkzendVUWdldHhDOUVxaUVWSVMx?=
 =?utf-8?B?dWpsWmM3b0JtdDBZNWVmaWJhVTAwOU0zUEdOOWdkNnlkYlk1bWZKTi9NNERx?=
 =?utf-8?B?VkF3YldjYjNxS3YzdjFKU3QzblNyY1lTT1Q2VlFkaEZtQ3BuYjFYcm1YUGoy?=
 =?utf-8?B?M05iQlNrY1djTzVIM0xGZVU1Tmo1QjJna3hXVFArVmtra1NvZVpPSGNtTVlm?=
 =?utf-8?B?RkNuVysvYndZTi9PVytQZjRZMHJEWEVpSmZTbmhDby8vWjRhOXZwMUN4VWNh?=
 =?utf-8?B?Zi95YzNHaWlNL3lOL0RMZ2NZRzg0ekFNWUlQSTIzRUIybkR2M3JsWTljMnJa?=
 =?utf-8?B?STVOb0FIMkFIRzF6OEZSVlFlait5UEJIa2s4Nlc3MHZTZ0FXbDZmbGNwSkJ2?=
 =?utf-8?B?aFdiYm1TVTJJazdJZGNYOGNKQSt1K1NuT2xOM3B3VUt6MjFZUkJGMVh6aUV6?=
 =?utf-8?B?eXdCUExvZlRiQlZwaFlQaW1GcFU4N2x2M1hhTzlTTG1QNUpKakMvUFZ2WHZH?=
 =?utf-8?B?QUtFR0FvN1hydjl1SnROWVJxdStuTjRjbW9KczZ5RlNZQ0ZGZnp4U3V3VzVw?=
 =?utf-8?Q?8n/cpWSxnTlhBda0=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B3YSjnzHAfZHmGCztfm4gxRZVCCOlJHodrmN4FbFuncBlf2g8EoWnd/XGctg1sOl6y8hXNgSJnZTQgkR8tChz5F3pfIG03OpOBkgC6E/UnaLofFpsofDcvMJEbzzRFlrVo5Ycz2TYrXf3XQ7888S9YQjSkqGQ9fQDS84SlkPHgMukxK/YDHeBKs6n4fApmGXUtApRHWATG55T4e5t78vtWmnYf0lqE+QR8j46f6d+OvCNVD67Q+RqbjTDcrHKRjQiTGJqddAgdSDjJOJRpCTjtR5KarD3ZATGKK05D13vWE6Slo8fbbvcVG5liupm8i3LW3BJ5GelPNjN1Rc8CDQRg==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec62220-afec-44c4-9200-08deaf946d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 19:35:15.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxlaOw+WEfRcRLHQAB5S8JZV/TR/Ui1ETnMkuGv13w9gb9d3Hp0guNQwroUTLwwbAvhBEA3K9RK8jR7e4P8GKy6stk+VkKkkprD1pP9zFAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9912
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AGpQhcCrztjYDM5SmgJVgq6EyZ96XVEJ-a9sJ9w7KRw_1778528120
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Rspamd-Queue-Id: EF7B4515299
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286807-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[onsemi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:dkim]
X-Rspamd-Action: no action

DQoNCj4gDQo+IA0KPiBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXINCj4g
VGhpcyBtZXNzYWdlIGNhbWUgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLg0KPiANCj4g
PiBAQCAtMTYzLDcgKzE2Niw3IEBAIHN0YXRpYyBpbnQgbmNuMjYwMDBfY29uZmlnX2ludHIoc3Ry
dWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiB9DQo+ID4NCj4gPiAvKiBEaXJlY3RseSBhY2Nl
c3NpbmcgdmlhIENsYXVzZSA0NSByZWFkIGF2b2lkcyB0aGUgZXh0cmENCj4gPiAtICogU1BJIGFj
Y2Vzc2VzIHJlcXVpcmVkIGJ5IGluZGlyZWN0IGFjY2Vzcy4NCj4gPiArICogU1BJIHRyYW5zYWN0
aW9ucyByZXF1aXJlZCBieSBpbmRpcmVjdCBhY2Nlc3MuDQo+ID4gKi8NCj4gDQo+IFBsZWFzZSBk
b24ndCBjaGFuZ2UgdGhpbmdzIHlvdSBhZGRlZCBpbiB0aGUgcHJldmlvdXMgcGF0Y2guDQoNCkkg
dGhvdWdodCB2MSBpcyBhYmFuZG9uZWQgb25jZSB2MiBpcyBzdWJtaXR0ZWQuIERpZG4ndCByZWFs
aXplZCB3ZSBkaWZmIHYxIC0+IHYyIHRvby4gV2lsbCBiZSBjYXJlZnVsIGluIGF2b2lkaW5nIGl0
IGluIGZ1dHVyZS4NCg0KPiANCj4gQW5kcmV3DQoNCg==


