Return-Path: <netdev+bounces-79086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B8A877C89
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A534282275
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C017576;
	Mon, 11 Mar 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyKy6UFX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E21755B
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148898; cv=none; b=L97ZMmjTK3byVuL4D83rQDQ5x2L4kK0lQBpm7UUxBNryQCMoKSnEAlHvbsBd/AG7Ro95Be5vSsRhBLJnwhydA2GHGG8qEUKaDnmXeW4Naly2hMNb69VeNRtpM+VzkWkZQML6AEDQL47XTut4mCGNYOzjUdSKZ0diOTQ0xRsdhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148898; c=relaxed/simple;
	bh=YVJOlQOojPODBcew3KZ9YmexhpJGIyFI7WC9zEWcJKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO+Kp2XZy6AwMoAnYhMTADW3+Drz60F2SWIepo2diRtIkOmKkWQQ37Mxv4H4vx3imZ2jxeNipKu6haIk+/lIb0NVPI3ywDDKbJbnE28NfuyYxWefxTWf5zrAF0sK3xvgjZ07gKVwHNTAnVHBWpcXEMhW6IMeAZmjUSeBfZUZaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyKy6UFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B327FC433F1;
	Mon, 11 Mar 2024 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148898;
	bh=YVJOlQOojPODBcew3KZ9YmexhpJGIyFI7WC9zEWcJKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyKy6UFXJtynmo+4VUt07TmQRPrtBSXDbwcA8IiEe9bD3+TCK9tFPdNUVBT3wdVPX
	 KF1mR05eoi/xA7gCn08vEKlPSXxvM3v36e6thWQJS860HwPO14aWCTC6O8+yyx6tbh
	 wBu1FZr6LDCqhQuW6TUQZTFxYwyx/lYrP5fndpTWbBSOTs9oApPWk7kHqpGZ9vcUyn
	 k+WbbAt3hKOU2hH7J1sNxUcH+jBPHv5Qkpb4Vdg4fTeYho5ISHX9f3kUQuIhvcc/7s
	 7gehzM0J+NfSn2Co3ucXWbhIa2VHPR+cl5FXWERUnXYS3qG4wwYs94Yd4EzKGt+Mrm
	 YOC15Ew/pjPEA==
Date: Mon, 11 Mar 2024 09:21:32 +0000
From: Simon Horman <horms@kernel.org>
To: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [iwl-next v1] ice: Remove ndo_get_phys_port_name
Message-ID: <20240311092132.GE24043@kernel.org>
References: <20240308105842.141723-1-dariusz.aftanski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308105842.141723-1-dariusz.aftanski@linux.intel.com>

On Fri, Mar 08, 2024 at 11:58:42AM +0100, Dariusz Aftanski wrote:
> ndo_get_phys_port_name is never actually used, as in switchdev
> devklink is always being created.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

