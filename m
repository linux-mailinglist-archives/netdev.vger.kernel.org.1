Return-Path: <netdev+bounces-50398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718ED7F597E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287A0281267
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4C18051;
	Thu, 23 Nov 2023 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datarespons.no header.i=@datarespons.no header.b="S5gj/rlC"
X-Original-To: netdev@vger.kernel.org
Received: from esa2.hc776-43.c3s2.iphmx.com (esa2.hc776-43.c3s2.iphmx.com [216.71.158.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DE110
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 23:42:10 -0800 (PST)
X-CSE-ConnectionGUID: h3unLSw9QqiTNnh59aTg+Q==
X-CSE-MsgGUID: YXa0aukOQGusVfmWXp4rhQ==
X-IronPort-RemoteIP: 104.47.12.51
X-IronPort-MID: 3008470
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-db3eur04lp2051.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.51])
  by ob1.hc776-43.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 08:42:10 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q88Dz/9L4DGKl8Afiw0r04QAmLGYXTjn9WTNFwXfIJD7E4CFQkv7u6Tf16oaQepJ7HSmB65O4TxGwqBiGp/hovm9aetXuby7f7W9RoYWstQuaOI3owZ4aebmuI7Lyua+p26q2Oj4pXiMCiTMz8UJ9OG8jKI97IESE2N6+FlCNBWzm7lwPWQ/gn78OCMtKUThwlWWYyQSIBGKxTqYyyBB/xygjy90M4PycJlJEU00hHPjUUfKnOc+RzEbxYnj5+FCfJZDKb6a3Ls+VvB/UeDtvugYwBmUSmJ8C02yCJxDyNSZ322l/VhNYXXstGnsTCcRwyDNBUwWWg5SVoTc5KnIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nds7xqgFtBMgLJBFl6nNCJYhd2ZhB2JHCNmY8souYYo=;
 b=VpwxNOU7XHXpo4wHoPtzozHCtL+JNEsYO5CUQV0kVnCHgWg7l5L5yQAfl9RUDIcCflhAKIfAX/EXV/pi+3RPOWyfLcJPYr5CgkjVaNkHqxraTdWhMhtVBVNlf5cak89hdnwm5JDxrCBvAFhJJr3S5X9KKgTENZxl4yJXgIpkdVGVTANG+HtftG6QT1qbyfte0TbHHVJKbRtxcbpiIbGsJbh/Il1Q7Lt5fG0mR3OE9QBVeTKbg40knZxzClC9AClhN7vGv29JccUcfNqn3mtgCd1tYY2dSt04uuDQt9IWaYMFt+FZlNyoYlRBTPOyD87GJ5MK7QR5CDMi5r7U60uEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=datarespons.no; dmarc=pass action=none
 header.from=datarespons.no; dkim=pass header.d=datarespons.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datarespons.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nds7xqgFtBMgLJBFl6nNCJYhd2ZhB2JHCNmY8souYYo=;
 b=S5gj/rlC8iONtCsB8TjQEsIPk3Ig331NsKNqMpqpXiTNxsgzRSyk5vRH3ifpS16AllMChkZCc2lLIhQo0bpd/FBmwRHls9ZWG7lPxUbaAME4T6hzpfcyQO//2fsSvHZuz6UPYI17UJ12gAOszI9yVrL/QHfjhMMUQDyQt5p6wYM=
