Return-Path: <netdev+bounces-20881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F9761AE8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253F61C20EC0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC704200C5;
	Tue, 25 Jul 2023 14:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD48BFF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:04:44 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D300106;
	Tue, 25 Jul 2023 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690293882; x=1721829882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sEHFvVe7XYYCGY6n7AtK+Dbf8TO5wHmGbK4JLItUm+g=;
  b=NHzLF5O+ufGdJ26uuYHjkqlyQQPZCmWyBvAARVFmXyUe1fKRQiUftLL0
   MT9Gt2N7z5gSRjf928MYbl+RbuGI6FB/Y39fhKxVk7sMqCmC/xKj72nKP
   p7eFjBKWB2kWcNZ69Xu8k6YpayEY+Pr2E5JUrs3BzcUu60DRvv0SQinmR
   7IAIRemgJC0tq7TllWsID/TANljzdDmTXIPKwquVX8nP0Ei7DuudACveJ
   Jy8ecQ9mfBL4kJ0P0ia/T/DaIV+GklgfpoY4hAOK6dEQuVvAjTrzIwb6+
   bVK+KAJPUBQ9YsgiK6zSUYpYDbgOHypsGNQeCw6P55NgT1Dh50icO0I1q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="365192932"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="365192932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="839875641"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="839875641"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2023 07:01:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 07:01:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 07:01:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 07:01:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=golxgQMs1CT9/dfedDuAeRuAT2xh606LUTV03hFSMuIfVJLTe4UFniZFbgZuUbrsKY2zb11SEncbcG2WDfrpjiwtSuSO8qdCdEFcMRpF86Sa61wzWxmBxEojYKEe0rmh44pVxrdhMhpURu1MN3tysufr5SOxzX2C3RMzn1mY2l9gf+BZa0IpjPmCSu2m7SkTgH0juFd/GT3w/T+Ci3PuMvVCT2R9xcmlR0UGwfbkW0iBBO4lg+elvXsrBfrO1+koxDCOh85+Xmu/PdoVppXepyOEDdNE8ruOxTTK+MJR3UWVwDskML+UB3nOsWb09QWgthpcSPS3I1/SkKPWKrWDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HVGxq1qLQc/CjnbXj9xiNuM3INCDExs/hfR8YjVkT0=;
 b=Upl+YSkOi+TcOaPPJzv2H7JiR1ntHDVgWdR5dBZdHgml72wOEqvAYgkjcaiBw6TcGQQbSFz4flkuzWa01FgTLfsDO4AdBC2yJQ65g5vL8Jnm3u/rNVZbFZPeWYKJYbRbp36cWmqG5KSj3hp8nFXy/RqhJCzcyl6AwiZd/8YCsWk6e8/OmQKBneM3xPbLwXRVnU6I4LWofAjCRoHFfIsmOAAAOyKdr4xQ3RSEabhswokbkONTHL9YPEmEIRmpfv/u66w7S/KZ/6dWHgWJIhQ3RD8SHC4DWV7YCV5ndzEgJi+Y9OMaywGT+NqWh0jKPKE2H5PG2TSfU3T9kjAV8s9OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 14:01:33 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 14:01:33 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCAAA2wkIAAMNUAgAA4eDCAAMCPAIADo+2ggAErQoCAACfLUA==
Date: Tue, 25 Jul 2023 14:01:33 +0000
Message-ID: <DM6PR11MB465734F6AD226A39DE8574419B03A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLpzwMQrqp7mIMFF@nanopsycho>
 <DM6PR11MB46579CC7E6D314BFDE47E4EE9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLqoMhxHq3m4dp1u@nanopsycho>
 <DM6PR11MB46571D843FB903AC050E2F129B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLt5GPRls7UL4zGx@nanopsycho>
 <DM6PR11MB465713389A234771BD29DF149B02A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZL+B48Om/cf61/Vq@nanopsycho>
