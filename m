Return-Path: <netdev+bounces-126233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D097029D
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834EBB22AAC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9066B15CD41;
	Sat,  7 Sep 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDfM3lFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDA47A62;
	Sat,  7 Sep 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725718247; cv=none; b=P6q4VFQLcNcuny/DrSLdUSOg2KL08mN7JVntR4sqL69lL5hVtRdBGvP1NMBkiJ4Pc4vpqF0EtXoETxREHiQrviUcziTJ1OYN/m5T0/ADrN4FPkXhESO1U35MZYFKK1clS+PDE230QlyGQ5/ci6neZsMHfyhvYbD6ktvHHyInFQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725718247; c=relaxed/simple;
	bh=8iys38tPi7MwJeLg8WSSxN+QqGamS+XyKqS2AhSoISo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxNPcI2N1XdAEfJBbjkUTbZ4la6x/AYOnUckEdrndoF81DJ+Fn2RmWTcUx0/xt5o+zkZcgca5cAtIyB9ouX9jgk27pB1BhFN+gbazry37Im9oi1/r9P8snpdvnO6P9Y9uxQC8Z8g7yUmNgcr8HHiG7Ruu0X+gK0/fVW5SzGdv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDfM3lFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C82C4CEC2;
	Sat,  7 Sep 2024 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725718247;
	bh=8iys38tPi7MwJeLg8WSSxN+QqGamS+XyKqS2AhSoISo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDfM3lFbrGmRTb5Tdsqdtk5p6nCFPNb6bxouosBcq6ouzt3N0/qhH/sYm/h6hVlpQ
	 sFZOO6IBKP7mUNB4ZYQWcgMZX+sgE+zM5lt+vyz0PUUOpDwBSttgBCz/02+NCVFA1d
	 Td33Qe/r93XFGFYFEIcuEgm6Li3d2DRK35oiiz0KeHEcq2yAzOTRZ/nYO/zzzQEDtp
	 MO9y356X47mslWNjf97rjBjJG1cGsmNyUD39wHYs8DVGIMdaCzM40NwxEOR+SOwHdl
	 VPH+R+WMSAu5C97IeOTSghqZW2/IsF6beSJR1zsE/gVDnaU8Ey9YmvO3lkZjkIMHQB
	 aMQkKhrNG1h5w==
Date: Sat, 7 Sep 2024 15:10:42 +0100
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yuehaibing@huawei.com,
	linux-kernel@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Message-ID: <20240907141042.GR2097826@kernel.org>
References: <20240906055700.2645281-1-danieller@nvidia.com>
 <20240906055700.2645281-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906055700.2645281-3-danieller@nvidia.com>

On Fri, Sep 06, 2024 at 08:57:00AM +0300, Danielle Ratson wrote:
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

...

> diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c

...

> @@ -548,6 +555,49 @@ __ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
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

Hi Danielle,

A minor issue from my side:
In the first iteration of the loop below bytes_written is used uninitialised.

Flagged by W=1 builds using clang-18 and gcc-14.

> +
> +	for (page = CMIS_CDB_EPL_PAGE_START;
> +	     page <= CMIS_CDB_EPL_PAGE_END && bytes_written < epl_len; page++) {
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

-- 
pw-bot: cr

