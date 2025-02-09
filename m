Return-Path: <netdev+bounces-164443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC3A2DD0A
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F6B3A81EB
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD3118871F;
	Sun,  9 Feb 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYTM30Cf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280291714AC
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099598; cv=none; b=iH6RroLXCJ2p2uNlYYDsoF5Elu5LtG3gnfkxEkN6wkE0lniSkAnj2trUTozYvSEu+cAV3Bp9Xst+ws2imk0dOXirC6lsKmcH3tVCNokze/ePODULht5yKwq7uVVCGvYofRLzgZ0UHEFdwPmCncgUWbktQEBoKvqJz/AUU3CGMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099598; c=relaxed/simple;
	bh=TLYauqIxGxZkb3ojnclsL59eGEmdz8oHXimrxn4uxCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFe3txplg+eI4MwT3qzd8HL7ag7rLjVkmuMUNsjP0xkDZh9Vy0V903KQdA65Q0w5mWPWH7SFPprM4XeLMg3x8zA+USOIaJzEPewowaBr93Qr1bLQKEt1E/ZlSZsP7/+CMsDRi1EnDONtvd4EJG5dfdDt3uLrCqFy2QjWRxgLqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYTM30Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E11CC4CEDD;
	Sun,  9 Feb 2025 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739099597;
	bh=TLYauqIxGxZkb3ojnclsL59eGEmdz8oHXimrxn4uxCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYTM30Cff9Q/PDKB+cwGdnmtbjN1FS0oULLRRhQkNEvEhLJh1mdXlGKxRWVQjvV/g
	 jbWylwabaeVE7Qd91FXqHPDycO3MdWJ/FQI8EvRQfb7KXzYmqBhH/uQU1S19sgOy6M
	 8rNrpmdzP+7xxkDVwlstSBmk0n2Y0oQ6YBeLizzEW365m9GZ2tJiJEoqiz2HyuNKaF
	 E3Ikxq/l2w9381+35sOvpmSvaVxynn9M2Sw+yckkcWY8lCzb/M4Jv+wjXfDBHaDk3V
	 tB0m21DwjjhfXcXcFEdA+g96WnkvLckxHS5dNgKYwMTC4l3vwJfl54J0FK8azwKgcg
	 1efdjNj7EFofA==
Date: Sun, 9 Feb 2025 11:13:14 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v1 01/13] ixgbe: add initial devlink support
Message-ID: <20250209111314.GC554665@kernel.org>
References: <20250203150328.4095-1-jedrzej.jagielski@intel.com>
 <20250203150328.4095-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203150328.4095-2-jedrzej.jagielski@intel.com>

On Mon, Feb 03, 2025 at 04:03:16PM +0100, Jedrzej Jagielski wrote:
> Add an initial support for devlink interface to ixgbe driver.
> 
> Similarly to i40e driver the implementation doesn't enable
> devlink to manage device-wide configuration. Devlink instance
> is created for each physical function of PCIe device.
> 
> Create separate directory for devlink related ixgbe files
> and use naming scheme similar to the one used in the ice driver.
> 
> Add a stub for Documentation, to be extended by further patches.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> +/**
> + * ixgbe_devlink_register_port - Register devlink port
> + * @adapter: pointer to the device adapter structure
> + *
> + * Create and register a devlink_port for this physical function.
> + *
> + * Return: 0 on success, error code on failure.
> + */
> +int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
> +{
> +	struct devlink_port *devlink_port = &adapter->devlink_port;
> +	struct devlink *devlink = adapter->devlink;
> +	struct device *dev = &adapter->pdev->dev;
> +	struct devlink_port_attrs attrs = {};
> +	int err;
> +
> +	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	attrs.phys.port_number = adapter->hw.bus.func;
> +	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
> +
> +	devlink_port_attrs_set(devlink_port, &attrs);
> +
> +	err = devl_port_register(devlink, devlink_port, 0);
> +	if (err) {
> +		dev_err(dev,
> +			"devlink port registration failed, err %d\n",
> +			err);

nit: I think we can fit this onto one 80 column-wide line (just!).

		dev_err(dev, "devlink port registration failed, err %d\n", err);

> +	}
> +
> +	return err;
> +}

...

