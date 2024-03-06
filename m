Return-Path: <netdev+bounces-78159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB66874398
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BC51C20B5D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAC91C684;
	Wed,  6 Mar 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAGNxjzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B01C280
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766852; cv=none; b=hitS3VaIhcXFRlTM9ay//W7HuCDQK/L4sdfgh9r/0goz9ulopLHVd1m5TppxvKnKvc2WirWuWEJa2OG/b4ca7WrY9SiSee/ugcYBl5bDUUUXoVm4l670k68ZbcpeEM+hfgY+QYq9H0TBeVWfGqIu2+mjWCxUuhBLkYHPAG1re9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766852; c=relaxed/simple;
	bh=POAJKR3OgJRYcpnuB29BhFD8tDhA1gO7avSXC5ZFZo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JkB7dPuGF5YG531/PKDqZt1gC06QwiK6YcYwIuJJYiQJhUYjFy6c8arF6NDCg8blsmUEa2rzzCfN01CoE/2mf2AiWpdiKk7pEW/dazVdvZ6PhYe+YnqIGHX2zf49n1sGocftaW5/siydrZoIUJyuTfnpIWcZm93KWkgnHPUBTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAGNxjzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946E7C433F1;
	Wed,  6 Mar 2024 23:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766851;
	bh=POAJKR3OgJRYcpnuB29BhFD8tDhA1gO7avSXC5ZFZo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gAGNxjzkBgoTuFJZZjrry49jgFA52cv//m3W0iJRf2NcU1JLxAdQQfzHbJey8mtaC
	 9swkBXyRf+0WUGWwNdQFYPwyTNXQYKO/ljriAbJ4+5jM7FRs50lmdsQmFRAWGIoHpI
	 kB9ohfSH0GfyLzvGpYXjgXY8h/5znnSBcsA57sAwbe30jvRfBxMDXWP5BVquDaNZvm
	 S4w8B8qXCYKc/EIOWmcEl753s9AkS3uY6XGJohpaHD2UyKrpLmpyffAgMgFONeP+I8
	 Y2fEB9ldF/ITz5baySKp36Ek63C3S7FFs9O5XV+u1P1bo9voEvuhbl5drEqaIcFdTE
	 9gSde6IGEjtvg==
Date: Wed, 6 Mar 2024 17:14:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, pmenzel@molgen.mpg.de,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH iwl-next v2 1/2] igb: simplify pci ops declaration
Message-ID: <20240306231410.GA589078@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306025023.800029-2-jesse.brandeburg@intel.com>

[+cc Paul for __maybe_unused cleanup]

On Tue, Mar 05, 2024 at 06:50:21PM -0800, Jesse Brandeburg wrote:
> The igb driver was pre-declaring tons of functions just so that it could
> have an early declaration of the pci_driver struct.
> 
> Delete a bunch of the declarations and move the struct to the bottom of the
> file, after all the functions are declared.

Nice fix, that was always annoying.

Seems like there's an opportunity to drop some of the __maybe_unused
annotations:

  static int __maybe_unused igb_suspend(struct device *dev)

after 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").

I don't know if SET_RUNTIME_PM_OPS() makes __maybe_unused unnecessary
or not.

> +#ifdef CONFIG_PM
> +static const struct dev_pm_ops igb_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
> +	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
> +			   igb_runtime_idle)
> +};
> +#endif
> +
> +static struct pci_driver igb_driver = {
> +	.name     = igb_driver_name,
> +	.id_table = igb_pci_tbl,
> +	.probe    = igb_probe,
> +	.remove   = igb_remove,
> +#ifdef CONFIG_PM
> +	.driver.pm = &igb_pm_ops,
> +#endif
> +	.shutdown = igb_shutdown,
> +	.sriov_configure = igb_pci_sriov_configure,
> +	.err_handler = &igb_err_handler
> +};
> +
>  /* igb_main.c */
> -- 
> 2.39.3
> 

