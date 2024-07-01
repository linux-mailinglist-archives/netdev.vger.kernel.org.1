Return-Path: <netdev+bounces-108165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F2991E09C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4EB1C2162C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980915E5A2;
	Mon,  1 Jul 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsXHyhwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994315B971
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840355; cv=none; b=ALOpSOENOS0WmCxN7l3FDosMSt2nQxjcpGPWUf241nO/0xhQQLll90RMJxh63SgJEjZETtH77sDvhSdw26G/9NkbLTwtM3yLkH9F3WzTtlZaIDcZFiR9uPj1ma6wHnY9z9Hxak5BY56/cDJjWrb7KBD9YjPH/9xz5ceJYdVINaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840355; c=relaxed/simple;
	bh=mc3hoi4ZRc9S2KSPyjqkM9eKdXtPWehPqDAjzKxpdB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq3r3UIVKnVO27iGZ9TmWDeA0HKUFy+5fdeunEAnfabz2kkmKpmVKJSPUJl3+OQQxPt9bGRs3W3MAGuyugu92xq3xvdXYjMR8Yv8Ny4ZWncfXVfv187o2pOQrRlm8yyv8hZVCI5zqKa9WLmTbzltmSI5w9094VhR0KTBBY/k1V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsXHyhwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A91C2BD10;
	Mon,  1 Jul 2024 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840354;
	bh=mc3hoi4ZRc9S2KSPyjqkM9eKdXtPWehPqDAjzKxpdB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsXHyhwPl/Qap3XqrGndF/EEsfsGQExRhDbQhkHgoFtpRkgQ1K20tPEaKBlsWhLZc
	 NHCFDbEsOs+T9iN5NeiQt3PKtReFYrGhurBp+T9s6z5IKcWGY4OC2BETE/ynus2TUp
	 6eQNE/lDgzsexeJtSZLK/kaTAfNvQjp+E0h/F+wk6YtnaB5u5/k5bZGEvZvhDw7Kaz
	 GfhyxVz3AKJv2+rbsp1M9711A7RqnsNrpGjWOGcpqnotYsD2mtZkd/zBlgWIWL5ycT
	 ggsatmW/gjBxW9LXS9ho9oN/KbW9WsH7WzbHUEOo8icFePI5KPRWL8B9Q4yqhbo3lA
	 KY5a/enUk8Wqg==
Date: Mon, 1 Jul 2024 14:25:51 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 3/7] ice: Align E810T GPIO to other products
Message-ID: <20240701132551.GA17134@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627151127.284884-12-karol.kolacinski@intel.com>

On Thu, Jun 27, 2024 at 05:09:27PM +0200, Karol Kolacinski wrote:
> Instead of having separate PTP GPIO implementation for E810T, use
> existing one from all other products.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> @@ -72,242 +78,99 @@ static int ice_ptp_find_pin_idx(struct ice_pf *pf, enum ptp_pin_function func,
>  
>  	return -1;
>  }
> -

nit: I think this blank line should stay

>  /**
> - * ice_get_sma_config_e810t
> - * @hw: pointer to the hw struct
> - * @ptp_pins: pointer to the ptp_pin_desc struture
> - *
> - * Read the configuration of the SMA control logic and put it into the
> - * ptp_pin_desc structure
> + * ice_ptp_update_sma_data - update SMA pins data according to pins setup
> + * @pf: Board private structure
> + * @sma_pins: parsed SMA pins status
> + * @data: SMA data to update
>   */
> -static int
> -ice_get_sma_config_e810t(struct ice_hw *hw, struct ptp_pin_desc *ptp_pins)
> +static void ice_ptp_update_sma_data(struct ice_pf *pf, uint sma_pins[],
> +				    u8 *data)

...

