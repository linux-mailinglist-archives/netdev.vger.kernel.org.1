Return-Path: <netdev+bounces-112659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB393A764
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9666AB20CF8
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECF13C8EE;
	Tue, 23 Jul 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GNM9M6IB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3C14286;
	Tue, 23 Jul 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760509; cv=none; b=MlTSiuN5SXiEMn3EqjtH3RjSCOEZK6ss+aWDbkrr/mMn/xq+eWHjBgKbgAHt0rlL04+34JmOnuPAHhHTyHnxcxwN1bu3uwNgby7r4c5axNAoiFIaZR/rBllUg0kX05ac8nh5m8CDj+XRAkUqiZb8BLE/P6r1PavpxRL73cy5OsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760509; c=relaxed/simple;
	bh=F+qGohd8YEEcowAlHHkXd1t/juxZhhjRxJYbb81wGQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF+AnrL+pBUd9BawyOmLyuGoNVFANG+T34sr5LWxPPP+tESRCSdmar8gbCIR/I94gRrIUgS93rq4YfGzSXtdpwXIQggTYAmLmQTGhK5Bemd78/BLSVaxO2rJGY5Vc5HPf2K8jrYTkhwz562PhTru+J+Ui/vu+lDnvGn0VnxOSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GNM9M6IB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V2H+VHX+vfAZGlPz7CUKL+rIgEnQgT0PSFIxQrJK6eg=; b=GNM9M6IBlT92e05ToKUxP1Uxtp
	mFoZqDeKszma18jowUE0HYJZwW2pKvLYgw7N95LY7zk0z+6Z9MDu/z+QOq7zS4XDE2faKbb3XJNzt
	RE2gAG8awfgI2rvide+Bok2XpsoWc5mns+vJdYj+cjJzHY00PnT6oXiKCCyt39o0gUog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWKYf-0035KV-Nk; Tue, 23 Jul 2024 20:48:21 +0200
Date: Tue, 23 Jul 2024 20:48:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v5 1/3] vdpa: support set mac address from vdpa tool
Message-ID: <8ff8f8d8-1061-42a2-b238-82f685639115@lunn.ch>
References: <20240723054047.1059994-1-lulu@redhat.com>
 <20240723054047.1059994-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723054047.1059994-2-lulu@redhat.com>

On Tue, Jul 23, 2024 at 01:39:20PM +0800, Cindy Lu wrote:
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> new MAC address from the vdpa tool and then set it to the device.
> 
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> 
> Here is example:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
> 
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa.c       | 84 +++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  9 +++++
>  include/uapi/linux/vdpa.h |  1 +
>  3 files changed, 94 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8d391947eb8d..07d61ee62839 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1361,6 +1361,85 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
>  	return err;
>  }
>  
> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +					struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	const u8 *macaddr;
> +	struct vdpa_mgmt_dev *mdev = vdev->mdev;
> +	struct nlattr **nl_attrs = info->attrs;
> +	int err = -EINVAL;
> +
> +	if (!vdev->mdev)
> +		return -EINVAL;
> +
> +	down_write(&vdev->cf_lock);
> +	if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC)) &&
> +	    nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +
> +		if (is_valid_ether_addr(macaddr)) {
> +			memcpy(set_config.net.mac, macaddr, ETH_ALEN);
> +			if (mdev->ops->dev_set_attr) {
> +				err = mdev->ops->dev_set_attr(mdev, vdev,
> +							      &set_config);
> +			} else {
> +				NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +						       "device not supported");
> +			}
> +		} else {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "Invalid MAC address");
> +		}
> +	}
> +	up_write(&vdev->cf_lock);
> +	return err;
> +}
> +static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
> +					 struct genl_info *info)
> +{
> +	const char *name;
> +	int err = 0;
> +	struct device *dev;
> +	struct vdpa_device *vdev;
> +	u64 classes;
> +
> +	if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +		return -EINVAL;
> +
> +	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +
> +	down_write(&vdpa_dev_lock);
> +	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
> +	if (!dev) {
> +		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +		err = -ENODEV;
> +		goto dev_err;
> +	}
> +	vdev = container_of(dev, struct vdpa_device, dev);
> +	if (!vdev->mdev) {
> +		NL_SET_ERR_MSG_MOD(
> +			info->extack,
> +			"Fail to find the specified management device");
> +		err = -EINVAL;
> +		goto mdev_err;
> +	}
> +	classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
> +	if (classes & BIT_ULL(VIRTIO_ID_NET)) {
> +		err = vdpa_dev_net_device_attr_set(vdev, info);
> +	} else {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
> +				       name);
> +	}
> +
> +mdev_err:
> +	put_device(dev);
> +dev_err:
> +	up_write(&vdpa_dev_lock);
> +	return err;
> +}
> +
>  static int vdpa_dev_config_dump(struct device *dev, void *data)
>  {
>  	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> @@ -1497,6 +1576,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
>  		.doit = vdpa_nl_cmd_dev_stats_get_doit,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> +	{
> +		.cmd = VDPA_CMD_DEV_ATTR_SET,
> +		.doit = vdpa_nl_cmd_dev_attr_set_doit,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>  };
>  
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 7977ca03ac7a..3511156c10db 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>   *	     @dev: vdpa device to remove
>   *	     Driver need to remove the specified device by calling
>   *	     _vdpa_unregister_device().
> +  * @dev_set_attr: change a vdpa device's attr after it was create
> + *	     @mdev: parent device to use for device

The indentation looks a bit odd here.

    Andrew

---
pw-bot: cr

