Return-Path: <netdev+bounces-220341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E7B457C2
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8753ADF82
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF534F494;
	Fri,  5 Sep 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZq3VoAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663734F486
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075134; cv=none; b=SWM0UlVqTQMrKcPjWgP8uqF1Jp1Ooby2q1BDcPKeRdFaX+tdiJ86Vb2iRpmuoyB6EGJv1NPHdN4UqwIAv1FmQa6KCQeXLS7vV1K9zWBypiyJXfOVDfs/o1+cM/RF6HIkKT+3BdR0NywzfNWLYf6q3OwQRLXlEzElPMLU+D0obmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075134; c=relaxed/simple;
	bh=k5NZk01dgW6yV3DnFqHfApW0WBrQ9Ru80qZ+VB3TejM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyJtPBDXVHHDtddHhKq7uTWpEAhfQXQ7e/W1fDXasTkvcSFaQ360OiVDyWVciNp4E4EB0PTha0IZaARh97VOo4EdO+jI63yNnUZdYpmHR1eVcmW8h9KUA/nCjwmgFTSqOiEZe3rDBPz926P5S853dQOBHvdZLr5hBwCZXIBpG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZq3VoAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F58C4CEF7;
	Fri,  5 Sep 2025 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757075134;
	bh=k5NZk01dgW6yV3DnFqHfApW0WBrQ9Ru80qZ+VB3TejM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZq3VoAmBmnVAfrbao+DbNHKxj4pCA84w4hEN8o/Bl3W99QBA3GlK+bPBybP6OZ9T
	 ijhj+FiX7AmN87MnYDKI9HzKOjeuU8k0XTmEDfgYwqFXYt2voOOzfZJj3sAoYV9ayi
	 +CwWyBVuKMI/XCADAvilzBq6bG5nUYEDMZPslYDW4IZc7YJ4ehUTnZXkoyz9SpuMNC
	 Ev7J2xM/oNelITsvqus5OatpRxwDPi3Nlw0E/q691WL092B6oVAwk7Cj4iAyQp3Bnx
	 gFg6aTGE92ceZlk4fgMZ+YiQ1uwO4uEP9yjihOxuKIKShp044JUzZ24OiX24xk0EZZ
	 coZZItkD1qeag==
Date: Fri, 5 Sep 2025 13:25:30 +0100
From: Simon Horman <horms@kernel.org>
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com,
	jiri@resnulli.us, netdev@vger.kernel.org, jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next,v3,2/2] i40e: support generic devlink param
 "max_mac_per_vf"
Message-ID: <20250905122530.GB553991@horms.kernel.org>
References: <20250903214305.57724-1-mheib@redhat.com>
 <20250903214305.57724-2-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903214305.57724-2-mheib@redhat.com>

On Thu, Sep 04, 2025 at 12:43:05AM +0300, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> Currently the i40e driver enforces its own internally calculated per-VF MAC
> filter limit, derived from the number of allocated VFs and available
> hardware resources. This limit is not configurable by the administrator,
> which makes it difficult to control how many MAC addresses each VF may
> use.
> 
> This patch adds support for the new generic devlink runtime parameter
> "max_mac_per_vf" which provides administrators with a way to cap the
> number of MAC addresses a VF can use:
> 
> - When the parameter is set to 0 (default), the driver continues to use
>   its internally calculated limit.
> 
> - When set to a non-zero value, the driver applies this value as a strict
>   cap for VFs, overriding the internal calculation.
> 
> Important notes:
> 
> - The configured value is a theoretical maximum. Hardware limits may
>   still prevent additional MAC addresses from being added, even if the
>   parameter allows it.
> 
> - Since MAC filters are a shared hardware resource across all VFs,
>   setting a high value may cause resource contention and starve other
>   VFs.
> 
> - This change gives administrators predictable and flexible control over
>   VF resource allocation, while still respecting hardware limitations.
> 
> - Previous discussion about this change:
>   https://lore.kernel.org/netdev/20250805134042.2604897-2-dhill@redhat.com
>   https://lore.kernel.org/netdev/20250823094952.182181-1-mheib@redhat.com
> 
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
>  Documentation/networking/devlink/i40e.rst     | 32 +++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>  .../net/ethernet/intel/i40e/i40e_devlink.c    | 48 ++++++++++++++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 31 ++++++++----
>  4 files changed, 105 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
> index d3cb5bb5197e..524524fdd3de 100644
> --- a/Documentation/networking/devlink/i40e.rst
> +++ b/Documentation/networking/devlink/i40e.rst
> @@ -7,6 +7,38 @@ i40e devlink support
>  This document describes the devlink features implemented by the ``i40e``
>  device driver.
>  
> +Parameters
> +==========
> +
> +.. list-table:: Generic parameters implemented
> +    :widths: 5 5 90
> +
> +    * - Name
> +      - Mode
> +      - Notes
> +    * - ``max_mac_per_vf``
> +      - runtime
> +      - Controls the maximum number of MAC addresses a VF can use
> +        on i40e devices.
> +
> +        By default (``0``), the driver enforces its internally calculated per-VF
> +        MAC filter limit, which is based on the number of allocated VFS.
> +
> +        If set to a non-zero value, this parameter acts as a strict cap:
> +        the driver will use the user-provided value instead of its internal
> +        calculation.
> +
> +        **Important notes:**
> +        - MAC filters are a **shared hardware resource** across all VFs.

Sorry for not noticing this before sending my previous response.

make htmldocs is unhappy about the line above. Could you look into it?

.../i40e.rst:33: ERROR: Unexpected indentation. [docutils]

> +          Setting a high value may cause other VFs to be starved of filters.
> +
> +        - This value is a **theoretical maximum**. The hardware may return
> +          errors when its absolute limit is reached, regardless of the value
> +          set here.
> +
> +        The default value is ``0`` (internal calculation is used).
> +
> +

...

