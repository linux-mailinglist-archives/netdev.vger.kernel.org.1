Return-Path: <netdev+bounces-53482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590E80334D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0C0280FAC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998B2377D;
	Mon,  4 Dec 2023 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfOZNCit"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4064AA;
	Mon,  4 Dec 2023 04:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701693888; x=1733229888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MetmIFiAVHiKZbtEDCY58YSH+1Sz/uhPYJxgTTY98fs=;
  b=NfOZNCitJpAMAYc9LT1yyY8hotlnupbZozd9LkFlZMs6M/qbVR0fv0Uc
   0zmYwmhpH7+uC5Xao3iy1/fS1FwgmTvyXUR97x4Z4othQff2mObuRsKdy
   7ZFpGJcefMHk8Gdn5Ara2GtcKCpGpJlEfbtLcfIHlI6W+R6hRsq36QH+n
   t2u2rcPGdFoaepX6ycmlf0ScC+PgEH58EPGgDBQBJqbMR3yzBif4nyVnl
   rztFoxkJ3+2tpyaMgMLDhkl2KbXFCOOjaQgP3EZvnaN2+9QsYTDzlLny2
   oB1zg75+YaKbo1U6yuKeRCK63LqcCeZZ0Qv/wP7xx4Ki+Yjnda+Vou0lD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="392601088"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="392601088"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="18565130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 04:44:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 04:44:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 04:44:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 04:44:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7XLZ1rL9CUwIUGglJMltXMi9VsuveJi+eMLWdnAs7Q/6cbQnIkZJB81ZK5Wu1JOaaHsJeDkRgHvUNgqsQTIsq/zMMG+v2hAPxD4gae23ll9ghz+bh669N/YpGHbtxLp+QVYDKD4+toyO1nEzMMppK4a2pLyODdrY/ImqSzF7JWA74kAF4uS5qMzcPdO9vFiRd7wjeYuRdeNZTAZk6VlMAH4InQZWjgJdOeWesECH+scSQJMfFgXdA7yibfXeuh3p0dHF6iwOzSV7bQiS70Lag3v1w8HRSRfGXxTHMh550LpEasZhkocukndGeLPNLlX/vpknZIYIvS+WIo7tpo6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL2phyJOIvkLnJ4ivTdq4dpSskqmx09QHAWXcgShNCc=;
 b=ZEoJ5tNv6v3SY7P+K/TekAXWZtEMCTkUi0xtqL5472yFMLyvMylO0mcdGJnL+7GJcQsczHozkPpCVFxrV7jhZ/EoKYL6VfeaHkDsLqwwHJHFKaumDabTN1Ywdu+/X/scehUxYf0vsA8WRXoHX4NqiQQLCs7cy26kilf1QZNnQt5L7MFXy7PGii60mh+b66jp4hzMhERoFHe69N8Anqh5D0WMa8F2OFjptDsxDCCaFvAA1LXmf/3UcjTEg0QrhR5ZjVCT41hDOnYS/RzHn+wK6c9T0+HSUykaSxSu24G6E56Kq+qplaRZNadTVgjGW463csZlccD/FN0d18Kb2HMBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 12:44:44 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 12:44:44 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Topic: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Index: AQHaHftDqogcp+ihbE618Bc81MIRXbCRmiWAgAGOCXCAAOF4gIAAvlGQgAAcCoCABBceYA==
Date: Mon, 4 Dec 2023 12:44:44 +0000
Message-ID: <CH3PR11MB841424C185225EC7EB9DBE4DE386A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
	<20231129093951.3be1bd8b@kernel.org>
	<CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
	<20231130225127.1b56ffca@kernel.org>
	<CH3PR11MB84146024E32844E0931039ACE381A@CH3PR11MB8414.namprd11.prod.outlook.com>
 <20231201115259.37821ed5@kernel.org>
