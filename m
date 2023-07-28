Return-Path: <netdev+bounces-22280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2D766D90
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BB51C217E6
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5ED12B95;
	Fri, 28 Jul 2023 12:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77776101FE
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 12:46:50 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406C135;
	Fri, 28 Jul 2023 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690548408; x=1722084408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5PIuhGDilObYWyLdEB/sRqj+eemdftkvgN6nxczjldY=;
  b=eVtXdXQC5rY9tA6Z+OCJvX+4R/bVpdSoMw4HAeL3/ED/WszvIEWGrWvK
   Lahi76c5aSUlRkzDKnY2Y3W8rH1hGtB4W5wYzzYhp7cMTjHhTenh7XQqn
   G9iVSUrIzrYxbKSCuKNxf544prD+oW1tt0DZ4tTVVfx21gc+CIZPZLH7n
   9ByK3DY40PpRXlI6z1D269LcVZkFHROEpx6J5wJUFIBC+BtKFHRcl/K3S
   RB8dpLrxMt9NS7ShOiZSKx1rZ2D+PajN0phAlMSS2c6FJ5tycehF4k57Z
   Vuu+Zb9/dfhSnGuGRxOKYMr3/uJRMjQX0owTX1pbFlJuKq6VOjk3qTl5S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372201715"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="372201715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 05:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841292375"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="841292375"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 05:46:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 05:46:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 05:46:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 05:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cze2WKOZ/yo02i0D/j2lLygIKQwsEhR76zViaVF9lweNDFgeJAMshmYkSA2NkLJiotNwsSNGUyL3AUn2H1eMcsEDsiK6VFg0us/p0H0nSRM36xmTNqMm5DbD+y8smxqzY10dxIFubgaGfG+tNqNWqyMMgVoGnxenX9TXBBJPSG2EWTaoH/7egyiDdJJmQa4qX3GCG41znc72G972K2IHkMHnrwqlzG5MvwtaIK0y15AWfj6RNfBlnHT5/pyFQxfJpidlZKAlZqbDbcELbctgc81D4DN6kmRdR2c1/bX1G2F2rMsVwBkIMdWOJ2wjIf/1RvmTigiCpcZacutHZUNkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiePCAhtBrLSdNF/TGMg1oVRimHz8J+iFwK8499wt9w=;
 b=CSByIiKqf9xy/ku0puEmxbxjK4nzelM5JgcTfWgI94ei98Pv9EoJxKMmu2F6Ko9pJGkgRi/3cuaElWkGMulTSdEFtx/Kb4BhSbXiMz6Z/31dKIwjAYVqfHvs+YHVW1cqAbdJXBPnAwqwVYixQWrXK0VafDfUT6pe/yGl3u+H9loOoG6IvRB2nmTS4elMIUoMcjn3+pF0ixknPWvJ+UJklXu10h6XVXm21zNXZKmtjPI+wytYuOBpoozjbgpVL3J1Arma8fklBECNHkBxyEmPr5aWhVI0GrJsR5MimlPBKOqfx21RDqvmpPOhZz8DfnlT8qRdMAewLPO2bG6QGR0zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB8202.namprd11.prod.outlook.com (2603:10b6:8:18b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 12:46:40 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 12:46:40 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Simon Horman <simon.horman@corigine.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Lemon" <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech,
 Milena" <milena.olech@intel.com>, "Michalik, Michal"
	<michal.michalik@intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH net-next 08/11] ice: add admin commands to access cgu
 configuration
Thread-Topic: [PATCH net-next 08/11] ice: add admin commands to access cgu
 configuration
Thread-Index: AQHZuut4iST449x8qESvU8D6WTPnwa/JMNcAgAXPD/A=
Date: Fri, 28 Jul 2023 12:46:39 +0000
Message-ID: <DM6PR11MB4657AE3296BEBC3A094EF7CF9B06A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-9-vadim.fedorenko@linux.dev>
 <ZL6zMmyIUObOY+6i@corigine.com>
