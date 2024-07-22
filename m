Return-Path: <netdev+bounces-112434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54722939107
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9F28235B
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5616DC17;
	Mon, 22 Jul 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnNS2fvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603AC8C7
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660023; cv=none; b=p5DVTyXw3D+qVaaStBmcURzBQyrXQ3SXI3C+f4m0Kw8I6ObyHww2NzFzRQaMnsg21dsaT+wzO5c5AxOVM9D2FXHciazUYHi8o0oWc0eKHvAZmp+3H8BI1yywPnqqocFEzJWJ0oIriZlcrNBsqy4VMT5qXadPtiRiPhHj9xm5gkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660023; c=relaxed/simple;
	bh=DBrfqFXsCePi5RkuOb5Ae8jJax5RVndoMZBKRM8bsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzKy7QRQFaHtwpl7PYNMnNPiSMk4mgr4kLe55ciiF5CMapV3v8UN0tKrj41b4Y/i8838giJub7sVIGVRbQ4pQmPaTVPcTB1xkbKvixJ/TRRau0kfJh6I02sqrpwz4QsdPsfG6a6nzyaOb0KaTJmSZ/CclupUAzzk8ktUNcfcBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnNS2fvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55E9C4AF0B;
	Mon, 22 Jul 2024 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660023;
	bh=DBrfqFXsCePi5RkuOb5Ae8jJax5RVndoMZBKRM8bsAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnNS2fvyZzKMBRw5Itw8QkII/Y4+fzFRB2Do5jGgdx7PFCUOoYJtlkr8GlMHGmTsn
	 uRtnccKm/ZlKwoYQNTsfvjey4AvPxCZ4QeL3qIBkVrKw84oN3j+3+hPC4VQTw2BG/y
	 IR2o+iW/GQpK4C2n05gH+QY/mhKw0oMtDTQSFlgDmqgLjpg/SS1t0vk57ofiaq9rbf
	 Zt1697dcgIx5Ak41pYgLUk4YSN9DtRlnx3yt6Ef0/L2epqr6/j+WptJgNGy78cTUlL
	 7xFEZDTK367yK7p9DeaC4mzMkUBVHYl7GdIwR7iPmkXkWlHowLRKTPQZDQWmoQccVD
	 RA5pSRk9FqDeg==
Date: Mon, 22 Jul 2024 15:53:39 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 03/13] ice: add debugging functions for the
 parser sections
Message-ID: <20240722145339.GG715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-4-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-4-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:05PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add debug for all parser sections.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Hi Jungfeng, Ahmed, all.

I am wondering if a mechanism other than writing to the system log
was considered for this debugging information, e.g. debugfs.


