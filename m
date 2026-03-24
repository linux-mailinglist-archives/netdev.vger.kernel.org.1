Return-Path: <netdev+bounces-271159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEUqHya4wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:13:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE66F318C71
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D39303E2F6
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AF391820;
	Tue, 24 Mar 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxKsHBvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED135390C84;
	Tue, 24 Mar 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368564; cv=none; b=uHXdyz/tVU/jOKhrSGFPhrrFnwPW+QFdPaT07arLPmr1dEAHyFvRITmMMA7SPPlKw5yi4MgnI62qYFaEhquuGtI3piBAnUMyZMQ2fmpu+ArNIoxdC7MVHdx8hXRQHmtQgCnKf9exsIqLnS2Fi8u99iaUABOuiIN+HLith4Eh9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368564; c=relaxed/simple;
	bh=cD21QrQ6E0LmHBU1ngnAKYZMoTRR8051WNRd2rrr2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H04r8moeCBipagdMCbSRz429M4ts+e2QYt70rD2vWu5JnlADbSankbujVVgJ/n6lVf109xUb3re+TQlw6xblPCYNQacJN0y0gCoEHuc4ETPimk0Re4sFgZZ4d++DNxHhf9Ja1YoNPktZc9wYpO+6p6rwABcpxr2gftRMSKHyYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxKsHBvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC5C2BC9E;
	Tue, 24 Mar 2026 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368563;
	bh=cD21QrQ6E0LmHBU1ngnAKYZMoTRR8051WNRd2rrr2e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxKsHBvy4RaesAtAyOqIR1DL1qBwY0P6PcV4Ia7yGieIkgwxAzvsAErvhH0y1zHFc
	 eFVEAWjbj3RzFwlzkzE1fIfN9szi/hcPRj5zWK5VMhUhwAhYRMMXmq6KeniJZkq89e
	 kVZ9Yz9mXhbhzsgJ2vB7VqkvQ4+fIhCfBbNCWjQ+pKDLeXUX9lfPTw5lY9a4S0GpTx
	 o36pBm/EwEbDWyfCAvT2LgtHKSdDuy5U6Y+wzQdM1oHi1/tYM6KSsMPoj3/dEBb+63
	 Rxc0hZ/fWxcX3ApRBqjLf1YWpBKjrLHNgkD+VmF5wdLC+CiG2Y/8HpS7jrpo57Hxdk
	 lHfUOO6UWlodQ==
Date: Tue, 24 Mar 2026 16:09:17 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com, dtatulea@nvidia.com,
	tariqt@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v7 net-next 2/5] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <20260324160917.GB111839@horms.kernel.org>
References: <20260323035110.3908741-1-rkannoth@marvell.com>
 <20260323035110.3908741-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323035110.3908741-3-rkannoth@marvell.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: EE66F318C71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:21:07AM +0530, Ratheesh Kannoth wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Devlink param value attribute is not defined since devlink is handling
> the value validating and parsing internally, this allows us to implement
> multi attribute values without breaking any policies.
> 
> Devlink param multi-attribute values are considered to be dynamically
> sized arrays of u64 values, by introducing a new devlink param type
> DEVLINK_PARAM_TYPE_U64_ARRAY, driver and user space can set a variable
> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
> 
> Implement get/set parsing and add to the internal value structure passed
> to drivers.
> 
> This is useful for devices that need to configure a list of values for
> a specific configuration.
> 
> example:
> $ devlink dev param show pci/... name multi-value-param
> name multi-value-param type driver-specific
> values:
> cmode permanent value: 0,1,2,3,4,5,6,7
> 
> $ devlink dev param set pci/... name multi-value-param \
> 		value 4,5,6,7,0,1,2,3 cmode permanent
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> index 2eb666a46f39..e96dfe322c14 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> @@ -43,7 +43,6 @@ struct mlx5e_pcie_cong_event {
>  	struct mlx5e_pcie_cong_stats stats;
>  };
>  
> -
>  static const struct counter_desc mlx5e_pcie_cong_stats_desc[] = {
>  	{ MLX5E_DECLARE_STAT(struct mlx5e_pcie_cong_stats,
>  			     pci_bw_inbound_high) },

The above hunk seems to have been included by mistake.

> @@ -259,7 +258,11 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
>  		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
>  	};
>  	struct devlink *devlink = priv_to_devlink(dev);
> -	union devlink_param_value val[4];
> +	union devlink_param_value *val;
> +
> +	val = kcalloc(4, sizeof(*val), GFP_KERNEL);
> +	if (!val)
> +		return -ENOMEM;
>  
>  	for (int i = 0; i < 4; i++) {
>  		u32 id = ids[i];

The lines following this hunk are:

		int err;

		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
		if (err)
			return err;

AI review points out that if the error condition above is reached,
then val will be leaked.

> @@ -275,6 +278,7 @@ mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
>  	config->outbound_low = val[2].vu16;
>  	config->outbound_high = val[3].vu16;
>  
> +	kfree(val);
>  	return 0;
>  }
>  

Overall I would suggest breaking the mlx5 driver changes out into a
separate preparatory patch, which precedes the devlink patch in the
patch-set.

...

-- 
pw-bot: changes-requested

