Return-Path: <netdev+bounces-19998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCE75D538
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 21:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B32282326
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7FD22EE3;
	Fri, 21 Jul 2023 19:48:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BA1EA8F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:48:31 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531522726;
	Fri, 21 Jul 2023 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689968909; x=1721504909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9EmbuIC9jl2iejZuhY1GnwqCyWEaBss3YEndrTWtkcA=;
  b=L6r71bxHP2f4OoPvQbFYWkahOpCK7hMJo6zocI71I2O4LtHaL4v90bZU
   tWljNEmixtLHGASThmEsmNrR9rflOnaEQ6HDUsP8943MBtljA6SNRSzvg
   I71e+SaLS7nLKnlBO8czstJ966gBSQIZ58IPuVqb6lHUrMOZcSqiXHDSe
   /sJnrC4qIlbbkkheXzDK6bNUjpxMSq+DxCH7ZrxbkjK25E8YiqCT1KsGb
   z+TA/rqRpwW6DYN5qkYW5XjGh82hZcUiQWcUE83nMdAEzcID/lJ97iUtm
   +7I06WP2x1xoAgKfIc8IeSIXCUJTmim7faeFSfKYYFebG/vfA3vJUcT4c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="351990653"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="351990653"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 12:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868341529"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 12:48:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 12:48:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 12:48:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 12:48:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 12:48:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0UYJf+EtuWI5W5j2bmIeQHKmvgxBjk9tHANRXHWdNIZ0KegZgkxOmlAvmEsIrVYczJuhgGVqN08Ac8V+FcrzHtj3jB3CiT2jxPBjXT0VWpgZItF1tuAIL5KkGHxT3SfoND2uiEWoFPuwtgKryu/N3njgW8W1Ev6csS6eoEkbijcOVIzTF4BVNZg57PKyxkok2sXDwsBoTCFbbZ/I70IfqP453hCeFkX3baWRdCZU2UNArLjFbOrvw/JRaHiDQwqbNW2JHLRpxBmPqLXie6XykJsLX2u8wBvbzIT9eLg72TO0+clZw9rFeduBsScBNsNbz+h/V3kiX9hwaPwlDGaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF8qVLifPaYf+44MLrvn7WcqCFhFIAbA9hbCVk1zCsg=;
 b=KQBRYBHfLeHgSOtjDuim0CPdHRgL9Z1fg2Nx3uSdol0tcXrymYiS8cwldRDtnEEwi87pa/zr0q21u6CdkynL3sBdBDUlKElKtNs5h+QDWSAdPsulUKP9zxDZQPsZ0KpPcghsaq7rRqq5Ez/ltNnC9d7beZqNyK8OrpuiAHOrSGPau+tcfk2Dquhr17FrSWFOKM6k6X/pyfPyK3R9hFzPD54NlZyHwvMiVZqDMCwdcqXHkqeyb0GUVPS+MLI1d78qVzHFOp1tCyiBQ9QMDXezhD8slKk8JCuIhfnMk0hbeMQVC5MS2WQSlMZ8ECiuZ5SUaDg+P+UAqtivBj9DPo7NFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MN0PR11MB6035.namprd11.prod.outlook.com (2603:10b6:208:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 19:48:19 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 19:48:18 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCAAA2wkIAAMNUAgAA4eDA=
Date: Fri, 21 Jul 2023 19:48:18 +0000
Message-ID: <DM6PR11MB46571D843FB903AC050E2F129B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLpzwMQrqp7mIMFF@nanopsycho>
 <DM6PR11MB46579CC7E6D314BFDE47E4EE9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLqoMhxHq3m4dp1u@nanopsycho>
In-Reply-To: <ZLqoMhxHq3m4dp1u@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MN0PR11MB6035:EE_
x-ms-office365-filtering-correlation-id: 962f0633-bf87-405d-05ca-08db8a236e71
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEKnpCH90mbS/mKmSU1LZKrjqn/mqDZBhVpmsOojJcppvCt6pN0EiyA73HIsv9udcVqi8unQd/OyM75kRDCJiPjPXSTQMRGw6VxP06tAAcIHkSUxQlzxzP8UWabZIrriz5hqg6wIaVMc/45MCsuaIJo5xY2gzj4StmcV4yZGr9jYqVhxVjMPBU4tqXgOzX7PgTEOgnvy9E46XeiwAfE1/MfxKbp4RLYsfptkBUIRR3qA+kamxcYjcMQVqA+QXS8m3q8MzYJTbaX0Kh0gZwNIw7XyZBqYg7k8+ZYUhhJTEAgRDHMFHdHxzluZGhtLmc/SfiiQEhVmJm4xL72HsiFQfK8XmdAhZpp37z5XoYeQjyS+PJtUoQtnEZPbuNHaTSGP48U7FGbCY4QVBMq/QguoAj/koqhHh/e2r9rOqoF4OWyX4KNPLlYif6VBzqME4bOK8Tn4y/Q1HTsHDUJULhR/oluGbtpEOxIM6eUrLqKSQvqDeZM3qtWpdd4sOep2U8D2N+GJnGklKpmBZAXmmMWZ96nuPkaeH6bXcqX6BfN0Y7uJxubofp/ZXA/ycTeWXAM5xo9ldYharsBPlXzpd5zgFVvLsWBYj32aiAC42J7cD97HYi4BiI2Y7iI6TEOBltlz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(76116006)(2906002)(66556008)(66946007)(66476007)(66446008)(64756008)(6916009)(4326008)(71200400001)(33656002)(86362001)(7696005)(83380400001)(54906003)(478600001)(186003)(9686003)(82960400001)(122000001)(38100700002)(6506007)(38070700005)(26005)(55016003)(30864003)(8676002)(5660300002)(8936002)(52536014)(41300700001)(316002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lib8MKLXqVVh/FoX30SMzy87AnzrMxJaROVq9J4SZzoJOeXmxAbGqv2Tvx3i?=
 =?us-ascii?Q?kzeJ3lAN7WKsMl7a91r+hW3fR95Hmpk3Z7i2OArvane0Dj4mlvlNiu7W0NIc?=
 =?us-ascii?Q?8JauhlkG6dP9UCcscf11j78nE1HK8ACRbV9D9sEzO91QPtSFSBo4Xt8FHn+b?=
 =?us-ascii?Q?AimiHJPBgV+rEKme+esEPJ2nPvyRYje4ypI9qKogsO2ZfNN1ZsAE863nwYSy?=
 =?us-ascii?Q?M/aOnZPmzbsadk3GFGp87LruNjOjctB2jk8y1l7IUVd55M1iRA3gE3mbAIVr?=
 =?us-ascii?Q?zd6aM1E5k/4hDjBlpAtW9evRvJuQwuANF1StsdyI8rnNR3a8nkzmLrA5vGWJ?=
 =?us-ascii?Q?MqQ0PEBYCVvkHa04cr+5fETbPh22RFcRoHg3X4iEhT/BT/w9PNG5o7qwRzuc?=
 =?us-ascii?Q?xyTNi0I+UYpFJNWy+gXpbSQ7FqGkwirdHbv6PndLk5AliFxhZf8+C+/0MS1h?=
 =?us-ascii?Q?YuMiWVYKVvZzdmxQuerGDIh35LEnSpb7SXk0LAvXoQgHcrpA9b+83A1Z5fZH?=
 =?us-ascii?Q?H2UtqQdqy3j9dRRMTqIIQu30uQD15G5Wdy8qS62MaZMPQc2Q8iW+SfmRryYK?=
 =?us-ascii?Q?VzMM3qbo9Qe2M5/zsDrlMvpi2LG7uaK6PgXCpziw7B0emRMw1xPnJBtKaRZI?=
 =?us-ascii?Q?gXUH/cI0QLah39xBbpKW0K8lRrQlhL61rNtCwReBtS6vf/iQBREh/BZCFo1R?=
 =?us-ascii?Q?8fElNaeivJFWFXUx2+R4T75RxaawLlEai1GhqIKEz1hB8ARNsoLtl8T6Z/43?=
 =?us-ascii?Q?15mC/b4GkA1dOjFnYz8ga1yPHHJqgxfgSdd5eXA65QpHm6jH4P13F1pYEyQ4?=
 =?us-ascii?Q?+RYc3b1d+ynlhMfPS8BLREcuWjoh54SiaEMVKV0mdca3kMcXBxdkqOhTcSdL?=
 =?us-ascii?Q?lMQuRpg2kGa5ScMriCSxB5jFSjGdXHyRzVuIsULeq3Z7tYZcUnZK1TJvRyRN?=
 =?us-ascii?Q?5Z/waWdQJ0UWd5hWN4l1OTeGxQy/NRrtF4BeIpCJYdYqrLwHd9bjpu/1LAdj?=
 =?us-ascii?Q?QWR2aZZvF4uy+zeZgLNKobm5YY+5QoO36lmJz9mB0YBRFbFTTcNQE8r1ZZMS?=
 =?us-ascii?Q?RfWybHxItn0nQXyxCefDDlVT2haUPotklQmQLYZrp9vBfApTVNJqR2y3/s7K?=
 =?us-ascii?Q?voy7YEWA1Zvld7W1nlmLoUtRFQbvej3uHONpafidC+Mb5zTrx+F2cyvmxYrQ?=
 =?us-ascii?Q?BTE21wW5R2AmnG5C+s2pjF6kR5KWj+HS1YQdiSK/qVULhK+OJYU73s2eqVOE?=
 =?us-ascii?Q?onkttjrKA5t1vorFTPi7M6dxd9PCq97gq0mK1e5aX3/5dvO8tAHRO75nuCX7?=
 =?us-ascii?Q?PCnwWbAld8HpetObdfFE91oYqboVRKrteUG8cV7yZMWd2v4ET0zJEBzjJw+3?=
 =?us-ascii?Q?rEopE1vrcniAAtxSZ9gKbnxF6gIV0EMfiPyCd19+O1T78NVwpvCc9FpME2g4?=
 =?us-ascii?Q?M2NtVvykgcDO1jrE1I6WkJkNGapN+LvSw3BPNz1S5O6NiNjaTCoe5UFOreAi?=
 =?us-ascii?Q?xohRnhUIW/8Rb7iOpIg7CRIrojDVBMlj1Ow5sLBVTUFYq36l2AALmvjmfxCw?=
 =?us-ascii?Q?dHcuaGgxiZEHc13VCsxwY1jfo/5e+YrV59d3ILh8Fq3yrrVIXstBqNETG9lq?=
 =?us-ascii?Q?GQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 962f0633-bf87-405d-05ca-08db8a236e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 19:48:18.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viwYBWYzRrYEncqW81re7fiRCNxL3S2LNo35QlbrkzZu4zu7jiQIYOCZ+jsic+dYa/J9Ev3x2M3qBhxMtBf67m4OqO86IyCSbyaNhGhQH0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, July 21, 2023 5:46 PM
>
>Fri, Jul 21, 2023 at 03:36:17PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, July 21, 2023 2:02 PM
>>>
>>>Fri, Jul 21, 2023 at 01:17:59PM CEST, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Friday, July 21, 2023 9:33 AM
>>>>>
>>>>>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>>>>>
>>>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev
>>>>>>>wrote:
>>>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>>
>>>>>>>[...]
>>>>>>>
>>>>>>>
>>>>>>>>+/**
>>>>>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>>>>>+ * @hw: board private hw structure
>>>>>>>>+ * @pin: pointer to a pin
>>>>>>>>+ * @pin_type: type of pin being enabled
>>>>>>>>+ * @extack: error reporting
>>>>>>>>+ *
>>>>>>>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>>>>>>>+ *
>>>>>>>>+ * Context: Called under pf->dplls.lock
>>>>>>>>+ * Return:
>>>>>>>>+ * * 0 - OK
>>>>>>>>+ * * negative - error
>>>>>>>>+ */
>>>>>>>>+static int
>>>>>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>>>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>>>>>+		    struct netlink_ext_ack *extack)
>>>>>>>>+{
>>>>>>>>+	u8 flags =3D 0;
>>>>>>>>+	int ret;
>>>>>>>>+
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>I don't follow. Howcome you don't check if the mode is freerun here =
or
>>>>>>>not? Is it valid to enable a pin when freerun mode? What happens?
>>>>>>>
>>>>>>
>>>>>>Because you are probably still thinking the modes are somehow connect=
ed
>>>>>>to the state of the pin, but it is the other way around.
>>>>>>The dpll device mode is a state of DPLL before pins are even consider=
ed.
>>>>>>If the dpll is in mode FREERUN, it shall not try to synchronize or
>>>>>>monitor
>>>>>>any of the pins.
>>>>>>
>>>>>>>Also, I am probably slow, but I still don't see anywhere in this
>>>>>>>patchset any description about why we need the freerun mode. What is
>>>>>>>diffrerent between:
>>>>>>>1) freerun mode
>>>>>>>2) automatic mode & all pins disabled?
>>>>>>
>>>>>>The difference:
>>>>>>Case I:
>>>>>>1. set dpll to FREERUN and configure the source as if it would be in
>>>>>>AUTOMATIC
>>>>>>2. switch to AUTOMATIC
>>>>>>3. connecting to the valid source takes ~50 seconds
>>>>>>
>>>>>>Case II:
>>>>>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>>>>>2. switch one valid source to SELECTABLE
>>>>>>3. connecting to the valid source takes ~10 seconds
>>>>>>
>>>>>>Basically in AUTOMATIC mode the sources are still monitored even when
>>>>>>they
>>>>>>are not in SELECTABLE state, while in FREERUN there is no such
>>>>>>monitoring,
>>>>>>so in the end process of synchronizing with the source takes much
>>>>>>longer as
>>>>>>dpll need to start the process from scratch.
>>>>>
>>>>>I believe this is implementation detail of your HW. How you do it is u=
p
>>>>>to you. User does not have any visibility to this behaviour, therefore
>>>>>makes no sense to expose UAPI that is considering it. Please drop it a=
t
>>>>>least for the initial patchset version. If you really need it later on
>>>>>(which I honestly doubt), you can send it as a follow-up patchset.
>>>>>
>>>>
>>>>And we will have the same discussion later.. But implementation is alre=
ady
>>>>there.
>>>
>>>Yeah, it wouldn't block the initial submission. I would like to see this
>>>merged, so anything which is blocking us and is totally optional (as
>>>this freerun mode) is better to be dropped.
>>>
>>
>>It is not blocking anything. Most of it was defined and available for
>>long time already. Only ice implementing set_mode is a new part.
>>No clue what is the problem you are implying here.
>
>Problem is that I believe you freerun mode should not exist. I believe
>it is wrong.
>
>
>>
>>>
>>>>As said in our previous discussion, without mode_set there is no point =
to
>>>>have
>>>>command DEVICE_SET at all, and there you said that you are ok with havi=
ng
>>>>the
>>>>command as a placeholder, which doesn't make sense, since it is not use=
d.
>>>
>>>I don't see any problem in having enum value reserved. But it does not
>>>need to be there at all. You can add it to the end of the list when
>>>needed. No problem. This is not an argument.
>>>
>>
>>The argument is that I already implemented and tested, and have the need
>>for the
>>existence to set_mode to configure DPLL, which is there to switch the mod=
e
>>between AUTOMATIC and FREERUN.
>>
>>>
>>>>
>>>>Also this is not HW implementation detail but a synchronizer chip featu=
re,
>>>>once dpll is in FREERUN mode, the measurements like phase offset betwee=
n
>>>>the
>>>>input and dpll's output won't be available.
>>>>
>>>>For the user there is a difference..
>>>>Enabling the FREERUN mode is a reset button on the dpll's state machine=
,
>>>>where disconnecting sources is not, as they are still used, monitored a=
nd
>>>>measured.
>>>
>>>So it is not a mode! Mode is either "automatic" or "manual". Then we
>>>have a state to indicate the state of the state machine (unlocked, locke=
d,
>>>holdover, holdover-acq). So what you seek is a way for the user to
>>>expliticly set the state to "unlocked" and reset of the state machine.
>>>
>>>Please don't mix config and state. I think we untangled this in the past
>>>:/
>>
>>I don't mix anything, this is the way dpll works, which means mode of dpl=
l.
>
>You do. You want to force-change the state yet you mangle the mode in.
>The fact that some specific dpll implemented it as mode does not mean it
>has to be exposed like that to user. We have to find the right
>abstraction.
>

