Return-Path: <netdev+bounces-17508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6152E751D47
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD51281C5F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBA100C2;
	Thu, 13 Jul 2023 09:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60414F4E9
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:33:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2114.outbound.protection.outlook.com [40.107.243.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6E1FD7
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcMnX2bLXAsetR2IzrbL8d+vj/9teTFTMdMCIJdj3OWLfxE0ISEp28Vuacmdo7WbdC57IvJ3uRhiBAh9J8VEtDK1WzJ7hW8Pq2NK8lRFZmblFGXpjOeXQPALTRrHA1Xvbp2obAed+DwKeW2i1i6h3hRc2bU9zDHumBOet6W+W4abwFuoRF9dgY5ug7gjKj1TEHn6NCZWc2q3x2XJzC01l/RUGeo3oeFL6fOLMYL4tCv5M/t+DBXl4oQ9DswtUY/rPcMk0mw8+vrpNrbWky6LH/tR6XWvbBGNixLSEU9KgpExQKSYXoEC0+QfBTV5NRYTPGAfZDAh1UYYlOP4GiM7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cShZncFkDLb5FQU7P+Qxrr/h3ChMaeSsWl7/JyyDVc=;
 b=Mph1eNiK+eqJySlwGj2jkUod4XMBCqB6lFepsaYbXGDw7cXdxQPsjtMf86Rk1oP2Lp8mS5sNimwLRuzQIOtXN+8SbWEy9lkGbycc37recDpmqQtrKqX90+FoXQTQL0Cn5vRDGLjxY/a6HDmcyxjlbTwifNzEs+xJ1FtEkzf4zllR24i+Il0u4O7nPGQBa7Hu4yiCpsvRknf2rdUzliNzicNS0hBExiBA5NxqCiNku8iGhufgrIIQ6uq1F2sRjcKphw1sBmdVIZZeipWu0EMrj3U6te6H6JbIml1UyOQKuHVLtTwbzgbWbIMJXnzsa7Z2VKHFKlKZG9LVfzGJ+lOuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cShZncFkDLb5FQU7P+Qxrr/h3ChMaeSsWl7/JyyDVc=;
 b=Cny9QR7aby6rYVRnWTJ4hvrOnMdBL9HWqrVnsEpfTdesi1oHWXJ+h5h3+YOg+lW73KBaztzH+2kP/0GORFDQcVqnS9dySPAi96YLG+Hd97BpcLeJo4zlYkB0zs6AcJC+NPZwTjHPmx5Idf33NXcQSHf5ZlK5PzS2DI6i+x/OzR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5016.namprd13.prod.outlook.com (2603:10b6:303:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 09:33:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:33:19 +0000
Date: Thu, 13 Jul 2023 10:33:13 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 3/4] ipv6: Constify the sk parameter of several
 helper functions.
Message-ID: <ZK/E2SSK9/RzaPm+@corigine.com>
References: <cover.1689077819.git.gnault@redhat.com>
 <38ea4cdcbd51177aae71c2e9fd9ca4a837ae01ec.1689077819.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ea4cdcbd51177aae71c2e9fd9ca4a837ae01ec.1689077819.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: ea24e1c8-f1bb-45b8-371b-08db838431c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jeLVt5YGQNhJTX+tpnC0CDoU348SFv/RgmEMD4nRRh6FDnZpI1sh1mXTIlV30f8gTFGZLA+MupxqP3aSW7ODx48pZNd49CCI85c/MFj4Xj8nknG5ZWgMK0tT0lnM1ImoUYPuZQ5mbjNJldJnBMANS0Sr334z+D3BBvQcSWIfsbZD1YXmxBVv5LWnYxYF595Oa+nZt2YGTlNGLk8QQg6Sshs2VqdupCGmB2lv+kbjQd3CFzst5loUBwmYtx3GkBcOz3bTvZ8hMJqwLg2hq3bduy0e2yeU9Qm/MH+4cjl+jbpConmJpYoRoKXGctPGkTuvxiLM5yoSQVzgbwxieuwLBS+L9j3IONwMSndc+zclzwbYi+W5SQY+O6zHJlnKUeF8KSFfNmGlVYH0J2Sxl9aYJGWbbIoAFwF4X89MdXCqs1sKtEKIiWFY+GuKNCfhbOojXXU/WwMIm83VxUI5f7CEHKN1yBdRLsO+ULzRIsqYwaItp8cCOz+6PuFniipLDikQewapwvNx1bt+ShLzNfLeCiAiCswsfuTN2NOzG22eAOhzMu7wxXnh3i1HGb7XfJs9Sc0iA64ZQ+Zie8N6NF1SBpcjoZFr20VuzkNtZ28Nm38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39840400004)(376002)(346002)(451199021)(44832011)(6916009)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(4744005)(2906002)(478600001)(5660300002)(8676002)(8936002)(54906003)(6666004)(6486002)(6512007)(6506007)(26005)(186003)(36756003)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xM0Y7lME7TZrLLAXgEvxTnPt5pJkivQHWRwhRfnaapE6sl8sTsUPvl7O5RPU?=
 =?us-ascii?Q?+d7uXwRc/7b7w5zeiebvf0mMRs7qSZsmJsZsUaksF18QkSj1TggO3WMxZaUT?=
 =?us-ascii?Q?H/9ISG9rb96MxGTHEp68lurlHFePZ7CPcjq1Oap0c1lheYLat3Qr9rC0xSLU?=
 =?us-ascii?Q?5ftwDJhoGmXMvsKap6FScjS8CEejuThRmgu4o8aQjJ7Vdx1gycROGIGABf60?=
 =?us-ascii?Q?ueSOK5jbR2upaw2SM0zbugnZ94ZPRFKVtIaG5nv6YZnwiTKkBVtn6FZv2y+W?=
 =?us-ascii?Q?3vsgSorUz0cV4tK9imi24oKbFWoUmHGupQOPzlRTECQj/VTj8d8NdyUfpMlU?=
 =?us-ascii?Q?xbeHQo6Z8lKchPVQ6qQVhv59crZA3QtXtC9bqSjzCwMbqhEyzrkcZtC/UKqm?=
 =?us-ascii?Q?gnNeYECzLgVVWu9cSdQmEhqYMHI3vbL6cD/DMNFmz/fAF3Erwf/X9VDK3xMw?=
 =?us-ascii?Q?FBmfWcjrwLTY2IgavM5FvEsUYtPOvLcRm/M5HaFROMNlhf5scpgGw/K2aZp8?=
 =?us-ascii?Q?t8bAkDnvvpOB9togRlDn6d9BmhqUl7AlSwyz1Q5mGNbztjpCFV4Z/IctBfpQ?=
 =?us-ascii?Q?uW5BSMJytvNp+Zyh2Cv328WKBWVGXZkseQ/V76+JXpHy94JGAnTFwgL2Ffxn?=
 =?us-ascii?Q?ZJurqZY6HmBmFxOR7ZvO95EV5r+dwOxMfzJcq1tgEirjqxov6vWLfxQ6QvJa?=
 =?us-ascii?Q?/dVPjPXcf4a5n+mELKvyk7JYP9OaCWMl7nolWNzGlonUzjve1G4juJJlobdQ?=
 =?us-ascii?Q?Ljv8wAfhPHi868S/KaLKfWAdM3naJqk+IGHRkkzrlqNcY/RRI6FBQNDZa9uo?=
 =?us-ascii?Q?yeeqOEfN6kwSRwdGIjjwA8BENXJKxPw36CVda3af3UyQjmoMK5PMwAFzdO1e?=
 =?us-ascii?Q?/ejt4EGoNXkCBs1g0ZJNYLad+B2dYUpzuwPpdvPW5BSbKUQJ1BF8VFPHlhKm?=
 =?us-ascii?Q?e2yI7RYQL8kYz++7MMm1fDuGKJAuQsiHWJgD6iOK/WzrPqrRcfcajPCP/SIR?=
 =?us-ascii?Q?ug34sfMUOImC/uM89lhREk20LkKb6/BusWTBROuTLNHDzjWPadi3ADCBXV8J?=
 =?us-ascii?Q?lORhmtl0M/VHinFZEZbAWHg3YM6A+8BEPuwrQOO8RNc1g6zuFtakp8eIke0l?=
 =?us-ascii?Q?+M4zeNNhq4vtm/tR3ywqAxSQI9WLiFlh3ZGJfEE748lKZ/lQUbHmgJ1dOSsD?=
 =?us-ascii?Q?JUHJPWCj1n4CJVp9cc5QETQ6RDxE0jm59agTuZdP/e4Yr6gB915x9vCGC2l8?=
 =?us-ascii?Q?devhHDJ5QF6f3JECpVd1A0zBUwb6CN27wbUNDgonoXZSu7GJUHEljgv8+8HX?=
 =?us-ascii?Q?OS5aUbduU0BBkOepmd5G1V4B1FJ6/UuE+/+ENgb/fdkd2JzIvsazgObWhBkY?=
 =?us-ascii?Q?EP04QgfsLDhlX0wTirW3ViLPt42p473th5QRUFrm5chy3RhkGgI0zp1im4Qa?=
 =?us-ascii?Q?Ekhh8T6/Uq7687SnQwL1mFWShbJCHMS5YTnhaN3giQKccMTvdEVUbJHXcKLh?=
 =?us-ascii?Q?hRzJv59U0XLx2Rhy89iuhK1lJW6LFePoHUKb109zBBL4aGjL8DDzIpkLosoM?=
 =?us-ascii?Q?w7/ol14mlWZHYKBKgdd0rard2bEn02cVp0kkqlywt/YWmAqwzp8mODUU/Xt2?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea24e1c8-f1bb-45b8-371b-08db838431c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:33:19.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnHtSqADD+CikwpOjz4LDUMJwlh4+J+GCpcx8QO5uQDuTkPFuL1DAzahot+2v1Dk8cVGjp9cuDm3paB7qJOaCG1Ye15odkepkbxrg8eUHHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 03:06:21PM +0200, Guillaume Nault wrote:
> icmpv6_flow_init(), ip6_datagram_flow_key_init() and ip6_mc_hdr() don't
> need to modify their sk argument. Make that explicit using const.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


