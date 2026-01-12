Return-Path: <netdev+bounces-248989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4DD12558
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3229830119BC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC7356A0B;
	Mon, 12 Jan 2026 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ozt31Hbp"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77832572F;
	Mon, 12 Jan 2026 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217760; cv=none; b=mtpV55pzEEUQuWCarrns/lumg0kw2VXxr27UREG7xfRZYMad+kxTHvR589XDaYPapAsYeEcbMMtG0ADTuy8PvcZwAXD6buev4/KjpWHkN2KyV3HfxSU46eL5Ntd1W6a7xA67gbel5+ky0zKiXK6L6ItYMiEepUmfkpJORTH2FNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217760; c=relaxed/simple;
	bh=ll9SMCinfSZ7t0ZSHxWSE/gxN9HrzUQ2mXsPq3zLFww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMK6N/EQ2xcQx75vlapDrK9ubCs+qrlvEp2uGIHMWyvpvmAERzQy5Fyi/t1rY7GrqmV28e2+T6GkPCUsfM7ZrGBZOaV8QxWCdUMj5HchXpJnHvQTA7IZiiIkjcDOwSu6WgjqrMZJDJpUQ3GAVZMQBVSrXJFp5B12dHBNUQOWXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ozt31Hbp; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0179717b-9567-4f3d-a521-6988c2d21ba6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768217756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=467nUSUE++0RwRY+T84QloFORYpCYgg1naH46mtpChk=;
	b=Ozt31HbpoO0bJK1SoDmGw6NwwqCqiEBXChBErHVBk/Va3b2wY7b1MhEBl+9FCD7731j2/n
	uaWe7jHRnVaYhO9P5/bN0e92yubgnme0fjqlck/G/e58SdsBXuMNI7lABhWVMtfmxjAltZ
	/FSYIo968xmDl2N1iZwbBXGC3rT0PL0=
Date: Mon, 12 Jan 2026 11:35:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] dpll: add dpll_device op to set working mode
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260112101409.804206-1-ivecera@redhat.com>
 <20260112101409.804206-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260112101409.804206-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 10:14, Ivan Vecera wrote:
> Currently, userspace can retrieve the DPLL working mode but cannot
> configure it. This prevents changing the device operation, such as
> switching from manual to automatic mode and vice versa.
> 
> Add a new callback .mode_set() to struct dpll_device_ops. Extend
> the netlink policy and device-set command handling to process
> the DPLL_A_MODE attribute.  Update the netlink YAML specification
> to include the mode attribute in the device-set operation.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   Documentation/netlink/specs/dpll.yaml |  1 +
>   drivers/dpll/dpll_netlink.c           | 44 +++++++++++++++++++++++++++
>   drivers/dpll/dpll_nl.c                |  1 +
>   include/linux/dpll.h                  |  2 ++
>   4 files changed, 48 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index 78d0724d7e12c..b55afa77eac4b 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -550,6 +550,7 @@ operations:
>           request:
>             attributes:
>               - id
> +            - mode
>               - phase-offset-monitor
>               - phase-offset-avg-factor
>       -
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index d6a0e272d7038..37ca90ab841bd 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -853,6 +853,45 @@ int dpll_pin_change_ntf(struct dpll_pin *pin)
>   }
>   EXPORT_SYMBOL_GPL(dpll_pin_change_ntf);
>   
> +static int
> +dpll_mode_set(struct dpll_device *dpll, struct nlattr *a,
> +	      struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
> +	enum dpll_mode mode = nla_get_u32(a), old_mode;
> +	DECLARE_BITMAP(modes, DPLL_MODE_MAX) = { 0 };

I believe the size of bitmap should be DPLL_MODE_MAX + 1 or
__DPLL_MODE_MAX?

> +	int ret;
> +
> +	if (!(ops->mode_set && ops->supported_modes_get)) {
> +		NL_SET_ERR_MSG_ATTR(extack, a,
> +				    "dpll device does not support mode switch");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = ops->mode_get(dpll, dpll_priv(dpll), &old_mode, extack);
> +	if (ret) {
> +		NL_SET_ERR_MSG(extack, "unable to get current mode");
> +		return ret;
> +	}
> +
> +	if (mode == old_mode)
> +		return 0;
> +
> +	ret = ops->supported_modes_get(dpll, dpll_priv(dpll), modes, extack);
> +	if (ret) {
> +		NL_SET_ERR_MSG(extack, "unable to get supported modes");
> +		return ret;
> +	}
> +
> +	if (!test_bit(mode, modes)) {
> +		NL_SET_ERR_MSG(extack,
> +			       "dpll device does not support requested mode");
> +		return -EINVAL;
> +	}
> +
> +	return ops->mode_set(dpll, dpll_priv(dpll), mode, extack);
> +}
> +
>   static int
>   dpll_phase_offset_monitor_set(struct dpll_device *dpll, struct nlattr *a,
>   			      struct netlink_ext_ack *extack)
> @@ -1808,6 +1847,11 @@ dpll_set_from_nlattr(struct dpll_device *dpll, struct genl_info *info)
>   	nla_for_each_attr(a, genlmsg_data(info->genlhdr),
>   			  genlmsg_len(info->genlhdr), rem) {
>   		switch (nla_type(a)) {
> +		case DPLL_A_MODE:
> +			ret = dpll_mode_set(dpll, a, info->extack);
> +			if (ret)
> +				return ret;
> +			break;
>   		case DPLL_A_PHASE_OFFSET_MONITOR:
>   			ret = dpll_phase_offset_monitor_set(dpll, a,
>   							    info->extack);
> diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
> index 36d11ff195df4..a2b22d4921142 100644
> --- a/drivers/dpll/dpll_nl.c
> +++ b/drivers/dpll/dpll_nl.c
> @@ -45,6 +45,7 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
>   /* DPLL_CMD_DEVICE_SET - do */
>   static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_AVG_FACTOR + 1] = {
>   	[DPLL_A_ID] = { .type = NLA_U32, },
> +	[DPLL_A_MODE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
>   	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
>   	[DPLL_A_PHASE_OFFSET_AVG_FACTOR] = { .type = NLA_U32, },
>   };
> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> index 912a2ca3e0ee7..c6d0248fa5273 100644
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h
> @@ -20,6 +20,8 @@ struct dpll_pin_esync;
>   struct dpll_device_ops {
>   	int (*mode_get)(const struct dpll_device *dpll, void *dpll_priv,
>   			enum dpll_mode *mode, struct netlink_ext_ack *extack);
> +	int (*mode_set)(const struct dpll_device *dpll, void *dpll_priv,
> +			enum dpll_mode mode, struct netlink_ext_ack *extack);
>   	int (*supported_modes_get)(const struct dpll_device *dpll,
>   				   void *dpll_priv, unsigned long *modes,
>   				   struct netlink_ext_ack *extack);


