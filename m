Return-Path: <netdev+bounces-204505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0AAFAEF2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06C53AF256
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E228B3F8;
	Mon,  7 Jul 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx20lxzw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91228A72A;
	Mon,  7 Jul 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878334; cv=none; b=OSMgVZv1I6UIF7yfw5huYpEFDOCmKXnwHW/omQQ7Abi3zKNzdZDtBTsGU9AZerv+sBG2c3TX7SK4lyVWeMFaC04s25o4SdyHbwrY2TtuLWBe5uto8lCyJH6sd10UZehVprWfH6hzHijGJVqsTCnDRXTq+TDwawST1GUyp1HzzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878334; c=relaxed/simple;
	bh=6D3VXogMfnFsIdn20Y64K01AIIjUCYdlxjGOy7uCzag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDkTohVD75/FDckJzEx1d15QIOqpQcsVbLtgg19dXzJJ9/vzGHAUZOpDqicwS4r1sD5sQaPalysPVND9hwlmeF04IhX2WHgkSvldLoG75awzug1/9gCJlGGOauOZFFS+dRId//GIIgtKWi0sBge4ihOVbTJCIuvSkgf487VEFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx20lxzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459EBC4CEF6;
	Mon,  7 Jul 2025 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751878333;
	bh=6D3VXogMfnFsIdn20Y64K01AIIjUCYdlxjGOy7uCzag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sx20lxzwt5UjEitScSSJxobl6rhisXSCxYkCzyzwffVEiOIWWewPxIzdkDUTyqdXz
	 lPSnvkYmxTV0/pZkHvZnvVaXmpFL5m+R+D5TGeNDLLu+20pMXHIfyTOEiTqxjwXlj+
	 FogB183pBONm8hMbwTAwylHURi59y80aQ2WTSrdJjIcIFKMmZOM9vjwXMUs5rXZUHN
	 YbawANl7FB5qlvgh+9T5lEeTxp01blWq/4yTkpKVMc93+quKP3lOFZ53IOQYhD555A
	 NN6jNq1Qn6zmRbbhqGnkxOMS9wpD+NFOnwKgeDBJS43dD9SOwFCZ/qlJOIndnFA250
	 8AkoadxiyZRcA==
Date: Mon, 7 Jul 2025 09:52:10 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	stable@kernel.org
Subject: Re: [PATCH v1 2/2] appletalk: Fix type confusion in
 handle_ip_over_ddp
Message-ID: <20250707085210.GA89747@horms.kernel.org>
References: <20250703052837.15458-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703052837.15458-1-linma@zju.edu.cn>

On Thu, Jul 03, 2025 at 01:28:37PM +0800, Lin Ma wrote:
> This code uses "ipddp0" calling __dev_get_by_name(), believing it must
> return device created in ipddp_init() function, ignoring the fact that a
> malicious user could hijack the interface name.
> 
> Fortunately, the upstream kernel already removed the code via commit
> 85605fb694f0 ("appletalk: remove special handling code for ipddp"). This
> fix should be applied to other stable versions.
> 
> Cc: stable@kernel.org
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Thanks Lin Ma,

I agree that this code change looks good.
That the code in question has been present since git history started.
And was removed by the commit cited above, in v6.7-rc1.

Reviewed-by: Simon Horman <horms@kernel.org>


Greg,

I'm unsure how this case should be handled from a stable PoV.

...

