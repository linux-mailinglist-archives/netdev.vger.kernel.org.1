Return-Path: <netdev+bounces-77514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E18720D6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3A8B26AF0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF685642;
	Tue,  5 Mar 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKM2NUpQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F505102B;
	Tue,  5 Mar 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646762; cv=none; b=oL/CyMx1dVbFsPwKSfDS1iG3Bsx+nU5NyyBIr0FsD6/wCWP7+G65iFyS2vkDwZ4MQFKv1/sKxHlqhF8ymspeZfh2dGpa1BTQgsrQ0CgF+1xCgh1Rw73B9A7kaCcnoqQc6Ua8Lj3FmmEgYHZ7bHo4G73bozk/PE9XyBqz4kFglpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646762; c=relaxed/simple;
	bh=b/75Y8D1XYqdu9zUfIy3JxL+23E6PphPsfEVHE/48rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrX++itCdEZZQFKMADUi8AIPuxzkVZn1aV4Dvm2In6GsYnVG+DK6kfuf68VC1YN4bucX2IytFoqj7NcR3JzuhY6h47LeeyJRuGkNCF8C818U4eeEeGxQ9Hk67wYqcmG97BljtE66/86n7RVhGY9GS3KSjOUt+gJlVlCVi9AdaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKM2NUpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36561C43390;
	Tue,  5 Mar 2024 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709646762;
	bh=b/75Y8D1XYqdu9zUfIy3JxL+23E6PphPsfEVHE/48rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKM2NUpQgft7AsZWuxoIMvwBDZF1xTbBQOEactvkwuefEM+OwKD3DPTap+WoTWa8B
	 cXzNKMYEMeRrGqtSJSrpA12US4xNQsPmhLoKTmSSR9d/qcyrVOjLIBDUT0oIoD1MaD
	 +0xpsat3ZTKYp1Hea9/53t67yN1/cl+725l5d4GENhJi4XqjF1/yHrXcTQSpneOFxP
	 dhu35qRTMR+INbOyalfx3BSapim4tUggNw1gYYRIa8GZktYuhwSWCQAbgbJBCF5D2x
	 J7Q7FF5wiEuseAavYJ+olkgBbq87qU4VBZAurt93FRw1OtIKxaaoKE5+Yvi0ZjdCak
	 kHTMiI8mQ5Avw==
Date: Tue, 5 Mar 2024 13:52:38 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH net-next] net: macsec: Leverage core stats allocator
Message-ID: <20240305135238.GG2357@kernel.org>
References: <20240305113728.1974944-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305113728.1974944-1-leitao@debian.org>

On Tue, Mar 05, 2024 at 03:37:27AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the macsec driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


