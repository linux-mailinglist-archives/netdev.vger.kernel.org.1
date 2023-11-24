Return-Path: <netdev+bounces-50761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25A7F6FE4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913B31C2105A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6395315AE4;
	Fri, 24 Nov 2023 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datarespons.no header.i=@datarespons.no header.b="UlZ5KZtv"
X-Original-To: netdev@vger.kernel.org
Received: from esa2.hc776-43.c3s2.iphmx.com (esa2.hc776-43.c3s2.iphmx.com [216.71.158.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49557EA
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 01:33:20 -0800 (PST)
X-CSE-ConnectionGUID: +Qa4gcoBRLa0WtPz59LVsg==
X-CSE-MsgGUID: JZvy66HZQmmHIvY4c/r31g==
X-IronPort-RemoteIP: 104.47.11.105
X-IronPort-MID: 3010749
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
  by ob1.hc776-43.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2023 10:33:19 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWODMxJ2xVfX0wHH0FUXn5njMwpwuFBA3wEro6F7dDwFIgy73QliuAxl9Bo8sPwwwUjmtWaix0M5oV9ox2gzpAOQrUWq0IaSsP1P3KcwMJwSnoIEoxC+E8gUR5LpFk2FAwTK35azR/zS7Py4EsjfiJbBCzy0VJRgQyL/a+BXIviAPIeX53KrJIE9POP2XX3lsb+xd7v6hQPQW9BNtdHTrfYTFvStK3pDQL/iSHwYWYZJXZ1zIqH+P80rsE9vg9bryo5obwjB2FsSU93FGl/0Z9oCXZ8NfC2HIpNeIlclVuk/22sp9DVgB3gwp+tY7L8XyyZZfmmREVkhGBh/Pkvjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnXJG2YWmeV9ob0XeY219mVf7qjxU9cLRudYCfwMFEo=;
 b=Rkp484VehVWfGhRgu4Wg6G1K56ATq8lCurYc4O5GbhYVOAHFam6uYRQNoYJ38XUsE/3dclQm84nRO4L7vGVsF62UIlYmasKt/Yqy2FgntBRHwXjstgGeYXsJ924eMpPasGs5pLn0yBT9Kda7tMwCw3K1b/cjSgiiUpLOzcxqEtLG4omNhMZDo6uhF8ed7bRMXHS7vRs0ewiP5VAYC+TtUB54DGFFgm12v/dDL1pqvby9dUn/nKBCOxhZ4UJjabiWyQCgUj9GsqsbQaYYcTvV3T/o9OpspfI9geoijt+2breoOjUnYZBJJ5vM36CvkPdV+U+AfxJygQcUT61xtXICAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=datarespons.no; dmarc=pass action=none
 header.from=datarespons.no; dkim=pass header.d=datarespons.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datarespons.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnXJG2YWmeV9ob0XeY219mVf7qjxU9cLRudYCfwMFEo=;
 b=UlZ5KZtvQmPSzoNSRVD8ete1SJZcM4PqUtexA8G4hqqfv8E8BJY3E541DQEy+v5PWK9VRtw4KSBg+VhayNx5g8vtwVvi2TxT8x6Uh0nvSEf3plEVqQEVMGAp+SpFblaOgBjEMtE1mNAx7hm+dbw1FyurCgX+tFNAfrFu+8PQ6v8=
Received: from AM0PR03MB5938.eurprd03.prod.outlook.com (2603:10a6:208:15c::22)
 by DB4PR03MB9553.eurprd03.prod.outlook.com (2603:10a6:10:3f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 09:33:16 +0000
Received: from AM0PR03MB5938.eurprd03.prod.outlook.com
 ([fe80::787b:2abd:c03:8fad]) by AM0PR03MB5938.eurprd03.prod.outlook.com
 ([fe80::787b:2abd:c03:8fad%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 09:33:16 +0000
From: Ivar Simensen <is@datarespons.no>
To: Ido Schimmel <idosch@idosch.org>
CC: "mkubecek@suse.cz" <mkubecek@suse.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: ethtool module info only reports hex info
Thread-Topic: ethtool module info only reports hex info
Thread-Index: Adod4I5dFMf6uPw6SS6MBqaUikNixwAH8K2AAC41Q0g=
Date: Fri, 24 Nov 2023 09:33:16 +0000
Message-ID:
 <AM0PR03MB593889F6F5B64D5C3361E0F4B9B8A@AM0PR03MB5938.eurprd03.prod.outlook.com>
References:
 <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>
 <ZV83lz4bwSpeBFb0@shredder>
In-Reply-To: <ZV83lz4bwSpeBFb0@shredder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=datarespons.no;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR03MB5938:EE_|DB4PR03MB9553:EE_
x-ms-office365-filtering-correlation-id: d15ff8c4-b95e-4603-8825-08dbecd06348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CtdOJgwP+PlFZoCHkKqq/YA5+ndQexV036A6xkAiWp/yTkFD+63cY4qPU/ZL1gOVvJo5GzyRtPYlw1WYVBybSC7n9VI77/bk6e6UGVBN7ABaV4rpOtdn6hXWhXXQDPy5zzD1xirBfSan8hzVaT/enH0E8ZROYZHDn8T+WJ7ouGPaJMC4h2m3YDFFHwmFyKTGeN1U6hoSu6Gc6vTKU8ZAabYTp2EZtNYXLvJ/MNGYm8KQ7lTi07zpW8t1c9gz8V7ro+w69394e3MxTb5BDsynkA6Lky5C1Sfa8v6uyT/U90jgYjEyrYHL5yjgXw7RRBCbWoJyLw2vMxxwTyWbYhT9EiwiDUzKBewOCZGYyQXYmSBuAcwBFDE2n7LsENwKvx0WFNt3oKfGq3LdPOlR/IpKNsj8Z92kAvi4lZPsuRZu0/qeC70RV8iUl21ZDFsGebnI+hj99DwDvxAiaJPDeUp083/N9UFXo0ZD9QtykjLQ13HXmRKqQIeZhb5qOuDdhOCzkfS0fkYHgK21zFURNWe+aS/YE8nKOxr2+RD/elkEEYwzb+uZnMPdbEg5hJVgvAqrPr8W7cBW+EokHwxIQBYXB5TmgSIRo3GY2VADK4kUD9fw+7nDMJQ3BDEbhcC+a7+o
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB5938.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39830400003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(83380400001)(71200400001)(7696005)(53546011)(6506007)(9686003)(41300700001)(5660300002)(52536014)(2906002)(478600001)(316002)(8676002)(4326008)(8936002)(91956017)(6916009)(76116006)(66476007)(66556008)(64756008)(54906003)(66446008)(66946007)(86362001)(122000001)(33656002)(38100700002)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Nb9v9Dy4hjvg1Wo+KZrFVuzhOQlcguIz6warPeBeGzTs12WHkG1eNyJF6/?=
 =?iso-8859-1?Q?UtxcN1xT9rlTG4drDqinxIGx4uxlM3x8Uwq8Iet9q/3aqvqPrPwFxCOqVV?=
 =?iso-8859-1?Q?HNXlUkvMwmtJ4cZxK4v6VZwQxza68leYyJFP8WfT4aVFNylRvMZ15wbGrC?=
 =?iso-8859-1?Q?cJBWClp5eNFk10z9IHNA17qZJwRe/moLMOlu8z1XI+JOAB/SGAdJSZf1je?=
 =?iso-8859-1?Q?aLzLwl61JPdrjh2WhkGRWQUYz/+qis4ns/oSeTOYnbWDgVSSv3pnNrxnFW?=
 =?iso-8859-1?Q?irNdIiwc6tCtwmYfjYXa5zgj1+sKK80w+Iy6wsVQUyyFx9dw5X8jhMKiPT?=
 =?iso-8859-1?Q?oJ9DLEK/aZxE6fOOGEQ1RBq+KJZJKkS9fJGcg5LFUFfueYFSMwTl4PkRy0?=
 =?iso-8859-1?Q?LreG9/a1CLOgpR6nxJk/oV9rZDX1vhxkJH8j+qcYTdyXkcLy7Rk21Zq76m?=
 =?iso-8859-1?Q?YUmvzrMt+DJ9Q5ccK9SaycZvElGWtynpunRO5Ojg/Hku9S2+hsLwTX+Fz0?=
 =?iso-8859-1?Q?ImBHlyxOR2rz5DclaBBy6pijhY+WFrN3RtwoCtpa/H+qmXyfXCdIVrsE2p?=
 =?iso-8859-1?Q?Ktn396/Lrff/wKmenBG2zUbF3bm3UxEJxok/zc/rKYex05H8GzwfcgyMAE?=
 =?iso-8859-1?Q?T4FxQlWs7Mxbf1RJVA0mrQ0Sg6pg/Zhk9A+vn69hSmx9N2RRy4cOZdW1Wz?=
 =?iso-8859-1?Q?265uHFHxYlXDBFvd8W7ByqUu6NwXuIQQBu2+FA+SzW6ywptWBrHNJyki6U?=
 =?iso-8859-1?Q?fv/+2WV6eckKZvIMZYZYkOOz6xvzbC1lrHhwdnLpuasG9bE484m6MMpAC/?=
 =?iso-8859-1?Q?Z4otm6EYLzBwQa+koYGkYyXFdwrEwAEMNOw0F5tNY2bCz4by+AqdhBH/yZ?=
 =?iso-8859-1?Q?qSzfYr9zXDfGoh9Z40nra8Rw+Eql+PH9uwVK/z9czIP5f8GV6oh4IPejfm?=
 =?iso-8859-1?Q?kl4AZo8A8CX+UZyVzSKmbTf1LJinzTAc5IB7eh2nX+PaBtBQEVrWPG4Tmo?=
 =?iso-8859-1?Q?b2HFCz1JcyEnCbojNGz6i66k0EUWUjzfYzWhPpPS6LXlcQDaYlhom2HFNE?=
 =?iso-8859-1?Q?74qMfgqYy9HFF1Atgjx6B/4sm7zmPPGmFPEgBg6PnWduDUpOl1JeLPTMVL?=
 =?iso-8859-1?Q?Txpu7VfXz0Dp+yf3599qXLCPvNZmpUoV1tzM6UMrl2A9BhthR5me3hT6Y4?=
 =?iso-8859-1?Q?544RrqG270e0QRrgyd4sGJDt00AQwev2pIb1gdeQqIL1e6Gp5Q/i+53cFS?=
 =?iso-8859-1?Q?8ewNNe/Hw6XgwYvH96UunP9ytmOTb9q1oeSxn7JSutSbCNczaVlDR87Jwe?=
 =?iso-8859-1?Q?uX77LRioW0DHT3lYNqdqgyblQz5jwkM6/jK71oSpHgU2rBgBmih9hm6ZoG?=
 =?iso-8859-1?Q?uLTNB8R51mJ+BkK39V7lxMFFnEK9TDh7hfW8DUxlCYTCZa0vhLGY2jUYyy?=
 =?iso-8859-1?Q?n89eIRvhXiMQ5wTw3K7xy/1XkhnPNjDsVhbujgrFtPuE2LxytpR5gfKjru?=
 =?iso-8859-1?Q?xHHC/bXibDi8ct6ujf71IkuvsF2Nbv23ypdlW2j7Ub8+DMfUKvpYVEfZ1e?=
 =?iso-8859-1?Q?U+ck/Gm5YV/ZhM6Ktz5OPd2HK0BVvfPBcXdpVv+qJl0AxlscSs0eHhf81O?=
 =?iso-8859-1?Q?7Xw4oJydWvzbQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWn/zDDb6amGJEr/hOZlyQLpIo3Fhe0z1pX+L7yKG4F7B4M1glRuajIIcqeK+6F5EEXdoSCPEzG2/9HsbceajmG8ohn6S+f7eSB2Sokt3JkGzgsypMMg1TIodo6xkWIm6ID5+x54sVRAuGtOwfEFv67Jq8OZ6e/73Cekrq4HcpPTDJ3czr7DTvYryKkrIH8r0tW4Yv+8AYooGh4B1Uonke8yrm3dZKbKz01ic2C5sZi0wKN5V9glQZuY5j7t6barhJGecME5p2JSNM8ko4f02tYsNKDP3+1a5VmvcAsQyZ6CJwr0R7vspwHxrclrRCyC9iuYwRQvDSZAbxbHKMEc8/1MOfz940vR8f1tCouwZa9jj6QNIVjlIRjrb5b2Ffb+ZxQD/Q6YydiKy2HL6o36OHEOak+tcQ969kIVrmIrB7hyoOrPCnQBGvIyVDEmXioGG/SNJjeLPLZchsSCNqUBOiQrOArjgcyrNakXc5yXvE+AFxlqQWxkoWOmETwMEqZ69at1qv2uZezeZjuZTSziuh9FME0UalLSTs+3USruWGL2/kzE23cP9s5AxjNBMWCm4cYhbZEWaDcJ/PuyTUAPPOFyAZjTsJxjAJyNff6Zaw4YDu9g0ngIX5WECs7fQe1oMxko8vmT8WvZ2Tnr0Vn24tiVYDVdMQxbW2rufwSzvb5mk7xdhlMEbU6n5Odv2OSCMZQkvO3qdIWB18RPf6g+oK53rcjfNnb6FBI+2uPTYZ92DYcJJPr4czqu3rBuPFl9BW5WTMIP8IEBI9usLKBNB9GOrg6Y13Rl9FeiRS5Sy/cxnKk4Nb5M5luZKIZDjYg7/1nkwNqHVC4QSzFwNF6rj2jGC849aI8+kfE+Xit6zWSEUxFvygrQosZebTrtI6YW
X-OriginatorOrg: datarespons.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5938.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15ff8c4-b95e-4603-8825-08dbecd06348
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 09:33:16.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c2c6b4bf-37db-40c2-ae4f-9fd06f3f8b9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXsXkUUG6uGLI44ILxFVofx6rDLCpz6ZHp4Iqb9Yjaze0FzVaRCVz6IBAY/+0Xpt5yCKeCv5MvcpzPtwFMvvrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9553

Hi Ido=0A=
Thanks for the quick response. I downloaded the latest source version today=
 (6.6) and can confirm that the hex dump issue is still there. =0A=
I then tried to add the suggested ID's to neltlink/module-eeprom.c as sugge=
sted, and now it's working!=0A=
=0A=
Actually, it was the SFF8024_ID_SOLDERED_MODULE that solved the case, the o=
ther ID didn't have any effect on my issue.=0A=
=0A=
Thanks=0A=
=0A=
=0A=
From:=A0Ido Schimmel <idosch@idosch.org>=0A=
Sent:=A0Thursday, November 23, 2023 12:29 PM=0A=
To:=A0Ivar Simensen <is@datarespons.no>=0A=
Cc:=A0mkubecek@suse.cz <mkubecek@suse.cz>; netdev@vger.kernel.org <netdev@v=
ger.kernel.org>=0A=
Subject:=A0Re: ethtool module info only reports hex info=0A=
=A0=0A=
On Thu, Nov 23, 2023 at 07:42:07AM +0000, Ivar Simensen wrote:=0A=
> Hi=0A=
> I'm not sure if this is a conscious decision or a bug, but I discovered a=
 change of behavior between version 5.4 an 5.16 according to get module inf=
o from a SFP Fiber connector: "ethtool -m ens5".=0A=
>=0A=
> After upgrading a target from Ubuntu 18.04 to 22.04, I discovered that th=
e ethtool just report a hex dump when I tried to verify my fiber SFP connec=
tors. In 18.04 I got a report with ethtool. I have tried to upgrade from ve=
rsion 5.16 to 6.1 and 6.5, but it did not fix the issue. I then downgraded =
to version 5.4 and now it works again.=0A=
>=0A=
> The expected result with "ethtool -m ens5" was to get a human readable re=
port, and with "ethtool -m ens5 hex on" a hexdump.=0A=
> I have tried with the flag "hex on/off" on 5.16, but the result is always=
 hex dump.=0A=
> On version 5.4 this flag switches between hex dump and module info report=
 as expected.=0A=
=0A=
Can you try the following ethtool patch?=0A=
=0A=
diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c=0A=
index 49833a2a6a38..8b19f8e28c72 100644=0A=
--- a/netlink/module-eeprom.c=0A=
+++ b/netlink/module-eeprom.c=0A=
@@ -216,6 +216,8 @@ static int eeprom_parse(struct cmd_context *ctx)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0 switch (request.data[0]) {=0A=
=A0#ifdef ETHTOOL_ENABLE_PRETTY_DUMP=0A=
+=A0=A0=A0=A0=A0=A0 case SFF8024_ID_GBIC:=0A=
+=A0=A0=A0=A0=A0=A0 case SFF8024_ID_SOLDERED_MODULE:=0A=
=A0=A0=A0=A0=A0=A0=A0 case SFF8024_ID_SFP:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return sff8079_show_all_nl(ct=
x);=0A=
=A0=A0=A0=A0=A0=A0=A0 case SFF8024_ID_QSFP:=0A=
=0A=
We might be missing more identifiers there. I can look into it next week=0A=
(around Wednesday).=0A=
=0A=
If it doesn't work, you can try compiling ethtool without the new=0A=
netlink support and instead use the legacy ioctl interface:=0A=
=0A=
$ ./configure --disable-netlink=0A=
$ make=0A=
=0A=
Thanks=

