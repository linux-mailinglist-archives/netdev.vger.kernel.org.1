Return-Path: <netdev+bounces-245962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B697CDC11B
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C281F303BBDD
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7619CC28;
	Wed, 24 Dec 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DzpFm24f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4F1F9F7A;
	Wed, 24 Dec 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766574207; cv=none; b=IqK7hnAS0+exh0yMMYngt1JlgsmaxYSmQhrwyI0d5df41Y+5w5/s5KkcaNp6+2I59E+XSsvZibcdHSDqwtjt2Renbp3+tJOaJ2nFLuLYs+/xFNE91tjMVVvpt0+kKGSkAcIYGcKyp6uinfz7Jc+pnXTpRmIbxQTumOSr8XWMOUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766574207; c=relaxed/simple;
	bh=IgeTXTpjU2zIaCHLPJ5EnLMPGil+tfm1feqTLiBCK70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii8RMoh2BY67L3qC0dmsmnFWb3cRqJfnYIqOBklXEDcjOvmUt4aFSgY5FpPe1kGZiMNIAIw1DDO3noozablYrFG2xLqYfHT6XhrhgdBVs/Bj9bMSeCpWMH5G0TPb01N10lE/xhvruQKYSxu71bnRpOlqNGgJEYU9BqYKAQO1eB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DzpFm24f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kK/h9nclBezOSTeXgq4+7LihTq+0s5OlX3ccZa+74pc=; b=DzpFm24fSHnsXMa4PO8DpCR3l1
	6q7IGLCSz4kK6Q5gg6b9FCgrDbENl2ldvUtAvGecXT9mLXdnJ3SSApLiaOlp3vnTDs1e9CeRG9wcX
	yq/B6Ha973NoJmuvRigpqJcdmj8AvFVY3n6d5blNNHiLFukVrc2zYVqpUYPS3TcZ1B0E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vYMeB-000PDB-1G; Wed, 24 Dec 2025 12:03:15 +0100
Date: Wed, 24 Dec 2025 12:03:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "illusion.wang" <illusion.wang@nebula-matrix.com>
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 13/15] net/nebula-matrix: add Dev start, stop
 operation
Message-ID: <4174bcb9-cb94-431f-9965-aa595d91e7bd@lunn.ch>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
 <20251223035113.31122-14-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223035113.31122-14-illusion.wang@nebula-matrix.com>

On Tue, Dec 23, 2025 at 11:50:36AM +0800, illusion.wang wrote:
> some important steps in dev start:
> 1.start common dev: config msix map table, alloc and enable msix vectors,
> register mailbox ISR and enable mailbox irq, set up chan keepalive task.
> 2.start ctrl dev: request abnormal and adminq ISR , enable them. schedule some
> ctrl tasks such as adapt desc gother task.
> 3.start net dev:
>  3.1 alloc netdev with multi-queue support, config private data and associatess
> with the adapter.
>  3.2 alloc tx/rx rings, set up network resource managements(vlan,rate limiting)
>  3.3 build the netdev structure, map queues to msix interrupts, init hw stats.
>  3.4 register link stats and reset event chan msg.
>  3.5 start net vsi and register net irq.
>  3.6 register netdev
>  3.7 some other handles such as sysfs attributes.

sysfs attributes rings alarm bells. Please make that a patch of its
own so it can get proper review.

