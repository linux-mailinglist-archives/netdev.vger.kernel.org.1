Return-Path: <netdev+bounces-189965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F4AB49EE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3D219E4658
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421E1D47B4;
	Tue, 13 May 2025 03:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A529CE8;
	Tue, 13 May 2025 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105967; cv=none; b=Blf4hXri/mL7SiQpIt0joh5jjzK8ZznQuclQiu1Pfb/DL1RF8f54GMWl4drHgdJ24cTsw99ake6R7eGo5jSZOxV+ElNJubwSndLfTFym5FAQ8qvysaZxo5GRFyPhNfVo0u5VfXWSXR8ic61Riy89dul6n+YC7mXcWuVYW05tJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105967; c=relaxed/simple;
	bh=Chow5GlNfbBE159hEwMc6Mjycy5u0TMXyXTHArsGG3w=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XLXCa4J5wnew5jiSLdXkFud5cT50jc5rwMA1E2urnvfWExE3Ejh2/0o6Pv3ejVvIWXKW4j1ODoLQuOgrUJZN7XDnA1WAjpLYeWHdBAk5lfmjskZ/ozK8Jb9eSWZhT5L+0w2bjUmS/4Jr9IZt2Sqy64H3uE6RiTrR0NMsjhEmaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZxLzD3g9lz1Z1dg;
	Tue, 13 May 2025 11:08:56 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E84D81402DA;
	Tue, 13 May 2025 11:12:34 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 May 2025 11:12:34 +0800
Message-ID: <34b4e4ba-d831-41de-a45a-53920d8b9f0d@huawei.com>
Date: Tue, 13 May 2025 11:12:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ethtool] hibmcge: add support dump registers for hibmcge
 driver
To: <mkubecek@suse.cz>
References: <20250307113932.821862-1-shaojijie@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250307113932.821862-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Hi:

The query result shows that this patch has been accpected:
https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=Jijie+Shao&state=3&q=&archive=both&delegate=123907

But I cannot find it from
https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/log/?qt=grep&q=Jijie+Shao

I'm not sure what happened.
Does this patch need to be resent?

Thanks，
Jijie Shao

