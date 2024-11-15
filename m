Return-Path: <netdev+bounces-145243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75979CDE86
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5547EB21AF8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7901BD014;
	Fri, 15 Nov 2024 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtkoF3Iu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDF1BD00C
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674580; cv=none; b=L59TcWnkD0T1kRRIAvMWugyc6ZgOT8edEk1CW0vONEKuGVCfTB6aE+7aF0oneKZNoGfizVLgn0qxo4EFNQN0OO1MX+s7VAuQDCKNbvs1PAmxlcO06Ad+SCRjhTkvnaPTvhgSfnXMC/GVn3jHTkb1LzG9pJ8f/SU3x5j0WJUYi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674580; c=relaxed/simple;
	bh=cjPI+Yb7+CQvXGS2BSpGx8kfZLNhaUmBB0BYf0BuI9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMHbCCeZguSlyh7dyUe1MDdbS5CtbBC+Yy7kWh0YQmA9GM1P4BMCmqyMN1pMek68uNTUoJN3eixdaoL8NtDYB9QZ5t+mU6tEWL4EzKdAL5QXF0grkVoC2+289v7oRPlZFgDzaJc4so4WtVkG630oKbPrSfylzuz1Pxh+9VizaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtkoF3Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021F9C4CED4;
	Fri, 15 Nov 2024 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731674580;
	bh=cjPI+Yb7+CQvXGS2BSpGx8kfZLNhaUmBB0BYf0BuI9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtkoF3Iu6eKIc4zwwIztmeXdslDZ+hEDEXcUjXKi/47iWo5ooWSUrfL4mzIMG76R2
	 QvtYxtrWnAoWA4exKBCJFufMohKgeruF1E2+RovCkTTuo8idNDiCp/LxTRFpWMk1tH
	 mGydlIBrQZ0E769K1hcMwWpfBbYK6uH83WEsLeaCslb4qVGFeTFnQlovG9GUwf3m4g
	 1rFr3ti/S2/ZYr5lUQjS3RV1HfQlXC6IQVS9AAukns2T0vyr8Qz7nHDT/OoNUaA1cP
	 ocAqDIoEoVdb+O0fUzdO5cFc4B2HRkWS2IuLkiNq7R8Q/WTicaitn7Ut2QFpYKFngm
	 pEaRbE4P6uvXg==
Date: Fri, 15 Nov 2024 12:42:56 +0000
From: Simon Horman <horms@kernel.org>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-net 02/10] virtchnl: add PTP virtchnl definitions
Message-ID: <20241115124256.GN1062410@kernel.org>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-3-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154616.2493297-3-milena.olech@intel.com>

On Wed, Nov 13, 2024 at 04:46:11PM +0100, Milena Olech wrote:
> PTP capabilities are negotiated using virtchnl commands. There are two
> available modes of the PTP support: direct and mailbox. When the direct
> access to PTP resources is negotiated, virtchnl messages returns a set
> of registers that allow read/write directly. When the mailbox access to
> PTP resources is negotiated, virtchnl messages are used to access
> PTP clock and to read the timestamp values.
> 
> Virtchnl API covers both modes and exposes a set of PTP capabilities.
> 
> Using virtchnl API, the driver recognizes also HW abilities - maximum
> adjustment of the clock and the basic increment value.
> 
> Additionally, API allows to configure the secondary mailbox, dedicated
> exclusively for PTP purposes.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 302 ++++++++++++++++++++
>  1 file changed, 302 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h

...

> +/**
> + * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
> + *					  VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME.
> + * @dev_time_ns: Device time value expressed in nanoseconds to set
> + *
> + * PF/VF sends this message to set the time of the main timer.
> + */
> +struct virtchnl2_ptp_set_dev_clk_time {
> +	__le64 dev_time_ns;
> +};
> +VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_set_dev_clk_time);
> +
> +/**
> + * struct virtchnl2_ptp_set_dev_clk_time: Associated with message
> + *					  VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE.

nit: struct virtchnl2_ptp_adj_dev_clk_fine:

Flagged by ./scripts/kernel-doc -none

> + * @incval: Source timer increment value per clock cycle
> + *
> + * PF/VF sends this message to adjust the frequency of the main timer by the
> + * indicated scaled ppm.
> + */
> +struct virtchnl2_ptp_adj_dev_clk_fine {
> +	__le64 incval;
> +};
> +VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_ptp_adj_dev_clk_fine);

...

