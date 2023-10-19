Return-Path: <netdev+bounces-42476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7187CED64
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6F1C20A63
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F6393;
	Thu, 19 Oct 2023 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qcmWxirG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9F38C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:18:32 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714B112
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxr1E5Pm+bVKmW0YoYK+jFU5h5tRUoUPsuII+eQuKBU5PDWdjoeIQzZS/vzJ2XlAG0efA2savUKf+JCP5R8iONEEe4EH4jvNYdk+r7gqjw6TVeLSqYZze/lFazml7Eik+uFJUzQk6YIEopKK8B2nGOpd5a0FIioUvTBwK3mXTLmXm6u8GMCp0RV4Zmru3VhxEFOmnEGufF3h3VKuFmGxXLgPV8rMR7hPhn2VtvzLWN2N+9f2UnHXrgNHBgZPUCElWeERGG/CnOxAazsROpz1Lm1G+TiOusfiPycdmQGwrlbkXIMVdAN6Cd+nidq0ojUhW/82ZDtagsRdJld8akjoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb0z9ba7EoKqOIDZ0r9V34zL1gTgdM9/eDy7anx0oH8=;
 b=hthjqDNnJKg3cTtE/9m5YXTf0AYPpsCO2waiLDjszdN7EjWHjwwfwE8ZTMjkJmoA1za78yXu7DQCfe4BlXpsDdaIJZeva7LBSSAnw6jTDVBiX2UxeVZDoIvNbmvQd50TuoFMQYVPvpk5Ai/1ImzpDMXXxcVHljQfGEzuhlpyT2BrY3+88dAwlofvuPrlRgQd2mIXVJ1/h7Y+G317vtlRN6pfMdmyIWFIPK+cfWocQCSQDFs5HgghGcdqMrv9TYFMD8CP950B1dV5moUQNB5Fcn3f7M3pmdGUcDCaelUFtRdAdwtnK7XiYxN187A0x0lvaayXCRxTK+ift0QFSfjm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb0z9ba7EoKqOIDZ0r9V34zL1gTgdM9/eDy7anx0oH8=;
 b=qcmWxirGOqx/cAAxKU/xu0qIUfYgSsQcA0oVbmlQRSNXsTVnzo1OmAlknoPdou0LeY8+SFLu8ZI4M530ZZwJKCO+w9qej0B1uE2vnMYK1A+UrhtsK/VoBte9QoJYZvEeQtJeSKHMemguu5Kbk84ZBK+6fApXwDbgNNvV56NhoMWmFAj2C/U428vJtnU6BbseX/QDerQab5bcdAjYaeQtuXbg43nSbh5ufF3v2SSXnsycuJfbVpQffWZ+MzbzUKEeDxYCKILi94+jf48F+0DDKKaKgNtAcUGLG92Y9VV+2ftlRgEBSUBpiaQwB3RLNuOh3rgGUkrs7oD32T1aZlh2bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 01:18:27 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 01:18:27 +0000
Date: Thu, 19 Oct 2023 09:18:18 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH iproute2-next 2/2] bpf: increase verifier verbosity when
 in verbose mode
Message-ID: <ZTCD2v7RuQojbkn-@u94a>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
 <20231018062234.20492-3-shung-hsi.yu@suse.com>
 <5a7efbd1-f05b-4b49-d9a8-ef5c4c6b8ee0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a7efbd1-f05b-4b49-d9a8-ef5c4c6b8ee0@kernel.org>