In-Reply-To: <ZL+B48Om/cf61/Vq@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB7302:EE_
x-ms-office365-filtering-correlation-id: 9999afab-e35e-48d1-76ae-08db8d17a773
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/ZpDJh9E12pm4YkWJtx8W0iVGWrvOcSGRJp2UPYQsIQnOTuoSxDe8Xai0+uy3bawMTAm2LCYFC/IG9LAGl7GOupmgV+XhkoyYJqYOl7H1PXUiJEgBFF2j10e/eq4S2POBLQ8vq3e68yZS7q+SXeFoT5bYg0QKKsiYLO7r1or7MZ1wYtyW6Ho9WcGS5rnvL269Uxt1bsYNpBYa1wcZ+vZXnmQPI18NnfR9AfL6qqPyOhC2hvTtHGEJv+SbCFXK4JXyNBnjGWE7ziwg1Kz4fSl70ueAEIA8UcchIC8TTrBdX0hnKewCbljwKK3QRMckzUQ1fH58GONtKge8J2XKYK3fSNCChazrVQyXal8ggRe9Ae08xFw8BWRtaOyi159Ws8NXgEhMY/31fPQx2zgVqZL7w3OqTObNT1BbGif/87k31MkEjBY91d453t/aVviYWX7Ui73r53R21qVr3O1UWro4Ci3+CH1V4dZJCGNYXMN1gZ9It8lmmxjd2xtTSnY7cVJJGaq9lfe+mUwqXDSneGiPlmRq4NeJjhMLAo4bTTxvJ8LdJsxr0Eo+qlzmTnBE9BeVWuzTzgPvbap3ZEsvYhJhCPWRMAMr9HL1RAdCy+gwlXQyFWuhMn+bxNkj+HilYr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(7696005)(9686003)(478600001)(54906003)(71200400001)(186003)(6506007)(30864003)(2906002)(41300700001)(66476007)(66446008)(64756008)(4326008)(6916009)(76116006)(5660300002)(52536014)(7416002)(8676002)(8936002)(316002)(66556008)(66946007)(122000001)(38100700002)(82960400001)(33656002)(38070700005)(86362001)(83380400001)(55016003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z34yjie47SI+4cqGWsMSNhu4HYSIJmcBymeEEgUIruD09ltY6VZ4VaCRY7y3?=
 =?us-ascii?Q?p2qCaUn6QHALOdG4zFC3LF8byPL2+/eKYVyzastEIaLXXWfLpmKKr0205plS?=
 =?us-ascii?Q?pbsSlUlnltEcwzbRwabcjXeKllSLwI1SamuBRxJlgFEXGvwWL7cSfLTjeqpi?=
 =?us-ascii?Q?6saO8Go24UPdTUfzM6h5zmn84DLgHmz5BYyGjp0EZKX0HxQaaTMzPwfwvfvd?=
 =?us-ascii?Q?F8kV3Zs9W3SIawVs19wNtzxNUhwBNAoHlh7rTCuj+RhdXI6d89HJZmQOAMU1?=
 =?us-ascii?Q?YNVqIs8JLEiYbmf2TdOiRGdEe72P+2PEMq/JmYIUY7aRbkL+bXm+POf3EVJ+?=
 =?us-ascii?Q?3b53TbgZU34uJ3ec6GtWAXDcfu5F1MYteLxiRddBL7+P/n4WYxL00xY5sXKF?=
 =?us-ascii?Q?geG3cdpihe5afdm5uKt1New9axPCLcUNNIH+QJ8d4Fca6jiYOMWTEqHdppVf?=
 =?us-ascii?Q?GERMQRjJrXeRw1RtJ3A9D7MF6rgVWhjjP0PbEVWOj92lCOEY1sPo4zRdP3nW?=
 =?us-ascii?Q?IxW1u1d6lRTQFQhO8jWqJhYcDp9hfW4yC+XJJ6HYFxFBCopIWZtKjjzjm8pI?=
 =?us-ascii?Q?HGYvGa9YWVqkqMLj/hJf8yFVx10GdqpYoJoH/PU1bi53k6gxIso78/LYTKG+?=
 =?us-ascii?Q?qbejxttAi5vupi9vjB2BfaLFkaBmIyFf0cieptW8k1NsIMKQfup/aXOZ3rAx?=
 =?us-ascii?Q?nyJNFOUlKvCrRqnZ/MFqPVN2WkCaBusksQlrghualyVlXELb69JmZGGSbow/?=
 =?us-ascii?Q?hPjXzz/1PUTp68bx35DfCoady2WtIkd6sduD+p+jyzoompmiXCmzs5p2xijl?=
 =?us-ascii?Q?ZhS00IdsSuhoFyzhud1zbnME2Bf194YR7iwMEdQ6TqDRRaaYsW0jdp1kFLKB?=
 =?us-ascii?Q?ZdsEw1sR1FrQO0NR0lrG4gldSDQGH3g4wAF9FqZKlcr4w+L6Qxx9xzi9hyla?=
 =?us-ascii?Q?+WKg4z+LKdt8TTunT0oh48M8pVFXTgfsx8+CRjxQTCPire3cynPKSgZCZBdT?=
 =?us-ascii?Q?VDy4h4cgARRKik5U962C7tlFfPtNHtt9nFCJnO8albRAJZU05pZnB0a5gM5B?=
 =?us-ascii?Q?2BiZhuWUEQU2k1yEF8ekZUHXQcmfjneV//UTm8ZcTSIYdsLasCux0wi7SmIZ?=
 =?us-ascii?Q?W5NBVG99p2Msj1pcZ9HrmzMmLFthNKVt/RxOis3YPEciRs/w52wL6vb6yOUX?=
 =?us-ascii?Q?sDr+iWV9n/2ZlV7fd0daNlRgznazYSBzUzat6QL88aPvg24QC8S4cZrfE89n?=
 =?us-ascii?Q?79af99XSZfTc8MJqlkgU0M4Uap8QILGgpKENl9z/DYR1AsdSg2rQIqts2W5g?=
 =?us-ascii?Q?cxpNYctqk1SsE8eLTnGQ2AXooCTWaFokAaphTHz9/KigoAlSybOuZQnlpu6g?=
 =?us-ascii?Q?2NYD5JPVr5kacX++jB0sjN21V5RgnDJCRAX5s7anbHvgEMGFfYcYzmMUyegg?=
 =?us-ascii?Q?tJ4XZQ9Esy+4/92FlymhCq48ZcWmPriGBIce6BxlXRjq7LEDXIelMDu50+Ak?=
 =?us-ascii?Q?a3uDI6rqsae0opMDuyslJVShhbS2UGSvj/B1HM9fpXCbUhffYVp+mcO4UZQw?=
 =?us-ascii?Q?SLqrKYXb9mAQrshPMaZHueydq60lWSsRqHZtUvvlWw3OauTHL6xU0CpwBoKV?=
 =?us-ascii?Q?8rvjfD58OEaRQUKdj7erF9uACiERHPJNrpcLhHw+eWev0FA/BaXi4kX9qukt?=
 =?us-ascii?Q?8mSxDA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9999afab-e35e-48d1-76ae-08db8d17a773
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 14:01:33.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tF+QVLq0YzoM/hXk9q0bZuQXbb2fwiw8cGA4U9wXuPLV2/mR2DhZhC0fDAIOcB6Q40H3H0XNcAdQQW058DGIy5FbETB3gOXlZaFH17ULcJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, July 25, 2023 10:04 AM
>
>Mon, Jul 24, 2023 at 05:03:55PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Saturday, July 22, 2023 8:37 AM
>>>
>>>Fri, Jul 21, 2023 at 09:48:18PM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Friday, July 21, 2023 5:46 PM
>>>>>
>>>>>Fri, Jul 21, 2023 at 03:36:17PM CEST, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Friday, July 21, 2023 2:02 PM
>>>>>>>
>>>>>>>Fri, Jul 21, 2023 at 01:17:59PM CEST, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>Sent: Friday, July 21, 2023 9:33 AM
>>>>>>>>>
>>>>>>>>>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.c=
om
>>>>>>>>>wrote:
>>>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>>>>>>>>>
>>>>>>>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev
>>>>>>>>>>>wrote:
>>>>>>>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>>>>>>>
>>>>>>>>>>>[...]
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>+/**
>>>>>>>>>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>>>>>>>>>+ * @hw: board private hw structure
>>>>>>>>>>>>+ * @pin: pointer to a pin
>>>>>>>>>>>>+ * @pin_type: type of pin being enabled
>>>>>>>>>>>>+ * @extack: error reporting
>>>>>>>>>>>>+ *
>>>>>>>>>>>>+ * Enable a pin on both dplls. Store current state in pin-flag=
s.
>>>>>>>>>>>>+ *
>>>>>>>>>>>>+ * Context: Called under pf->dplls.lock
>>>>>>>>>>>>+ * Return:
>>>>>>>>>>>>+ * * 0 - OK
>>>>>>>>>>>>+ * * negative - error
>>>>>>>>>>>>+ */
>>>>>>>>>>>>+static int
>>>>>>>>>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pi=
n,
>>>>>>>>>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>>>>>>>>>+		    struct netlink_ext_ack *extack)
>>>>>>>>>>>>+{
>>>>>>>>>>>>+	u8 flags =3D 0;
>>>>>>>>>>>>+	int ret;
>>>>>>>>>>>>+
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>I don't follow. Howcome you don't check if the mode is freerun
>>>>>>>>>>>here or
>>>>>>>>>>>not? Is it valid to enable a pin when freerun mode? What happens=
?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Because you are probably still thinking the modes are somehow
>>>>>>>>>>connected
>>>>>>>>>>to the state of the pin, but it is the other way around.
>>>>>>>>>>The dpll device mode is a state of DPLL before pins are even
>>>>>>>>>>considered.
>>>>>>>>>>If the dpll is in mode FREERUN, it shall not try to synchronize o=
r
>>>>>>>>>>monitor
>>>>>>>>>>any of the pins.
>>>>>>>>>>
>>>>>>>>>>>Also, I am probably slow, but I still don't see anywhere in this
>>>>>>>>>>>patchset any description about why we need the freerun mode. Wha=
t
>>>>>>>>>>>is
>>>>>>>>>>>diffrerent between:
>>>>>>>>>>>1) freerun mode
>>>>>>>>>>>2) automatic mode & all pins disabled?
>>>>>>>>>>
>>>>>>>>>>The difference:
>>>>>>>>>>Case I:
>>>>>>>>>>1. set dpll to FREERUN and configure the source as if it would be=
 in
