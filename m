Return-Path: <netdev+bounces-130469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D298AA0E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2532CB25F0A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE34194082;
	Mon, 30 Sep 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnTo1ML9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5D19309E;
	Mon, 30 Sep 2024 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714518; cv=none; b=JVsPGA3R/RkCEggl5S02vygjABbNQgwbfn6zgqShP/z7zsMmr3e+W/xk+C4++0cjecFe16qtpwsx0N+PPqKIVBh9v/yAqPrXB3qsFoAGDmSERe99fnZqICS320kk6w/vYrRf9A9Z0gZ8LnHmunyGXja9rLiWiaxoR0VJWXkY/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714518; c=relaxed/simple;
	bh=E3mcGZ+rWDw9nsWQRCjWdLt6GoBHCgrZtJYw1N+0JfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dhp+SSOKuTfRc4Lyk+eCxt1Z1/HDtfthj3D4aHmbWpIcA9PvFlNfYiVV0OpahbS42Y9goRY99l9c7srvoJrqDX9YSXWPJoeG5K0v7RTTNSzLxg+spqiPGD+sKyKyOj8IOGd+xTDnuKZZQH2CBixO+bYivma+yxFs4NAEfDlb9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnTo1ML9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEFFC4CEC7;
	Mon, 30 Sep 2024 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714517;
	bh=E3mcGZ+rWDw9nsWQRCjWdLt6GoBHCgrZtJYw1N+0JfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnTo1ML943VUDW7sizvgArsOvpBOwC1C3QtWAS72EwFtQiWPuuTGHeCdNDUMobOGa
	 aT/BhQ5B549nY4PlIAB2YZ08tRu7IrVN1pjkwFGzBiPFg5X5UvmOVd1S7TTgHhNCoE
	 wIDPUEP3IRwLWcsL9stVJpOsdr3M9gHkLczbcxtLovIEZBrpgCvWeCMadwm+/+fB2A
	 jmadj441Vm5606RWCEVuMPy5MUpwjIUcE5JYz8PQwXXNw0vNOK2z5zTUCYglmB/YjV
	 IjWEjW8XzHhubgfduEoMLw7WuiT85ChxqB8spPX16CP0Nt+xhoKHZE1QH67yVJOych
	 lmNuA7ZgjqbKw==
Date: Mon, 30 Sep 2024 17:41:54 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next v3 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Message-ID: <20240930164154.GG1310185@kernel.org>
References: <20240930084637.1338686-1-danieller@nvidia.com>
 <20240930084637.1338686-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930084637.1338686-3-danieller@nvidia.com>

On Mon, Sep 30, 2024 at 11:46:37AM +0300, Danielle Ratson wrote:
> In the CMIS specification for pluggable modules, LPL (Low-Priority Payload)
> and EPL (Extended Payload Length) are two types of data payloads used for
> managing various functions and features of the module.
> 
> EPL payloads are used for more complex and extensive management
> functions that require a larger amount of data, so writing firmware
> blocks using EPL is much more efficient.
> 
> Currently, only LPL payload is supported for writing firmware blocks to
> the module.
> 
> Add support for writing firmware block using EPL payload, both to
> support modules that supports only EPL write mechanism, and to optimize
> the flashing process of modules that support LPL and EPL.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -556,6 +563,49 @@ __ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
>  	return err;
>  }
>  
> +#define CMIS_CDB_EPL_PAGE_START			0xA0
> +#define CMIS_CDB_EPL_PAGE_END			0xAF
> +#define CMIS_CDB_EPL_FW_BLOCK_OFFSET_START	128
> +#define CMIS_CDB_EPL_FW_BLOCK_OFFSET_END	255
> +
> +static int
> +ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev,
> +				 struct ethtool_cmis_cdb_cmd_args *args,
> +				 struct ethtool_module_eeprom *page_data)
> +{
> +	u16 epl_len = be16_to_cpu(args->req.epl_len);
> +	u32 bytes_written;
> +	u8 page;
> +	int err;
> +
> +	for (page = CMIS_CDB_EPL_PAGE_START;
> +	     page <= CMIS_CDB_EPL_PAGE_END && bytes_written < epl_len; page++) {

bytes_written does not seem to be initialised here for the first iteration
of the loop.

Flagged by W=1 builds with clang-18.

> +		u16 offset = CMIS_CDB_EPL_FW_BLOCK_OFFSET_START;
> +
> +		while (offset <= CMIS_CDB_EPL_FW_BLOCK_OFFSET_END &&
> +		       bytes_written < epl_len) {
> +			u32 bytes_left = epl_len - bytes_written;
> +			u16 space_left, bytes_to_write;
> +
> +			space_left = CMIS_CDB_EPL_FW_BLOCK_OFFSET_END - offset + 1;
> +			bytes_to_write = min_t(u16, bytes_left,
> +					       min_t(u16, space_left,
> +						     args->read_write_len_ext));
> +
> +			err = __ethtool_cmis_cdb_execute_cmd(dev, page_data,
> +							     page, offset,
> +							     bytes_to_write,
> +							     args->req.epl + bytes_written);
> +			if (err < 0)
> +				return err;
> +
> +			offset += bytes_to_write;
> +			bytes_written += bytes_to_write;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static u8 cmis_cdb_calc_checksum(const void *data, size_t size)
>  {
>  	const u8 *bytes = (const u8 *)data;

...

-- 
pw-bot: changes-requested

