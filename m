Return-Path: <netdev+bounces-17159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3A7509EF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60C928174F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302212AB5C;
	Wed, 12 Jul 2023 13:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FC2AB27
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:47:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527BE4D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abjs2RA3yXv+9RZvVjRB/6bDMSj4FJiE1ic7xcYV0+advrLGU7cGEl/Igsj+AXmLXxfFj79wLwx47AI4JYdExuP5mecfdOJQndpasqF7cQBkZncCYjx/PIfgvKKSq7P7wvHQTpoYlABtq2yxYq/yF6cJy1wgK8UwTibSdRh6PPVR5B2CHR4DP8ydcrR9sFqucA5S4YP4Mx2wYFSJkFaVzNsLVfGnf5R0kDDpjdauNBfiw5lCWSyY2tMQKbo8xVxp0aLIZMdiouyVJMF6sNTtCFUkQFwzmBVUQx6mceVO7i0csdxorvvXQM5nmP6UmuhZo+KHVriS+7STqQLgLqmQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNyjajrbvLFtDV4SxADmFnA/WP2sga+ljrHcAV6nchk=;
 b=SgpEU7m+FjL0GYDnuEpI/VRi/DMA6BDK4FAs40VMFfw9Y63H5Nrc98ygraV+EKC2eQfvHHh6+HcznhnG5pus9Xti8kwJWnucu5iBvUdR22pKfTLCiRDUHJA9kn00QDXtP/6tilvErkPNHo26S7SAIHCoXOUuAC7G+R4NZLhGv87z8TyzDygOfe+xkd/pWZ30YDUqJc5AK7OqsmqC1xwjzpYmjyFEwHeCrls822osxvZzoz95IcsImxgX/uJ1JEDqGJIpjBQCUrHjApnQS8K4k4MA+JljIBfrHOIyky9IQBYFag5c1acB/BJinhlhfniemZkKm6IsohFswdi/aYtE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNyjajrbvLFtDV4SxADmFnA/WP2sga+ljrHcAV6nchk=;
 b=J+GnLg+eUpqzcW0P6ehYduaDesqmcJpF8lRjqJSzr8auXOKtEzrSQbTDregM5EOWBdXhFaL43rW5lAksVK0NEHDDSdfF2+i+z4aOZ5ttQ0MkqMG6GBZYYYZvYacZtnMPkKdqk1rtW3RxLF8vQoRJZABhvzsgGCMihuiSAO0lNK2LhV2v69mHI9xAFBf54T55ZUEYQRMP/9CX0YFzrj3kFUCvkEfSCYP8AtYGGlAlJdFacH/rB6Z7PTDP56t7JALONJ/udfE5SBLzdm/P1m09zx8f8cms061SXEJ81coNEKSM97utFJMpgLdB/RRPfqxIaZe22l9WQZh4ac29hq5Oew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 13:47:36 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::3aad:bfe2:42fb:705f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::3aad:bfe2:42fb:705f%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:47:36 +0000
Date: Wed, 12 Jul 2023 16:47:29 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next] devlink: remove reload failed checks in params
 get/set callbacks
