Return-Path: <netdev+bounces-14849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB40744151
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC621C20C21
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26481174CD;
	Fri, 30 Jun 2023 17:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D7171DA
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 17:34:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2128.outbound.protection.outlook.com [40.107.92.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4445E4497;
	Fri, 30 Jun 2023 10:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNV0utNtapoRB2LiRy3T1NX/VH6SNbRqXPsAAzBjwE3oOQuvOBEOmsP0kUNkoy1k3PDfFjPnrDiRnyPcHK4bSn9MzToM0+LXad42EcUgXgICjzV+XuXBaR5AoKAFFqKiP42L7qKOs7NG0IaS4w8ZEnPc8i78/6UcrxyvG4TGtIZ9yYEFqJWqrzEagcLnoEWdlfXyRR2T+5b57Y8Rc3Q9rD/XcO2zzqzroSfc1cfVRrvDaOrQr/EJlmFfc7j8MXch80YFutMpj7egZmNEb1kCcnXa/OCsIlVEvUcC4a0kEh56R8uHtdv9qX6UAqOiX3XoHK/ASh6WG2fnh3dNrcxGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFNCKBvZb8fDLDDfwG51VBg2WOwBZB/yUTgUZ8bxA/o=;
 b=IPEd3Z+Pv/phOjykv4cbi9oHyR4HZn8uu98HcNaIe69Dls7EdaiinxNMK02QSEVGlOQxsIi2Adij65K8Yxa/o+81wg3p7qwt/m8rYpFArVQHYcqjIJKZNtMVKNAIY1lBHqhkrzCpaocdgsyACV3f6dLzmIntZgFtS0cf/vEVuRXvJUrtWgzBYfr7xV/NynOeVnSqMdrr+Y2B8of53RC0RDVNptZPELZN9FrM4WX6A+Oqw+wujYaD1rARB/n/GC/P7s74eNKTKoCnyez2agmEIuf056rm8NhlJ/Rj65vxlJM5UjqKggHyEZ7hl8b2aEFvHpINAz5HWvDqsR+7QfNlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFNCKBvZb8fDLDDfwG51VBg2WOwBZB/yUTgUZ8bxA/o=;
 b=uaDUw8bcm/PbK1UBxq1bxz1LRtJrYz0lH2n/ZBErrvtE486NalGvzU7OgfRvoscMT4jraRRhrDqtGbwZVIxBvq5seY5gceQg8N7b/pMpuoyCSc9ERYMNl96NyZXSXU2/1pu34A5BsNAQTu5r+NJS7feOJ0DNK/E/j60QQ/vO1Yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO6PR13MB6032.namprd13.prod.outlook.com (2603:10b6:303:14c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 17:33:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:33:48 +0000
Date: Fri, 30 Jun 2023 19:33:42 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, andersson@kernel.org,
	quic_jhugo@quicinc.com, Sean Tranchetti <quic_stranche@quicinc.com>
Subject: Re: [PATCH net v3] docs: networking: Update codeaurora references
 for rmnet
Message-ID: <ZJ8R9hzSG9HLB2QX@corigine.com>
References: <1688142377-20749-1-git-send-email-quic_subashab@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688142377-20749-1-git-send-email-quic_subashab@quicinc.com>
X-ClientProxiedBy: AS4P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO6PR13MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 97975ddd-3f9a-444f-06e2-08db799029e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1I7crpCMNCFPpwdkIldemNAragPboNFlgNlDa+4GpyocwJkRF0sotA1aVyn+0IHIF5Mbp3dYhjHtKKk0xnC3nwXrr6qfjCSY0VTIE1hHgI9JCjnbvBAJC/kPcdrdLGepLuxmS6fSj4JixcARnkxMn2AwafV4e9n2Olbt+PdUEqdW35WdltdF9rmif9fNFfuJ+d5Lt+JpN7Qi9AXJdASYm6elSvyFeeh5lXMAuDGe++no8r2D67YU6UtnqvvaLTTINYJcOGlBQeNZeVE27ZSjD2NUHK63gRIIVZ6wBPoOl3SlGz8jZDG02+mgLvWqf40gyEoA0sB9VA+N/q9s+JK/y8ZEmDBWt7OS9uBzlfjoQzCsLQ0XCGC7ABjLZaIF/2ongt1N/xzpo2bfDuWX+EeYgjTMxuU2kBm7/6s+xmoWu9yBmw7qvC0ecvVT36sY72HvemWg6NCP2/2l9LAbpA1p7KrVi+Gw5kLVLCx6ZtJl5b0xcWxnSK9IlqZNMgjT0r8pD8dwtWPbM6HC+m1roXJdNjy+WaTfZmc64jatdfdiCJfbO1kn7LomJ2NRJnX72Kzv7E7YxkYLn3eMHpZGR69kDJRMLOyWifs8A3to8MUudes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(376002)(346002)(366004)(396003)(451199021)(6506007)(4744005)(6486002)(38100700002)(6666004)(2616005)(83380400001)(186003)(6512007)(41300700001)(86362001)(2906002)(478600001)(36756003)(316002)(66946007)(66556008)(66476007)(4326008)(7416002)(5660300002)(44832011)(6916009)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQaxh2o+gKzR6Rfab3Zpx04ghTJmW42ytBgVZpak8p+vPhXSdKqELD4aVF23?=
 =?us-ascii?Q?aPFJsYHjzRAsv5NbGs8ThqArcqYCfUytmRloHLoX/5nmrEPaAGIV0wlV3xj7?=
 =?us-ascii?Q?BQ0NJEvmseqrCvC5x4E+6/IKSNxCJKBa8JSSuqj96yFHBTBtDdg7aoyaVBbq?=
 =?us-ascii?Q?F9ZA8E5hOJ0Qm6AEMvFqIIzwanbsbuGM1kY6zFB2cTrVqZrGd0UH+8G02Ok8?=
 =?us-ascii?Q?zdo9uUeuadVvKfxQCgJPcQzu/B91DG2TLobdIEs5N274+qwPWaVgJdzzx67U?=
 =?us-ascii?Q?Sd1bNXfw/2UdQ1I2jEy+6VmVBWw4j3gMtsgQA7jTGoc5hdH1DtocRvl5vcG1?=
 =?us-ascii?Q?tfQFzd9l3aL1VAbuMHrANgOs7RzrV2OHDQIA/NJwHaRHnTsTbtZnOBXJyees?=
 =?us-ascii?Q?MTjJ2jDXWTj+946mnvv/vf/ufEqzYDqzW7TLz0FYn/YZ8K5KLT2xhQnBZLL7?=
 =?us-ascii?Q?pFfNkA0ilYhColt96oZJgdbWdhkzSqhgoXztxDuXrMUkkhQBdyucfXTknhs4?=
 =?us-ascii?Q?rsTPtqjN0cjNDnrekKkCH+q3pJRysnNsDmmL5sUafOBhPlI/PC6imj2yu0Gt?=
 =?us-ascii?Q?9JULBpdx0rpUZ4CdL6ZH/WOqqQb0JkdcgqZAbxrhWbOfCCozCV4E5QOFNn4x?=
 =?us-ascii?Q?j7IDX9IhgsUrHeL9lPQ/ZY4Ux2AKtJTTFxpjJFAAM5We4VuI6kyl9jZ59z3/?=
 =?us-ascii?Q?ugP0a1EXpeE+b8zsY1v5U68WbLotE5hFRnr9+cxiIBI1JWvT1Stk0TXvb5nb?=
 =?us-ascii?Q?y6S0rjD1/NQBxoVf8zeR2n0lvO+7v5oH8GC8L+AcvHABZzm4MpWN+WcoxlY1?=
 =?us-ascii?Q?p6GHDLeEKWPtIe2Um9noJrbIfzWzqiFPy9bwJyw087Ifvuv99HmX2eJLkKlm?=
 =?us-ascii?Q?Q98ODMqti4TNw+CFgPjRpDKHrSznTBJbn8xGjqPBDWb1IdAF1rtR0WsR0ta9?=
 =?us-ascii?Q?flXMv4pSDfKbGW7KwdV8UgJzS5WGtGgITw+aN2zmrMV8kYx7eK8BOtZiaJy0?=
 =?us-ascii?Q?8MvHdQIk8IIRTp1G4LuNfdWuIoV0SNcMDTljojpBj534pnzYvLWlBin4HFYe?=
 =?us-ascii?Q?BrnDqqaucVxaAm74WwAlkEkh4MbUg/tZCXouGwwHxjk1dy7iuDDEnW1LmQT6?=
 =?us-ascii?Q?QRVEb9hVDlCqZC5YfHnfCTW5OSN2sou3LzMVQclcQ7Op658gs381SHPQVW+K?=
 =?us-ascii?Q?jnXcUp6S1n/gHYpJ6TAsP5KkIauvLkAWPoSp0WWXr60koxJQ5WQYSUsGjcAz?=
 =?us-ascii?Q?BmV5d/FOG1TBZQ6ytiLO/fzVL5kOcl7jIm+c86VrNUBkoKUIdUvdj6Rk0q+d?=
 =?us-ascii?Q?hpPF2xp2kwQ78stSycpomvc3TwKXbE3bLNdPYchp5g707TtW9hwcnaft3zsD?=
 =?us-ascii?Q?C0Zw/LE8yd5yGMJHZZtqHwqvGuv4MoDTDbXRnAIgxy39tvT2XI01PCRLvKp+?=
 =?us-ascii?Q?3Qo61OlI59b7rNplyPpX1TXgw041P4+mT/wD0Othd6b3YEvoDoaKEmaJ+A+3?=
 =?us-ascii?Q?liYKLEEmSKYMUvhlJd2uTeW5UVyPdMLFdjETubzvZCU9ojDJ0BuFRWNhjLs8?=
 =?us-ascii?Q?9j7/8UtkVMbD31x/mbQENJ9LNm/LAUTWTze+mc3dRx0sSWOZxvy0ScVczVZW?=
 =?us-ascii?Q?3u+eUdWsGtslzDteOcQlhJ2jU6OZC2yYqZJ4JEoFeu2wupcee1CQqt4Iq/dL?=
 =?us-ascii?Q?Fc/TTw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97975ddd-3f9a-444f-06e2-08db799029e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:33:48.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH/ucD9OBRar3GYMzUxTJ+v5+F8+1b/EQSVDdPsAzCV9n4RKzrLN63CbWOUSvTVYzMo7ZBcGW8GRb8Ivltt0EAX/wu1HdgIPd1rNMd5GtNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6032
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 10:26:17AM -0600, Subash Abhinov Kasiviswanathan wrote:
> source.codeaurora.org is no longer accessible and so the reference link
> in the documentation is not useful. Use iproute2 instead as it has a
> rmnet module for configuration.
> 
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


