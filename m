Return-Path: <netdev+bounces-34619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819357A4DE3
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C7E280C8B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7A20B05;
	Mon, 18 Sep 2023 16:02:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F27208A1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 16:02:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245A2D69
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiAaPAe9/4ngRWDpZOWigfkhL26B+8HNFlru8DQ0AizRinp5E9Xi1dPM5iH1Fj3Z9YbF5Ydahm4OFsm3WY5cm4fIphMmD47gSgA341a2R1vBCEVZ5i7dlw4gHGAUpX9Uvj+k+p9lJKbddPkiagAP4kG0Xfc/CpzW5NJpafJlW1eWCLYoUkz5ka8/xQ60GSl6xOOx8ndRYiC5oviB0Q02L4GpIDCZfA8iocqUcrM+13AYj1FwLGXDBi0ccIg4XS8ZXfpJv+iP/Kp153x97zPvMzAZTEb6kLeoZUcHvhHEYebPEWIbVsi1H4/6+4OMhAMEQFQYm67V4M1IELhG2RPDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ONgcusYThNfdzAraX7j03g7dchPLesapLroz3L/uBo=;
 b=k/OmIRTOcsqFw2n7ZOEYDW5EPtVookH66V1fX4AaegN02dXBx+fG1Cnr6+KwDsiurm607DldwOdTIa2x04q1cnZYZRwr6JwtvUV4VodRiZssHlFBFXok/pZg9qZBBn9QDEjzktbfjDkn2UeJi7Db4NvqIXfuQwbbL7ykWp5Ekx5bux9KDt+d27Xl9hJLVIHkEft4WZoDLVHLVpyjRmBQ8RbdqTmNzXE5TC36Sz2tQhQ6fJ+KDEcE4iOTUYd+HNe7wCdSUCy28rqRkS8M0Zg5o1TlQQlgj1DBK78spzFeEH4XeaVcYzrCvhsv/vxU6BWlEpIrgBLfeKdaZ7t716Qwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ONgcusYThNfdzAraX7j03g7dchPLesapLroz3L/uBo=;
 b=PvwoBa88lWMPG8PVzViMJHS1mpyW4j+dgvfeX6VZIsQQq7eCODG1I2IqOXSJIlV5Q7Za7ZBaacmfAQEbRZzfebnVTncm1PY7A5NZp6irINZIgz+mEIHcWIBhPFPhrZ40jSuJ2CeB93cpogs4A/Nkdh//V85NMhPOjIEuXXpxcHi4wRfsNkzc4o2402MVDjR7FEg8gWy1ovapwARX4FvKBDMUoBgb9UpQ7L4JTBiK0o+Rik71gbCmKIWDcLjufJwVxJqXbvlW6BblwxHr3YZo65t3GQFVRpWZ3uDpW22uWqBSYW2iG3BA+X/Xqr5e9acJqHy7SHrhuUaPSiwidraJCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 15:41:51 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::31e8:f2df:2902:443d]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::31e8:f2df:2902:443d%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:41:51 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Benc <jbenc@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Li Zetao <lizetao1@huawei.com>,
	Thomas Graf <tgraf@suug.ch>,
	Tom Herbert <therbert@google.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH net] vxlan: Add missing entries to vxlan_get_size()