Received: from AM0PR03MB5938.eurprd03.prod.outlook.com (2603:10a6:208:15c::22)
 by DBBPR03MB10260.eurprd03.prod.outlook.com (2603:10a6:10:535::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 07:42:07 +0000
Received: from AM0PR03MB5938.eurprd03.prod.outlook.com
 ([fe80::787b:2abd:c03:8fad]) by AM0PR03MB5938.eurprd03.prod.outlook.com
 ([fe80::787b:2abd:c03:8fad%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 07:42:07 +0000
From: Ivar Simensen <is@datarespons.no>
To: "mkubecek@suse.cz" <mkubecek@suse.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: ethtool module info only reports hex info
Thread-Topic: ethtool module info only reports hex info
Thread-Index: Adod4I5dFMf6uPw6SS6MBqaUikNixw==
Date: Thu, 23 Nov 2023 07:42:07 +0000
Message-ID:
 <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=datarespons.no;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR03MB5938:EE_|DBBPR03MB10260:EE_
x-ms-office365-filtering-correlation-id: 895e26e2-3df6-460a-5be8-08dbebf7b186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5E2/Xpt+xAsKu+iwGC65ZH57/o1X8iCeMDeXNygVSybGFpNtl7U39P3Xd/RsiNMsO6+UNq4tOMIzU3HxOW79qvqS1aPlkboUmGIpyYQWPx8rP+oKAs/ujvWmTxQ46iUYex2PwRq0cE0e6U5LksO5zM1z9/RhqeMjCCkLXnVtCylf4HdCVnLpFD1QyRCT5WWRgHBmBLpnz9s5Mb3zet4svE0/r5SJfcsANrWD6FpkBuItagvfmf980QinFieNvn4JpLfYTzzfp/ZHDBCRvNSGpSfXwqupAUFqh+Q1SdTXYtW+ZJDD1J2Rjab+DLAzX4cr9rqaxHHx1vyWKM9yqX7FCwbnvPQWxGdKjFXg8YGHbUwEyOql75KdXRcaeQUq0XUpQJtu+oUwwpWWDZ0gEwHui9xuD5rbFOncN14pwrYC7BqOR6aZtd0ngeKpvXZZm9Ia5dLZeq6r2L3hz4weNe/GUdCSQMK3Um6lhT7nrXBfxX8dCPCriBHgfS27LsU6Op3YnUVywfO+1e1oNFo3u920BP1crYarYBzuIFRuciGPUouXBicCyhD1BvLX6riSW7ZJC45kWjRvAir5zwJlr86yvvKh1wU21FV6DG5UTM1GibZ6z4qwV9bVCihK/28VbYQDRu2pWkJAVFOKd+Ii/8iPNSP2IA6kU9wTQ7nWHReZSodXFA5MJdudYoCj/kR+3yTd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB5938.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(346002)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(55016003)(41300700001)(86362001)(71200400001)(2906002)(5660300002)(83380400001)(52536014)(38070700009)(8936002)(66946007)(66556008)(316002)(64756008)(66446008)(66476007)(8676002)(110136005)(76116006)(33656002)(26005)(7696005)(478600001)(6506007)(9686003)(122000001)(38100700002)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J+O4DIIxFpQtbdl+6kro75O8dgasALU1NFBvjO8Qhc3AF+osO0nOpHX5Xtxv?=
 =?us-ascii?Q?DRuQJFpISVloXdKNgDf3zeGuh3S6tor9hg54wmK3YRAMhQaNPvtkB7X2ONMa?=
 =?us-ascii?Q?x8sHx7hq7k6JGknmyjE4XODwTO9m3/WCR/vz/rMCPxrdqiWJroQT6ZSGMsr9?=
 =?us-ascii?Q?P8WZwJyIJqG1oQLD4luii5Kvzx0f2rqnpGdsMK3UuSaZUaKeIiYFk9398p7C?=
 =?us-ascii?Q?7/kqw0VxTA2Vj5KnvCEo1yJVZdW5Oy11B9OXl5ehR+CLvQgDMk1th75C67Nb?=
 =?us-ascii?Q?POisbM93NvmuFxeh2jOHh6oZsc//67/3BI68bU2lD+DbC2nrbONFb8Oc3NOF?=
 =?us-ascii?Q?S+H/PWxnvHg2yJ86KRiWa/PugqC6lWJCHfcrjUDQKOFDi+8tFgSC/YH5g6l6?=
 =?us-ascii?Q?KWhCvyFeFfV3IAZaVyJra11ClHgbF9WbkNWum3X6qOVeoPknPb+7grL2eqir?=
 =?us-ascii?Q?HAkK99dEPRBlGRevOcqX76jsHBYOHZ+FDdhXoua09rZdWyaFzKUyyD9TyuUf?=
 =?us-ascii?Q?FS1KlX1P6J8Y6A0mSoXF2u1y1zsTilHWsbMH0SCoViqg+NcFktcVc+lGLACF?=
 =?us-ascii?Q?jdZ4I/+cpb8JkazBPW5Aj+5gPDH+CEGO0wwe1fQ9A/UupNjI/f4gpGM9yfrM?=
 =?us-ascii?Q?kFqYpybDoZnXBxJOCmTbPrncX/C4WYV2+hkvvNg02clHbuuhKODlVMSQo4QR?=
 =?us-ascii?Q?G8SjvqyMhhNU9MDqENaWPcSWeDYmRVWoJq5H5QTiNv2Fxcdo4iIrdry6dqGW?=
 =?us-ascii?Q?ZkOJf18P2IqaWVqN/pMqLbz4il4ixDH+3iix6W7lSR+4/qPgYLh7Cbxaemh9?=
 =?us-ascii?Q?6FimYvmoK5PTLQIwPCFVAjXNraJQyHlyRRt8Hhn0Ca+is89wdfH8Lp+EgrTX?=
 =?us-ascii?Q?lnk5xvHMisfO1E6Q7D7fc1kbXtvBSn/iZ9XzCFBrJ9092X3tLV1kSO6EwTvN?=
 =?us-ascii?Q?xmwh/AcpJLigGrankZ1hB0y2g/jSvmNUjCQd9/yK3+VLHigEFIWn90SFy7Pr?=
 =?us-ascii?Q?NlC2bCXCSYyBWSyzJs3MIepIhaJYBIMQ8aSi/ds26BNTNv/5KFdDRxawVWJz?=
 =?us-ascii?Q?Qac95Apby8NG+3t7H1t7lHRgeMFt1r20ox6cXPkpPedYLMSHANrcNmFQo4uZ?=
 =?us-ascii?Q?e6QLeWzWQ6uJwJzhQZlxmGj1//bx/bIXCZSyx/AcNJslRHUvo4xptwuj0HxE?=
 =?us-ascii?Q?zzAdKFNw/R6IwkvQrNVTYRwg3/GuKRHiQdp4m5BMPpvfuWTzfZ0ZCZT3mAp2?=
 =?us-ascii?Q?cnf6f8zNM0AAi/xPjz4UHDhlLzKcKgtqUy6Ffo3Ey5dG3YeddTR7qUFQYzmo?=
 =?us-ascii?Q?6tzUskeN9NjIuEoa+1DIISWW4KslFpVk5/NPUokLhdHTDVTMH0x7rGz4EUng?=
 =?us-ascii?Q?KfORDwGklfZa32XZmPKo4TaSZnwMeuy9Ldc4VYrN8bYBX9I7eh3NhMtrUFDA?=
 =?us-ascii?Q?g2eg1wrPb2XCQGZ9++0uyYrcc6Oqn8T3lkP+0emYnNI47XO+jzrOe/vHd/2a?=
 =?us-ascii?Q?BwPwUmJ9POzq0rEX7SCfM8+LpJJgdtGxe2r5H+BF3Lf7tF0xtGVs0/mtvhp3?=
 =?us-ascii?Q?2QHudjE51KEGkVUYLNE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x38gvRcYephJ43l5EZ4llveikDDyvYWerPrMAp+VoQI4qG0kmXZTCOBrgrqWU53qCdwybam32okwEkxyNCopZvUG9T8wwkG6Esl0qTH1ZG40IfkYF0MZjHOwlsZLCVeuBPqXaT9VRnYSxBdOlH1t7zofM/pNAVatdMPkgmMMu8k5Ql5IKErAEQysrQQLePzJcAjiaZAy4nPW+xI0rHDxLn/UlLqOaRRcOXdVEa+w113O+WJXOCn9lYHbG2I60C0ssnmPa91yHQRokQSjSQ/utB30/77pIQ/u2ybF9WU4KqMw3llaW4qmcWq5oTP6vWAIflgHtugSxDXA62WfIaXhiwJhIzs79hYizmLJcj9Gq3Rip/5FhYWptGSXZe+pk7vxA+ayc+nmXzaLgYbXVRUgkxoSugwjGk8dsGbZm1db4r3ckogqG0uPVHjoybJb/A5ZNv1P3NTpQkAJA2MYQ0X9ZivqaLp9CfD9DyBdrKQvMuhWUh7Gr9SbIUL2uyTcDWTdG3HC4uORaeK8FL/KxoS0W6d7XdcBQV9/UxGK++FzLzh9IbDE7+KkMd53+Kqg3r6gEo4TyVtM6cEWGPb9Lj3RZi56fAQsad97SXzOo/8yhHU8I/jI8+BRMceGYMZEs1mrNdcsbj/LAhqt87e9i1bgI0MM619OxwJ53SxBavcOl7uPRlcj2TSU32M1/GCcNFpGVxeEXNp+pc6TYQjkoEfYy9oKiK3Iqy8o5FRp6ULj3odAxcq4WGYXjd3/4vbmXmhM1KJ5HGgvU5jtEp3US2boBQa7/JbJMwk6kmsUf2JV3RmuRvUFGrCl+ZfXmPVb8vNsvKjKAHFGe5OIuJAsADOE4w==
X-OriginatorOrg: datarespons.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5938.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895e26e2-3df6-460a-5be8-08dbebf7b186
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 07:42:07.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c2c6b4bf-37db-40c2-ae4f-9fd06f3f8b9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xitC7NHXwxAhuZijbMrQa8WdL4///Is3F81NqkX0uka7wFPMGXEs+K/fU0fn1kJ9AF0v4dCyLZo6+tVWT7axLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10260

Hi
I'm not sure if this is a conscious decision or a bug, but I discovered a c=
hange of behavior between version 5.4 an 5.16 according to get module info =
from a SFP Fiber connector: "ethtool -m ens5".

After upgrading a target from Ubuntu 18.04 to 22.04, I discovered that the =
ethtool just report a hex dump when I tried to verify my fiber SFP connecto=
rs. In 18.04 I got a report with ethtool. I have tried to upgrade from vers=
ion 5.16 to 6.1 and 6.5, but it did not fix the issue. I then downgraded to=
 version 5.4 and now it works again.

The expected result with "ethtool -m ens5" was to get a human readable repo=
rt, and with "ethtool -m ens5 hex on" a hexdump.
I have tried with the flag "hex on/off" on 5.16, but the result is always h=
ex dump.=20
On version 5.4 this flag switches between hex dump and module info report a=
s expected.

Best regards
Ivar Simensen

My target:
Ubuntu 22.04.3 LTS
Kernel 5.15.0-88-generic
Ethtool ver 1:5.16-1

Hex dump result with ethtool 5.16 (and the same with 6.1 and 6.5):
ledtkn2@ledtkn2-23420231:~$ sudo ethtool -m ens5
Offset          Values
------          ------
0x0000:         02 04 07 04 14 40 02 12 00 01 05 01 1f 00 28 ff
0x0010:         00 00 00 00 43 4f 54 53 57 4f 52 4b 53 20 20 20
0x0020:         20 20 20 20 00 00 00 00 52 4a 33 47 45 58 44 44
0x0030:         50 4c 58 4c 43 52 41 55 30 30 30 30 05 1e 00 fe
0x0040:         10 14 00 00 42 30 35 34 41 41 48 52 20 20 20 20
0x0050:         20 20 20 20 32 33 30 37 32 35 20 20 68 70 08 6e
0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Expected result with ethtool 5.4:
ledtkn2@ledtkn2-23420231:~$ sudo ethtool -m ens5
        Identifier                                : 0x02 (module soldered t=
o motherboard)
        Extended identifier                       : 0x04 (GBIC/SFP defined =
by 2-wire interface ID)
        Connector                                 : 0x07 (LC)
        Transceiver codes                         : 0x04 0x14 0x40 0x02 0x1=
2 0x00 0x01 0x05 0x00
        Transceiver type                          : Infiniband: 1X LX
        Transceiver type                          : SONET: SONET reach spec=
ifier bit 1
        Transceiver type                          : SONET: OC-48, long reac=
h
        Transceiver type                          : SONET: OC-12, single mo=
de, long reach
        Transceiver type                          : Ethernet: 1000BASE-LX
        Transceiver type                          : FC: long distance (L)
        Transceiver type                          : FC: Longwave laser (LC)
        Transceiver type                          : FC: Single Mode (SM)
        Transceiver type                          : FC: 200 MBytes/sec
        Transceiver type                          : FC: 100 MBytes/sec
        Encoding                                  : 0x01 (8B/10B)
        BR, Nominal                               : 3100MBd
        Rate identifier                           : 0x00 (unspecified)
        Length (SMF,km)                           : 40km
        Length (SMF)                              : 25500m
        Length (50um)                             : 0m
        Length (62.5um)                           : 0m
        Length (Copper)                           : 0m
        Length (OM3)                              : 0m
        Laser wavelength                          : 1310nm
        Vendor name                               : COTSWORKS
        Vendor OUI                                : 00:00:00
        Vendor PN                                 : RJ3GEXDDPLXLCRAU
        Vendor rev                                : 0000
        Option values                             : 0x10 0x14
        Option                                    : RX_LOS implemented, inv=
erted
        Option                                    : TX_DISABLE implemented
        Option                                    : Paging implemented
        BR margin, max                            : 0%
        BR margin, min                            : 0%
        Vendor SN                                 : B054AAHR
        Date code                                 : 230725
        Optical diagnostics support               : Yes
        Laser bias current                        : 28.404 mA
        Laser output power                        : 1.3464 mW / 1.29 dBm
        Receiver signal average optical power     : 0.0003 mW / -35.23 dBm
        Module temperature                        : 53.79 degrees C / 128.8=
2 degrees F
        Module voltage                            : 3.2860 V
        Alarm/warning flags implemented           : No



