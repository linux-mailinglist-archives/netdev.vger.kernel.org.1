Return-Path: <netdev+bounces-24417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE477021A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83361C2182A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D2C148;
	Fri,  4 Aug 2023 13:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121DA929
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A74C433C7;
	Fri,  4 Aug 2023 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691156671;
	bh=uDkY58UkthYs6rYU1ibKDJwSFeKpnh9PwS5wusjzbl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdQ1XsdSCjR9lRj1/dZNLcwM/cNvf+CHqSCjkzrcsd8iUDsViB6xS2sIT6oQ6Qdjw
	 gOCjXDXtskKzE2+fQbOJq0SUx+cpDt/lVHWKbk3tUQedlGl1dOnQ+fvTLOPY1n/Fzq
	 VOTi8N3eD1JcyuvZjlP4toGCsFn7QtS9jMkwVcEZD1XNO17ajGGvFTsOxsKrgQFI45
	 RlZM7qCFIyF3PDGvRwC2+wL20hWVMxe5Y/erC7R7PVGLhz8GHG1/hm4ya0B9BShQrm
	 Y6Ab5AsStXhdmfJeV7AkKI+euN4ohI1QBHlgC2olSisU9AIVHLgU2fwDC1Wvf+mtpi
	 qQvVqQcONICxA==
Date: Fri, 4 Aug 2023 15:44:26 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com
Subject: Re: [PATCH net-next 0/7] sfc: basic conntrack offload
Message-ID: <ZM0AurjKOt8q0ezk@kernel.org>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691063675.git.ecree.xilinx@gmail.com>

On Thu, Aug 03, 2023 at 12:56:16PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Support offloading tracked connections and matching against them in
>  TC chains on the PF and on representors.
> Later patch serieses will add NAT and conntrack-on-tunnel-netdevs;
>  keep it simple for now.

Hi Ed,

I did provide a minr nit on patch 7/7, in response to that patch,
but overall this patchset looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>

