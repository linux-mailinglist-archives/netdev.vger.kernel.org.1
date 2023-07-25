Return-Path: <netdev+bounces-20717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5D5760C19
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386E62810F4
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBCAC2C7;
	Tue, 25 Jul 2023 07:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1619F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:40:25 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2107.outbound.protection.outlook.com [40.107.101.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7DE120
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoZqphaiF8P1qNjI/Igoio8UPA4BhXWqmnrpDjBnxvGr6Gj0dZAvdgBeLhs7gKBocZIstrbvygZS61z1h/C7zFOnhzuFQnYoRDKYYj7Maqi5/a0mH5/v+/Bg/O179znwqIlgrcTFrJrw5i9af/TmcructaoJOp4AuXvG+/OdSqfmnpQX95ZkwXBHng8X6RYVocg6CiMwU2wMCdvUep3eOMg/R2zUX+CPlbQqIIGy6AtTFqpUgs0TMIRrJXmAsyRJHxf3be3RS62yp02QeY8ShRP0pDBXEkA2r+CzJ10DPi6QbaDsGJhlzoqTV3srsPsYD7o/dd7zn6rwKFI/ik2jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLJVvcjQl6BSvBHpJZ3RWW/Avrj7Orklvr7wg+8AZdA=;
 b=X5jq8ezH+vHvO6YmkZk9a/UcADQPVe76A+l7wJvqaLRqjkUNa5D7tsUGIZ5OGbUCxKUN+uHDZDAUnHm1eyebLqNdGI1eUv22K0yZeSYvQ6p80jOOIjtK/ct/fhIeWssrfW+GB+KmJ4at1bTUr8S/LapLO4xpkOCTIn7HjXo7KzhKcy/STQQCErvlIKil0GFkprK4hyHbDkwCbEItgkYNGRYBWQxREvyICjeB1q1qwoLHEtI2uB+d+dXm4aSdY1ZUATInc14RXs87qq9Gg3Vl1z2w1k02RHHK2iLauf5U6obQ1QJpHVLZPmtQgM14Pp9E1YyVMhsCqrKRcNsrn5PKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLJVvcjQl6BSvBHpJZ3RWW/Avrj7Orklvr7wg+8AZdA=;
 b=N5kc1hWdShIyLFjgO0EzmUj3TZZDoUd5z3tM1j6immQrJ8lWVizX3UfU59nNuj1asFQwEpoqyC8k+EgDiIFYVCWdaoNPh2qXpAN6RoQAHdZ7wcrXLk0KQapQLTUlNOpsEvAgaOgGoShUvclqp1ercmB1hms16fB4HwlkFmAZES4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4834.namprd13.prod.outlook.com (2603:10b6:a03:36b::10)
 by MN2PR13MB3759.namprd13.prod.outlook.com (2603:10b6:208:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:40:21 +0000
Received: from BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1]) by BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:40:21 +0000
Date: Tue, 25 Jul 2023 09:40:13 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>, jiri@resnulli.us,
	ivecera@redhat.com, vladbu@nvidia.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next v2 07/12] ice: Switchdev FDB events support