In-Reply-To: <20231201115259.37821ed5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|CH3PR11MB8520:EE_
x-ms-office365-filtering-correlation-id: 003cd46d-d023-4353-70f8-08dbf4c6cae0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ql9vRaZVVGpSSmGd/M9gzy0J51UNT6bNVd0/zbnfm7QekGnaYAw8Iy8NmjHjykKkYwih15FyCJMvtbUZzSvHN6w6YljPJH6+UXCkCwzW3JdOF1zXOgO9h25ce6Je1wXDOCkO4WN9wtPqahmqiq6j3ICDXCMKAgYNu+97FXdMG7gu2rQwPXnl9IZWSbET+Zb49fexL9M/QaM8pPkhQUPGLNc8qgeIanvZNkD3PCx08EuUI9569Fo6h8Y6PmXc2JRDl2CVA5/AvWFAanh3oN1KhQYFgABmJMBtGS+DBwm3FXnUncRdPwwVgyK1r44X/YYcu7PzR0rdIwAdBhL76cc6V3F63zey0DkW0D0Ji6KuMF2qiXwCtUOfWu5XYJieqUHPrriIA91q1t86x2g7gX5mzJCS58AbQyx/FcVV9wFERUFvHW6fVMdw8dZaBRqg583kdckojFPpdCJyMv4oY+r7vHBrlghHu8+fNp5wH535hLU53YqqiwwFOhEkMG+5mFDLTBdgD7I4Rqf+5lN9SJlrEtgOAO7cbhFWfUb9cjFSf+7utE0YPFrEiW6/HgcrksLxoZr+J9Zthv+8ODnCl9MBpTRHAq3LPQdzbEDVYrf/LDs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(76116006)(66476007)(64756008)(54906003)(66446008)(66946007)(316002)(6916009)(478600001)(71200400001)(966005)(38100700002)(7416002)(5660300002)(38070700009)(41300700001)(2906002)(33656002)(52536014)(86362001)(4326008)(8676002)(8936002)(122000001)(83380400001)(55016003)(26005)(82960400001)(9686003)(53546011)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IXrDdL6ZbLpW1ciHosfwIuQ4b8pmu6abv99jG9r9r7i/ybeFl1WQKhs+Epur?=
 =?us-ascii?Q?KT/T7wSZTDCXBEQLtuCQsCXkrPE4DTvbL/ZZI0FrkL1RtKtEaTnK4qgNWE2z?=
 =?us-ascii?Q?uQ37rU7wr4Kq1TsQVC6TJUFI9Sm6ZcKM/Xku8t6uV1yAtZq8DRbOMj2pXDl9?=
 =?us-ascii?Q?kGvCiAgRf5F5zvWYoZRHzVxZNOTJ1o+LdnpGYXG9FShOtQENemTUxbcmErPQ?=
 =?us-ascii?Q?mpiO7vKG0iWhuvujwhbkw2fajcukKMXIJ12qOW10op6EaZlJBR/aAbZ6njBr?=
 =?us-ascii?Q?jZh7qpjupBMya27X/4Ik3fQz8ow8SdB2ahqnbO0Xon+frEsSQWpu8CgiI0LB?=
 =?us-ascii?Q?guGjGa2I9jokYp61CsSElLSm4Xof/S+y/N3A9ZSfUEIe1kSDFqLIlv+GzH7a?=
 =?us-ascii?Q?0SNwKupTP7a97SJnftjhSqqJZPNOVSJGAWgbVMBgpPYqTp4CHVSmWCtDO4/d?=
 =?us-ascii?Q?dhTDnY11qSvyF0qLnCxKi9q0gtgTOFGgoh68i50qnmW3S+qrrEHXO7GwzmuY?=
 =?us-ascii?Q?hDEbEf4z4mQyKmFOgQRuUJFYDWqU6mPoJ16bU6fkeqbOvEz4N7TPiP+A0UbK?=
 =?us-ascii?Q?zzcJUewjNyWjTQdwBAjynPBNias0a/YlTuaUtgRV4vb4Lfn+FYkWZ2aaJhzw?=
 =?us-ascii?Q?At8R7+5gvJ6OqDVCZlMMTfBBmjcGb/nYDYaXDNn56sj72QDmaOtM0kBJv8HP?=
 =?us-ascii?Q?U+IjfB6e28pjmCTTpDlgWs1nYK7bkXENBOWG92JiUWGROlJNqwRgaUoWP3Ws?=
 =?us-ascii?Q?aEuM5hfWd9NM4QtH/mGJyt8Cv0i1MLr2Y912Rd0WPr2LOD56//98rX+YHzRj?=
 =?us-ascii?Q?0XnXX22azHIz2kNIaxgpSA/Uwkn5/IJuc7Mit0JzxUSygfguI09QeZm5NR3+?=
 =?us-ascii?Q?21SVuMJplZ2gjYYAVlaa3Hx/HGBZQtBPE3J152RfZcx9JJoNAkzHUAdKqzGg?=
 =?us-ascii?Q?sUc5C1jUWssoNU66Mv5oss5yajp8JEUL5LrFcugoPJ9zVCR2gNS/JiMy0awt?=
 =?us-ascii?Q?1fUsYWXeK4tEhCH12/e3TlQNomhS2gBihipW4n/0vxcW7Cjbmkvb3OAjWWIw?=
 =?us-ascii?Q?brgUDLGUboha2ySo2OqA7EUKNrJ49P7RXV+dP8nIUbTw249QL482eau1ZTS0?=
 =?us-ascii?Q?oInrsrKIJekLfd+Z1/mhObMlrvAJ/w4IFecPnVvVFRiycYjN6h+AexgJNa70?=
 =?us-ascii?Q?qkFfI8WQZBg3EPwk927yh+VKBNnKpYTcA4WHHQRSgPZBol02sfJtkjAyUU9J?=
 =?us-ascii?Q?zIfE4no9hEJNH9BsXJeFImBdZgGAoTXV38Y+Ulz9k1xxMgilQL3SwZs7KN8n?=
 =?us-ascii?Q?7VXAI+0E4eN+YMpcWleJpl7rVHCawUEPpkpCOfyn+hpMPnH/qMP7Bjit2bWC?=
 =?us-ascii?Q?wvVVwBFqq+KaNfs9R8BGoZqVahfHSWTzMUrRDDTsOqbYGQBUbLzddICDbTp2?=
 =?us-ascii?Q?9sR2y9ej68zHsWaJWKS6MOlPz7tY09viYnb1KtfYtPbMrwOsNgq/Q3cUMcyI?=
 =?us-ascii?Q?/qGe+KxLXGPlli+SHQZeLmpUes+MkqaIytIg9jDSjYtuv+diIIV3WuK5zUpU?=
 =?us-ascii?Q?rj/AeB2kX+4K9t4pUVpD4nJkCrKQ2jrQRVFiTmih?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003cd46d-d023-4353-70f8-08dbf4c6cae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 12:44:44.7110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bojGBEpW8qoW7aJcDQr0IY4BLYGqzhOS8ErFZO17o1fhHwQU59eq+yaesLgjGvPHRS00XFONcZFblaxmGH/5fUP2ZLmVNxHkcMKdl2CVn8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com

