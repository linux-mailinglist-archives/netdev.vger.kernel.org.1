Return-Path: <netdev+bounces-172370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280DA546AB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24323B23F9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A07209F57;
	Thu,  6 Mar 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZIRR3b2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD82209F38
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254078; cv=none; b=nXvB1sSE5dqt425EkVvmOV/lKS/Lfa7Iv/uXCpX3b8WeT8Rlv8nGPTUR2HBf6SOk8GQuw80pY5jIZH6X7r8mYWUk8mHfHJWYho4aH5NsT4jinxcyF5lEL9ovKjQQB11J3EwlVTuLW2AfUeG6KZ/iVEzUNMJr7qOwXjc2c+60SCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254078; c=relaxed/simple;
	bh=nrzVgQGTRl5rsEbFS3DitQd0cgTpWwwFO4ICiZBmMWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKPN3Mi89aQzoZSNAEHK1VEi6Tk8CaGC3K/sw1X2oJX5TN86AQ/Fil/eh1Ja03Mgkq9jIYf/sX6299MpYbai520xvKwLjYto0Xshc3Gr9aW5qSVfVsy6b/K/eFjYmsSWOpAvNurjKDDZfFduXDQSwiBoZmZCmo6JKMYNPwUpzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZIRR3b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E45C4CEE0;
	Thu,  6 Mar 2025 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254078;
	bh=nrzVgQGTRl5rsEbFS3DitQd0cgTpWwwFO4ICiZBmMWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZIRR3b2MC/O4LBJ/ksJ0RAafGu4ZGA41T8Uq/NZOM+z6W3/RPM9Jebk/zXQw8q6B
	 dKVHRc07Omvqjfag7QvBFJ1A3nOreKTczKBZF0+6CUP8bEHi5UnUinxF3z87om7cuS
	 yPkW4/5HDrl65AKnKSigKvAFZsQaVtCkLHc32sDJMujT7PcYYBgwLFJyfhUZkuomwf
	 Nzv6++nu6yVkdfR5woa0pd7N9Ea3SbnmHjsmltEFZ212tpzuG5tfR9Ku55gxdqKdo7
	 wzqrYOQQxcm7/sK68M26b1bZW5Vb0gem8xH31of0xkKeIs3E1W0qPsWLQ/5Jw3b9iS
	 Jn9Lrers1G0qw==
Date: Thu, 6 Mar 2025 09:41:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, jiri@nvidia.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: Re: [PATCH iwl-next v5 12/15] ixgbe: add support for devlink reload
Message-ID: <20250306093854.GQ3666230@kernel.org>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
 <20250221115116.169158-13-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221115116.169158-13-jedrzej.jagielski@intel.com>

On Fri, Feb 21, 2025 at 12:51:13PM +0100, Jedrzej Jagielski wrote:
> The E610 adapters contain an embedded chip with firmware which can be
> updated using devlink flash. The firmware which runs on this chip is
> referred to as the Embedded Management Processor firmware (EMP
> firmware).
> 
> Activating the new firmware image currently requires that the system be
> rebooted. This is not ideal as rebooting the system can cause unwanted
> downtime.
> 
> The EMP firmware itself can be reloaded by issuing a special update
> to the device called an Embedded Management Processor reset (EMP
> reset). This reset causes the device to reset and reload the EMP
> firmware.
> 
> Implement support for devlink reload with the "fw_activate" flag. This
> allows user space to request the firmware be activated immediately.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
> index 41aedf4b8017..e5fef951c6f5 100644
> --- a/Documentation/networking/devlink/ixgbe.rst
> +++ b/Documentation/networking/devlink/ixgbe.rst
> @@ -88,3 +88,18 @@ combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
>         and device serial number. It is expected that this combination be used with an
>         image customized for the specific device.
>  
> +Reload
> +======
> +
> +The ``ixgbe`` driver supports activating new firmware after a flash update
> +using ``DEVLINK_CMD_RELOAD`` with the ``DEVLINK_RELOAD_ACTION_FW_ACTIVATE``
> +action.
> +
> +.. code:: shell
> +    $ devlink dev reload pci/0000:01:00.0 reload action fw_activate
> +The new firmware is activated by issuing a device specific Embedded
> +Management Processor reset which requests the device to reset and reload the
> +EMP firmware image.
> +
> +The driver does not currently support reloading the driver via
> +``DEVLINK_RELOAD_ACTION_DRIVER_REINIT``.

Hi Jedrzej, all,

This is not a proper review. And I didn't look into this, but make htmldocs
complains that:

 .../ixgbe.rst:98: ERROR: Error in "code" directive:
 maximum 1 argument(s) allowed, 9 supplied.
 
 .. code:: shell
     $ devlink dev reload pci/0000:01:00.0 reload action fw_activate

...

