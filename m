Return-Path: <netdev+bounces-17507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E9751D46
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87DC1C2131F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD66100C1;
	Thu, 13 Jul 2023 09:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8AFBE1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:33:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7419A1FD7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjAeivh4xTssBH2ghM38dYT9s8uzp8ctm7VVHhEBaZ0h4SWpxrMjmqte0yGVHCAe3bzfD2hKo/trOcnF1v9Al5JxS9COqJlwSa6PPwS0t+PSJGMC2ylpfjXSYCdh5FoJoB5G+pfrHPqWrMs/GhZtFvmiRK8aK+oUXz5afNvnfmWfj2/sxzl3AD1SEv2XuqbfObXNfoCGuFS0IbN21IPqOyuB8txxiu7d6NxTVtOEVXrVDeArOKJEuA8J7IO0Ym6z+5OuepOuwnrxXuGnmNpihhmN8OSlq5C54wBsizpNAEnMONfNOs4Obtp94DcxlSKaaNNiiHFQakSD6R8YVaKKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Px9m7IayUXZDrWKkLFz4af63wbB+i/lx103zk5KSo=;
 b=Uw0saYMFas0XbegcYWQrq8szQ9Hanefy1NGdeEI2a9NFTfFluPv9gXuP82mruw684frNic9rHNevjZwRiDl6o1uTDNSi5tXbxOXEuByCLyS2lgUb3gR2tvOAxHxCKkg0Hya5VtgP9N+SKPey1L15gzvv77+/pEywqda8/XB01Oa+AEx70LvScajZQhDNxqEjy6cTUavJgIkBMfqUx94hMembjUmIG5aRUv/eYPVp4ACQ2dS09RBqhiTB0VqZnVY3JUZ3VYtu7uSUjWAdJ0HkOTI5Z8szeQmauG//TLC7hDM/OQkWqLTmTuQ/3d5Bs+FwtCapk0V3fg/wy8DxM1m7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Px9m7IayUXZDrWKkLFz4af63wbB+i/lx103zk5KSo=;
 b=BtZ5vSgSa3Wh1z7P/+y27rCvaBhXaCCJjBedC26InR6UfEljmY+1PK0uVUrh2G/Fl21bmCnM8NuFMYejCe6BQtdqzNI3ISKX4hID4mkKsfSyNmqVH9CfxAb0LE1UCo3XntIonXyTLcw2JVglFyCkt4Elyoy97J7bXFVG0x4DnH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5016.namprd13.prod.outlook.com (2603:10b6:303:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:33:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:33:01 +0000
Date: Thu, 13 Jul 2023 10:32:55 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 2/4] ipv4: Constify the sk parameter of
 ip_route_output_*().
