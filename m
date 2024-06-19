Return-Path: <netdev+bounces-104976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C6B90F596
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53B8B232FF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC048156661;
	Wed, 19 Jun 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKpPUrTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EC55884;
	Wed, 19 Jun 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819959; cv=none; b=ZcN33kTc2Bn0MTSRcoehOwtl/eHn2TYs9rHnLDYURRPgi8ikgRuYe9NyRAsn2UWoY8xiCxI/8Q8SENUe8uzdfASMEHGHkgn5YuTsZ5nn8CMK+AFXkvZFg26liISQ1BXhOH9UqhHCzr9lqAKnlR3ObVOxN93rvOopCOFKRowpcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819959; c=relaxed/simple;
	bh=wu5doY2yM+kAhRxAhoruupZJiydYR2zkCHoJU+MPAAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA6d8Z66CnQmnyVcp2xnAPsuE+A2Rnd4aDXATdHc/NmEafQEKhVmPD4oNeh06DhP9rpa53E+qOQwXcGf2xAELUtGWlKFZMbbgawaGl84kVAy0yQfppZt6GTbJ3wUSjt9bHuSoDN+GcdmvMRRI2nIfYL1IkyjSBkf16uKXsiSQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKpPUrTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E2FC2BBFC;
	Wed, 19 Jun 2024 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819959;
	bh=wu5doY2yM+kAhRxAhoruupZJiydYR2zkCHoJU+MPAAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKpPUrTv4I6wjxRkHfq+6Wll38KVAfUMb7u3eB63FWxTBgwHkvxnO7hZgsJrxi14X
	 sE7SFz0I190E8SFOfIdr0TExH9jqrwKJCmiNmuuacuLRCtznrh1J40FJRaj+F0TZSp
	 zLjiKmqjfg0zn4mfB0Y6ccbljRBFWrvyVrIjbTMkP6xnYytvng9VMJYlMIS0TcFFcS
	 fp6GWOp+39Q6aQQRUy7zxmC6VRklsHLqslFg+fIWojKwEdUnMsw3O8JZRDhiJT6yvV
	 rBHFO8nKPRKiyfStqMv9xzWJFCEA3nVCRV1WAQXjpg2HsKPLc2ELFuuJIBp1HWWp9l
	 pduJDKMjm4TMg==
Date: Wed, 19 Jun 2024 18:59:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] enic: add ethtool get_channel support
Message-ID: <20240619175915.GQ690967@kernel.org>
References: <20240618160146.3900470-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618160146.3900470-1-jon@nutanix.com>

On Tue, Jun 18, 2024 at 09:01:46AM -0700, Jon Kohler wrote:
> Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
> support to get the current channel configuration.

This is nice :)

> Note that the driver does not support dynamically changing queue
> configuration, so .set_channel is intentionally unused. Instead, users
> should use Cisco's hardware management tools (UCSM/IMC) to modify
> virtual interface card configuration out of band.

That is a shame :(

> Signed-off-by: Jon Kohler <jon@nutanix.com>

Sad face aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