X-ClientProxiedBy: TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::6) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DBBPR04MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 194c7ea4-498c-4e9c-da24-08dbd0414c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B0wT3lYiVz3d0yFP1u14s/PN6p+UGWcLGVJsUp2kWIV7e4DF2qE1kl5jDPeBgSfU24keA9KIoUBlv/vnaaOvoDg83A6MHhiLmUJUQGtvKaPRxTIGh9UtuwMmflEjGh5rCGtWRgX8br//UzucxeHVIn1YW+kRjfiiqu6iyZBOtqxWB4cPGIB3NmKwuuGrhm2ch+fqbE1z01/7H8fo6mfPbtwjWRsXlMdnaCC6mgNbFi0s6PHcwgzifeZZ3ltPPu62TWkYbtS637R211V4W53ElmRbJeRF3mUGrWzEZJwLi7jKa5pI4teCnxlf7nG+DJhKPbrlw64ZpLUCqPaO/YZGpm7US6e5cQ9k9O9L4yYChpehmY9cYH1oJ3z6P6kk4iVTR0MZbWrAMjcQuQDoaQiYaGudYYQ0IwMRyoKmqGIv1LfqNPBv1jyaqLzK27QkPSgdGHeDRfreo61s+gYKRobvHaQ3Ti6gw4N7ecLeTOjHrrjlz+3lwruRnAfoByCSMOuGHy/dmkYnKR6nHah/6tfR4clGPpJhq6j9B2wbDTQjf2SP/jhdD0mtvduLHyZHwP26
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(9686003)(6512007)(26005)(478600001)(6486002)(5660300002)(41300700001)(8676002)(8936002)(86362001)(2906002)(4326008)(33716001)(316002)(54906003)(6916009)(66476007)(66946007)(66556008)(53546011)(6666004)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUFSNk9IQ1JnQlNiWXhzd1AvRzRmM25Sdm5BK0FBeXIrcGRzVEJvOHVBd3pu?=
 =?utf-8?B?UWZWODg0UTQ2M3YyQ2hhZnJpUWF2amhtV0xnV2RvVE1HOTZEa1hXc3czOVNV?=
 =?utf-8?B?bHJHbWlsOCtnRkl5R2ZkanlHd1BSaE5uNUtZRUVDTGdnWEk3U0xVR3NZbko1?=
 =?utf-8?B?ZTJXaFNjbmQ0Skd4a3ZIb0VIejNuQkx5R0JVcG9Fd2MvWjZiL21sbXBadmVI?=
 =?utf-8?B?V1l6cXRCN1JVNTdXTlYvMG5zSkpnR0VqeFpoWDYweGx3MFljb0pvNHgxbWZI?=
 =?utf-8?B?NFI4T2FHT0tnRVNrM1Y2dk44U2lBQUhLY3pLOUtlaXhBbWlub0pVTlE5RFJu?=
 =?utf-8?B?MENjdUV1Z05rWFRETC9sayszV0RHZ3FNL3UwZnVydnFTVUg4VlJ1SG9mYkhk?=
 =?utf-8?B?S08xUno1YjRsR0pTem5zUnhraGRqUXFNb29oMnJQTXo3R1RJU0syclZwd0dZ?=
 =?utf-8?B?dzdNdVRpWFFTbmN1RmZqb3V4VFk3dzZFaWJVeThPbkpldkt2OXYyL0J4cnJp?=
 =?utf-8?B?ZEE4amg2Y1hqNlVmY1lUclRzeUtmcDd1YWgvYVJEREVhZWlWZFdqSUVTall5?=
 =?utf-8?B?VFl4VGxLa2U3OFJib2xld0I2QUIzT0pKY083U294UVduU0JVengzR3BvUnh6?=
 =?utf-8?B?Znk1TlZVRWlvYWd2Z0lLdXdSZ0cyNC9RYjQxTWZxanNhak5yVUFlK2gyNXp4?=
 =?utf-8?B?TWRxS1hrcnByWEk0NlNlRUNUZVNBTFJYRGc4cGErRlFEL0J2bjdFdGtlRGZ0?=
 =?utf-8?B?VFlpWitOSlBvTTdTNG1oVE1LTUhuVDRzTEhxREpVUmZQdlVnZXR4UlFYUmtZ?=
 =?utf-8?B?ZXBVWUpFNU54MDR3aEJiKzVMUGZiRHIzYStkay91ci9CMWt0RDd4UGtiNUdN?=
 =?utf-8?B?Ulg2UjR3OWFwUGw5cnd2TFA2d29adTloZ1RlYmFLcG1FbzQvQWFRMTAyVStK?=
 =?utf-8?B?Uy9PeTNPd0JFOGVYQkFxOHlpWitaRVY4dGg0dW9qVEt6aFpGSXZhQUtaeGYr?=
 =?utf-8?B?azl6dlRTYU1Td0hlMXJCc21OZ01FcVBMYlhwMDZha0ZIMkVUZlk2aEpCbGRL?=
 =?utf-8?B?N2hZSEVaOWdmYmplQWNjZ0EzejlkK09SUG1IYXJIV1NCb2EvbENTd3BMYklR?=
 =?utf-8?B?RVh6V1lLVXU4aTc4VnlEVWwxdGluQm9BV29iSWpUdUdPMnpGNHN2TjNuNXo3?=
 =?utf-8?B?RnphVnplMFM5RDIrMytSRGhPNVRFdzhFNkhYYjNUdGh4SWNlUzQxZHBhelBj?=
 =?utf-8?B?d3FqTTFxQ05ZZk1kckozZnp0NGlMSGRGQmpqd0JmelNzRXJCcmlPWnh5OHJF?=
 =?utf-8?B?UU5rUk1kMDRWbHFqaDh4RWhVeTFXN3dNWTNxbU1DWjlXdkQ5bDlvd2NvZVov?=
 =?utf-8?B?VFkyQWdNeDV0cGhOS2VldmxBd1lCUXBpUUpyQW1WdE5LYWpKT3NLcWQ0MTZQ?=
 =?utf-8?B?M0ZCblJDV2ZORTNBcEFFcDhYTEhlejI2WTV0L0NiOEhzaCt4ejhwL1l1amNV?=
 =?utf-8?B?VGdCZUlpdDJPK21oSzNQRTgyK3JpdUlsUXc1bEJEa1VFamg0YkxHUTQ5azB6?=
 =?utf-8?B?OW9vUE5YTnlEU0pSY0xQR3oydFo4ZDdUcCtpK3Y5NGhKMlBSNGlRUVpnVHcr?=
 =?utf-8?B?VWFrMG9TZTA3M1dMcEh5SHRNT2RITHNBaE0yWmxyeGRMR0hjcEF2dS9YaytN?=
 =?utf-8?B?R2labEkrWXRMejhNbVQzVWkra0NnQktEcUhQWXBWOG1vWDBWTG1CM2FOVEgz?=
 =?utf-8?B?VElRTTNsTkRiTnB4eUN4dzd5MXFHYThOWGFmQmM0bDFjNDA2NUhoOEVZMkpI?=
 =?utf-8?B?VjVOcWxvUEdrNHh3c2V6QUttbUFSSVo3bFZITUk4OVhYenk1R0Fpdy9uSS85?=
 =?utf-8?B?R25TbWFpcW5IOTk2YXFsVVEyVDhydHBvbWt0STZBV09Sdjh5cGNPQ21VOVRI?=
 =?utf-8?B?cTlESzdwbTViNkRuMDJDN2p6eXpJc2cvY1hQSllDSkExSlh0NzVVL25LRmxC?=
 =?utf-8?B?U2RkNU01OUY3aFFMSGw5MVU4NkhocEUyektHVE5lbEdYanpDb0lkK0YxN0RP?=
 =?utf-8?B?TjRwQUE0TWF3T1dPWURiaXhkZU1uYzFzajBUNURwbGJJSWhGcWpTRVhHVFVJ?=
 =?utf-8?Q?ZTr9KJwdnozUmQD9NwSu+hylf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194c7ea4-498c-4e9c-da24-08dbd0414c01
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:18:27.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS7WOBDXcF59KvK1D9yRyuk4gnsC9eLYPJFIUdOSTfRLrGs1LVJTmqA6C3O61UZAEQdsWaAhO1Q81oNJ44jWJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7883