>>>>>>>>>>AUTOMATIC
>>>>>>>>>>2. switch to AUTOMATIC
>>>>>>>>>>3. connecting to the valid source takes ~50 seconds
>>>>>>>>>>
>>>>>>>>>>Case II:
>>>>>>>>>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>>>>>>>>>2. switch one valid source to SELECTABLE
>>>>>>>>>>3. connecting to the valid source takes ~10 seconds
>>>>>>>>>>
>>>>>>>>>>Basically in AUTOMATIC mode the sources are still monitored even =
when
>>>>>>>>>>they
>>>>>>>>>>are not in SELECTABLE state, while in FREERUN there is no such
>>>>>>>>>>monitoring,
>>>>>>>>>>so in the end process of synchronizing with the source takes much
>>>>>>>>>>longer as
>>>>>>>>>>dpll need to start the process from scratch.
>>>>>>>>>
>>>>>>>>>I believe this is implementation detail of your HW. How you do it =
is up
>>>>>>>>>to you. User does not have any visibility to this behaviour, there=
fore
>>>>>>>>>makes no sense to expose UAPI that is considering it. Please drop =
it at
>>>>>>>>>least for the initial patchset version. If you really need it late=
r on
>>>>>>>>>(which I honestly doubt), you can send it as a follow-up patchset.
>>>>>>>>>
>>>>>>>>
>>>>>>>>And we will have the same discussion later.. But implementation is
>>>>>>>>already
>>>>>>>>there.
>>>>>>>
>>>>>>>Yeah, it wouldn't block the initial submission. I would like to see =
this
>>>>>>>merged, so anything which is blocking us and is totally optional (as
>>>>>>>this freerun mode) is better to be dropped.
>>>>>>>
>>>>>>
>>>>>>It is not blocking anything. Most of it was defined and available for
>>>>>>long time already. Only ice implementing set_mode is a new part.
>>>>>>No clue what is the problem you are implying here.
>>>>>
>>>>>Problem is that I believe you freerun mode should not exist. I believe
>>>>>it is wrong.
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>As said in our previous discussion, without mode_set there is no
>>>>>>>>point to
>>>>>>>>have
>>>>>>>>command DEVICE_SET at all, and there you said that you are ok with
>>>>>>>>having
>>>>>>>>the
>>>>>>>>command as a placeholder, which doesn't make sense, since it is not
>>>>>>>>used.
>>>>>>>
>>>>>>>I don't see any problem in having enum value reserved. But it does n=
ot
>>>>>>>need to be there at all. You can add it to the end of the list when
>>>>>>>needed. No problem. This is not an argument.
>>>>>>>
>>>>>>
>>>>>>The argument is that I already implemented and tested, and have the n=
eed
>>>>>>for the
>>>>>>existence to set_mode to configure DPLL, which is there to switch the
>>>>>>mode
>>>>>>between AUTOMATIC and FREERUN.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>Also this is not HW implementation detail but a synchronizer chip
>>>>>>>>feature,
>>>>>>>>once dpll is in FREERUN mode, the measurements like phase offset
>>>>>>>>between
>>>>>>>>the
>>>>>>>>input and dpll's output won't be available.
>>>>>>>>
>>>>>>>>For the user there is a difference..
>>>>>>>>Enabling the FREERUN mode is a reset button on the dpll's state
>>>>>>>>machine,
>>>>>>>>where disconnecting sources is not, as they are still used,
>>>>>>>>monitored and
>>>>>>>>measured.
>>>>>>>
>>>>>>>So it is not a mode! Mode is either "automatic" or "manual". Then we
>>>>>>>have a state to indicate the state of the state machine (unlocked,
>>>>>>>locked,
>>>>>>>holdover, holdover-acq). So what you seek is a way for the user to
>>>>>>>expliticly set the state to "unlocked" and reset of the state machin=
e.
>>>>>>>
>>>>>>>Please don't mix config and state. I think we untangled this in the
>>>>>>>past
>>>>>>>:/
>>>>>>
>>>>>>I don't mix anything, this is the way dpll works, which means mode of
>>>>>>dpll.
>>>>>
>>>>>You do. You want to force-change the state yet you mangle the mode in.
>>>>>The fact that some specific dpll implemented it as mode does not mean =
it
>>>>>has to be exposed like that to user. We have to find the right
>>>>>abstraction.
>>>>>
>>>>
>>>>Just to make it clear:
>>>>
>>>>AUTOMATIC:
>>>>- inputs monitored, validated, phase measurements available
>>>>- possible states: unlocked, locked, locked-ho-acq, holdover
>>>>
>>>>FREERUN:
>>>>- inputs not monitored, not validated, no phase measurements available
>>>>- possible states: unlocked
>>>
>>>This is your implementation of DPLL. Others may have it done
>>>differently. But the fact the input is monitored or not, does not make
>>>any difference from user perspective.
>>>
>>>When he has automatic mode and does:
>>>1) disconnect all pins
>>>2) reset state    (however you implement it in the driver is totaly up
>>>		   to the device, you may go to your freerun dpll mode
>>>		   internally and to automatic back, up to you)
>>> -> state will go to unlocked
>>>
>>>The behaviour is exactly the same, without any special mode.
>>
>>In this case there is special reset button, which doesn't exist in
>>reality, actually your suggestion to go into FREERUN and back to AUTOMATI=
C
>>to pretend the some kind of reset has happened, where in reality dpll wen=
t
>>to
>>FREERUN and AUTOMATIC.
>
>There are 3 pin states:
>disconnected
>connected
>selectable
>
>When the last source disconnects, go to your internal freerun.
>When some source gets selectable or connected, go to your internal
>automatic mode.
>