on 2025/3/7 19:39, Jijie Shao wrote:
> Add support pretty printer for the registers of hibmcge driver.
>
> Sample output:
> $ ethtool -d enp132s0f2
> [SPEC]valid                   [0x0000]: 0x00000001
> [SPEC]event_req               [0x0004]: 0x00000000
> [SPEC]mac_id                  [0x0008]: 0x00000003
> [SPEC]phy_addr                [0x000c]: 0x00000003
> [SPEC]mac_addr_h              [0x0010]: 0x08080803
> [SPEC]mac_addr_l              [0x0014]: 0x00000808
> [SPEC]uc_max_num              [0x0018]: 0x00000004
> [SPEC]mdio_freq               [0x0024]: 0x00000000
> [SPEC]max_mtu                 [0x0028]: 0x00000fc2
> [SPEC]min_mtu                 [0x002c]: 0x00000100
> [SPEC]tx_fifo_num             [0x0030]: 0x00000040
> [SPEC]rx_fifo_num             [0x0034]: 0x0000007f
> [SPEC]vlan_layers             [0x0038]: 0x00000002
> [MDIO]command_reg             [0x0000]: 0x0000187f
> [MDIO]addr_reg                [0x0004]: 0x00000000
> [MDIO]wdata_reg               [0x0008]: 0x0000a000
> [MDIO]rdata_reg               [0x000c]: 0x00000000
> [MDIO]sta_reg                 [0x0010]: 0x00000000
> [GMAC]duplex_type             [0x0008]: 0x00000001
> [GMAC]fd_fc_type              [0x000c]: 0x00008808
> [GMAC]fc_tx_timer             [0x001c]: 0x000000ff
> [GMAC]fd_fc_addr_low          [0x0020]: 0x08080803
> [GMAC]fd_fc_addr_high         [0x0024]: 0x00000808
> [GMAC]max_frm_size            [0x003c]: 0x000005f6
> [GMAC]port_mode               [0x0040]: 0x00000008
> [GMAC]port_en                 [0x0044]: 0x00000006
> [GMAC]pause_en                [0x0048]: 0x00000003
> [GMAC]an_neg_state            [0x0058]: 0x00349800
> ...
>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>   Makefile.am |   2 +-
>   ethtool.c   |   1 +
>   hibmcge.c   | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   internal.h  |   3 +
>   4 files changed, 175 insertions(+), 1 deletion(-)
>   create mode 100644 hibmcge.c
>
> diff --git a/Makefile.am b/Makefile.am
> index 862886b..3ecb327 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -23,7 +23,7 @@ ethtool_SOURCES += \
>   		  smsc911x.c at76c50x-usb.c sfc.c stmmac.c	\
>   		  sff-common.c sff-common.h sfpid.c sfpdiag.c	\
>   		  ixgbevf.c tse.c vmxnet3.c qsfp.c qsfp.h fjes.c lan78xx.c \
> -		  igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c hns3.c
> +		  igc.c cmis.c cmis.h bnxt.c cpsw.c lan743x.c hns3.c hibmcge.c
>   endif
>   
>   if ENABLE_BASH_COMPLETION
> diff --git a/ethtool.c b/ethtool.c
> index a1393bc..20f96f4 100644
> --- a/ethtool.c
> +++ b/ethtool.c
> @@ -1206,6 +1206,7 @@ static const struct {
>   	{ "fsl_enetc", fsl_enetc_dump_regs },
>   	{ "fsl_enetc_vf", fsl_enetc_dump_regs },
>   	{ "hns3", hns3_dump_regs },
> +	{ "hibmcge", hibmcge_dump_regs },
>   };
>   #endif
>   
> diff --git a/hibmcge.c b/hibmcge.c
> new file mode 100644
> index 0000000..921efd2
> --- /dev/null
> +++ b/hibmcge.c
> @@ -0,0 +1,170 @@
> +/* Copyright (c) 2025 Huawei Corporation */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include "internal.h"
> +
> +#define HBG_REG_NAEM_MAX_LEN 24
> +
> +struct hbg_reg_info {
> +	u32 type;
> +	u32 offset;
> +	u32 val;
> +};
> +
> +struct hbg_offset_name_map {
> +	u32 offset;
> +	const char *name;
> +};
> +
> +enum hbg_reg_dump_type {
> +	HBG_DUMP_REG_TYPE_SPEC = 0,
> +	HBG_DUMP_REG_TYPE_MDIO,
> +	HBG_DUMP_REG_TYPE_GMAC,
> +	HBG_DUMP_REG_TYPE_PCU,
> +	HBG_DUMP_REG_TYPE_MAX,
> +};
> +
> +struct hbg_type_info {
> +	const char *type_name;
> +	const struct hbg_offset_name_map *reg_map;
> +	u32 reg_num;
> +};
> +
> +static const struct hbg_offset_name_map hbg_spec_maps[] = {
> +	{0x0000, "valid"},
> +	{0x0004, "event_req"},
> +	{0x0008, "mac_id"},
> +	{0x000c, "phy_addr"},
> +	{0x0010, "mac_addr_h"},
> +	{0x0014, "mac_addr_l"},
> +	{0x0018, "uc_max_num"},
> +	{0x0024, "mdio_freq"},
> +	{0x0028, "max_mtu"},
> +	{0x002c, "min_mtu"},
> +	{0x0030, "tx_fifo_num"},
> +	{0x0034, "rx_fifo_num"},
> +	{0x0038, "vlan_layers"},
> +};
> +
> +static const struct hbg_offset_name_map hbg_mdio_maps[] = {
> +	{0x0000, "command_reg"},
> +	{0x0004, "addr_reg"},
> +	{0x0008, "wdata_reg"},
> +	{0x000c, "rdata_reg"},
> +	{0x0010, "sta_reg"},
> +};
> +
> +static const struct hbg_offset_name_map hbg_gmac_maps[] = {
> +	{0x0008, "duplex_type"},
> +	{0x000c, "fd_fc_type"},
> +	{0x001c, "fc_tx_timer"},
> +	{0x0020, "fd_fc_addr_low"},
> +	{0x0024, "fd_fc_addr_high"},
> +	{0x003c, "max_frm_size"},
> +	{0x0040, "port_mode"},
> +	{0x0044, "port_en"},
> +	{0x0048, "pause_en"},
> +	{0x0058, "an_neg_state"},
> +	{0x0060, "transmit_ctrl"},
> +	{0x0064, "rec_filt_ctrl"},
> +	{0x01a8, "line_loop_back"},
> +	{0x01b0, "cf_crc_strip"},
> +	{0x01b4, "mode_change_en"},
> +	{0x01dc, "loop_reg"},
> +	{0x01e0, "recv_control"},
> +	{0x01e8, "vlan_code"},
> +	{0x0200, "station_addr_low_0"},
> +	{0x0204, "station_addr_high_0"},
> +	{0x0208, "station_addr_low_1"},
> +	{0x020c, "station_addr_high_1"},
> +	{0x0210, "station_addr_low_2"},
> +	{0x0214, "station_addr_high_2"},
> +	{0x0218, "station_addr_low_3"},
> +	{0x021c, "station_addr_high_3"},
> +	{0x0220, "station_addr_low_4"},
> +	{0x0224, "station_addr_high_4"},
> +	{0x0228, "station_addr_low_5"},
> +	{0x022c, "station_addr_high_5"},
> +};
> +
> +static const struct hbg_offset_name_map hbg_pcu_maps[] = {
> +	{0x0420, "cf_tx_fifo_thrsld"},
> +	{0x0424, "cf_rx_fifo_thrsld"},
> +	{0x0428, "cf_cfg_fifo_thrsld"},
> +	{0x042c, "cf_intrpt_msk"},
> +	{0x0434, "cf_intrpt_stat"},
> +	{0x0438, "cf_intrpt_clr"},
> +	{0x043c, "tx_bus_err_addr"},
> +	{0x0440, "rx_bus_err_addr"},
> +	{0x0444, "max_frame_len"},
> +	{0x0450, "debug_st_mch"},
> +	{0x0454, "fifo_curr_status"},
> +	{0x0458, "fifo_his_status"},
> +	{0x045c, "cf_cff_data_num"},
> +	{0x0470, "cf_tx_pause"},
> +	{0x04a0, "rx_cff_addr"},
> +	{0x04e4, "rx_buf_size"},
> +	{0x04e8, "bus_ctrl"},
> +	{0x04f0, "rx_ctrl"},
> +	{0x04f4, "rx_pkt_mode"},
> +	{0x05e4, "dbg_st0"},
> +	{0x05e8, "dbg_st1"},
> +	{0x05ec, "dbg_st2"},
> +	{0x0688, "bus_rst_en"},
> +	{0x0694, "cf_ind_txint_msk"},
> +	{0x0698, "cf_ind_txint_stat"},
> +	{0x069c, "cf_ind_txint_clr"},
> +	{0x06a0, "cf_ind_rxint_msk"},
> +	{0x06a4, "cf_ind_rxint_stat"},
> +	{0x06a8, "cf_ind_rxint_clr"},
> +};
> +
> +static const struct hbg_type_info hbg_type_infos[] = {
> +	[HBG_DUMP_REG_TYPE_SPEC] = {"SPEC", hbg_spec_maps, ARRAY_SIZE(hbg_spec_maps)},
> +	[HBG_DUMP_REG_TYPE_MDIO] = {"MDIO", hbg_mdio_maps, ARRAY_SIZE(hbg_mdio_maps)},
> +	[HBG_DUMP_REG_TYPE_GMAC] = {"GMAC", hbg_gmac_maps, ARRAY_SIZE(hbg_gmac_maps)},
> +	[HBG_DUMP_REG_TYPE_PCU] = {"PCU", hbg_pcu_maps, ARRAY_SIZE(hbg_pcu_maps)},
> +	[HBG_DUMP_REG_TYPE_MAX] = {"UNKNOWN", NULL, 0},
> +};
> +
> +static void dump_type_reg(const struct hbg_type_info *type_info,
> +			  const struct hbg_reg_info *reg_info)
> +{
> +	const char *reg_name = "UNKNOWN";
> +	u32 i = 0;
> +
> +	for (i = 0; i < type_info->reg_num; i++)
> +		if (type_info->reg_map[i].offset == reg_info->offset) {
> +			reg_name = type_info->reg_map[i].name;
> +			break;
> +		}
> +
> +	fprintf(stdout, "[%s]%-*s[0x%04x]: 0x%08x\n",
> +		type_info->type_name, HBG_REG_NAEM_MAX_LEN, reg_name,
> +		reg_info->offset, reg_info->val);
> +}
> +
> +int hibmcge_dump_regs(struct ethtool_drvinfo *info __maybe_unused,
> +		      struct ethtool_regs *regs)
> +{
> +	struct hbg_reg_info *reg_info;
> +	u32 offset = 0;
> +
> +	if (regs->len % sizeof(*reg_info) != 0)
> +		return -EINVAL;
> +
> +	while (offset < regs->len) {
> +		reg_info = (struct hbg_reg_info *)(regs->data + offset);
> +
> +		if (reg_info->type >= HBG_DUMP_REG_TYPE_MAX)
> +			dump_type_reg(&hbg_type_infos[HBG_DUMP_REG_TYPE_MAX],
> +				      reg_info);
> +		else
> +			dump_type_reg(&hbg_type_infos[reg_info->type], reg_info);
> +
> +		offset += sizeof(*reg_info);
> +	}
> +
> +	return 0;
> +}
> diff --git a/internal.h b/internal.h
> index f33539d..e3707d7 100644
> --- a/internal.h
> +++ b/internal.h
> @@ -366,6 +366,9 @@ int vmxnet3_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
>   /* hns3 ethernet controller */
>   int hns3_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
>   
> +/* hibmcge ethernet controller */
> +int hibmcge_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
> +
>   /* Rx flow classification */
>   int rxclass_parse_ruleopts(struct cmd_context *ctx,
>   			   struct ethtool_rx_flow_spec *fsp, __u32 *rss_context);

