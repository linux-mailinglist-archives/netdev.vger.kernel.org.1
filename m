Return-Path: <netdev+bounces-172005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5663EA4FD65
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C23A7AA1B6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D111FECD1;
	Wed,  5 Mar 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MayCLFOS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02381F4172
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173432; cv=none; b=RG0ym8lBx8iYdoLdVYNeVFDcZYxtu6D2PjKC3zjGEXFI8sqoH8yXnVeVYpqKXARUf1spK9nx7PIBHlxHMaFyBFZ3qRz3g0RWxILAiUUim+u8TXvLMSWFpCQpZEDHmJcC6CC7DvSrxrbsQhdR2Y9XJ+qDuKDDdXwy2/07NHyvRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173432; c=relaxed/simple;
	bh=5+kOicrbwcea7mesoaCgGQQgtJv+hnrlnQMqZcmtj2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWCZp5ehDnIsOQ5ONt9B+UDR4Q/g2ypTz7Fj5awX4fsBRgmjdpcU6Nmrt4PytKjP+DvyvaO/OaddwMFO2fE+crEQOHF9sSjwsd1DzTBlbqTVy6R8XsaiQyp0AvjzL1UmUTB1LJ8BJLsRGVwa/uwKI0lqb+6lvj1+PbNNQdoAP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MayCLFOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACECC4CEE8;
	Wed,  5 Mar 2025 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741173431;
	bh=5+kOicrbwcea7mesoaCgGQQgtJv+hnrlnQMqZcmtj2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MayCLFOS1zzN0AcZb4EzzvHkM3WpUKM/XEFc/xez/p5GT5b+6DU0kMvjd9BrXswWr
	 yD48z4nUTD4JHUIjP/lPRcCzJO/tT2v9KB84fa2hFrG5b6ZGCYl6F+wWaVktq4afqD
	 7QKw3bdgMt7BtSO+N5+4mMaS0q0lEic7/v7Qo8RkPc/K/EwbWoejI0JptxZPC/Oo1W
	 aYYyQT2a/adJzmxpoxAcnOSj8nloc/dFwT4u91OIbjWldXMA8YMgY1w1dZOgLj3/Wn
	 c9c8VSvFMU0NUrrH6c3NWj12OyhLM036Vm8h4WYvKuiBjvZWL02pqi+9xykujKnX/5
	 wDqBd40M98CvQ==
Date: Wed, 5 Mar 2025 11:17:07 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, andrew@lunn.ch, pmenzel@molgen.mpg.de,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 4/4] ixgbe: add E610 .set_phys_id() callback
 implementation
Message-ID: <20250305111707.GM3666230@kernel.org>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
 <20250303120630.226353-5-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303120630.226353-5-jedrzej.jagielski@intel.com>

On Mon, Mar 03, 2025 at 01:06:30PM +0100, Jedrzej Jagielski wrote:
> Legacy implementation of .set_phys_id() ethtool callback is not
> applicable for E610 device.
> 
> Add new implementation which uses 0x06E9 command by calling
> ixgbe_aci_set_port_id_led().
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v3: move the #defines related to ixgbe_aci_cmd_set_port_id_led out of the
> struct definition

Reviewed-by: Simon Horman <horms@kernel.org>