This would make the driver to check if all the sources are disconnected
each time someone disconnects a source. Which in first place is not
efficient, but also dpll design already allows different driver instances t=
o
control separated sources, which in this case would force a driver to imple=
ment
additional communication between the instances just to allow such hidden
FREERUN mode.
Which seems another argument not to do this in the way you are proposing:
inefficient and unnecessarily complicated.

We know that you could also implement FREERUN mode by disconnecting all the
sources, even if HW doesn't support it explicitly.

>From user perspactive, the mode didn't change.
>

The user didn't change the mode, the mode shall not change.
You wrote to do it silently, so user didn't change the mode but it would ha=
ve
changed, and we would have pretended the different working mode of DPLL doe=
sn't
exist.

>From user perepective, this is exacly the behaviour he requested.
>

IMHO this is wrong and comes from the definition of pin state DISCONNECTED,
which is not sharp, for our HW means that the input will not be considered
as valid input, but is not disconnecting anything, as input is still
monitored and measured.
Shall we have additional mode like PIN_STATE_NOT_SELECTABLE? As it is not
possible to actually disconnect a pin..

>
>>For me it seems it seems like unnecessary complication of user's life.
>>The idea of FREERUN mode is to run dpll on its system clock, so all the
>>"external" dpll sources shall be disconnected when dpll is in FREERUN.
>
>Yes, that is when you set all pins to disconnect. no mode change needed.
>

