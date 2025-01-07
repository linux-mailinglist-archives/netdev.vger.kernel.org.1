Return-Path: <netdev+bounces-155859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DAAA0410C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C543A1871
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23EE1EB9EF;
	Tue,  7 Jan 2025 13:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE21AC44D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257434; cv=none; b=qXCsk3iRvTfIWC819lqkPE3U4inzz3O1upDfWVGJVEE/72RbZe1R+yia89H5w7OJdGNrGccf9F3b9+3+g4m281YgH4C2xBCqy9x3Q0ry7eUY0fmVKKS5GTXP04dOOkSXZ1Tl3xpugkBE4BOA1IblSIkxR5YuDYJBe3qKjCPQXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257434; c=relaxed/simple;
	bh=fGmBYQyEQt+dPwD8ubo+uAvCRdaeXPF5Ah6nh6Pg1t8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/o8aG1fAy/yOtbUmRHzsFi7sZPqadz8fTwGBoZ8i33ACYaOuprr7XckvYFx91yUI5ZJTShZ/f7FL0FVGP4CH9Ks9nmfP0TwaVNI9uMwYVb8zRjkknTyA5M/2k8dhlXQcmzsz2ylxhkGYVAD4GxUTk2XgztAA+8zrNgVz4nDlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YSByM73HnzgbP3;
	Tue,  7 Jan 2025 21:40:43 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E363418010A;
	Tue,  7 Jan 2025 21:43:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jan 2025 21:43:48 +0800
Message-ID: <2cdc2e20-834a-41ed-919e-955a60265a2e@huawei.com>
Date: Tue, 7 Jan 2025 21:43:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [hns3 bugreport] free_pcppages_bulk Null pointer problem
To: zhuwei <zhuwei@sangfor.com.cn>, yisen.zhuang <yisen.zhuang@huawei.com>,
	salil.mehta <salil.mehta@huawei.com>