In-Reply-To: <ZL6zMmyIUObOY+6i@corigine.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB8202:EE_
x-ms-office365-filtering-correlation-id: e3a393d4-2b15-4cf8-b30d-08db8f68b04f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w2GB/GEPuGFTd3mrRzvn9KJvk3tfI1dTY6TFSDwJ3/P7FuiIZqHiMQYjDHwef0Xz0ttxR3mI5MxV+59F5m22NQeGfxJ4Q2oadSAFrpU601kkzwrBecxE42P8vmkiqx4v2aaxRYx7FVCwESNyo9CYYo0w7OE8iAELyyZTpIRzsvdYX2O0vOzRcbJA6oEjy9vqThT0as/BB5kyq09M1g7BP8Ey32CwLid0VReqaHo5oG1UY3ka35hzndkX/VQn4Y7b0VoImqSarBTa355uMn98rSUp1F00gUJmXlN9MBpOPICXc/Q05pBX4/X9HsVjLW+4zCsjyISFtU0E/EEErTT2XbpRtXPtlHlPNqaloF+2Kkq5LXgSjoVlguJTVWkI4Q6Kcp7n0QFLxeOR+RS4m1ZkiRCkUloZwsM1tIyuDHgRjYOTEzHta4GaW4RZ98wBLCvZz2PK/objsUzgStYUbAyLP9XcLBJslLLUiIEQWUE13lVLJww41JVoEuqMj/2j5u5ln1lhjgmxo7qU1eFpOG7BxnvUIhxg89dWAz4/IYET7wd8JotlReRuYAv+ROfGmgKtqvPg2N8fQRonzNZbB+kA2cYqIgQ73dFZMdeM16dv1SumKyG9lcxJq25grbuUt21D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(55016003)(316002)(110136005)(7696005)(122000001)(9686003)(54906003)(38100700002)(478600001)(5660300002)(52536014)(82960400001)(41300700001)(66556008)(8676002)(66446008)(66476007)(64756008)(71200400001)(66946007)(8936002)(76116006)(4326008)(83380400001)(6506007)(186003)(86362001)(33656002)(38070700005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8h+ls1+i4DN/bQxdb5nDnjQxoK3osUS5jMX+/Lf+B7LV/L7vQkidg+P/Cf5?=
 =?us-ascii?Q?DjOrzA3mwiZuB8ndPCqyXHZspJCaB9SozWbPYxjYvZQihe1dl2ftcIx+yzb4?=
 =?us-ascii?Q?p/Ytp34WREe87Yd1YBxn4cYWf1B2m9qmj6GcbzORY1JUOvHS8rhQKCz1ecuJ?=
 =?us-ascii?Q?vTXwI0IKCai+5MnIGNUqfGmW2FbmnG1SEcic3kRGfnbbwH1FDcEjece+xcVP?=
 =?us-ascii?Q?GjfdB3bpw0Xv4Dc4FUCYhYicLVDxE7Y8vzf33gQEN0+7fMtKYF7Fg1zilvCQ?=
 =?us-ascii?Q?ONgby783e+/zrO/IxAXvX5txQ9ElVdJ3Y9WGOorLJQygg6fNQGZBpttjvOGc?=
 =?us-ascii?Q?v2hWO94gE3Oc9MlR3VNBMUfb+mTYswuTG/TDbu8tbrvcDTas+nQhK8HHLVTo?=
 =?us-ascii?Q?UVzkB7lXwdjloqbygW25kVycSUJZ7y08uY5F2GmrguRvkc3Ek8QwrE9mUjvn?=
 =?us-ascii?Q?XWK1m1KYjIaOV7Ui/AeaY7Y1CQLnA3QLRx4QxQipg/63WliNAyrLFWJqEFLq?=
 =?us-ascii?Q?POjaoQC8CUxi2wh6helr/RzCLiYzX/IIBDRUatgl/9p9FNgDaL/cRQaq0VNp?=
 =?us-ascii?Q?sh0oLvVmU4fuhbH6P9+1r+Dvlo+QYHz61cCUMWlk4qvuCCD/RypqqBHozZ6e?=
 =?us-ascii?Q?QL56pfjVXv9JXJWWQ7BTbHXsxc0VzqHprWnqOs3y8F0VC8pbge5CpdGRLP+M?=
 =?us-ascii?Q?7JHaOFimbjiPfB46vw3r2HhOImCh+0P9I5w0ri4ZD0HyjQUhdYumNCqug+Oo?=
 =?us-ascii?Q?b35+UMm3noi8RTgLoLNN03nEbkrt2GN5OjamFUrT3gqZWmMS9tgNs7o8Sniu?=
 =?us-ascii?Q?UFQwMObdMftvfzDYdI05x2/az0xjS3Md91Q7DxCv1Gv3MpvqpkDaR6VnKPbO?=
 =?us-ascii?Q?D4Xjfj0zXVD8gfZdIVj83xCo8SAGAUSwfU7fyv56JBwciNFeUH4EoJF3qzKK?=
 =?us-ascii?Q?tIDi2KQiDRiFYn404y+I3hD3uw1488inevOvwJwChSS8Mm0xlJMtjWPWsDvh?=
 =?us-ascii?Q?VI04/lNsYOR/XaScD6pLOO4OMleYc948p4gbjM2yvcFXuip58XzPCl9wOHUt?=
 =?us-ascii?Q?gt8ljfVN2Va4YwSji1pW2JvSYuefd7ohGwAB+tPHTod8Pux/HsuDSk9c9N3k?=
 =?us-ascii?Q?IptG6ALKeGsGleaS7w69OpNbz/0TRXYXC2VXBBkWGdmTtrBMGZrM/BkHNour?=
 =?us-ascii?Q?GaxlPYORKmGZgNikNdlhf8Nk/GnYJukkgi629Cu99OVJ67eZeA9igsEJjeDI?=
 =?us-ascii?Q?tXLux835/HO9mW2Pj74aimQrrlizfDNowZeJgPQsHl1/zEN7Jl+/v16ACR7Z?=
 =?us-ascii?Q?h1QOe0HL2Uk3Sw31RhbT+RBhFSCZRJmFEuz9AmJql+RVrBRRrgyicK0ub04O?=
 =?us-ascii?Q?h2qqQ0UleKvG6Bw7y3xpJ2mxoVEjx9B98D++OzQ+9dB4AIjWjZEU9VNVHLUk?=
 =?us-ascii?Q?uh6TqBmnf81BxDL+SEPJNl8u2KwXfnA70UUlyKfM3tKDcKAhXHpMcPaeeB1m?=
 =?us-ascii?Q?Tqwtm5ftrA9/psL2T4KqU2f9HQ0KX1gkuFMaLTR6i/J24wtaoD1WQzUD3yVc?=
 =?us-ascii?Q?TQVAIuzdRTyePcHoJn1kQHLT/B4Uy1dBGtpK8Ue+D+p5AY9qXnjT0x2qwL0i?=
 =?us-ascii?Q?rEVjfe0oZ+wz/6+on9wPJFxOYzsas4jyR1cM4WN+AO4L/kceSdT/UARpfsfw?=
 =?us-ascii?Q?DXK2iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a393d4-2b15-4cf8-b30d-08db8f68b04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 12:46:39.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQdEiM2UBKnOgbujYIxEdZVUo1uTi3OI3k4W7w3LMvnC0oiY5TR9AD6lLsDnKwjLRgFxO5HClkFWkhJ2EMOP27vEa2y9KlBNRmln13nE1eI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Simon Horman <simon.horman@corigine.com>
>Sent: Monday, July 24, 2023 7:22 PM
>
>On Thu, Jul 20, 2023 at 10:19:00AM +0100, Vadim Fedorenko wrote:
>
>...
>
>Hi Vadim,
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
>b/drivers/net/ethernet/intel/ice/ice_common.c
>
>...
>
>> +/**
>> + * ice_aq_get_cgu_dpll_status
>> + * @hw: pointer to the HW struct
>> + * @dpll_num: DPLL index
>> + * @ref_state: Reference clock state
>> + * @dpll_state: DPLL state
>
>./scripts/kernel-doc says that @config is missing here.
>

Sure, will fix.

>> + * @phase_offset: Phase offset in ns
>> + * @eec_mode: EEC_mode
>> + *
>> + * Get CGU DPLL status (0x0C66)
>> + */
>> +int
>> +ice_aq_get_cgu_dpll_status(struct ice_hw *hw, u8 dpll_num, u8
>*ref_state,
>> +			   u8 *dpll_state, u8 *config, s64 *phase_offset,
>> +			   u8 *eec_mode)
>
>...
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>
>...
>
>> +/**
>> + * ice_get_cgu_state - get the state of the DPLL
>> + * @hw: pointer to the hw struct
>> + * @dpll_idx: Index of internal DPLL unit
>> + * @last_dpll_state: last known state of DPLL
>> + * @pin: pointer to a buffer for returning currently active pin
>> + * @ref_state: reference clock state
>
>Likewise, @eec_mode is missing here.

Sure, will fix.

>
>> + * @phase_offset: pointer to a buffer for returning phase offset
>> + * @dpll_state: state of the DPLL (output)
>
>And @mode is missing here.
>

Sure, will fix.

>> + *
>> + * This function will read the state of the DPLL(dpll_idx). Non-null
>> + * 'pin', 'ref_state', 'eec_mode' and 'phase_offset' parameters are use=
d to
>> + * retrieve currently active pin, state, mode and phase_offset respecti=
vely.
>> + *
>> + * Return: state of the DPLL
>> + */
>> +int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
>> +		      enum dpll_lock_status last_dpll_state, u8 *pin,
>> +		      u8 *ref_state, u8 *eec_mode, s64 *phase_offset,
>> +		      enum dpll_lock_status *dpll_state,
>> +		      enum dpll_mode *mode)
>> +{
>> +	u8 hw_ref_state, hw_dpll_state, hw_eec_mode, hw_config;
>> +	s64 hw_phase_offset;
>> +	int status;
>> +
>> +	status =3D ice_aq_get_cgu_dpll_status(hw, dpll_idx, &hw_ref_state,
>> +					    &hw_dpll_state, &hw_config,
>> +					    &hw_phase_offset, &hw_eec_mode);
>> +	if (status) {
>> +		*dpll_state =3D ICE_CGU_STATE_INVALID;
>
>dpll_state is of type enum dpll_lock_status.
>But the type of ICE_CGU_STATE_INVALID is enum ice_cgu_state.
>Is this intended?
>
>As flagged by gcc-12 W=3D1 and clang-16 W=3D1 builds.
>

No it's leftover, thanks for catching!

>> +		return status;
>> +	}
>> +
>> +	if (pin)
>> +		/* current ref pin in dpll_state_refsel_status_X register */
>> +		*pin =3D hw_config & ICE_AQC_GET_CGU_DPLL_CONFIG_CLK_REF_SEL;
>> +	if (phase_offset)
>> +		*phase_offset =3D hw_phase_offset;
>> +	if (ref_state)
>> +		*ref_state =3D hw_ref_state;
>> +	if (eec_mode)
>> +		*eec_mode =3D hw_eec_mode;
>> +	if (!dpll_state)
>> +		return status;
>
>Here dpll_state is checked for NULL.
>But, above, it is dereferenced in the case where ice_aq_get_cgu_dpll_statu=
s
>fails. Is that safe?
>

Yes, will fix.

>Also, perhaps it makes things a bit clearer to return 0 here.

True, will fix.

>
>...
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>
>...
>
>> +static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_inputs[] =3D {
>> +	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "CVL-SDP20",	  ZL_REF0N, DPLL_PIN_TYPE_INT_OSCILLATOR,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX, 0, },
>> +	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX, 0, },
>> +	{ "SMA1",	  ZL_REF3P, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "SMA2/U.FL2",	  ZL_REF3N, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0, },
>> +};
>
>A gcc-12 W=3D1 build warns that ice_e810t_sfp_cgu_inputs, and
>the similar static variables below, are unused when ice_ptp_hw.h
>is included in ice_main.c via ice.h.
>
>Looking at ice_e823_zl_cgu_outputs[], it seems to only be used
>in ice_ptp_hw.c, so perhaps it could be defined there.
>
>Perhaps that is also true of the other static variables below,
>but I didn't check that.