We don't disconnect anything, we used a pin state DISCONNECTED as this seem=
ed
most appropriate.

>
>>Let's assume your HW doesn't have a FREERUN, can't you just create it by
>>disconnecting all the sources?
>
>Yep, that's what we do.
>

No, you were saying that the mode doesn't exist and that your hardware does=
n't
support it. At the same time it can be achieved by manually disconnecting a=
ll
the sources.

>
>>BTW, what chip are you using on mlx5 for this?
>>I don't understand why the user would have to mangle state of all the pin=
s
>>just
>>to stop dpll's work if he could just go into FREERUN and voila. Also what=
 if
>>user doesn't want change the configuration of the pins at all, and he jus=
t
>>want
>>to desynchronize it's dpll for i.e. testing reason.
>
>I tried to explain multiple times. Let the user have clean an abstracted
>api, with clear semantics. Simple as that. Your internal freerun mode is
>just something to abstract out, it is not needed to expose it.
>

Our hardware can support in total 4 modes, and 2 are now supported in ice.
I don't get the idea for abstraction of hardware switches, modes or
capabilities, and having those somehow achievable through different
functionalities.

I think we already discussed this long enough to make a decision..
Though I am not convinced by your arguments, and you are not convinced by m=
ine.

Perhaps someone else could step in and cut the rope, so we could go further
with this?