References: <AHsAlABfIqBgWBLnpG0eZ4rc.1.1736218069638.Hmail.zhuwei@sangfor.com.cn>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <AHsAlABfIqBgWBLnpG0eZ4rc.1.1736218069638.Hmail.zhuwei@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/1/7 10:47, zhuwei wrote:
> Hello, maintainers of the hns3 driver.
>
> We have encountered a problem here, and so far we have no good way to reproduce it.
> At the same time, we retrieved another problem, which is similar to ours:
> https://gitee.com/openeuler/kernel/issues/IAPIEH
>
> Is there any good way to reproduce the problem? We have tried: memory pressure, reboot -f,
> rmmod and insmod hns3, iperf3 network pressure.But none of them worked.
>
> crash stack:
> 67671.494874]  connection100:0: detected conn error (1020)
> [367671.916326] Unable to handle kernel paging request at virtual address dfff200000000000
> [367671.925125] Mem abort info:
> [367671.928566]   ESR = 0x96000004
> [367671.928577]   Exception class = DABT (current EL), IL = 32 bits
> [367671.938987]   SET = 0, FnV = 0
> [367671.938994]   EA = 0, S1PTW = 0
> [367671.946510] Data abort info:
> [367671.946512]   ISV = 0, ISS = 0x00000004
> [367671.946513]   CM = 0, WnR = 0
> [367671.946515] [dfff200000000000] address between user and kernel address ranges
> [367671.946519] Internal error: Oops: 96000004 [#1] SMP
> [367671.946523] Source version: v6.11.1.0094+0~b7cfb09f1.20241224 #1 SMP Tue Dec 24 08:20:50 UTC 2024
> [367671.946524] Modules linked in: etmem_scan xt_comment xt_conntrack dm_round_robin iptable_raw iptable_mangle arc4 md4 sha512_generic sha512_arm64 nls_utf8 cifs ccm nfsv3 iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_multiport tcp_diag inet_diag rpcsec_gss_krb5 nfsv4 dns_resolver fuse act_gact cls_u32 sch_ingress nfsd auth_rpcgss nfs_acl nfs lockd grace fscache sunrpc 8021q garp mrp xt_state nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter vhost_net vhost tap mlx5_ib(OE) mlx5_core(OE) tls mlxfw rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi vfio_pci vfio_virqfd vfio_iommu_type1 vfio hns3 dm_multipath mlx4_en mlx4_core tipc ip6_udp_tunnel udp_tunnel tun nbd bridge stp llc watch_reboot sffs(OE) cl_lock(OE)
> [367671.965185]  cl_softdog(OE) squashfs overlay loop ib_core(OE) mlx_compat(OE) ipmi_ssif realtek aes_ce_blk crypto_simd cryptd ofpart aes_ce_cipher crct10dif_ce hclge ipmi_si cmdlinepart ghash_ce ky_lpcmux ses hnae3 host_edma_drv sha1_ce hi_sfc joydev sbsa_gwdt ipmi_devintf enclosure ipmi_msghandler mtd spi_dw_mmio sch_fq_codel ip_tables sha2_ce sha256_arm64 megaraid_sas(OE) hisi_sas_v3_hw usbhid hisi_sas_main [last unloaded: etmem_scan]
> [367671.973333] Process reboot (pid: 74860, stack limit = 0x000000000e4123c0)
> [367672.082318] CPU: 59 PID: 74860 Comm: reboot Kdump: loaded Tainted: G        W  OE     4.19.90-89.16.v2401.osc.sfc.6.11.1.0094.ky10.aarch64+debug #1
> [367672.208813] Source Version: v6.11.1.0094+0~b7cfb09f1.20241224
> [367672.335042] Hardware name: Yunke China KunTai R522/BC82AMDGA, BIOS 1.35 04/30/2020
> [367672.426869] pstate: 60400089 (nZCv daIf +PAN -UAO)
> [367672.498045] pc : free_pcppages_bulk+0x1d8/0xed0
> [367672.611251] lr : free_unref_page_commit+0x274/0x370
> [367672.611259] sp : ffffa022977b7640
> [367672.684217] x29: ffffa022977b7720 x28: ffff7fe8089f9a88
> [367672.787041] x27: 0000000000000003 x26: dfff200000000000
> [367672.787045] x25: 0000000000000000 x24: ffff7fe8089f9a90
> [367672.787046] x23: 0000000000000000 x22: 1fffeffd0113f351
> [367672.787047] x21: 1fffeffd0113f352 x20: ffffa02dbfb79fe0
> [367672.787049] x19: ffff7fe8089f9a80 x18: 000000000000003b
> [367672.787050] x17: 0000ffff333416b8 x16: ffff200021ba9060
> [367672.787051] x15: 00000000000000c0 x14: 0000ffff3387dac0
> [367672.787053] x13: 000000007fffffff x12: 00002173cb4fb960
> [367672.787054] x11: 1fffeffd0100af8e x10: ffff0ffd0100af8e
> [367672.787056] x9 : dfff200000000000 x8 : ffff140402be4000
> [367672.787057] x7 : ffffffffffffffff x6 : 1ffff40452ef6ed8
> [367672.787059] x5 : 0000000000000010 x4 : 0000000000000000
> [367672.787060] x3 : ffff2000229a6148 x2 : 0000000000000000
> [367672.787061] x1 : ffffa02dbfb79ff0 x0 : 0000000000000000
> [367672.787064] Call trace:
> [367672.787074]  free_pcppages_bulk+0x1d8/0xed0
> [367672.787077]  free_unref_page_commit+0x274/0x370
> [367672.787079]  free_unref_page+0x90/0xc0
> [367672.787084]  __put_page+0x70/0xa8
> [367672.787093]  page_pool_return_page+0x84/0xb8
> [367672.787095]  page_pool_put_page+0x2dc/0x818
> [367672.787115]  hns3_free_buffer.isra.30+0x150/0x1c8 [hns3]
> [367672.787132]  hns3_free_buffer_detach+0x108/0x148 [hns3]
> [367672.787137]  hns3_free_desc+0x74/0x228 [hns3]
> [367672.787141]  hns3_fini_ring+0x30/0x518 [hns3]
> [367672.787145]  hns3_uninit_all_ring.isra.40+0xc4/0x148 [hns3]
> [367672.787148]  hns3_client_uninit+0x278/0x410 [hns3]
> [367672.787173]  hclge_uninit_client_instance+0x2ec/0x428 [hclge]
> [367672.787180]  hnae3_uninit_client_instance+0xe4/0x128 [hnae3]
> [367672.787182]  hnae3_unregister_ae_dev+0xe4/0x2b0 [hnae3]
> [367672.787187]  hns3_shutdown+0x40/0xe0 [hns3]
> [367672.787194]  pci_device_shutdown+0x74/0x120
> [367672.787201]  device_shutdown+0x23c/0x5a8
> [367672.787205]  kernel_restart_prepare+0x6c/0x80
> [367672.787206]  kernel_restart+0x20/0x88
> [367672.787208]  sys_reboot+0x2e4/0x330
> [367672.787212]  el0_svc_naked+0x44/0x48
> [367672.787216] Code: 38fa6884 35006284 d343ff20 f9000439 (38fa6800)
> [367672.787266] SMP: stopping secondary CPUs
> [367672.841402] Starting crashdump kernel...
> [367672.841407] Bye!
>
> hope we can solve it together and make hns3 better.

Hi, Zhu Wei,

Thanks for your report.

It seems that there is something wrong with the pp_page unref. But as you are using KylinOS based 4.19,
not the mainline or stable branch, we have no idea about the code you are using.
May be you can check the latest bugfixes related to page pool?

Thanks,
Jijie Shao




