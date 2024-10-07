Return-Path: <netdev+bounces-132763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D6A9930E9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE04B24926
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB11D79AF;
	Mon,  7 Oct 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm+4Vpp0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A315338D;
	Mon,  7 Oct 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314307; cv=none; b=eX7CjAmlrC2KxU6qp6htHfUfYUQztEog4Whv12Usr0ApM3r/G1/kOTKeauaxiog3opUpeLpmpIhlU1bTt6q4eiKPT+r3QqfksJ6lnoo6BiwUxfJsYS4g9yBxZhx4j9KZEbwXrK2a6VVK3RsibQwEj/EibnHKkxliE7B9JSqzND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314307; c=relaxed/simple;
	bh=5Augm3AdOUC2qeYmDSEVxrrJ4lWMK5bJKrYwdruqZsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2JQT86H1RtDbnnbXhKWkNv4rFDPI5fx7wiL7nwXIDTpojDPsWKvR77sblrParpIpv0ukB1S8YNlF5w1uQB52Z9EfKfmCy5D9UwjXOHCuwkTXebKIYaGohFBADEcStouAofDGHR939uy8gN6xznT6spVZheKihi0Igq5hUdzfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm+4Vpp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE094C4CEC6;
	Mon,  7 Oct 2024 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314306;
	bh=5Augm3AdOUC2qeYmDSEVxrrJ4lWMK5bJKrYwdruqZsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tm+4Vpp0tK+un/E8/yxk1cYg2AKCvlnDUhIObhZJYHKOhKTenosXS+Swm9YrzJ3Uh
	 Bska8PcmKurZ/T0v7fmYuYE0Zeql8EofZcwcWzsh+aJIDaSQ6QBbQ8MbFLSeQ1NimA
	 7fbRG9+vJ54iRaWGLAHHlblKYdYuHddHLxk81Zd1VuUSkiS0SBULZphHDczANq0eUc
	 xR6YFrYK7pZYrAiYEORuwhl4VRUS2bYMT+1XR8ykkMgDHlFoi6EJTgUBv4QB6R9aba
	 0MSCiunhfG74yRV9S1es5r8Q2X/p7+5RpR2icF5spn2KFAT6P6W0oOVJ2Tr8dSntzx
	 fvEggA/yckNnA==
Date: Mon, 7 Oct 2024 16:18:22 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next] vmxnet3: support higher link speeds from
 vmxnet3 v9
Message-ID: <20241007151822.GF32733@kernel.org>
References: <20241004174303.5370-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004174303.5370-1-ronak.doshi@broadcom.com>

On Fri, Oct 04, 2024 at 10:43:03AM -0700, Ronak Doshi wrote:
> Until now, vmxnet3 was default reporting 10Gbps as link speed.
> Vmxnet3 v9 adds support for user to configure higher link speeds.
> User can configure the link speed via VMs advanced parameters options
> in VCenter. This speed is reported in gbps by hypervisor.
> 
> This patch adds support for vmxnet3 to report higher link speeds and
> converts it to mbps as expected by Linux stack.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>
> ---
> Changes in v1:
>   - Add a comment to explain the changes

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

...

