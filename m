Return-Path: <netdev+bounces-29413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661897830E6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B508280EEC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F12F9CA;
	Mon, 21 Aug 2023 19:18:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B848F43
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:18:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D12CD3
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 12:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfPK1fzjKIcuaV/3PiYRa5OwARYNLfLfU6XILtW5zUeWg98mBRsNsQHK7xAu9BATcr/IfscMjxWYdSPSfHHICTvb/MSnUY3UyUnoEPEiuTs0b9iKMskjs6QnaPfLvR2FbebA3UIHS6bNlATokK1af54yTjAASAtgTHqN3Y5LpQ4wMqAp6JsIysYM6bH6gptAJ5XWZHX9fn1Q1ETtqx8jxxfPwoKOaaCPXTcVAuy/45nhRe8s/xFKyXpq4RoPayZWPqj9MBGx/VQ9T3YeaNSuz+dO2k+dyhignUlZUYSy/vVXS4P23LwIrNvPjVB3Bb9TpIzfmszQF7n+goi5EXfHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cJR5tTSFLB8DUFZ7aOvTtdHA/xXsnEp4uB2D+Zc3CQ=;
 b=b7ZoEpINP7i6DdMCSzmnQyxiuSJuRH+mcgFiLa2qkyBI78+53WJFrXvDwnAWc9nywzNWesnQJgpK+6bl3W6fedB53bT8BmmdAFiVYMplWgOhXQbkhCLVUg3wMsMyt53g3XsmlGWQZy75LmxmIUHgeQ5a/lXBSM1WT/mB/ogBV7s0vYRIWB+rPZhIZ/EZVcQEbzAw7oVetykwKJlud5lgpXEsi/k26BrQsJcvPhqacHyDZg3pLEpgg0UlQojYXSPuVya29cB4P0R6ntuLgU/GVXNGgMJnr1X8pJfkVEsMv2eDrSYVXK12ESXuX8Q7MAKdmCCy7FWNi4nfCgibuKl3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=mojatatu.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cJR5tTSFLB8DUFZ7aOvTtdHA/xXsnEp4uB2D+Zc3CQ=;
 b=dtzYhWh2OZWTjbRY5Q9tHSUt00snYRRCTrvQrBZ57hQUlSLnfxjhssSs0imJxGRsyzfbQoYau7iCqxZ9jAk5ri8mVRhz/8Nj2qNGinu0faZBRSguPdALQDttdEJ/NG+2sf3kaK2XuL/KzXjUHxPvf4Z40b0WIBob1CXjqqhTbu+M/A1LARHZaDQl+MMXrftPCQKVOp7/Ff81bKBUjlFCkzT3AkpN8G+QGdhxUSG5Nca+jgNSXT0snf5mLRXHM0GbPlW6eid9w+WQ6piSoAbLvnWi3cZ/jrBhltr+KbNX0xsTgEk/nIpgXx/bNDGr2ldzxxIbXqBpobtRlknS4ya0cw==
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:17:56 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::e3) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.11 via Frontend
 Transport; Mon, 21 Aug 2023 19:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 19:17:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 12:17:44 -0700
Received: from fedora.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 12:17:40 -0700
References: <20230819163515.2266246-1-victor@mojatatu.com>
 <20230819163515.2266246-2-victor@mojatatu.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Victor Nogueira <victor@mojatatu.com>
CC: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <mleitner@redhat.com>,
	<horms@kernel.org>, <pctammela@mojatatu.com>, <kernel@mojatatu.com>
Subject: Re: [PATCH net-next v2 1/3] net/sched: Introduce tc block netdev
 tracking infra