Merging two threads.

On 1 December 2023 8:53 PM CET, Jakub Kicinski wrote:
>=20
> On Fri, 1 Dec 2023 18:33:11 +0000 Michalik, Michal wrote:
>> That looks really promising - great idea. I tried only vmtest today, and=
 my tests
>> work kind of flawless with my own built kernel (nested VMs):
>>   $ vmtest -k /home/net-next/vmlinux "modprobe netdevsim && KSRC=3D/home=
/net-next/ pytest"
>>   =3D> vmlinux
>>   =3D=3D=3D> Booting
>>   =3D=3D=3D> Setting up VM
>>   =3D=3D=3D> Running command =20
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>   platform linux -- Python 3.9.16, pytest-7.4.3, pluggy-1.3.0
>>   rootdir: /home/net-next/tools/testing/selftests/drivers/net/netdevsim/=
dpll
>>   collected 91 items =20
>>=20
>>   test_dpll.py .........................................................=
.. [ 64%]
>>   ................................                                      =
   [100%]
>>=20
>>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D 91 passed in 10.54s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> I will try to take a look at virtme-ng next week, but to be frank I alre=
ady like
>> the vmtest.
>=20
> Hm, FWIW I manged to get virtme-ng to work (I was pointing it at a
> vmlinux not bzImage which it expects). But vmtest is still unhappy.
>=20
> $ vmtest -k build/vmlinux "echo Running!"
> =3D> vmlinux
> =3D=3D=3D> Booting
> Failed to connect QGA
>=20
> Caused by:
>     Timed out waiting for QGA connection
>=20