Message-ID: <ZK6u8UFXjyD+a9R0@shredder>
References: <20230712113710.2520129-1-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712113710.2520129-1-jiri@resnulli.us>
X-ClientProxiedBy: MR2P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::10) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d13d7d-2a0e-4c56-ce46-08db82de8c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsJ6n+n1S0ODFXwmQHWvnYmLupqrRN5QH4xM3gCDzaHvf59on5OFu6bAlpeeEDk/3gBfub0vLSDoPLEIjd6jG3Ah+Vk/ZCtVe2LOsc2+Dqb+DdVOmjIyXSZDQWY/WIuBaAOj4TOKFGPDFmZLg26AKOtcmLsfsSf9FR8nx2Db6G0Y8wCUjiaYieQR4fluPSHJ62NdS3e6C8SEl6kzg4W8HIDNYvDp7ABXSmWbCkqCuqr8ErAXpvLY4rxge+fQ2tAOqy8ooa07XACDxnZybEeOXXbKxe5ALi+ey+VgNQjTD0KTvyh9hjmNngTBT4R4y5GrRfq9AZfCVTsTBs9wKIiuqW+r8bN/GLnMAQTb0M6oZmEOEbYpDAsXDV0kNHE46SCRvXOGaima2YzfjkgjOetKDodBzMDbsg6yHmNlnJ4g8azVGeNAn3rP3fr3jMTEG0OijjIGB0HqpMUzdoChLxcB7TGmPFnh/w3vCc0QeVNB8eIVTaZAibulnJ+dI0hg4ua5OMA4kjCUxnZmHp173Bb01CWBOe4GycOM95z64/9vbMR702udhmg5ThljE9Xr6rdpMKmfx324L91u7bAVAur6MQt0+h6euelTHWBoDtUPt5g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(6666004)(478600001)(6486002)(186003)(6506007)(107886003)(9686003)(6512007)(2906002)(33716001)(66946007)(41300700001)(5660300002)(66476007)(26005)(316002)(4326008)(8936002)(66556008)(6916009)(38100700002)(8676002)(86362001)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D0U/OeKntrBoKD5MFNpx/iaycvV2jByQMitaH98NQIVxLpfS6o+7CTzV2QST?=
 =?us-ascii?Q?WmeEhxAc+Ppx+NEg4YjZSYnaSvhWnQOV6sqnOYn+KzwwoAtx99XDk+0tmZZ+?=
 =?us-ascii?Q?I5N9qzeYYf1YU9reNsGc9vcN0dUBDJRmOayz6KpOi8o1uObhXsJnNBp5Ju3i?=
 =?us-ascii?Q?HFGGl6TgOY0FsvuFNgezCYDuiTWPhESjIgelWtzdH7WBSfv5MSGnktfh/pf2?=
 =?us-ascii?Q?F896DJOz4sELkAfCq08cpNXe+li6G97DwTDM3kCDZfm2tzQShR75n7upSBg4?=
 =?us-ascii?Q?NxenEyB+d6MLJxRja9ETyrFJIUlZZoQLSnox9eipXZHk/TZV1k2VIBpETeeZ?=
 =?us-ascii?Q?zYTqlZDl3BQKPUOcejyVJ0LHSqlPIR41zdGP7gF9/WEE1BjeABVn5K6iDOAd?=
 =?us-ascii?Q?k2VcBAiSjX0a4WY+PBQhXrPfRtq+Z5GRYhuwbBGf0yHYdZY5nipsRtK1ZKBe?=
 =?us-ascii?Q?e+yZV+vCyX2jih62E1VqznQq0fj2PynsPG5LPR2iDTnNIXQmwQVfUtRDtl8T?=
 =?us-ascii?Q?Ibg6Pl095L4to0a7POrehq+bmvYhn2H7+f+p0kztOuxsxxFQVELkULZbigY+?=
 =?us-ascii?Q?RtjSGjJLZlV3MxHTcAR3/yzzkMVJ8AIwB9g9dl67fCZcYpnSvKa0DMTdX7uJ?=
 =?us-ascii?Q?/oOYQzzhpUWR94awt0As51h93aKJLNscOm2c0oGS1UTcWzQBlWYiWFNIEid4?=
 =?us-ascii?Q?z38y1EW9HZ6P7faHfyJVrw3gtpQ2fvFK+hRgDlia6/H2jzG+8Ldw5diIMnj0?=
 =?us-ascii?Q?CSQLSXYaJUOqmx50JtaTqsk9uStdNgJmZWSkINAHvodSKmNhYM4Dn6f3YDIU?=
 =?us-ascii?Q?tNQWXkWPREnkLfWxLdCaR963VQWid8/ztPVMukydNsx0b9aXsX2ovJuV2sWv?=
 =?us-ascii?Q?qAIqh3RN2+RGdoBbtokQ0KCWt+72c6zP6BTSPT4mVsOmsXLjx1IFgH/zk1El?=
 =?us-ascii?Q?Jyjx4BkOBv90WCPbz1J8x5CF8R+8P84IltkMKmk/sFbsAWGg2U7lKUFyitrr?=
 =?us-ascii?Q?pSDZaVlKiOf9FsBCq1v61M1i7FB2z3WzAc5t46WyBCBVZr1NdwRnNMeNvT7b?=
 =?us-ascii?Q?rLfBGT9SYVldvaU5KPy8badoePZH5LldTAit17wPXbaGiENkgd7nS4vavoi0?=
 =?us-ascii?Q?w5eYZJQy/kTvs0J+3X5ZlZMkzJodzc40M+zVBO15JtNcZvh5Ellql701tBOO?=
 =?us-ascii?Q?h/zK4WC5LbBg42aA9NxUQnCVrZxA2+XCCwf/nFD9pIcqewCV9hwxgURojtWQ?=
 =?us-ascii?Q?akNPmX7LGOTWWpUpB9jB4Cjh+IfYSWRRFpb2lnxWliIdxPKFq01rszFh9WsN?=
 =?us-ascii?Q?lsg4+tRXIv/DpzH9Ln7wdLSD7wDvPF1N8fslltYNkrLOkpiuLlpA/nb6j0Ej?=
 =?us-ascii?Q?tKTz9dF4Z6BMxQlKD9V3oVdsRu0d+HKfQ1Cib56ajyfKmhUk6NxB3DUyeQJc?=
 =?us-ascii?Q?PMNKUajt1fymed3JRJ31ON7m9x1/DDFyTg+3Vb4u1LRAWLvn9Q9c2VpmA46S?=
 =?us-ascii?Q?jbvP4B6oR1IX+UvJLEesynaYQM7wJdEb3jPCydS0CO6n72w3UwIx0Cqujoou?=
 =?us-ascii?Q?Zk/AD0t5JeBpV9isMQOk2PvJ+QEDyA51lwaWCOfP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d13d7d-2a0e-4c56-ce46-08db82de8c9a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:47:35.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9RLlQyGeO/C+1BMCV1bq5kY6F9WtPgJOj0LOFMluU8H0yLEygetzni6aLhTJC2K31LEXtna6lFOR+qnwo4RIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 01:37:10PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The checks in question were introduced by
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> 
> Back then, it was a possible fix. Alternative way to fix this was to
> make sure drivers register/unregister params in the code where it is
> ensured that the data accessed by params callbacks are available.
> But that was problematic as the list of params wes static durint

s/wes/was/
s/durint/during/

> devlink instance being registered.
> 
> Eventually this limitation was lifted and also the alternative fix
> (which also fixed another issue) was done for mlxsw by
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> The checks are no longer relevant, each driver should make sure to
> register/unregister params alongside with the data it touches. Remove
> the checks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I don't see how we can hit the issue after 74cbc3c03c82 and any driver
that suffers from this issue should have already seen it after
7d7e9169a3ec, so this patch looks reasonable to me.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

