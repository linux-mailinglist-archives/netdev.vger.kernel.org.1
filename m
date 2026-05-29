Return-Path: <netdev+bounces-293198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILqeNnXhGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:56:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D959607918
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD3A93054A14
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2B43E48B;
	Fri, 29 May 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="enOdcLq9"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976143DA4E
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.151.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079990; cv=none; b=iqBBAgFk4RADgOuw6vJ8EbtH9TZBzHHm86QfqMAhLGbe7n6Xfq88w4NR6IDKdVOWO8vcHpaPhDaVg8HqHk3outf1WdeYOKR5NgxoKSxUgutywPWzR7J64XxkLf9hmIBW23EB2lXB268UUrp9BF35mD4Pc4xyjoqdjFBg818gH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079990; c=relaxed/simple;
	bh=ksSgRle4/VlrMEq2PpJZ9sDOtWxzEyBT28EIUzx+aIs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EtIrEqS4KyxeXKxGW7lTmIhQkrEALCvnY2HfZvl7Whb1wIUWNpUmPMycwJCHRTFV9GtXW3vFayEHHMErsXYAaNnqG4EUtsDUuH6coDqQhITv3nFNrL0C1QrGq+ySfEXIaKD+bZzYVHxIan0PaXBW56cRwx2/ucLugFVWi/9hflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=enOdcLq9; arc=none smtp.client-ip=170.10.151.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780079988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y16LTCnGK2mzfuIaoRYruXZcKhoKG+j8Tydj5J4MrkM=;
	b=enOdcLq9lYqa5dskEdBacOgMpYGXHZk+Jqs2sUSYI5cGv95AVlF95rYPBCkupDLhD5Sq+N
	4L6kVNxGPuA22AqfI0z6saUv1i8OOav6AJ7ZEvpVzV1AK/HD581rZ6efWq1fWqepcMVCRs
	kBA6OTBcarnYYzpV6kzNQAekfjtluE1QtU94GsiqZlsLbLOCHvNDvH7NCAUXQiJWG16PjH
	Bv7mAln14oLLrs7eA9hkgQnpOlG5kP+gp3gmFp6JCsFLNyyMoazY2J17w9v78NDtGRZfbK
	oN5errrxAOPum712JlD1yeviVM2HxBAe+iygNC5N6H5K5TChL4GkLUb8RlmgPg==
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-1-c6aedchuNgyVv4Ikaj711w-1; Fri, 29 May 2026 11:39:44 -0700
X-MC-Unique: c6aedchuNgyVv4Ikaj711w-1
X-Mimecast-MFC-AGG-ID: c6aedchuNgyVv4Ikaj711w_1780079981
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by DS0PR02MB9046.namprd02.prod.outlook.com (2603:10b6:8:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 18:39:39 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:39:39 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"wahrenst@gmx.net" <wahrenst@gmx.net>, "jacob.e.keller@intel.com"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 03/14] net: phy: microchip_t1s: Use generic APIs
 for C45 read and write
Thread-Topic: [PATCH net-next v3 03/14] net: phy: microchip_t1s: Use generic
 APIs for C45 read and write