I have seen this before I got the proper qemu version, actually I compiled =
it from scratch:
  $ qemu-system-x86_64 --version
  QEMU emulator version 8.1.3

Which version of qemu are you using?

Btw. I agree that logs for vmtest are not very helpful, the .vmtest.log fil=
e is basically empty
for me every time.

>=20
> Are you on Ubuntu? I'm on Fedora. Maybe it has some distro deps :(
>=20

I'm using Rocky, so kind of similar to Fedora.
  $ cat /etc/rocky-release
  Rocky Linux release 9.2 (Blue Onyx)

Also, installed qemu-guest-agent and edk2-ovmf packages according to vmtest=
 instructions.
Have you installed those?

>> >> To be honest I did not see that. I agree that this is a simpler solut=
ion, but I am
>> >> not sure if that is not "too simple". What I mean, I'm not sure who w=
rote the sdsi
>> >> tests, but maybe they were not aware about the Python best practices?=
 Python used
>> >> to be my first language, and I would vote for using the venvs if you =
asked me.
>> >> I understand that it haven't been done before, but we are here to try=
 to improve
>> >> the things, yes?  =20
>> >=20
>> > I think I already asked how long the setup takes but my only concern=20
>> > is that the setup will be slower, and less useful during development.
>>=20
>> I wanted for "run_dpll_test.sh" to be userfriendly even for people who d=
oes not
>> have a clue how python/pytest works. If somebody is developing tests, I =
assume
>> he/she knows what she is doing and is using own environment either way, =
like
>> venvs with additional Python debug tools and direct pytest in tests dire=
ctory:
>>   KSRC=3D<KERNEL SRC> pytest
>=20
> Fair point.
>=20
>> I don't feel like it is slowing anybody down. But since vmtest looks pro=
mising,
>> maybe I can prepare a reverse logic. What I mean is I will prepare scrip=
t which
>> helps prepare the environment, but the default will be to use "locally i=
nstalled
>> stuff" when people just run "make -C tools/testing/selftests".
>=20
> Let's keep it as is. 10sec for automated run is fine.

OK

On 1 December 2023 9:03 PM CET, Jakub Kicinski wrote:
>=20
> On Thu, 23 Nov 2023 05:52:43 -0500 Michal Michalik wrote:
>> +++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandle=
r.py
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Wrapper for the YNL library used to interact with the netlink interfa=
ce.
>> +#
>> +# Copyright (c) 2023, Intel Corporation.
>> +# Author: Michal Michalik <michal.michalik@intel.com>
>> +
>> +import sys
>> +from pathlib import Path
>> +from dataclasses import dataclass
>> +
>> +from .consts import KSRC, YNLSPEC, YNLPATH
>> +
>> +
>> +try:
>> +    ynl_full_path =3D Path(KSRC) / YNLPATH
>> +    sys.path.append(ynl_full_path.as_posix())
>> +    from lib import YnlFamily
>> +except ModuleNotFoundError:
>> +    print("Failed importing `ynl` library from kernel sources, please s=
et KSRC")
>> +    sys.exit(1)
>=20
> Do you have any suggestions on how we could build up a common Python
> library for selftests? Can we create a directory for "library" code
> somewhere under tools/testing/ ? Adding a wrapper like this for every
> test is going to hurt.
>=20

Agree, my approach is not very elegant but I could not figure out anything =
more
useful at that time. Having a common Python libraries might be a good idea =
- let
me think a bit how to handle it.=20

> Calling out to YNL, manipulating network namespaces, manipulating
> netdevsim instances, etc - will be fairly common for a lot of networking
> tests.
>=20
> There's already some code in tools/testing/selftests/bpf/test_offload.py
> which is likely Python-incompetent cause I wrote it. But much like YNL
> it'd be nice if it was available for new tests for reuse.
>=20

I will familiarize myself with that - thanks for pointing that out.

> Can we somehow "add to python's library search path" or some such?

Yeah, we might consider using PYTHONPATH in this "new common lib place":
https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH


