Return-Path: <netdev+bounces-53607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8D803E38
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1271C20954
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E231595;
	Mon,  4 Dec 2023 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAZjxVlS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AEEB2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701717469; x=1733253469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PMJ3dOOz0vgsSdqdOgzo+svpeLBI94fpeftqsuzQwyU=;
  b=KAZjxVlSvPxitNO19S6TprZ7mL3rVMQBee8Fs+DFvbI+h4UmJKltMMsx
   mDEIKmF4YRXbDbIimi3IC7PsN0ds4dW9a0acY1QE8YO0k6W0wFHevJ/y0
   1tCagP7SuiBIKezoc6IYtq4nrzqjEYZGwddAdudoJRTFQulFNFo8Insn+
   MTY8lppZo2HuaqSViVcqBQGgJM1uBMvH8Waqh3vcdHxJG7qhbFJxG5W/d
   U+jkrqCxGl0TzdcevUwlaFuO2brSZJRmyDqlfGldDybuxDqEgaA3A1yCO
   GdrwYk5EIXqijWF6EX1CBS8LSaMZFGmDa5eu9QNDmeuYmUHNlXWHLIZIt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458106311"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="458106311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="12065593"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 11:17:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 11:17:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 11:17:48 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 11:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGuuM7nuPmcmd2tl3zaNcyCTimYKwrCmpH8p92HambkV9yJucJOImaJHntPdbPNfHzXcTj+9fIjA+6Q+bQxYZZ+5COzs3iqVdu0pw8kly73xvb0legVmOVJYJUdMQ0HonYHniTBNJtpw1HGWnMBmQ5xw1fec82pcKSxtWBYLTJNLM3VzWsOFR1Q2iziP9A5eZRUxR1Iit+JX461vpyNT2398hGYjiizNjKuR4eHrZttjmU5ixxA5dHB+L3hbkDZZhDFfcyXt73dpXbYuamts/Aa+Yt7MYVAZ/5DXTjr5sb1JFR53eaBVCdtOkZyZk3ZWZZk0tgN8isbR14NiQrc2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8c6Hs/3WzHW+0mSScLfD/iEkPyKY0zCMYNUPvLfSOU=;
 b=HckzriXrVEHd2zzmavVUQ8c8NppxT2+TvPKT5xR7ZWUWiV3y2F7vt99KJYsrda+JZqffxAfgHJqHRVq8mnIcFi4zO7nSDWUiisTEz+RHLlLlZKAGJzzs68rKQlIz6m8y295VE54YUz2bwuERuwGWamaKKWHlVK6Hc/TrJ0n6wcF9Im4tWIyww2vakn2/LBYJTx+HzVW05zyV9AmvP8B70tf0d0AlmCMVQKKrz2tNMvqOq5j+Uqe5hMlvJQKUX3frDf5zS/KnrDgiDJcAtjb9DQoLhJXUiSjomW/AAIypZ57K3qqvGW6XRdqpBMBgfNtL4X3PGreI3lqee7xfi6nK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:17:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 19:17:24 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "Hadi Salim, Jamal"
	<jhs@mojatatu.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Nambiar, Amritha" <amritha.nambiar@intel.com>, "sdf@google.com"
	<sdf@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Thread-Topic: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Thread-Index: AQHaHjkkBNIOR7QioUaP8Uc5lp/FxLCOU54AgAsMqwCAAC/VAA==
Date: Mon, 4 Dec 2023 19:17:24 +0000
Message-ID: <CO1PR11MB5089142F465D060B9AE3FDC0D686A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
 <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
 <ZW39QoYQUSyIr89P@nanopsycho>
