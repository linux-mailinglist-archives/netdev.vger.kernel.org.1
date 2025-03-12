Return-Path: <netdev+bounces-174244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60710A5DF85
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA3A3A8868
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1A723536B;
	Wed, 12 Mar 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUuz9RDz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DC1553AA
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791337; cv=none; b=OIV8fFUd6SAtZ9q3ZMKi8HD8ZB3Eycxsx0HH+gcL2pVs6eYYG1R98OzsXX/mSSkCu7ouo4hhYbI8fg1Ylr201B1T6VKXW/kTt7l/2YPPaYEGDCvcjjbOZDcyJCSOStRfhvr/8bV4aZioiLzSGExa79fLXxWlrq5xs9O/pJFpKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791337; c=relaxed/simple;
	bh=ttMGOyKcGN5/IMeqSBa9LzkbTqTyW9zXdt/4cUmR9is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLzY2ijGb5NP8RLXzvDfyTRxjBnymkKKPwxZTdPsDX237S8mMBzxr8FbIk55G0yKki5jlGAg2mLyBLjZ9sBmQDFEmZJaiYFCq55zCGaAJRIf9pSx9ueUm8kRZSMOZcwO/T9g6WaMjfWBcWUTwWO60s4DrsEOYcAk1sFubyUUA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUuz9RDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF44BC4CEDD;
	Wed, 12 Mar 2025 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741791337;
	bh=ttMGOyKcGN5/IMeqSBa9LzkbTqTyW9zXdt/4cUmR9is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUuz9RDzKpjeMsqTIxF2lcL0EUz6sRwHgaAeRazRJhNvzFwSdx4G793MIcCS5Icre
	 EjShOgTkyt5qjyH6II+ojwLoHLvTq0hasMslgL/aPb+aNZZcafDGCOXP+mgDI7wYRb
	 sYFzUfZZk/eKN3bxCrtscMyKI0+X8VmL2D9q0z19LA7EEMSgaFtojohI07YXF6rg3w
	 EW/CKbs00/b9iZKfH4hvloxB1cockssjcydWolgVpr5y/uYWGyZNl0n0Xdztl8zw5d
	 ot9jDtjJKroVZkqf2Pdq14bNb7R4mNWKpApcbKqOmUkguI08rw3n4mu8JbSWxW2mUS
	 l9V2orF0q5S+w==
Date: Wed, 12 Mar 2025 15:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Bharath R <bharath.r@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: Re: [PATCH iwl-next v7 11/15] ixgbe: add device flash update via
 devlink
Message-ID: <20250312145530.GU4159220@kernel.org>
References: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
 <20250312125843.347191-12-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312125843.347191-12-jedrzej.jagielski@intel.com>

On Wed, Mar 12, 2025 at 01:58:39PM +0100, Jedrzej Jagielski wrote:

...

> diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
> index a41073a62776..41aedf4b8017 100644
> --- a/Documentation/networking/devlink/ixgbe.rst
> +++ b/Documentation/networking/devlink/ixgbe.rst
> @@ -64,3 +64,27 @@ The ``ixgbe`` driver reports the following versions
>        - running
>        - 0xee16ced7
>        - The first 4 bytes of the hash of the netlist module contents.
> +
> +Flash Update
> +============
> +The ``ixgbe`` driver implements support for flash update using the
> +``devlink-flash`` interface. It supports updating the device flash using a
> +combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
> +``fw.netlist`` components.
> +.. list-table:: List of supported overwrite modes
> +   :widths: 5 95

Hi Jedrzej,

make htmldocs flags two warnings, which I believe can be resolved by
adding a blank line here.

  .../ixgbe.rst:75: ERROR: Unexpected indentation.
  .../ixgbe.rst:76: WARNING: Field list ends without a blank line; unexpected unindent.

> +   * - Bits
> +     - Behavior
> +   * - ``DEVLINK_FLASH_OVERWRITE_SETTINGS``
> +     - Do not preserve settings stored in the flash components being
> +       updated. This includes overwriting the port configuration that
> +       determines the number of physical functions the device will
> +       initialize with.
> +   * - ``DEVLINK_FLASH_OVERWRITE_SETTINGS`` and ``DEVLINK_FLASH_OVERWRITE_IDENTIFIERS``
> +     - Do not preserve either settings or identifiers. Overwrite everything
> +       in the flash with the contents from the provided image, without
> +       performing any preservation. This includes overwriting device
> +       identifying fields such as the MAC address, Vital product Data (VPD) area,
> +       and device serial number. It is expected that this combination be used with an
> +       image customized for the specific device.
> +

...

