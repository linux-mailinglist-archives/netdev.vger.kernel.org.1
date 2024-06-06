Return-Path: <netdev+bounces-101347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C908FE380
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A98B27C50
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DF152190;
	Thu,  6 Jun 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="uftOaDOP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A01514EE;
	Thu,  6 Jun 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666944; cv=fail; b=At0MFRQLhQ0ZzObdUwL09guWurTA8yABo7+alPUA+hRqHhz/Y4JmbaQuJjNjt3bZpeXd67SI0Lip0wPVQpNoZeNdigspU4UVBM9j3shLN61o+zwDffdjf5TpQUUNAdRv/V4VLFN5H6VCcFNkmVgB9nRfT1pFZgv+n7qUjnuULJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666944; c=relaxed/simple;
	bh=RYeqpW9BfQ8HAGqpu1i+N/J6tJsnMQP0e60qo+N8pVo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mVaAr7mN7zAWqeVdAOM3/vdiF8tBNWyNI8KwE/gAzMiBTZLawPAmFUI5bh/IwfSgLQVu22uyYYRiqY4LPQUtnxNY8jGRXNfY5/oNgkAZwXmsXQouKT31H1/oD95VtJMTdU71uItv1VHKZ9VGSFhhwaltGCEwYBcVGltvLCSpsv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uftOaDOP; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4560WOps028619;
	Thu, 6 Jun 2024 02:42:08 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yjshcc6gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 02:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4vR3LKFCYIzhJ428I/aGdj3wFq7culqhvjrSBIGQoJ/2nJrVHiYVGQ80e96/lJAmkpnFGdNzfAxIFfGn9CxfYbkQz0upaH8gtPHoT5fRqtSamQbsx7hR2eBqbeveNs0ha6fmqAreKMoUT+QxOpY1UCzQvsXOy/vT9l0C4ZVSjzY2rt9wY6aD+tPjAltgBgkJ+2AX/PS4R+mOMoQKkD+JJ0dU7+F3iEM1+StfDucP6LFDKHTH7uq2ETt9TIm15nJgUohQY5B2EsPz6VwuTR6fzjJxYJwdLxV2nQzJ4GhaHL3J/jX9DO1McbfBgx9juw52b6HZCVfytQWhQS5EXvzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjmbp/jX6uWbW71rNhLZ9BL8u37nTlDgfhKTcueVjiw=;
 b=emltc0w+kIKeGzHA9tH6bfK2Tr4T2oXwhGouaWyRTunBVuxJlRLiK1irEbpE2vtyBlb2zj5Rw1SAuHGtytes3ZxTZp/5q0MhP49JvLN2j0KutGEdz0nu6TlFNneF+RVR6GU45Y2gs7+gKmMu0JAW11RVTE0AyeGQHz4AFd+Ols9/WkUoTUSfrrWeX3EwQx+L4Qlp9bI0Hp3dyr69HH6ZJZgMtK0aswSoFakznhK65MHQ7sxg158XSumqmYmDxmdWwyvZovhKaZWtzYH/s6EJ1k3vp+ZOtk2A1ezprvjoudnfo4dooh57a1nvvFyrdM+ssngMwyadgBpYLKvpTqhRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjmbp/jX6uWbW71rNhLZ9BL8u37nTlDgfhKTcueVjiw=;
 b=uftOaDOPvkoZMlU/Vve/NCkNEPHLwCjqlmsxHTN+CRw3DK6ndxVMyIv1KFGihcW0GNWq3MJWGvkr0VgGzdwLtwFBslNDEtRiqdY3rLIJDZxFaKlP3pir7HpoKeRiLx810GxfAXwhf1iAoZzUhdwtc5hvTGX/Y9nsROynDzawxsU=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by BY3PR18MB4691.namprd18.prod.outlook.com (2603:10b6:a03:3c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 6 Jun
 2024 09:42:05 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::ba6a:d051:575b:324e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 09:42:05 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v1 4/5] ice: implement transmit hardware timestamp
 statistics
Thread-Topic: [PATCH iwl-next v1 4/5] ice: implement transmit hardware
 timestamp statistics