On Wed, Oct 18, 2023 at 08:35:30AM -0600, David Ahern wrote:
> On 10/18/23 12:22 AM, Shung-Hsi Yu wrote:
> > diff --git a/lib/bpf_libbpf.c b/lib/bpf_libbpf.c
> > index f678a710..08692d30 100644
> > --- a/lib/bpf_libbpf.c
> > +++ b/lib/bpf_libbpf.c
> > @@ -285,11 +285,14 @@ static int load_bpf_object(struct bpf_cfg_in *cfg)
> >  	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
> >  			.relaxed_maps = true,
> >  			.pin_root_path = root_path,
> > -#ifdef (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> > -			.kernel_log_level = 1,
> > -#endif
> >  	);
> >  
> > +#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> > +	open_opts.kernel_log_level = 1;
> > +	if (cfg->verbose)
> > +		open_opts.kernel_log_level |= 2;
> > +#endif
> > +
> >  	obj = bpf_object__open_file(cfg->object, &open_opts);
> >  	if (libbpf_get_error(obj)) {
> >  		fprintf(stderr, "ERROR: opening BPF object file failed\n");
> 
> Why have the first patch if you redo the code here?

Ah, good point. I was trying to separate out libbpf-related changes from
verbosity-increasing changes, hence the first patch. And there I add the
.kernel_log_level field within DECLARE_LIBBPF_OPTS() because that seems to
be how it's usually done.

In the second patch I tried to make log-level changes consistent, having
them all done with `|= 2`, which isn't possible within
DECLARE_LIBBPF_OPTS().

Maybe I should have just have `open_opts.kernel_log_level = 1;` outside of
DECLARE_LIBBPF_OPTS() in the first patch to begin with.

+#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
+	open_opts.kernel_log_level = 1;
+#endif

Followed by

 #if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
 	open_opts.kernel_log_level = 1;
+	if (cfg->verbose)
+		open_opts.kernel_log_level |= 2;
 #endif

Would be better than

 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 			.relaxed_maps = true,
 			.pin_root_path = root_path,
+#ifdef (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
+			.kernel_log_level = 1,
+#endif
 	);

Followed by

 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 			.relaxed_maps = true,
 			.pin_root_path = root_path,
 #ifdef (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
-			.kernel_log_level = 1,
+			.kernel_log_level = cfg->verbose ? (2 | 1) : 1,
 #endif
 	);

I suppose. What do you think?

