Return-Path: <netdev+bounces-61110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153D18227AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 05:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE9B283FC3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 04:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91411723;
	Wed,  3 Jan 2024 04:02:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9624171B4
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T4bXp6n4sz1FHVX;
	Wed,  3 Jan 2024 11:58:02 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (unknown [7.185.36.178])
	by mail.maildlp.com (Postfix) with ESMTPS id 81C9A14041B;
	Wed,  3 Jan 2024 12:02:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:02:01 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 12:02:01 +0800
Subject: Re: [RFC iproute2 0/8] rdma: print related patches
To: Stephen Hemminger <stephen@networkplumber.org>, <leon@kernel.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <f20e633d-48af-197a-0124-3c20984fa4e0@huawei.com>
Date: Wed, 3 Jan 2024 12:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2024/1/3 8:34, Stephen Hemminger wrote:
> This set of patches makes rdma comman behave more like the
> other commands in iproute2 around printing flags.
> There are some other things found while looking at that code.
>
> Stephen Hemminger (8):
>    rdma: shorten print_ lines
>    rdma: use standard flag for json
>    rdma: make pretty behave like other commands
>    rdma: make supress_errors a bit
>    rdma: add oneline flag
>    rdma: do not mix newline and json object
>    rdma: remove duplicate forward declaration
>    rdma: remove unused rd argument
>
>   man/man8/rdma.8 | 12 +++++++--
>   rdma/dev.c      | 40 ++++++++++++++--------------
>   rdma/link.c     | 52 +++++++++++++++++-------------------
>   rdma/rdma.c     | 21 ++++++++++-----
>   rdma/rdma.h     | 10 +++----
>   rdma/res-cmid.c | 37 ++++++++++++--------------
>   rdma/res-cq.c   | 35 ++++++++++++------------
>   rdma/res-ctx.c  | 11 ++++----
>   rdma/res-mr.c   | 26 +++++++++---------
>   rdma/res-pd.c   | 21 +++++++--------
>   rdma/res-qp.c   | 50 +++++++++++++++++-----------------
>   rdma/res-srq.c  | 27 ++++++++++---------
>   rdma/res.c      | 39 +++++++++++----------------
>   rdma/res.h      | 18 +++++--------
>   rdma/stat-mr.c  | 10 +++----
>   rdma/stat.c     | 68 +++++++++++++++++++++-------------------------
>   rdma/stat.h     |  4 +--
>   rdma/sys.c      | 11 +++-----
>   rdma/utils.c    | 71 +++++++++++++++++++------------------------------
>   19 files changed, 267 insertions(+), 296 deletions(-)
>
Pretty mode works well. But there seems to be something wrong with 
oneline, which
puts all information on the same line. This behavior is different with ip.

```bash
[root@localhost iproute2]# ./rdma/rdma res show qp
link mlx5_0/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link mlx5_1/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link mlx5_2/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link hns_0/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link hns_1/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link hns_2/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]
link hns_3/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]

[root@localhost iproute2]# ./rdma/rdma res show qp -o
link mlx5_0/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core] \link 
mlx5_1/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core] \link 
mlx5_2/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core] \link hns_0/1 
lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core] \link hns_1/1 lqpn 1 
type GSI state RTS sq-psn 0 comm [ib_core] \link hns_2/1 lqpn 1 type GSI 
state RTS sq-psn 0 comm [ib_core] \link hns_3/1 lqpn 1 type GSI state 
RTS sq-psn 0 comm [ib_core] \[root@localhost iproute2]#

[root@localhost iproute2]# ./ip/ip -o a
1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever 
preferred_lft forever
1: lo    inet6 ::1/128 scope host \       valid_lft forever 
preferred_lft forever
10: eth8    inet6 fe80::9e52:f8ff:fe8e:f307/64 scope link \ valid_lft 
forever preferred_lft forever
11: eth9    inet6 fe80::268a:7ff:fe55:41d0/64 scope link \ valid_lft 
forever preferred_lft forever
```

Tested-by: Chengchang Tang <tangchengchang@huawei.com>

