Return-Path: <netdev+bounces-21878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18C765232
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E141C215F9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A298156CC;
	Thu, 27 Jul 2023 11:25:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA5AD2E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:25:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2137.outbound.protection.outlook.com [40.107.243.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25198E69;
	Thu, 27 Jul 2023 04:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrMDrSNCMo5YXrKY/yJxJ3MKPCCc/eaCeghtPCPYxY+wkeTxymnYPuGA/ieMC/tIvqjq5PBtXOinfIhnyFW4cYG6HXVhN5S2fMn99ZPialtI8vzChODWnGCa3zds6ywDpdS+K9gUMdynPizDo09wO8HgP0Es3l3svl9tAy9xofjG/OC5runz4jDqvYavN7DhmV5pH1MAmXXM40cI1OW+ByLqcrDCiHGfOArRhcX8NoE+fBDCVNqG8uRKVZrFN8W061C7iSysT3G3jaawv4hMXXe9/00pf3J6iOoNTmCkx3zvpVGMaSMKytbXqi9evacr36kilvYjVPbMwjmERZukOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/brb7Ql/ffJurTTUFu9k2lGybbNjA9t8vahLkmcYKW8=;
 b=LEXMwbDYltRRSFdgAt6F8YkNBOYG+H9BphwMs4vkLo8LVp2MDhXmDqucAbolfcQygoYf4xyvU5c/YrlrkaROD/JjxBwWQw82wh6undGXGEBeGty6Lmtryx4uQccwcSk7ENqFgjLghf3PExN49baM1i9z2fKVLcvzJH+b0jZbcuvt2717m/NiC6/SWcBicq23Gtq1Nb67PkwHci4SLy+E9rmLYbUGrv5OnEBXFOea8hfig6HGo4oB8EvMuElrtqtS/p6tUZG+Hq8EX+IwdCFveDX4eLONDLwqj/u+bCSYT2exrgXO4N0ReX2KXkxnitWJdc7+WKHlyTdTd2d8+c9hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/brb7Ql/ffJurTTUFu9k2lGybbNjA9t8vahLkmcYKW8=;
 b=W//syvcGaEbGoqXfwpOr2qfuo7pYCw7REPD5cSySIL8n0+bCSrHyqfrqJRipbXzzBEubCbOfkZyO5jtOAC8z/OOwBi/UXgIZt+ISEmYV8SbgpBln2dD3AH4gmrdYpjErSJqlyC4tdgfvZROCwbfyxFMhFmonbRwM8erYQpWR+t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO6PR13MB6047.namprd13.prod.outlook.com (2603:10b6:303:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:25:00 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:25:00 +0000
Date: Thu, 27 Jul 2023 13:24:53 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dccp@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dccp: Allocate enough data in
 ccid_get_builtin_ccids()
Message-ID: <ZMJUBWEPY+QPYg8z@corigine.com>
References: <35ed2523-49ee-4e2b-b50d-38508f74f93f@moroto.mountain>
 <ZMEX4VOYzz8IvRUQ@corigine.com>
 <ZMEY9aPRSpiy+qie@corigine.com>
 <c962e03c-6091-483a-90f2-4db8afe5283a@kadam.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c962e03c-6091-483a-90f2-4db8afe5283a@kadam.mountain>
X-ClientProxiedBy: AM0PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::40) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO6PR13MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3a9cc9-b790-4cf5-c46c-08db8e941d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CClm/6Gi4/5DZMcsCIYo+QEtB6lTEarDTiTg2stspsxYpUIVL91q2Gf4yJc6r1TLu3aSn3qnkJAUo1fKHaE2OIJAz2OlPkPP4eez0rORXZFFvz9SRBlFutqaAUHHXe9Gk7R7vviHHA6LFQcK1W+hyiBKt8nF0Hwe9LIC+VDdk3fP5dKtbsgIjkS2nRal4xHbpetOxwk5uM4Kop8kss2wOAK0q7JxxLQzIi0oUT15f4nPZnYERWsnA9Rx9R4sMqsNwje2E6LAZdHD58r0hp+FGthqPwPAg3tH2thsadJAvmgBq4kQU++GEcTiwuqXtBfJPlqyFoFIjJ/p9hGX2bG5fGOFraFmpAIDlQL2DadX3e+a6xVN5tGnqMaSaRMLHcnrykOpsI9aqBQPOVYxR2pw7Qa59JdxxECmYFEE02JQwiT4Cogh8T4XqBwBI4bbiuS7SezpkQmF7UvX6G8+SUcequxmGab1NL2+CNKds9JmW0PluB4yby4ykTTbXO61SfBYF/6kmkuAwvOOR9rieCvizPU3pmKW5sTFJuKakhHNx9b01Li5aofjZE9GtsVxzh/NvpbqBgkR8JqEzkUV7grA21tqTgVRoNKIQCihHAPBasDvoOPsELuiTh7Um+8ZH8LwaoXRiIdAIPR9ESCi7TBiCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39830400003)(396003)(376002)(451199021)(2906002)(316002)(41300700001)(44832011)(8676002)(8936002)(5660300002)(36756003)(86362001)(6512007)(6506007)(478600001)(6666004)(6486002)(83380400001)(186003)(2616005)(38100700002)(4326008)(6916009)(66476007)(66556008)(66946007)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbPNvvsQgPAAbKQZSR+EM7o8xQZGGhM+YdwT6eyns70/hFYedRyNwf8xL+rC?=
 =?us-ascii?Q?OPhV4dca0CdhIDILFXb29BLVfOdiZ7D1i2Q5+20C/5LCr+CBJK7lyUkizeTy?=
 =?us-ascii?Q?qiB7uWwfpOzZ5qlmgPh94Bv09+bjjl58hIbmIQALnLywrr6Up+xJ5WW/Cc6g?=
 =?us-ascii?Q?ToXf7sR75PAjnfWoPhA03T0qROFibJsJGDa9mMd8usXkVnGOR+3dGQm2J5WX?=
 =?us-ascii?Q?use9K70+aODshPXLVM9blPZ4y8LP6wIsoojDNVjGC1KFrJhMbW9JsY2Ub3gI?=
 =?us-ascii?Q?SqVoitRlaHI9UxmBl2V2Zl/WSschDsctjh8rzOvyD/00IadQl+UVNCxptpSf?=
 =?us-ascii?Q?4WhHP46H4boMwwpGKHGA+hoT6ilCgAUdGq98AXfkJDiM4ThwLg4EqHmAAjHt?=
 =?us-ascii?Q?DFzwa6ao/GnG4eMB0hZzsEiRVqwrUlZrhAvJFX/2sttOr8AkV5T/DkgPe6Yx?=
 =?us-ascii?Q?eV2D0x2yycNs1eS15+Ivi+dhCXonf4V9oWD0UcqDiiGRuC+AuZRAnQ3LC5r0?=
 =?us-ascii?Q?2V+hXR9i41YUbqjE+7PXdTVocVDXkRrdw400ZIFvpggH65y9B5YgY+veHRWr?=
 =?us-ascii?Q?PrGE8paIbUBRFnUAbXjyI6EskKNq/mzmBVweVGuPsjgktiWYRH3RRjMOitV6?=
 =?us-ascii?Q?3/PZ3kt0tMEy3UvDYK0WVbQJsJJ1WVe13pzjdGQ5O8EPkan4aFQcFIrmCLoh?=
 =?us-ascii?Q?/X5gEbc5J+Y63+G7zpcvTbdmMWHM3dPCcbpWbY8o1KWSXN73xwZ4p9FTXo/X?=
 =?us-ascii?Q?EO0HPdeqRE20PBd4JPi3mw0h++l8a4hlnJ7i7NbGxPdhw0/6rWNt81mVMR3O?=
 =?us-ascii?Q?dmGwpKHVgzUnkW3xgZVDjec46W+1J5PzwVNET+JLzGywUuRxjOvcZ3fmf0s8?=
 =?us-ascii?Q?uzvPUcUiZoAVLSwsWcJaMB7b+6knN3OlAWBglkGHLqJVMvNN0KdK1bVO1dUc?=
 =?us-ascii?Q?md2zdiYbvqwbn5g9frjT7hZanptT9kJmhvaoOQEAC6gtKMa0tpPM2aH3BGfY?=
 =?us-ascii?Q?3XzfCR+lWFzq+Qb9ZRfMfT8LQ+XSXpceeyBkfCOU+xpsOuDGNMpRKDIevYnv?=
 =?us-ascii?Q?8/rX8OA01pTjHWRluY/b+6V5fACpfTA8mXaFf59xidBRe5dWnVEoKa8n8I/s?=
 =?us-ascii?Q?EaN18uLRiTscYKlqmXKj+giaNVicB6cvoGU/GAnoabwhv/o1AHFgfcqD9IFe?=
 =?us-ascii?Q?Rg8vrZcccdZB3dxU4l+6lQL0IdDJCf+ocNNtjFWqIWOE5E9ZxL/aVarzAtUI?=
 =?us-ascii?Q?aQesWolikkzIBnGWVQMybrYiQsPCDYZlwNKosQZ0MFcAvnvpqtXmaVYFpmb0?=
 =?us-ascii?Q?JsC20hdKbBzkwXgVc6uiVeRTvfF+vb73UmVXGSneyufU7qh7WAHwh3nZdA7W?=
 =?us-ascii?Q?rsB90v08XTrU5FZtsTsyv1aPLKjYOtvtm3skFgmxl9XKL+fBDrx2gUpJeyXu?=
 =?us-ascii?Q?Wl7ukdp44UYMPE72cYxYO2SXY8gumaE1ups5blUSWiAYRCNXekPy2FChh01p?=
 =?us-ascii?Q?bOmRPnRM1XLh37cabQAk2xh/eU5+gFWq32cciE71JCJtSGM07b2Yxd6jRECh?=
 =?us-ascii?Q?CVuewxMM4nJtmxFkd185SSek62wTkUTRjZ/yZPOgjBDQQXq8Kb5GzF3eBUgy?=
 =?us-ascii?Q?Cfoig/7dEb4EpKypvwR/LeGjwAVHD0Xco9mH9KveuSESxQtnzum8OP9TCkGI?=
 =?us-ascii?Q?BukfWw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3a9cc9-b790-4cf5-c46c-08db8e941d47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:25:00.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srwuft/2VlqKG45loTyZOi2FDn770uAZCTw+QWwtP2RAIj57wu5sVr7P7cPSXySdDN0GQuqiFFVJgAfZhPUqI8Y+787mKN6a4htrNb9iCFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6047
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 04:45:03PM +0300, Dan Carpenter wrote:
> On Wed, Jul 26, 2023 at 03:00:37PM +0200, Simon Horman wrote:
> > On Wed, Jul 26, 2023 at 02:56:01PM +0200, Simon Horman wrote:
> > > On Wed, Jul 26, 2023 at 01:47:02PM +0300, Dan Carpenter wrote:
> > > > This is allocating the ARRAY_SIZE() instead of the number of bytes.  The
> > > > array size is 1 or 2 depending on the .config and it should allocate
> > > > 8 or 16 bytes instead.
> > > > 
> > > > Fixes: ddebc973c56b ("dccp: Lockless integration of CCID congestion-control plugins")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > 
> > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > 
> > Sorry, I was a bit hasty there.
> > 
> > > > --- a/net/dccp/ccid.c
> > > > +++ b/net/dccp/ccid.c
> > > > @@ -48,7 +48,8 @@ bool ccid_support_check(u8 const *ccid_array, u8 array_len)
> > > >   */
> > > >  int ccid_get_builtin_ccids(u8 **ccid_array, u8 *array_len)
> > > >  {
> > > > -       *ccid_array = kmalloc(ARRAY_SIZE(ccids), gfp_any());
> > > > +       *ccid_array = kmalloc_array(ARRAY_SIZE(ccids), sizeof(*ccid_array),
> > > > +                                   gfp_any());
> > 
> > The type of *ccid_array is u8.
> > But shouldn't this be something more like sizeof(struct ccid_operations)
> > or sizeof(ccids[0]) ?
> 
> Aw crud.  Actually the code is fine isn't it.  I thought it was saving
> pointers but actually it's saving char.  *Embarrassing*.

Yeah, looking at this with fresh eyes, I see that you are right.
Let's drop this one.

-- 
pw-bot: rejected