Just to make it clear:

AUTOMATIC:
- inputs monitored, validated, phase measurements available
- possible states: unlocked, locked, locked-ho-acq, holdover

FREERUN:
- inputs not monitored, not validated, no phase measurements available
- possible states: unlocked

>
>>
>>>
>>>Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cmd
>>>to hit this button.
>>>
>>
>>As already said there are measurement in place in AUTOMATIC, there are no
>>such
>>thing in FREERUN. Going into FREERUN resets the state machine of dpll
>>which
>>is a side effect of going to FREERUN.
>>
>>>
>>>
>>>>So probably most important fact that you are missing here: assuming the
>>>>user
>>>>disconnects the pin that dpll was locked with, our dpll doesn't go into
>>>>UNLOCKED
>>>>state but into HOLDOVER.
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>>>>>>>needs to be documented, please.
>>>>>>>
>>>>>>
>>>>>>Sure will add the description of FREERUN to the docs.
>>>>>
>>>>>No, please drop it from this patchset. I have no clue why you readded
>>>>>it in the first place in the last patchset version.
>>>>>
>>>>
>>>>mode_set was there from the very beginning.. now implemented in ice
>>>>driver
>>>>as it should.
>>>
>>>I don't understand the fixation on a callback to be implemented. Just
>>>remove it. It can be easily added when needed. No problem.
>>>
>>
>>Well, I don't understand the fixation about removing it.
>
>It is needed only for your freerun mode, which is questionable. This
>discussion it not about mode_set. I don't care about it, if it is
>needed, should be there, if not, so be it.
>
>As you say, you need existance of your freerun mode to justify existence
>of mode_set(). Could you please, please drop both for now so we can
>move on? I'm tired of this. Thanks!
>

