Return-Path: <netdev+bounces-209004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D373FB0DFC6
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60571C80538
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883A28C5B4;
	Tue, 22 Jul 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asGNOylE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031802EA491
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196072; cv=none; b=frC2PeUp/ZZ45iCC1OgmNm7Wls69ArjRAjzAECRCzQJS5WspmEKANobqcvrXul+2ih8DbwOpZam5zv5iRel5qkI4EN+0ZnwtEGckMhcwtwhetKGLtrywDABbq4JcTL3sQ+Pr5CIl0phA/MLPP9iJ9UtsZw/cSXG87FJQA3jOlls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196072; c=relaxed/simple;
	bh=d5Dgo/SP2frqJQVMsqQJtgDsR0zcroc9Ub5WH+3oids=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXGJmkRevby4uq6PcNKYrq5ZNINe1gDe1ygZ0xNRwwGyrdavokkdkGtVKxlW09KfOlNz0xNypo39+b+7EHjffyZ2Rsg3z7bjd7Y013FpyYhkFuaI9czKtDTZMhWRZgASAM8DbZsI1gx/uJ30VqIPSXra1QfDDcH/f5zY/8TVXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asGNOylE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6155CC4CEEB;
	Tue, 22 Jul 2025 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196071;
	bh=d5Dgo/SP2frqJQVMsqQJtgDsR0zcroc9Ub5WH+3oids=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asGNOylE9Z7BKj65LuJd+1BMWxHf8yVl9Hvg2q6sE/15sBS8nONUAgH/tebTcMooE
	 wU3Bg7Sqi2zAb4rhMmjIkZduzVRl5uGmWd8r+5y25aykVvSTMaY3JXXIvptO+Cfviu
	 WSiL3S/tXfxiBf4Bvi7Q8wtmGbCpHdBDM1yggQX7QTB6fskrV2BBrdkvFVNhKrZ6EA
	 FMU95Sii2ju+lG8Bo/RuM74Hcks+xZfFIoNjQz35yY89c4pcwteyWkzSKmqCDiF53t
	 ziNcUJ32nmp+oN+IFflvHN333zwIBBS5eImK24GNnOhmp7pHCkCmsTs79604QSyqQ/
	 H6N3ZLfUVbQpg==
Date: Tue, 22 Jul 2025 15:54:28 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com
Subject: Re: [PATCH iwl-next v1 09/15] ice: drop driver specific structure
 from fwlog code
Message-ID: <20250722145428.GM2459@horms.kernel.org>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
 <20250722104600.10141-10-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722104600.10141-10-michal.swiatkowski@linux.intel.com>

On Tue, Jul 22, 2025 at 12:45:54PM +0200, Michal Swiatkowski wrote:
> In debugfs pass ice_fwlog structure instead of ice_pf.
> 
> The debgufs dirs specific for fwlog can be stored in fwlog structure.
> 
> Add debugfs entry point to fwlog api.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c

...

> @@ -580,9 +569,10 @@ static const struct file_operations ice_debugfs_data_fops = {
>  
>  /**
>   * ice_debugfs_fwlog_init - setup the debugfs directory
> - * @pf: the ice that is starting up
> + * @fwlog: pointer to the fwlog structure
> + * @root: debugfs root entry on which fwlog director will be registered
>   */
> -void ice_debugfs_fwlog_init(struct ice_pf *pf)
> +void ice_debugfs_fwlog_init(struct ice_fwlog *fwlog, struct dentry *root)
>  {
>  	struct dentry *fw_modules_dir;
>  	struct dentry **fw_modules;
> @@ -598,41 +588,39 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
>  
>  	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
>  						      pf->ice_debugfs_pf);

pf no longer exists in this context.

> -	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
> +	if (IS_ERR(fwlog->debugfs))
>  		goto err_create_module_files;
>  
> -	fw_modules_dir = debugfs_create_dir("modules",
> -					    pf->ice_debugfs_pf_fwlog);
> +	fw_modules_dir = debugfs_create_dir("modules", fwlog->debugfs);
>  	if (IS_ERR(fw_modules_dir))
>  		goto err_create_module_files;

...

