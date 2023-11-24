Return-Path: <netdev+bounces-50707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000157F6CFC
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 08:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273431C20C9E
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 07:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9F5247;
	Fri, 24 Nov 2023 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datarespons.no header.i=@datarespons.no header.b="ZA2Y23bJ"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 23:39:21 PST
Received: from esa1.hc776-43.c3s2.iphmx.com (esa1.hc776-43.c3s2.iphmx.com [216.71.156.243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E5D6E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:39:21 -0800 (PST)
X-CSE-ConnectionGUID: KQHHTJ7KRaCE9B7k/MIHGw==
X-CSE-MsgGUID: sVNMfaC1RIaf70y+rC/GpA==
X-IronPort-RemoteIP: 104.47.0.51
X-IronPort-MID: 3015010
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
  by ob1.hc776-43.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2023 08:38:16 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE02Xab6c0n6ftQfQA89StunfubdYfkxDVdQFRyyg0PyL59nIrwz5xMAS/rcv3E7AILSIjuXwo5W4SogckGJrpp7kGAeXPn3Oi+GTpLi7CcgcTH2PBr5VelQr6cxgT9Pq+xSMo0pHwsG8v04WN/R6q9OmxpuEqbYCi9X34nuUBVCV0e6K6aE/J9GS0XrMDohZq99SF8ireJ8RK38qQKf/ZZMNEgjJGWacEbK6Y2zt1LO8umIx+zoefal1tgs0qkiQkKvBiDYKa5QEy0k8CZzTLOFoZMbkveMEkhpH+qba+gvXptLB/DKqos44plw4QWRWINuEyAQ26faW09ydWFPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt0Cos16WA3lQqStMAZlXLk/XYA5VyeHAXUPCshQNrY=;
 b=KKEuOZLnZRgq8fy7zwYPtDr1HyyNcl7oHNPBTxo743iaeLH6tUuXdFnqabfVyEOlSEzqR5Lb9ex6dIPWrwKcvfjn+WiabvZoRKgXQEx9Wzcv/7ozArc9NwjCIlJD92TFvPEy3JjjonL9stElozD/s1Tij5VQ6vugldEAXWYNJcOoPpw5o9XohfDChQHUuFUKYwv5GVhJgtbjEubuZYsZ2c+v4h/GRLS60ktdcJAYphbBkd7Ke1txxTEHxJSOMgUol2d+5efp4hYj2PP3mMLaBx9EiFLi7JpvrcrcZik9Tv9IEoBOCcGaxgdsVHSg5LZL3aMN3gqfK3vcP9psz7mchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=datarespons.no; dmarc=pass action=none
 header.from=datarespons.no; dkim=pass header.d=datarespons.no; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datarespons.no;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt0Cos16WA3lQqStMAZlXLk/XYA5VyeHAXUPCshQNrY=;
 b=ZA2Y23bJ6IWeVB2y472FQxIhwKzji1hUEPJYuzlcXnUfkOYlYrYUr6m9xFRUi3dszDLY/IaZf4Dz7q+2vWASd0q+pSU8ZnkDQAWr8/h6a84FydxZxjMPnqedGDqsdmoFgAZwwCVPotwqJNofm50CZwegnPvBBM1A0ezMP2On+qE=
Received: from AM0PR03MB5938.eurprd03.prod.outlook.com (2603:10a6:208:15c::22)
 by DB3PR0302MB9258.eurprd03.prod.outlook.com (2603:10a6:10:431::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 07:38:14 +0000
Received: from AM0PR03MB5938.eurprd03.prod.outlook.com
 ([fe80::787b:2abd:c03:8fad]) by AM0PR03MB5938.eurprd03.prod.outlook.com
 ([fe80::787b:2abd:c03:8fad%4]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 07:38:14 +0000
From: Ivar Simensen <is@datarespons.no>
To: Michal Kubecek <mkubecek@suse.cz>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: ethtool module info only reports hex info
Thread-Topic: ethtool module info only reports hex info
Thread-Index: Adod4I5dFMf6uPw6SS6MBqaUikNixwAP/FGAACBkL4A=
Date: Fri, 24 Nov 2023 07:38:14 +0000
Message-ID:
 <AM0PR03MB59381C3714D1B54C867CB65CB9B8A@AM0PR03MB5938.eurprd03.prod.outlook.com>
References:
 <AM0PR03MB5938EE1722EF2C75112B86F5B9B9A@AM0PR03MB5938.eurprd03.prod.outlook.com>
 <20231123151949.ky37p6fp4mnq6oq6@lion.mk-sys.cz>
In-Reply-To: <20231123151949.ky37p6fp4mnq6oq6@lion.mk-sys.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=datarespons.no;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR03MB5938:EE_|DB3PR0302MB9258:EE_
x-ms-office365-filtering-correlation-id: 4a39d145-f2a4-466e-163b-08dbecc05114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3HCepHgupBsurMMEvkTuL+6sKeaarnwSXWlknEkNIB6r9OFnhMGmsPq67sBwF0QJMdXS2WxsyC24eZyKe5Aj+pUKp79zPq/wT+CqmCpf/GSXulTzAWdTV1CzQ/dn9Pp0FziqGn5ej47jzXJ4X+N0kcBmDRn1Dd71Jt4B2VuTHGjk6Se7Vi6QUEfCzDI52Z6XVYF9PAxixeru1mp3fSRZxrSJ33SnKnNrS1h84tf3JLYj41gL0Ctc20uEnfQr8wIK/rgRjqURCGZobjMVp7oSIdr3K4PmoCu3I/SkkRkrKq5y3lkN90fHxoXQGTNZAbluKZlThTKfvmUgisBLvXmxOI1zRZ1jsnpx0qWP8By6/Kvp5tbDJQDWhDRDJprxfwO9B4YER9Le+Z32FYQP5AaM5magGTAY/AfxfiUHgaX5o7MVTCM/tbWtUoiLPjQTyk+6Uv32gn3Gb5ZEAleue3w0dzdLLFsDZu9DXqaY9KFHAOrv++4Z9vnEMp+ZrOCnGoBAU3vPOhKWK791ikRDiBlQfTKUugbyysCW+OVuNL+KYEFwQFMfcHJ/UI40yOi2nyMD25SdPDKYGYBeggi17UIhk8M3DvvjHwd5eB9Lkf6hM5k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB5938.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(376002)(346002)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6916009)(316002)(64756008)(66946007)(66556008)(66476007)(76116006)(66446008)(966005)(91956017)(38100700002)(38070700009)(2906002)(5660300002)(52536014)(8936002)(8676002)(4326008)(122000001)(26005)(53546011)(7696005)(6506007)(86362001)(71200400001)(33656002)(55016003)(41300700001)(9686003)(478600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SIdz6RZiFy2bYw74s3sW+VM+uEZF5xExL8brDdNGB1R2OzqTjBCi53JX5+?=
 =?iso-8859-1?Q?CivXxeI6C9k/cwqZVHe8oZzYxwhPmZpr78n5/THICG8dR+819rfNck3EiK?=
 =?iso-8859-1?Q?/RJaqny/HCPcHqmJyfl6oXMZC71mjZlmrdw2vADv809KtLvzaTCIiMTJJZ?=
 =?iso-8859-1?Q?/ffNoee5rm4J/AKJWHwqvxWzhHx0e4zUDrzkE3YEzwlduoRIoWQ5BjmYcL?=
 =?iso-8859-1?Q?tIuDA1luJgD8Ts2rV1qboDTMJL7rPR5m/EatXI1dcfUb90uMpGiWgf96U6?=
 =?iso-8859-1?Q?+Y2wE3NW9bt0Ddykusa3ebPXdAPu8sczxArqSJEfX2CaPnilskkF9MRMiA?=
 =?iso-8859-1?Q?tPNxvKJBFXFM3yxfIUKazWW6AUVbUBF1PsMjRKb8Bxxy6tMhAYRfZSKq4/?=
 =?iso-8859-1?Q?/nAZdjwsMOt7+g3C4YFzdgBdszn01VhAYbPNg5Ncg0D76xdfY9psQhTtl/?=
 =?iso-8859-1?Q?1BN5flv3vKN+IyMdlw8Jz+za12CvhPcBD1u7yAN8vCoy0riYsj0gN7y81K?=
 =?iso-8859-1?Q?rNbCtrXS0HksjUx/l2bg2wRHlRaiFlzA+z0C1btOOOcc1B71zy7BRu9rQQ?=
 =?iso-8859-1?Q?vUtpxm7lLju9ifREstKc2rN0eengmjGSDTMH7qM8jUgR8DXgryaYREPj63?=
 =?iso-8859-1?Q?Ib26uyPxPOWjg2v85f0c1DZBdioKFsNIBqKuJ+tJX8Sz6xNbJv2iTNo6/G?=
 =?iso-8859-1?Q?d5rb/a9rpwGia5rAf3/z1cS/XpbmBXdtSaozk/+Cm99AH9OaU+2un+7e6x?=
 =?iso-8859-1?Q?mR++2drdOmO5PB/49VhzwCSXLd0dpfp3ZUd+ClcsRpE/YfcCNezBcPSpPk?=
 =?iso-8859-1?Q?nt3oO/oJfh9roqVqXVXh13EyA88X2Ef6TETnJtyPWouXIXxMPxwdbzZLaS?=
 =?iso-8859-1?Q?46EKirDOG2qV9+dgrZsxsEJaRnJXKXysrqpJTsiH6eNEH+UhqiepbqNUdx?=
 =?iso-8859-1?Q?yGsxU/KdiNnzdsfa1gMV7C/JjjwSyji+BkqRAxm/8uK1DCv/wsi2YRy3Mx?=
 =?iso-8859-1?Q?EMEqXQwBi9R3b5QXMjr+Gr3LD7pNvN5kwspDX3SX1GKqXVNcVYHBk6ch3E?=
 =?iso-8859-1?Q?hvsRg+vXJnQLQp2oaucilKKIgmm2bWWMC3EOakahgLEAso0LoQ6ecwzQgC?=
 =?iso-8859-1?Q?b93niE2RxamKqWojxNcGFWiai4eQLID7QgvGYn7WebfAAVENIv8uoyP4/8?=
 =?iso-8859-1?Q?/dkEBR/oJynbk+dniPfLT5bgTIKYhdfubuCPtEC+kHm2ARNE5O2UijQwYs?=
 =?iso-8859-1?Q?7BOre0dEPivWI9ZJODl2bwauWBwZ8wiJaovqPfsUHQcb2SnvLQnM41qdrh?=
 =?iso-8859-1?Q?Wo0FvjhakI+fgxmkE1X2UknibHPK+Ynj5HWZ+bQ2WCS+MIQrABtESC5SV2?=
 =?iso-8859-1?Q?3W1hckPHS9wsFAv3ZUOd1yi4u7B4/hZrzqfSALTWWUc7S8jI4S7QxyNcwt?=
 =?iso-8859-1?Q?0CpaKYQODYT5l9ZPOst1ekChtMSKbuFfS53DOOpMJ/L3jzQ5XuaK2PT5uv?=
 =?iso-8859-1?Q?EpUSLgghc1titQyTCNE1tYQC9Dyyvnw8fxx9PMBKbenfn2qunzdXdDAPhh?=
 =?iso-8859-1?Q?EYFCyUSCd4ybjooNnrJ1MJF4HyD/hc01aT2tiLOWrHGwBq0HR8tZ0vKxy0?=
 =?iso-8859-1?Q?meu4jdobYEwV4=3D?=
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
	1f2CWoWbHLXw0iVlcpSHPXQ0dpTDAmpi1EJjjdJs68db1Hal58zTT7Q7QXJGOgctad8/nl+5LjcrcAKZFzlkjKM0trWsuESj3EbS12REYyHuZT8XDPxSTGSK4P8ENKtCXwW1tErH6UPHoobjTN/OnuVQdJbCQ7QMD1GCMLBxNCWpLqLdO8C/0eG3xn2oQc5RODtEVNonUaNqAKVN8rGSbjjbztio86lWRxfbgkvIU6Xw7NuSmsHgPMA8jpO2hkYE3pdGWoW/TFU/jW6TgieXNovmx8GIlOzF8z/HCpZiFOtqx4GrpTS5Rnl8riCsKon0cBbbndLHGwU89XIxmNpX30hpeCT+reef9JnnFTvER4QgKvaAnYamKhXLN5cxDnkS5iWG4UU5QaAzBwFC+5YgkCz7gOtpxX3wS8v+AjbPbPdfnwYblO3d6xBFKv613JNrKQkF2KB6Siv92jK/IaDKJ/kcn0YjLObxbH0h3cnaw2M9DtoyuaMQVx4oeAW0hPBtK2IxdRl3dTlaLPlVSlbyoVB4hSo8wb0GjMpZ+ifeXvp4TWTz5OfVo+p8IyjrnZephHRTHLPPqw+uvULgFRXiwBzxQWQjbJac/FWi//+3AmvZHluy2Uvc5n8JJSoJn0Srd+430O2uJjC07Q6YtWOFAc0sjMLMXFTV/om2JCXGhsN/cCZeA6vccOco927cExr5zAm0MJHkgQUZW8B3PsNdwctfRxni+DHCbRXf519AiRnTSHDabKmk6/ZNG679z3FNBSaTroRpLUcg6NqC8IuH3ZNUoiXrskWeiHY+gSVxnPB/iOZrO8roOKQDBl+4evRHFuntH5nSRlDlqE4IuQg69g==
X-OriginatorOrg: datarespons.no
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5938.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a39d145-f2a4-466e-163b-08dbecc05114
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 07:38:14.1067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c2c6b4bf-37db-40c2-ae4f-9fd06f3f8b9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hOoaLwgN6yq2wTvPIjgPTG21AE4IFzlaImIekYlFGG/OU1POcif8h7kIjqjcDVyMhDUiWmMrtPEdm6lMFc/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9258

Hi Michal=0A=
I'm not sure of this. I did not build the ethtool my selves, but used the v=
ersion that comes with Jammy. When testing different versions of ethtool, I=
 used the deb packages found at =0A=
http://archive.ubuntu.com/ubuntu/pool/main/e/ethtool/ and installed with dp=
kg. =0A=
I assumed however that pretty dump was enabled.=0A=
=0A=
-----Original Message-----=0A=
From: Michal Kubecek <mkubecek@suse.cz> =0A=
Sent: torsdag 23. november 2023 16:20=0A=
To: Ivar Simensen <is@datarespons.no>=0A=
Cc: netdev@vger.kernel.org=0A=
Subject: Re: ethtool module info only reports hex info=0A=
=0A=
On Thu, Nov 23, 2023 at 07:42:07AM +0000, Ivar Simensen wrote:=0A=
> Hi=0A=
> I'm not sure if this is a conscious decision or a bug, but I =0A=
> discovered a change of behavior between version 5.4 an 5.16 according =0A=
> to get module info from a SFP Fiber connector: "ethtool -m ens5".=0A=
> =0A=
> After upgrading a target from Ubuntu 18.04 to 22.04, I discovered that =
=0A=
> the ethtool just report a hex dump when I tried to verify my fiber SFP =
=0A=
> connectors. In 18.04 I got a report with ethtool. I have tried to =0A=
> upgrade from version 5.16 to 6.1 and 6.5, but it did not fix the =0A=
> issue. I then downgraded to version 5.4 and now it works again.=0A=
=0A=
Are you sure your ethtool was built with pretty dumps enabled?=0A=
=0A=
Michal=0A=

