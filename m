Return-Path: <netdev+bounces-18247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04E755FB5
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61981C209E8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFA8A93E;
	Mon, 17 Jul 2023 09:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F7A927
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:47:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A2A4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLvhfdgdeSjgH7QZyvM3e+DDHfA+QCRI8ks+QiSHDfPoTmpS80T3WZqv7BXlPFGVJUTdoBcXQwEmhKBZQTs+L+J4f78O8Kp7vxZ5ODAdf26tcJ0/y9l7Q63fRwLQyO1KA3RCTX82MjPch77qO2JmxgSsoL+MY+eMO/kyxxNO2987NSXUnyNe310j9BZz5coxYfHCAm13aYyrkdFBKpypWt9cg2EdKyGpzUCXh3VPjiqexAG26m0TxYsFWPp58f6MMVusC1FNcxwDqS/HSog9bbgf5/n8ylV5VRYgML9G/kl4AhCyzgSbk99aYjI+PEFZ7Q1IFvBX8NtafV9uC6Fmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7IS/1ABcOkizIuGTkRQbalxBKGZ3C7oQoMTCXAoKrI=;
 b=YDSBPe/OlgPXz61VhKBJoZ/TL0VBi9fOXuODdLhxl1Ssr1Da416eRK0Kcsuhi9eikH5k3s+nKhBjxO8PoyLuTzaSX5VgtGgapQBj708vli02j6JSpoT5eM6U+AD+8gB1noe5rg9mOOWrk3O0VKAN8BNMsWynNcZVeyToVmdk2kL9I7sHkHAxAqgp9/xICUOsSDuacDoZ90qjH7w2TQJQVbrv/l+7Lz+1+ANdVjaG+IIAOS08Yuh9LD2Ej/uxqOAdm8hs7pojmvEE5C57T26evK33r2lF5t3nB+iciSEjQh1usbzWxQkvrsDKvHa41/KL3QpOHnzjeeXk4nuWKyLqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7IS/1ABcOkizIuGTkRQbalxBKGZ3C7oQoMTCXAoKrI=;
 b=GalJUrv807/pyKT81J7Xz7dE/Eh+Skm7hJpJ20uOci7LEU3tGJYqEQzLP4QGlqmF9g0M7Ym5uoRs2S5A3CgraEwi12/r1A6RRXMV56MypLbDFGISwSfN7K+gaU2oVJaOrd0wOQsanW5c6mqnYTATHtQ0ov50MHeuNKlomeSY1O75jxpPnhiI+1m9rQxdM7WjR4x2FUhlWzyOsxqyLmX1WEeme3IuKqt3vzEQJedpH3dqfQXC4u2SrDPa8UDdIbO0qyf1WDn8lyNNC89UUHvkL/YLwzmGY8vgv/hhJkTLEjxDEtGRX1T8o49XCy+EWT1YeXlZ45jDWexRf8IruUkUlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:47:15 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:47:15 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 04/26] Documentation: document netlink
 ULP_DDP_GET/SET messages
In-Reply-To: <ZLJyU5mSp9g/v/aN@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-5-aaptel@nvidia.com>
 <ZLJyU5mSp9g/v/aN@corigine.com>
