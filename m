Return-Path: <netdev+bounces-17460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920D751BA0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B81281CB7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534B79DD;
	Thu, 13 Jul 2023 08:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B26613B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:33:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67D3C28
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjRvfs6CIIBMBAbIIKcpYxMZjSqFD+NzvZlRiI7X13ICFvH6GwoK5e3gEuw90AoTfyHBOyCHLGfSi86u1qA1PciZur+CVqPubOwiEVrPibzMqB6kIjCK5yo3kmgiIlb+v4D6KKt0BNHVIiFU4+LnMLhTHJ90JfX2Ex5nUuale24eCdeKA25ggJ/TTC2EmXaIJjBu2xXsY5cxLnxu+LfXzsRpQX/KKtmkr7NQ7UrlXlGk8SX1v4H7KPBI6qYpRctS5EdGuVnJHa/jdsb3GILjWUtKlobJmssO7R456mxTUVAX93nWaBgvvpeNAZC26ORls5SxsyIcN1ZlzDbydojd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoeIY7lH3qPQu0Jkrf+h9x4qLgPhcFrKH3loWAD81K0=;
 b=BHsaLYYEoT70HavnIGyDDefROfNNwnAsJXqiS1cHs0jOh+xT1vYjRiIhWjnlLYmaz8W1ttYDirDdMbN2XSfH3EBujgeD8wCsAKXlKxFroO+kdASVLBTs7B2RrYLV77MHlLytk7BZ/3TI5r1V3U7fw+QNLfnY3rbLggXnlXcu5GenWoKEOMeMR+X6q581WV7DcFfwU0muRG3uFXJXUm0AROydOI7K2qD/jsxN2S3r5jzaEVO6bVbSQKD7nzQruk98qBWDy5ilxl8zivHZm2b50tLr2JBxs+C9mEJhM1OyzaucHIAuDgenj3+xU0ShkzgoDJTr+pd2iW6131/3sp9nRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoeIY7lH3qPQu0Jkrf+h9x4qLgPhcFrKH3loWAD81K0=;
 b=fYU1Cea6Nj2H7BbUzsbekKcE+lSd4zM/0Qe5LSxJfjB+QHWZk32mT621InIEHhDIGtJ5ZVW5pFQxDxFL5Xuc3WZb2oCDDSzDKBF2JYti5V3ruDB6G+8cJonJZVrYlaEjozUVd+UMvNBm7u2akyWEfCzUCdwqeHhYE0Pn3OVIHmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5866.namprd13.prod.outlook.com (2603:10b6:510:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:33:51 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:33:51 +0000
Date: Thu, 13 Jul 2023 09:33:43 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	shaozhengchao@huawei.com, victor@mojatatu.com,
	paolo.valente@unimore.it
Subject: Re: [PATCH net v3 2/4] selftests: tc-testing: add tests for qfq mtu
 sanity check
Message-ID: <ZK+25zBUBYWa0HfO@corigine.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
 <20230711210103.597831-3-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711210103.597831-3-pctammela@mojatatu.com>
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 18fad3e1-df41-4443-9997-08db837be300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3l+ELusRYCAIRDLlXoAYX4avvahqXMLXaPsO59bCpCf3YIoV1eKr6GZTY5qOSn6t+btrx0+jVHLlirZKg5G33zf81/13M9SvzZ3xEkq4ejJYhVbN5JqKlKfURAlwRMsqlxU/pVQP4Ax18KNpp0hO/JDUsn5kmWQmEomB5LpaZc0jdKRWKk5USrrArrtjCO/T/v4vsgDraWJ+sDldDFZXo7021KiniMfvdl+QcPfTM9fTPE7q3Me0VlfXX2tcQ0LIZlTgbe3DbSAtFOJuUJ0t0UL2OxDk9e51fGhF+25FlVD4xARKsI/qN0VPc6BzmZ6w2vgnvM8uWzXoGk5Bu+wpRRjMSn8zUXjV5U+C2JVg80arxi4gm9ToZs4oyaAA6Oz/qjmN6TwbdCXpoq3KAM2SEkyRlobEOCnulxmGeQhgmG7i5u8GgVaPHfzlccDwYWZuYg73D5Y4+xqALn10Z1MBcdNqJ+RmIbyi4/px1Nx6eNZU3JjpbeW7AS9nwhdDvt6Utjt8+7nRu+DxIbNQyLZ6TiFw/BGDjAxbgLda9QaP7/CaObtNwSAQA1g8d1/LnHma/cfZosSWqARAMWhRARuQeB0zUVDStrY90vN3iGHvit7f5BSxxXLXpoM2rEsw6au6SNZ3+5269hgX7VU/Nvtg1YgmwYtRCYgoJxzSU55VL74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(451199021)(44832011)(4744005)(41300700001)(2906002)(316002)(7416002)(8936002)(8676002)(5660300002)(66556008)(66476007)(6916009)(4326008)(66946007)(26005)(6506007)(86362001)(38100700002)(6512007)(6666004)(6486002)(2616005)(36756003)(478600001)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIQxKEoqValban1KRuOv9o27qPMfKBZm4RFV4S//A8XmT6+zQztyyCcojPLr?=
 =?us-ascii?Q?4HkGxF4nj4/wdcyVFlRSBcmZm+yD1f7rnwvOBACE+aKXOPfod9QjiCyqXxI9?=
 =?us-ascii?Q?nF+V/IEX3WeJRcowy2rIJy8vIJselgP2J4EY+Xrqdqn9eUV0w2Pl62ycZdNy?=
 =?us-ascii?Q?ABc46rrlEhV+dRLwAMyXAhVTECb8ies7pjZSkqKkBQDtxOXhRugYKwAGZKc0?=
 =?us-ascii?Q?y1u7qpW5XopzimP7plAJKh3Ni/d5SNVlUf4XD/8udn4/JBQULYdI3rUoX48p?=
 =?us-ascii?Q?MWZGAg5c7Y8z141hGza7IoBcl4fLyv4KYpulahdcx4BgnmY8cJhkAtjyzRI/?=
 =?us-ascii?Q?gCEwvoLyhaXfLTNsWmzMXgsc4Nek2q3vqyKUo+Qs/8z0yELVYVTIRCP/2L4W?=
 =?us-ascii?Q?KDKmko/MOfSdnUdcVqEX7xItOvePpkKdSbB5uwTM4pct5L0Wwl1ehj6QbVfB?=
 =?us-ascii?Q?+pPFuvQ+rvkI5OWsUeUMLGi2DKKi63zytqXhiDpFUwZ4C2iLBA23L+XSF11r?=
 =?us-ascii?Q?1db8YgC0WOsKwS0ZvXVhUr36IIH7mLWjl4Ls2TTeQZ3yQt9LkkYeeBUUdENM?=
 =?us-ascii?Q?F222/X3X0Ul+ybTvBGUJFgIJWcf1/wtL2R2mTkaXizjGEo+mKtXqFJzKjs8+?=
 =?us-ascii?Q?MX7k3HgRl7Z27cu+uggEC79kwtWaKbco7Q040vlQCeasuj866OmvkIZqpqNV?=
 =?us-ascii?Q?hrOy6OsHS2EI68bHDCLkT1u9ElQ1AxXOZtyAtFVbs7XyseSrWAh+Bwe2PZ6Y?=
 =?us-ascii?Q?uQ4+7+Xqo2c7TsYkEDJONVGR+9/OTT48lDJ8MysbsIkmXJ/TaXT04l2iixRQ?=
 =?us-ascii?Q?AuBi1QBiu9jkm6pl/vstR103tlNaCeok2oIMFaIPRwydcXuOHIJwILrr6vCD?=
 =?us-ascii?Q?huteO4u+8y6AmGA9y8zn8u/QCIhDKN2aKpW2Ym+z4Max5GoGzyeyx6TC1zTe?=
 =?us-ascii?Q?ve7W2GkEvcoaQ1CwLLBxP7merqkmIhZ039DenUM2Mb/whytvlYix9WA1aErj?=
 =?us-ascii?Q?WAUeTjB49V/kU0jgcpEtcvLFz3F8nbGgs3GqNPasQgDmegZ9dMZaEbR91tIY?=
 =?us-ascii?Q?wMJ1fyUyphDzPXNX48UZZzjGah1JnJ4+u7exK25QxKpnw3hXcPkqTB5C2Jo1?=
 =?us-ascii?Q?0JVj1IaZhBTCxQVClpbT1g2CtIsgoz0RZ58bFaPqIDdREXbM/FrREva/EZFK?=
 =?us-ascii?Q?SYP7KOs1QvlzkRe8qlrFoAcDncIzuFEKsHjtaa2uTC7Gh5v9QDDnH1oUEmax?=
 =?us-ascii?Q?pJ/ESYDasVagv3Mj3xxvWnlFHAmtRcHiy9YSA5ZDC5eVy7PZqpehHnNM8z7j?=
 =?us-ascii?Q?KDhL4aH13TltqPBcTWUv3YI4VUEpv7R+6h1A5bqXhxx698T2OB0NPTFl2Zul?=
 =?us-ascii?Q?pRxjr8/gaoC/Rot1Sjcz1S4BHL0Yte7kpJLHpPZU/GxJrOF7LXYcWe1O7xT+?=
 =?us-ascii?Q?joYgFhxPeXVTdwgnuMPhE2gtOJfGJHB6GDUb8EDMfI3kgTZOVjjZrQ8GZ/cQ?=
 =?us-ascii?Q?C8r1LlcPcGOM3jf90lc+lq1fNd8+E7Iytn2TEACzBpRUvleJNbtw+5aIrPWZ?=
 =?us-ascii?Q?O/qrv/daEyD09bubu/ba8w9cmhhTtxuedFNJAtOTJeFXue6Xz34cbyRObGoA?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fad3e1-df41-4443-9997-08db837be300
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:33:51.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC6LpHs4ZL5DB5Xk8/ITvMiqjDCkjqp4e+sMTBwSWoZhL73xnylO4k4vDdEZekLSBecS/HaWKh7urLGkVOKL2UzgvEwMrTrjGH1feQpb2jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 06:01:01PM -0300, Pedro Tammela wrote:
> QFQ only supports a certain bound of MTU size so make sure
> we check for this requirement in the tests.
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


