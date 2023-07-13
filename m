Return-Path: <netdev+bounces-17499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86185751D05
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8554F1C211C3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677E0FBE1;
	Thu, 13 Jul 2023 09:18:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C23F9DA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:18:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2121.outbound.protection.outlook.com [40.107.244.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEEACF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:18:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxkyxxOgakDUEKhhqF2liNs/Zc4i0jMTcAtjSilMEJsM+iVRyPW0qgQTaOQWfEam/DAj9duj0UeOS6EnAUmimKQU9u28QQFfAdlQxJn5BRHD62LBrjhOtE/156Ek5mL9wfQzY8owyqJfNBcEQfbdwpvYWfD0F+NzILUvP/zcBH30IC6XH7DjQ7RnfEwBvMbp1tXccN+6O2m76Sm6SHg6MD9BmBjqobCErqgqdt9P+IqdNMIj5O+V61UqClG0mvBcPkzM407RdIJRftVEhCQ/ecYs89NTgBGhGiAsCO1dgBNDqTbmWPogFfgxFOx8R2Lcy0X2TUtfIXSUhdgtiZOYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPf/H0oTQMGS7AMh7Gw+B+lJVjbDWF5i7UG0NY58aqo=;
 b=kPGn7uPCZssQEnmR+5Ris6TYBZz0DPFVVPdHjlQfu8sR/EMVd7cZLmquNZ82q5EWIOLaCLjRQRDkQps5ubniDhJWNZcNE90tm6ddBWQoSD1g+RODkgd88ubJfN0ZGBRsZsaLRit2reN5bb5KSbLE7D3IejXYhRJF8b8eEWdzwQFyoW3yJonrn1cqmVN1CQJktDPrhdDCeYLKBTaFdBdaqQsRqAiNQDMvh6FYg3HDLP8SOOZdrQADWc98zj9CSQfcaBJ3+PGeN6D/SNu4c1f6C2hwREAySXEkmbti07qgB46pnagmy5pnFhDJrojAvhFs3WVPSypf1joUIM9FdAcdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPf/H0oTQMGS7AMh7Gw+B+lJVjbDWF5i7UG0NY58aqo=;
 b=hfbjdWTHvXP2DsGXdM1DslY40P0VqBM6N6PmxFXouVHs/6rVMDyEzXkmvoQXLScYmb1qdc0KtfTSRH3xQfULuEtruI8GWnJSqfv+ucB4lAp+7vaYKSqGKeNIKsODY9rBCmqSV+XPmtR80akSZHQ4T5kqaszg8oKYjcsQ8rsubg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 09:18:27 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:18:27 +0000
Date: Thu, 13 Jul 2023 10:18:20 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 5/5] net: sched: cls_flower: Undo
 tcf_bind_filter in case of an error
Message-ID: <ZK/BXA/bFW9YbrY/@corigine.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
 <20230712211313.545268-6-victor@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712211313.545268-6-victor@mojatatu.com>