Thread-Index: AdzvmBFC1SigzU34Qxu7YHkJB60sJQ==
Date: Fri, 29 May 2026 18:39:39 +0000
Message-ID: <CY8PR02MB92495A456BF9029FFCC1D4FB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|DS0PR02MB9046:EE_
x-ms-office365-filtering-correlation-id: b98e9775-a86f-4060-cbbe-08debdb1a45a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|38070700021|18002099003|6133799003|3023799007|56012099006|11063799006
x-microsoft-antispam-message-info: KA2hcgsUDAZ/WAlhDdjD9KCszj0eQEw2DtyDvKzeL1NOEjOsM+g68LNz2j6kH+8YAQvwvIIQFjTuzST/pWmudYSFlPuwVO0EYsm0gjbSTAcuSov76+CZJqcW+PVXLuEUBumJaCRX43scVzb+C4WamFHSXbMEqe0LOryVMGt9fNnjOkoMHWRTjRybu/zn0eM7905nuGS8UW2LdDW/2SX7kBdoR5dEVsBmmYfOYSLRg+cjrmYFL5nIQIXf8U6KvLp5aQ7lyhw1HIsMPfhyV0WTNsdIgppxVbsve3vWqiGoIcisG3HN4AQruhbPRDQQ/iCrm3HjMkygmnr+8yzqXl+rTFSStkJ3Rv1xbpPhFv4diAdScUiCEb9HTpwWzi+sUAfzHw/S20BF915Par0YdHTC3MrGIAQxq8rugEXOj2neAVzOngptiDyFt3TQNijlt46pXTz+bnVevKqTp2Vf9n0lrM5sYZf+ZdZZ0f+EgCSY4Gu4H9bmhl0OwzoiY3ZYR5nvrEsw2rt4Z4YhxpE/gwMkKaI510Bg4I9T7mAV9tpA9/2LlcFUJQKgX1f60p+7UmPXOl90C/HKMHb8LOHmbVimg71GF+uZMX+5ivhJGog1AE6LftQ5qg3gS1uTXZzBSoh4vgWpZY12kpac6FRp4jH5kHGrdcHSvKRCfOKHpxO0dAjKEOWn+/1cjfRS6Qk5jBApI+nZU02kiXlZ9Z0MK9NNFbK5fJXINcwuWKXQW7m983AZoUlv0l790xCaFuVDnJwg6GFWHZJsp+h0BuOdOPGIuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700021)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?spDMZ14KAQuizo1W22skdm4lLNODrkr7l9XXc/NMhOUxaDNzjUxMBQUy7q//?=
 =?us-ascii?Q?A1ZLfMiuVrHAPcQsiVm1OOttZDMQ1bwsdL0Bznyknh2FkV353Zl6KdTRg2qV?=
 =?us-ascii?Q?d/rwLCLPTpv785l2FpIsUPZ5O4KBvBPnGSGUCjOFNw4wNCZenj649JCh8zsL?=
 =?us-ascii?Q?quTfdk17TeULfpV6j0qDlFVQLOwEMr5rhHamrw8svPvVZaVHYJu1z1skRkWX?=
 =?us-ascii?Q?czDpDE2VdpZNEfZ+xoZNde0Omj4dyexzwYw6FusMbSOG27tyw+qSd9hcSOqa?=
 =?us-ascii?Q?VRcbHiCj/kCRDkG+Nq0DWdy7NbjyjWFpm29BUE73pbGQZolUSKfzwJWb8Ssr?=
 =?us-ascii?Q?nYcB2JZKfdIGQA83TlFUpU5QZY8d8+0NEobv4zhkTfAFqrXekL1Wcocv/xEN?=
 =?us-ascii?Q?41z35nu5o1rMPFkMpPUZ4KvyaAkWZ3KE5lGtWI1r6EzDhObhloUhhJ20eJY3?=
 =?us-ascii?Q?JsEWrZg75sQZU8yPVbO+aQt+sDmjGXXuSTiMSQtNKWqkef1bR7EppXWcfvxP?=
 =?us-ascii?Q?nil5IqyoWSMbywFRpXUFoY0Gt9E6C3U7LdrtWSrBRwdCzd+a8BtH12sGwoJX?=
 =?us-ascii?Q?AJW2HEWrSaTMi73Xyi683X943etsjddHbsbxcZ7GvMkuOPtaO3Cn5j2WzurK?=
 =?us-ascii?Q?CBGPgRRXbFs5PJBMvQNtnJEWguzgkfPzrDKTs9X8vX1FkMfaWoUx2ne5n6/N?=
 =?us-ascii?Q?AoXQlSkgj+KAMmeZYpTdifQX3dJARPk/MF6UF6hxtVvcm80iiltHM4aShOBs?=
 =?us-ascii?Q?yvjwH/eUJTiQKszElupo8rrvnxNg5FMXsk95unDehcFOTNwUAhvZrti8EDfn?=
 =?us-ascii?Q?0jN/xTLvw7r1TQjjNUW2nUEXxVdiZrQq4Tqp0BiamrfVAIXv1QAdrQvrr40U?=
 =?us-ascii?Q?lPrxtmd41mUOm9xLVadwy/xpnrN4mFJzuGRi9HSAf++0YOP6WQoBjrjIeBZO?=
 =?us-ascii?Q?UMV1qUPIO57/Pe8izBGq/uRP2FjAbHHbIXgqhMZ2/44NkxUgB++tA1xsdL1p?=
 =?us-ascii?Q?iSVL74mFeyF9QNSFKs1jPIX3pKe64rwgHInfzAdGhZxiZyYRAZcoc57mWTPj?=
 =?us-ascii?Q?fGzyv4KfF6XmlTSvglAnJO/ki3nDVod0UeJl+Ps2xdElQTWh0Md5EI1mnQI5?=
 =?us-ascii?Q?LngA+9ti9aXmLgUWA7pDzAHPx+ydITZFF4IVNCVVDqKLSCyjQYtUpnfj8GOx?=
 =?us-ascii?Q?sjHHTsdd/vJAv3S11C9CIwCVm4eMppsYIrs66i2EQwXrR239A1e0PrKrKMc/?=
 =?us-ascii?Q?oXvD+iydE3g9mvWTw0BBgucSaFov3x8YwDwwUhCBoaCLTTsMjpwpRRqo64A4?=
 =?us-ascii?Q?FRS1Tc26yfNk0GTo5oYx/6sM3y3Ybwgv5u3lRv+QWB/Q1BmWXbljj2sw5PH+?=
 =?us-ascii?Q?xgqTFi0ORm60LTp/6I9/keT3zRtvmDdxJMm6IJk7Lw35OyArexjx5KoLQtbW?=
 =?us-ascii?Q?dAmG5APifk/95UPVmhhQ+20A/eDJEpdWRk+xw8nqZ2igX9QQywNNUxBvLOYD?=
 =?us-ascii?Q?6O4mTHeKSYVimFFOvomqz2/jnhmdUnBtUf+LPzo/V10JumjeTYGtyA76cLI5?=
 =?us-ascii?Q?L+V5YreWS6OOPzqLVYysVpqekEB3U27mrtPUR4WYlNiWG4wDlHMImPAIxxZu?=
 =?us-ascii?Q?TpU9R4xnRFtscmmyuF/Ana1NlCJlPHxEtZPKnqZPHkeogZmkT3V5qA1I9+dP?=
 =?us-ascii?Q?j7uCAWvjID7G2B0y1FfmfUYrhqiLhT6zMHMDY9M1H6nczThIsGW0nTeVqlOh?=
 =?us-ascii?Q?9SOA6s1vXA=3D=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jNOyGXtkq3N0HEBHat7kTlKBQPx7NCvVVDCEaTPWYxBkbCNFtawlAoOoM5j4pEv89nI/5r1SPTB6rwEZeoApMS8eQyWGigtM/LuOfbTefYkEtX5rlLzDNQHoUW4hM3+x4XDoUwtyxpN9Z4J7hfjcoAcxd83fg8GInP583yqJllg8dHk5iqz/rDjr1izt4KE3xDkJdiMDsFuFMorE+WwFRSkH3FW1w1kRZiwqfF1LRPoV5eFw+Zm28h6XE6kPFb012e3PeIUg76z523zkfHCEpSn456Pu0860csj4lP4dTG++9Wc1ctiyoIsUvhEfQVrcSOapwUKTMFtmY0EwsIiJHw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98e9775-a86f-4060-cbbe-08debdb1a45a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:39:39.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: We/p/BDAwcrCZQGUsZWCmgqMLr8MCos68M8YdebvmN16nlFngmcTnqFULfTyO+4780uMwgrvtCwRjWfFYKGsXKLPERq1ZTJp94fiVcb/wOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9046
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: diNnF5lgYC4Pd57zz8_k7DPb7Y1Ru73RkD7SPLCDaeU_1780079981
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293198-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmx.net,intel.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,CY8PR02MB9249.namprd02.prod.outlook.com:mid,onsemi.com:email,onsemi.com:dkim]
X-Rspamd-Queue-Id: 7D959607918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace vendor implementation with generic API to read and write
PHY registers using C45 bus protocol.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/phy/microchip_t1s.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1=
s.c
index e601d56b2507..0c4dc70641d8 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -506,34 +506,6 @@ static int lan86xx_read_status(struct phy_device *phyd=
ev)
 =09return 0;
 }
