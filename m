Return-Path: <netdev+bounces-192694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A085AC0D51
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEBB1BC4929
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F628C03A;
	Thu, 22 May 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZvYdCO9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53528C01E;
	Thu, 22 May 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921932; cv=none; b=ToE/nnsQxcjHdhT3RVWkv2GZUuzcHoUg4Gzx8TUtr3dHKLamF0b2CFVI/7vENCyy+zbne02adBWea2WPROj2DzSFVdLhCvpq65QFU08rhGAN8J0nwrsZ8gauygLpK1CrxwVUg2vtYyP98xP8xTzEZFz4zgdOHCcv3sJSvswHZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921932; c=relaxed/simple;
	bh=6Asv8ogK2+lf9UneA4gPVYzxO8G2cewAGm2bqeLWYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIrE2UsqMxeUkob+KdKEZpTmM2Br2uEgwqQYz+s6WMCzYDHt2SzrAJ8Edm4LHDUxNhmP8ZYNF89Q37bRBUbdCXJKAoMSyBsZyUc+Ozo/1GnIBL7Nh1YuFc1pjlqfo7TibZIXbS8s51lDOM1PLvSYQA6U1jv/6IQ4LXA1Wb/RH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZvYdCO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A97C4CEEB;
	Thu, 22 May 2025 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921931;
	bh=6Asv8ogK2+lf9UneA4gPVYzxO8G2cewAGm2bqeLWYeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZvYdCO9dkHdFSHJhOhFtRT6hRtEUw2+/+U+hSDqP62MqPd6dDWJzgX1q+idg1uZ0
	 to7fnXu9g+kR1kXIRseJWUPSaPNVix9K+5nq3C2Mul2RE+1XuWYvUpbkSyMLg1xhMF
	 WQeblJoogKkLmI1hHXDzGIlQXxpSkW0GPFPCWcLqXoH4s2+kPjZidfF180dsZsFAsp
	 V4FvGsCD/eYtY92hsuOpAxKDmE0WjhBZaAf/GTfttDtmtVAmFrSRlMPmfkTnNdflcE
	 bzs6QBmu7DmoAXKvNEBqMbL7YOAR5F6jyKD6qW0PlQfUEAubRiArqy0cuB3MCZIm4F
	 fjPu9uaT5PxvA==
Date: Thu, 22 May 2025 14:52:07 +0100
From: Simon Horman <horms@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: sysfs: Implement is_visible for
 phys_(port_id, port_name, switch_id)
Message-ID: <20250522135207.GH365796@horms.kernel.org>
References: <20250521140824.3523-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521140824.3523-1-yajun.deng@linux.dev>

On Wed, May 21, 2025 at 10:08:24PM +0800, Yajun Deng wrote:
> phys_port_id_show, phys_port_name_show and phys_switch_id_show would
> return -EOPNOTSUPP if the netdev didn't implement the corresponding
> method.
> 
> There is no point in creating these files if they are unsupported.
> 
> Put these attributes in netdev_phys_group and implement the is_visible
> method. make phys_(port_id, port_name, switch_id) invisible if the netdev
> dosen't implement the corresponding method.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v2: Remove worthless comments
> v1: https://lore.kernel.org/all/20250515130205.3274-1-yajun.deng@linux.dev/

Reviewed-by: Simon Horman <horms@kernel.org>

FWIIW, I had the same thought that Jakub related in his review of v1.

 "I'm slightly worried some user space depends on the files existing,
  but maybe ENOENT vs EOPNOTSUPP doesn't make a big difference.|

...


