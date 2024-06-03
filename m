Return-Path: <netdev+bounces-100072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A418D7C31
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74DFB2271B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061333E49E;
	Mon,  3 Jun 2024 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="q5lme7dv"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409523B297;
	Mon,  3 Jun 2024 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398576; cv=none; b=sjsyTx+/oj1sVw7Q3sWFsmNLNDURV8P/xvU36tAQUCF+9QH3K4SVl4vcSWrbxSEtz8W592N98f7oDjm4hsSTShuqpFvxgNxVgEpi1u3B1quLQnMMBA87WZLsQl7UpgpYJy0FuRvk7x4YIxJqlPX+gUR2OR26HvXM/eN49+xFcSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398576; c=relaxed/simple;
	bh=7ugu+6bkjE+KB/YtSRKnXmti/vB38R8XnolG71eebZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftaI59TCYvITaksDGwLwIlHBFTeMMlrhg3roZ+eho+rjMZCTcsCKhKBUCRTHlFcB/w1xTHU0aXBLV338zgNgWQTvUov9+1CTxY8gCMajzRrqvor55bmm1VY7d2oMhxw593TbfKj3qlIuwY/a4vLcRAt6AyxH8Li2HYxBzYM05N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=q5lme7dv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/JZ5P7Z02l8WZ3cRpitT5VAHx/w1IRQf9UE3sfmYEn4=; t=1717398574;
	x=1717830574; b=q5lme7dvdooP4c51KJJ6qNZSg0KEhgzKMc3K3QKWZzvqiyitXjNvEkO8udV4Q
	orVQ3Fb8UaWY682UCAjPl2zdjrGC8dMuQDpRauKU7zmi2u+qR/sEn5BKleSzkmsmt/BAp3KdYxYvr
	vYRibSB3IhAkm170GNme1JdWf5+WGEmDjkBZNNtG1f0Ly/LabLSSJ6YVMP+DAuo61FDhIU9+Z+HZB
	6W9m/QhDY6/23/ZQ+khg12tOCDAf2KyjQEpGE8d/WW4sXdMW/pN47xsNrT3mh7eSQKEWQKfilkB5v
	HAWJtRlY1oOcGVRR7UWqX9wJ370Y+uOY4ktDNrXdNEyq8Aylkw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sE1oh-0004xw-Vo; Mon, 03 Jun 2024 09:09:16 +0200
Message-ID: <de980a49-b802-417a-a57e-2c47f67b08e4@leemhuis.info>
Date: Mon, 3 Jun 2024 09:09:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: "ERROR: modpost: "icssg_queue_pop" [...] undefined" on arm64 (was:
 [PATCH net-next v6 1/3] net: ti: icssg-prueth: Add helper functions to
 configure FDB)
To: MD Danish Anwar <danishanwar@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Diogo Ivo <diogo.ivo@siemens.com>, Roger Quadros <rogerq@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240528113734.379422-1-danishanwar@ti.com>
 <20240528113734.379422-2-danishanwar@ti.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240528113734.379422-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1717398574;fe658f45;
X-HE-SMSGID: 1sE1oh-0004xw-Vo

On 28.05.24 13:37, MD Danish Anwar wrote:
> Introduce helper functions to configure firmware FDB tables, VLAN tables
> and Port VLAN ID settings to aid adding Switch mode support.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Hi! Since Friday I get a compile error in my -next builds for Fedora:

ERROR: modpost: "icssg_queue_push"
[drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
ERROR: modpost: "icssg_queue_pop"
[drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!

Looks like this problem was found and reported mid May by the kernel
test robot already, which identified a earlier version of the patch I'm
replying to to be the cause:
https://lore.kernel.org/all/202405182038.ncf1mL7Z-lkp@intel.com/

That and the fact that the patch showed up in -next on Friday makes me
assume that my problem is caused by this change as well as well. A build
log can be found here:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-39-aarch64/07523690-next-next-all/builder-live.log.gz

I don't have the .config at hand, but can provide it when needed.

Ciao, Thorsten

> ---
>  drivers/net/ethernet/ti/icssg/icssg_config.c | 170 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_config.h |  19 +++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  12 ++
>  3 files changed, 201 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 15f2235bf90f..2213374d4d45 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -477,3 +477,173 @@ void icssg_config_set_speed(struct prueth_emac *emac)
>  
>  	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
>  }
> +
> +int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
> +		       struct mgmt_cmd_rsp *rsp)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	int slice = prueth_emac_slice(emac);
> +	int addr, ret;
> +
> +	addr = icssg_queue_pop(prueth, slice == 0 ?
> +			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
> +	if (addr < 0)
> +		return addr;
> +
> +	/* First 4 bytes have FW owned buffer linking info which should
> +	 * not be touched
> +	 */
> +	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
> +	icssg_queue_push(prueth, slice == 0 ?
> +			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
> +	ret = read_poll_timeout(icssg_queue_pop, addr, addr >= 0,
> +				2000, 20000000, false, prueth, slice == 0 ?
> +				ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
> +	if (ret) {
> +		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
> +		return ret;
> +	}
> +
> +	memcpy_fromio(rsp, prueth->shram.va + addr, sizeof(*rsp));
> +	/* Return buffer back for to pool */
> +	icssg_queue_push(prueth, slice == 0 ?
> +			 ICSSG_RSP_PUSH_SLICE0 : ICSSG_RSP_PUSH_SLICE1, addr);
> +
> +	return 0;
> +}
> +
> +static void icssg_fdb_setup(struct prueth_emac *emac, struct mgmt_cmd *fdb_cmd,
> +			    const unsigned char *addr, u8 fid, int cmd)
> +{
> +	int slice = prueth_emac_slice(emac);
> +	u8 mac_fid[ETH_ALEN + 2];
> +	u16 fdb_slot;
> +
> +	ether_addr_copy(mac_fid, addr);
> +
> +	/* 1-1 VID-FID mapping is already setup */
> +	mac_fid[ETH_ALEN] = fid;
> +	mac_fid[ETH_ALEN + 1] = 0;
> +
> +	fdb_slot = bitrev32(crc32_le(0, mac_fid, 8)) & PRUETH_SWITCH_FDB_MASK;
> +
> +	fdb_cmd->header = ICSSG_FW_MGMT_CMD_HEADER;
> +	fdb_cmd->type   = ICSSG_FW_MGMT_FDB_CMD_TYPE;
> +	fdb_cmd->seqnum = ++(emac->prueth->icssg_hwcmdseq);
> +	fdb_cmd->param  = cmd;
> +	fdb_cmd->param |= (slice << 4);
> +
> +	memcpy(&fdb_cmd->cmd_args[0], addr, 4);
> +	memcpy(&fdb_cmd->cmd_args[1], &addr[4], 2);
> +	fdb_cmd->cmd_args[2] = fdb_slot;
> +
> +	netdev_dbg(emac->ndev, "MAC %pM slot %X FID %X\n", addr, fdb_slot, fid);
> +}
> +
> +int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
> +		      u8 vid, u8 fid_c2, bool add)
> +{
> +	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
> +	struct mgmt_cmd fdb_cmd = { 0 };
> +	u8 fid = vid;
> +	int ret;
> +
> +	icssg_fdb_setup(emac, &fdb_cmd, addr, fid, add ? ICSS_CMD_ADD_FDB : ICSS_CMD_DEL_FDB);
> +
> +	fid_c2 |= ICSSG_FDB_ENTRY_VALID;
> +	fdb_cmd.cmd_args[1] |= ((fid << 16) | (fid_c2 << 24));
> +
> +	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
> +	if (ret)
> +		return ret;
> +
> +	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
> +	if (fdb_cmd_rsp.status == 1)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
> +		     u8 vid)
> +{
> +	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
> +	struct mgmt_cmd fdb_cmd = { 0 };
> +	struct prueth_fdb_slot *slot;
> +	u8 fid = vid;
> +	int ret, i;
> +
> +	icssg_fdb_setup(emac, &fdb_cmd, addr, fid, ICSS_CMD_GET_FDB_SLOT);
> +
> +	fdb_cmd.cmd_args[1] |= fid << 16;
> +
> +	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
> +	if (ret)
> +		return ret;
> +
> +	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
> +
> +	slot = (struct prueth_fdb_slot __force *)(emac->dram.va + FDB_CMD_BUFFER);
> +	for (i = 0; i < 4; i++) {
> +		if (ether_addr_equal(addr, slot->mac) && vid == slot->fid)
> +			return (slot->fid_c2 & ~ICSSG_FDB_ENTRY_VALID);
> +		slot++;
> +	}
> +
> +	return 0;
> +}
> +
> +void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
> +		       u8 untag_mask, bool add)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_vlan_tbl *tbl;
> +	u8 fid_c1;
> +
> +	tbl = prueth->vlan_tbl;
> +	fid_c1 = tbl[vid].fid_c1;
> +
> +	/* FID_C1: bit0..2 port membership mask,
> +	 * bit3..5 tagging mask for each port
> +	 * bit6 Stream VID (not handled currently)
> +	 * bit7 MC flood (not handled currently)
> +	 */
> +	if (add) {
> +		fid_c1 |= (port_mask | port_mask << 3);
> +		fid_c1 &= ~(untag_mask << 3);
> +	} else {
> +		fid_c1 &= ~(port_mask | port_mask << 3);
> +	}
> +
> +	tbl[vid].fid_c1 = fid_c1;
> +}
> +
> +u16 icssg_get_pvid(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	u32 pvid;
> +
> +	if (emac->port_id == PRUETH_PORT_MII0)
> +		pvid = readl(prueth->shram.va + EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET);
> +	else
> +		pvid = readl(prueth->shram.va + EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET);
> +
> +	pvid = pvid >> 24;
> +
> +	return pvid;
> +}
> +
> +void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
> +{
> +	u32 pvid;
> +
> +	/* only 256 VLANs are supported */
> +	pvid = (u32 __force)cpu_to_be32((ETH_P_8021Q << 16) | (vid & 0xff));
> +
> +	if (port == PRUETH_PORT_MII0)
> +		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET);
> +	else if (port == PRUETH_PORT_MII1)
> +		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET);
> +	else
> +		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
> +}
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index cf2ea4bd22a2..4a9721aa6057 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -35,6 +35,8 @@ struct icssg_flow_cfg {
>  	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
>  	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
>  
> +#define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
> +
>  struct icssg_rxq_ctx {
>  	__le32 start[3];
>  	__le32 end;
> @@ -202,6 +204,23 @@ struct icssg_setclock_desc {
>  #define ICSSG_TS_PUSH_SLICE0	40
>  #define ICSSG_TS_PUSH_SLICE1	41
>  
> +struct mgmt_cmd {
> +	u8 param;
> +	u8 seqnum;
> +	u8 type;
> +	u8 header;
> +	u32 cmd_args[3];
> +};
> +
> +struct mgmt_cmd_rsp {
> +	u32 reserved;
> +	u8 status;
> +	u8 seqnum;
> +	u8 type;
> +	u8 header;
> +	u32 cmd_args[3];
> +};
> +
>  /* FDB FID_C2 flag definitions */
>  /* Indicates host port membership.*/
>  #define ICSSG_FDB_ENTRY_P0_MEMBERSHIP         BIT(0)
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index a78c5eb75fb8..82bdad9702c3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -232,6 +232,7 @@ struct icssg_firmwares {
>   * @emacs_initialized: num of EMACs/ext ports that are up/running
>   * @iep0: pointer to IEP0 device
>   * @iep1: pointer to IEP1 device
> + * @vlan_tbl: VLAN-FID table pointer
>   */
>  struct prueth {
>  	struct device *dev;
> @@ -256,6 +257,7 @@ struct prueth {
>  	int emacs_initialized;
>  	struct icss_iep *iep0;
>  	struct icss_iep *iep1;
> +	struct prueth_vlan_tbl *vlan_tbl;
>  };
>  
>  struct emac_tx_ts_response {
> @@ -313,6 +315,16 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue);
>  void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
>  u32 icssg_queue_level(struct prueth *prueth, int queue);
>  
> +int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
> +		       struct mgmt_cmd_rsp *rsp);
> +int icssg_fdb_add_del(struct prueth_emac *emac,  const unsigned char *addr,
> +		      u8 vid, u8 fid_c2, bool add);
> +int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
> +		     u8 vid);
> +void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
> +		       u8 untag_mask, bool add);
> +u16 icssg_get_pvid(struct prueth_emac *emac);
> +void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
>  #define prueth_napi_to_tx_chn(pnapi) \
>  	container_of(pnapi, struct prueth_tx_chn, napi_tx)
>  