Reason for dpll subsystem is to control the dpll. So the mode_set and
different modes are there for the same reason.
Explained this multiple times already, we need a way to let the user switch
to FREERUN, so all the activities on dpll are stopped.

>
>>set_mode was there for a long time, now the callback is properly implemen=
ted
>>and you are trying to imply that this is not needed.
>>We require it, as there is no other other way to stop AUTOMATIC mode dpll
>>to do its work.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>Another question, I asked the last time as well, but was not heard:
>>>>>>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>>>>>>connected with a single DPLL pin:
>>>>>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>>>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>>>>>
>>>>>>>You have a SyncE daemon running on top eth0 and eth1.
>>>>>>>
>>>>>>>Could you please describe following 2 flows?
>>>>>>>
>>>>>>>1) SyncE daemon selects eth0 as a source of clock
>>>>>>>2) SyncE daemon selects eth1 as a source of clock
>>>>>>>
>>>>>>>
>>>>>>>For mlx5 it goes like:
>>>>>>>
>>>>>>>DPLL device mode is MANUAL.
>>>>>>>1)
>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>>>>>    -> pin_id: 10
>>>>>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>>>>>>>    -> device_id: 2
>>>>>>
>>>>>>Not sure if it needs to obtain the dpll id in this step, but it doesn=
't
>>>>>>relate to the dpll interface..
>>>>>
>>>>>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as inpu=
t.
>>>>>You need to set the state on a pin on a certain DPLL device.
>>>>>
>>>>
>>>>The thing is pin can be connected to multiple dplls and SyncE daemon sh=
all
>>>>know already something about the dpll it is managing.
>>>>Not saying it is not needed, I am saying this is not a moment the SyncE
>>>>daemon
>>>>learns it.
>>>
>>>Moment or not, it is needed for the cmd, that is why I have it there.
>>>
>>>
>>>>But let's park it, as this is not really relevant.
>>>
>>>Agreed.
>>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
=3D
>>>>>>>CONNECTED
>>>>>>>
>>>>>>>2)
>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>>>>>    -> pin_id: 11
>>>>>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>>>>>>>    -> device_id: 2
>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =
=3D
>>>>>>>CONNECTED
>>>>>>> (that will in HW disconnect previously connected pin 10, there will=
 be
>>>>>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>>>>>
>>>>>>
>>>>>>This flow is similar for ice, but there are some differences, althoug=
h
>>>>>>they come from the fact, the ice is using AUTOMATIC mode and recovere=
d
>>>>>>clock pins which are not directly connected to a dpll (connected thro=
ugh
>>>>>>the MUX pin).
>>>>>>
>>>>>>1)
>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>>>pin_id: 13
>>>>>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id:=
 2