Message-ID: <ZL98XUEm8Q6/wp5h@corigine.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
 <20230724161152.2177196-8-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724161152.2177196-8-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::20) To BY3PR13MB4834.namprd13.prod.outlook.com
 (2603:10b6:a03:36b::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4834:EE_|MN2PR13MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce1b7a5-be17-494c-6a53-08db8ce265ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xd2ZvGQmHpCHCFleuGGlwPItf4N8TnCzWBOs2l94ukSO228A2q3gjD42t1+s/7G/1/sGHAu+f+KtkgSADe8m7TBAq8qvfCP/pFVR9deS20dQBvjov655DHI6NV3lFxLWMw8LiCywai1kCHmd1DiUunnbSFYqA1kM8o3XaZ3S9HVdd5wbGEAoIGId0Qyuh++bkWmsmIVY4wK7suf9FmqBcGwpanBkr2aU63pNhRqb3chEqg1o1OU/LHfnrXfSD4Cv7HHqFrTMgR03HXq8WfHf+k+bhu0GWHCB1fUcWrnKfTJN9bJaJXXv9KScBfgSHlUN2jeXTCT8bhmgkpSpVcepMxG/i9X2LaORHA2C3qexzR1mZuKHzUCdghO2yd1jb9crAWlgJFhYL0YpY7QZvaN7RLft8pxkY0Rsl8c+y4DE2BiA3H3l0/lLyFlVhijcPmLvLik6O4DiS1pkv2qtP2DTn8r9adYfDazE5KBfZ7SYuNHBFju+jn2jqtrCiiwP1LWKr72oSLglEZSIrsQKm4TWZBxSl8GbrUVdggy83PgfmxVahOATbsiD3rEZqIztZ7mGLYKxe8WOoSl6kRDWGwiuh7A539o5rVk3yzKhNEzbY3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4834.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(451199021)(38100700002)(6666004)(6512007)(478600001)(6486002)(54906003)(41300700001)(2616005)(5660300002)(8676002)(316002)(66556008)(66476007)(6916009)(66946007)(8936002)(4326008)(186003)(6506007)(86362001)(7416002)(44832011)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VeP5EzgNEg/M8N03WoVu8INgrP5vIwYxJSihIF7PHETiZfTL5fbP1J2gxp0R?=
 =?us-ascii?Q?oU67Ad6kmyTAtCOFI1CDx+ED4G+olzywIJLZW6QJ5RY94igJp87N/uPr9qy0?=
 =?us-ascii?Q?gu4XfIrH7tz59yylEkWPT9Z6B74hJVPHak3tgEqp9HzIbjqH8TxoFMDhKts1?=
 =?us-ascii?Q?ZRgdj+mdCSi1QDFW/hrXbsoN31U8jSVXnl2DJu1pP1JYbxlNti/8jZOYSqZM?=
 =?us-ascii?Q?YB+PfqyhXbxuHHlbgm2Zwo+v8eqQeAMHJHEeEU5Acrhcfm8lg2v6WjkoPk5j?=
 =?us-ascii?Q?/T6L0tlpzcMTaj+YX13NbUHZ19Zh11ZSdSNugC/Sp4ErTkxrIYx6lwevea2m?=
 =?us-ascii?Q?RMEGSooD91H1v2ro18RwaVT4wkHlyvhHKnZZvKtmw5YXarccT8ZoMWwiQU73?=
 =?us-ascii?Q?pnJgntkER1zkS/05ZEqZ4d8zjlz2vd7wrhOOsFNcFi9E6ucIS22GPZpCm3ur?=
 =?us-ascii?Q?KM4YTHR8pfhWPShdggraXCxY1vzLXi8q1niFZPZ5Nyz9vofORltzR0qSCHwE?=
 =?us-ascii?Q?s0sgubfjR1wet3+wp3yTdrKObfOR1j5W5zZlHuz5cuO2yUFGJX3riC7gyJve?=
 =?us-ascii?Q?jk3n+CqKr2X9i0VYN5EsJCDwDUGbdKpUQNdDPHAVVGJCMs3gsQL5am2Ph1fE?=
 =?us-ascii?Q?F8rulYOels8kdZ2y1Zxglou+tmg1WHJ3V0cU33yawNmLM2L3KPK94S2DU2jm?=
 =?us-ascii?Q?gZB4UXzSL0lT7oZ0bPvkW9G5PKfSbVoJEtjCgtjF/JstYtyh8AqMVk/qJhTe?=
 =?us-ascii?Q?aJxoRFG/1PHsGRJfin3J2GtuQYv7MuKdcFW44ycToHm9mBTr1ZWovH2Yooz1?=
 =?us-ascii?Q?h8ybP0/L2J9rELZDxJIfO4nEstQahNLijpHisg/kl2lOvjvJfqcFljTQrF36?=
 =?us-ascii?Q?SFh8qy71jK+yvGN+lj9zRseUlH8vFi/oha4b313rsZ6ugslpEIiwLkpAbDm7?=
 =?us-ascii?Q?vNZIWZBTjMa8/K7G+2K0uCc3Xhim/jhHtQ6wrqvslCP21w8EBqOcGlDRYQP9?=
 =?us-ascii?Q?Gheo7A4UfvAn5MgPKKuMoqTW5P/eZUSwrWQj28Njz4rJFf80lTutCatyPnYY?=
 =?us-ascii?Q?0Mzq08vTEBgBve/uO4SqI4jgf3Ws2UPxHQTvrHFJRsKoDtARdNoeu4ANh0Of?=
 =?us-ascii?Q?q0nMKJG1V/20wmpZqNnH50NHEcq+lMlxkvT+Cc2+41USR2zuPVCJQ7M8wGq+?=
 =?us-ascii?Q?1mCndoME5WHnXOqOcB9rRK96pJKi6J4gTyaNsxgQuZeZYt1GH+Ian3046bqM?=
 =?us-ascii?Q?dQrYGd9ridRuodSMMbXKLN4R1iqdlHZXtASqvSG4Mp7OgguBhApyNhQAgAXB?=
 =?us-ascii?Q?MRqaJrys+w2Frx83e1s9mPhsQFOuqp5CBP3Aa1VmSswsF3M8UoM6EpcFBFrg?=
 =?us-ascii?Q?yrGZQ6RnfBhAVD1x1vRnDAN+0vE84OR0lEzReAx1fUBoaYF/ncSULWtlKbKz?=
 =?us-ascii?Q?lFWF2D+oYapt+9D/ly+hG11rCopTMsBUoxstOmGImq7Sxq4qY19m/fg6qmzh?=
 =?us-ascii?Q?+xyH5qB1ul8Lcu4UIfFfcHaZ5Id47PvHV9p735JVaa+/Xf7VgDocLTIKxVNo?=
 =?us-ascii?Q?p4BISzpmKIDhGJEvdb6DegEQWkPO4eqRFPZ3BMvt+og+J26Aut3z68b75oaS?=
 =?us-ascii?Q?mx2Ea/Xtkg1WhGg566Rp1vv9EzVuxQm01Twv/N/JOE5+K/QvpSxnEYvpUIO+?=
 =?us-ascii?Q?lIg4VA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce1b7a5-be17-494c-6a53-08db8ce265ce
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4834.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:40:21.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZNxYSL5xZCXR7bge6DYX6aNrB2Q1BhbZ3iKbGQ+F5bc/zbdeOY3TMlzP6dsoH+EAG0g4sGpiipd3UqYj5EpknO+BPs499vraazst1Dl5Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3759
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:11:47AM -0700, Tony Nguyen wrote:
> From: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Listen for SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events while in switchdev
> mode. Accept these events on both uplink and VF PR ports. Add HW
> rules in newly created workqueue. FDB entries are stored in rhashtable
> for lookup when removing the entry and in the list for cleanup
> purpose. Direction of the HW rule depends on the type of the ports
> on which the FDB event was received:
> 
> ICE_ESWITCH_BR_UPLINK_PORT:
> TX rule that forwards the packet to the LAN (egress).
> 
> ICE_ESWITCH_BR_VF_REPR_PORT:
> RX rule that forwards the packet to the VF associated
> with the port representor.
> 
> In both cases the rule matches on the dst mac address.
> All the FDB entries are stored in the bridge structure.
> When the port is removed all the FDB entries associated with
> this port are removed as well. This is achieved thanks to the reference
> to the port that FDB entry holds.
> 
> In the fwd rule we use only one lookup type (MAC address)
> but lkups_cnt variable is already introduced because
> we will have more lookups in the subsequent patches.
> 
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


