Return-Path: <netdev+bounces-247342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE0CF808E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717413065E21
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95683254BC;
	Tue,  6 Jan 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O49LYbk5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B6319858;
	Tue,  6 Jan 2026 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698644; cv=none; b=M7PXecOW6J6SaYqsMY+fYb3E+41vA68TeDCiZkQkADLV84jDAoyS4N9s4vNF+sQm974D0mUy+iSGFRsIqSzsPNROq5ow2/36flR8l+kx3Vsd6oTTTEJ8j1OCVPYo5Rdtb9Lgn5t0GoPhaqtO6mVoLsg26pDbdm0B7jtipsD+flU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698644; c=relaxed/simple;
	bh=rFDJdW7RlUGxZ8mbpqcEbbOtuMy6ucJx5AeKD2kkwDQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=rXbxhxqAcgz3KTlO7yhWbV5VOTAa4f10vCxNALJvuN2tOjhjvDNTq1ibKX7BmwW5BTeaWG6Ehmv4CwTib4dYonRp35v2f02S+kckNE3A0Qx5Iioh3BqgO050YdFCgdIE26qGePOEkbB0xhBmGMMPiciOiIQ2LBaO3UdFLUWLD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O49LYbk5; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767698633; h=Message-ID:Subject:Date:From:To;
	bh=qpJOiwyTfx3WIFfeSNOkU0yY/KPGHRtRT7EydZH4SVY=;
	b=O49LYbk5jKojRaoVNqLcwzbv05pqa0rB2HmU/UjWuXMzf/NCzkpprzjKrs6tQ/dhvGAXUmsIE2idk6d5O2tS3lxD37NJ0acTZVX5PSnAY67zqlz3AlXIlEdfLdEIQz36k9CslWEU+kWh96nQoZsVuqEOoLohglGECkW6lK7Eh1g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WwVZ7bt_1767698632 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 19:23:52 +0800
Message-ID: <1767698557.9158366-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 2/2] virtio-net: Implement ndo_write_rx_mode callback
Date: Tue, 6 Jan 2026 19:22:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 I Viswanath <viswanathiyyappan@gmail.com>,
 edumazet@google.com,
 andrew+netdev@lunn.ch,
 horms@kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com,
 mst@redhat.com,
 eperezma@redhat.com,
 jasowang@redhat.com
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com>
 <20260102180530.1559514-3-viswanathiyyappan@gmail.com>
In-Reply-To: <20260102180530.1559514-3-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


If this is a common requirement, it would be better to provide more examples of
driver modifications.

Thanks.


On Fri,  2 Jan 2026 23:35:30 +0530, I Viswanath <viswanathiyyappan@gmail.com> wrote:
> Implement ndo_write_rx_mode callback for virtio-net
>
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 +++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..83d543bf6ae2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -460,9 +460,6 @@ struct virtnet_info {
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>
> -	/* Work struct for setting rx mode */
> -	struct work_struct rx_mode_work;
> -
>  	/* OK to queue work setting RX mode? */
>  	bool rx_mode_work_enabled;
>
> @@ -3866,33 +3863,31 @@ static int virtnet_close(struct net_device *dev)
>  	return 0;
>  }
>
> -static void virtnet_rx_mode_work(struct work_struct *work)
> +static void virtnet_write_rx_mode(struct net_device *dev)
>  {
> -	struct virtnet_info *vi =
> -		container_of(work, struct virtnet_info, rx_mode_work);
> +	struct virtnet_info *vi = netdev_priv(dev);
>  	u8 *promisc_allmulti  __free(kfree) = NULL;
> -	struct net_device *dev = vi->dev;
>  	struct scatterlist sg[2];
>  	struct virtio_net_ctrl_mac *mac_data;
> -	struct netdev_hw_addr *ha;
> +	char *ha_addr;
>  	int uc_count;
>  	int mc_count;
>  	void *buf;
> +	int idx;
>  	int i;
>
>  	/* We can't dynamically set ndo_set_rx_mode, so return gracefully */
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>
> -	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
> +	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
>  	if (!promisc_allmulti) {
>  		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
>  		return;
>  	}
>
> -	rtnl_lock();
> -
> -	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
> +	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
> +						  NETIF_RX_MODE_CFG_PROMISC);
>  	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
> @@ -3900,7 +3895,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
>  			 *promisc_allmulti ? "en" : "dis");
>
> -	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
> +	*promisc_allmulti = netif_rx_mode_get_cfg(dev,
> +						  NETIF_RX_MODE_CFG_ALLMULTI);
>  	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
> @@ -3908,27 +3904,22 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
>  			 *promisc_allmulti ? "en" : "dis");
>
> -	netif_addr_lock_bh(dev);
> -
> -	uc_count = netdev_uc_count(dev);
> -	mc_count = netdev_mc_count(dev);
> +	uc_count = netif_rx_mode_get_uc_count(dev);
> +	mc_count = netif_rx_mode_get_mc_count(dev);
>  	/* MAC filter - use one buffer for both lists */
>  	buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
>  		      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
>  	mac_data = buf;
> -	if (!buf) {
> -		netif_addr_unlock_bh(dev);
> -		rtnl_unlock();
> +	if (!buf)
>  		return;
> -	}
>
>  	sg_init_table(sg, 2);
>
>  	/* Store the unicast list and count in the front of the buffer */
>  	mac_data->entries = cpu_to_virtio32(vi->vdev, uc_count);
>  	i = 0;
> -	netdev_for_each_uc_addr(ha, dev)
> -		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> +	netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx)
> +		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
>
>  	sg_set_buf(&sg[0], mac_data,
>  		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
> @@ -3938,10 +3929,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>
>  	mac_data->entries = cpu_to_virtio32(vi->vdev, mc_count);
>  	i = 0;
> -	netdev_for_each_mc_addr(ha, dev)
> -		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
> -
> -	netif_addr_unlock_bh(dev);
> +	netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx)
> +		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
>
>  	sg_set_buf(&sg[1], mac_data,
>  		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
> @@ -3950,17 +3939,15 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>  		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
>
> -	rtnl_unlock();
> -
>  	kfree(buf);
>  }
>
>  static void virtnet_set_rx_mode(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	char cfg_disabled = !vi->rx_mode_work_enabled;
>
> -	if (vi->rx_mode_work_enabled)
> -		schedule_work(&vi->rx_mode_work);
> +	netif_rx_mode_set_flag(dev, NETIF_RX_MODE_SET_SKIP, cfg_disabled);
>  }
>
>  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
> @@ -5776,7 +5763,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device */
>  	flush_work(&vi->config_work);
>  	disable_rx_mode_work(vi);
> -	flush_work(&vi->rx_mode_work);
> +	netif_flush_rx_mode_work(vi->dev);
>
>  	if (netif_running(vi->dev)) {
>  		rtnl_lock();
> @@ -6279,6 +6266,7 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_validate_addr   = eth_validate_addr,
>  	.ndo_set_mac_address = virtnet_set_mac_address,
>  	.ndo_set_rx_mode     = virtnet_set_rx_mode,
> +	.ndo_write_rx_mode   = virtnet_write_rx_mode,
>  	.ndo_get_stats64     = virtnet_stats,
>  	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
> @@ -6900,7 +6888,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> -	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	spin_lock_init(&vi->refill_lock);
>
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
> @@ -7205,7 +7192,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vi->config_work);
>  	disable_rx_mode_work(vi);
> -	flush_work(&vi->rx_mode_work);
> +	netif_flush_rx_mode_work(vi->dev);
>
>  	virtnet_free_irq_moder(vi);
>
> --
> 2.47.3
>