In-Reply-To: <ZW39QoYQUSyIr89P@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS0PR11MB7880:EE_
x-ms-office365-filtering-correlation-id: 5dde2815-21c2-49f5-d885-08dbf4fda57c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PPO+bi6TfTJu18/5eCxFTcZcbGUcEfnefMeCKEQz+pamBbmXj3sAXDGx8fLxnJfgHlzfv+qUqkUsNboZKi8X2+V2B0kx1JARb+Qc/Y0I9bWdEW8lwWOEzfEGT1sNoUc1NqNxBU32U8HiYvMfvCEF+dvwMFUjZ726WjC1ElFoRMY3rcMkTuBnUnM0WmEzRklHGwlBLXxQYYGFUINmuxaRRDHa/lQuR03+pgPzYv5Nk9ONwzMNwA9H31ajRd1r2HBySW5T9U/hDBaNGPUbBRYwNMFsEcGsA91AWEHLSfNdyTW25kqUC0LHROknfta1sB2X14Mbo9HhbJlKKZlqqc/3QqWa1BbkVb3TBkNrkL3IBhcbWibvN8RPEgMZXWI31lTXChS1wd8oMZDh2J9lvXcge9kbxlbW56ZrKtCNy9Gq8PbqXzfEAEo6Owgul+5f88nOvPMgal3bUe5kKV1ajz68Ts0tZSTovs/1tjZj12LQJ/fH+T7E/twCkc/3c0xOC8M3+2vdB57cvk5hspyaU1N+uq4rX2rVWXUFoBDMGlbNW0W+h38b2UKpmLxz07ARcvHF/t2a/pzCrXlxLr3UqtCpAEiNS3HXtUxt/HsfrafeMiOQCIFg1Cfh/pYzJIdlg7y9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(55016003)(122000001)(38100700002)(2906002)(15650500001)(7416002)(33656002)(5660300002)(82960400001)(83380400001)(53546011)(9686003)(6506007)(71200400001)(7696005)(26005)(76116006)(110136005)(478600001)(41300700001)(316002)(66556008)(64756008)(66446008)(54906003)(66476007)(6636002)(8676002)(52536014)(66946007)(8936002)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tq2sUcredE2+XD92CeUNDlzU+mRceI/oTkoiBvBCo/N7a4YVg9Cjk4LKk6K/?=
 =?us-ascii?Q?Dk9y5CVRv5e6vIvkujCojuV4jx3MEcT39qgzuRHwtdwbMhOuecnHKHKzb61I?=
 =?us-ascii?Q?Rd9Glz/Amhf9z1LvjBE35JFejUlxPxuwvs5Y2s7e/P5Bxzh1FGB1BIDOtKjx?=
 =?us-ascii?Q?6vvTIx8CrnylvDMCh9ebcJalyezn+oFF/fV5nkOJH/bQ55w9KBY07heMlkRW?=
 =?us-ascii?Q?e496jM4tvcNlRKjErIGO9xyqVfVbLK3p0t1yeBaWBB99HXzJxxyCNgylfr2q?=
 =?us-ascii?Q?uXBJ7SNiWyEgMsnurV3QuIdJz8oS01O9VV0bHn79nlbrTR1RcePJq/EDK7ys?=
 =?us-ascii?Q?I2P8IUuMPH1MYmw7qzmtY6baf+GZhFM8sDN9AMbNV1EqWmP9DNQ/SgZoA9k9?=
 =?us-ascii?Q?uupzmiAvSvcQK8FCPGECU6l2KBQKClnfuIKtJGcfZxmH6FiZzc4gC0gMzJ0h?=
 =?us-ascii?Q?Gv3JeTVB+suLhcebtmXLL0I5GHPp7ridSWZOtFHwM/PS+L7vaTMUGqBep+pO?=
 =?us-ascii?Q?Yda2jFef6Cf0JL+F29zi6pYb5HPBi8TYFHo8+AEu04NzbcaGOBm7V8OtVLI6?=
 =?us-ascii?Q?mp/9Gm08PpCAjL6hZl01vYHE0x5N2WLPJUP5Zc3n/yH03LxsyBVkQtijMPz5?=
 =?us-ascii?Q?rfSusszVMF4ysqoFfOGaNUBkEr82u8Jpi+3uVdrwNYzxk6m9lTcm7RaDpC1n?=
 =?us-ascii?Q?ZHtPrnkYcze+/ksATU85qsKumjup9TV+h5xfVJtn+6hfbDRYty51hySVAfIO?=
 =?us-ascii?Q?+gH8ctBqwUicqHwxG3vJEEs/XsZN/2h1KfieQuh2IhTP6QO1EM4eVnEaxC21?=
 =?us-ascii?Q?Li7XGVBfY6qvHHmTWIevowB1Pu2BBa3/QrMHkbQo1P6FRuQ3iE1lTsTghJ9I?=
 =?us-ascii?Q?b/KBOmMkXqnlX/OGxPv2yfck/A7UXQ9g0MmDRpHZPm6UNgvJr5YW0sLuffCw?=
 =?us-ascii?Q?DXN4wst0flevecgBPUTDEGXwYMkmyHgZjKgPRMGeS7hOAadNf8++N97D8V5M?=
 =?us-ascii?Q?NUCfDuvTrKswJ9nIQh20+KNUOuuc5WDHRfws8yh+oXVZZvYxgeSj3Ui+vgk/?=
 =?us-ascii?Q?OBuTUwSjhxutcyzDmYt6VvDUJZw4WZlaZZxaYnMGM/nTBjZbWXwjg2k+51FT?=
 =?us-ascii?Q?VvsQjOFwrDVhbeGvLvbV8uQ2nZZynM0P1tiM6ZOEIPJKONTyvDn9P5vlddPh?=
 =?us-ascii?Q?U8R1rLeRgpJ3EnNhrltQLiwL0RYU7Vt4lRnWSZ6g7ffeslHeORMKxiHB+qzh?=
 =?us-ascii?Q?r9xk0aevqjtUlTMKhfLeIXHDwtssrtbeK1Ug2xYKtKtBX32i/RposlSGfD3i?=
 =?us-ascii?Q?JZWR7gsBWorrXtUIPjB3j9u2SHlJqTqCaoFWfy6Iqhl9QrE1bES5W+NuEtXt?=
 =?us-ascii?Q?sGbGUTKUT49EzKr9PMbrfU1+I1FZ2IhBDmdy3Ty45bv1jjRRCea9TXxAuVc5?=
 =?us-ascii?Q?7b4MwVNR0iGvZaUX+tBiC/Ro2bNP5UVja5I1J5UMfIwBTdptyQyMnTOJINWo?=
 =?us-ascii?Q?EJYhi6758z4qIN06virTjSVS9t2KN6dHB8DK97lY4hyoHijiLobXTXoYWWwB?=
 =?us-ascii?Q?XO7JN1Z+0VFgZPgWEYMtRXbwAW58jBQDtyN5/YzE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dde2815-21c2-49f5-d885-08dbf4fda57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 19:17:24.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JE47zzJHMsyQvUzlAHH87F9zs6nx1KzDAAJjc2DQQ5MjFGRIEc7TZ10ByF/C7ikpB2d+UbtkkLEYbFwhiQ2RHYwcPfpAjsbohsvIrNY1Vp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, December 4, 2023 8:25 AM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net;