Yes, great catches, will fix.

Thank you for all of them!
Arkadiusz

>
>> +
>> +static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_inputs[] =3D {
>> +	{ "CVL-SDP22",	  ZL_REF0P, DPLL_PIN_TYPE_INT_OSCILLATOR,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "CVL-SDP20",	  ZL_REF0N, DPLL_PIN_TYPE_INT_OSCILLATOR,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "C827_0-RCLKA", ZL_REF1P, DPLL_PIN_TYPE_MUX, },
>> +	{ "C827_0-RCLKB", ZL_REF1N, DPLL_PIN_TYPE_MUX, },
>> +	{ "C827_1-RCLKA", ZL_REF2P, DPLL_PIN_TYPE_MUX, },
>> +	{ "C827_1-RCLKB", ZL_REF2N, DPLL_PIN_TYPE_MUX, },
>> +	{ "SMA1",	  ZL_REF3P, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "SMA2/U.FL2",	  ZL_REF3N, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "GNSS-1PPS",	  ZL_REF4P, DPLL_PIN_TYPE_GNSS,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, },
>> +};
>> +
>> +static const struct ice_cgu_pin_desc ice_e810t_sfp_cgu_outputs[] =3D {
>> +	{ "REF-SMA1",	    ZL_OUT0, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "REF-SMA2/U.FL2", ZL_OUT1, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, },
>> +	{ "MAC-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, },
>> +	{ "CVL-SDP21",	    ZL_OUT4, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "CVL-SDP23",	    ZL_OUT5, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +};
>> +
>> +static const struct ice_cgu_pin_desc ice_e810t_qsfp_cgu_outputs[] =3D {
>> +	{ "REF-SMA1",	    ZL_OUT0, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "REF-SMA2/U.FL2", ZL_OUT1, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "PHY-CLK",	    ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
>> +	{ "PHY2-CLK",	    ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
>> +	{ "MAC-CLK",	    ZL_OUT4, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
>> +	{ "CVL-SDP21",	    ZL_OUT5, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "CVL-SDP23",	    ZL_OUT6, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +};
>> +
>> +static const struct ice_cgu_pin_desc ice_e823_si_cgu_inputs[] =3D {
>> +	{ "NONE",	  SI_REF0P, 0, 0 },
>> +	{ "NONE",	  SI_REF0N, 0, 0 },
>> +	{ "SYNCE0_DP",	  SI_REF1P, DPLL_PIN_TYPE_MUX, 0 },
>> +	{ "SYNCE0_DN",	  SI_REF1N, DPLL_PIN_TYPE_MUX, 0 },
>> +	{ "EXT_CLK_SYNC", SI_REF2P, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "NONE",	  SI_REF2N, 0, 0 },
>> +	{ "EXT_PPS_OUT",  SI_REF3,  DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "INT_PPS_OUT",  SI_REF4,  DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +};
>> +
>> +static const struct ice_cgu_pin_desc ice_e823_si_cgu_outputs[] =3D {
>> +	{ "1588-TIME_SYNC", SI_OUT0, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "PHY-CLK",	    SI_OUT1, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
>> +	{ "10MHZ-SMA2",	    SI_OUT2, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
>> +	{ "PPS-SMA1",	    SI_OUT3, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +};
>> +
>> +static const struct ice_cgu_pin_desc ice_e823_zl_cgu_inputs[] =3D {
>> +	{ "NONE",	  ZL_REF0P, 0, 0 },
>> +	{ "INT_PPS_OUT",  ZL_REF0N, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "SYNCE0_DP",	  ZL_REF1P, DPLL_PIN_TYPE_MUX, 0 },
>> +	{ "SYNCE0_DN",	  ZL_REF1N, DPLL_PIN_TYPE_MUX, 0 },
>> +	{ "NONE",	  ZL_REF2P, 0, 0 },
>> +	{ "NONE",	  ZL_REF2N, 0, 0 },
>> +	{ "EXT_CLK_SYNC", ZL_REF3P, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "NONE",	  ZL_REF3N, 0, 0 },
>> +	{ "EXT_PPS_OUT",  ZL_REF4P, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "OCXO",	  ZL_REF4N, DPLL_PIN_TYPE_INT_OSCILLATOR, 0 },
>> +};
>> +
>> +static const struct ice_cgu_pin_desc ice_e823_zl_cgu_outputs[] =3D {
>> +	{ "PPS-SMA1",	   ZL_OUT0, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_1_hz), ice_cgu_pin_freq_1_hz },
>> +	{ "10MHZ-SMA2",	   ZL_OUT1, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_10_mhz), ice_cgu_pin_freq_10_mhz },
>> +	{ "PHY-CLK",	   ZL_OUT2, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
>> +	{ "1588-TIME_REF", ZL_OUT3, DPLL_PIN_TYPE_SYNCE_ETH_PORT, 0 },
>> +	{ "CPK-TIME_SYNC", ZL_OUT4, DPLL_PIN_TYPE_EXT,
>> +		ARRAY_SIZE(ice_cgu_pin_freq_common), ice_cgu_pin_freq_common },
>> +	{ "NONE",	   ZL_OUT5, 0, 0 },
>> +};
>> +
>>  extern const struct
>>  ice_cgu_pll_params_e822 e822_cgu_params[NUM_ICE_TIME_REF_FREQ];
>>
>
>...