> 
> Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
> Change-Id: Ic97bbe53ace0e70ec704235513a2174d6c9b219e
> ---
>  .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    2 +
>  .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 3513 +++++++++++-----
>  .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 3595 +++++++++++++++--
>  .../nbl/nbl_include/nbl_def_dev.h             |    9 +-
>  .../nbl/nbl_include/nbl_def_service.h         |   55 +
>  .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   78 +-
>  6 files changed, 5829 insertions(+), 1423 deletions(-)
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> index 96e00bcc5ff4..69f7a3b1b3ab 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> @@ -136,6 +136,8 @@ struct nbl_software_tool_table {
>  
>  struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *param);
>  void nbl_core_remove(struct nbl_adapter *adapter);
> +int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param);
> +void nbl_core_stop(struct nbl_adapter *adapter);
>  
>  int nbl_st_init(struct nbl_software_tool_table *st_table);
>  void nbl_st_remove(struct nbl_software_tool_table *st_table);
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> index 853dd5469f60..d97651c5daa0 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -27,11 +27,35 @@ static struct nbl_dev_board_id_table board_id_table;
>  
>  struct nbl_dev_ops dev_ops;
>  
> +static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
> +static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info);
>  static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt);
>  static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param);
>  static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter);
>  
>  /* ----------  Basic functions  ---------- */
> +static int nbl_dev_get_port_attributes(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->get_port_attributes(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +}
> +
> +static int nbl_dev_enable_port(struct nbl_dev_mgt *dev_mgt, bool enable)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->enable_port(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), enable);
> +}
> +
> +static void nbl_dev_init_port(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	if (restore_eth)
> +		serv_ops->init_port(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +}
> +
>  static int nbl_dev_alloc_board_id(struct nbl_dev_board_id_table *index_table, u32 board_key)
>  {
>  	int i = 0;
> @@ -70,7 +94,41 @@ static void nbl_dev_free_board_id(struct nbl_dev_board_id_table *index_table, u3
>  		memset(&index_table->entry[i], 0, sizeof(index_table->entry[i]));
>  }
>  
> +static void nbl_dev_set_netdev_priv(struct net_device *netdev, struct nbl_dev_vsi *vsi,
> +				    struct nbl_dev_vsi *user_vsi)
> +{
> +	struct nbl_netdev_priv *net_priv = netdev_priv(netdev);
> +
> +	net_priv->tx_queue_num = vsi->queue_num;
> +	net_priv->rx_queue_num = vsi->queue_num;
> +	net_priv->queue_size = vsi->queue_size;
> +	net_priv->netdev = netdev;
> +	net_priv->data_vsi = vsi->vsi_id;
> +	if (user_vsi)
> +		net_priv->user_vsi = user_vsi->vsi_id;
> +	else
> +		net_priv->user_vsi = vsi->vsi_id;
> +}
> +
>  /* ----------  Interrupt config  ---------- */
> +static irqreturn_t nbl_dev_clean_mailbox(int __always_unused irq, void *data)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
> +
> +	nbl_dev_clean_mailbox_schedule(dev_mgt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t nbl_dev_clean_adminq(int __always_unused irq, void *data)
> +{
> +	struct nbl_task_info *task_info = (struct nbl_task_info *)data;
> +
> +	nbl_dev_clean_adminq_schedule(task_info);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void nbl_dev_handle_abnormal_event(struct work_struct *work)
>  {
>  	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> @@ -81,6 +139,23 @@ static void nbl_dev_handle_abnormal_event(struct work_struct *work)
>  	serv_ops->process_abnormal_event(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
>  }
>  
> +static void nbl_dev_clean_abnormal_status(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> +
> +	nbl_common_queue_work(&task_info->clean_abnormal_irq_task, true);
> +}
> +
> +static irqreturn_t nbl_dev_clean_abnormal_event(int __always_unused irq, void *data)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
> +
> +	nbl_dev_clean_abnormal_status(dev_mgt);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
>  {
>  	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> @@ -114,1414 +189,2876 @@ static void nbl_dev_register_ctrl_irq(struct nbl_dev_mgt *dev_mgt)
>  	msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num = irq_num.adminq_irq_num;
>  }
>  
> -/* ----------  Channel config  ---------- */
> -static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +static int nbl_dev_request_net_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	struct nbl_msix_info_param param = {0};
> +	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
>  	int ret = 0;
>  
> -	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> -		return 0;
> +	param.msix_entries = kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
> +	if (!param.msix_entries)
> +		return -ENOMEM;
>  
> -	ret = chan_ops->cfg_chan_qinfo_map_table(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> -						 chan_type);
> -	if (ret)
> -		dev_err(dev, "setup chan:%d, qinfo map table failed\n", chan_type);
> +	param.msix_num = msix_num;
> +	memcpy(param.msix_entries, msix_info->msix_entries +
> +		msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
> +		sizeof(param.msix_entries[0]) * msix_num);
>  
> +	ret = serv_ops->request_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &param);
> +
> +	kfree(param.msix_entries);
>  	return ret;
>  }
>  
> -static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +static void nbl_dev_free_net_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	int ret = 0;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	struct nbl_msix_info_param param = {0};
> +	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
>  
> -	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> -		ret = chan_ops->setup_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
> +	param.msix_entries = kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
> +	if (!param.msix_entries)
> +		return;
>  
> -	return ret;
> +	param.msix_num = msix_num;
> +	memcpy(param.msix_entries, msix_info->msix_entries +
> +		msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
> +	       sizeof(param.msix_entries[0]) * msix_num);
> +
> +	serv_ops->free_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &param);
> +
> +	kfree(param.msix_entries);
>  }
>  
> -static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	int ret = 0;
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	u32 irq_num;
> +	int err;
>  
> -	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> -		ret = chan_ops->teardown_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
>  
> -	return ret;
> -}
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	irq_num = msix_info->msix_entries[local_vector_id].vector;
>  
> -static void nbl_dev_remove_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> -{
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
> +		 "nbl_mailbox@pci:%s", pci_name(NBL_COMMON_TO_PDEV(common)));
> +	err = devm_request_irq(dev, irq_num, nbl_dev_clean_mailbox,
> +			       0, dev_common->mailbox_name, dev_mgt);
> +	if (err) {
> +		dev_err(dev, "Request mailbox irq handler failed err: %d\n", err);
> +		return err;
> +	}
>  
> -	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> -		chan_ops->remove_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
> +	return 0;
>  }
>  
> -static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
> -				       u8 chan_type, struct work_struct *task)
> +static void nbl_dev_free_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	u32 irq_num;
>  
> -	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> -		chan_ops->register_chan_task(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type, task);
> -}
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return;
>  
> -/* ----------  Tasks config  ---------- */
> -static void nbl_dev_clean_mailbox_task(struct work_struct *work)
> -{
> -	struct nbl_dev_common *common_dev = container_of(work, struct nbl_dev_common,
> -							 clean_mbx_task);
> -	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	irq_num = msix_info->msix_entries[local_vector_id].vector;
>  
> -	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_MAILBOX);
> +	devm_free_irq(dev, irq_num, dev_mgt);
>  }
>  
> -static void nbl_dev_prepare_reset_task(struct work_struct *work)
> +static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	int ret;
> -	struct nbl_reset_task_info *task_info = container_of(work, struct nbl_reset_task_info,
> -							     task);
> -	struct nbl_dev_common *common_dev = container_of(task_info, struct nbl_dev_common,
> -							 reset_task);
> -	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct nbl_chan_send_info chan_send;
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
>  
> -	serv_ops->netdev_stop(dev_mgt->net_dev->netdev);
> -	netif_device_detach(dev_mgt->net_dev->netdev); /* to avoid ethtool operation */
> -	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
>  
> -	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_ACK_RESET_EVENT, NULL,
> -		      0, NULL, 0, 0);
> -	/* notify ctrl dev, finish reset event process */
> -	ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
> -	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
>  				  NBL_CHAN_TYPE_MAILBOX, true);
>  
> -	/* sleep to avoid send_msg is running */
> -	usleep_range(10, 20);
> -
> -	/* ctrl dev must shutdown phy reg read/write after ctrl dev has notify emp shutdown dev */
> -	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
> -		serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
> +	return serv_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					    local_vector_id, true);
>  }
>  
> -static void nbl_dev_clean_adminq_task(struct work_struct *work)
> +static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> -						       clean_adminq_task);
> -	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
>  
> -	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_ADMINQ);
> +	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
> +		return 0;
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_CLEAN_MAILBOX_CAP))
> +		nbl_common_flush_task(&dev_common->clean_mbx_task);
> +
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
> +	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
> +				  NBL_CHAN_TYPE_MAILBOX, false);
> +
> +	return serv_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					    local_vector_id, false);
>  }
>  
> -static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
> +static int nbl_dev_request_adminq_irq(struct nbl_dev_mgt *dev_mgt, struct nbl_task_info *task_info)
>  {
> -	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> -						       fw_hb_task);
> -	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
>  	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	u32 irq_num;
> +	char *irq_name;
> +	int err;
>  
> -	if (task_info->fw_resetting)
> -		return;
> +	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
> +		return 0;
>  
> -	if (!serv_ops->check_fw_heartbeat(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
> -		dev_notice(NBL_COMMON_TO_DEV(common), "FW reset detected");
> -		task_info->fw_resetting = true;
> -		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
> -					NBL_CHAN_TYPE_ADMINQ, true);
> -		nbl_common_queue_delayed_work(&task_info->fw_reset_task, MSEC_PER_SEC, true);
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
> +	irq_num = msix_info->msix_entries[local_vector_id].vector;
> +	irq_name = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].irq_name;
> +
> +	snprintf(irq_name, NBL_STRING_NAME_LEN, "nbl_adminq@pci:%s",
> +		 pci_name(NBL_COMMON_TO_PDEV(common)));
> +	err = devm_request_irq(dev, irq_num, nbl_dev_clean_adminq,
> +			       0, irq_name, task_info);
> +	if (err) {
> +		dev_err(dev, "Request adminq irq handler failed err: %d\n", err);
> +		return err;
>  	}
> +
> +	return 0;
>  }
>  
> -static void nbl_dev_fw_reset_task(struct work_struct *work)
> +static void nbl_dev_free_adminq_irq(struct nbl_dev_mgt *dev_mgt, struct nbl_task_info *task_info)
>  {
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	u32 irq_num;
> +
> +	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
> +		return;
> +
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
> +	irq_num = msix_info->msix_entries[local_vector_id].vector;
> +
> +	devm_free_irq(dev, irq_num, task_info);
>  }
>  
> -static void nbl_dev_adapt_desc_gother_task(struct work_struct *work)
> +static int nbl_dev_enable_adminq_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> -						       adapt_desc_gother_task);
> -	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
>  
> -	serv_ops->adapt_desc_gother(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
> +		return 0;
> +
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
> +	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
> +				  NBL_CHAN_TYPE_ADMINQ, true);
> +
> +	return serv_ops->enable_adminq_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					    local_vector_id, true);
>  }
>  
> -static void nbl_dev_recovery_abnormal_task(struct work_struct *work)
> +static int nbl_dev_disable_adminq_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> -						       recovery_abnormal_task);
> -	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
>  
> -	serv_ops->recovery_abnormal(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -}
> +	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
> +		return 0;
>  
> -static void nbl_dev_ctrl_reset_task(struct work_struct *work)
> -{
> -	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> -						       reset_task);
> -	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
> +	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
> +				  NBL_CHAN_TYPE_ADMINQ, false);
>  
> -	nbl_dev_handle_fatal_err(dev_mgt);
> +	return serv_ops->enable_adminq_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					    local_vector_id, false);
>  }
>  
> -static void nbl_dev_ctrl_task_schedule(struct nbl_task_info *task_info)
> +static int nbl_dev_request_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	char *irq_name;
> +	u32 irq_num;
> +	int err;
> +	u16 local_vector_id;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_FW_HB_CAP))
> -		nbl_common_queue_work(&task_info->fw_hb_task, true);
> +	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
> +		return 0;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_ADAPT_DESC_GOTHER))
> -		nbl_common_queue_work(&task_info->adapt_desc_gother_task, true);
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
> +	irq_num = msix_info->msix_entries[local_vector_id].vector;
> +	irq_name = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].irq_name;
> +
> +	snprintf(irq_name, NBL_STRING_NAME_LEN, "nbl_abnormal@pci:%s",
> +		 pci_name(NBL_COMMON_TO_PDEV(common)));
> +	err = devm_request_irq(dev, irq_num, nbl_dev_clean_abnormal_event,
> +			       0, irq_name, dev_mgt);
> +	if (err) {
> +		dev_err(dev, "Request abnormal_irq irq handler failed err: %d\n", err);
> +		return err;
> +	}
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_RECOVERY_ABNORMAL_STATUS))
> -		nbl_common_queue_work(&task_info->recovery_abnormal_task, true);
> +	return 0;
>  }
>  
> -static void nbl_dev_ctrl_task_timer(struct timer_list *t)
> +static void nbl_dev_free_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_task_info *task_info = container_of(t, struct nbl_task_info, serv_timer);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	u32 irq_num;
>  
> -	mod_timer(&task_info->serv_timer, round_jiffies(task_info->serv_timer_period + jiffies));
> -	nbl_dev_ctrl_task_schedule(task_info);
> +	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
> +		return;
> +
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
> +	irq_num = msix_info->msix_entries[local_vector_id].vector;
> +
> +	devm_free_irq(dev, irq_num, dev_mgt);
>  }
>  
> -static void nbl_dev_chan_notify_flr_resp(void *priv, u16 src_id, u16 msg_id,
> -					 void *data, u32 data_len)
> +static int nbl_dev_enable_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	u16 vfid;
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	int err = 0;
>  
> -	vfid = *(u16 *)data;
> -	serv_ops->process_flr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vfid);
> +	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
> +		return 0;
> +
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
> +	err = serv_ops->enable_abnormal_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					    local_vector_id, true);
> +
> +	return err;
>  }
>  
> -static void nbl_dev_ctrl_register_flr_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +static int nbl_dev_disable_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	u16 local_vector_id;
> +	int err = 0;
>  
> -	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					   NBL_PROCESS_FLR_CAP))
> -		return;
> +	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
> +		return 0;
>  
> -	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> -			       NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY,
> -			       nbl_dev_chan_notify_flr_resp, dev_mgt);
> +	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
> +	err = serv_ops->enable_abnormal_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					    local_vector_id, false);
> +
> +	return err;
>  }
>  
> -static struct nbl_dev_temp_alarm_info temp_alarm_info[NBL_TEMP_STATUS_MAX] = {
> -	{LOGLEVEL_WARNING, "High temperature on sensors0 resumed.\n"},
> -	{LOGLEVEL_WARNING, "High temperature on sensors0 observed, security(WARNING).\n"},
> -	{LOGLEVEL_CRIT, "High temperature on sensors0 observed, security(CRITICAL).\n"},
> -	{LOGLEVEL_EMERG, "High temperature on sensors0 observed, security(EMERGENCY).\n"},
> -};
> -
> -static void nbl_dev_handle_temp_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
> +static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
>  {
> -	u16 temp = (u16)*data;
> -	u64 uptime = 0;
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> -	enum nbl_dev_temp_status old_temp_status = ctrl_dev->temp_status;
> -	enum nbl_dev_temp_status new_temp_status = NBL_TEMP_STATUS_NORMAL;
> -
> -	/* no resume if temp exceed NBL_TEMP_EMERG_THRESHOLD, even if the temp resume nomal.
> -	 * Because the hw has shutdown.
> -	 */
> -	if (old_temp_status == NBL_TEMP_STATUS_EMERG)
> -		return;
> -
> -	/* if temp in (85-105) and not in normal_status, no resume to avoid alarm oscillate */
> -	if (temp > NBL_TEMP_NOMAL_THRESHOLD &&
> -	    temp < NBL_TEMP_WARNING_THRESHOLD &&
> -	    old_temp_status > NBL_TEMP_STATUS_NORMAL)
> -		return;
> -
> -	if (temp >= NBL_TEMP_WARNING_THRESHOLD &&
> -	    temp < NBL_TEMP_CRIT_THRESHOLD)
> -		new_temp_status = NBL_TEMP_STATUS_WARNING;
> -	else if (temp >= NBL_TEMP_CRIT_THRESHOLD &&
> -		 temp < NBL_TEMP_EMERG_THRESHOLD)
> -		new_temp_status = NBL_TEMP_STATUS_CRIT;
> -	else if (temp >= NBL_TEMP_EMERG_THRESHOLD)
> -		new_temp_status = NBL_TEMP_STATUS_EMERG;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	int err = 0;
> +	int i;
> +	u16 msix_not_net_num = 0;
>  
> -	if (new_temp_status == old_temp_status)
> -		return;
> +	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
> +		msix_info->serv_info[i].base_vector_id = msix_info->serv_info[i - 1].base_vector_id
> +							 + msix_info->serv_info[i - 1].num;
>  
> -	ctrl_dev->temp_status = new_temp_status;
> +	for (i = NBL_MSIX_MAILBOX_TYPE; i < NBL_MSIX_TYPE_MAX; i++) {
> +		if (i == NBL_MSIX_NET_TYPE)
> +			continue;
>  
> -	/* temp fall only alarm when the alarm need to resume */
> -	if (new_temp_status < old_temp_status && new_temp_status != NBL_TEMP_STATUS_NORMAL)
> -		return;
> +		msix_not_net_num += msix_info->serv_info[i].num;
> +	}
>  
> -	if (data_len > sizeof(u16))
> -		uptime = *(u64 *)(data + sizeof(u16));
> -	nbl_log(common, temp_alarm_info[new_temp_status].logvel,
> -		"[%llu] %s", uptime, temp_alarm_info[new_temp_status].alarm_info);
> +	err = serv_ops->configure_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					   msix_info->serv_info[NBL_MSIX_NET_TYPE].num,
> +					   msix_not_net_num,
> +					   msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en);
>  
> -	if (new_temp_status == NBL_TEMP_STATUS_EMERG) {
> -		ctrl_dev->task_info.reset_event = NBL_HW_FATAL_ERR_EVENT;
> -		nbl_common_queue_work(&ctrl_dev->task_info.reset_task, false);
> -	}
> +	return err;
>  }
>  
> -static const char *nbl_log_level_name(int level)
> +static int nbl_dev_destroy_msix_map(struct nbl_dev_mgt *dev_mgt)
>  {
> -	switch (level) {
> -	case NBL_EMP_ALERT_LOG_FATAL:
> -		return "FATAL";
> -	case NBL_EMP_ALERT_LOG_ERROR:
> -		return "ERROR";
> -	case NBL_EMP_ALERT_LOG_WARNING:
> -		return "WARNING";
> -	case NBL_EMP_ALERT_LOG_INFO:
> -		return "INFO";
> -	default:
> -		return "UNKNOWN";
> -	}
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	int err = 0;
> +
> +	err = serv_ops->destroy_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	return err;
>  }
>  
> -static void nbl_dev_handle_emp_log_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
> +static int nbl_dev_alloc_msix_entries(struct nbl_dev_mgt *dev_mgt, u16 num_entries)
>  {
> -	struct nbl_emp_alert_log_event *log_event = (struct nbl_emp_alert_log_event *)data;
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	u16 i;
>  
> -	nbl_log(common, LOGLEVEL_INFO, "[FW][%llu] <%s> %.*s", log_event->uptime,
> -		nbl_log_level_name(log_event->level), data_len - sizeof(u64) - sizeof(u8),
> -		log_event->data);
> -}
> +	msix_info->msix_entries = devm_kcalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), num_entries,
> +					       sizeof(msix_info->msix_entries),
> +					       GFP_KERNEL);
> +	if (!msix_info->msix_entries)
> +		return -ENOMEM;
>  
> -static void nbl_dev_chan_notify_evt_alert_resp(void *priv, u16 src_id, u16 msg_id,
> -					       void *data, u32 data_len)
> -{
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> -	struct nbl_chan_param_emp_alert_event *alert_param =
> -						(struct nbl_chan_param_emp_alert_event *)data;
> +	for (i = 0; i < num_entries; i++)
> +		msix_info->msix_entries[i].entry =
> +				serv_ops->get_msix_entry_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), i);
>  
> -	switch (alert_param->type) {
> -	case NBL_EMP_EVENT_TEMP_ALERT:
> -		nbl_dev_handle_temp_ext(dev_mgt, alert_param->data, alert_param->len);
> -		return;
> -	case NBL_EMP_EVENT_LOG_ALERT:
> -		nbl_dev_handle_emp_log_ext(dev_mgt, alert_param->data, alert_param->len);
> -		return;
> -	default:
> -		return;
> -	}
> +	dev_info(NBL_DEV_MGT_TO_DEV(dev_mgt), "alloc msix entry: %u-%u.\n",
> +		 msix_info->msix_entries[0].entry, msix_info->msix_entries[num_entries - 1].entry);
> +
> +	return 0;
>  }
>  
> -static void nbl_dev_ctrl_register_emp_ext_alert_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +static void nbl_dev_free_msix_entries(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -
> -	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> -					 NBL_CHAN_TYPE_MAILBOX))
> -		return;
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
>  
> -	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> -			       NBL_CHAN_MSG_ADMINQ_EXT_ALERT,
> -			       nbl_dev_chan_notify_evt_alert_resp, dev_mgt);
> +	devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), msix_info->msix_entries);
> +	msix_info->msix_entries = NULL;
>  }
>  
> -static int nbl_dev_setup_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
> +static int nbl_dev_alloc_msix_intr(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> -	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	int needed = 0;
> +	int err;
> +	int i;
>  
> -	task_info->dev_mgt = dev_mgt;
> +	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
> +		needed += msix_info->serv_info[i].num;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_FW_HB_CAP)) {
> -		nbl_common_alloc_task(&task_info->fw_hb_task, nbl_dev_fw_heartbeat_task);
> -		task_info->timer_setup = true;
> +	err = nbl_dev_alloc_msix_entries(dev_mgt, (u16)needed);
> +	if (err) {
> +		pr_err("Allocate msix entries failed\n");
> +		return err;
>  	}
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_FW_RESET_CAP)) {
> -		nbl_common_alloc_delayed_task(&task_info->fw_reset_task, nbl_dev_fw_reset_task);
> -		task_info->timer_setup = true;
> +	err = pci_enable_msix_range(NBL_COMMON_TO_PDEV(common), msix_info->msix_entries,
> +				    needed, needed);
> +	if (err < 0) {
> +		pr_err("pci_enable_msix_range failed, err = %d.\n", err);
> +		goto enable_msix_failed;
>  	}
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_CLEAN_ADMINDQ_CAP)) {
> -		nbl_common_alloc_task(&task_info->clean_adminq_task, nbl_dev_clean_adminq_task);
> -		task_info->timer_setup = true;
> -	}
> +	return needed;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_ADAPT_DESC_GOTHER)) {
> -		nbl_common_alloc_task(&task_info->adapt_desc_gother_task,
> -				      nbl_dev_adapt_desc_gother_task);
> -		task_info->timer_setup = true;
> -	}
> +enable_msix_failed:
> +	nbl_dev_free_msix_entries(dev_mgt);
> +	return err;
> +}
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_RECOVERY_ABNORMAL_STATUS)) {
> -		nbl_common_alloc_task(&task_info->recovery_abnormal_task,
> -				      nbl_dev_recovery_abnormal_task);
> -		task_info->timer_setup = true;
> -	}
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_RESET_CTRL_CAP))
> -		nbl_common_alloc_task(&task_info->reset_task, &nbl_dev_ctrl_reset_task);
> +static void nbl_dev_free_msix_intr(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
>  
> -	nbl_common_alloc_task(&task_info->clean_abnormal_irq_task,
> -			      nbl_dev_handle_abnormal_event);
> +	pci_disable_msix(NBL_COMMON_TO_PDEV(common));
> +	nbl_dev_free_msix_entries(dev_mgt);
> +}
>  
> -	if (task_info->timer_setup) {
> -		timer_setup(&task_info->serv_timer, nbl_dev_ctrl_task_timer, 0);
> -		task_info->serv_timer_period = HZ;
> -	}
> +static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
> +{
> +	int err = 0;
>  
> -	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, &task_info->clean_adminq_task);
> +	err = nbl_dev_alloc_msix_intr(dev_mgt);
> +	if (err < 0) {
> +		dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Failed to enable MSI-X vectors\n");
> +		return err;
> +	}
>  
>  	return 0;
>  }
>  
> -static void nbl_dev_remove_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
> +static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> +	nbl_dev_free_msix_intr(dev_mgt);
> +}
>  
> -	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, NULL);
> +/* ----------  Channel config  ---------- */
> +static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	int ret = 0;
>  
> -	nbl_common_release_task(&task_info->clean_abnormal_irq_task);
> +	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> +		return 0;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_FW_RESET_CAP))
> -		nbl_common_release_delayed_task(&task_info->fw_reset_task);
> +	ret = chan_ops->cfg_chan_qinfo_map_table(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +						 chan_type);
> +	if (ret)
> +		dev_err(dev, "setup chan:%d, qinfo map table failed\n", chan_type);
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_FW_HB_CAP))
> -		nbl_common_release_task(&task_info->fw_hb_task);
> +	return ret;
> +}
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_CLEAN_ADMINDQ_CAP))
> -		nbl_common_release_task(&task_info->clean_adminq_task);
> +static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	int ret = 0;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_ADAPT_DESC_GOTHER))
> -		nbl_common_release_task(&task_info->adapt_desc_gother_task);
> +	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> +		ret = chan_ops->setup_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_RECOVERY_ABNORMAL_STATUS))
> -		nbl_common_release_task(&task_info->recovery_abnormal_task);
> +	return ret;
> +}
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_RESET_CTRL_CAP))
> -		nbl_common_release_task(&task_info->reset_task);
> +static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	int ret = 0;
> +
> +	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> +		ret = chan_ops->teardown_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
> +
> +	return ret;
>  }
>  
> -static int nbl_dev_update_template_config(struct nbl_dev_mgt *dev_mgt)
> +static bool nbl_dev_should_chan_keepalive(struct nbl_dev_mgt *dev_mgt)
>  {
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	bool ret = true;
>  
> -	return serv_ops->update_template_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	ret = serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					     NBL_TASK_KEEP_ALIVE);
> +
> +	return ret;
>  }
>  
> -/* ----------  Dev init process  ---------- */
> -static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +static int nbl_dev_setup_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
>  {
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_dev_common *common_dev;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	int board_id;
> -
> -	common_dev = devm_kzalloc(NBL_ADAPTER_TO_DEV(adapter),
> -				  sizeof(struct nbl_dev_common), GFP_KERNEL);
> -	if (!common_dev)
> -		return -ENOMEM;
> -	common_dev->dev_mgt = dev_mgt;
> +	u16 dest_func_id = NBL_COMMON_TO_MGT_PF(common);
>  
> -	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
> -		goto setup_chan_fail;
> +	if (!nbl_dev_should_chan_keepalive(dev_mgt))
> +		return 0;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_CLEAN_MAILBOX_CAP))
> -		nbl_common_alloc_task(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +	if (chan_type != NBL_CHAN_TYPE_MAILBOX)
> +		return -EOPNOTSUPP;
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_RESET_CAP))
> -		nbl_common_alloc_task(&common_dev->reset_task.task, &nbl_dev_prepare_reset_task);
> +	dest_func_id = serv_ops->get_function_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +						 NBL_COMMON_TO_VSI_ID(common));
>  
> -	if (param->caps.is_nic) {
> -		board_id = serv_ops->get_board_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -		if (board_id < 0)
> -			goto get_board_id_fail;
> -		NBL_COMMON_TO_BOARD_ID(common) = board_id;
> -	}
> +	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> +		return chan_ops->setup_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +						 dest_func_id, chan_type);
>  
> -	NBL_COMMON_TO_VSI_ID(common) = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0,
> -							    NBL_VSI_DATA);
> +	return -ENOENT;
> +}
>  
> -	serv_ops->get_eth_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_COMMON_TO_VSI_ID(common),
> -			     &NBL_COMMON_TO_ETH_MODE(common), &NBL_COMMON_TO_ETH_ID(common),
> -			     &NBL_COMMON_TO_LOGIC_ETH_ID(common));
> +static void nbl_dev_remove_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  
> -	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, &common_dev->clean_mbx_task);
> +	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> +		chan_ops->remove_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
> +}
>  
> -	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = common_dev;
> -
> -	nbl_dev_register_common_irq(dev_mgt);
> +static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
> +				       u8 chan_type, struct work_struct *task)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  
> -	return 0;
> +	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
> +		chan_ops->register_chan_task(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type, task);
> +}
>  
> -get_board_id_fail:
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_RESET_CAP))
> -		nbl_common_release_task(&common_dev->reset_task.task);
> +/* ----------  Tasks config  ---------- */
> +static void nbl_dev_clean_mailbox_task(struct work_struct *work)
> +{
> +	struct nbl_dev_common *common_dev = container_of(work, struct nbl_dev_common,
> +							 clean_mbx_task);
> +	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_CLEAN_MAILBOX_CAP))
> -		nbl_common_release_task(&common_dev->clean_mbx_task);
> -setup_chan_fail:
> -	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
> -	return -EFAULT;
> +	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_MAILBOX);
>  }
>  
> -static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
>  
> -	if (!common_dev)
> -		return;
> -
> -	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> -
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_RESET_CAP))
> -		nbl_common_release_task(&common_dev->reset_task.task);
> -
> -	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					  NBL_TASK_CLEAN_MAILBOX_CAP))
> -		nbl_common_release_task(&common_dev->clean_mbx_task);
> -
> -	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +	if (ctrl_dev)
> +		queue_work(ctrl_dev->ctrl_dev_wq1, &common_dev->clean_mbx_task);
> +	else
> +		nbl_common_queue_work(&common_dev->clean_mbx_task, false);
>  
> -	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
> -	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = NULL;
> +	return 0;
>  }
>  
> -static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +static void nbl_dev_prepare_reset_task(struct work_struct *work)
>  {
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	struct nbl_dev_ctrl *ctrl_dev;
> -	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> +	int ret;
> +	struct nbl_reset_task_info *task_info = container_of(work, struct nbl_reset_task_info,
> +							     task);
> +	struct nbl_dev_common *common_dev = container_of(task_info, struct nbl_dev_common,
> +							 reset_task);
> +	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
>  	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	int i, ret = 0;
> -	u32 board_key;
> -	char part_number[50] = "";
> -	char serial_number[128] = "";
> -	int board_id;
> -
> -	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
> -			dev_mgt->common->pdev->bus->number;
> -	if (param->caps.is_nic) {
> -		board_id =
> -			nbl_dev_alloc_board_id(&board_id_table, board_key);
> -		if (board_id < 0)
> -			return -ENOSPC;
> -		NBL_COMMON_TO_BOARD_ID(common) =  board_id;
> -	}
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_chan_send_info chan_send;
>  
> -	dev_info(dev, "board_key 0x%x alloc board id 0x%x\n",
> -		 board_key, NBL_COMMON_TO_BOARD_ID(common));
> +	serv_ops->netdev_stop(dev_mgt->net_dev->netdev);
> +	netif_device_detach(dev_mgt->net_dev->netdev); /* to avoid ethtool operation */
> +	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
>  
> -	ctrl_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_ctrl), GFP_KERNEL);
> -	if (!ctrl_dev)
> -		goto alloc_fail;
> -	NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev)->adapter = adapter;
> -	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = ctrl_dev;
> +	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_ACK_RESET_EVENT, NULL,
> +		      0, NULL, 0, 0);
> +	/* notify ctrl dev, finish reset event process */
> +	ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
> +	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
> +				  NBL_CHAN_TYPE_MAILBOX, true);
>  
> -	nbl_dev_register_ctrl_irq(dev_mgt);
> +	/* sleep to avoid send_msg is running */
> +	usleep_range(10, 20);
>  
> -	ctrl_dev->ctrl_dev_wq1 = create_singlethread_workqueue("nbl_ctrldev_wq1");
> -	if (!ctrl_dev->ctrl_dev_wq1) {
> -		dev_err(dev, "Failed to create workqueue nbl_ctrldev_wq1\n");
> -		goto alloc_wq_fail;
> -	}
> +	/* ctrl dev must shutdown phy reg read/write after ctrl dev has notify emp shutdown dev */
> +	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
> +		serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
> +}
>  
> -	ret = serv_ops->init_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -	if (ret) {
> -		dev_err(dev, "ctrl dev chip_init failed\n");
> -		goto chip_init_fail;
> -	}
> +static void nbl_dev_clean_adminq_task(struct work_struct *work)
> +{
> +	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> +						       clean_adminq_task);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  
> -	ret = serv_ops->start_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -	if (ret) {
> -		dev_err(dev, "ctrl dev start_mgt_flow failed\n");
> -		goto mgt_flow_fail;
> -	}
> +	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_ADMINQ);
> +}
>  
> -	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
> -		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
> -		if (ret) {
> -			dev_err(dev, "ctrl dev setup chan qinfo failed\n");
> -				goto setup_chan_q_fail;
> -		}
> -	}
> +static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info)
> +{
> +	nbl_common_queue_work(&task_info->clean_adminq_task, true);
> +}
>  
> -	nbl_dev_ctrl_register_flr_chan_msg(dev_mgt);
> -	nbl_dev_ctrl_register_emp_ext_alert_chan_msg(dev_mgt);
> +static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
> +{
> +	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> +						       fw_hb_task);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
>  
> -	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> -	if (ret) {
> -		dev_err(dev, "ctrl dev setup chan queue failed\n");
> -			goto setup_chan_q_fail;
> -	}
> +	if (task_info->fw_resetting)
> +		return;
>  
> -	ret = nbl_dev_setup_ctrl_dev_task(dev_mgt);
> -	if (ret) {
> -		dev_err(dev, "ctrl dev task failed\n");
> -		goto setup_ctrl_dev_task_fail;
> +	if (!serv_ops->check_fw_heartbeat(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
> +		dev_notice(NBL_COMMON_TO_DEV(common), "FW reset detected");
> +		task_info->fw_resetting = true;
> +		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
> +					NBL_CHAN_TYPE_ADMINQ, true);
> +		nbl_common_queue_delayed_work(&task_info->fw_reset_task, MSEC_PER_SEC, true);
>  	}
> -
> -	serv_ops->get_part_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), part_number);
> -	serv_ops->get_serial_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), serial_number);
> -	dev_info(dev, "part number: %s, serial number: %s\n", part_number, serial_number);
> -
> -	nbl_dev_update_template_config(dev_mgt);
> -
> -	return 0;
> -
> -setup_ctrl_dev_task_fail:
> -	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> -setup_chan_q_fail:
> -	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -mgt_flow_fail:
> -	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -chip_init_fail:
> -	destroy_workqueue(ctrl_dev->ctrl_dev_wq1);
> -alloc_wq_fail:
> -	devm_kfree(dev, ctrl_dev);
> -	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = NULL;
> -alloc_fail:
> -	nbl_dev_free_board_id(&board_id_table, board_key);
> -	return ret;
>  }
>  
> -static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
> +static void nbl_dev_fw_reset_task(struct work_struct *work)
>  {
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_dev_ctrl **ctrl_dev = &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct delayed_work *delayed_work = to_delayed_work(work);
> +	struct nbl_task_info *task_info = container_of(delayed_work, struct nbl_task_info,
> +						       fw_reset_task);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	u32 board_key;
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
>  
> -	if (!*ctrl_dev)
> -		return;
> +	if (serv_ops->check_fw_reset(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
> +		dev_notice(NBL_COMMON_TO_DEV(common), "FW recovered");
> +		nbl_dev_disable_adminq_irq(dev_mgt);
> +		nbl_dev_free_adminq_irq(dev_mgt, task_info);
>  
> -	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
> -			dev_mgt->common->pdev->bus->number;
> -	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> -	nbl_dev_remove_ctrl_dev_task(dev_mgt);
> +		msleep(NBL_DEV_FW_RESET_WAIT_TIME); // wait adminq timeout
> +		nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> +		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> +		nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> +		nbl_dev_request_adminq_irq(dev_mgt, task_info);
> +		nbl_dev_enable_adminq_irq(dev_mgt);
>  
> -	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
> +					  NBL_CHAN_TYPE_ADMINQ, false);
>  
> -	destroy_workqueue((*ctrl_dev)->ctrl_dev_wq1);
> -	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), *ctrl_dev);
> -	*ctrl_dev = NULL;
> +		if (NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)) {
> +			nbl_dev_get_port_attributes(dev_mgt);
> +			nbl_dev_enable_port(dev_mgt, true);
> +		}
> +		task_info->fw_resetting = false;
> +		return;
> +	}
>  
> -	/* If it is not nic, this free function will do nothing, so no need check */
> -	nbl_dev_free_board_id(&board_id_table, board_key);
> +	nbl_common_queue_delayed_work(delayed_work, MSEC_PER_SEC, true);
>  }
>  
> -static int nbl_dev_netdev_open(struct net_device *netdev)
> +static void nbl_dev_adapt_desc_gother_task(struct work_struct *work)
>  {
> -	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> -	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> +						       adapt_desc_gother_task);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  
> -	return serv_ops->netdev_open(netdev);
> +	serv_ops->adapt_desc_gother(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
>  }
>  
> -static int nbl_dev_netdev_stop(struct net_device *netdev)
> +static void nbl_dev_recovery_abnormal_task(struct work_struct *work)
>  {
> -	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> -	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> +						       recovery_abnormal_task);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  
> -	return serv_ops->netdev_stop(netdev);
> +	serv_ops->recovery_abnormal(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
>  }
>  
> -static netdev_tx_t nbl_dev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
> +static void nbl_dev_ctrl_reset_task(struct work_struct *work)
>  {
> -	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> -	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_resource_pt_ops *pt_ops = NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt);
> +	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
> +						       reset_task);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
>  
> -	return pt_ops->start_xmit(skb, netdev);
> +	nbl_dev_handle_fatal_err(dev_mgt);
>  }
>  
> -static void nbl_dev_netdev_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
> +static void nbl_dev_ctrl_task_schedule(struct nbl_task_info *task_info)
>  {
> -	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> -	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  
> -	serv_ops->get_stats64(netdev, stats);
> -}
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_FW_HB_CAP))
> +		nbl_common_queue_work(&task_info->fw_hb_task, true);
>  
> -static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
> -{
> -	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> -	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_ADAPT_DESC_GOTHER))
> +		nbl_common_queue_work(&task_info->adapt_desc_gother_task, true);
>  
> -	return serv_ops->rx_add_vid(netdev, proto, vid);
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_RECOVERY_ABNORMAL_STATUS))
> +		nbl_common_queue_work(&task_info->recovery_abnormal_task, true);
>  }
>  
> -static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
> +static void nbl_dev_ctrl_task_timer(struct timer_list *t)
>  {
> -	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> -	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_task_info *task_info = container_of(t, struct nbl_task_info, serv_timer);
> +
> +	mod_timer(&task_info->serv_timer, round_jiffies(task_info->serv_timer_period + jiffies));
> +	nbl_dev_ctrl_task_schedule(task_info);
> +}
> +
> +static void nbl_dev_ctrl_task_start(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> +
> +	if (!task_info->timer_setup)
> +		return;
> +
> +	mod_timer(&task_info->serv_timer, round_jiffies(jiffies + task_info->serv_timer_period));
> +}
> +
> +static void nbl_dev_ctrl_task_stop(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> +
> +	if (!task_info->timer_setup)
> +		return;
> +
> +	timer_delete_sync(&task_info->serv_timer);
> +	task_info->timer_setup = false;
> +}
> +
> +static void nbl_dev_chan_notify_flr_resp(void *priv, u16 src_id, u16 msg_id,
> +					 void *data, u32 data_len)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	u16 vfid;
>  
> -	return serv_ops->rx_kill_vid(netdev, proto, vid);
> +	vfid = *(u16 *)data;
> +	serv_ops->process_flr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vfid);
>  }
>  
> -static const struct net_device_ops netdev_ops_leonis_pf = {
> -	.ndo_open = nbl_dev_netdev_open,
> -	.ndo_stop = nbl_dev_netdev_stop,
> -	.ndo_start_xmit = nbl_dev_start_xmit,
> -	.ndo_validate_addr = eth_validate_addr,
> -	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
> -	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
> -	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
> +static void nbl_dev_ctrl_register_flr_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					   NBL_PROCESS_FLR_CAP))
> +		return;
> +
> +	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +			       NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY,
> +			       nbl_dev_chan_notify_flr_resp, dev_mgt);
> +}
>  
> +static struct nbl_dev_temp_alarm_info temp_alarm_info[NBL_TEMP_STATUS_MAX] = {
> +	{LOGLEVEL_WARNING, "High temperature on sensors0 resumed.\n"},
> +	{LOGLEVEL_WARNING, "High temperature on sensors0 observed, security(WARNING).\n"},
> +	{LOGLEVEL_CRIT, "High temperature on sensors0 observed, security(CRITICAL).\n"},
> +	{LOGLEVEL_EMERG, "High temperature on sensors0 observed, security(EMERGENCY).\n"},
>  };
>  
> -static const struct net_device_ops netdev_ops_leonis_vf = {
> -	.ndo_open = nbl_dev_netdev_open,
> -	.ndo_stop = nbl_dev_netdev_stop,
> -	.ndo_start_xmit = nbl_dev_start_xmit,
> -	.ndo_validate_addr = eth_validate_addr,
> -	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
> -	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
> -	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
> +static void nbl_dev_handle_temp_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
> +{
> +	u16 temp = (u16)*data;
> +	u64 uptime = 0;
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	enum nbl_dev_temp_status old_temp_status = ctrl_dev->temp_status;
> +	enum nbl_dev_temp_status new_temp_status = NBL_TEMP_STATUS_NORMAL;
> +
> +	/* no resume if temp exceed NBL_TEMP_EMERG_THRESHOLD, even if the temp resume nomal.
> +	 * Because the hw has shutdown.
> +	 */
> +	if (old_temp_status == NBL_TEMP_STATUS_EMERG)
> +		return;
> +
> +	/* if temp in (85-105) and not in normal_status, no resume to avoid alarm oscillate */
> +	if (temp > NBL_TEMP_NOMAL_THRESHOLD &&
> +	    temp < NBL_TEMP_WARNING_THRESHOLD &&
> +	    old_temp_status > NBL_TEMP_STATUS_NORMAL)
> +		return;
> +
> +	if (temp >= NBL_TEMP_WARNING_THRESHOLD &&
> +	    temp < NBL_TEMP_CRIT_THRESHOLD)
> +		new_temp_status = NBL_TEMP_STATUS_WARNING;
> +	else if (temp >= NBL_TEMP_CRIT_THRESHOLD &&
> +		 temp < NBL_TEMP_EMERG_THRESHOLD)
> +		new_temp_status = NBL_TEMP_STATUS_CRIT;
> +	else if (temp >= NBL_TEMP_EMERG_THRESHOLD)
> +		new_temp_status = NBL_TEMP_STATUS_EMERG;
> +
> +	if (new_temp_status == old_temp_status)
> +		return;
> +
> +	ctrl_dev->temp_status = new_temp_status;
> +
> +	/* temp fall only alarm when the alarm need to resume */
> +	if (new_temp_status < old_temp_status && new_temp_status != NBL_TEMP_STATUS_NORMAL)
> +		return;
> +
> +	if (data_len > sizeof(u16))
> +		uptime = *(u64 *)(data + sizeof(u16));
> +	nbl_log(common, temp_alarm_info[new_temp_status].logvel,
> +		"[%llu] %s", uptime, temp_alarm_info[new_temp_status].alarm_info);
> +
> +	if (new_temp_status == NBL_TEMP_STATUS_EMERG) {
> +		ctrl_dev->task_info.reset_event = NBL_HW_FATAL_ERR_EVENT;
> +		nbl_common_queue_work(&ctrl_dev->task_info.reset_task, false);
> +	}
> +}
> +
> +static const char *nbl_log_level_name(int level)
> +{
> +	switch (level) {
> +	case NBL_EMP_ALERT_LOG_FATAL:
> +		return "FATAL";
> +	case NBL_EMP_ALERT_LOG_ERROR:
> +		return "ERROR";
> +	case NBL_EMP_ALERT_LOG_WARNING:
> +		return "WARNING";
> +	case NBL_EMP_ALERT_LOG_INFO:
> +		return "INFO";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
> +static void nbl_dev_handle_emp_log_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
> +{
> +	struct nbl_emp_alert_log_event *log_event = (struct nbl_emp_alert_log_event *)data;
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +
> +	nbl_log(common, LOGLEVEL_INFO, "[FW][%llu] <%s> %.*s", log_event->uptime,
> +		nbl_log_level_name(log_event->level), data_len - sizeof(u64) - sizeof(u8),
> +		log_event->data);
> +}
> +
> +static void nbl_dev_chan_notify_evt_alert_resp(void *priv, u16 src_id, u16 msg_id,
> +					       void *data, u32 data_len)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> +	struct nbl_chan_param_emp_alert_event *alert_param =
> +						(struct nbl_chan_param_emp_alert_event *)data;
> +
> +	switch (alert_param->type) {
> +	case NBL_EMP_EVENT_TEMP_ALERT:
> +		nbl_dev_handle_temp_ext(dev_mgt, alert_param->data, alert_param->len);
> +		return;
> +	case NBL_EMP_EVENT_LOG_ALERT:
> +		nbl_dev_handle_emp_log_ext(dev_mgt, alert_param->data, alert_param->len);
> +		return;
> +	default:
> +		return;
> +	}
> +}
> +
> +static void nbl_dev_ctrl_register_emp_ext_alert_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +
> +	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +					 NBL_CHAN_TYPE_MAILBOX))
> +		return;
> +
> +	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +			       NBL_CHAN_MSG_ADMINQ_EXT_ALERT,
> +			       nbl_dev_chan_notify_evt_alert_resp, dev_mgt);
> +}
> +
> +static int nbl_dev_setup_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	task_info->dev_mgt = dev_mgt;
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_FW_HB_CAP)) {
> +		nbl_common_alloc_task(&task_info->fw_hb_task, nbl_dev_fw_heartbeat_task);
> +		task_info->timer_setup = true;
> +	}
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_FW_RESET_CAP)) {
> +		nbl_common_alloc_delayed_task(&task_info->fw_reset_task, nbl_dev_fw_reset_task);
> +		task_info->timer_setup = true;
> +	}
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_CLEAN_ADMINDQ_CAP)) {
> +		nbl_common_alloc_task(&task_info->clean_adminq_task, nbl_dev_clean_adminq_task);
> +		task_info->timer_setup = true;
> +	}
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_ADAPT_DESC_GOTHER)) {
> +		nbl_common_alloc_task(&task_info->adapt_desc_gother_task,
> +				      nbl_dev_adapt_desc_gother_task);
> +		task_info->timer_setup = true;
> +	}
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_RECOVERY_ABNORMAL_STATUS)) {
> +		nbl_common_alloc_task(&task_info->recovery_abnormal_task,
> +				      nbl_dev_recovery_abnormal_task);
> +		task_info->timer_setup = true;
> +	}
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_RESET_CTRL_CAP))
> +		nbl_common_alloc_task(&task_info->reset_task, &nbl_dev_ctrl_reset_task);
> +
> +	nbl_common_alloc_task(&task_info->clean_abnormal_irq_task,
> +			      nbl_dev_handle_abnormal_event);
> +
> +	if (task_info->timer_setup) {
> +		timer_setup(&task_info->serv_timer, nbl_dev_ctrl_task_timer, 0);
> +		task_info->serv_timer_period = HZ;
> +	}
> +
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, &task_info->clean_adminq_task);
> +
> +	return 0;
> +}
> +
> +static void nbl_dev_remove_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
> +
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, NULL);
> +
> +	nbl_common_release_task(&task_info->clean_abnormal_irq_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_FW_RESET_CAP))
> +		nbl_common_release_delayed_task(&task_info->fw_reset_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_FW_HB_CAP))
> +		nbl_common_release_task(&task_info->fw_hb_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_CLEAN_ADMINDQ_CAP))
> +		nbl_common_release_task(&task_info->clean_adminq_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_ADAPT_DESC_GOTHER))
> +		nbl_common_release_task(&task_info->adapt_desc_gother_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_RECOVERY_ABNORMAL_STATUS))
> +		nbl_common_release_task(&task_info->recovery_abnormal_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_RESET_CTRL_CAP))
> +		nbl_common_release_task(&task_info->reset_task);
> +}
> +
> +static int nbl_dev_update_template_config(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->update_template_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +}
> +
> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_common *common_dev;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	int board_id;
> +
> +	common_dev = devm_kzalloc(NBL_ADAPTER_TO_DEV(adapter),
> +				  sizeof(struct nbl_dev_common), GFP_KERNEL);
> +	if (!common_dev)
> +		return -ENOMEM;
> +	common_dev->dev_mgt = dev_mgt;
> +
> +	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
> +		goto setup_chan_fail;
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_CLEAN_MAILBOX_CAP))
> +		nbl_common_alloc_task(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_RESET_CAP))
> +		nbl_common_alloc_task(&common_dev->reset_task.task, &nbl_dev_prepare_reset_task);
> +
> +	if (param->caps.is_nic) {
> +		board_id = serv_ops->get_board_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +		if (board_id < 0)
> +			goto get_board_id_fail;
> +		NBL_COMMON_TO_BOARD_ID(common) = board_id;
> +	}
> +
> +	NBL_COMMON_TO_VSI_ID(common) = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0,
> +							    NBL_VSI_DATA);
> +
> +	serv_ops->get_eth_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_COMMON_TO_VSI_ID(common),
> +			     &NBL_COMMON_TO_ETH_MODE(common), &NBL_COMMON_TO_ETH_ID(common),
> +			     &NBL_COMMON_TO_LOGIC_ETH_ID(common));
> +
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, &common_dev->clean_mbx_task);
> +
> +	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = common_dev;
> +
> +	nbl_dev_register_common_irq(dev_mgt);
> +
> +	return 0;
> +
> +get_board_id_fail:
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_RESET_CAP))
> +		nbl_common_release_task(&common_dev->reset_task.task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_CLEAN_MAILBOX_CAP))
> +		nbl_common_release_task(&common_dev->clean_mbx_task);
> +setup_chan_fail:
> +	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
> +	return -EFAULT;
> +}
> +
> +static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
> +
> +	if (!common_dev)
> +		return;
> +
> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_RESET_CAP))
> +		nbl_common_release_task(&common_dev->reset_task.task);
> +
> +	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					  NBL_TASK_CLEAN_MAILBOX_CAP))
> +		nbl_common_release_task(&common_dev->clean_mbx_task);
> +
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
> +
> +	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
> +	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = NULL;
> +}
> +
> +static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_ctrl *ctrl_dev;
> +	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	int i, ret = 0;
> +	u32 board_key;
> +	char part_number[50] = "";
> +	char serial_number[128] = "";
> +	int board_id;
> +
> +	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
> +			dev_mgt->common->pdev->bus->number;
> +	if (param->caps.is_nic) {
> +		board_id =
> +			nbl_dev_alloc_board_id(&board_id_table, board_key);
> +		if (board_id < 0)
> +			return -ENOSPC;
> +		NBL_COMMON_TO_BOARD_ID(common) =  board_id;
> +	}
> +
> +	dev_info(dev, "board_key 0x%x alloc board id 0x%x\n",
> +		 board_key, NBL_COMMON_TO_BOARD_ID(common));
> +
> +	ctrl_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_ctrl), GFP_KERNEL);
> +	if (!ctrl_dev)
> +		goto alloc_fail;
> +	NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev)->adapter = adapter;
> +	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = ctrl_dev;
> +
> +	nbl_dev_register_ctrl_irq(dev_mgt);
> +
> +	ctrl_dev->ctrl_dev_wq1 = create_singlethread_workqueue("nbl_ctrldev_wq1");
> +	if (!ctrl_dev->ctrl_dev_wq1) {
> +		dev_err(dev, "Failed to create workqueue nbl_ctrldev_wq1\n");
> +		goto alloc_wq_fail;
> +	}
> +
> +	ret = serv_ops->init_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	if (ret) {
> +		dev_err(dev, "ctrl dev chip_init failed\n");
> +		goto chip_init_fail;
> +	}
> +
> +	ret = serv_ops->start_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	if (ret) {
> +		dev_err(dev, "ctrl dev start_mgt_flow failed\n");
> +		goto mgt_flow_fail;
> +	}
> +
> +	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
> +		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
> +		if (ret) {
> +			dev_err(dev, "ctrl dev setup chan qinfo failed\n");
> +				goto setup_chan_q_fail;
> +		}
> +	}
> +
> +	nbl_dev_ctrl_register_flr_chan_msg(dev_mgt);
> +	nbl_dev_ctrl_register_emp_ext_alert_chan_msg(dev_mgt);
> +
> +	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> +	if (ret) {
> +		dev_err(dev, "ctrl dev setup chan queue failed\n");
> +			goto setup_chan_q_fail;
> +	}
> +
> +	ret = nbl_dev_setup_ctrl_dev_task(dev_mgt);
> +	if (ret) {
> +		dev_err(dev, "ctrl dev task failed\n");
> +		goto setup_ctrl_dev_task_fail;
> +	}
> +
> +	serv_ops->get_part_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), part_number);
> +	serv_ops->get_serial_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), serial_number);
> +	dev_info(dev, "part number: %s, serial number: %s\n", part_number, serial_number);
> +
> +	nbl_dev_update_template_config(dev_mgt);
> +
> +	return 0;
> +
> +setup_ctrl_dev_task_fail:
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> +setup_chan_q_fail:
> +	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +mgt_flow_fail:
> +	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +chip_init_fail:
> +	destroy_workqueue(ctrl_dev->ctrl_dev_wq1);
> +alloc_wq_fail:
> +	devm_kfree(dev, ctrl_dev);
> +	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = NULL;
> +alloc_fail:
> +	nbl_dev_free_board_id(&board_id_table, board_key);
> +	return ret;
> +}
> +
> +static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_ctrl **ctrl_dev = &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	u32 board_key;
> +
> +	if (!*ctrl_dev)
> +		return;
> +
> +	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
> +			dev_mgt->common->pdev->bus->number;
> +	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
> +	nbl_dev_remove_ctrl_dev_task(dev_mgt);
> +
> +	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +
> +	destroy_workqueue((*ctrl_dev)->ctrl_dev_wq1);
> +	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), *ctrl_dev);
> +	*ctrl_dev = NULL;
> +
> +	/* If it is not nic, this free function will do nothing, so no need check */
> +	nbl_dev_free_board_id(&board_id_table, board_key);
> +}
> +
> +static int nbl_dev_netdev_open(struct net_device *netdev)
> +{
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->netdev_open(netdev);
> +}
> +
> +static int nbl_dev_netdev_stop(struct net_device *netdev)
> +{
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->netdev_stop(netdev);
> +}
> +
> +static netdev_tx_t nbl_dev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_resource_pt_ops *pt_ops = NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt);
> +
> +	return pt_ops->start_xmit(skb, netdev);
> +}
> +
> +static void nbl_dev_netdev_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
> +{
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	serv_ops->get_stats64(netdev, stats);
> +}
> +
> +static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
> +{
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->rx_add_vid(netdev, proto, vid);
> +}
> +
> +static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
> +{
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	return serv_ops->rx_kill_vid(netdev, proto, vid);
> +}
> +
> +static const struct net_device_ops netdev_ops_leonis_pf = {
> +	.ndo_open = nbl_dev_netdev_open,
> +	.ndo_stop = nbl_dev_netdev_stop,
> +	.ndo_start_xmit = nbl_dev_start_xmit,
> +	.ndo_validate_addr = eth_validate_addr,
> +	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
> +	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
> +
> +};
> +
> +static const struct net_device_ops netdev_ops_leonis_vf = {
> +	.ndo_open = nbl_dev_netdev_open,
> +	.ndo_stop = nbl_dev_netdev_stop,
> +	.ndo_start_xmit = nbl_dev_start_xmit,
> +	.ndo_validate_addr = eth_validate_addr,
> +	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
> +	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
> +
> +};
> +
> +static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
> +				       struct nbl_init_param *param)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	bool is_vf = param->caps.is_vf;
> +
> +	if (is_vf) {
> +		netdev->netdev_ops = &netdev_ops_leonis_vf;
> +	} else {
> +		netdev->netdev_ops = &netdev_ops_leonis_pf;
> +		serv_ops->set_netdev_ops(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					 &netdev_ops_leonis_pf, true);
> +	}
> +	return 0;
> +}
> +
> +static void nbl_dev_remove_netops(struct net_device *netdev)
> +{
> +	netdev->netdev_ops = NULL;
> +}
> +
> +static void nbl_dev_set_eth_mac_addr(struct nbl_dev_mgt *dev_mgt, struct net_device *netdev)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	u8 mac[ETH_ALEN];
> +
> +	ether_addr_copy(mac, netdev->dev_addr);
> +	serv_ops->set_eth_mac_addr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +				   mac, NBL_COMMON_TO_ETH_ID(common));
> +}
> +
> +static int nbl_dev_cfg_netdev(struct net_device *netdev, struct nbl_dev_mgt *dev_mgt,
> +			      struct nbl_init_param *param,
> +			      struct nbl_register_net_result *register_result)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_net_ops *net_dev_ops = NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt);
> +	u64 vlan_features = 0;
> +	int ret = 0;
> +
> +	if (param->pci_using_dac)
> +		netdev->features |= NETIF_F_HIGHDMA;
> +	netdev->watchdog_timeo = 5 * HZ;
> +
> +	vlan_features = register_result->vlan_features ? register_result->vlan_features
> +							: register_result->features;
> +	netdev->hw_features |= nbl_features_to_netdev_features(register_result->hw_features);
> +	netdev->features |= nbl_features_to_netdev_features(register_result->features);
> +	netdev->vlan_features |= nbl_features_to_netdev_features(vlan_features);
> +
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +
> +	SET_DEV_MIN_MTU(netdev, ETH_MIN_MTU);
> +	SET_DEV_MAX_MTU(netdev, register_result->max_mtu);
> +	netdev->mtu = min_t(u16, register_result->max_mtu, NBL_DEFAULT_MTU);
> +	serv_ops->change_mtu(netdev, netdev->mtu);
> +
> +	if (is_valid_ether_addr(register_result->mac))
> +		eth_hw_addr_set(netdev, register_result->mac);
> +	else
> +		eth_hw_addr_random(netdev);
> +
> +	ether_addr_copy(netdev->perm_addr, netdev->dev_addr);
> +
> +	serv_ops->set_spoof_check_addr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev->perm_addr);
> +
> +	netdev->needed_headroom = serv_ops->get_tx_headroom(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +
> +	ret = net_dev_ops->setup_netdev_ops(dev_mgt, netdev, param);
> +	if (ret)
> +		goto set_ops_fail;
> +
> +	nbl_dev_set_eth_mac_addr(dev_mgt, netdev);
> +
> +	return 0;
> +set_ops_fail:
> +	return ret;
> +}
> +
> +static void nbl_dev_reset_netdev(struct net_device *netdev)
> +{
> +	nbl_dev_remove_netops(netdev);
> +}
> +
> +static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
> +				struct nbl_register_net_result *register_result)
> +{
> +	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(NBL_DEV_MGT_TO_COMMON(dev_mgt));
> +#ifdef CONFIG_PCI_IOV
> +	struct resource *res;
> +#endif
> +	u16 pf_bdf;
> +	u64 pf_bar_start;
> +	u64 vf_bar_start, vf_bar_size;
> +	u16 total_vfs = 0, offset, stride;
> +	int pos;
> +	u32 val;
> +	struct nbl_register_net_param register_param = {0};
> +	int ret = 0;
> +
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &val);
> +	pf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0 + 4, &val);
> +	pf_bar_start |= ((u64)val << 32);
> +
> +	register_param.pf_bar_start = pf_bar_start;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +	if (pos) {
> +		pf_bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_OFFSET, &offset);
> +		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_STRIDE, &stride);
> +		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF, &total_vfs);
> +
> +		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR, &val);
> +		vf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
> +		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR + 4, &val);
> +		vf_bar_start |= ((u64)val << 32);
> +
> +#ifdef CONFIG_PCI_IOV
> +		res = &pdev->resource[PCI_IOV_RESOURCES];
> +		vf_bar_size = resource_size(res);
> +#else
> +		vf_bar_size = 0;
> +#endif
> +		if (total_vfs) {
> +			register_param.pf_bdf = pf_bdf;
> +			register_param.vf_bar_start = vf_bar_start;
> +			register_param.vf_bar_size = vf_bar_size;
> +			register_param.total_vfs = total_vfs;
> +			register_param.offset = offset;
> +			register_param.stride = stride;
> +		}
> +	}
> +
> +	net_dev->total_vfs = total_vfs;
> +
> +	ret = serv_ops->register_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +				     &register_param, register_result);
> +
> +	if (!register_result->tx_queue_num || !register_result->rx_queue_num)
> +		return -EIO;
> +
> +	return ret;
> +}
> +
> +static void nbl_dev_unregister_net(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	int ret;
> +
> +	ret = serv_ops->unregister_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +	if (ret)
> +		dev_err(dev, "unregister net failed\n");
> +}
> +
> +static u16 nbl_dev_vsi_alloc_queue(struct nbl_dev_net *net_dev, u16 queue_num)
> +{
> +	struct nbl_dev_vsi_controller *vsi_ctrl = &net_dev->vsi_ctrl;
> +	u16 queue_offset = 0;
> +
> +	if (vsi_ctrl->queue_free_offset + queue_num > net_dev->total_queue_num)
> +		return -ENOSPC;
> +
> +	queue_offset = vsi_ctrl->queue_free_offset;
> +	vsi_ctrl->queue_free_offset += queue_num;
> +
> +	return queue_offset;
> +}
> +
> +static int nbl_dev_vsi_common_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				    struct nbl_dev_vsi *vsi)
> +{
> +	int ret = 0;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_vsi_param vsi_param = {0};
> +
> +	vsi->queue_offset = nbl_dev_vsi_alloc_queue(NBL_DEV_MGT_TO_NET_DEV(dev_mgt),
> +						    vsi->queue_num);
> +	vsi_param.index = vsi->index;
> +	vsi_param.vsi_id = vsi->vsi_id;
> +	vsi_param.queue_offset = vsi->queue_offset;
> +	vsi_param.queue_num = vsi->queue_num;
> +
> +	/* Tell serv & res layer the mapping from vsi to queue_id */
> +	ret = serv_ops->register_vsi_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &vsi_param);
> +	return ret;
> +}
> +
> +static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
> +{
> +}
> +
> +static int nbl_dev_vsi_common_start(struct nbl_dev_mgt *dev_mgt, struct net_device *netdev,
> +				    struct nbl_dev_vsi *vsi)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	int ret;
> +
> +	vsi->napi_netdev = netdev;
> +
> +	ret = serv_ops->setup_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +	if (ret) {
> +		dev_err(dev, "Setup q2vsi failed\n");
> +		goto set_q2vsi_fail;
> +	}
> +
> +	ret = serv_ops->setup_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +	if (ret) {
> +		dev_err(dev, "Setup rss failed\n");
> +		goto set_rss_fail;
> +	}
> +
> +	ret = serv_ops->setup_rss_indir(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +	if (ret) {
> +		dev_err(dev, "Setup rss indir failed\n");
> +		goto setup_rss_indir_fail;
> +	}
> +
> +	if (vsi->use_independ_irq) {
> +		ret = serv_ops->enable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
> +		if (ret) {
> +			dev_err(dev, "Enable napis failed\n");
> +			goto enable_napi_fail;
> +		}
> +	}
> +
> +	ret = serv_ops->init_tx_rate(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +	if (ret) {
> +		dev_err(dev, "init tx_rate failed\n");
> +		goto init_tx_rate_fail;
> +	}
> +
> +	return 0;
> +
> +init_tx_rate_fail:
> +	serv_ops->disable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
> +enable_napi_fail:
> +setup_rss_indir_fail:
> +	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +set_rss_fail:
> +	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +set_q2vsi_fail:
> +	return ret;
> +}
> +
> +static void nbl_dev_vsi_common_stop(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
> +{
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	if (vsi->use_independ_irq)
> +		serv_ops->disable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
> +	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +}
> +
> +static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				     void *vsi_data)
> +{
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	int ret = 0;
> +
> +	ret = nbl_dev_register_net(dev_mgt, &vsi->register_result);
> +	if (ret)
> +		return ret;
> +
> +	vsi->queue_num = vsi->register_result.tx_queue_num;
> +	vsi->queue_size = vsi->register_result.queue_size;
> +
> +	nbl_debug(common, NBL_DEBUG_VSI, "Data vsi register, queue_num %d, queue_size %d",
> +		  vsi->queue_num, vsi->queue_size);
> +
> +	return 0;
> +}
> +
> +static int nbl_dev_vsi_data_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				  void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
> +}
> +
> +static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	nbl_dev_vsi_common_remove(dev_mgt, vsi);
> +}
> +
> +static int nbl_dev_vsi_data_start(void *dev_priv, struct net_device *netdev,
> +				  void *vsi_data)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	int ret;
> +	u16 vid;
> +
> +	vid = vsi->register_result.vlan_tci & VLAN_VID_MASK;
> +	ret = serv_ops->start_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev, vsi->vsi_id, vid,
> +				       vsi->register_result.trusted);
> +	if (ret) {
> +		dev_err(dev, "Set netdev flow table failed\n");
> +		goto set_flow_fail;
> +	}
> +
> +	if (!NBL_COMMON_TO_VF_CAP(common)) {
> +		ret = serv_ops->set_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +		if (ret) {
> +			dev_err(dev, "Set netdev lldp flow failed\n");
> +			goto set_lldp_fail;
> +		}
> +		vsi->feature.has_lldp = true;
> +	}
> +
> +	ret = nbl_dev_vsi_common_start(dev_mgt, netdev, vsi);
> +	if (ret) {
> +		dev_err(dev, "Vsi common start failed\n");
> +		goto common_start_fail;
> +	}
> +
> +	return 0;
> +
> +common_start_fail:
> +	if (!NBL_COMMON_TO_VF_CAP(common))
> +		serv_ops->remove_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +set_lldp_fail:
> +	serv_ops->stop_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +set_flow_fail:
> +	return ret;
> +}
> +
> +static void nbl_dev_vsi_data_stop(void *dev_priv, void *vsi_data)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	nbl_dev_vsi_common_stop(dev_mgt, vsi);
> +
> +	if (!NBL_COMMON_TO_VF_CAP(common)) {
> +		serv_ops->remove_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +		vsi->feature.has_lldp = false;
> +	}
> +
> +	serv_ops->stop_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
> +}
> +
> +static int nbl_dev_vsi_data_netdev_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +					 struct net_device *netdev, void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	vsi->netdev = netdev;
> +	return nbl_dev_cfg_netdev(netdev, dev_mgt, param, &vsi->register_result);
> +}
> +
> +static void nbl_dev_vsi_data_netdev_destroy(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	nbl_dev_reset_netdev(vsi->netdev);
> +}
> +
> +static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				     void *vsi_data)
> +{
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +				     &vsi->queue_num, &vsi->queue_size);
> +
> +	nbl_debug(common, NBL_DEBUG_VSI, "Ctrl vsi register, queue_num %d, queue_size %d",
> +		  vsi->queue_num, vsi->queue_size);
> +	return 0;
> +}
> +
> +static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				  void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
> +}
> +
> +static void nbl_dev_vsi_ctrl_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	nbl_dev_vsi_common_remove(dev_mgt, vsi);
> +}
> +
> +static int nbl_dev_vsi_ctrl_start(void *dev_priv, struct net_device *netdev,
> +				  void *vsi_data)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	int ret = 0;
> +
> +	ret = nbl_dev_vsi_common_start(dev_mgt, netdev, vsi);
> +	if (ret)
> +		goto start_fail;
> +
> +	/* For ctrl vsi, open it after create, for that we don't have ndo_open ops. */
> +	ret = serv_ops->vsi_open(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev,
> +				 vsi->index, vsi->queue_num, 1);
> +	if (ret)
> +		goto open_fail;
> +
> +	return ret;
> +
> +open_fail:
> +	nbl_dev_vsi_common_stop(dev_mgt, vsi);
> +start_fail:
> +	return ret;
> +}
> +
> +static void nbl_dev_vsi_ctrl_stop(void *dev_priv, void *vsi_data)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	serv_ops->vsi_stop(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
> +	nbl_dev_vsi_common_stop(dev_mgt, vsi);
> +}
> +
> +static int nbl_dev_vsi_ctrl_netdev_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +					 struct net_device *netdev, void *vsi_data)
> +{
> +	return 0;
> +}
> +
> +static void nbl_dev_vsi_ctrl_netdev_destroy(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +{
> +}
> +
> +static int nbl_dev_vsi_user_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				     void *vsi_data)
> +{
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +
> +	serv_ops->get_user_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +				      &vsi->queue_num, &vsi->queue_size,
> +				      NBL_COMMON_TO_VSI_ID(common));
> +
> +	nbl_debug(common, NBL_DEBUG_VSI, "User vsi register, queue_num %d, queue_size %d",
> +		  vsi->queue_num, vsi->queue_size);
> +	return 0;
> +}
> +
> +static int nbl_dev_vsi_user_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> +				  void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
> +}
> +
> +static void nbl_dev_vsi_user_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +{
> +	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +
> +	nbl_dev_vsi_common_remove(dev_mgt, vsi);
> +}
> +
> +static int nbl_dev_vsi_user_start(void *dev_priv, struct net_device *netdev,
> +				  void *vsi_data)
> +{
> +	return 0;
> +}
> +
> +static void nbl_dev_vsi_user_stop(void *dev_priv, void *vsi_data)
> +{
> +}
> +
> +static int nbl_dev_vsi_user_netdev_build(struct nbl_dev_mgt *dev_mgt,
> +					 struct nbl_init_param *param,
> +					 struct net_device *netdev, void *vsi_data)
> +{
> +	return 0;
> +}
> +
> +static void nbl_dev_vsi_user_netdev_destroy(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +{
> +	/* nothing need to do */
> +}
> +
> +static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
> +	[NBL_VSI_DATA] = {
> +		.vsi_ops = {
> +			.register_vsi = nbl_dev_vsi_data_register,
> +			.setup = nbl_dev_vsi_data_setup,
> +			.remove = nbl_dev_vsi_data_remove,
> +			.start = nbl_dev_vsi_data_start,
> +			.stop = nbl_dev_vsi_data_stop,
> +			.netdev_build = nbl_dev_vsi_data_netdev_build,
> +			.netdev_destroy = nbl_dev_vsi_data_netdev_destroy,
> +		},
> +		.vf_support = true,
> +		.only_nic_support = false,
> +		.in_kernel = true,
> +		.use_independ_irq = true,
> +		.static_queue = true,
> +	},
> +	[NBL_VSI_CTRL] = {
> +		.vsi_ops = {
> +			.register_vsi = nbl_dev_vsi_ctrl_register,
> +			.setup = nbl_dev_vsi_ctrl_setup,
> +			.remove = nbl_dev_vsi_ctrl_remove,
> +			.start = nbl_dev_vsi_ctrl_start,
> +			.stop = nbl_dev_vsi_ctrl_stop,
> +			.netdev_build = nbl_dev_vsi_ctrl_netdev_build,
> +			.netdev_destroy = nbl_dev_vsi_ctrl_netdev_destroy,
> +		},
> +		.vf_support = false,
> +		.only_nic_support = true,
> +		.in_kernel = true,
> +		.use_independ_irq = true,
> +		.static_queue = true,
> +	},
> +	[NBL_VSI_USER] = {
> +		.vsi_ops = {
> +			.register_vsi = nbl_dev_vsi_user_register,
> +			.setup = nbl_dev_vsi_user_setup,
> +			.remove = nbl_dev_vsi_user_remove,
> +			.start = nbl_dev_vsi_user_start,
> +			.stop = nbl_dev_vsi_user_stop,
> +			.netdev_build = nbl_dev_vsi_user_netdev_build,
> +			.netdev_destroy = nbl_dev_vsi_user_netdev_destroy,
> +		},
> +		.vf_support = false,
> +		.only_nic_support = true,
> +		.in_kernel = false,
> +		.use_independ_irq = false,
> +		.static_queue = false,
> +	},
> +};
> +
> +static int nbl_dev_vsi_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
> +{
> +	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_vsi *vsi = NULL;
> +	int i;
> +
> +	net_dev->vsi_ctrl.queue_num = 0;
> +	net_dev->vsi_ctrl.queue_free_offset = 0;
> +
> +	/* Build all vsi, and alloc vsi_id for each of them */
> +	for (i = 0; i < NBL_VSI_MAX; i++) {
> +		if ((param->caps.is_vf && !vsi_tbl[i].vf_support) ||
> +		    (!param->caps.is_nic && vsi_tbl[i].only_nic_support))
> +			continue;
> +
> +		vsi = devm_kzalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), sizeof(*vsi), GFP_KERNEL);
> +		if (!vsi)
> +			goto malloc_vsi_fail;
> +
> +		vsi->ops = &vsi_tbl[i].vsi_ops;
> +		vsi->vsi_id = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0, i);
> +		vsi->index = i;
> +		vsi->in_kernel = vsi_tbl[i].in_kernel;
> +		vsi->use_independ_irq = vsi_tbl[i].use_independ_irq;
> +		vsi->static_queue = vsi_tbl[i].static_queue;
> +		net_dev->vsi_ctrl.vsi_list[i] = vsi;
> +	}
> +
> +	return 0;
> +
> +malloc_vsi_fail:
> +	while (--i + 1) {
> +		devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
> +		net_dev->vsi_ctrl.vsi_list[i] = NULL;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +static void nbl_dev_vsi_destroy(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	int i;
> +
> +	for (i = 0; i < NBL_VSI_MAX; i++)
> +		if (net_dev->vsi_ctrl.vsi_list[i]) {
> +			devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
> +			net_dev->vsi_ctrl.vsi_list[i] = NULL;
> +		}
> +}
> +
> +struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt, u8 vsi_index)
> +{
> +	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct nbl_dev_vsi *vsi = NULL;
> +	int i = 0;
> +
> +	for (i = 0; i < NBL_VSI_MAX; i++) {
> +		vsi = net_dev->vsi_ctrl.vsi_list[i];
> +		if (vsi && vsi->index == vsi_index)
> +			return vsi;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int nbl_dev_chan_get_st_name_req(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> +	struct nbl_chan_send_info chan_send = {0};
> +
> +	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
> +		      NBL_CHAN_MSG_GET_ST_NAME, NULL, 0,
> +		      st_dev->real_st_name, sizeof(st_dev->real_st_name), 1);
> +	return chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
> +}
> +
> +static void nbl_dev_chan_get_st_name_resp(void *priv, u16 src_id, u16 msg_id,
> +					  void *data, u32 data_len)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> +	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct device *dev = NBL_COMMON_TO_DEV(dev_mgt->common);
> +	struct nbl_chan_ack_info chan_ack;
> +	int ret;
> +
> +	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ST_NAME, msg_id,
> +		     0, st_dev->st_name, sizeof(st_dev->st_name));
> +	ret = chan_ops->send_ack(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_ack);
> +	if (ret)
> +		dev_err(dev, "channel send ack failed with ret: %d, msg_type: %d\n",
> +			ret, NBL_CHAN_MSG_GET_ST_NAME);
> +}
> +
> +static void nbl_dev_register_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> +
> +	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +					 NBL_CHAN_TYPE_MAILBOX))
> +		return;
> +
> +	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +			       NBL_CHAN_MSG_GET_ST_NAME,
> +			       nbl_dev_chan_get_st_name_resp, dev_mgt);
> +	st_dev->resp_msg_registered = true;
> +}
> +
> +static void nbl_dev_unregister_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> +
> +	if (!st_dev->resp_msg_registered)
> +		return;
> +
> +	chan_ops->unregister_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_MSG_GET_ST_NAME);
> +}
> +
> +static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
> +	{
> +		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
> +	},
> +};
> +
> +static void nbl_det_setup_net_dev_ops(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
> +{
> +	NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt) = &netdev_ops[param->product_type];
> +}
> +
> +static int nbl_dev_setup_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +{
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> +	struct nbl_dev_vsi *vsi;
> +	int i, ret = 0;
> +	u16 total_queue_num = 0, kernel_queue_num = 0, user_queue_num = 0;
> +	u16 dynamic_queue_max = 0, irq_queue_num = 0;
> +
> +	*net_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_net), GFP_KERNEL);
> +	if (!*net_dev)
> +		return -ENOMEM;
> +
> +	ret = nbl_dev_vsi_build(dev_mgt, param);
> +	if (ret)
> +		goto vsi_build_fail;
> +
> +	for (i = 0; i < NBL_VSI_MAX; i++) {
> +		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
> +
> +		if (!vsi)
> +			continue;
> +
> +		ret = vsi->ops->register_vsi(dev_mgt, param, vsi);
> +		if (ret) {
> +			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d register failed", vsi->index);
> +			goto vsi_register_fail;
> +		}
> +
> +		if (vsi->static_queue) {
> +			total_queue_num += vsi->queue_num;
> +		} else {
> +			if (dynamic_queue_max < vsi->queue_num)
> +				dynamic_queue_max = vsi->queue_num;
> +		}
> +
> +		if (vsi->use_independ_irq)
> +			irq_queue_num += vsi->queue_num;
> +
> +		if (vsi->in_kernel)
> +			kernel_queue_num += vsi->queue_num;
> +		else
> +			user_queue_num += vsi->queue_num;
> +	}
> +
> +	/* all vsi's dynamic only support enable use one at the same time. */
> +	total_queue_num += dynamic_queue_max;
> +
> +	/* the total queue set must before vsi stepup */
> +	(*net_dev)->total_queue_num = total_queue_num;
> +	(*net_dev)->kernel_queue_num = kernel_queue_num;
> +	(*net_dev)->user_queue_num = user_queue_num;
> +
> +	for (i = 0; i < NBL_VSI_MAX; i++) {
> +		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
> +
> +		if (!vsi)
> +			continue;
> +
> +		if (!vsi->in_kernel)
> +			continue;
> +
> +		ret = vsi->ops->setup(dev_mgt, param, vsi);
> +		if (ret) {
> +			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d setup failed", vsi->index);
> +			goto vsi_setup_fail;
> +		}
> +	}
> +
> +	nbl_dev_register_net_irq(dev_mgt, irq_queue_num);
> +
> +	nbl_det_setup_net_dev_ops(dev_mgt, param);
> +
> +	return 0;
> +
> +vsi_setup_fail:
> +vsi_register_fail:
> +	nbl_dev_vsi_destroy(dev_mgt);
> +vsi_build_fail:
> +	devm_kfree(dev, *net_dev);
> +	return ret;
> +}
> +
> +static void nbl_dev_remove_net_dev(struct nbl_adapter *adapter)
> +{
> +	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct nbl_dev_vsi *vsi;
> +	int i = 0;
> +
> +	if (!*net_dev)
> +		return;
> +
> +	for (i = 0; i < NBL_VSI_MAX; i++) {
> +		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
> +
> +		if (!vsi)
> +			continue;
> +
> +		vsi->ops->remove(dev_mgt, vsi);
> +	}
> +	nbl_dev_vsi_destroy(dev_mgt);
>  
> -};
> +	nbl_dev_unregister_net(dev_mgt);
>  
> -static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
> -				       struct nbl_init_param *param)
> +	devm_kfree(dev, *net_dev);
> +	*net_dev = NULL;
> +}
> +
> +static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
>  {
> -	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> +	int ret;
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	bool is_vf = param->caps.is_vf;
> +	struct nbl_dev_st_dev *st_dev;
>  
> -	if (is_vf) {
> -		netdev->netdev_ops = &netdev_ops_leonis_vf;
> +	/* unify restool's chardev for leonis/draco/rnic400. all pf create chardev */
> +	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
> +		return 0;
> +
> +	st_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_st_dev), GFP_KERNEL);
> +	if (!st_dev)
> +		return -ENOMEM;
> +
> +	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = st_dev;
> +	ret = serv_ops->setup_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					 nbl_get_st_table(), st_dev->st_name);
> +	if (ret) {
> +		dev_err(dev, "create resource char dev failed\n");
> +		goto alloc_chardev_failed;
> +	}
> +
> +	if (param->caps.has_ctrl) {
> +		nbl_dev_register_get_st_name_chan_msg(dev_mgt);
>  	} else {
> -		netdev->netdev_ops = &netdev_ops_leonis_pf;
> -		serv_ops->set_netdev_ops(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -					 &netdev_ops_leonis_pf, true);
> +		ret = nbl_dev_chan_get_st_name_req(dev_mgt);
> +		if (!ret)
> +			serv_ops->register_real_st_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +							st_dev->real_st_name);
> +		else
> +			dev_err(dev, "get real resource char dev failed\n");
>  	}
> +
>  	return 0;
> +alloc_chardev_failed:
> +	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
> +	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
> +	return -1;
>  }
>  
> -static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
> -				struct nbl_register_net_result *register_result)
> +static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter)
>  {
> -	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(NBL_DEV_MGT_TO_COMMON(dev_mgt));
> -#ifdef CONFIG_PCI_IOV
> -	struct resource *res;
> -#endif
> -	u16 pf_bdf;
> -	u64 pf_bar_start;
> -	u64 vf_bar_start, vf_bar_size;
> -	u16 total_vfs = 0, offset, stride;
> -	int pos;
> -	u32 val;
> -	struct nbl_register_net_param register_param = {0};
> -	int ret = 0;
> -
> -	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &val);
> -	pf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
> -	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0 + 4, &val);
> -	pf_bar_start |= ((u64)val << 32);
> -
> -	register_param.pf_bar_start = pf_bar_start;
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> -	if (pos) {
> -		pf_bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> -
> -		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_OFFSET, &offset);
> -		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_STRIDE, &stride);
> -		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF, &total_vfs);
> -
> -		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR, &val);
> -		vf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
> -		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR + 4, &val);
> -		vf_bar_start |= ((u64)val << 32);
> +	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
>  
> -#ifdef CONFIG_PCI_IOV
> -		res = &pdev->resource[PCI_IOV_RESOURCES];
> -		vf_bar_size = resource_size(res);
> -#else
> -		vf_bar_size = 0;
> -#endif
> -		if (total_vfs) {
> -			register_param.pf_bdf = pf_bdf;
> -			register_param.vf_bar_start = vf_bar_start;
> -			register_param.vf_bar_size = vf_bar_size;
> -			register_param.total_vfs = total_vfs;
> -			register_param.offset = offset;
> -			register_param.stride = stride;
> -		}
> -	}
> +	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
> +		return;
>  
> -	net_dev->total_vfs = total_vfs;
> +	nbl_dev_unregister_get_st_name_chan_msg(dev_mgt);
> +	serv_ops->remove_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), nbl_get_st_table());
>  
> -	ret = serv_ops->register_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -				     &register_param, register_result);
> +	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
> +	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
> +}
>  
> -	if (!register_result->tx_queue_num || !register_result->rx_queue_num)
> -		return -EIO;
> +static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
> +{
> +	*dev_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(struct nbl_dev_mgt), GFP_KERNEL);
> +	if (!*dev_mgt)
> +		return -ENOMEM;
>  
> -	return ret;
> +	NBL_DEV_MGT_TO_COMMON(*dev_mgt) = common;
> +	return 0;
>  }
>  
> -static void nbl_dev_unregister_net(struct nbl_dev_mgt *dev_mgt)
> +static void nbl_dev_remove_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
>  {
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
> -	int ret;
> -
> -	ret = serv_ops->unregister_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> -	if (ret)
> -		dev_err(dev, "unregister net failed\n");
> +	devm_kfree(NBL_COMMON_TO_DEV(common), *dev_mgt);
> +	*dev_mgt = NULL;
>  }
>  
> -static u16 nbl_dev_vsi_alloc_queue(struct nbl_dev_net *net_dev, u16 queue_num)
> +static void nbl_dev_remove_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl)
>  {
> -	struct nbl_dev_vsi_controller *vsi_ctrl = &net_dev->vsi_ctrl;
> -	u16 queue_offset = 0;
> +	devm_kfree(dev, *dev_ops_tbl);
> +	*dev_ops_tbl = NULL;
> +}
>  
> -	if (vsi_ctrl->queue_free_offset + queue_num > net_dev->total_queue_num)
> -		return -ENOSPC;
> +static int nbl_dev_setup_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl,
> +			     struct nbl_adapter *adapter)
> +{
> +	*dev_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_dev_ops_tbl), GFP_KERNEL);
> +	if (!*dev_ops_tbl)
> +		return -ENOMEM;
>  
> -	queue_offset = vsi_ctrl->queue_free_offset;
> -	vsi_ctrl->queue_free_offset += queue_num;
> +	NBL_DEV_OPS_TBL_TO_OPS(*dev_ops_tbl) = &dev_ops;
> +	NBL_DEV_OPS_TBL_TO_PRIV(*dev_ops_tbl) = adapter;
>  
> -	return queue_offset;
> +	return 0;
>  }
>  
> -static int nbl_dev_vsi_common_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				    struct nbl_dev_vsi *vsi)
> +int nbl_dev_init(void *p, struct nbl_init_param *param)
>  {
> +	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
> +	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> +	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
> +	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
> +	struct nbl_service_ops_tbl *serv_ops_tbl = NBL_ADAPTER_TO_SERV_OPS_TBL(adapter);
> +	struct nbl_channel_ops_tbl *chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
>  	int ret = 0;
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	struct nbl_vsi_param vsi_param = {0};
>  
> -	vsi->queue_offset = nbl_dev_vsi_alloc_queue(NBL_DEV_MGT_TO_NET_DEV(dev_mgt),
> -						    vsi->queue_num);
> -	vsi_param.index = vsi->index;
> -	vsi_param.vsi_id = vsi->vsi_id;
> -	vsi_param.queue_offset = vsi->queue_offset;
> -	vsi_param.queue_num = vsi->queue_num;
> +	ret = nbl_dev_setup_dev_mgt(common, dev_mgt);
> +	if (ret)
> +		goto setup_mgt_fail;
>  
> -	/* Tell serv & res layer the mapping from vsi to queue_id */
> -	ret = serv_ops->register_vsi_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &vsi_param);
> -	return ret;
> -}
> +	NBL_DEV_MGT_TO_SERV_OPS_TBL(*dev_mgt) = serv_ops_tbl;
> +	NBL_DEV_MGT_TO_CHAN_OPS_TBL(*dev_mgt) = chan_ops_tbl;
>  
> -static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
> -{
> -}
> +	ret = nbl_dev_setup_common_dev(adapter, param);
> +	if (ret)
> +		goto setup_common_dev_fail;
>  
> -static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				     void *vsi_data)
> -{
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> -	int ret = 0;
> +	if (param->caps.has_ctrl) {
> +		ret = nbl_dev_setup_ctrl_dev(adapter, param);
> +		if (ret)
> +			goto setup_ctrl_dev_fail;
> +	}
>  
> -	ret = nbl_dev_register_net(dev_mgt, &vsi->register_result);
> +	ret = nbl_dev_setup_net_dev(adapter, param);
>  	if (ret)
> -		return ret;
> +		goto setup_net_dev_fail;
>  
> -	vsi->queue_num = vsi->register_result.tx_queue_num;
> -	vsi->queue_size = vsi->register_result.queue_size;
> +	ret = nbl_dev_setup_st_dev(adapter, param);
> +	if (ret)
> +		goto setup_st_dev_fail;
>  
> -	nbl_debug(common, NBL_DEBUG_VSI, "Data vsi register, queue_num %d, queue_size %d",
> -		  vsi->queue_num, vsi->queue_size);
> +	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
> +	if (ret)
> +		goto setup_ops_fail;
>  
>  	return 0;
> +
> +setup_ops_fail:
> +	nbl_dev_remove_st_dev(adapter);
> +setup_st_dev_fail:
> +	nbl_dev_remove_net_dev(adapter);
> +setup_net_dev_fail:
> +	nbl_dev_remove_ctrl_dev(adapter);
> +setup_ctrl_dev_fail:
> +	nbl_dev_remove_common_dev(adapter);
> +setup_common_dev_fail:
> +	nbl_dev_remove_dev_mgt(common, dev_mgt);
> +setup_mgt_fail:
> +	return ret;
>  }
>  
> -static int nbl_dev_vsi_data_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				  void *vsi_data)
> +void nbl_dev_remove(void *p)
>  {
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
> +	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> +	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
> +	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
>  
> -	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
> -}
> +	nbl_dev_remove_ops(dev, dev_ops_tbl);
>  
> -static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> -{
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	nbl_dev_remove_st_dev(adapter);
> +	nbl_dev_remove_net_dev(adapter);
> +	nbl_dev_remove_ctrl_dev(adapter);
> +	nbl_dev_remove_common_dev(adapter);
>  
> -	nbl_dev_vsi_common_remove(dev_mgt, vsi);
> +	nbl_dev_remove_dev_mgt(common, dev_mgt);
>  }
>  
> -static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				     void *vsi_data)
> +static void nbl_dev_notify_dev_prepare_reset(struct nbl_dev_mgt *dev_mgt,
> +					     enum nbl_reset_event event)
>  {
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	int func_num = 0;
> +	unsigned long cur_func = 0;
> +	unsigned long next_func = 0;
> +	unsigned long *func_bitmap;
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_chan_send_info chan_send;
> +
> +	func_bitmap = devm_kcalloc(NBL_COMMON_TO_DEV(common), BITS_TO_LONGS(NBL_MAX_FUNC),
> +				   sizeof(long), GFP_KERNEL);
> +	if (!func_bitmap)
> +		return;
>  
> -	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -				     &vsi->queue_num, &vsi->queue_size);
> +	serv_ops->get_active_func_bitmaps(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), func_bitmap,
> +					  NBL_MAX_FUNC);
> +	memset(dev_mgt->ctrl_dev->task_info.reset_status, 0,
> +	       sizeof(dev_mgt->ctrl_dev->task_info.reset_status));
> +	/* clear ctrl_dev func_id, and do it last */
> +	clear_bit(NBL_COMMON_TO_MGT_PF(common), func_bitmap);
> +
> +	cur_func = NBL_COMMON_TO_MGT_PF(common);
> +	while (1) {
> +		next_func = find_next_bit(func_bitmap, NBL_MAX_FUNC, cur_func + 1);
> +		if (next_func >= NBL_MAX_FUNC)
> +			break;
>  
> -	nbl_debug(common, NBL_DEBUG_VSI, "Ctrl vsi register, queue_num %d, queue_size %d",
> -		  vsi->queue_num, vsi->queue_size);
> -	return 0;
> -}
> +		cur_func = next_func;
> +		dev_mgt->ctrl_dev->task_info.reset_status[cur_func] = NBL_RESET_SEND;
> +		NBL_CHAN_SEND(chan_send, cur_func, NBL_CHAN_MSG_NOTIFY_RESET_EVENT, &event,
> +			      sizeof(event), NULL, 0, 0);
> +		chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
> +		func_num++;
> +		if (func_num >= NBL_DEV_BATCH_RESET_FUNC_NUM) {
> +			usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
> +			func_num = 0;
> +		}
> +	}
>  
> -static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				  void *vsi_data)
> -{
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	if (func_num)
> +		usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
>  
> -	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
> -}
> +	/* ctrl dev need proc last, basecase reset task will close mailbox */
> +	dev_mgt->ctrl_dev->task_info.reset_status[NBL_COMMON_TO_MGT_PF(common)] = NBL_RESET_SEND;
> +	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
> +		      NULL, 0, NULL, 0, 0);
> +	chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
> +	usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
>  
> -static void nbl_dev_vsi_ctrl_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> -{
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	cur_func = NBL_COMMON_TO_MGT_PF(common);
> +	while (1) {
> +		if (dev_mgt->ctrl_dev->task_info.reset_status[cur_func] == NBL_RESET_SEND)
> +			nbl_info(common, NBL_DEBUG_MAIN, "func %ld reset failed", cur_func);
>  
> -	nbl_dev_vsi_common_remove(dev_mgt, vsi);
> +		next_func = find_next_bit(func_bitmap, NBL_MAX_FUNC, cur_func + 1);
> +		if (next_func >= NBL_MAX_FUNC)
> +			break;
> +
> +		cur_func = next_func;
> +	}
> +
> +	devm_kfree(NBL_COMMON_TO_DEV(common), func_bitmap);
>  }
>  
> -static int nbl_dev_vsi_user_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				     void *vsi_data)
> +static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt)
>  {
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_chan_param_notify_fw_reset_info fw_reset = {0};
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev_mgt->net_dev->netdev);
>  	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> +	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> +	struct nbl_chan_send_info chan_send;
>  
> -	serv_ops->get_user_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> -				      &vsi->queue_num, &vsi->queue_size,
> -				      NBL_COMMON_TO_VSI_ID(common));
> +	if (test_and_set_bit(NBL_FATAL_ERR, adapter->state)) {
> +		nbl_info(common, NBL_DEBUG_MAIN, "dev in fatal_err status already.");
> +		return;
> +	}
>  
> -	nbl_debug(common, NBL_DEBUG_VSI, "User vsi register, queue_num %d, queue_size %d",
> -		  vsi->queue_num, vsi->queue_size);
> -	return 0;
> -}
> +	nbl_dev_disable_abnormal_irq(dev_mgt);
> +	nbl_dev_ctrl_task_stop(dev_mgt);
> +	nbl_dev_notify_dev_prepare_reset(dev_mgt, NBL_HW_FATAL_ERR_EVENT);
>  
> -static int nbl_dev_vsi_user_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
> -				  void *vsi_data)
> -{
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	/* notify emp shutdown dev */
> +	fw_reset.type = NBL_FW_HIGH_TEMP_RESET;
> +	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
> +		      NBL_CHAN_MSG_ADMINQ_NOTIFY_FW_RESET, &fw_reset, sizeof(fw_reset), NULL, 0, 0);
> +	chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
>  
> -	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
> +	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
> +				  NBL_CHAN_TYPE_ADMINQ, true);
> +	serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
> +	nbl_info(common, NBL_DEBUG_MAIN, "dev in fatal_err status.");
>  }
>  
> -static void nbl_dev_vsi_user_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
> +/* ----------  Dev start process  ---------- */
> +static int nbl_dev_start_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
>  {
> -	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	int err = 0;
>  
> -	nbl_dev_vsi_common_remove(dev_mgt, vsi);
> -}
> +	err = nbl_dev_request_abnormal_irq(dev_mgt);
> +	if (err)
> +		goto abnormal_request_irq_err;
>  
> -static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
> -	[NBL_VSI_DATA] = {
> -		.vsi_ops = {
> -			.register_vsi = nbl_dev_vsi_data_register,
> -			.setup = nbl_dev_vsi_data_setup,
> -			.remove = nbl_dev_vsi_data_remove,
> -		},
> -		.vf_support = true,
> -		.only_nic_support = false,
> -		.in_kernel = true,
> -		.use_independ_irq = true,
> -		.static_queue = true,
> -	},
> -	[NBL_VSI_CTRL] = {
> -		.vsi_ops = {
> -			.register_vsi = nbl_dev_vsi_ctrl_register,
> -			.setup = nbl_dev_vsi_ctrl_setup,
> -			.remove = nbl_dev_vsi_ctrl_remove,
> -		},
> -		.vf_support = false,
> -		.only_nic_support = true,
> -		.in_kernel = true,
> -		.use_independ_irq = true,
> -		.static_queue = true,
> -	},
> -	[NBL_VSI_USER] = {
> -		.vsi_ops = {
> -			.register_vsi = nbl_dev_vsi_user_register,
> -			.setup = nbl_dev_vsi_user_setup,
> -			.remove = nbl_dev_vsi_user_remove,
> -		},
> -		.vf_support = false,
> -		.only_nic_support = true,
> -		.in_kernel = false,
> -		.use_independ_irq = false,
> -		.static_queue = false,
> -	},
> -};
> +	err = nbl_dev_enable_abnormal_irq(dev_mgt);
> +	if (err)
> +		goto enable_abnormal_irq_err;
>  
> -static int nbl_dev_vsi_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
> -{
> -	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> -	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> -	struct nbl_dev_vsi *vsi = NULL;
> -	int i;
> +	err = nbl_dev_request_adminq_irq(dev_mgt, &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
> +	if (err)
> +		goto request_adminq_irq_err;
>  
> -	net_dev->vsi_ctrl.queue_num = 0;
> -	net_dev->vsi_ctrl.queue_free_offset = 0;
> +	err = nbl_dev_enable_adminq_irq(dev_mgt);
> +	if (err)
> +		goto enable_adminq_irq_err;
>  
> -	/* Build all vsi, and alloc vsi_id for each of them */
> -	for (i = 0; i < NBL_VSI_MAX; i++) {
> -		if ((param->caps.is_vf && !vsi_tbl[i].vf_support) ||
> -		    (!param->caps.is_nic && vsi_tbl[i].only_nic_support))
> -			continue;
> +	nbl_dev_get_port_attributes(dev_mgt);
> +	nbl_dev_init_port(dev_mgt);
> +	nbl_dev_enable_port(dev_mgt, true);
> +	nbl_dev_ctrl_task_start(dev_mgt);
>  
> -		vsi = devm_kzalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), sizeof(*vsi), GFP_KERNEL);
> -		if (!vsi)
> -			goto malloc_vsi_fail;
> +	return 0;
>  
> -		vsi->ops = &vsi_tbl[i].vsi_ops;
> -		vsi->vsi_id = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0, i);
> -		vsi->index = i;
> -		vsi->in_kernel = vsi_tbl[i].in_kernel;
> -		vsi->use_independ_irq = vsi_tbl[i].use_independ_irq;
> -		vsi->static_queue = vsi_tbl[i].static_queue;
> -		net_dev->vsi_ctrl.vsi_list[i] = vsi;
> -	}
> +enable_adminq_irq_err:
> +	nbl_dev_free_adminq_irq(dev_mgt, &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
> +request_adminq_irq_err:
> +	nbl_dev_disable_abnormal_irq(dev_mgt);
> +enable_abnormal_irq_err:
> +	nbl_dev_free_abnormal_irq(dev_mgt);
> +abnormal_request_irq_err:
> +	return err;
> +}
>  
> -	return 0;
> +static void nbl_dev_stop_ctrl_dev(struct nbl_adapter *adapter)
> +{
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
>  
> -malloc_vsi_fail:
> -	while (--i + 1) {
> -		devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
> -		net_dev->vsi_ctrl.vsi_list[i] = NULL;
> -	}
> +	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
> +		return;
>  
> -	return -ENOMEM;
> +	nbl_dev_ctrl_task_stop(dev_mgt);
> +	nbl_dev_enable_port(dev_mgt, false);
> +	nbl_dev_disable_adminq_irq(dev_mgt);
> +	nbl_dev_free_adminq_irq(dev_mgt, &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
> +	nbl_dev_disable_abnormal_irq(dev_mgt);
> +	nbl_dev_free_abnormal_irq(dev_mgt);
>  }
>  
> -static void nbl_dev_vsi_destroy(struct nbl_dev_mgt *dev_mgt)
> +static void nbl_dev_chan_notify_link_state_resp(void *priv, u16 src_id, u16 msg_id,
> +						void *data, u32 data_len)
>  {
> -	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> -	int i;
> +	struct net_device *netdev = (struct net_device *)priv;
> +	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_chan_param_notify_link_state *link_info;
>  
> -	for (i = 0; i < NBL_VSI_MAX; i++)
> -		if (net_dev->vsi_ctrl.vsi_list[i]) {
> -			devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
> -			net_dev->vsi_ctrl.vsi_list[i] = NULL;
> -		}
> +	link_info = (struct nbl_chan_param_notify_link_state *)data;
> +
> +	serv_ops->set_netdev_carrier_state(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +					   netdev, link_info->link_state);
>  }
>  
> -struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt, u8 vsi_index)
> +static void nbl_dev_register_link_state_chan_msg(struct nbl_dev_mgt *dev_mgt,
> +						 struct net_device *netdev)
>  {
> -	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> -	struct nbl_dev_vsi *vsi = NULL;
> -	int i = 0;
> +	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
>  
> -	for (i = 0; i < NBL_VSI_MAX; i++) {
> -		vsi = net_dev->vsi_ctrl.vsi_list[i];
> -		if (vsi && vsi->index == vsi_index)
> -			return vsi;
> -	}
> +	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +					 NBL_CHAN_TYPE_MAILBOX))
> +		return;
>  
> -	return NULL;
> +	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +			       NBL_CHAN_MSG_NOTIFY_LINK_STATE,
> +			       nbl_dev_chan_notify_link_state_resp, netdev);
>  }
>  
> -static int nbl_dev_chan_get_st_name_req(struct nbl_dev_mgt *dev_mgt)
> +static void nbl_dev_chan_notify_reset_event_resp(void *priv, u16 src_id, u16 msg_id,
> +						 void *data, u32 data_len)
>  {
> -	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> -	struct nbl_chan_send_info chan_send = {0};
> +	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> +	enum nbl_reset_event event = *(enum nbl_reset_event *)data;
>  
> -	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
> -		      NBL_CHAN_MSG_GET_ST_NAME, NULL, 0,
> -		      st_dev->real_st_name, sizeof(st_dev->real_st_name), 1);
> -	return chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
> +	dev_mgt->common_dev->reset_task.event = event;
> +	nbl_common_queue_work(&dev_mgt->common_dev->reset_task.task, false);
>  }
>  
> -static void nbl_dev_chan_get_st_name_resp(void *priv, u16 src_id, u16 msg_id,
> -					  void *data, u32 data_len)
> +static void nbl_dev_chan_ack_reset_event_resp(void *priv, u16 src_id, u16 msg_id,
> +					      void *data, u32 data_len)
>  {
>  	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
> -	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct device *dev = NBL_COMMON_TO_DEV(dev_mgt->common);
> -	struct nbl_chan_ack_info chan_ack;
> -	int ret;
>  
> -	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ST_NAME, msg_id,
> -		     0, st_dev->st_name, sizeof(st_dev->st_name));
> -	ret = chan_ops->send_ack(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_ack);
> -	if (ret)
> -		dev_err(dev, "channel send ack failed with ret: %d, msg_type: %d\n",
> -			ret, NBL_CHAN_MSG_GET_ST_NAME);
> +	WRITE_ONCE(dev_mgt->ctrl_dev->task_info.reset_status[src_id], NBL_RESET_DONE);
>  }
>  
> -static void nbl_dev_register_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +static void nbl_dev_register_reset_event_chan_msg(struct nbl_dev_mgt *dev_mgt)
>  {
>  	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
>  
>  	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
>  					 NBL_CHAN_TYPE_MAILBOX))
>  		return;
>  
>  	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> -			       NBL_CHAN_MSG_GET_ST_NAME,
> -			       nbl_dev_chan_get_st_name_resp, dev_mgt);
> -	st_dev->resp_msg_registered = true;
> +			       NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
> +			       nbl_dev_chan_notify_reset_event_resp, dev_mgt);
> +	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
> +			       NBL_CHAN_MSG_ACK_RESET_EVENT,
> +			       nbl_dev_chan_ack_reset_event_resp, dev_mgt);
>  }
>  
> -static void nbl_dev_unregister_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
> +int nbl_dev_setup_vf_config(void *p, int num_vfs)
>  {
> -	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
> -	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
> -
> -	if (!st_dev->resp_msg_registered)
> -		return;
> +	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  
> -	chan_ops->unregister_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_MSG_GET_ST_NAME);
> +	return serv_ops->setup_vf_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), num_vfs, false);
>  }
>  
> -static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
> -	{
> -		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
> -	},
> -};
> +void nbl_dev_register_dev_name(void *p)
> +{
> +	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
>  
> -static void nbl_det_setup_net_dev_ops(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
> +	/* get pf_name then register it to AF */
> +	serv_ops->register_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +				    common->vsi_id, net_dev->netdev->name);
> +}
> +
> +void nbl_dev_get_dev_name(void *p, char *dev_name)
>  {
> -	NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt) = &netdev_ops[param->product_type];
> +	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
> +	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
> +
> +	serv_ops->get_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), common->vsi_id, dev_name);
>  }
>  
> -static int nbl_dev_setup_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
> +void nbl_dev_remove_vf_config(void *p)
>  {
> +	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
>  	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> -	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> -	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
> -	struct nbl_dev_vsi *vsi;
> -	int i, ret = 0;
> -	u16 total_queue_num = 0, kernel_queue_num = 0, user_queue_num = 0;
> -	u16 dynamic_queue_max = 0, irq_queue_num = 0;
> +	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
>  
> -	*net_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_net), GFP_KERNEL);
> -	if (!*net_dev)
> -		return -ENOMEM;
> +	return serv_ops->remove_vf_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
> +}
>  
> -	ret = nbl_dev_vsi_build(dev_mgt, param);
> -	if (ret)
> -		goto vsi_build_fail;
> +static int nbl_dev_start_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)

> +	ret = register_netdev(netdev);
> +	if (ret) {
> +		dev_err(dev, "Register netdev failed\n");
> +		goto register_netdev_fail;
>  	}

By the time register_netdev() has returned, your device is live,
potentially sending and receiving packets, especially if things like
NFS root are used.

> -	nbl_dev_register_net_irq(dev_mgt, irq_queue_num);
> +	if (!param->caps.is_vf) {
> +		if (net_dev->total_vfs) {
> +			ret = serv_ops->setup_vf_resource(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
> +							  net_dev->total_vfs);
> +			if (ret)
> +				goto setup_vf_res_fail;
> +		}
> +		nbl_netdev_add_st_sysfs(netdev, net_dev);

So you need to be very careful of any initialisation which happens
after register_netdev(). Does it happen too late?

This is a bug i keep pointing out for new drivers. The fact you
repeated it suggests you have not been monitoring the netdev list and
learning from reviews other new drivers get. So i expect you are going
to be doing a lot of rewriting :-(

	Andrew