Thank you!
Arkadiusz


>
>>
>>>
>>>We are talking about UAPI here. It should provide the abstraction, leavi=
ng
>>>the
>>>internal implementation behind the curtain. What is important is:
>>>1) clear configuration knobs
>>>2) the outcome (hw behaviour)
>>>
>>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET =
cmd
>>>>>>>to hit this button.
>>>>>>>
>>>>>>
>>>>>>As already said there are measurement in place in AUTOMATIC, there ar=
e
>>>>>>no
>>>>>>such
>>>>>>thing in FREERUN. Going into FREERUN resets the state machine of dpll
>>>>>>which
>>>>>>is a side effect of going to FREERUN.
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>So probably most important fact that you are missing here: assuming=
 the
>>>>>>>>user
>>>>>>>>disconnects the pin that dpll was locked with, our dpll doesn't go =
into
>>>>>>>>UNLOCKED
>>>>>>>>state but into HOLDOVER.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why?
>>>>>>>>>>>This
>>>>>>>>>>>needs to be documented, please.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Sure will add the description of FREERUN to the docs.
>>>>>>>>>
>>>>>>>>>No, please drop it from this patchset. I have no clue why you
>>>>>>>>>readded
>>>>>>>>>it in the first place in the last patchset version.
>>>>>>>>>
>>>>>>>>
>>>>>>>>mode_set was there from the very beginning.. now implemented in ice
>>>>>>>>driver
>>>>>>>>as it should.
>>>>>>>
>>>>>>>I don't understand the fixation on a callback to be implemented. Jus=
t
>>>>>>>remove it. It can be easily added when needed. No problem.
>>>>>>>
>>>>>>
>>>>>>Well, I don't understand the fixation about removing it.
>>>>>
>>>>>It is needed only for your freerun mode, which is questionable. This
>>>>>discussion it not about mode_set. I don't care about it, if it is
>>>>>needed, should be there, if not, so be it.
>>>>>
>>>>>As you say, you need existance of your freerun mode to justify existen=
ce
>>>>>of mode_set(). Could you please, please drop both for now so we can
>>>>>move on? I'm tired of this. Thanks!
>>>>>
>>>>
>>>>Reason for dpll subsystem is to control the dpll. So the mode_set and
>>>>different modes are there for the same reason.
>>>>Explained this multiple times already, we need a way to let the user sw=
itch
>>>>to FREERUN, so all the activities on dpll are stopped.
>>>>
>>>>>
>>>>>>set_mode was there for a long time, now the callback is properly
>>>>>>implemented
>>>>>>and you are trying to imply that this is not needed.
>>>>>>We require it, as there is no other other way to stop AUTOMATIC mode =
dpll
>>>>>>to do its work.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>Another question, I asked the last time as well, but was not hea=
rd:
>>>>>>>>>>>Consider example where you have 2 netdevices, eth0 and eth1, eac=
h
>>>>>>>>>>>connected with a single DPLL pin:
>>>>>>>>>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>>>>>>>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>>>>>>>>>
>>>>>>>>>>>You have a SyncE daemon running on top eth0 and eth1.
>>>>>>>>>>>
>>>>>>>>>>>Could you please describe following 2 flows?
>>>>>>>>>>>
>>>>>>>>>>>1) SyncE daemon selects eth0 as a source of clock
>>>>>>>>>>>2) SyncE daemon selects eth1 as a source of clock
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>For mlx5 it goes like:
>>>>>>>>>>>
>>>>>>>>>>>DPLL device mode is MANUAL.
>>>>>>>>>>>1)
>>>>>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>>>>>>>>>    -> pin_id: 10
>>>>>>>>>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL devic=
e id
>>>>>>>>>>>    -> device_id: 2
>>>>>>>>>>
>>>>>>>>>>Not sure if it needs to obtain the dpll id in this step, but it
>>>>>>>>>>doesn't
>>>>>>>>>>relate to the dpll interface..
>>>>>>>>>
>>>>>>>>>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as
>>>>>>>>>input.
>>>>>>>>>You need to set the state on a pin on a certain DPLL device.
>>>>>>>>>
>>>>>>>>
>>>>>>>>The thing is pin can be connected to multiple dplls and SyncE daemo=
n
>>>>>>>>shall
>>>>>>>>know already something about the dpll it is managing.
>>>>>>>>Not saying it is not needed, I am saying this is not a moment the
>>>>>>>>SyncE
>>>>>>>>daemon
>>>>>>>>learns it.
>>>>>>>
>>>>>>>Moment or not, it is needed for the cmd, that is why I have it there=
.
>>>>>>>
>>>>>>>
>>>>>>>>But let's park it, as this is not really relevant.
>>>>>>>
>>>>>>>Agreed.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 ->
>>>>>>>>>>>state =3D
>>>>>>>>>>>CONNECTED
>>>>>>>>>>>
>>>>>>>>>>>2)
>>>>>>>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>>>>>>>>>    -> pin_id: 11
>>>>>>>>>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL devic=
e
>>>>>>>>>>>id
>>>>>>>>>>>    -> device_id: 2
>>>>>>>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 ->
>>>>>>>>>>>state =3D
>>>>>>>>>>>CONNECTED
>>>>>>>>>>> (that will in HW disconnect previously connected pin 10, there
>>>>>>>>>>>will be
>>>>>>>>>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>This flow is similar for ice, but there are some differences,
>>>>>>>>>>although
>>>>>>>>>>they come from the fact, the ice is using AUTOMATIC mode and
>>>>>>>>>>recovered
>>>>>>>>>>clock pins which are not directly connected to a dpll (connected
>>>>>>>>>>through
>>>>>>>>>>the MUX pin).
>>>>>>>>>>
>>>>>>>>>>1)
>>>>>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 =
->
>>>>>>>>>>pin_id: 13
>>>>>>>>>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin ->
>>>>>>>>>>pin_id: 2
>>>>>>>>>>   (in case of dpll_id is needed, would be find in this response
>>>>>>>>>>also)
>>>>>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id:
>>>>>>>>>>2) to
>>>>>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0,
>>>>>>>>>>while
>>>>>>>>>>all the
>>>>>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>>>>
>>>>>>>>>Yeah, for this you need pin_id 2 and device_id. Because you are
>>>>>>>>>setting
>>>>>>>>>state on DPLL device.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to
>>>>>>>>>>CONNECTED
>>>>>>>>>>with
>>>>>>>>>>   parent pin (pin-id:2)
>>>>>>>>>
>>>>>>>>>For this you need pin_id and pin_parent_id because you set the
>>>>>>>>>state on
>>>>>>>>>a parent pin.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Yeah, this is exactly why I initially was in favour of hiding all
>>>>>>>>>the
>>>>>>>>>muxes and magic around it hidden from the user. Now every userspac=
e
>>>>>>>>>app
>>>>>>>>>working with this has to implement a logic of tracking pin and the
>>>>>>>>>mux
>>>>>>>>>parents (possibly multiple levels) and configure everything. But i=
t
>>>>>>>>>just
>>>>>>>>>need a simple thing: "select this pin as a source" :/
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>Jakub, isn't this sort of unnecessary HW-details complexicity expo=
sure
>>>>>>>>>in UAPI you were against in the past? Am I missing something?
>>>>>>>>>
>>>>>>>>
>>>>>>>>Multiple level of muxes possibly could be hidden in the driver, but=
 the
