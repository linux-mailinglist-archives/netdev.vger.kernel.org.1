Return-Path: <netdev+bounces-67576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAA8441B0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDF3B2809D
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DE80C0F;
	Wed, 31 Jan 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T8kQL6SL"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503B5A7A1
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710770; cv=none; b=grogCnuNPyy2pcaTE1hoPU49w7ml5KQAFIHJ1YF5G54GrrVwYqGPvVfISLuhTq+y+LYmNYEaImwBJzn15pn8F9+VREo/GotgveP98l7w4AZ+WO22Eyk7j5jsmVPWqQtJG5wPCJUISnsZDNfw4kBLSeSPPOH75vGMVh0lNW5vb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710770; c=relaxed/simple;
	bh=Lif18p+1paphhVOHWJF2RVPGhBgIwHy+Wxrwj/QA8GQ=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:Cc:
	 In-Reply-To:Content-Type; b=t4mJymRFDxXqoaF3/ZHhrNyfTl8MP0q2uV8TZ1cjhLHRxq15bcTq++UTyJKkNl+skeflKEbtHUjdS2x+ju3uuUVcLq9MOO16ywqeKXb40uANLtCtjuV9UaOB/ScO9rFapyAyRy8yJacNJnPhRkMWG3XmLB0lsdQUSSTrS1XHlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T8kQL6SL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=sWh5ZAloUoFUdWxlA40LiPSAjHtktCGH3Xq+AgvEf9Y=;
	b=T8kQL6SLIv/VProZKrMhvz3znoHtJNYBTPuTGR3ro4EOXVwKgrVxNbih4YYKf8
	U0LNRJBUcPT6AWRhxOV9DvsH1LqFgfZmkgTpTHmIbJZqfgCcgbWM1yMMlNXFM9b5
	RC+3292/n/9GIX0XyLfJLnbLV60k1pk3ECLql7s9zthoE=
Received: from [10.32.80.13] (unknown [210.12.126.226])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3f3rfVrplvM0ZAA--.4851S2;
	Wed, 31 Jan 2024 22:19:12 +0800 (CST)
Message-ID: <ea5264d6-6b55-4449-a602-214c6f509c1e@163.com>
Date: Wed, 31 Jan 2024 22:19:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Report mlx5_core crash
Content-Language: en-US
References: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
To: saeedm@nvidia.com, roid@nvidia.com, dchumak@nvidia.com,
 vladbu@nvidia.com, paulb@nvidia.com
From: Tao Liu <taoliu828@163.com>
Cc: netdev@vger.kernel.org, taoliu828@163.com
In-Reply-To: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
X-Forwarded-Message-Id: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3rfVrplvM0ZAA--.4851S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW3Jr4xKw17tryDXFWfuFg_yoWrXw17pF
	13K39rCr4Dta4DKr4xtayUXrn0va1qvF95ZFykuw1Fg34q934kJF1kXw48uryDGryUtay7
	Ww1Duw1DAa15WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUseOPUUUUU=
X-CM-SenderInfo: xwdrzxbxysmqqrwthudrp/1tbiPQB2FGVOBbMSrAABs9

Hi Mellanox team,

    We hit a crash in mlx5_core which is similar with commit
    de31854ece17 ("net/mlx5e: Fix nullptr on deleting mirroring rule").
    But they are different cases, our case is:
    in_port(...),eth(...) \
