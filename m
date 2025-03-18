Return-Path: <netdev+bounces-175852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC37A67B1A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896B33BF650
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BD2211A2C;
	Tue, 18 Mar 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaBwDQ3B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635E211A27
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319543; cv=none; b=Amqj2+xHEVKjyPe40UKU6p6zYWuPljUkIk+XWkecptDVngyLAqfZl5/8jG+lWHrSp+A4xFe7DTg0Lc7RkLciOzgoi7sPbb2vNrGFi/XHqe/4hlQWUj7g1AhccT8otNzvakGPslkQa+Oej79FubS4z7fkkQPA0Ll9nVdn7Wv+yrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319543; c=relaxed/simple;
	bh=SogSoSrqlalouWo5pyYUSkLZg8i1AkOWjwNtRR+E4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5nIk4EkzQv4XJKYALGkbue/sN+j4P5fHpLfCBF7mqhXR+6t1yWivkzdp0inXz7X4ret41G75mRmrDmfZH9x8OPaDs5gdxOH8b8mfUOs37Z15IdVRVo08wpEaCr35i7id9o34IITm5WOcdq3YK8+yhtWAZdXed4HjsWl8d6h2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaBwDQ3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1905AC4CEDD;
	Tue, 18 Mar 2025 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319542;
	bh=SogSoSrqlalouWo5pyYUSkLZg8i1AkOWjwNtRR+E4gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaBwDQ3Bb4+/vPpDXpbzi8WvtdqwkVUS6XdUKLem5uaqg+0iT34POXj65dKKrgPSH
	 LA88GIABjIj2jq7RacPup4UIRxhPMJb2lbQZVAJTYU+ksbIp9rzduTxEF6F3QPOIJJ
	 bqjLTfI5vyb55RJpUHkfos/fkLplizLeX6HGuzu5lY7pnj57MlP/twkfaKYSacb0dQ
	 YCrrJR+UyxnNyyyBXPngo1TSYDsixQSlBJ+gNNRdsRsg708YJSVoJKdZA7o93WvR9N
	 NVLo7B7vQ72hduwSzELKBjUCTHkIs6Rv8TEtaq+faBVsmmPAWuul9YBB+0tHEpdANN
	 nS1n8Pw9vUlhQ==
Date: Tue, 18 Mar 2025 17:38:58 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 2/4] net/mlx5: Expose serial numbers in devlink
 info
Message-ID: <20250318173858.GS688833@kernel.org>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318153627.95030-3-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 04:36:25PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Devlink info allows to expose serial number and board serial number
> Get the values from PCI VPD and expose it.
> 
> $ devlink dev info
> pci/0000:08:00.0:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA

Hi Jiri,

I'm sorry if this is is somehow obvious, but what is
the difference between the serial number and board serial number
(yes, I do see that they are different numbers :)

>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.0:
>   driver mlx5_core.eth
> pci/0000:08:00.1:
>   driver mlx5_core
>   serial_number e4397f872caeed218000846daa7d2f49
>   board.serial_number MT2314XZ00YA
>   versions:
>       fixed:
>         fw.psid MT_0000000894
>       running:
>         fw.version 28.41.1000
>         fw 28.41.1000
>       stored:
>         fw.version 28.41.1000
>         fw 28.41.1000
> auxiliary/mlx5_core.eth.1:
>   driver mlx5_core.eth
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/devlink.c | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> index 73cd74644378..be0ae26d1582 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> @@ -35,6 +35,51 @@ static u16 mlx5_fw_ver_subminor(u32 version)
>  	return version & 0xffff;
>  }
>  
> +static int mlx5_devlink_serial_numbers_put(struct mlx5_core_dev *dev,
> +					   struct devlink_info_req *req,
> +					   struct netlink_ext_ack *extack)
> +{
> +	struct pci_dev *pdev = dev->pdev;
> +	unsigned int vpd_size, kw_len;
> +	char *str, *end;
> +	u8 *vpd_data;
> +	int start;
> +	int err;
> +
> +	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
> +	if (IS_ERR(vpd_data))
> +		return 0;
> +
> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> +					     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> +	if (start >= 0) {
> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> +		if (!str) {
> +			err = -ENOMEM;
> +			goto end;
> +		}
> +		end = strchrnul(str, ' ');
> +		*end = '\0';
> +		err = devlink_info_board_serial_number_put(req, str);
> +		kfree(str);
> +	}
> +
> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
> +	if (start >= 0) {
> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> +		if (!str) {
> +			err = -ENOMEM;
> +			goto end;
> +		}
> +		err = devlink_info_serial_number_put(req, str);
> +		kfree(str);
> +	}
> +
> +end:
> +	kfree(vpd_data);
> +	return err;

Perhaps it can never happen, but Smatch flags that err may be used
uninitialised here. I believe that can theoretically occur if
neither of start condition above are met.

> +}
> +

...

