Return-Path: <netdev+bounces-265888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OhABcmTr2kragIAu9opvQ
	(envelope-from <netdev+bounces-265888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:45:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 465BD244F73
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C1CF3009F35
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723123BD62E;
	Tue, 10 Mar 2026 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0rHSjqhs"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB22C11E8;
	Tue, 10 Mar 2026 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114308; cv=fail; b=gWV4Z3YVxjN3CXhvEmaBdHwmrzKWgShYN3H0rwbh6jdiJQsBb01Dpnm+5hyyMxiUtpl9GPznAaFyh+f4S4sgoDpLcqeNq/zeq3pNdMZndBtlFEzWHUsU8Ovgu34ETBvmsvGogC9M6jtO7BS8Zp3T7OqJve4zlfyCEmFPvWpgFR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114308; c=relaxed/simple;
	bh=pahQbH7nLNf8BhaCeOz45Y4yF7QdjFEPH2fKiJ6UZEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fEjSRZmLFSFbVr6+nZWpJIuaU5LNjXwp6LiiJ3/UAaEvOzJR+Tnq3ixgpiM+oiDdvqKtXZdcRCs3+pTF8TpoVi6/RKPHR8LdQMVJErjPjLCgeqlEttI+31KQduon4Z5ZbgBU5XI3yWpL4pXDSzNmRAY/lVzCoggGsPthgTQGRug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0rHSjqhs; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T57UxH2AGpgN9rMR44eA9IyPMfqt9IGhWkJPGB5VjcCNRLodDPCuiTcJa4AUcBPC+wxMk9xcZaqG0PpkB7JPbICyyNyWU9f6ubSsIKLappvbY2vhN3Mx+tthIhctD3Zvgj8FiuAX4TaKleZ6hqjEfgn8KHeEhHU2FcjtJN0Q2mGM1qvctFIivQo10/fZctRI9GxsFSg0SM/DBAX9Fjv1uexw8bG/qNtmazw0t7cED1/XpjrZ+YX0T3DjYiBsH/yTZcTI2B6Lrcrer7w6rQQPj0AqFDhPaqBaKXLr8GzBeMO1aBSOEScCBU/VTUXudGAGCHhUw1RgPs8lZ4I+igGxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m55sJ6iJvGl/njn5kaIz1Y5D6GHxeNqhcLIEooLboJU=;
 b=Tbp/ITxfmL66F/PJsFlt1T9vum30qnsj6XgDom+6RBmYxglzadrDPqkyE3DBt7pCz46aXWFiEGnRcBTHH0VS3/hfmdrSqKCHdDuxZtQrl0vZdNNaI8/8phtXiorvB/Re60Xm1wb+RymNCqiUmJN/qUgYx0up4htFpWu5XT9C4yeun0type2yfwH0hOVzqwamBhAdMwwv0CgwYKG0Ahyct6EcfacxOKwGZBdoKL0oAIGPY8TFJkatUA327WPGH8k32DD3txVaXZXNwoHIVaGDDCs2Ov08FZMS1L0Hie7PWpHAwiPDVUU1Xwwq4QffxfNPn8M90Wk816NvX9r6Xoa4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m55sJ6iJvGl/njn5kaIz1Y5D6GHxeNqhcLIEooLboJU=;
 b=0rHSjqhsDbFALCfippwD44nAAIF4H92B3pl9yIGRQOzD0yV91HPtLAjxfE6vjETXE0GxEd7uZmtajcheXoES8DhdcDluSSRm/1UwE4wgzNc8w1r02jTPOPwJ0dkOy0gIyWrMVPtmBS9p+h4URxxU6ka34/FTULjVRLsbmOL13JBsI3vKBriFlc2t8JkOrSX8Gf58hewkNnLQDl3o8pynHuYBeaFRV3HWzTa5nAp3d3dtxfskixJrihYqTnwqS2PkPIoby2tP9qlqwaVDaR0VICJGyo3QqPnrgjgqsuLDqVM3o7FOl6XIb9BbMGnPPKVlZr2eTvy2kFtm/V7P7Ftp5w==
Received: from IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7)
 by IA4PR11MB9417.namprd11.prod.outlook.com (2603:10b6:208:569::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 03:45:01 +0000
Received: from IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::9b76:a6e7:1eab:4e6e]) by IA1PR11MB8804.namprd11.prod.outlook.com
 ([fe80::9b76:a6e7:1eab:4e6e%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 03:45:01 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: lan743x: fix SGMII detection on PCI1xxxx
 B0+ during warm reset
Thread-Topic: [PATCH net-next] net: lan743x: fix SGMII detection on PCI1xxxx
 B0+ during warm reset
Thread-Index: AQHcrH8V/uA8QrVycEqiGucaSh7Cm7WnBlmAgAAfhPA=
Date: Tue, 10 Mar 2026 03:45:01 +0000
Message-ID:
 <IA1PR11MB880405FDDE4434E1A2C27217EC46A@IA1PR11MB8804.namprd11.prod.outlook.com>
References: <20260305090355.4946-1-thangaraj.s@microchip.com>
 <20260309184611.4a98d42b@kernel.org>
In-Reply-To: <20260309184611.4a98d42b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB8804:EE_|IA4PR11MB9417:EE_
x-ms-office365-filtering-correlation-id: c796bb3b-8e51-42d8-3ad3-08de7e576893
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 Qp0O55LfTGeN01ILo5k9ASMT63+yaEtpnGTr/AkiK9/mYUdc3qXoXY/SyGX4eEjNG+vtQX5QEj7jleITu7Xro8pT5wveqvoFGB8qKqAeL5Wd/SDJMfRPEO7j9RUBgBpWXnzIA4JiDL1RnB799FWLtUSBtHWai91yvTW607CTCqgQlVZTSNIXjptIo2zM6aG7/YvicDbYTYDeoOGO3Fo8r1SHUOCvfx5B5wLwoehnBPvPHDjPqx5FckUpF6pw0MExAe5U4YgDbBtIcmUDGZsGSl8I593Yf+jGRvdOB84w0TP7q99Ago7alHzl4snQ33T//6Rpus8cBxVGQgFkOJO9ax0ZsdW0v/nc7OhEuwg9QsCoJvbp2eaP+20SyPGyHfcfDpwYcshxzYsLGhT+3USqMYvyGBJR48Zwhh/npUWEiIUOmletnFdAAUck0hXa2pf66FJM96R5zbEiSYe6gXjDxZwzTdydn/qLquSVMiVuoJDTMsIkZvOfE5Tl7HXYFIKiSreZqE7QwZ8L4zCagWABk8RYZU9jOTBuTzr8oImExhgR0f+te6X8cvO9fFN0BJ5eYTNFLRlG+I9l8M+BfTEajy8h14qsFK18w4u05AlKYWoD3ZjLd1onOQ0h4LuPm3rfZ3UrIcDqfcOe/gXLgltdPBcJJS6BO/oNY23oilepMIBVjZuZcqPmGPAfi240Q3n8cQbTNALUcNi5mYwGSWclG2VfNxg9mWM4caS1gwDdTXlOvyHDn+L9lD/VaM/I4j8LOLc/niKerBpKbTRkLoGo3MClAQbLpdm5caENF0a20WE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G77CDxHnoCUXuWaOELkVH4B/V/TSYAy4n0cE0sA6Lev0G2iIlsDgJIId3t3v?=
 =?us-ascii?Q?nGKsWj15MnZA6hx15aXSPmceJdo4Wnkdv+0sk6s4rSTRlcmuNRrzx4E0iTcR?=
 =?us-ascii?Q?W4AEFBYI5Ifj8m3eSEqNA41hChNV+lckrfBhfpbbEDsE68t7tdXueD08rKDy?=
 =?us-ascii?Q?ZnvAJRvqiOUoX/yokm3qq4Kp5Ku+0OT1wNXUj0iBVZo4UNz2stwkb2p3DJi4?=
 =?us-ascii?Q?qFVUTLVANZrlkGp7wGi1NrncsAO5wH7JiNKuRLPo2oKkqTCy2T6rt8vRA6KD?=
 =?us-ascii?Q?Dz7hdNVD6NN9wGOZlw7jcw3oqxo/U/gwpQj9KaDCiDuJSzbttfZNxhHQrgUP?=
 =?us-ascii?Q?vR8diBD8TaKkNE1gNZUwpM97kY4Ux1T8AE4wUmz8U6Ilc1WbGokCYBM652CL?=
 =?us-ascii?Q?K6QniUfe6PgUit4CXXa9ysVnKClCa1GNr/WGaiIBhZ0oTwy5JpOc7tNjQpyL?=
 =?us-ascii?Q?N60u6Ltj8UcLySzpqB56cf0hAuGQazjO6cI8m1KLXQzZOJNwu4MP8b9jA+tu?=
 =?us-ascii?Q?HHHP0pedGaSJ8XiEtQw7SS5RjOLaiFdBxJfYFJVjDT/seYeiu3dv57WG0jmZ?=
 =?us-ascii?Q?QPv/SZ+hdtCDGK2triEHFpmXEPuDIh5mPJjVzwc5B3VDMyOGwyBnNvGwnRqV?=
 =?us-ascii?Q?+o45O1GM2mz90cgNtQ5FK9a2AYNCTpIlQCGSC+1rszKecYNbEQsbdhZltNXL?=
 =?us-ascii?Q?lGHEsM6SsZv95R55wF14IUVqxk+g8Y377CS4+DPYMxJAjezc7TXVAHuUlHpZ?=
 =?us-ascii?Q?cpFNaaPgohHqbs32Bjg+mYe+GssvV/sU8PnwY9quCk+bpkqLxRuMF/WgiykL?=
 =?us-ascii?Q?ftdHmEqejcQUSorqHUiafxFV0xJJvS7//wjat2mQgDCddRHjiaOb2TLn7ga9?=
 =?us-ascii?Q?C0WDXwNGdsFXbC6+2bp5hd4up9T4l3PFRnJYxacZL3NZcS9CfM03aGwE1dDV?=
 =?us-ascii?Q?sIC/ALOQ1dwvxmLBQAOpfUkB2wG92/4J+Rdux22RpOb9rzyAZii0XGbftNL+?=
 =?us-ascii?Q?28FgS94UhRG/UVfkT7a+35g7zauLVbwz5euENhQPYaEJ0TSVYmOHi1LuM1t0?=
 =?us-ascii?Q?mTQaV/E17Im07s/L+XyiMnSW/p6rUeN7wP/LvDobvZlhWzI1j8ZvScZq/maE?=
 =?us-ascii?Q?Ndj2UFojPUteOOtMhwDucyRWJCZhMx9C2NFkjASyPhMAvEYebyiXqRsZm1OD?=
 =?us-ascii?Q?aiPoWFSzw51QUNqFEhLwqFwlK1Axq/a5paApunSDh9MzAIaDGJwqgZCrpj2E?=
 =?us-ascii?Q?CBPe0C8+yuLcs48z7sxETpCYHECYCTSljeWhQ9hLFh0G+ElbDaTodMvi9hmC?=
 =?us-ascii?Q?MBz+FnzYCb1lguihhAp8Dz7mYETOoAiWFBt3w/XbXirqtgOn2YG6MK1R3M7X?=
 =?us-ascii?Q?Ca+vW4ehmlIi2aWgoBlgNPNsQ6oc8SRLObLdbXUEPljyUtZ60jEN5whVGJgL?=
 =?us-ascii?Q?FDgFcfvzwTA2NaDbSfgqYhsZ479fc1hum0ujtp35UUGS7MMqS06iTExdvd15?=
 =?us-ascii?Q?EFvBTYtMUjzp6thSwiowJvSvLMJNBYyLogwoEqsoobMIXQb73/2xesPOWGvs?=
 =?us-ascii?Q?gGWR3ShW3U9IYOFas9a6rw6eWlEjM7mCunI+vk9QKU+xrMJKoVYk7EnUhfmX?=
 =?us-ascii?Q?Ap3ZPPZ1iA1p2bukMqzCt1vovh9zJfoJX3UVJ+4KUnP0xS8dGZBGxpXg4T/h?=
 =?us-ascii?Q?C0peaUVdl1PLnYicc0KeXDA0Pb2dJTHPHYknFmYMyoSbp1M/0RbKwapoddSq?=
 =?us-ascii?Q?iS9jYHNqrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c796bb3b-8e51-42d8-3ad3-08de7e576893
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 03:45:01.4462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXkUgjRMZGU2HlLFIA1BFx7PAyXb7W2Jv9zElIMuVDdZGlSeqlZTKISeWY+cj4ZUHRrQHsYy9r3FDMtxPVFJiKP7yVFNppBC+YIUkgOiJpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9417
X-Rspamd-Queue-Id: 465BD244F73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-265888-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,lunn.ch:email,IA1PR11MB8804.namprd11.prod.outlook.com:mid]
X-Rspamd-Action: no action

Hi Jakub,
Thanks for reviewing the patch.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, March 10, 2026 7:16 AM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: lan743x: fix SGMII detection on PCI1xx=
xx
> B0+ during warm reset
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Thu, 5 Mar 2026 14:33:55 +0530 Thangaraj Samynathan wrote:
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -32,10 +32,12 @@ static void pci11x1x_strap_get_status(struct
> > lan743x_adapter *adapter)  {
> >       u32 chip_rev;
> >       u32 cfg_load;
> > +     u32 dev_rev;
> >       u32 hw_cfg;
> >       u32 strap;
> >       int ret;
> >
> > +     dev_rev =3D adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
> >       /* Timeout =3D 100 (i.e. 1 sec (10 msce * 100)) */
> >       ret =3D lan743x_hs_syslock_acquire(adapter, 100);
> >       if (ret < 0) {
> > @@ -47,10 +49,11 @@ static void pci11x1x_strap_get_status(struct
> lan743x_adapter *adapter)
> >       cfg_load =3D lan743x_csr_read(adapter,
> ETH_SYS_CONFIG_LOAD_STARTED_REG);
> >       lan743x_hs_syslock_release(adapter);
> >       hw_cfg =3D lan743x_csr_read(adapter, HW_CFG);
> > -
> > -     if (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
> > -         hw_cfg & HW_CFG_RST_PROTECT_) {
> > -             strap =3D lan743x_csr_read(adapter, STRAP_READ);
> > +     strap =3D lan743x_csr_read(adapter, STRAP_READ);
> > +     if ((dev_rev =3D=3D ID_REV_CHIP_REV_PCI11X1X_A0_  &&
>=20
> it may be a good idea to a add a little helper like:
>=20
> static bool pci11x1x_is_a0(const struct lan743x_adapter *adapter) {
>         u32 dev_rev =3D adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
>=20
>         return dev_rev =3D=3D ID_REV_CHIP_REV_PCI11X1X_A0_; }
>=20
> and same thing for b0?

Sure, I will add the helper in the next revision of the patch.
>=20
> > +          (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
> > +          hw_cfg & HW_CFG_RST_PROTECT_)) ||
> > +          (strap & STRAP_READ_USE_SGMII_EN_)) {
>=20
> I don't think this implements the logic you describe in the commit messag=
e?
> You say:
>=20
>  For PCI11x1x B0 and later: Use the newly available
>   STRAP_READ_USE_SGMII_EN_
>=20
> but your condition will also look at the strap & STRAP_READ_USE_SGMII_EN_
> if cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ || hw_cfg &
> HW_CFG_RST_PROTECT_ is also on A0

This bit was introduced in B0, but in the earlier version this bit always r=
eads zero and makes no difference.
> --
> pw-bot: cr

Regards,
Thangaraj Samynathan