Message-ID: <ZK/Ex6IrzErDL3R9@corigine.com>
References: <cover.1689077819.git.gnault@redhat.com>
 <195d71a41fb3e6d2fc36bc843e5909c9240ef163.1689077819.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195d71a41fb3e6d2fc36bc843e5909c9240ef163.1689077819.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0255.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 80997258-6978-400f-6f79-08db838426fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7KcGPAq6l7bu9aBO8Jtm96c42rAswJllafegoR+pAMvUqE3/9ywfPq7v0jJn8hZWsV2fclbXXAOZsd4t8iDxZtpVDi/dkB9CIq2nrawlX0M03bemsq0luyDbNFKWvW8EfKXyoCFVhIeiqQgzxeKNV5dCMCYSIzL+B+fPfj7UGylnfgGMXFuX4V4swVj00yO4XhOXLhSbWgplxvZeXa1mtbDZsAT5y/Wc2luAlMH9WfxKwckJykAFDTPeC4oojbtBqSap1o4WAQ8I8Rz2cGsCqsaJi6/Fe2Fg4zPaK78HwQkTv4ghXQfGFaAq9OFbVoocAhoNSmtjzKIfEH2tILMpFH33sh1rVryV9Iee0C8VL74rdFwlwYb7AnRNLpSlSkUzgLuT6Ilm5TVomknwSN6V4yfz6Ll2E8ts6bhZdTixgW3TTY0K6AOyGFVZaKF6wSaL7D5IHYow5DmWVkn4oVZrN6Phzp00MiP1r9phcb3NhN38bdIX05BWIaURl7KfN4uEVWaNijPyjrAcATYpI0wjMqOr+FM2Ogm7oIv5hlCcSF09htJdlG9pQezEyRDTZqDtFZSQXO/c1HlvjUmaPYoTEwV3X7ATFqaphsJi9ZVEdGM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39840400004)(376002)(346002)(451199021)(44832011)(6916009)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(2906002)(478600001)(5660300002)(8676002)(8936002)(54906003)(6666004)(6486002)(6512007)(6506007)(26005)(186003)(36756003)(558084003)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WtCcrDSANIkuFzA3VJFq7iQyVkGPQ8GyBcz3lnDc0Pc8agXUOM6dy2xQzv/e?=
 =?us-ascii?Q?BRjZYKT61rB51zDdDIEf5jukylBCPMaIpgnhS+Zl8xGfEvR84w5BF1ykFu4v?=
 =?us-ascii?Q?DIytXrH3kZRwdppH5uWz8ImdJQGemb5fQpcEeEQlyCv0wp0dTRLdl8gYSCWo?=
 =?us-ascii?Q?3bZm7w/oY5e/s7dMbTW0N6knwPpAjIrV4D1wxF6ibYiEuUz5dHfaR7qkkj4R?=
 =?us-ascii?Q?hH4iY67yapVc8VJ7/FIqMXYt7HRAc09P5OXnaSeoSEe4O6B1C2jUif6078cM?=
 =?us-ascii?Q?Of8zAkZQLCZZPjGiLoGhjeZnnXpP+nCzEHiJ+FL5gdKO0SHIffiQz3rk/1Hv?=
 =?us-ascii?Q?h4ZCo+PHS0Ogi6JpVt6oshjimU8f+U16LTqJpWEcvxeKnw+8hgG2hAnenjPK?=
 =?us-ascii?Q?I+OL3wcw5rGjzWesVZcbgM7CD/ruLRxSKmzEqmvVPjRXV+iXngNov30NOFg7?=
 =?us-ascii?Q?KPwVx2KGpp06GkgIzAQKChu0YHEEyrK56BQuAzOFPRpxjGYkNk3A2AADiZmA?=
 =?us-ascii?Q?+TemN74bqgo3a0aOQaonZfPt7JBcBA99qvl+0oPSwMX78onjvWO5BtAllIA1?=
 =?us-ascii?Q?ogmjp8bPT6QT4YNY+3Tfxs5/7x4faUss8gKH6fa2WZS6L6FEHe3tqll8jicI?=
 =?us-ascii?Q?K/LWqVHTef72IAY7wFlcxzmdd1t9k6ahqTG24cFRP8dQOoMOPz1D4twJs4z2?=
 =?us-ascii?Q?8JptEREdFu9XY3y8UaLqHrpsf+m0YyBZ4/o3g0feerW3M4ZIl6XyID5k2ay4?=
 =?us-ascii?Q?jwAmblW9axnLqyzZuxNsGNYUffuGtRfAuRvkMsDpdovuX+AmJyWvPVDnJbtz?=
 =?us-ascii?Q?P4BeXilj6dQ531Axp+Nhi3SR1HznwqmVnKOI68m+IyHsd79+yT+zE0aVIO7S?=
 =?us-ascii?Q?T/+5Ga87GbrQ5UvpfQbq7sGA6+v/GK3KsZkso/D4Jc4vZgPX/ucbz40Cb5m1?=
 =?us-ascii?Q?RZrq/CfeXIVBizYzuXvF9IGbf8X+Ry5MfuOAwhvtncnVnrkXzjFsI5aW039w?=
 =?us-ascii?Q?dOXe6rXT3crCEuqLvQeAssVPYm6UNSXcl1Yu4RMFCxgPw5kxyAxgtqkKC/tg?=
 =?us-ascii?Q?PsBIuy6EaRpp8+Tp+mFh08ElOID6D5d7cKtjF4xtNqLX1idqeq5SN++BsvUS?=
 =?us-ascii?Q?hELI6E7EJUY4rRszX0pW3pv0KIcZ0BAJXZC+cboeMfaBulHe+2HP0D9obuC7?=
 =?us-ascii?Q?X6gdLhW/5vmSE0zhT0xgEQmRyuGlBnNqEF8P1BH2JByJxwpCodpbmPwuwyLv?=
 =?us-ascii?Q?QpsecG7vmZb0aj3vEm0BSxzipsgX4KfXNJ4MuE2sl655E9seMVMLV9Qo/VIj?=
 =?us-ascii?Q?9I3dEDNYCPHMYTVtFBiqCR1X4sDESCIYmTqwgZ6t6/paCe78s4EsZejTAwAF?=
 =?us-ascii?Q?M/vAwt4iYPtr8SEHweu84y2pM6b8JyTuL4jPxs9jedAr9jz1rchl0tD0kfAm?=
 =?us-ascii?Q?6vW4ToqJDxSeykDjzEArDxcTAPKhCQi67fIAtaagmeEi/m4juo4lMF/+P0GG?=
 =?us-ascii?Q?I1qgtDyBhl7SlUd3ianW4ctAto0EzGX3I2dLbTjr5Rglate2LUTRghM9T7xd?=
 =?us-ascii?Q?PTG2UUGzUAZF1UC8BnMro/p8gTmH/dHxp+feqMagImndX6OLJZNhTMqRH6o4?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80997258-6978-400f-6f79-08db838426fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:33:01.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRzuAru0841b8ewnVYKJizEQPG1fG5qFwwc3dTix38sJL4eo3qE9zPIN4tjIAGimKntZVPeOZ9btgyf9kAyWNM8wxsPr+bC61qNPoU5+cFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 03:06:14PM +0200, Guillaume Nault wrote:
> These functions don't need to modify the socket, so let's allow the
> callers to pass a const struct sock *.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