actions:set(tunnel(...)),vxlan_sys_4789,set(tunnel(...)),vxlan_sys_4789,...

      BUG: kernel NULL pointer dereference, address: 0000000000000270
      RIP: 0010:del_sw_hw_rule+0x29/0x190 [mlx5_core]
      Call Trace:
       tree_remove_node+0x1a/0x50 [mlx5_core]
       mlx5_del_flow_rules+0x54/0x170 [mlx5_core]
       __mlx5_eswitch_del_rule+0x4b/0x190 [mlx5_core]
       ? __update_load_avg_se+0x29a/0x320
       mlx5e_tc_rule_unoffload+0x4b/0xc0 [mlx5_core]
       mlx5e_tc_del_fdb_flow+0x1e2/0x2e0 [mlx5_core]
       __mlx5e_tc_del_fdb_peer_flow+0xcd/0x100 [mlx5_core]
       mlx5e_tc_del_flow+0x42/0x220 [mlx5_core]
       mlx5e_flow_put+0x26/0x60 [mlx5_core]
       mlx5e_delete_flower+0x25a/0x3a0 [mlx5_core]
       tc_setup_cb_destroy+0xae/0x170
       fl_hw_destroy_filter+0x9f/0xc0 [cls_flower]
       __fl_delete+0x325/0x340 [cls_flower]
       fl_delete+0x36/0x80 [cls_flower]
       tc_del_tfilter+0x34d/0x6d0
       ? tc_get_tfilter+0x450/0x450
       rtnetlink_rcv_msg+0x2de/0x380
       ? copyout+0x1c/0x30
       ? rtnl_calcit.isra.39+0x110/0x110
       netlink_rcv_skb+0x50/0x100
       netlink_unicast+0x1a5/0x280
       netlink_sendmsg+0x253/0x4c0
       ? _copy_from_user+0x26/0x50
       sock_sendmsg+0x5b/0x60
       ____sys_sendmsg+0x1ef/0x260
       ? copy_msghdr_from_user+0x5c/0x90
       ? ____sys_recvmsg+0xe6/0x170
       ___sys_sendmsg+0x7c/0xc0
       ? copy_msghdr_from_user+0x5c/0x90
       ? inet_ioctl+0x187/0x1d0
       ? ___sys_recvmsg+0x89/0xc0
       ? _copy_to_user+0x1c/0x30
       ? sock_do_ioctl+0xd3/0x150
       ? __fget_light+0xca/0x110
       __sys_sendmsg+0x57/0xa0
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

     As digging into the coredump, there are some data shared:

       crash> struct mlx5_flow_rule 0xffff88852a158840
       struct mlx5_flow_rule {
         node = {
             list = {
                   next = 0xffff88852a158fc0,
                   prev = 0xffff88817d405090
                 },
             children = {
                   next = 0xffff88852a158850,
                   prev = 0xffff88852a158850
                 },
             type = FS_TYPE_FLOW_DEST,
             parent = 0x0,                 <---------- crash here
             root = 0x0,
             ...
          },
         dest_attr = {
             type = MLX5_FLOW_DESTINATION_TYPE_VPORT,
             {
                   ...
                   vport = {
                           num = 65535,
                           vhca_id = 1,
                           pkt_reformat = 0xffff890291911840, <----------
                           flags = 3 '\003'
                         },
                 }
           },
       }

       crash> struct mlx5_flow_handle ffff88805d87ca40
       struct mlx5_flow_handle {
         num_rules = 0x6,
         rule = 0xffff88805d87ca48
       }
       crash>
       crash> x/6xg 0xffff88805d87ca48
       0xffff88805d87ca48:     0xffff88852a158fc0 0xffff88852a158840
                                                           ^^^^^^
       0xffff88805d87ca58:     0xffff8882ee4546c0 0xffff8882ee454e40
       0xffff88805d87ca68:     0xffff88852a158840 0xffff8882ee455b00
                                   ^^^^^^

       crash> struct mlx5_pkt_reformat 0xffff890291911840
       struct mlx5_pkt_reformat {
         ns_type = MLX5_FLOW_NAMESPACE_FDB,
         reformat_type = 0x0,
         sw_owned = 0x1,
         {
             action = {
               dr_action = 0xffff88fe5d87c700 <----------
             },
             id = 0x5d87c700
           }
       }
       crash> struct mlx5_pkt_reformat 0xffff890291911780
       struct mlx5_pkt_reformat {
         ns_type = MLX5_FLOW_NAMESPACE_FDB,
         reformat_type = 0x0,
         sw_owned = 0x1,
         {
             action = {
               dr_action = 0xffff88805d87c700 <----------
             },
             id = 0x5d87c700
           }
       }

    rule->node.parent == NULL in del_sw_hw_rule() triggers kernel core 
directly.
    But the root cause is dup pointers in handle->rule[], which conducted by
    wrong judgement of pkt_reformat: pkt_reformat->action.dr_action are
    different 64 bits pointer with same least 32 bits.

    add_rule_fg
      add_rule_fte
        create_flow_handle
          find_flow_rule
            mlx5_flow_dests_cmp
              d1->vport.pkt_reformat->id == d2->vport.pkt_reformat->id
      tree_add_node              <---------- called only when 
node.refcount == 1

   So there are two issues to fix:
   1. How to deal with dup rules to avoid nullptr in rule->node.parent?
   2. How to compare pkt_reformat properly?

   Do you have any ideas to fix these? Looking forward to your response.


Best regards, Tao


