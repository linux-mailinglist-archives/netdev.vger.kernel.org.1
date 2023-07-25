Return-Path: <netdev+bounces-20715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F1760C16
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B1D1C20D35
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C09457;
	Tue, 25 Jul 2023 07:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4548F6C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:39:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2114.outbound.protection.outlook.com [40.107.101.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54393C3E
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKXmXrAXjnfMYUf8FkxzPY5kj1eQMQ25hWj2glWqAqFBw8KMGPtpVDlHResflfxdNBi3uK3Ajm55pHrBCf9W97k46RQmZCeCORFRTf91WqgwSMswTCUae4eHun3Uzv7WMRqusVFxXGk4DW43AGoM/uPSRXq+1SUd/H0iGAAYePpGAykmIYB6tAg/MjHf5Bb2NAGNDMx4OAYVH483sQBxrlQ0hrvpNw+loSaYuYsx92FqmAxgLrbD4A7JiQqMg8dVwZrHuOgC9LJdmiAsolWnmPN/NBHh2PB3RcYnKMuEXTXBYAqEuQOIxu/2UFgGouNgqEuSaD7OGgbP3pBp/WIBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gpaiVhZMjSbjKtrg/Smv7CKnF3WaDvUpluNVIaHCfo=;
 b=FvLl///FYrk5Ht1bLAFgYrzFDZKvH9US+Q0vBRpAVJoF6Tw4FC9kmCMe/lD5zHyw+eDLZBLTvsA4iytfjNe66i1pakEWyGoJGE2YaPfwJEA0umOOk9BbOjNupm15HPzxrkdPhlsdwjfcKWgUXUy+fD/ldI+cpZHXGJhav56vJz5oNVmd6Bdu3vnJg98ifAGIhyke6O+K4VApWJuZm4hDL4StzfklHK7BBWOc8xAcCtf07CSZWv6q1pWbh9ot8QwEod5RJOiHz1KygXgRhdul7quYXVVr/+7CKUtOW1BAV3P/WoDqmjuxRLrvcYhHQoiqRRxXI1JV9mPhSmFPRgiN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gpaiVhZMjSbjKtrg/Smv7CKnF3WaDvUpluNVIaHCfo=;
 b=lmUUohDHs1RLU1E4Kt1hgfn3Ae3rE3CBj5OE9NLFHYNmBnimv2s5aZWp1lR2jGLn+pb+g19xRK1eXXqOmmMwalLbkEJSiWQzTAeNds0ysHaTt3u713Y/D/8spn119vqG8mjtko7QBfKIvabx7Mo+tbnulO9l4FR1clZvV0swPqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BY3PR13MB4834.namprd13.prod.outlook.com (2603:10b6:a03:36b::10)
 by MN2PR13MB3759.namprd13.prod.outlook.com (2603:10b6:208:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:39:23 +0000
Received: from BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1]) by BY3PR13MB4834.namprd13.prod.outlook.com
 ([fe80::a719:a383:c4a8:f6f1%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:39:22 +0000
Date: Tue, 25 Jul 2023 09:38:45 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>, jiri@resnulli.us,
	ivecera@redhat.com, vladbu@nvidia.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next v2 09/12] ice: Add VLAN FDB support in switchdev
 mode
Message-ID: <ZL98BfI1BAtmU/CM@corigine.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
 <20230724161152.2177196-10-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724161152.2177196-10-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM4PR0302CA0013.eurprd03.prod.outlook.com
 (2603:10a6:205:2::26) To BY3PR13MB4834.namprd13.prod.outlook.com
 (2603:10b6:a03:36b::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR13MB4834:EE_|MN2PR13MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: b228719c-2b97-4105-914c-08db8ce23172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5s8pvGFA6M0Jhz+tGzZ9Mi3Zq+ykI598XptpOQ2ocGNHuN+A+Sxk9O6BMAVVYtbIx7ZUg1P/JjZSGPl2NvZhgYGrWXB4+Fw9I9VfpnlmIor8IC8+8nK1Gw6ZMB2hnNogBGiE728kTtrxGey7S2Dl42uff04ETW0wCxHd6Aj0XZMjSZcNP5S+YUAW/el0Mbkh0SNHaeJ2Q+i0Yeesx2JHyOJbU1M1NS+Fmt0IK4eVJrduNzFByx9OHWFbAZQYJKNGi9khi+pULvdU8gEkb7kt+eO2r+KsyqH6hqAiztxjPiFjOCu9zD1h2hyZOF+MVhcSOo3BuXjOqFd+qtRpBSB6CBF9myOCvfxa+XGOZwQ5jzeXMp2jo9NDJpOp+X/aU9IfsMSS4DH3NlC6ad0nbkn0t9CWLHxVoBIgV1FPgbGr33RPWiAlwCWk/lmav8f0dedrUwvibvsIsvon9DhGnwRLjLwMWXuhZTNUv9fKNWrrs+dVto0Fc9FRCPIyb1oDgIafeCBtPSJpzoNzFir5rl0u7zNuhgQUGKOlzkNlDmUlDzd/SjrodezIkdC/SeDmcKqxTaI3Pt57+QO9P9+b7QhdiuTatuEXXSluoKYBMqmaBzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR13MB4834.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(451199021)(38100700002)(6666004)(6512007)(478600001)(6486002)(54906003)(41300700001)(2616005)(5660300002)(8676002)(316002)(66556008)(66476007)(6916009)(66946007)(8936002)(4326008)(186003)(83380400001)(6506007)(86362001)(7416002)(44832011)(4744005)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBXEn1FXQgP83EsKpdsjF28WDYtkZPMcE8+Ow0bHOU+U0BpjKMPel1Vb3RM0?=
 =?us-ascii?Q?PC+hqayhYC3D5Mk4a1C47VMrA6kItEAeqOglfI20aDl+bZchpQANjg2MRaYE?=
 =?us-ascii?Q?g79OPQZuqaAjUzEyo1hLwhNBZ5YDXcrOqz1A91BZsCG3qtol1Hx0SfjsWuY9?=
 =?us-ascii?Q?CLqjA/+RUDTmBX8dNdkuNnHdowcdxY/YbffMAx6zfU4KlTBMq11M8/iz2PPF?=
 =?us-ascii?Q?s5b8IVhOc3YXx9dV4J9k5InCh9GjXQCrJRjGiwesYUfv8RrVF0mEgHIDqtEb?=
 =?us-ascii?Q?3YWBTiNdm7jSp8sbyzluHoEqpr7rn7v157ceUytwuhWoKyEy7A2qclcqNDXY?=
 =?us-ascii?Q?Szlr8CDVQSia30dvhYSZqTTHXOx7ZZ+du+RGiHqPBj56XmDsFQ2gLFWBxzRy?=
 =?us-ascii?Q?AR+iT8HHIUSCNLa97/1BWG9uJ5rBdnJ3h0lV9mx+IA4gi5KX0s9BO8/APCZQ?=
 =?us-ascii?Q?1o9cPcox1Iy1CteudDGub/3s3zMF87e9ERajxvyxNMEfIcmh0JHDr4fkPRmc?=
 =?us-ascii?Q?FOtcF3ShREnqIXnZTf5U9PW7v46gQhyo6RzmxXfnrsb2fSFuB2I7aXL2620X?=
 =?us-ascii?Q?ZuT4RhZcBiA32Oyc44A7bmFvslaDL0TS+tFUBSdmHz5bqmU9tj6hx895i5KB?=
 =?us-ascii?Q?AUe3PZbZgbKFWCNbgrrjOTwCPgm/p8u71D2yCnb5hD7UOev9U5p++zlaP/BI?=
 =?us-ascii?Q?n1rhwFKcaNkE2/WSZjiXCe817fbClASvtOilrGPojATYNmdgHfHdTR9b81T/?=
 =?us-ascii?Q?+jLLFVWIEUd25/lx3wlGyC99IsFfDXY5ZZ8g86l9vH06A4b4/WF4L5rSgUHv?=
 =?us-ascii?Q?VM11CdteNsWKYlk7to7CYPRrokeJA3HkAkA1EFqByocz0U8jtUoOGrmnMC7C?=
 =?us-ascii?Q?VILJEvcZNIOzNAW9ICWq2aIkZhBYCewzwz7YOocyjRGlbb3jJuAqPDqHb7eO?=
 =?us-ascii?Q?CfZ3hDAiH4SCEIfYhbXsxUaa+PgthH/5TZgv9ucjTS+vqk+0s2ZIdvDpvdhU?=
 =?us-ascii?Q?OREA7AlNEocWrjb3/i5ew7Kw+oedREPEc8jSsCmKXSPZ9beK8Z3AkXHfg3Qd?=
 =?us-ascii?Q?atGy72rxz9Yum4++nLSb5yeXa/ko4n4Cj2S8uvsd8zJSVRPE7bVgzDhj7HSa?=
 =?us-ascii?Q?BNEm8APS1Zzd+xFsbTdJ0YqU480nhFkVUzCZKKTM3PLEYzTqqg4gFcbqCWLr?=
 =?us-ascii?Q?zP6VgCXvWvthWWijRY3WiRJ1N5ILevwJf8+slTHUmkVvPXsdlMwGXR8Xwz4h?=
 =?us-ascii?Q?/o7vOWzSFzrIGOVeK9xPDyIEM5DPZYkZlM2VR30/XV9P6hz3L+hzdPT63lYn?=
 =?us-ascii?Q?YpwQuOK+eV+DBrc8/9IM0Ej5zar82OsjV7joH/AOQbv3+K3n5a02ay3QftSd?=
 =?us-ascii?Q?NtMBlqrQB7Kz1IeBRC38xc7ItJOhYkFN29mnDKXD0S14+OXwXTYsirbUNybA?=
 =?us-ascii?Q?E/gruGA01w8tDkAh45B6iKK/h8e21EpLoa2kfvrANg/jbOfUGcvufG9PcQcR?=
 =?us-ascii?Q?Kp8H1bNwQvGuHU+ca/GtDq4GtOhiuudNt0zwc4ApNBsBCaJttxEzLLGBYyPo?=
 =?us-ascii?Q?0PE+gSeFAJT/Eqn4qMUVTrV4dpCV8lKvKI47Jj4G7IWFWUTOa53pp9aq3nf9?=
 =?us-ascii?Q?jL7oHssGjVoI4gaYHAHlrHqFCRnxEeySHhPZ4RKj/6S5Ku03OX+smu/GezSF?=
 =?us-ascii?Q?6GSNqQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b228719c-2b97-4105-914c-08db8ce23172
X-MS-Exchange-CrossTenant-AuthSource: BY3PR13MB4834.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:39:22.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRoGLMQZfDk1WQtPX1RgzK8ZL3M40+mK7RokMw4kG9MOQK9qxZ/8sFW0PtKkxoXswYUBez83Yv1HIAjQrEF48E3fTw/+Vu52CJtcRDCGLao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3759
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:11:49AM -0700, Tony Nguyen wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> Add support for matching on VLAN tag in bridge offloads.
> Currently only trunk mode is supported.
> 
> To enable VLAN filtering (existing FDB entries will be deleted):
> ip link set $BR type bridge vlan_filtering 1
> 
> To add VLANs to bridge in trunk mode:
> bridge vlan add dev $PF1 vid 110-111
> bridge vlan add dev $VF1_PR vid 110-111
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


