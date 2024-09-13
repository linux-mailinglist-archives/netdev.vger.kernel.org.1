Return-Path: <netdev+bounces-128247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FB978B78
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0900C1F23DD9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF385158A2E;
	Fri, 13 Sep 2024 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxooX1Gt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB7D502
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267405; cv=fail; b=KOIIgkuGNbKEUnO0V0HgrQYoSfdTo9Ay5Q/X4iQZY4hTTWsQ1CHUgY+27Z185FTYBcAWei5kiVF041x11whxr5E06FKWh/d/2VZo7aDF8jRqgN8qxKbY9IBrIkK7tH+uw8HiLNjwckin9Csx2l0P5Or7mz8dOHb2PIu+bxTiR7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267405; c=relaxed/simple;
	bh=cT6ESmv0SgNqYAIxbZbw5GfE7UgA6EnNUchul8lK+uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aR9KTrtMMxWjAvKHwvIyb/xe2ifKDdF264Ad1Jt14hh/ZVUf25jiBahkTb/xmcB89NCKuMsLsMOPhGZP0NuN4U+JAeA5EU0g+jqzPU8B1hmKmwPRwhUlkXQf56MlMp+VDCS3Ct9KBII8FDgf4dtF7e7px9dD5uq8qjPQN09vOFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxooX1Gt; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726267404; x=1757803404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cT6ESmv0SgNqYAIxbZbw5GfE7UgA6EnNUchul8lK+uc=;
  b=BxooX1Gt5ydorEUBt3zwlSZ3CTGwXYnub/6HRftE8hvbH3uTWUMt4oXE
   EEZB50i/0/0aAdvzsj6ReqNhHYz+kFhhhm9UQxC1+12L2lRm0UIUQuwVS
   KTsZOz1cvzzkf+AaU3JfsQTPc0OFpv4kgSQzgctwQNYTQRXs8BEr9qNMc
   xJqNSQGH8RRuRls5XH1RtDl1KqxmosKq2LtDicvOBlpg9BeiGrKirIvBk
   MqiTZ5IHF5E0kDJ2EG0lSpN2ORQNjAndJpZh+NEovN8W5tU13Q1AB+nxP
   49dFTJscIdPjIw82hrcW2GZvDrP8/hHFAXpIIhESTZ0Fu+xzscNMPbowM
   A==;
X-CSE-ConnectionGUID: A2uiHX+OQ62G1G1FBb8oDw==
X-CSE-MsgGUID: FrFcNta9Ss2NWkir+29KbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35856698"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="35856698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 15:43:23 -0700
X-CSE-ConnectionGUID: Z2kazfn6RzefCEEv1ocDXg==
X-CSE-MsgGUID: 89CTAsuFTi2kjQSJSh4pWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="68084424"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 15:43:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 15:43:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 15:43:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5BPUEEJLlnqF0IMgHoGKj5fh2dzJGQLC4QHYL21+KOi5Jt2dnaNEcxtKYbCCmpU4M72HW6KzGrnjDryKR5H62Y20r1J563AvXL4HeVlgIQkQU8UV2VmUllGuQvSwavBcOUJ38z/Q9Z30j17fv87Wcpq4PZ3W1E9PW2GBcQpw7ZVxr81hk1eJyUL6z3MIIc8uR7W8VFu8lSic+3YqF8l+Os0Ydk+S1BAJ9DaUVO+E8VrJlxON8S/bHa/k4v0oZXTzv/jOAxYOpaOQlG/g7JIyxhw+Xmd7dwE0C14PMWinwzNHrM6AaChMazcF0izZ90yVe3IA4STYQPmQOIz94cOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qOYGaeMYnmG441+SOF7Klf6B/V7jCH6NraUtN9GQZg=;
 b=nuwfhlUw97T+WOT537PMakiYg6p+zMQVsE2u9KlH7ttbr+rlxFgaTwYRAB/I6ko2yvOSCq+5osUDoav9aO03TmJVIwNuJM2Ai7IUchlRc8+4kqploX9QcrNCYaj77PU+4bLE1Oy4hVL91EKVQQpQjnnFKXvZllSTUBNPI+E/kd4gQg3vAUkiwaJ8wJXBS6g0PjiVAwS0GAdZKspi1CtINXLhaVBpaaep9hp3FplFlYmAm89IzDW6uuERT8Iy0HkPjn+KK997oWRcIKKKDk8MIrOYHMLr1xqRpCitSRYwk+h/reTNSmnxT/XNjwVRQU4mk32oaLvPS4Mm40h5+GKyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 22:43:19 +0000
