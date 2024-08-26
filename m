Return-Path: <netdev+bounces-121775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882895E775
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 05:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405FC1F214A7
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 03:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6784426289;
	Mon, 26 Aug 2024 03:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E41373;
	Mon, 26 Aug 2024 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724644353; cv=none; b=i0+yDVeKAYjv5jm1PHhCfQhEJII7J8v+SpfdE31hYFwjCP8AZfhPdN7GMPDoUomUNzl7VMeVBAg07hIZ0eLRSGP5tTUmpF9XxfNLp38bndQILm1IrW4Sum+Rj0mFj3dX21eZFzfOilchAGqnnXYlmnBYj1VDpLXDeCUFlghgu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724644353; c=relaxed/simple;
	bh=SD63059dnQ98be+o1rkrcvanrHAW1WbyLURqeN58Bfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nu/kem0/Vi24jjigocMX25+l45Z9T6MHGdEY5abJtn/O5HtulWVpmENkx3aoXTnKZdSqkPX+Jzog63UZXx4sTkxrljBfL82FoUbvV8D235zvTZdrb9ba8HUy+DkfNS87g8s3B+NQ+k35OBvQuR5/dmUg7rGInmpzRPRHMn2PNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wsc9f2yr1z1HHLW;
	Mon, 26 Aug 2024 11:49:10 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A01361A0188;
	Mon, 26 Aug 2024 11:52:27 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 11:52:26 +0800
Message-ID: <680d81a5-27e3-0d56-d53d-2159928e53ad@huawei.com>
Date: Mon, 26 Aug 2024 11:52:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
 <20240821171817.3b935a9d@kernel.org>
 <2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
 <20240822075123.55da5a5a@kernel.org>
 <0d2ac86a-dc01-362a-e444-e72359d1f0b7@huawei.com>
 <af8c128a-ff6c-4441-9ab5-c0401900db76@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <af8c128a-ff6c-4441-9ab5-c0401900db76@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/26 7:28, Andrew Lunn wrote:
> On Fri, Aug 23, 2024 at 02:35:04PM +0800, Jinjie Ruan wrote:
>>
>>
>> On 2024/8/22 22:51, Jakub Kicinski wrote:
>>> On Thu, 22 Aug 2024 10:07:25 +0800 Jinjie Ruan wrote:
>>>> On 2024/8/22 8:18, Jakub Kicinski wrote:
>>>>> On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:  
>>>>>> Use scoped for_each_available_child_of_node_scoped() when iterating over
>>>>>> device nodes to make code a bit simpler.  
>>>>>
>>>>> Could you add more info here that confirms this works with gotos?
>>>>> I don't recall the details but I thought sometimes the scoped
>>>>> constructs don't do well with gotos. I checked 5 random uses
>>>>> of this loop and 4 of them didn't have gotos.  
>>>>
>>>> Hi, Jakub
>>>>
>>>> From what I understand, for_each_available_child_of_node_scoped() is not
>>>> related to gotos, it only let the iterating child node self-declared and
>>>> automatic release, so the of_node_put(iterating_child_node) can be removed.
>>>
>>> Could you either test it or disasm the code to double check, please?
>>
>> Hi, Jakub, I test it with a fake device node on QEMU with a simple
>> example using for_each_available_child_of_node_scoped() and goto out of
>> the scope of for_each_available_child_of_node_scoped(), the
>> of_node_put(child) has been called successfully.
> 
> What compiler version?
> 
> Please test with 5.1

with 5.1, the result is same and of_node_put(child) has been called
successfully.

The test patch and test result is below (with CONFIG_OF_DYNAMIC=y)

trace event string verifier disabled
rcu: Hierarchical RCU implementation.
rcu:    RCU event tracing is enabled.
rcu:    RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
get ppi-partitions ok!
OF: ====================================== of_node_put interrupt-partition-0
of_get_child_count parts_node 2!
OF: ====================================== of_node_put interrupt-partition-0
OF: of_irq_init: Failed to init /interrupt-controller@1e001000
((ptrval)), parent 00000000



diff --git a/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
index 43a5a4ab6ff0..79715727ea03 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
@@ -161,6 +161,16 @@ gic: interrupt-controller@1e001000 {
                interrupt-controller;
                reg = <0x1e001000 0x1000>,
                      <0x1e000100 0x100>;
+
+               ppi-partitions {
+                       ppi_cluster0: interrupt-partition-0 {
+                               affinity = <&A9_0 &A9_1>;
+                       };
+
+                       ppi_cluster1: interrupt-partition-1 {
+                               affinity = <&A9_2 &A9_3>;
+                       };
+               };
        };

        L2: cache-controller@1e00a000 {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 3be7bd8cd8cd..35e1387453f5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1468,10 +1468,39 @@ gic_of_init(struct device_node *node, struct
device_node *parent)
 {
        struct gic_chip_data *gic;
        int irq, ret;
+       struct device_node *parts_node;
+       int nr_parts;

        if (WARN_ON(!node))
                return -ENODEV;

+       parts_node = of_get_child_by_name(node, "ppi-partitions");
+       if (!parts_node)
+               return -1;
+
+       pr_err("get ppi-partitions ok!\n");
+
+       nr_parts = of_get_child_count(parts_node);
+
+       if (!nr_parts) {
+               pr_err("of_get_child_count parts_node error!\n");
+               return -1;
+       }
+
+       pr_err("of_get_child_count parts_node %d!\n", nr_parts);
+
+       /*for_each_child_of_node(parts_node, child_node) {
+               if (true) {
+                       pr_err("of_node_put child_node
%s\n",child_node->name);
+                       of_node_put(child_node);
+                       return -1;
+               }
+       }*/
+       for_each_available_child_of_node_scoped(parts_node, child_node) {
+               if (true)
+                       goto exit;
+       }
+
        if (WARN_ON(gic_cnt >= CONFIG_ARM_GIC_MAX_NR))
                return -EINVAL;

@@ -1509,6 +1538,9 @@ gic_of_init(struct device_node *node, struct
device_node *parent)

        gic_cnt++;
        return 0;
+
+exit:
+       return -EINVAL;
 }
 IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
 IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 110104a936d9..d9ccf3117dff 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -46,8 +46,11 @@ EXPORT_SYMBOL(of_node_get);
  */
 void of_node_put(struct device_node *node)
 {
-       if (node)
+       if (node) {
+               if (!strcmp(node->name, "interrupt-partition-0"))
+                       pr_err("======================================
of_node_put interrupt-partition-0\n");
                kobject_put(&node->kobj);
+       }
 }
 EXPORT_SYMBOL(of_node_put);



> 
> https://www.kernel.org/doc/html/next/process/changes.html
> 
> 	Andrew