X-ClientProxiedBy: LO2P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::35) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: b4efe2f5-274e-4fc8-33b7-08db83821dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gsaDiAprhE8PWA9N6DB9xNA9huTZGpNSWr5uL1e2HcHbTe2c9oaIbBNjISWdpKfMmBeGAGyA7frXuERN/FYwfU4jmNLpFSjf02ULAHt0TNMKSIJeihE/U0vpan7Osgq9HtD2BUu4ckysvMZFIsSyW0K/4W4kaQy+aqR9pHbJ1p6cEoZ1mO+SGVDZ4RYLuaDQEN8XdkrQViq9HNFR78uEKl+Pgmcx+oPEbO66TzugBZCUUKSETgZM9cZB45Zqd0ykA7Dh7WgECBzJ7Paej6loeh/V1pmlTAhXBiV1PVJBYFRk5FMkI+ePVvvBiaFDhBdcZ3Rf6rscmPDZscHovxZbXvZD1O47sSbRQM3udaAd1bpG4eBt90bCXRsgEVhD0uhI2ov4L6NDTGy0Zph93v2H949DUCX3aJMMTLixid0CTTu/RNPO+wYQMsaZgur1Plw8AgDJebDfej6e4N8jiDSPwzwX5ojWNCYCVNW+4sSao3QnwzwgJZW4dNMD8/53+vP+GgFEN5p/+Qqgapfhc+0aFuKB2atHg7uZvV46DhjebzDuPdHAObBKEmcKY+nvXjFWRM7jydTajWHAoIQUs5Rw/bsd/fo0/QNBzyLK1rNSj9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(451199021)(478600001)(6666004)(6486002)(6506007)(186003)(26005)(6512007)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(38100700002)(8676002)(4744005)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GRArqF+BYhEoQ6o+0lY1zwwWpfdFM4r6fF0J8TnGgV9MKuaT2Vhqi2i7l4RR?=
 =?us-ascii?Q?dZpzMUWTWEC0rMrKlcSxyelk6IeKXA4j0oF8OkFaFd9C9usVsdnMbYxrwwe6?=
 =?us-ascii?Q?aPkutZQeAl0dVqi2G6XDsblXh8DqhuvI08UbmoFOAjRKNS+kQ6OeZKv/a3tY?=
 =?us-ascii?Q?GlxdewoVL3BFd0TLQS29L+MiWxEPe0sr329njy97G57/jo+sz79UCb3IAmlA?=
 =?us-ascii?Q?toqhrgMIXwlyjgM1PbzrDgkFLgo36TH+v2aubSYCVTs+sLNyOJkicx9xja+I?=
 =?us-ascii?Q?kAKjV3CTbJSBkjtdM3dMTg4cIDytmBbA4O9nyK/60ZoWfkTVvtPp8alYni8R?=
 =?us-ascii?Q?xaX49mgjSt7cRKmv762GdFrFGxp8H5+kW0DiccPJgPhdFiPERziUkGXb7lK+?=
 =?us-ascii?Q?vptr8No3DR0yCdDogo9iBnzt7a3eNtQGMjGondUC3VfzxZJJBv7nqxZk5/cq?=
 =?us-ascii?Q?PiWjhW+fGjhOcwDJ1k0fLDQwcbUgncaMNa09abNhNoBXX6dMHtM9xnddpjjx?=
 =?us-ascii?Q?t+brE+++UbgITT5uR3cDZ6/UZMtMOLekW8+rU7kI4J0CAuNN4TYj+THo4iIZ?=
 =?us-ascii?Q?3jvyW4oiBBNiOMvaSO0NDlCC1bjL9mEknLfcf++I3f4haPs3tsnMykYoSAW+?=
 =?us-ascii?Q?hmkNISbd/oSv4C6CDMwPKzNmlrtl1t1ZUtvbCB16F1MLIgRCyc4TFAEImkdF?=
 =?us-ascii?Q?A4fZ1BHm2nnLPCvmHC/RT1SAzb0sNMQH+092ZcOk5w1psj8ChqctY3FDg6tp?=
 =?us-ascii?Q?YOmSnlrk860SIrFSe46PyZCII5nV1K12x1uD//lUZsGhAAACa6aBXlZlGnvY?=
 =?us-ascii?Q?zQ7vjhKkSOcrKNxrnja/M+LAQnwabGkeDuahnsIUq2dCQlFbx8mliMFGP192?=
 =?us-ascii?Q?MTpueGTTxCSYtSrPBMfI++6VRuN2ZB2o3EATtjjU9bEK0PYhOIQwmq59ydXY?=
 =?us-ascii?Q?75I4Pk/Aufm3qtArTNoa9fZT05t/jCi1dHBmM/pXcMRsQaV3KNTwbPW5rpuL?=
 =?us-ascii?Q?/iffOqMNoT+mCvhPN3dlAatgXTnp2GSh6iCJxqyrwHBNiaFzFab4D2amDr71?=
 =?us-ascii?Q?O2EcF9fx8KqbNbEGQ4KElHqOvIQikFR1FpmrAAk1Vq/WXBJiFr9stxRdUKKe?=
 =?us-ascii?Q?044vA2qhDLMW9kpZMd4hZEWUrQ+Rw4TdffCfYYDepA1E1yuDwCiCios9pBD3?=
 =?us-ascii?Q?eri2kSa3PLgVJJd1FQ99OCoEVHFiP9kYJhCZTJnsHuGkfVLawZXAvKkZSj4p?=
 =?us-ascii?Q?9sEPXJqMtHbIkATP3Rgp0tt1kSFB3IK0/kgCFgOV9i5gGIPbK9XRFo2N43XE?=
 =?us-ascii?Q?Y92Mtj3SGDa1hRWZwSBNzsWIbR4rbYEdPQqgoJ9erizZcRB5h/JE+u8NXHiH?=
 =?us-ascii?Q?GfcYSUbdoMLReL2QkZ/9DhK+/1MYnc/+FvyAkXXCcohsYAWY4uc8MovHnsk0?=
 =?us-ascii?Q?hvBLs2bvqteJKU4eBugSmp+gpYddevCc51lGyly38tBBzLZek8PW8VdGsAeZ?=
 =?us-ascii?Q?SgeGYKCROlgnOhAOhdPRbE4Q2jwo2Uu8yoXf4s5CgGpAGT9BQ+4Np0C1NMSG?=
 =?us-ascii?Q?TkDMgy/AJ6GfCGfVNy8JYrwuKq79kKEJ/XEpXDOdYkUrKQYj4344wqHeVjQT?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4efe2f5-274e-4fc8-33b7-08db83821dbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:18:27.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFU9I9hEB294hNRX+Skszzmw+RiBOKTNnu8pU7RuFTxGK5S8Wl17SdbQ40SZ6/ESl22W2yT8V7JNRmnhcz1RhPCSZvVSMTI9F2nUK6r7aRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 06:13:13PM -0300, Victor Nogueira wrote:
> If TCA_FLOWER_CLASSID is specified in the netlink message, the code will
> call tcf_bind_filter. However, if any error occurs after that, the code
> should undo this by calling tcf_unbind_filter.
> 
> Fixes: 77b9900ef53a ("tc: introduce Flower classifier")
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