Received: from IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb]) by IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 22:43:19 +0000
From: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Topic: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Thread-Index: AQHbBcDCNfFxzJCH10CXGFshkzVK97JWT2gg
Date: Fri, 13 Sep 2024 22:43:19 +0000
Message-ID: <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6266:EE_|PH7PR11MB6772:EE_
x-ms-office365-filtering-correlation-id: 73921fa6-7599-4d73-bab4-08dcd44576d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JR2xZC6y3f2Sc1ErcnhIomcZz1DrgHkV7svrRoIpxqdVYQcKc7qMUYlop1B8?=
 =?us-ascii?Q?r66jpiohJMx7b+D4q7Ayd4SVYmw6bpB1/oe3LjjARhxbP7fFu5ku1AbngRpR?=
 =?us-ascii?Q?evxtlcS2W7oTmkuyt2LHQFJRezdpXhZWsQIcI4JPBgbWXrmoHEZTrzku1CY/?=
 =?us-ascii?Q?kMU/foN9fUw6vV3OZNqUKHMrKxlLamusH7433QHWLkakBzM31vOsGk/dTCSv?=
 =?us-ascii?Q?Fck/+x9YG41e79k3SCdwp/0XEKzkt0+IFdSZ2Fy+c0xzj1pIM2OIgG4RFI+U?=
 =?us-ascii?Q?BP7AbP7Sb3kcuFLvUK1CqwlpQSNp/ErCp7GnbhHaTE+RfFSjp2mVNctiozLi?=
 =?us-ascii?Q?R33DXGLd10htkwaxcsYMTzFkEWMvP0wqZQjZYkEyLJNRcgAR/G6tV4+24iLu?=
 =?us-ascii?Q?nU1XK1nPN2RpfXoR5XxtTxKk1Tq5owTgBxsfHoiitcwPoyG3EAN41QTyPn8a?=
 =?us-ascii?Q?6jRYYz43FqoKkssDWt1aZ42GzYV1zBqHc1yAm7U2gGCzbvaT73vZdJUtMI2k?=
 =?us-ascii?Q?xfaiI3sB8r5G30JeZR9HdnfDFr9frts+MYRrVdrv1YmqqM90RQ/XuUO9/Tcz?=
 =?us-ascii?Q?F/qh/AnuiJMxO7xkDXYAVXAh6BpZ/Nd/RdeFPgQBdAfr8kB/5hnMPDMYJAKw?=
 =?us-ascii?Q?JydFU82ZivEo5JbtmzE7X0UJyhN5cSTM2Pk7UqRmOCDu66cF08gInThy59C4?=
 =?us-ascii?Q?fBU/4K2iNojZiSJC8Ls77/N5ozmXQrBT9Nh0TnQtXyfXk1LI1v3uRRPDVFGP?=
 =?us-ascii?Q?QXsZQAfmXii/sWqQpavR0JaMBcmtvR+uJ6h1s7AOMX7p4ccaHau/10Xu6S/1?=
 =?us-ascii?Q?se5NEhgOCnho8TQ+sxKAL+/yOrdL80Fid7vL7dCQMjOnkD9UllJNAfHq+cRf?=
 =?us-ascii?Q?avjizEiGpiMdIMMuPe0TrXoJTzAJDMpbYr1jUm2S8MhMrulmBVCRoMozyySM?=
 =?us-ascii?Q?13j7KEajUGau6QLW/p01ZqSEtZ0ZeVnryqTfFTp8BncEsvaHdQ+AWX556kya?=
 =?us-ascii?Q?Cko6hihN6AhbxX2HqOd3FNVOOg9Zp0U/o1T6XC3A41PpNfSJTNeBWZronAsc?=
 =?us-ascii?Q?/J5+Kl/0NbOOtHtKmbzu5Ntp7WtAAcZoyph/TTHJvhJ6Ag2uxtWfDi6SksDd?=
 =?us-ascii?Q?0gryst84+/+pVNWz21hPB6a5KobpCi/RlGJKWRZHrm5181BugkrVJnbqsqAl?=
 =?us-ascii?Q?s0UErYKcq0UEYyyKOHIWEJ5Kc+u3TldnXm7Y4oWZ6dytQSB4jhy2JbARUmaM?=
 =?us-ascii?Q?9Qi+p+OGTvmm4dBJiJVGC04zPEL3QgyykdfVV8IeSdmfa+PrdNYRorejAHAe?=
 =?us-ascii?Q?gyU6aHiTgHn1StaN0Y4wy+Tc3zK2oeffA6nZJQyoxJWx2H6XsZ+WVIaLgQ/G?=
 =?us-ascii?Q?rXH8GAmlyWhOj2d+A+AqiyELI8y78lNB1+7rJuqEE/8MaumfUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6266.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a5hImpQkvu8n7IYg5hlIQTL1zducizLGQ18MaAh7vrK8PY7hrn7NEWKKAWSB?=
 =?us-ascii?Q?LTGKSeshuzUSGzT2Os9k7Y5vqRsy7mMblXHfew3yGWNa7AzoMWYfRGOCZVzA?=
 =?us-ascii?Q?3l9zvtmb5a8Tcmp5eJ3pZE+Wv0nGV3KP5lluKj0sloPJU/Jid22sQ77eUVK5?=
 =?us-ascii?Q?r/zYAHKtGwWLE4eabuFQwvLSMsS5zBuyCnGiLvjSMxOf+LAa9gf/iOiwoA05?=
 =?us-ascii?Q?rkvRJtkxwn3+w0E5ctB9dYZqHCGboWnrebxr+8S89j0kIdJLZIv9NEd9Q6dt?=
 =?us-ascii?Q?KfXswUv+K6cHsy/Z9G8Brm26yzGYG8eAyz1eKc199XKyQuixOj2k1t/XPJJ1?=
 =?us-ascii?Q?XGvQ/6a5OnZPD5sIefUFGiOSdtE7D60ZQBj0x0TeEgRq0+k+mYVsEqlN+D9H?=
 =?us-ascii?Q?aEvuzyHR2B7bpJwWKohVqATkzrQanGK1d2v+R1ZuCsyghN3pEK+f4YUz2rfI?=
 =?us-ascii?Q?1aNJnU8XSV3QnmhB8yU++dXjSVuA9uCudo4a39+68BTapLa2n20BL2QNaOUO?=
 =?us-ascii?Q?9tgAIlc1rHnMe4zryKcBo16mIbiOlAmOJ5nrV1q+7wpcLNhKvyrLUnVkNaNa?=
 =?us-ascii?Q?n7yQBfW7qAMtLU7WxtnKEuAzacUTbWbTS+9/oEgbyxA3tb9kJ+VdF87RQQFg?=
 =?us-ascii?Q?/onNgO428u2qvQh/AzhlE0iFIOvyhlooKqiMGLgFSQZmVZIVN2V8iHDSd4xV?=
 =?us-ascii?Q?brpx5CgV4Rf/wR5MCcivRgEV7fxvrcYk1/VZZsuq/8MfEJazhma64VR/J+QP?=
 =?us-ascii?Q?ZViM57rrxKhJsI2CC4vhUj7zsr+WtEheLdW3kncPz86ZNVGbhCF3oUiWD6gN?=
 =?us-ascii?Q?qbpt2g0lnzJaCsE8O9AMT1oo4DO9UF4ptbPQIXDjEv7ZLqobVtmnOQTtuoTW?=
 =?us-ascii?Q?X/Lq6de0sHjs+DP1OuLml2+l7Z1iVUyYOM4RwSeCJI+c8TdVwvbqpZQJCg9T?=
 =?us-ascii?Q?nd0KOnUQRHh9ZV6QCTHhMFX6xfDhGxAab4IcdFhV6rQkezqKDkpgMwtE2Ouq?=
 =?us-ascii?Q?/gOv1fBmdM91BmsaLTczfypN6jGog6gtzGjPmG1ala0hfJgpSnPOvC9t094i?=
 =?us-ascii?Q?veXZFM6G6Wg/LF/kIlYhHBEY6vX6oUw+tRb/VA2wAN82XRMFA8mQdZupG8hE?=
 =?us-ascii?Q?m1CmmNqk2abUbkEzFCz2tMD097W6JjEu5pkgWxndNTNentkr1pPmN9Vxor7Q?=
 =?us-ascii?Q?47HdfcvbHCvhCt9BUhakm0Lswiz3+XF8CyNLC6kHtmIZud6gls2bdooF4CdD?=
 =?us-ascii?Q?iVpa7KShS4FKGcBT/xwHtuqa2xqBmSKXhXBSlQXHeOf6JYqpL6OJxNYywu4v?=
 =?us-ascii?Q?pvVnTSUvJlg24OxK2v3DT6FSeDw9UC+dPxDuhq2+WJhO4teEDM+VxMh1ezHe?=
 =?us-ascii?Q?zKd+OfRF1YPHfP41SaxBnTEQhjWm3EXXR59SLif78RjCw4h/VYZlH650gewQ?=
 =?us-ascii?Q?Ec8Knz7mQchn4oq/QSrJmUb1OFsOeOrQwzPDPWa0VnBjgTNptP9S9TatUzfB?=
 =?us-ascii?Q?ewEd6p7C0ci3tRItMr407X7N8fI6kSA9p3txrKThTzUPx2rwXjxuN/viN1hZ?=
 =?us-ascii?Q?b+yHu40Unu9jghR5NOCha2Y/KQ4b5JoSMEzzP6ejK2Ivsgo4G3NeeDQ6uwwV?=
 =?us-ascii?Q?dQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6266.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73921fa6-7599-4d73-bab4-08dcd44576d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 22:43:19.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YagKUrlQQxjEQo/7aQor9Ag62C9RGkFbbHmrayNm583fJLm6O/eLofXQWOjSNtSl2Jd3FgboDUcCKABy19k9p9lABuEu6roreKMqb+51qOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Friday, September 13, 2024 2:38 AM
