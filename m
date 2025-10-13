Return-Path: <netdev+bounces-228686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF4BD239F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7803C1068
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032772FC867;
	Mon, 13 Oct 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhUruPYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8F2FC032;
	Mon, 13 Oct 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346911; cv=none; b=CTdOY3Ws7CKds+9HvOWLj481q1eREsgWd8QSd3ulqblcBVbl8nZquLXljoFCA+VRWyqlewfrsMfiAs9luxmsd5YAjBAPe5AukdzQQ5pUqrdFK31JNHVk3RZ5Z7U6c2JkM8I9tzLwrF+/reuuDpLT2VQCqn61Yll4wpXvGiYwN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346911; c=relaxed/simple;
	bh=msRnUaav7uDbDfI0p1Dhb1/vdSrsLZdUhmbjsqrEHk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm8RyK3mqhfcfGdiG1gkwcELqr45Hby9yXz1ulA8rnZurnUIuYL2zUK4PXu3Xn9uEMMzdjrBRsxV4ElfKhKo1GAwhbtI/tM3fxjV3TW+CMNDhbuiVMEaEswHIONnLMRP4/oU9/wOPsSt5ZjOKDaXmGNtsdCzfRqzKzrrD8CmGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhUruPYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98786C4CEFE;
	Mon, 13 Oct 2025 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760346909;
	bh=msRnUaav7uDbDfI0p1Dhb1/vdSrsLZdUhmbjsqrEHk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhUruPYg3qdVAZUFOmBT0D40rd0ttI1xEP8FKGYvgqVSctcV9NjmlOpxo0CS0m3t4
	 BSxOoV6Bmdq9jTQqCD5aebpZDUyozNZ2YAn3ElO3ACNnONrZ057z01/TS+YLhc51NA
	 mzmqy4dti3icMKPWFOQy6tfeS232C+SlvGx0DxJPyd3Njp/HkUqq+XSJUD5fKwDT0G
	 5++fyUIkFAmvOdWJVfS62UjsOqry5KhF52B2MIhUU2k2/vig9UwPv2rp+zEIVGUr5k
	 gDCQ6EW2RPFh23fYUizArtHEuALPrDUJ3niQrexIGUDhSORlwc3IdtyLJwkqZ80NBi
	 bqtBN5+mDKY2g==
Date: Mon, 13 Oct 2025 10:15:05 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] dpll: zl3073x: Handle missing or corrupted flash
 configuration
Message-ID: <aOzDGT44n_ychCgK@horms.kernel.org>
References: <20251008141445.841113-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008141445.841113-1-ivecera@redhat.com>

On Wed, Oct 08, 2025 at 04:14:45PM +0200, Ivan Vecera wrote:
> If the internal flash contains missing or corrupted configuration,
> basic communication over the bus still functions, but the device
> is not capable of normal operation (for example, using mailboxes).
> 
> This condition is indicated in the info register by the ready bit.
> If this bit is cleared, the probe procedure times out while fetching
> the device state.
> 
> Handle this case by checking the ready bit value in zl3073x_dev_start()
> and skipping DPLL device and pin registration if it is cleared.
> Do not report this condition as an error, allowing the devlink device
> to be registered and enabling the user to flash the correct configuration.
> 
> Prior this patch:
> [   31.112299] zl3073x-i2c 1-0070: Failed to fetch input state: -ETIMEDOUT
> [   31.116332] zl3073x-i2c 1-0070: error -ETIMEDOUT: Failed to start device
> [   31.136881] zl3073x-i2c 1-0070: probe with driver zl3073x-i2c failed with error -110
> 
> After this patch:
> [   41.011438] zl3073x-i2c 1-0070: FW not fully ready - missing or corrupted config
> 
> Fixes: 75a71ecc24125 ("dpll: zl3073x: Register DPLL devices and pins")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

I am unsure how much precedence there is for probing a device
with very limited functionality like this. But, the approach
does make sense to me as it provides a path for user intervention
to address the detected problem which at any rate renders the probed
driver inoperable.

Reviewed-by: Simon Horman <horms@kernel.org>

...

