Return-Path: <netdev+bounces-105432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384191121B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850AD1C225E1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189CB1B5828;
	Thu, 20 Jun 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgdp9V3g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2D51862A;
	Thu, 20 Jun 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911832; cv=none; b=SqdOcvks/lPlBAikglFEsTYWME8SDjXCuRU9zRsaBrjKIW25lFpz1hbRP5TYeH5PFyfPA4bFH8ver8ovGJGl+W8XAA6iUsKM+WuJFej8NEf/jlisStneLHeEmSICiQa8yNE498I9C5HXJKTgeN5Zrbzb9mkMxRuEs9UYNZOOStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911832; c=relaxed/simple;
	bh=29nTEiif20CFUV9FBLNA/wCmJTCDRc6J9B7DziK6rUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCc0G90RHiS9GoZnaYO+4wJerNKrTZLGrElf8ij8OAuiNZrMWWW4lpNPYDpgGM0nkuNnFQkF+lJjiXkL0BpyzjE/KyIk7aoufe9cIv4B/yEtN46ZP3jMx5umVBf82zzfUTp2C8RyTddgUuqb0NczsSSTpBho+pU2ZhbTfN4v1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgdp9V3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1889FC2BD10;
	Thu, 20 Jun 2024 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718911830;
	bh=29nTEiif20CFUV9FBLNA/wCmJTCDRc6J9B7DziK6rUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgdp9V3gASTmkotfe2knDUlY5iJLpdRqn9R2XMzOkkMSWzRg8JwEUxbTbGtvJxW9h
	 Y5BUI8/1ekn7sM9Iha4NxGqJvt5c0nG4suDzbSqO02P9HSGO9RxcPJJmd7e0zubHz9
	 cMiQderXjZ77F9SDuPQDHiAMZW7yh4LrYedKvr2Mzu70havA5hQaEpt+6iWabTjT1C
	 OT4yCuTePD8iVNpjkSgPna/qd/uCurVBrjLW/td7G6mTnsQoJ3ZcYGQNqp/YaA5xWb
	 Hbj2qTeD2SftoUg4qCGpwI/KwMMSkrUL+mE+Aj19e1xJpBrFG2IXwDG0Bdd2Xa+I5C
	 KrcNfcMN7iR+w==
Date: Thu, 20 Jun 2024 20:30:23 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v6 4/9] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240620193023.GS959333@kernel.org>
References: <20240619121727.3643161-1-danieller@nvidia.com>
 <20240619121727.3643161-5-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619121727.3643161-5-danieller@nvidia.com>

On Wed, Jun 19, 2024 at 03:17:22PM +0300, Danielle Ratson wrote:
> Add progress notifications ability to user space while flashing modules'
> firmware by implementing the interface between the user space and the
> kernel.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

...

> diff --git a/net/ethtool/module.c b/net/ethtool/module.c

...

> @@ -158,3 +159,119 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
>  	.set			= ethnl_set_module,
>  	.set_ntf_cmd		= ETHTOOL_MSG_MODULE_NTF,
>  };
> +
> +/* MODULE_FW_FLASH_NTF */
> +
> +static int
> +ethnl_module_fw_flash_ntf_put_err(struct sk_buff *skb, char *err_msg,
> +				  char *sub_err_msg)
> +{
> +	int err_msg_len, sub_err_msg_len, total_len;
> +	struct nlattr *attr;
> +
> +	if (!err_msg)
> +		return 0;
> +
> +	err_msg_len = strlen(err_msg);
> +	total_len = err_msg_len + 2; /* For period and NUL. */
> +
> +	if (sub_err_msg) {
> +		sub_err_msg_len = strlen(sub_err_msg);
> +		total_len += sub_err_msg_len + 2; /* For ", ". */
> +	}
> +
> +	attr = nla_reserve(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,
> +			   total_len);
> +	if (!attr)
> +		return PTR_ERR(attr);

Hi Danielle,

attr is NULL here, so I think this will return 0.
Perhaps it should return an negative error value,
say -ENOMEM, instead?

Flagged by Smatch

> +
> +	if (sub_err_msg)
> +		sprintf(nla_data(attr), "%s, %s.", err_msg, sub_err_msg);
> +	else
> +		sprintf(nla_data(attr), "%s.", err_msg);
> +
> +	return 0;
> +}

...

