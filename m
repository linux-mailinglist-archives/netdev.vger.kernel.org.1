Return-Path: <netdev+bounces-293205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCXLOj7iGWpmzggAu9opvQ
	(envelope-from <netdev+bounces-293205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F66079A7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABED83094592
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421B4611CF;
	Fri, 29 May 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="eQ+I6iFI"
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E94534B3
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.153.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080083; cv=none; b=n1JPyzQr1EMe2G1sehKxhSIgn2bdhA7hKDv0mN9u19+WALiG1aFiaDjU3CaDCbdEEJr+IrrubW4niW0cPVaAhLoJ1BVTA+5gy2tYeWuY76nzBMwf2ljvZ20OPtJ2WgUk+hsZX7BdTnGGNaWV9lfeOOwZJjQ6wVl2JjTdJWmTYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080083; c=relaxed/simple;
	bh=hsj+K4tmwE+cJ38+cXRvs8st6bUfDAIFMZFIpFVoQVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dUCGsW6/KqLWZD5E3PECet5TuSQV+KID5Eo1ROyTvTOjO0yNXGYgqUZWqFV/Xlk6YCY2kwnwZIo3Q3rA/n+8QVAq6MP+/OURZFnSzQOjQAWG3AxgPlWnnPcl27KE12FysFrfv0dk3+DxoeYIyjsJ4qrqKbulNdzXzGHIVuONjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=eQ+I6iFI; arc=none smtp.client-ip=170.10.153.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780080081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9MuGT9MvV5rdIb6/8NpgUF4u/MEJFn06sFOpsvnFEnE=;
	b=eQ+I6iFIjH/JzieOiDFJQ/D+955w9j+JeQdVG6gwFv5crJhQwmMAK1ycJsREamOFJCE3ES
	euXMlPVogkQUjOjzHpIB108EQ12GWSrm98kBVjO3joa2iJwSdQJGNlROvsKB/ouxOmMAqQ
	WINxoFVf15Zvf4d1vJFbnNcI7YaWuv8M9DDJTM5faNCEPh9C7AHCwlLWqPOBZK9QiY+a+u
	blCHG6vAhQGEP+ZRpG4zTjKaK3RadOEK3pNorknKMOn2t/VTn869Pn5JFVVS7yr3Cjqri7
	hgXt75z4qLLmEa3JStU1Y2K5tzwME72JGXcRVNXBSo+lgkQQebiZCXw8k9oPHg==
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-70-dGwzJKsxN8qKWL6_H03QVA-2; Fri,
 29 May 2026 11:41:16 -0700
X-MC-Unique: dGwzJKsxN8qKWL6_H03QVA-2
X-Mimecast-MFC-AGG-ID: dGwzJKsxN8qKWL6_H03QVA_1780080073
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by PH0PR02MB7399.namprd02.prod.outlook.com (2603:10b6:510:a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:41:11 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:41:11 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 10/14] net: phy: ncn26000: Enable enhanced noise
 immunity
Thread-Topic: [PATCH net-next v3 10/14] net: phy: ncn26000: Enable enhanced
 noise immunity
Thread-Index: AdzvmVFLM7TbV4+NS4+4Cu0xCWIFFQ==
Date: Fri, 29 May 2026 18:41:11 +0000
Message-ID: <CY8PR02MB9249022FD77BEF360103367283162@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|PH0PR02MB7399:EE_
x-ms-office365-filtering-correlation-id: 17afeaf3-bf3d-4667-36bc-08debdb1dae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|921020|18002099003|56012099006|11063799006
x-microsoft-antispam-message-info: DVpniGcRrl0xSUGTO1ncoGp7nCT6CT9X+57ifsoE/xujFA5psTOACLE4RVs05NAc4AZ50E4gNcu+fuHlTNdrfshHC/XOWhqcODnfTTjimpFmBDyso4IkAOiuWgx2lwO6dQiczyys3pvgYYqTI4OxBNZvjKXbcG4DeDFI+d47muD3KEWlaZTdidTJWDVmC97RJi1EmhX1s2m2ILBGjvlFL9nLusV4lZpYjW63Vw0QYfLeGmLJP9WLnYF79s9s1L89RTprcesThVeKpKQm1vzijwv8rr8sI8zQfap8Mv4FL6CkTVTv2reiwjGbOkhS7dsyEZkX+yioZjsBPZHHVjoSETVFnXEqh8yxNnNAV/aJaBT81K4B3sEVrhBXGUCAUwIU6TSE+iTSDwu4v9IrrUpPCCtNVe8wG3hoJt2vX8xJVMSaVYHpBA4y46hWqeHAWJNOshymj0056RoDxUl3Q2bFqPsg5XDKlEJp8u6gKl2NmdAeOj2uFV4tQfhELvWD94g94RuO+I2qOF6RalkPhoXPCFKpYI49qrdFwRAcE+V1pwbjfjsKBfQ3xscYrRcY5ymLwSebc22DkGu/5lJFICKC9A9gSijhgftReTHpW145OCQXeZG9av6TD44pmD/zVMlDLPKuhOBbOaVczRIGJJX7ZY8rY+4RjOWU5lKGl+cqStldtLaPX4a3eyG5VQ3HHVlao2d8YCpoyZBAoPL9NEym0GkmhWuAdjE7A8cYw7yUQU143bewHefsyH96BJjpZVwLJq4SJJa8KjkEQUu7YHkfYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y/mz748iMD57ueFkpJBTZ6S7UZvqzNfJdDljAgNanLZAGVZB7adYW12suJGZ?=
 =?us-ascii?Q?XKh5S5qzi949Of3ITcObTJuaaIrqZ77tcnwxN1cLG6cINayg/GlfdB8xjlDi?=
 =?us-ascii?Q?Rf3tiN7JV7hPnUnMnd7kVe1lulIbfBoMw7oJyL+RH7fH/gp7t+6JfI3M7nvx?=
 =?us-ascii?Q?/A1dYZYKnUgjjjKMznGk2iOg3uDXBgLbUuH+FMLaG8NPWEpP5L0Bse+gLd1y?=
 =?us-ascii?Q?kZ4E+EB3dm4VfLIJ0lDwx5ypGKibzNk+VAxsGBQpw1TWTw+ZLNTQ/FnSoK27?=
 =?us-ascii?Q?l41Vl98QmDtlkQkKRRu6r3yO2VRtKjtL6JkIVnp2yX51YOtTSYJgjPosq0k5?=
 =?us-ascii?Q?ucHnO5JVGxoMDv/dWFS9uF9VrMWk7/M73e+evyuGWtwOTMa3WRXu6KG3X+fJ?=
 =?us-ascii?Q?oje3TrNM56AQZpbCPaRW7HHX4DYtbTd3ZWc0jKsmxLX5pvQjMF+OlxfRwZaA?=
 =?us-ascii?Q?xCxJc76+Oxi/JxmsHw/qmcyk38gTZRB5HGOl2iN/v3588P/i/hTQ+VjFm/Ew?=
 =?us-ascii?Q?rvrmU1VncqGzzYnHdPrxZbaW8nbEQlsdbHLUDWfbX9k2wIIwh0p4uhX0MZID?=
 =?us-ascii?Q?bMIRC35XmekIRXHrSc4jn2ZCg4CcDRcCm3tN7LeDelqHL/SXIQX6OZIBaC7g?=
 =?us-ascii?Q?A+n9U6XpWBf0bKN5A5Sz8mHHQb2WmWO9N3oJ6kDw+LVEDvFLLYvFyrg3iQ6g?=
 =?us-ascii?Q?V850qam1OgrhcmqbJvbgWHzZAnxZx446hgHTmk/XlwnjvMLi4+fcWx+z/I4w?=
 =?us-ascii?Q?bAmJvYHivV5ETqLsaT3ZMLZiDKp3gqQmAFRcyPw5Iin7ydyNJ8vwEAWmPIwk?=
 =?us-ascii?Q?1U0LKjGpMWRYbChjKe3YvDRyVSfmAVzI+Oal8Di7PRM252J4laD6OSSNijfU?=
 =?us-ascii?Q?igG0lae7QYIKZMTpkGoWCAlR/ZpjkSmQZDKOSy55yzMW9wQJH2wd01BTOOpd?=
 =?us-ascii?Q?TD+975yuPFUuU6sklyyfDcHz3/JGC8UPv4se9vLWRn63KR0NgjYIDDKT9sjB?=
 =?us-ascii?Q?eKx0vHy0LNEmZXdl34EzTC9bMqPWSkVqLpPCGPcMNL/HfcnvaldrH8MfSya/?=
 =?us-ascii?Q?jsx7nv9sGdyzbaGBDcFvdHCfuJhoiW/J9I7SKjLnxK7VJzjOTUGdX6st9z88?=
 =?us-ascii?Q?nvLzV1LMMflTq754E0OhnPzc1/Q/tmAD+wgL6/DftPfQcY4GK9TiSFx4IgxW?=
 =?us-ascii?Q?UqiN5cWEsGXZFa5KmnQ1PGOwBrL4iMm3sTFLYEG6c7K6saGgp7LNAl1Cp/GS?=
 =?us-ascii?Q?K0QmpJQRpfCNFLGOLVbbkESdVLGzvpYqKvCxw3iiv8gjbNk4gof1jBkuplUc?=
 =?us-ascii?Q?gbhtS0vmznvWVI/8G1SPa6A+RO9cPzm2zXEG/SvTb+Wa7Mb19d1JD+x8DmJ5?=
 =?us-ascii?Q?Qw3/oWgcUCPvG0Fkz4bZj+aER/I6z4LlEtrb8ZRhG9SNC/WqAo+WYBZKVj8T?=
 =?us-ascii?Q?F3ZQnXRg6idcAhLfoM9e0+I//z6CQmBvjMSyChQbLinLB3hK0zxRKMEWN1gs?=
 =?us-ascii?Q?UhWpMA+O4Bwdt0NLRAjV8YxSwJZ243D2YiUwMgwVW2M2/yAjXmX2R/JE8hOx?=
 =?us-ascii?Q?AyABLhdfNnZqsHCejGzcabZqsBXpc2hm0bHeMZIh43L+ZdP+OEXV+eSgP0K8?=
 =?us-ascii?Q?KFZBqXaBBVDMtm2iQc75wSAPB+C2T4hvz4ltRpk23o32q58oTYyvuO0bH87T?=
 =?us-ascii?Q?gBKL55nQV2vzYt/SoHb5JrIYx4WFwsKyYH/G723RWVGq5/qOtOVvOYdyjzym?=
 =?us-ascii?Q?rhSxUcmb2VR4k5rLBBkLKjL4tukxqL0=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X6TGwGVRPVg4vVBek7Im8HyILeYRGVBF0unLqxZpxlfSh7Uru+Yht4+XJZXgQ9uG3KXM6uxz25NhL320flKtt9hSwI+YpatFhH4R6cxicssT+dJ7VgQ3cQDDE0r1KkFxZ+aXceC23JiW/w3s21KL7b10XMJIVq4rDydxdoR/iyYFkSYRM/Z5L9seo01Y5IzZFjo9HM6A8Otjn24uO/PQQILMaPNIc7mSJso02pHSQcg/mnLjrTW18wxj/VlQ5ykruPCKR1tV2bXc14L46yrkPKTeB2lRz88liWyMEshlaFDxTV7pdTgAXgjgG+XeWl19extfII2Ox/+UviJWveETdw==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17afeaf3-bf3d-4667-36bc-08debdb1dae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 18:41:11.2025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P967FmbLByDrK/TbwSFnqF+LpCPAVhEDlaBd91eMEYsUy1wqeEaMRs3RFl9v9O6Th1t1Y7/Tl+fHlHPgkfGsTWa7vrtUSJnq76AO2AVGvTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7399
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N3VtUPstUG-5_sEhf0m_3DjNNIK-pVrKKSUAnCb5aNU_1780080073
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293205-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[onsemi.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[onsemi.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:email,onsemi.com:dkim,CY8PR02MB9249.namprd02.prod.outlook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 928F66079A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By setting ENI bit, noise immunity is improved and it is
specifically meant for PLCA enabled nodes.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/phy/ncn26000.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index 2c8601c3f94a..c3a34b2c524d 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -36,6 +36,10 @@
=20
 #define TO_TMR_DEFAULT=09=09=0932
=20
+#define NCN26000_REG_PHYCFG1=09=090x8001
+#define NCN26000_PHYCFG1_ENI=09=09BIT(7)
+#define NCN26000_PHYCFG1_ENI_MASK=09BIT(7)
+
 static int ncn26000_config_init(struct phy_device *phydev)
 {
 =09int ret =3D 0;
@@ -106,6 +110,24 @@ static int ncn26000_read_status(struct phy_device *phy=
dev)
 =09return 0;
 }
=20
+/* Intercept PLCA enable/disable request to
+ * set the proprietary, ENI mode accordingly
+ */
+static int ncn26000_c45_plca_set_cfg(struct phy_device *phydev,
+=09=09=09=09     const struct phy_plca_cfg *plca_cfg)
+{
+=09int ret =3D genphy_c45_plca_set_cfg(phydev, plca_cfg);
+=09u16 eni_cfg =3D 0;
+
+=09if (ret || plca_cfg->enabled < 0)
+=09=09return ret;
+
+=09eni_cfg =3D (plca_cfg->enabled) ? NCN26000_PHYCFG1_ENI : 0;
+=09return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+=09=09=09      NCN26000_REG_PHYCFG1,
+=09=09=09      NCN26000_PHYCFG1_ENI_MASK, eni_cfg);
+}
+
 static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 {
 =09int ret;
@@ -156,7 +178,7 @@ static struct phy_driver ncn26000_driver[] =3D {
 =09=09.config_aneg           =3D ncn26000_config_aneg,
 =09=09.read_status           =3D ncn26000_read_status,
 =09=09.handle_interrupt      =3D ncn26000_handle_interrupt,
-=09=09.set_plca_cfg          =3D genphy_c45_plca_set_cfg,
+=09=09.set_plca_cfg          =3D ncn26000_c45_plca_set_cfg,
 =09=09.get_plca_cfg          =3D genphy_c45_plca_get_cfg,
 =09=09.get_plca_status       =3D genphy_c45_plca_get_status,
 =09=09.soft_reset            =3D genphy_soft_reset,
@@ -177,7 +199,7 @@ static struct phy_driver ncn26000_driver[] =3D {
 =09=09.read_status=09=09=3D ncn26000_read_status,
 =09=09.handle_interrupt       =3D ncn26000_handle_interrupt,
 =09=09.get_plca_cfg=09=09=3D genphy_c45_plca_get_cfg,
-=09=09.set_plca_cfg=09=09=3D genphy_c45_plca_set_cfg,
+=09=09.set_plca_cfg=09=09=3D ncn26000_c45_plca_set_cfg,
 =09=09.get_plca_status=09=3D genphy_c45_plca_get_status,
 =09=09.soft_reset             =3D genphy_soft_reset,
 =09},
--=20
2.43.0