> To: netdev@vger.kernel.org
> Cc: Michal Kubecek <mkubecek@suse.cz>; Jakub Kicinski
> <kuba@kernel.org>; Mogilappagari, Sudheer
> <sudheer.mogilappagari@intel.com>
> Subject: [PATCH ethtool] netlink: rss: retrieve ring count using
> ETHTOOL_GRXRINGS ioctl
>=20
> Several drivers regressed when ethtool --show-rxfh was converted from
> ioctl to netlink. This is because ETHTOOL_GRXRINGS was converted to
> ETHTOOL_MSG_CHANNELS_GET, which is semantically equivalent to
> ETHTOOL_GCHANNELS but different from ETHTOOL_GRXRINGS. Drivers which
> implement ETHTOOL_GRXRINGS do not necessarily implement
> ETHTOOL_GCHANNELS or its netlink equivalent.
>=20
> According to the man page, "A channel is an IRQ and the set of queues
> that can trigger that IRQ.", which is different from the definition of
> a queue/ring. So we shouldn't be attempting to query the # of rings for
> the ioctl variant, but the # of channels for the netlink variant
> anyway.
>=20
> Reimplement the args->num_rings retrieval as in do_grxfh(), aka using
> the ETHTOOL_GRXRINGS ioctl.
>=20


> -	if (tb[ETHTOOL_A_CHANNELS_RX_COUNT])
> -		args->num_rings +=3D
> mnl_attr_get_u32(tb[ETHTOOL_A_CHANNELS_RX_COUNT]);
> -	return MNL_CB_OK;
> +	ret =3D ioctl_init(ctx, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D send_ioctl(ctx, &ring_count);
> +	if (ret) {
> +		perror("Cannot get RX ring count");
> +		return ret;
> +	}
> +
> +	args->num_rings =3D (u32)ring_count.data;
> +
> +	return 0;
>  }
>=20

Hi Vladimir, my understanding is ioctls are not used
in ethtool netlink path. Can we use ETHTOOL_MSG_RINGS_GET=20
(tb[ETHTOOL_A_RINGS_RX] member) instead ?=20

Couldn't work on this since I was on sabbatical till this week.

