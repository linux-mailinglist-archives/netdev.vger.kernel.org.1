Return-Path: <netdev+bounces-22232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E037669EF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD92826FE
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D82F111BE;
	Fri, 28 Jul 2023 10:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E21118B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:11:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2133.outbound.protection.outlook.com [40.107.93.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5EF2D67
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq8CXf6glIEQAdedCCHmfUZ0goQmQPC23LBeWXg4zquUcdiTLLx1rl46dv4jqr+m2+KbSQcry+/HMrVEAI94g/9U2AnE4YvOG1ZIMfvvukosyY3vY4W3XP1jYUPBEGsKRPH/Dd1SEINstOWLJQb7HvVRXnKHFe5n0MGoLIRGgfU3/onFYrb38r8+JzyWxWbVrsjwWdEw92lyugb+bdq+U+08e9zwKNQsTRo27AdTj8gKMnmBKpVn5FfnbEwC1KZ8gA/lVE0EK+D49XddXYhIM9l/RJWw6QMl875URsK24UMJOzMP45HHALuiJuboOl/ZVCM9VAM2xDy8Yp0vudYuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsaIC8N3V/rrllsoRNx6peiiH4MKP+R2rALScm6doBo=;
 b=kXyoRLeGqwpQX6r6mCHRent65b9YPzXot+hE3ng0BuhAcLOYXGEE4VGiNllZ1U4fvB+Gclp+U2svABBFuVbt3DgZQOyENEWgIYhphR4S5wh2Bp39bKVHZxZ854FrrsqRTiLc1ApQyi8WazgDGqVxY4GioniP4wOE96skK0BszIv8Yl6pVHXy9tmeTGOv6I7JYAWNrbzy4QNGHG0bYiM+NvCMHGhExD1rYGwRewRgjlYvDbdSZh264uoatJBPshQ1DwCJsXCz1HcxgLtbockKGNXjklfs09tgCU4ZqxwceoNG62ukPLln68twvrSkIU0PYzRQ26BEKAz5n5KYFtHMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsaIC8N3V/rrllsoRNx6peiiH4MKP+R2rALScm6doBo=;
 b=UPc7oObYk2+9ohz9ZuAUfHxCQ67oyZylkPS/l1gIw7DoP0ubSSn4Xz9AGVn4O71R1hVgeDDGTlnZpyO1kvNMvoW56D9JCmZt2ZupmbU1Omm9/9Axp04TpMtCYv6v7lGSmpxCu3kky3bUs31dfQZbwarlHyj/wU4FyGDUOhbvrg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB3968.namprd13.prod.outlook.com (2603:10b6:806:70::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 10:10:57 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:10:57 +0000
Date: Fri, 28 Jul 2023 12:10:51 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	david.m.ertman@intel.com, daniel.machon@microchip.com
Subject: Re: [PATCH net-next v2 00/10][pull request] ice: Implement support
 for SRIOV + LAG
Message-ID: <ZMOUK+jr0g1aGOr6@corigine.com>
References: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0PR02CA0134.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::31) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB3968:EE_
X-MS-Office365-Filtering-Correlation-Id: 74814c7e-b8a1-4e78-e7e7-08db8f52ef63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NIn1O0nALJZS9yf8t917knr9wdoInWC0mr8tX4wFJCCdZLrzS67ahLulxNXRv4Nekv0vlu4pHz8g5HUA4txdrxTiP/Oe9e/wVQVae491xtLZOxFprGQ05mQ3oQmv7xmSyu0pH07X/0ZlfybccYC5XeBH1T6GYwJZzUxppmQudPoe4MBYBwAxDXRdsc61tWFenmbITIJ8Gz9cxwKg4sC55pKANTnc9VIScBT0sv8SOghfrOGAJOxGRx0qAM9Hn+hdKBNgDIw61migiAnTob3hVmF/le6y+bf1QwDOxdApepAFELyu9S/G6010/MOR5i9vG8zOqSatXmd45o8tKSAt/iXju8X2ZM0ReAGObm0ma/pIBgeM1qDC89S2Mf/JaDIwTtgqGQp+3cZz8nrnZu8GdCicB353Uqr2NbTiu8cScUmAiTkwl8i5+LM7c4JOmFUN1Ojcc/70rhuwh76AoJQ7o1sr4s5WoARA0wqR6AZkbuJA2vwMMyv7+Skvj7dG/6kcpVDOWakpv6n9xUQpv+2EivNAiEHkAFJUM42JXdSC7i34s+UOwzsvo03rBDvCYRzjhUlrvh94OpfWWg6Oxy74XhqLGIQFaAigLDlBDCwF4xoAcAwG27s+c+zpczWrvGKZ27/CWsgg8JEJ+niSXCKI6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(366004)(396003)(376002)(346002)(451199021)(316002)(86362001)(41300700001)(5660300002)(44832011)(2906002)(8676002)(8936002)(36756003)(966005)(6512007)(6506007)(478600001)(6666004)(6486002)(83380400001)(186003)(2616005)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XiiHTE7OnyyC38rF5XkjwGbSYjFmKYT6k3LULstdHfwcc5OiDthElqjhvZS?=
 =?us-ascii?Q?M/ipnSkNC/EY8Lr1HegthZfD4910GNvPAm8i2YG7mbInFbN6l7J3lhFmo0lk?=
 =?us-ascii?Q?eAzWS1qnh2FkGP6Jh9vnwntxhyre0ZhHtvW6Ly/KZO/WxmenNeG3dDYOygvn?=
 =?us-ascii?Q?lZ1DScVv4AdTCbbDvn6qsC8Oz1MSyHaDtPY0onq5K6F4zT7H6tDtSvWY21cR?=
 =?us-ascii?Q?cXYtlIxUK9HCPDxJdm+eqXmB/R2+BQ5+wt6LYNKrZCk9lKHRBRzHVJUCYCTE?=
 =?us-ascii?Q?kGGV5xrmlkuAbdL4gJ/XefVAORg2tTL/NBkI01ivhBDbhewig3pkgUL6NWL7?=
 =?us-ascii?Q?Y3GAuE7BGfwV2UN0tnRDY8Luk5H/zMS1SOIkqwbizQ3+xlC+ggyiAOForgJA?=
 =?us-ascii?Q?TRP3SFLZWYCzvZF5nRJh2bOKq9MeQxBg/s9YkNm0Mh/7QBIsnv8WG8ByxqfZ?=
 =?us-ascii?Q?xcMnFoap73kmUZCDtsIFr+KiLzFacZ6M/Y3SUFsvZqNUxJPz1833w6Ysacwt?=
 =?us-ascii?Q?C4z3ZREEXNAkzE2fNebItW5sOZkz9XuijRFxme6HRRekwa6FGZGqTX7qcgFs?=
 =?us-ascii?Q?9MLY+lQqQWLR+NERMXmjHPCgV9QVbvoDN4wvbQdMqmRsJ+Q7HitTvz0kqswh?=
 =?us-ascii?Q?ElM47S7uBBPfC5PZt14Dx7zsmhCoR8rxujc1ICr2O7djC7vYWZVMZmIjvwgR?=
 =?us-ascii?Q?bF2Ng3sp/P0rpuqVEOpa8SjofgzxvH0297Mmz9xa5Tg/DwFRlXiuRNsIYddG?=
 =?us-ascii?Q?Z5qoJP4/iBKDja2mhmBE73VkhibxHKRo3CcnobPrb7sGR6GFCyvFjgJKHpi2?=
 =?us-ascii?Q?NL32JAfDYf4D63SAQir2Dl0qZIhyLZNrrHxnMhg0klycrdYJj/F4BKqPLqXi?=
 =?us-ascii?Q?56+ACT17A0B4iBZ8bHwiYziv4sC5Xrez/ecetMI52j4jTnyOKKgk47NcDbU5?=
 =?us-ascii?Q?zPKBiGLjajyP3gA9Ho/rOH8M94V6BRtIIZ5pqUwAMsNsYBcHw762F7YKQGf+?=
 =?us-ascii?Q?lVPfk7Ammx/IJZtwbjizIa82HIT4i7ymH0PfYBbFHnY/ly6uP0WP3lGcFyzA?=
 =?us-ascii?Q?BwVnAiGn6KWlP92nePNsi04B6KMqQ0G5gfxwWgWBF9TkSTpQ5d3rJgsPiUHL?=
 =?us-ascii?Q?FIsa9RMiUykULUv5VS4fUEGDSCeOgmoFWTN/qHL+o/98Q4ZM7VyOKqC5VmPU?=
 =?us-ascii?Q?1uy5yWighyNW9UZuLLsDUN8DduQXdt3OiH7WQuTzzx9KWP4n3rVRUcUXuJZu?=
 =?us-ascii?Q?HZpIhsXK/gCbXrry4HYvQ8KDyczOs7Mtd72QyTs2Gty3a2+ZDfjqNuU/zggy?=
 =?us-ascii?Q?9GaHkZSYEBbfThrkehR5Jq88xgsyozL8F4i6E32sHr4IpFpzkX3jMTnqlCri?=
 =?us-ascii?Q?uXBkB3YQ9ZhMSzpErwtyUiufiFGX7nJ047WrRL5ZVlI07i87rruwX+UWbnax?=
 =?us-ascii?Q?h2F6TrtTUNXvO2iwLf2T9EhN0dq5dFWUXQj048eUe4vJSWjF2bF0DtOmXIcF?=
 =?us-ascii?Q?lN/OoIGLU58yc/WS+QCCzOf3Oyg3xziqPXJ06vG0BtxG5puNRfQ7fMsSCmOM?=
 =?us-ascii?Q?uGS0FD2FomGY9QFqAOVDWBo8ySDOzVkhR5k+ktyLvD1m8cAUhXz4flHaacGE?=
 =?us-ascii?Q?fE6HRjZx6cFajcXrIfJNSzKbvfdBI9QRVkO6nFhi5pZTL4r0f0qLTcw/zdIv?=
 =?us-ascii?Q?Y7ZE1Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74814c7e-b8a1-4e78-e7e7-08db8f52ef63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 10:10:57.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea9MWxCWBwZAJM7BKQa0iqbyWiCY9JPTy1yyMR+iv9CHDuK9buBqQ474u8dtcCN5QPlkOebVCtsa1XRjvKk/UeiKMF37/FVTqMAQu7iIQz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 12:57:50PM -0700, Tony Nguyen wrote:
> Dave Ertman says:
> 
> Implement support for SRIOV VF's on interfaces that are in an
> aggregate interface.
> 
> The first interface added into the aggregate will be flagged as
> the primary interface, and this primary interface will be
> responsible for managing the VF's resources.  VF's created on the
> primary are the only VFs that will be supported on the aggregate.
> Only Active-Backup mode will be supported and only aggregates whose
> primary interface is in switchdev mode will be supported.
> 
> The ice-lag DDP must be loaded to support this feature.
> 
> Additional restrictions on what interfaces can be added to the aggregate
> and still support SRIOV VFs are:
> - interfaces have to all be on the same physical NIC
> - all interfaces have to have the same QoS settings
> - interfaces have to have the FW LLDP agent disabled
> - only the primary interface is to be put into switchdev mode
> - no more than two interfaces in the aggregate
> ---
> v2:
> - Move NULL check for q_ctx in ice_lag_qbuf_recfg() earlier (patch 6)
> 
> v1: https://lore.kernel.org/netdev/20230726182141.3797928-1-anthony.l.nguyen@intel.com/

Thanks.

Reviewed-by: Simon Horman <simon.horman@corigine.com>

...