>>>>>>   (in case of dpll_id is needed, would be find in this response also=
)
>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) t=
o
>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while
>>>>>>all the
>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>
>>>>>Yeah, for this you need pin_id 2 and device_id. Because you are settin=
g
>>>>>state on DPLL device.
>>>>>
>>>>>
>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED
>>>>>>with
>>>>>>   parent pin (pin-id:2)
>>>>>
>>>>>For this you need pin_id and pin_parent_id because you set the state o=
n
>>>>>a parent pin.
>>>>>
>>>>>
>>>>>Yeah, this is exactly why I initially was in favour of hiding all the
>>>>>muxes and magic around it hidden from the user. Now every userspace ap=
p
>>>>>working with this has to implement a logic of tracking pin and the mux
>>>>>parents (possibly multiple levels) and configure everything. But it
>>>>>just
>>>>>need a simple thing: "select this pin as a source" :/
>>>>>
>>>>>
>>>>>Jakub, isn't this sort of unnecessary HW-details complexicity exposure
>>>>>in UAPI you were against in the past? Am I missing something?
>>>>>
>>>>
>>>>Multiple level of muxes possibly could be hidden in the driver, but the
>>>>fact
>>>>they exist is not possible to be hidden from the user if the DPLL is in
>>>>AUTOMATIC mode.
>>>>For MANUAL mode dpll the muxes could be also hidden.
>>>>Yeah, we have in ice most complicated scenario of AUTOMATIC mode + MUXE=
D
>>>>type
>>>>pin.
>>>
>>>Sure, but does user care how complicated things are inside? The syncE
>>>daemon just cares for: "select netdev x as a source". However it is done
>>>internally is irrelevant to him. With the existing UAPI, the syncE
>>>daemon needs to learn individual device dpll/pin/mux topology and
>>>work with it.
>>>
>>
>>This is dpll subsystem not SyncE one.
>
>SyncE is very legit use case of the UAPI. I would say perhaps the most
>important.
>

But it is still a dpll subsystem.

Thank you!
Arkadiusz

>
>>
>>>Do we need a dpll library to do this magic?
>>>
>>
>>IMHO rather SyncE library :)
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>2) (basically the same, only eth1 would get different pin_id.)
>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>>>pin_id: 14
>>>>>>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) t=
o
>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while
>>>>>>all the
>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED
>>>>>>with
>>>>>>   parent pin (pin-id:2)
>>>>>>
>>>>>>Where step c) is required due to AUTOMATIC mode, and step d) required
>>>>>>due to
>>>>>>phy recovery clock pin being connected through the MUX type pin.
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>Thanks!
>>>>>>>
>>>>>>>
>>>>>>>[...]
>>>>