Thread-Index: AQHat/XKbSnryGuzBEOhscpgf8ZQFQ==
Date: Thu, 6 Jun 2024 09:42:05 +0000
Message-ID: 
 <PH0PR18MB4474A300F2393A7B22BB7B30DEFA2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240604221327.299184-1-jesse.brandeburg@intel.com>
 <20240604221327.299184-5-jesse.brandeburg@intel.com>
In-Reply-To: <20240604221327.299184-5-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|BY3PR18MB4691:EE_
x-ms-office365-filtering-correlation-id: 5aad20b7-358b-426f-1d88-08dc860ced27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?sJiWCLEsi/9V91ZAlIp7KuLBz5tQByuAmohbfbIDY0k1k0aPfBeFL2b0nAqy?=
 =?us-ascii?Q?96fRSMBioPixG6H/zXl7/pgIaFViLBsL4u4mA3uRGhuJsfAzhxY00BMHlX6K?=
 =?us-ascii?Q?cWSQtJzwssQ4DZQjgp1jhDKDxOZWcJI3CN8JK9Gm40NTiRBz3lFSYkEoCvUI?=
 =?us-ascii?Q?WVjWttQW/uPMijN34jeoGhx8Zx3kvsQgKPj8M6QNSeKp1qPDvgBWTLlbd8S3?=
 =?us-ascii?Q?oPIopPOptB7GQVslX1KnJEnfFI7vcTgTh9pCAuMlBBpF8F/8vfmesncVOQPm?=
 =?us-ascii?Q?ygcCaaQ3CqRQ10dne3kKJcx0XH7lO/0mnMm/t5de+VqEnmTCwvj9h41SOACs?=
 =?us-ascii?Q?x8DqclbAkIn5GC2j2EkmxRGjyonrayGPc6IwckLG9sgcFYVojuuHHnW879oc?=
 =?us-ascii?Q?o1nInKJcHMys0YV7gwQgNGTfZlIYH5DjBaNvgoR6F0GqOd3wNJ1mQkgTj7bj?=
 =?us-ascii?Q?FwardNRnnb2IDsKkUbsjYl5Xi7tpEHf5AGkGKJCDcVTkz5H54QpR6STTaHE5?=
 =?us-ascii?Q?sVhfT3q8kwqin1Cl9FhdWJ++GXVyKSKzK7yCrn0ZIUNX+W7MBesIDi919g1b?=
 =?us-ascii?Q?j60avM+E2ZIetNhJ7UxueZy9ChtIoHeScHYBw+dmMMsSboSu0lJDFvQRkqGD?=
 =?us-ascii?Q?s3zPie5rh3iD+PkuTzfpNDzSck7tkm9Tr3WLH7gUbm4dDuo8nYrz06wdZZA0?=
 =?us-ascii?Q?JOnTqtDp1JHZfwSto72nPKnM9OzLTIoYyHsfoj8qC0b/Gf2L254tyfcMmwy2?=
 =?us-ascii?Q?hEYfAWtjstxj7NDE3ZLk1E3R0HtVcLWRNAouQKEfTHw1gf8G4mA1x99kmo3G?=
 =?us-ascii?Q?M3n/CBGSK9vAcIuubaodpDCU3HccH8nI4H3RJ7x16vQiBW9tfF+PLxtAMUu/?=
 =?us-ascii?Q?9Rk45J9zc0eKEnu3YTUDEa9yqKwn9IKjmBu6utyux/UYKUFgGzI5G4+G/FMk?=
 =?us-ascii?Q?P0fydH2xkvp1NJU8nNHtWScCuKpuwD2yb/werpvLss+YIHOZnsTU/RtCVLvz?=
 =?us-ascii?Q?YqCDKuTEGfz40zQwc8qOHfAv9e3RPd1j5ciVvZSHqN0y3d1WYt0TjsybiX9u?=
 =?us-ascii?Q?96mBd6RiXFB0zX3NtPyC8N4H17TWGds2Jo5hUxSK+n/aHKTyH9msLEzpQAq7?=
 =?us-ascii?Q?e4l5YlEphbkvO+vPYr9BiEyJgh4zYQ1xNDsqk+WtK7apkqjCSh0VfwAX27FG?=
 =?us-ascii?Q?16yVcGKu6NAaSkV/sEB0mBk6AochCk9LKORc+E8Kv1qVbZFwgDxUifEMlrWo?=
 =?us-ascii?Q?coSOnp3zGrHdh7BJ8FcicLA18TR/me7JVl7FpED/B4OD70jq+PwlfG3fb20g?=
 =?us-ascii?Q?eB1F3xpbIC5HBOKhmw4fF7pBdkpn+N1lPRat8MnRZwiYB7J4XFWX6u8WJVYM?=
 =?us-ascii?Q?CDAp/cY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Fv4YuEn0Gyxr27p99Qx2CYfnFLBZTdJClHwot1OVETcsKiPMe2zP4wQfFZse?=
 =?us-ascii?Q?fXTbgAA+8dgz/FWlH5WTJhJ/47v6w2fJaylWHwS536ZNqabUl7t60hEeG514?=
 =?us-ascii?Q?ZIU93G5sKiVWMhuPQQP50lYS7pZ52bALjzCCIjf8AAJOpAUIQ/jKsDIOHkD5?=
 =?us-ascii?Q?3PFJOyKZHirkzAriNjxk4Ydisgqob55lXZyHfHojZFgO3XPeVbo/kopH4812?=
 =?us-ascii?Q?rhKrZHFcKtaPZ6B+XY+B3IHqGq4IKe/1ocj/ET6jkCk5Iamk0C2ve9uLb3Fe?=
 =?us-ascii?Q?pHg6H8fSaYX7S9+JDjLw1gR7BVUDhHLPG5m2Xgkkr8V/T2ZXK2yQNNuKjJ/x?=
 =?us-ascii?Q?lrzXifvufrSMBE3g3weHKBxPkRsksE4XFhZGR7at2jhPp2GZkv8XLl6PmZ5F?=
 =?us-ascii?Q?+81G05HcLc26T61FZtG9tn2uyz3ghuhvB7r+hq0Di8u/C6KLgpxMjkUUvz+i?=
 =?us-ascii?Q?BmzEQdhdcvh8FzH07u3XUn4WNL65ZDDVoBa+SD98J/OK5WxvVfPPdArjEgbu?=
 =?us-ascii?Q?FNcqlw5rJx2mA6ppOf+3NHZSIk8ll8Htn3vSDP0OPohwUXLAUWhcO9SwxV4c?=
 =?us-ascii?Q?azYuPR219oGRM5wnXfF7sKDOjZxwmukosQpgffwKjty4KYTK3Y5tKF+XY2Fw?=
 =?us-ascii?Q?R5RMTYyyun6Dzanvdvn4HlEkjhWz3IXW3RTCumNPhRhJlUJlMsjmDRB75StF?=
 =?us-ascii?Q?9rVBfzSMWb1rdT32HO/BrK9Mfy6az2K3zjQ34b7GhR2LA5NWLcu7I/4mo7Pu?=
 =?us-ascii?Q?JUJPgik4vdFKcTyqQrCZGZtkASxRGjlYoaPQ2DpUbjyL50BJBlRQHKBl7FRS?=
 =?us-ascii?Q?MnBaOVbLDpEuxpojfLcw2yoTq1d2hi2cg5peA//Tp+pyKZkQ4cmvMuVDeF68?=
 =?us-ascii?Q?lid18efSEcSgsJrrOkhs4zlM+JEq6Q92ilSWSCbkX6kmD7DLARQbZsbWlpAN?=
 =?us-ascii?Q?uaTf664AAy8/6KLqf9bNkAxRGzH/0yjsobK7mby92nNVCUEastTLEwvjdjHJ?=
 =?us-ascii?Q?nGJqH86hXNRnET2Ya3mVS42K/5/1TiDCLFGra2rKSKV34bNCvf18m9WCRXJJ?=
 =?us-ascii?Q?6ETsoC1TIbkjnXFLsdNo0Dyg1o7LGSl5BpeBXUmKs1Ka/tinIClUj+l1RMk5?=
 =?us-ascii?Q?M/8sbL/DJPMX7dYMZjwsmKul/ZPUo3+kQrz9CUu6a2X8NL6MGxpFUXbXno3/?=
 =?us-ascii?Q?TwKHyKTaW8QEnKHGaOBNhrWjecv+94UOI14RZhc17yo01YMJwnTguQzHr1Wz?=
 =?us-ascii?Q?GNhSAAI8Eo69Glwm3CdpskwID3jZju7b+cUuXxlRNibD3nRcG7tDg1lWV4+S?=
 =?us-ascii?Q?Zz9XPXSdj3wnDcTUMhhvp+gy8rSyQB0hB9ElkFm3WtoCzfwnoRMajnnFe/8A?=
 =?us-ascii?Q?JSUXkrKK5ks9ovzhdm1YJ6EF03LRJx1+c1hFK/0aCgbTEc+IoyTWDAKTdeJb?=
 =?us-ascii?Q?M3PiddKI34fPB2qQf+X0mQgAM2766x0S+0kvStpSJCoHTbbkX5QMiJzEvFd/?=
 =?us-ascii?Q?8iXNA58jX2+3M7YZf51ohqhGav9PcVMzHSykKCA+kFixO2KEAQ2FXgX9RFB7?=
 =?us-ascii?Q?0Muketao5jrnHwH8IEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aad20b7-358b-426f-1d88-08dc860ced27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 09:42:05.5732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW/yeUYwO6DqNXc38w3gGOucA6zEcLkI6iBmNQpfQsQXC7V659zAssZIiayE9DWw/pSxSd2k7VewITdFOuCl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4691