Date: Mon, 17 Jul 2023 12:47:10 +0300
Message-ID: <253bkgaswdd.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 401e72ea-7288-46a8-73ff-08db86aacd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uiEXd/oL/u8pVWAXvGaChVuvXD1YFlr2irP+vKbkLelqbNP8709HwtwQ+pXvVtkW8hCFYpxYoe1LuvRWtctf45GOBDKurCOb+s1MrXbGSm4gzmnGwM3yhgRL+YNVy6G9+31S/0FfJAfTjW3mjIGyUM9/ELBdNavpWk8GeTO3UbLfaezIYY4RPNE8u61TQYWKPomBPZt0j01OtmhKvLu/WO74qNY0btsilIaUtQeds8ek1iiZrZ5e4NkLBbtLBPqM8q/l5yFT+4ApsfRE3AIt89iPF9/Dgm1d51354jokvebqi5nghYKdHbAZlsq6zVSjh5lx+gHhE+D7O9iSyupZyfLnMbhvPa8SJwaMYqSBXdr0K/y4zt2U11B6KAtMstRv/JmIerZzZsgqiRfBoj1pzGEJxZ3dF1IFf0Eg7JSMJTgV2isPAu1gIqHbc/3iCkKqGGY85SQgRnr5NkZJdXXyo9lhngAskfIrbllKthFBiM7T8sCBH5yLHfqXse+CV5fleP4T4GFx8LWHokBuXzj5DiMyiJOsU/b7K2AmgkLjRVyLbFjP1GW9XU4EXTtV3jMt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(558084003)(2906002)(478600001)(6486002)(6666004)(8936002)(36756003)(8676002)(7416002)(41300700001)(66476007)(316002)(6916009)(66946007)(66556008)(4326008)(83380400001)(38100700002)(86362001)(6512007)(5660300002)(26005)(107886003)(2616005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HnbPmOfIGgYaMpGKJW5IqGtknFki/U0i6B3JVYNrbqPy5TWVnKYFfkXjtlm?=
 =?us-ascii?Q?pd7Yt+YfkVVrD+9paprtCgh2MFm32hc00jv3ULqiccl+/1pkaknkWpySi4EJ?=
 =?us-ascii?Q?FlqAxwAeBMVP/I8GDqCi05loZF/1PXV4hSS+9Igh/awkBZAZGuY4xYXEBe2f?=
 =?us-ascii?Q?8lZWUyyVnBAO2/BvgQG8rqF3zHQ63P7SV81TH/xNvaAerLWRNP2SWxsLOlEJ?=
 =?us-ascii?Q?H9iYrgj6FmM5lykAYiiRw/zy5X5sM/dq0reJGuEVNx4m2KoAFgacF+hdz8ni?=
 =?us-ascii?Q?qm/MgObbxLk1gfCme8QLnUWAELRSVCkZfRwW9K82VWdDA3UHrBs7ITNVwsk1?=
 =?us-ascii?Q?MYmgLEnXmHiL7UiiRPsk/US3rPQOWBPS653IlYHBD1snwf7kuX9clUKkjZM8?=
 =?us-ascii?Q?Tf7U+lgqnqVECJJvCfrqDcXbAXCKjOqX5tq5yaWujsypNNpzGTVhYIQKJBMm?=
 =?us-ascii?Q?vXubONQrfyiNh8c/v3jgrZdCPhp1Xf6WID1z9XCOPop2HVOuhmxb4D249l+q?=
 =?us-ascii?Q?gtXmuhIqoGEvMWI/yBgWDZqsl70k/hydCebxHWLObN0Ou3XOTAUfQhIy4Wvw?=
 =?us-ascii?Q?BAFGhQe13DW0Ol5jyMiHijHsJwFotm2QJgnxaoT+uCzyaeMrVL6rEf/Al1PL?=
 =?us-ascii?Q?ew3gXILwLuV4LXuTu69x5BKFOfm+ZBmUEoOX5uU8qC1jj+MN0md4ZIE8S2RS?=
 =?us-ascii?Q?Czh4XHYWjISDbYF8yndTyFF5iRuHcd6J4fvh6AyvowsOh1lS/esAYrUUo0fw?=
 =?us-ascii?Q?NwEv4YE5WMi7JDFLGOCCypSpl7sYuBXlVRY6ajlLwmKYhFweH/a3w/OGyYLT?=
 =?us-ascii?Q?YdW3X7B+10wiEaCJhHuoEnDNs/RvtKswAjDzRfruZ5OfJmh+il4RA1/jXh6P?=
 =?us-ascii?Q?Dso7hm/jH6K4OXQ5+bCy8B6siUGvheQr8PmVAMcSSRjj7ZDPRgBJbSe3ND0z?=
 =?us-ascii?Q?VqAd+Ocat72vCh4cr4nced87Zug9w49PtBpqUtGFEzLjC3PIGvI+OjAnxNqo?=
 =?us-ascii?Q?pSxK4nsaOChORDmdEWOWM4caiMtHAEPyPbB+iUyd5z80lQquNJiVb/VbwE+M?=
 =?us-ascii?Q?AqirHRHsR52gPLsUDWyU869e28JasoRioKeeIc6lQrSOcyM5bgDoC78GutqY?=
 =?us-ascii?Q?Ktt5WpSPvdJ0PP43CcFz1gSveqOzo0MdQc4zwMSsLF9OMxXsK6G1ZgYsezE8?=
 =?us-ascii?Q?XTDFROHCaUaJjUdlFvEFrMMu3a/5Z//bvvqVVVqiOnqEgumRKmGwB5x2r7du?=
 =?us-ascii?Q?24kMFbQqyavU/GE2+YXOXQYpt+06vDCN5y3+cHiQxk2dJIP+ALMARnauyof6?=
 =?us-ascii?Q?nx/JK3lIYHOcdmwJ0V17AzHhYt+5dBRumlRg1UeecaEZV3QTx+6/J5JnaJVg?=
 =?us-ascii?Q?T+TFDdSNzmYSlhGrwI5UyvjtgUstsLano05Ki/bL4kd5RHnHcXD1pjFAnUKa?=
 =?us-ascii?Q?KYS6FlGTEYGFeZKpe8WMkUgbH1mJ9zp9kZbC/piuiQZ77Gr+tnvol9qQAcTT?=
 =?us-ascii?Q?/zm7HPQV+2Mfo8FKkXzaylec+rVr0W4LYSuh3O3gRivII94XhaS2h8ZA1F/S?=
 =?us-ascii?Q?u51fLK32s63DCROgne8A70xAsGKT3LAig85SwkgP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401e72ea-7288-46a8-73ff-08db86aacd95
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:47:15.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mitA5FEKRCV1kpQo0AtbEUYEzr72g+PW/KKMqCAv7PQO3n/CeKk+sRfmn/j6ZpPEaaLu9kF7N+2are5av8achQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman <simon.horman@corigine.com> writes:
> 'make htmldocs' seems a bit unhappy about the table above.
>
>   .../ethtool-netlink.rst:2038: WARNING: Malformed table.
>   Text in column margin in table line 6.

Turns out the column separator is 2 spaces.
I'll fix it, thanks.