Date: Mon, 21 Aug 2023 22:12:51 +0300
In-Reply-To: <20230819163515.2266246-2-victor@mojatatu.com>
Message-ID: <871qfw6w8d.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: c8252c09-d05b-479e-4713-08dba27b5345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HUa9d7OD1tpswH8tIHKIvlt3HRxSCWzcST8MMr93rx4YFSQ/dGOC0pX4Qn4EhzoZxE9Df9PTvmrjJrRuZ+Ttt0vgTgbNglBa5xPPf9XooMoW+Gn/+WnDvKJzDcLQFZS4Rv80eEUrMrDJvHUcyrCs+jbVRirBoWozQEfnjOKKTVp4aUUkDh6uk1SparYXXhAqrAHV3dMvnUclBszOANj8tuTt3y4uBQSF3pxvVfttncvELxrX9mskydukarBJEItf9BTshoIuTZjBnakPdhXjn7LxGk1aCERwcZ5REbdQWMZHuto+OEhlJRyzOY25aIvBQEgmx0zDw3qia2zTQqurmSqZv5xeXI/NfUaGOhPymOzjRz/aewIbH5tJR7CkSh3/1KKpLazjpMAC3WruAztywKxm8iW9BJTk64x3i8dkJ8Fk34A8U4vzyJln5CHwtZ9HzHY5QbTSImlK2GdRr3a3kOvSvZv/j5tzTe4/XMKGFNeRHvAlF91j4BPY+mchbq1RbCZetWSdCG9i7yTsPrkM6DyKeOG2ZcYV/weOMfZ07x3LukspZaqzPESWiwCaJACxKB3fWnGoQ4mWJOfDIKr8kZYeM+HL+qSO+Aaatjc/8vArZRXgvXkTxRJLZYnEgflXDUFLljuBpaH+SKO5RlLI18AiUGRGjrlP4kc2eKVQk+OPb1io0CC8Y33jWpuAGbWdp5sUG9hm4abAo064rpYEztHKxer9p2JZ+ElgwCV2op1bM6/HD1exW6frIKJKPmH1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7416002)(7696005)(40480700001)(5660300002)(336012)(426003)(16526019)(26005)(36860700001)(47076005)(86362001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:17:56.3533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8252c09-d05b-479e-4713-08dba27b5345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Sat 19 Aug 2023 at 13:35, Victor Nogueira <victor@mojatatu.com> wrote:
> The tc block is a collection of netdevs/ports which allow qdiscs to share
> filter block instances (as opposed to the traditional tc filter per port).
> Example:
> $ tc qdisc add dev ens7 ingress block 22
> $ tc qdisc add dev ens8 ingress block 22
>
> Now we can add a filter using the block index:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action drop
>
> Up to this point, the block is unaware of its ports. This patch fixes that
> and makes the tc block ports available to the datapath as well as control
> path on offloading.
>
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  include/net/sch_generic.h |  4 ++
>  net/sched/cls_api.c       |  1 +
>  net/sched/sch_api.c       | 79 +++++++++++++++++++++++++++++++++++++--
>  net/sched/sch_generic.c   | 34 ++++++++++++++++-
>  4 files changed, 112 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index e92f73bb3198..824a0ecb5afc 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -19,6 +19,7 @@
>  #include <net/gen_stats.h>
>  #include <net/rtnetlink.h>
>  #include <net/flow_offload.h>
> +#include <linux/xarray.h>
>  
>  struct Qdisc_ops;
>  struct qdisc_walker;
> @@ -126,6 +127,8 @@ struct Qdisc {
>  
>  	struct rcu_head		rcu;
>  	netdevice_tracker	dev_tracker;
> +	netdevice_tracker	in_block_tracker;
> +	netdevice_tracker	eg_block_tracker;
>  	/* private data */
>  	long privdata[] ____cacheline_aligned;
>  };
> @@ -458,6 +461,7 @@ struct tcf_chain {
>  };
>  
>  struct tcf_block {
> +	struct xarray ports; /* datapath accessible */
>  	/* Lock protects tcf_block and lifetime-management data of chains
>  	 * attached to the block (refcnt, action_refcnt, explicitly_created).
>  	 */
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index a193cc7b3241..a976792ef02f 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1003,6 +1003,7 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
>  	refcount_set(&block->refcnt, 1);
>  	block->net = net;
>  	block->index = block_index;
> +	xa_init(&block->ports);

Missing dual call to xa_destroy() for this.

>  
>  	/* Don't store q pointer for blocks which are shared */
>  	if (!tcf_block_shared(block))
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index aa6b1fe65151..6c0c220cdb21 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1180,6 +1180,71 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>  	return 0;
>  }
>  
> +static void qdisc_block_undo_set(struct Qdisc *sch, struct nlattr **tca)
> +{
> +	if (tca[TCA_INGRESS_BLOCK])
> +		sch->ops->ingress_block_set(sch, 0);
> +
> +	if (tca[TCA_EGRESS_BLOCK])
> +		sch->ops->egress_block_set(sch, 0);
> +}
> +
> +static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
> +			       struct nlattr **tca,
> +			       struct netlink_ext_ack *extack)
> +{
> +	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
> +	struct tcf_block *in_block = NULL;
> +	struct tcf_block *eg_block = NULL;
> +	unsigned long cl = 0;
> +	int err;
> +
> +	if (tca[TCA_INGRESS_BLOCK]) {
> +		/* works for both ingress and clsact */
> +		cl = TC_H_MIN_INGRESS;
> +		in_block = cl_ops->tcf_block(sch, cl, NULL);
> +		if (!in_block) {
> +			NL_SET_ERR_MSG(extack, "Shared ingress block missing");
> +			return -EINVAL;
> +		}
> +
> +		err = xa_insert(&in_block->ports, dev->ifindex, dev, GFP_KERNEL);
> +		if (err) {
> +			NL_SET_ERR_MSG(extack, "ingress block dev insert failed");
> +			return err;
> +		}
> +
> +		netdev_hold(dev, &sch->in_block_tracker, GFP_KERNEL);
> +	}
> +
> +	if (tca[TCA_EGRESS_BLOCK]) {
> +		cl = TC_H_MIN_EGRESS;
> +		eg_block = cl_ops->tcf_block(sch, cl, NULL);
> +		if (!eg_block) {
> +			NL_SET_ERR_MSG(extack, "Shared egress block missing");
> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		err = xa_insert(&eg_block->ports, dev->ifindex, dev, GFP_KERNEL);
> +		if (err) {
> +			netdev_put(dev, &sch->eg_block_tracker);
> +			NL_SET_ERR_MSG(extack, "Egress block dev insert failed");
> +			goto err_out;
> +		}
> +		netdev_hold(dev, &sch->eg_block_tracker, GFP_KERNEL);
> +	}
> +
> +	return 0;
> +err_out:
> +	if (in_block) {
> +		xa_erase(&in_block->ports, dev->ifindex);
> +		netdev_put(dev, &sch->in_block_tracker);
> +		NL_SET_ERR_MSG(extack, "ingress block dev insert failed");
> +	}
> +	return err;
> +}
> +
>  static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>  				   struct netlink_ext_ack *extack)
>  {
> @@ -1270,7 +1335,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  	sch = qdisc_alloc(dev_queue, ops, extack);
>  	if (IS_ERR(sch)) {
>  		err = PTR_ERR(sch);
> -		goto err_out2;
> +		goto err_out1;
>  	}
>  
>  	sch->parent = parent;
> @@ -1289,7 +1354,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  			if (handle == 0) {
>  				NL_SET_ERR_MSG(extack, "Maximum number of qdisc handles was exceeded");
>  				err = -ENOSPC;
> -				goto err_out3;
> +				goto err_out2;
>  			}
>  		}
>  		if (!netif_is_multiqueue(dev))
> @@ -1311,7 +1376,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  
>  	err = qdisc_block_indexes_set(sch, tca, extack);
>  	if (err)
> -		goto err_out3;
> +		goto err_out2;
>  
>  	if (tca[TCA_STAB]) {
>  		stab = qdisc_get_stab(tca[TCA_STAB], extack);
> @@ -1350,6 +1415,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  	qdisc_hash_add(sch, false);
>  	trace_qdisc_create(ops, dev, parent);
>  
> +	err = qdisc_block_add_dev(sch, dev, tca, extack);
> +	if (err)
> +		goto err_out4;
> +
>  	return sch;
>  
>  err_out4:
> @@ -1360,9 +1429,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  		ops->destroy(sch);
>  	qdisc_put_stab(rtnl_dereference(sch->stab));
>  err_out3:
> +	qdisc_block_undo_set(sch, tca);

Is this a bugfix? This new call is for all sites that jump to
err_out{3|4} even though you only added new code to the end of the
function.

> +err_out2:
>  	netdev_put(dev, &sch->dev_tracker);
>  	qdisc_free(sch);
> -err_out2:
> +err_out1:
>  	module_put(ops->owner);
>  err_out:
>  	*errp = err;
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 5d7e23f4cc0e..0fb51fd6f01e 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -1048,7 +1048,12 @@ static void qdisc_free_cb(struct rcu_head *head)
>  
>  static void __qdisc_destroy(struct Qdisc *qdisc)
>  {
> -	const struct Qdisc_ops  *ops = qdisc->ops;
> +	struct net_device *dev = qdisc_dev(qdisc);
> +	const struct Qdisc_ops *ops = qdisc->ops;
> +	const struct Qdisc_class_ops *cops;
> +	struct tcf_block *block;
> +	unsigned long cl;
> +	u32 block_index;
>  
>  #ifdef CONFIG_NET_SCHED
>  	qdisc_hash_del(qdisc);
> @@ -1059,11 +1064,36 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
>  
>  	qdisc_reset(qdisc);
>  
> +	cops = ops->cl_ops;
> +	if (ops->ingress_block_get) {
> +		block_index = ops->ingress_block_get(qdisc);
> +		if (block_index) {
> +			cl = TC_H_MIN_INGRESS;
> +			block = cops->tcf_block(qdisc, cl, NULL);
> +			if (block) {
> +				if (xa_erase(&block->ports, dev->ifindex))
> +					netdev_put(dev, &qdisc->in_block_tracker);
> +			}
> +		}
> +	}
> +
> +	if (ops->egress_block_get) {
> +		block_index = ops->egress_block_get(qdisc);
> +		if (block_index) {
> +			cl = TC_H_MIN_EGRESS;
> +			block = cops->tcf_block(qdisc, cl, NULL);
> +			if (block) {
> +				if (xa_erase(&block->ports, dev->ifindex))
> +					netdev_put(dev, &qdisc->eg_block_tracker);
> +			}
> +		}
> +	}
> +
>  	if (ops->destroy)
>  		ops->destroy(qdisc);
>  
>  	module_put(ops->owner);
> -	netdev_put(qdisc_dev(qdisc), &qdisc->dev_tracker);
> +	netdev_put(dev, &qdisc->dev_tracker);
>  
>  	trace_qdisc_destroy(qdisc);