X-Proofpoint-ORIG-GUID: Joodqwt4h3UnU8TGuDCZLDqAgQT28sIA
X-Proofpoint-GUID: Joodqwt4h3UnU8TGuDCZLDqAgQT28sIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01


> The kernel now has common statistics for transmit timestamps, so implemen=
t
> them in the ice driver.
>=20
> use via
> ethtool -I -T eth0
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>=20
> $ sudo ethtool -I -T eth0
> Time stamping parameters for eth0:
> Capabilities:
>         hardware-transmit
>         software-transmit
>         hardware-receive
>         software-receive
>         software-system-clock
>         hardware-raw-clock
> PTP Hardware Clock: 0
> Hardware Transmit Timestamp Modes:
>         off
>         on
> Hardware Receive Filter Modes:
>         none
>         all
> Statistics:
>   tx_pkts: 17
>   tx_lost: 0
>   tx_err: 0
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 6f0a857f55c9..97a7a0632a1d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -4357,6 +4357,23 @@ static void ice_get_rmon_stats(struct net_device
> *netdev,
>  	*ranges =3D ice_rmon_ranges;
>  }
>=20
> +/* ice_get_ts_stats - provide timestamping stats
> + * @netdev: the netdevice pointer from ethtool
> + * @ts_stats: the ethtool data structure to fill in  */ static void
> +ice_get_ts_stats(struct net_device *netdev,
> +			     struct ethtool_ts_stats *ts_stats) {
> +	struct ice_pf *pf =3D ice_netdev_to_pf(netdev);
> +	struct ice_ptp *ptp =3D &pf->ptp;
> +
> +	ts_stats->pkts =3D ptp->tx_hwtstamp_good;
> +	ts_stats->err =3D ptp->tx_hwtstamp_skipped +
> +			ptp->tx_hwtstamp_flushed +
> +			ptp->tx_hwtstamp_discarded;
> +	ts_stats->lost =3D ptp->tx_hwtstamp_timeouts; }
> +
>  static const struct ethtool_ops ice_ethtool_ops =3D {
>  	.cap_rss_ctx_supported  =3D true,
>  	.supported_coalesce_params =3D ETHTOOL_COALESCE_USECS | @@ -
> 4407,6 +4424,7 @@ static const struct ethtool_ops ice_ethtool_ops =3D {
>  	.get_eth_mac_stats	=3D ice_get_eth_mac_stats,
>  	.get_pause_stats	=3D ice_get_pause_stats,
>  	.get_rmon_stats		=3D ice_get_rmon_stats,
> +	.get_ts_stats		=3D ice_get_ts_stats,
>  };
>=20
>  static const struct ethtool_ops ice_ethtool_safe_mode_ops =3D {
> --
> 2.43.0
>=20
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

