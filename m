Return-Path: <netdev+bounces-293805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGksHimkHWr5cgkAu9opvQ
	(envelope-from <netdev+bounces-293805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E3621A0E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07E6B30225D0
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B65F3DB62E;
	Mon,  1 Jun 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy54UBgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B63DA7F8
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327086; cv=none; b=bltSJOPjTKH6mcykGbJE+47EzbJhWreaaqV2AEJtE3FeWNeJ+vfwMt/h2iPwyMQ3QhMlB1EIpPVbCHupGIiziBWOb4ttbBYPuovB2BnPv+7kudog7amni7voylVqtxTATeDpfp3fEh4+xslQC+vkcy4VF8c320XyM3wYSw0WPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327086; c=relaxed/simple;
	bh=8FFo7QVhD9jTMfiajr2YHuBvqBorAyV2RcTNZD/fVF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdBTgAdFwENti39GxavfU0yA5VnI+JLDtC0pT2kBbPWi7AoWV/wjufBpoV8NwAN1jhXvyQ7y9vJehfrM5rSoM1eLvca+H4JVg/aCHYELuSSK2l1aQ6HhsRLQD0l1FstQP2qJf4txuJf9vEPdaFSO0UVF6dNUcS08vtAy8TH4GJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sy54UBgo; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso10297645ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327078; x=1780931878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEFV9Atlreiumvbd96uJc9jcp+WvYr8pgeQcn+NCl6c=;
        b=sy54UBgo82Ssvt7qtGI4SGWc4aa0qpSgROUzubh7Ac2qBQJfVP037SLDkYAbnN7PFQ
         0e15WGblDfbdFgTurseqhETKhkPyO2rtdXzw5CPVnjFPd+uohxqEGLNveIdIsESd1jr8
         BraBIVeKH/A6t4x6UzkyifSJZNDAzdgOrTQsQbNZ/1KKXk8AaP3VGNgLSWQnwet5AXEP
         V1ikQjuZDD04sZ6NjsiVDnFiM3VCxm4RHogSXHzsQ+/5Wghaa8o8brsqfWUvd8aq9KkB
         vJ5w1xYvCmgGUimkxoXRAgl1f85jBdrgEp9MxdMD8pWlprkSqhx86V7GC8iPSNToUmOU
         t8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327078; x=1780931878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEFV9Atlreiumvbd96uJc9jcp+WvYr8pgeQcn+NCl6c=;
        b=RZ/qn9oQXtrBetfXm5tWWBgXtuF+W1kBQxUfYZeiZnc6s+FNry4PcyvgIvpp0VmTej
         qzTGve9sk03XWmF5eFuTCqGJSL8opcLarq0GroRGwBlUuxuOzD9jHOa6t/QOaIDGc/5N
         /+pRaiTazEdpMrkr8EnkUrdtWdf/6h7zw7/2zTLCQjPqmEW6B59HE/DhIVCZU2tcB3/B
         nMKOtQ8xswNAcRcJNjpYQPUV2wKwREuBNdUIBDVS9TOqvLLpRpS+f+MIninxHi/V5csv
         /9BexuRKPU2WlXUs0tPYzw7BOc593nvxavQ4XHmKczyBzrWWnmONbrK2S/lNWtntGYAP
         421g==
X-Forwarded-Encrypted: i=1; AFNElJ9+BI5iMP7NNQPOwGO5HWai/6XzapMkQlA/AiO5UNjDVTinUeFa7VzdKg34JcXACBAeSZFfwDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbZOxbwt8vKFAAPbYAji1dGlAWGf1bHNN6jU9eCNamoX2JXY8
	xv2jJUsYo7gohUwABVPaLOpJUomRyJoM7GMQH+t/TFKLNqPuUHFkNKLZ
X-Gm-Gg: Acq92OHtC16SMO8lyv23OOdISgCMO0wieQkFPtwvrjWScSAQ0CbtFGObQUOOSfoJEOi
	d3Xsyhv/dNobq37CFibg4QI6yhSFPNcN+5KKBmWhg7dVVcK7LYZ2zlAF2VdzPRREy3Ma7gvO4gm
	amNHAyH7vThRmZqbTQdJa0VXLswhk9DCdDBnUEKELTnc+fJJGHVQnKrxfjHnzEg4g6/EnaLXftw
	Vyc9LHf2KjkJ+Cg649ExhM9XJV/xEzAe8eTGej6FnvIiywGgf/gJIf5JCGFTSTr9ogNC+ghgLIJ
	EvSB/9Ufs97BgU8S1xTrKHA49kZ90hAvc57/lAFBo85gpDyrDx33xxowejCGuTcQhACb7MWbbr5
	goHGhIp74X0MS6CgGPXMdtuUw5mHqCEvoosxrLkJ4km3Gw8DQtCD0H2YJc2M7/RU3WoI3mu3fXp
	dAa4+XNKUrEeUt2oSv8nSxtR8HynwkwsExD44MfA==
X-Received: by 2002:a17:903:1905:b0:2bf:1486:e6bc with SMTP id d9443c01a7336-2bf36865b6fmr138516175ad.29.1780327077757;
        Mon, 01 Jun 2026 08:17:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c2381bsm110037665ad.62.2026.06.01.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:17:57 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:17:56 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, joshwash@google.com, tariqt@nvidia.com, haiyangz@microsoft.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, willemb@google.com, 
	ernis@linux.microsoft.com, kory.maincent@bootlin.com, danieller@nvidia.com, 
	idosch@nvidia.com
Subject: Re: [PATCH net-next 13/14] net: ethtool: optionally skip rtnl_lock
 on IOCTL path
Message-ID: <ah2hvWMz70qAYmsG@devvm7509.cco0.facebook.com>
References: <20260528231637.251822-1-kuba@kernel.org>
 <20260528231637.251822-14-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528231637.251822-14-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293805-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 864E3621A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/28, Jakub Kicinski wrote:
> Convert the IOCTL path similarly to how we converted Netlink.
> The device lookup gets a little hairy. We could take rtnl_lock
> unconditionally and drop it before calling the driver (this would
> avoid the reference + liveness check). But I think being able
> to make progress even if rtnl is dead-locked is quite useful.
> 
> First extra concern is handling features. List all the cmds which
> modify features and always take rtnl_lock. We could fold this list
> into ethtool_ioctl_needs_rtnl() but seems cleaner to keep
> ethtool_ioctl_needs_rtnl() driver-related. If a driver changed
> features and we were not holding rtnl_lock - warn about it.
> It can only happen on buggy ops locked drivers (buggy because
> they should have set appropriate "I need rtnl for op X" bit).
> 
> Second wrinkle is the PHY ID hack which drops the locks while
> sleeping. Convert its static "busy" variable which used to
> be protected by rtnl_lock to a field in struct ethtool_netdev_state.
> This feature is about identifying an adapter or a port within
> a system, so being able to blink multiple LEDs at the same
> time is likely not very useful in practice. But it's the simplest
> fix, we can add a mutex if someone thinks a system should only
> be ID'ing one port at a time.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/ethtool.h |  2 +
>  net/ethtool/ioctl.c     | 98 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 74 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 4f15221119e2..35ee57a0e5fa 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1375,6 +1375,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>   *			within RTNL.
>   * @rss_indir_user_size: Number of user provided entries for the default
>   *			 (context 0) indirection table.
> + * @phys_id_busy:	Loop blinking the device LED is running.
>   * @wol_enabled:	Wake-on-LAN is enabled
>   * @module_fw_flash_in_progress: Module firmware flashing is in progress.
>   */
> @@ -1382,6 +1383,7 @@ struct ethtool_netdev_state {
>  	struct xarray		rss_ctx;
>  	struct mutex		rss_lock;
>  	u32			rss_indir_user_size;
> +	unsigned		phys_id_busy:1;
>  	unsigned		wol_enabled:1;
>  	unsigned		module_fw_flash_in_progress:1;
>  };
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 6c3a7e8644ae..aea087d62fe9 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -543,7 +543,7 @@ static int ethtool_get_link_ksettings(struct net_device *dev,
>  	int err = 0;
>  	struct ethtool_link_ksettings link_ksettings;
>  
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);
>  	if (!dev->ethtool_ops->get_link_ksettings)
>  		return -EOPNOTSUPP;
>  
> @@ -600,7 +600,7 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
>  	struct ethtool_link_ksettings link_ksettings = {};
>  	int err;
>  
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);
>  
>  	if (!dev->ethtool_ops->set_link_ksettings)
>  		return -EOPNOTSUPP;
> @@ -674,7 +674,7 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
>  	struct ethtool_cmd cmd;
>  	int err;
>  
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);
>  	if (!dev->ethtool_ops->get_link_ksettings)
>  		return -EOPNOTSUPP;
>  
> @@ -710,7 +710,7 @@ static int ethtool_set_settings(struct net_device *dev, void __user *useraddr)
>  	struct ethtool_cmd cmd;
>  	int ret;
>  
> -	ASSERT_RTNL();
> +	netdev_ops_assert_locked(dev);
>  
>  	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
>  		return -EFAULT;
> @@ -2451,10 +2451,10 @@ void ethtool_puts(u8 **data, const char *str)
>  }
>  EXPORT_SYMBOL(ethtool_puts);
>  
> -static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
> +static int ethtool_phys_id(struct net_device *dev, void __user *useraddr,
> +			   bool has_rtnl_lock)
>  {
>  	struct ethtool_value id;
> -	static bool busy;
>  	const struct ethtool_ops *ops = dev->ethtool_ops;
>  	netdevice_tracker dev_tracker;
>  	int rc;
> @@ -2462,7 +2462,7 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
>  	if (!ops->set_phys_id)
>  		return -EOPNOTSUPP;
>  
> -	if (busy)
> +	if (dev->ethtool->phys_id_busy)
>  		return -EBUSY;
>  
>  	if (copy_from_user(&id, useraddr, sizeof(id)))
> @@ -2472,13 +2472,14 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
>  	if (rc < 0)
>  		return rc;
>  
> -	/* Drop the RTNL lock while waiting, but prevent reentry or
> +	/* Drop the locks while waiting, but prevent reentry or
>  	 * removal of the device.
>  	 */
> -	busy = true;
> +	dev->ethtool->phys_id_busy = true;
>  	netdev_hold(dev, &dev_tracker, GFP_KERNEL);
>  	netdev_unlock_ops(dev);
> -	rtnl_unlock();
> +	if (has_rtnl_lock)
> +		rtnl_unlock();
>  
>  	if (rc == 0) {
>  		/* Driver will handle this itself */
> @@ -2491,22 +2492,25 @@ static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
>  		u64 i = 0;
>  
>  		do {
> -			rtnl_lock();
> +			if (has_rtnl_lock)
> +				rtnl_lock();
>  			netdev_lock_ops(dev);
>  			rc = ops->set_phys_id(dev,
>  				    (i++ & 1) ? ETHTOOL_ID_OFF : ETHTOOL_ID_ON);
>  			netdev_unlock_ops(dev);
> -			rtnl_unlock();
> +			if (has_rtnl_lock)
> +				rtnl_unlock();
>  			if (rc)
>  				break;
>  			schedule_timeout_interruptible(interval);
>  		} while (!signal_pending(current) && (!id.data || i < count));
>  	}
>  
> -	rtnl_lock();
> +	if (has_rtnl_lock)
> +		rtnl_lock();
>  	netdev_lock_ops(dev);
>  	netdev_put(dev, &dev_tracker);
> -	busy = false;
> +	dev->ethtool->phys_id_busy = false;
>  
>  	(void) ops->set_phys_id(dev, ETHTOOL_ID_INACTIVE);
>  	return rc;
> @@ -3259,7 +3263,8 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
>  static int
>  dev_ethtool_locked(struct net *net, struct net_device *dev,
>  		   void __user *useraddr,
> -		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state)
> +		   u32 ethcmd, struct ethtool_devlink_compat *devlink_state,
> +		   bool has_rtnl_lock)
>  {
>  	u32 sub_cmd;
>  	int rc;
> @@ -3315,6 +3320,8 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
>  			return -EPERM;
>  	}
>  
> +	netdev_ops_assert_locked(dev);
> +
>  	if (dev->dev.parent)
>  		pm_runtime_get_sync(dev->dev.parent);
>  
> @@ -3402,7 +3409,7 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
>  		rc = ethtool_get_strings(dev, useraddr);
>  		break;
>  	case ETHTOOL_PHYS_ID:
> -		rc = ethtool_phys_id(dev, useraddr);
> +		rc = ethtool_phys_id(dev, useraddr, has_rtnl_lock);
>  		break;
>  	case ETHTOOL_GSTATS:
>  		rc = ethtool_get_stats(dev, useraddr);
> @@ -3549,8 +3556,12 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
>  	if (dev->ethtool_ops->complete)
>  		dev->ethtool_ops->complete(dev);
>  
> -	if (old_features != dev->features)
> -		netdev_features_change(dev);
> +	if (old_features != dev->features) {
> +		if (has_rtnl_lock)
> +			netdev_features_change(dev);
> +		else
> +			netdev_WARN(dev, "unexpected device features change with ethtool cmd %u", ethcmd);
> +	}
>  out:
>  	if (dev->dev.parent)
>  		pm_runtime_put(dev->dev.parent);
> @@ -3558,25 +3569,60 @@ dev_ethtool_locked(struct net *net, struct net_device *dev,
>  	return rc;
>  }
>  
> +/* Commands that may toggle dev->features in net/ethtool/ioctl.c and so
> + * call into __netdev_update_features(), which still requires rtnl_lock.
> + * Driver-decided SET commands that may chain into rtnl-only helpers are
> + * covered by ethtool_ioctl_needs_rtnl()/ETHTOOL_OP_NEEDS_RTNL_*.
> + */
> +static bool ethtool_cmd_changes_features(u32 ethcmd)
> +{
> +	switch (ethcmd) {
> +	case ETHTOOL_SFEATURES:
> +	case ETHTOOL_SFLAGS:
> +	case ETHTOOL_STXCSUM:
> +	case ETHTOOL_SRXCSUM:
> +	case ETHTOOL_SSG:
> +	case ETHTOOL_STSO:
> +	case ETHTOOL_SGSO:
> +	case ETHTOOL_SGRO:
> +		return true;

GVE's gve_get_ethtool_stats (ETHTOOL_GSTATS) still has ASSERT_RTNL and
is now reachable with only ops lock?