Date: Mon, 18 Sep 2023 11:40:15 -0400
Message-Id: <20230918154015.80722-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::47) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 677ace90-45d0-44fd-cb56-08dbb85dc6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NcwF/bF33JuR+uTqJbsbiImzlTpmGrwhmnl2C44d0O3vj7RJSWDZwZoY8J9NEkuXOtzMb1obBgqy23GZuZrPQz4wXbQ6mJsNITPX5QR0XZsEo6byG6TT9tclCzZ/9eRQju1XiF3GT5fTRVXOLVE/jWVxnVZwPDPCrmJJBVyCkGfuSANmbwPVySGGJuDhIqoS9RN+37Uaz601P2NhmxS6cRW/DGRB1M+4HEXfsCUxeQaIgeFpBG0TgGEkV9yq5iG+eE/IYFMe3nMRugwqG3ugMonDWP9cv38Bu9TILuiXax/VcJj/Eo9aOal3ugOIuyucc4kS8sxRxBr2vhPxzoozBiDsRKyNkHAzxlQzc9b8ZKyZz2vzUWhBilfHYkg4y9m04E7DlMcpzIkflGPwrzyNDW+tMtgZtkbnfciiNV4aaJUZO2+tPM1RxQmN5P4UfzvCsb15ERpZywteVT4UEWQNznCHtNxxsWv1lqMU+2F394+RsGfBJ7F2TzgGw7F4+rUiDg4KgbDl01VItTBkN5MhWOJYRVu5CuYM5Ruu0CA8u7tBcXBkyTTR8ohCoRT2nG+N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(1800799009)(186009)(451199024)(5660300002)(26005)(107886003)(1076003)(8936002)(4326008)(8676002)(2616005)(2906002)(7416002)(86362001)(38100700002)(36756003)(83380400001)(66946007)(6506007)(6486002)(66476007)(54906003)(66556008)(6666004)(478600001)(6512007)(41300700001)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBJ5a/eSxK6EtU8OC+dpqG4SVf+Iic4jSUpqk/ZOczun3o0UYXfI1Cxr4SBB?=
 =?us-ascii?Q?gjydC/WsQ4ndP2+xxIG2WA4vxucOraQUNgj74vMdQtYJdHvI8NKeU1mhMU4E?=
 =?us-ascii?Q?m1sIzONvj5xV4f0FpWnjsMq3QTJJur0XiMLECWbqoZBt21BwMBD0I7S2RW3t?=
 =?us-ascii?Q?uHxB4r58a8ED8lIcrTrNeH18sV5uLsBlHvenEcPaN+n+pSAAkVjbEYb5qEc5?=
 =?us-ascii?Q?0IoQ/iWXboGZ2U4aIe41IhbGCmxjkoTBx38PueYV1Hai0I/yrAZ43BGy3A5t?=
 =?us-ascii?Q?EjrCxvz5sgZwFmlPtG4IdhJXz3xZ23CFbLETW6epxWSzqBR/g3xJs1b7Jvvp?=
 =?us-ascii?Q?2ZrlVKANM9GOlVoRcRK3lD2vpEE+Wwb44r+zWjat7vT6Rhh3PnurE8bfEaHS?=
 =?us-ascii?Q?B9vDRtm2SFfLJ1yfK7efAPFwVvoBRN7SVJFBjt9QYwM170f/XQM3RhPKEM1a?=
 =?us-ascii?Q?rVa538SwrBzuIjji7IRNZfTNL68+78aVMoOk2H2ytwckP6FmLXXFpUYYOc/p?=
 =?us-ascii?Q?TMO1Xm9D23ZbgovWcs5mr6ClM5DSOOWDB12iZeC+pHOca4d6howkZwYS42C9?=
 =?us-ascii?Q?1hWuQImg+OH36PWpkqfAbITEIMfS1yvJLN+0itPd5/kmHNBnqkwo0v/wQB0t?=
 =?us-ascii?Q?BPulAndIE6zBvchmMHJ96R5h/sBaQviMoM8tDSpvGAjPyBqO6X5BsT0Ty6Hm?=
 =?us-ascii?Q?SzNGY7066nr2eFZo+KbXKehgqdzUOgcHSV4ZhqLi2YB8KTN9B/yovev2mAON?=
 =?us-ascii?Q?2vEr+KzW3I/9KwFGzMO1WVf6u9exiLxWLrOw3H78BtUTG3AGiUoCs4zevp/r?=
 =?us-ascii?Q?/dIgWxJfpndZpMri7j8Te2riwfOlwmB9BC/BRiqq7HZyl5Cz1f1dpbBJppGN?=
 =?us-ascii?Q?Xy2Zz4wSTojBj0IHix6simvz+bZBkFYh02Sqwa5GsgNdJ13C0nPO8TjJZEGZ?=
 =?us-ascii?Q?0e6NZL3yfo3S42/QBZGvbBGBl/mJvcCNqFpaloAgv4G2etqfsVcd2tHMZdPt?=
 =?us-ascii?Q?nHUgmn4VR29BK5pD/CbyhKjAvCdsFwr9slsM8kr/ro9WWmKnaeV+OIuDQMc9?=
 =?us-ascii?Q?/YWJzww/rneTs6lSWC/pYeB9AePQG2nUiT+b35NN/JKaDAwytMIrRkKRsrPT?=
 =?us-ascii?Q?MyTo92RaKvc0/8VQ5ECnjLait28S02goopvBqm5Mdstc5Wvp15oeNrOaqonq?=
 =?us-ascii?Q?7sGRU3b+sWDMojDETvSQ6jIZ2TDgYFxq95xsDRXPwJgQaa4HhaUKQs90NDaB?=
 =?us-ascii?Q?LmB3yCSSH6L4H/sM00krb37GUjT1flswvPuRb2Wu1dFAE+gbr0lHyh2nj+rT?=
 =?us-ascii?Q?Ezpt6Kqul37PsYqEdXfdLss0iWkCDA3ax/QxMH+se09qCFaYfSR5nDagUJU2?=
 =?us-ascii?Q?VYne+t5YPeIdQ4WHNXjOsx9dcDH2qiGT2WxQoMFhg6gvLpiD2vHcchrKEF7Y?=
 =?us-ascii?Q?9f+n2Mv4MsILsSCKCSX8PzgmJac1YC0QKVHDVqxG2N/JKsVKDCVwKpEu+v6R?=
 =?us-ascii?Q?qp/eBF6cYjjTdFljfQSoCeIiSyj0dOGZum7LeSSHA1TlzjEXb5T8ltYr8+Mn?=
 =?us-ascii?Q?8TvF1XvbJjiIbdTSR7wztdJl+nq8PT08+Tu0NgRa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ace90-45d0-44fd-cb56-08dbb85dc6b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:41:50.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDZChdKQ1T5/mSWwgxkE0E0/HaKjkV/r5HcBCy51Pf0lG23QAN5x4qhtUoLUBmQbibUtmSvIH5Hj+BtUNXVwbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are some attributes added by vxlan_fill_info() which are not
accounted for in vxlan_get_size(). Add them.

I didn't find a way to trigger an actual problem from this miscalculation
since there is usually extra space in netlink size calculations like
if_nlmsg_size(); but maybe I just didn't search long enough.

Fixes: 3511494ce2f3 ("vxlan: Group Policy extension")
Fixes: e1e5314de08b ("vxlan: implement GPE")
Fixes: 0ace2ca89cbd ("vxlan: Use checksum partial with remote checksum offload")
Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e463f59e95c2..5b5597073b00 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4331,6 +4331,10 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBYPASS */
+		nla_total_size(0) + /* IFLA_VXLAN_GBP */
+		nla_total_size(0) + /* IFLA_VXLAN_GPE */
+		nla_total_size(0) + /* IFLA_VXLAN_REMCSUM_NOPARTIAL */
+		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
 		0;
 }
 
-- 
2.40.1