=20
-/* OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and
- * C45 registers space. If the PHY is discovered via C22 bus protocol it a=
ssumes
- * it uses C22 protocol and always uses C22 registers indirect access to a=
ccess
- * C45 registers. This is because, we don't have a clean separation betwee=
n
- * C22/C45 register space and C22/C45 MDIO bus protocols. Resulting, PHY C=
45
- * registers direct access can't be used which can save multiple SPI bus a=
ccess.
- * To support this feature, set .read_mmd/.write_mmd in the PHY driver to =
call
- * .read_c45/.write_c45 in the OPEN Alliance framework
- * drivers/net/ethernet/oa_tc6.c
- */
-static int lan865x_phy_read_mmd(struct phy_device *phydev, int devnum,
-=09=09=09=09u16 regnum)
-{
-=09struct mii_bus *bus =3D phydev->mdio.bus;
-=09int addr =3D phydev->mdio.addr;
-
-=09return __mdiobus_c45_read(bus, addr, devnum, regnum);
-}
-
-static int lan865x_phy_write_mmd(struct phy_device *phydev, int devnum,
-=09=09=09=09 u16 regnum, u16 val)
-{
-=09struct mii_bus *bus =3D phydev->mdio.bus;
-=09int addr =3D phydev->mdio.addr;
-
-=09return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
-}
-
 static struct phy_driver microchip_t1s_driver[] =3D {
 =09{
 =09=09PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -584,8 +556,8 @@ static struct phy_driver microchip_t1s_driver[] =3D {
 =09=09.features           =3D PHY_BASIC_T1S_P2MP_FEATURES,
 =09=09.config_init        =3D lan865x_revb_config_init,
 =09=09.read_status        =3D lan86xx_read_status,
-=09=09.read_mmd           =3D lan865x_phy_read_mmd,
-=09=09.write_mmd          =3D lan865x_phy_write_mmd,
+=09=09.read_mmd           =3D genphy_phy_read_mmd,
+=09=09.write_mmd          =3D genphy_phy_write_mmd,
 =09=09.get_plca_cfg=09    =3D genphy_c45_plca_get_cfg,
 =09=09.set_plca_cfg=09    =3D lan86xx_plca_set_cfg,
 =09=09.get_plca_status    =3D genphy_c45_plca_get_status,
--=20
2.43.0


