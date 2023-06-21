Return-Path: <netdev+bounces-12818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14A0739054
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79DE28172A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816E1B90F;
	Wed, 21 Jun 2023 19:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF117724
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:44:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A819A2
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMIq7T6dLr04D3ksvUtqaSnrlBHcKoW7rweyn5IMPjOAObaGOlNac4+J/Cia+7MYigPTPKxNpphhjNQ/o71Vq4n7CJLhV4cnJG37XVqoH8qlM1CKN6UwB1kchE0BEr0X3ZiptVV4vbgByOC8iQ6rkPd7LpwoaWitMsjvB99ku1y7vOVRztVa8wnO0+wT4VUNof+QncCqy/eup4jJmLmwPDxzq84gJkqT64BiJ5g6yGLIThcU54XipEsw4vLN+8TZucfRzmAEyWWFcLojyO5jpSunBqZ/myDqjW8elljj1FRm1GRl1S+3qAMh9zgxBDtDh2hpGGVS0fDUPNYIM4axCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNfBF0FXJx6msCo6WIiBJ5/oSclSfsQwXR4t99PBwyk=;
 b=mbLtgGHkfUgYqRUvT//fK/GhhEhdR2W69iBLL2rM3yHd/uWP65w5SPWnRYwQa7BKAdJQXL3XDKlJuKZbeNTwm8Sk+BtVC+dyG/zDQDN4N2Bgf7fGUD5+3UiISNq5Vb5dVVbUOZTEduHW54BbNrpY9+f5iQnOErUfDuIFNYj6X7hAH6hpxbY79r/5/4hCeaHj8Qc5NmvtD7khHHK+F7Z/OM9tzQJ+8Kp1dRcSyqY4V85XletWzN2ocoXpdPE1qzdW8pbygT0x62RLdeluGmWwm5J2cHWJ/L0bWkKRZ++l7U8GY85ZkdoASO6c6ctyx+XK2Up7lPtoVxsZOSRHtOcdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNfBF0FXJx6msCo6WIiBJ5/oSclSfsQwXR4t99PBwyk=;
 b=QDQgwCuNoNkF4a2WZlz+kWpUBDD4oxIbQ1b851XR2IIueemNK5ersdlZW6q2PxqL/3tMPD6ODwMagzeXtpvze3n6a2KRvJE2umjV8ERyUm20eomMHA69eQeQQ4whrKS5Da2u/ymZhvAQsJwLncea/VNvTt9AbXutjHqSx0lnDUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4015.namprd13.prod.outlook.com (2603:10b6:806:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 19:44:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 19:44:05 +0000
Date: Wed, 21 Jun 2023 21:43:56 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>, emil.s.tantilov@intel.com,
	jesse.brandeburg@intel.com, sridhar.samudrala@intel.com,
	shiraz.saleem@intel.com, sindhu.devale@intel.com,
	willemb@google.com, decot@google.com, andrew@lunn.ch,
	leon@kernel.org, mst@redhat.com, shannon.nelson@amd.com,
	stephen@networkplumber.org, Alan Brady <alan.brady@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
Subject: Re: [PATCH net-next v2 03/15] idpf: add controlq init and reset
 checks
Message-ID: <ZJNS/JeE5gAg/9Wb@corigine.com>
References: <20230614171428.1504179-1-anthony.l.nguyen@intel.com>
 <20230614171428.1504179-4-anthony.l.nguyen@intel.com>
 <20230616234218.58760587@kernel.org>
 <0b6fa05f-d357-2942-d17b-d24d8a5a3321@intel.com>
 <20230621121439.382c687f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621121439.382c687f@kernel.org>
X-ClientProxiedBy: AM8P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d972b54-a5be-4cae-2f62-08db728fdf3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jJlBbGw6sDXRu+i5OrqbSgBPkpW1FADuHljWPLprJIFxPXRQwM5bvxIps73nHnctc+/3YhcWxRObW8ZMQdHy8zTz1KLFmvybUDOWaPmCKRhwAOhg2w+K6sdw3K1ugxoVEVxOLyCY0fI3VMIQCqkdLPL8qp9ZGXXU7EXuT5kkGX+YeSXfiul01nBlCU/7PgYi81F47ad/8i74KHrexoxsye0ufs/Z2Pu34k/o5jz+FGwVd+nkuLsYM2PYz1GqaAtyeP2pnB9o4Ll6i5YW8x64GQkajNzdShbgrEKGQI++EF6f1FuLHvm8MeMACKo+BaFTC4GPUZxm4RfwEWl1xEOrS+LlsK6y6UTOWrzIwJkx+1p5DzFK/45V1r5W8cF/NtrTnSNLJA2E17OOiwWPZtPNJnFbhnsWCr08iwcW3SZiPpQOkbEHr4c7446YFQLw/rwE5e9Ll4gTDBq2H+F8CzVEnQm+MMmYiPht4BK+ifvwRkLrWU2jwizHykf/Lcb2ocpv79z9FljVs6kMS0/6p4fUTLMI7mvrNi26cE31a3m20GB3K6PbKlMipKlTy6VBGk7lgSNbs+thsV8m7f7tdlSaZ2RaD/3cxLlNlAWrVpnGnY8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(346002)(39840400004)(451199021)(186003)(8676002)(66556008)(8936002)(66476007)(5660300002)(66946007)(54906003)(4326008)(26005)(316002)(6486002)(6666004)(41300700001)(478600001)(36756003)(6512007)(38100700002)(6506007)(6916009)(7416002)(86362001)(83380400001)(2906002)(44832011)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPA0J/DfGILlfyBL1mFTlSbXDicgekPJV4FNOTVyBkUoX+xNO78QxFIqhitw?=
 =?us-ascii?Q?PxmGXDsYhvi+41jR2n/Fl8IrNzcv+BDzRk8Sg7CKmQECmv/ROvGzUGc6lHhB?=
 =?us-ascii?Q?hmULMTMD9u4jwroElk0Vfx284feJwqmxz34FQFxd2gmof5rDwjfPSgOHH549?=
 =?us-ascii?Q?c0WfW6p67PTkpvr4cSpCfZ1t0j2670xZBw+c9jusuXsyvxI8pfwnVUp9ytUh?=
 =?us-ascii?Q?vOkbRY8M8j68UkqYNQV5tZ/s2cAK6rYfriPK49HuHVQWKd1j+z/O7BYnXaGt?=
 =?us-ascii?Q?AncoJSEM62vyFi5kvdiIEPTLzJarVzf+3xifyTHuiQe5uMpMk6VXzx+5ew6R?=
 =?us-ascii?Q?4S/l7QSMbfrNEgRSFPuIb9njiqoV6B1RlFBPlrHPoPHAIE5rXHIaVxV+xhya?=
 =?us-ascii?Q?Wa5MI5WId4dPm90FZd4eYkJ8oFeB6/XK0NAZ1GyOHzHnET9AMRwV8+WpMoyo?=
 =?us-ascii?Q?DzyVHAcKBClCEWCZliFwlWeB7NhbUmZXKVuOmgvvWa5upui0Y0I4VctR+5Q4?=
 =?us-ascii?Q?6rjUI7MwKwQ0I7P4s7l3T/R54KoGoiBtV+4bAWnktG4nhOYYDH21iCF8QWAt?=
 =?us-ascii?Q?djXiIrrLtIQwUHBF1dFFjDW7FnCtqpCWi8+OD7p2s20PqJR9jg9nob58/YeX?=
 =?us-ascii?Q?5/0BrWKeVj5ZRguwpBxr+ndkNgxPF507RUKpl5OcA1zIq6DUga2KSFr/DYjH?=
 =?us-ascii?Q?TTl1MuJsHkRM1N3G0+L7ipK9aWHkHhCcFT/5eUqClhIGEcygk1Q0K8Nw7wOA?=
 =?us-ascii?Q?2dCkPWPljDgikXSZd20VJ4147s7rEXCOX3wK3TH1waKoZYr7PYEMOsEzdydj?=
 =?us-ascii?Q?1SILTHkq4p0BY7mYg2VF5DrGyx/bFF1m4LDPvKWeJCrFN/Hh9wu/GkTNEu7y?=
 =?us-ascii?Q?H1onc5dlNqN5Xaut3K1xY2koN9jKBdNtwnnMBAu+u6G6kOUYmOi1lgq0WT1/?=
 =?us-ascii?Q?FUVO3f9wvnxp/OIDprVKSmtnliTddlW2doQinTcadNBd/brQKSjWDUp/s7pu?=
 =?us-ascii?Q?IuNAbvVAxFdrfKNwOVz9lfzCqy8uL7T6SGyndN4dBiYgB4zpuJPKlpZu5uPY?=
 =?us-ascii?Q?EKg9OwVODDgjmk6e9vqiazABQZfwU2ic0/fFSaR8q4KidHU+ymPkFKxBymV1?=
 =?us-ascii?Q?WoL4yDq86sDKgxXod63bNs9efgLxg3mUFt9Tdy2jKXv5H2KYb0jVTf34dYv3?=
 =?us-ascii?Q?PLsxYLhFlVUcKNhbx69ShwL6tSStJArLgGfzk5gQ0yEF4fPCqX3asSWqwyAI?=
 =?us-ascii?Q?nUQXl3aBJC/G5tvLb+cArbXhlOGEdZVSQ+Pv7OIoMAC3H4smsomotaRELWGM?=
 =?us-ascii?Q?KVxGGW9ZcOuJKpIQiEw8+OehHpQPbR6BP+Y5N1fM9gcq4mkj/IKnIxqEYXGo?=
 =?us-ascii?Q?ViZQvkyxHKOUrmSOErXf+GUxX2uB9n06fZ5DE58ACy8K8nfAZqld5xDQDjNJ?=
 =?us-ascii?Q?/mKNWS1Mlvt43BeJ/z1wfmHUn/MzuZ0Aa/1r0SBIzbLC9HHLuxSIUKb8G1w/?=
 =?us-ascii?Q?4tvOR2akwEs6hy+29sCnLQg5OAQmzKUAFHZBfAMymZWde8Aen2kFdvCiMIrU?=
 =?us-ascii?Q?LOIPmaL7qM/BeRIl5AT9QvTuDAjppHZEYx+dggnC/ThlKXgm7axbdaGjwEoO?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d972b54-a5be-4cae-2f62-08db728fdf3d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:44:05.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b01T9mLmVaowN3JP/M+kK/N5Ym4V9B2QzjEplNq/KuFWuy0zbwhy8/BKBs/vO33yCfAm+Mo7pZy6LfQg0YSnJq6X80jrWWRA0Xb0usEcoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 12:14:39PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Jun 2023 12:05:54 -0700 Linga, Pavan Kumar wrote:
> > >> +void *idpf_alloc_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem, u64 size)
> > >> +{
> > >> +	struct idpf_adapter *adapter = hw->back;
> > >> +	size_t sz = ALIGN(size, 4096);
> > >> +
> > >> +	mem->va = dma_alloc_coherent(&adapter->pdev->dev, sz,
> > >> +				     &mem->pa, GFP_KERNEL | __GFP_ZERO);  
> > > 
> > > DMA API always zeros memory, I thought cocci warns about this
> > > Did you run cocci checks?
> > 
> > I ran cocci check using the command "make -j8 
> > M=drivers/net/ethernet/intel/idpf/ C=1 CHECK="scripts/coccicheck" 
> > CONFIG_IDPF=m &>>err.log" but didn't see any hits and not sure if this 
> > is the right command to see the warning. Will fix it anyways.
> 
> Ugh, disappointing, looks like people how were chasing these flags
> throughout the tree couldn't be bothered to upstream the cocci check.
> Or even document it, it seems? :| See 750afb08ca7131 as the initial
> commit, FWIW, sorry to misdirect towards coccicheck.

Perhaps not entirely helpful on my part,
but I confirm that this series seems coccicheck-clean
in my environment too.