>>>>>>>>fact
>>>>>>>>they exist is not possible to be hidden from the user if the DPLL i=
s in
>>>>>>>>AUTOMATIC mode.
>>>>>>>>For MANUAL mode dpll the muxes could be also hidden.
>>>>>>>>Yeah, we have in ice most complicated scenario of AUTOMATIC mode + =
MUXED
>>>>>>>>type
>>>>>>>>pin.
>>>>>>>
>>>>>>>Sure, but does user care how complicated things are inside? The sync=
E
>>>>>>>daemon just cares for: "select netdev x as a source". However it is =
done
>>>>>>>internally is irrelevant to him. With the existing UAPI, the syncE
>>>>>>>daemon needs to learn individual device dpll/pin/mux topology and
>>>>>>>work with it.
>>>>>>>
>>>>>>
>>>>>>This is dpll subsystem not SyncE one.
>>>>>
>>>>>SyncE is very legit use case of the UAPI. I would say perhaps the most
>>>>>important.
>>>>>
>>>>
>>>>But it is still a dpll subsystem.
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>>
>>>>>>>Do we need a dpll library to do this magic?
>>>>>>>
>>>>>>
>>>>>>IMHO rather SyncE library :)
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>Thank you!
>>>>>>>>Arkadiusz
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>2) (basically the same, only eth1 would get different pin_id.)
>>>>>>>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 =
->
>>>>>>>>>>pin_id: 14
>>>>>>>>>>b) SyncE daemon uses PIN_GET to find parent MUX type pin ->
>>>>>>>>>>pin_id: 2
>>>>>>>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id:
>>>>>>>>>>2) to
>>>>>>>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0,
>>>>>>>>>>while
>>>>>>>>>>all the
>>>>>>>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>>>>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to
>>>>>>>>>>CONNECTED
>>>>>>>>>>with
>>>>>>>>>>   parent pin (pin-id:2)
>>>>>>>>>>
>>>>>>>>>>Where step c) is required due to AUTOMATIC mode, and step d)
>>>>>>>>>>required
>>>>>>>>>>due to
>>>>>>>>>>phy recovery clock pin being connected through the MUX type pin.
>>>>>>>>>>
>>>>>>>>>>Thank you!
>>>>>>>>>>Arkadiusz
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>Thanks!
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>[...]
>>>>>>>>

