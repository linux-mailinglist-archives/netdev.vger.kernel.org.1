Return-Path: <netdev+bounces-72857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6723859F64
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EF2280E7A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461102261B;
	Mon, 19 Feb 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GApodCAM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F082375B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334147; cv=none; b=N4mwH2bGj+1Qsxpl+OOjQDmdWQ2vhi9jkSlCL8l5nUsMzu3mIoLKssZx10MV++tiBJutV2EtgUS5Dd9yyJpI9ENEPgb6FgPnVBuk0Y4YiWVEOSJqTgJ0UmjS0D1HxFLRCErYRE32PMk6vInvzlBqXVDgxF5oKAJNhIm76g1FquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334147; c=relaxed/simple;
	bh=9VV68o31k6fg5obU3U9SI3UIbPyFr2icRfRLTVpufGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdOSHWeCPDfDUn2jjqKFbcx7f+lMN55DH3ghvDTEy6w9sR4YY6YXAgpHEf8P2IqWpaCouXKXdGLrB0/+TDmbYp9fIEQqzsfDHmTQ4VAG4ZKwBgFHoz22BIk11JC+2sYksAUzncKkqo/YQM6cWthsTi1M+1F/Zuia1kN9zH8aLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GApodCAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBB9C43390;
	Mon, 19 Feb 2024 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334146;
	bh=9VV68o31k6fg5obU3U9SI3UIbPyFr2icRfRLTVpufGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GApodCAMX12icns9otjHfa5LlWl9vlVRhpuMoFpoeSfoOIbxI6eJb1kVF0MfINDuJ
	 p7YI+W8NaaHtEY8hletGL3G/i2fuJ0Hxk/NfeqUeAf4qkZ6cyklfyoGcdSvkCfux+L
	 8zRHPupywDI2wlne5gVDsPzT0yafnRRFAVGKXnaE90YFw9cnwG++Exh6f9Ncy0zO+I
	 VGR8G4TErUJhvNzxg6EcgrBsBurmdBs2TQYh4Y62pkUXQ3CqZ2VgsA8JSApG4pZBSQ
	 1AZhYhry8JXRehJcLxxvMte4T4VViq76O8H3YF+sDTTOXD1nlXR9ffcowS/2GJHYdw
	 n7si8VBkkjW/A==
Date: Mon, 19 Feb 2024 09:15:42 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v1 1/2] igb: simplify pci ops declaration
Message-ID: <20240219091542.GS40273@kernel.org>
References: <20240210220109.3179408-1-jesse.brandeburg@intel.com>
 <20240210220109.3179408-2-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210220109.3179408-2-jesse.brandeburg@intel.com>

On Sat, Feb 10, 2024 at 02:01:08PM -0800, Jesse Brandeburg wrote:
> The igb driver was pre-declaring tons of functions just so that it could
> have an early declaration of the pci_driver struct.
> 
> Delete a bunch of the declarations and move the struct to the bottom of the
> file, after all the functions are declared.
> 
> Reviewed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

...

> @@ -219,19 +203,6 @@ static const struct pci_error_handlers igb_err_handler = {
>  
>  static void igb_init_dmac(struct igb_adapter *adapter, u32 pba);
>  
> -static struct pci_driver igb_driver = {
> -	.name     = igb_driver_name,
> -	.id_table = igb_pci_tbl,
> -	.probe    = igb_probe,
> -	.remove   = igb_remove,
> -#ifdef CONFIG_PM
> -	.driver.pm = &igb_pm_ops,
> -#endif
> -	.shutdown = igb_shutdown,
> -	.sriov_configure = igb_pci_sriov_configure,
> -	.err_handler = &igb_err_handler
> -};
> -
>  MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
>  MODULE_DESCRIPTION("Intel(R) Gigabit Ethernet Network Driver");
>  MODULE_LICENSE("GPL v2");

...

> @@ -10169,4 +10142,24 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
>  
>  	spin_unlock(&adapter->nfc_lock);
>  }
> +
> +#ifdef CONFIG_PM
> +static const struct dev_pm_ops igb_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
> +	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
> +			igb_runtime_idle)
> +};
> +#endif
> +
> +static struct pci_driver igb_driver = {
> +	.name     = igb_driver_name,
> +	.id_table = igb_pci_tbl,
> +	.probe    = igb_probe,
> +	.remove   = igb_remove,
> +	.driver.pm = &igb_pm_ops,

Hi Jesse,

the line above causes a build failure if CONFIG_PM is not set.

> +	.shutdown = igb_shutdown,
> +	.sriov_configure = igb_pci_sriov_configure,
> +	.err_handler = &igb_err_handler
> +};
> +
>  /* igb_main.c */

...