> edumazet@google.com; Keller, Jacob E <jacob.e.keller@intel.com>; Hadi Sal=
im,
> Jamal <jhs@mojatatu.com>; johannes@sipsolutions.net;
> andriy.shevchenko@linux.intel.com; Nambiar, Amritha
> <amritha.nambiar@intel.com>; sdf@google.com; horms@kernel.org;
> netdev@vger.kernel.org
> Subject: Re: [patch net-next v4 8/9] devlink: add a command to set notifi=
cation
> filter and use it for multicasts
>=20
> Mon, Nov 27, 2023 at 04:40:22PM CET, przemyslaw.kitszel@intel.com wrote:
> >On 11/23/23 19:15, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >>
>=20
> [...]
>=20
>=20
> >> diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
> >> index fa9afe3e6d9b..33a8e51dea68 100644
> >> --- a/net/devlink/netlink.c
> >> +++ b/net/devlink/netlink.c
> >> @@ -17,6 +17,79 @@ static const struct genl_multicast_group
> devlink_nl_mcgrps[] =3D {
> >>   	[DEVLINK_MCGRP_CONFIG] =3D { .name =3D
> DEVLINK_GENL_MCGRP_CONFIG_NAME },
> >>   };
> >> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
> >> +				      struct genl_info *info)
> >> +{
> >> +	struct nlattr **attrs =3D info->attrs;
> >> +	struct devlink_obj_desc *flt;
> >> +	size_t data_offset =3D 0;
> >> +	size_t data_size =3D 0;
> >> +	char *pos;
> >> +
> >> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
> >> +		data_size +=3D nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
> >> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
> >> +		data_size +=3D nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
> >> +
> >> +	flt =3D kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);
> >
> >instead of arithmetic here, you could use struct_size()
>=20
> That is used for flex array, yet I have no flex array here.
>=20

Yea this isn't a flexible array. You could use size_add to ensure that this=
 can't overflow. I don't know what the bound on the attribute sizes is.


