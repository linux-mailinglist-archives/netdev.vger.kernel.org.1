Return-Path: <netdev+bounces-20718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA61760C1D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6FA1C20C09
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AE10971;
	Tue, 25 Jul 2023 07:41:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DA8F6D
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:41:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2101.outbound.protection.outlook.com [40.107.92.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD6B1FF6
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5FJ/Q3hEDbCrBS44VXMMg7nHv7EODlrF6EU+2CfYvpmbBL5NAZ0cYI64wmZjbYZ6o1XKuv0ZJLEwa1hy7Er4x9R/+6y1ty9UyYGDL0t8H3WepQCb1Vl3IKUzAmNl3CezyL21qpLFJ0c7eIVwedw9wIq2emytVff6JWn5f7uxGQ1TJ0E+/Y/3Y5jjkvXNhDkHseBHARGNedLlFS0zi3nUl4NAiPlmI/eGYUmatiaXG0XEqU7+zp0bfP6m34TLwm/HnKqstsuGRZRtzGgZ+mvjo5SfAM/luAJ7/N462/M0Grmu5IRabCj8s9UqCkY+5xewh/yx1NmevGtZELRpDQy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5a58J/0NQ+ei7NDaACFVP4oICVVwM5nY+qsPbdOPAM=;
 b=KbUGBeWX6HHOmJUcIxs/eD82JEHw7pXwVeyQvk/Z0h7oGJdKhuHUD6YwGmqAI7vAGqdEIqeK/BWs/2m+OJPMwFT5/BT8L/rSNKJUBq2d91dOEAW2++kXyRuV8Z6gLYbGXWok1k5ZE2m2EyiIvqiaZDNBqXK4Jg7D6W5UQ/O73fTyvq/BFR9C5+Q3G5wKcxCqw/26qYVyJSf67jdQWrDS2wzP/i06WvZY1HVh+gNrZEYk+jeR9f6LIhsgvtimE0/KZT02u+X9JoW84taGNE7c7DBA4VLOmeHewt4Y/aUSQO2PUIjigXeOUkZ4GyhRpgGCiL5KV2mhGRaCEif5zWZMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5a58J/0NQ+ei7NDaACFVP4oICVVwM5nY+qsPbdOPAM=;
 b=QNLgfEntPudUoS32Vhy0lixjBK9zIVRBbVhP8C5kPJMR3WDX8kULNffB0jFvfJIQVxAwBD9nZNktNPI5ADD6IbibRxs18a3DRAtwStEPTo0pJUhcaacpqBp3iqVog8V37K3cBifp4IJhfueMUeNuHjd75s+dlaeAXgGCotCHD1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4834.namprd13.prod.outlook.com (2603:10b6:a03:36b::10)
 by MN2PR13MB3759.namprd13.prod.outlook.com (2603:10b6:208:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:41:01 +0000
Received: from BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1]) by BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:41:01 +0000
Date: Tue, 25 Jul 2023 09:40:54 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Pawel Chmielewski <pawel.chmielewski@intel.com>, jiri@resnulli.us,
	ivecera@redhat.com, vladbu@nvidia.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next v2 12/12] ice: add tracepoints for the switchdev
 bridge
Message-ID: <ZL98hoj03llhaLA6@corigine.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
 <20230724161152.2177196-13-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724161152.2177196-13-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::36) To BY3PR13MB4834.namprd13.prod.outlook.com
 (2603:10b6:a03:36b::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4834:EE_|MN2PR13MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: 205b8d7a-6685-41d0-b310-08db8ce27e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o6D1rfHPy1QQex/h4tw4rDzsJtzA49ZnnliLmYO6pdYjZcP1RFfM3MJfFlw+EAtjwdBVehamaFe/y4xDB4YIX5OzUpYmV3eKW1A6knwAxaoB+KUvM2PBeE4Q5p1jazTVbbnfCZlAE2kNmsAPrH0QRTRAe26wdhD2JXH5U9csYF0F6LK0jPZKFzfeNkEkEHNrof7ce/qL5x9q1ssQvyjtFwqNVwAkn8tP2KIju5vKA8cNjC3Y7v/mswm6+/Q+vMAjRCU7rv8e2R32yspZxcpc5vQ5f0zPv9kBIegGxi/A9cYzPe19GeVmSgA6tXoEHU6h6KVyrmy/L16Lq2T8A9SrX9zMN6x2HtGqdBzJDA2WaS/gxt/I67RJ4KjUEyZX/NQZoomuad7nOWHs8h1HvbFuLbh62cOLy/GkrVKcFBWN4upR04fh7hs3jzNDvQVpoHeZDRZjKaYKo7jMz8+ycXgi2L7r7O9YJkHjlfdpsFFPtBbcG5QcmEkJYYkEVO3wQwvh2m8O2tbXNC8Zmelr45XjA31WXOzrr4LS0j5QsSg4gSwkjnOL8zqIURjSwo2DS3YpWVotNEOK/poX1cBRi0Wp40bO0sC9ODxl/jNf0Zz7anM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4834.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(451199021)(38100700002)(6666004)(6512007)(478600001)(6486002)(54906003)(41300700001)(2616005)(5660300002)(8676002)(316002)(66556008)(66476007)(6916009)(66946007)(8936002)(4326008)(186003)(83380400001)(6506007)(86362001)(7416002)(44832011)(4744005)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XM/nVI+lTa7WwsJw8CUMNZgiZevpFLkyOEtBooIVLnH+lSGRubRL0MdG+3aE?=
 =?us-ascii?Q?KyjHEO+R5GMUWKtLsywBPcWYCz7PmWJNy8wpDjUMoDNp4yQpq1YCq3MEovwE?=
 =?us-ascii?Q?KZhSfrD2RB6Y+y25FvN9pEkk51w+HYHhhc3wklnnGwZYkwc1U8kVls/fJvBs?=
 =?us-ascii?Q?Q/9kAox2SfpNVhlbo+wRCdkF7BDqaNAIcy8Pw1OcNfgwp7e4MbymjhFTSnZz?=
 =?us-ascii?Q?UyJw1qeYLmF/IW/rak72lbxDW5b5S4UnJw78f+u/7bv5T27Y1VJZPylz+oVh?=
 =?us-ascii?Q?o4Kt0/EmSCRfiawcqwidpKc5+Lo9awl5HOlgVXmi6ixlp/6M8PMOf6A1aZMr?=
 =?us-ascii?Q?TA1Y6XkFLJ+u1arRYgj9ejcAtZzku8Z4dwaYU8QZgVqJfcx8lMQiPg6Oe1Wh?=
 =?us-ascii?Q?/vxv9UQjYC7GVgNjPGXZ5bXMzUWYdaVjicE3zvGTZb9DWkumOktHpfvQ0z/E?=
 =?us-ascii?Q?Ga0GPMPPYmeUYhXoL3Zm2VuQTTEqj+EME15mevJJ1c4DUoT5Lf2H/+FqOT+8?=
 =?us-ascii?Q?xTFwOp/pLR4qExx1JoYHf7AXOTxekVmzbX9nSjSwLXO3XYnil9ydjRNPvnae?=
 =?us-ascii?Q?faF0iOZ8gE48xvW9w80ZCddEgkpJeWImcIEqnJaC9LLHPsv5eTcX+DjmxG5K?=
 =?us-ascii?Q?mDs5detb3fmfPbbyjBMoJMj8+veUIikpH7SoEgyyqQMQZbN+agnUbOpICrh3?=
 =?us-ascii?Q?VGNl8QwHGYSyq4rQD9skqildrOiLSwb7kn9136kP3XKPd2Hw1Tmk2lokJXah?=
 =?us-ascii?Q?WuerafAqCJPCaHaJLGWA9aamZHGLV87z1gFWV5cO4HOtzllho+qBqzA4trqe?=
 =?us-ascii?Q?+4I59fIG5TORytkJ2hoAs4N3mAVV8tGbZNh2HjcnXsk1vqfXhyN6w5tG7Rdc?=
 =?us-ascii?Q?6NIsQpu1rTMKP90wnCA19e4odevdFrl7PAGClQKlzZNC+TW4lCsppUAJN1Xi?=
 =?us-ascii?Q?tlmuVIeX7SOfBO/xA7kGCHzL1aJB0QTwootG00w3RUajHWRpN73DpIH0BCBg?=
 =?us-ascii?Q?xhJrIiakTGjswYaoYeO5/sD2LuMbHErkjNoX9ViV720p8TzL14SOvJNNJjYK?=
 =?us-ascii?Q?/ReHhJ9q3EExYHmfeAeEsL/ryqJlIGIjEuajDtcZ25YGNLQFCvIR/IvFq8gu?=
 =?us-ascii?Q?mPLUekxwSBLkxJhTuhwQux7m3b6+qcP697Gqkxm7Sqr6dXxJEcZK/13GGsUR?=
 =?us-ascii?Q?qQG4on7TN/cRWAD7w6iwD7A9nVO6bMnkzm4n9nP3tn6mTPotEagOnHWLZUIo?=
 =?us-ascii?Q?sRrZIMM2ED+axPdE6HLDjOxTqRjgugPmqLERdXKul3jt+4+hzQ8U/j4OxAkf?=
 =?us-ascii?Q?NyCh5pHNPdNUgfDqd6xtfUhP1bKw5FWenFgJKLWf7t13zFygLjDYXctOBV+5?=
 =?us-ascii?Q?VqHZ8yx6lGLStgvb6QN+jWrPIBE0znl6UStvD3SLEXO8db9Q1SjZlES5Fc9D?=
 =?us-ascii?Q?RhPZ3WY9BEBLiK8wwnm4DexP62lAg4P6G0nCa93xjINaBJ6BO14SPOhG0ntJ?=
 =?us-ascii?Q?tMHJCNME4v1EdU2DUTxgyF9dlglYKoFVhCDG42LkpxCZ4CL5euBCEK+KxQUc?=
 =?us-ascii?Q?nX9jeTD4L41k8ipqrU8R6MSoyrPxy9OgXs6uAtF8cyXz1CWzZqNSAuHvHqaM?=
 =?us-ascii?Q?s1zynODJP31tjcZ2uqGF0K+F1ykuh4Fp6AIveIulZXVeaeIXSMzJC3zZ6ciG?=
 =?us-ascii?Q?9VTxrQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205b8d7a-6685-41d0-b310-08db8ce27e0d
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4834.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:41:01.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpJWa1peV3G/OhOPQWh1W5S5dxHn6E6UAgkeOk2Z3iBhSMgY5pOpfP41JnWfwhmaM42m70KzX4LqyIFEiGKveOAKjxzlttaHVjS0oMvampg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3759
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:11:52AM -0700, Tony Nguyen wrote:
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
> 
> Add tracepoints for the following events:
> - Add FDB entry
> - Delete FDB entry
> - Create bridge VLAN
> - Cleanup bridge VLAN
> - Link port to the bridge
> - Unlink port from the bridge
> 
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


