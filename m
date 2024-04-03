Return-Path: <netdev+bounces-84443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A214896F05
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85A2282BD0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86D4DA13;
	Wed,  3 Apr 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWdbbgnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B756241E2
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148048; cv=none; b=hpKw3urJ0kVD23i88lNXo4A4KCootFNO/rPkvJdUfWHN3zMNAMdnQ8LUzQG9D4/bDXG90NOkCQ1VUH+P1tMJ6aVrafgIxDaEhy0tOmh6a9pdcPSEh5cM8sWTIZ5ehjs4qC8HFBLmlJqmQzOd9BkJEdI+6M6nTSHUll8Ly+c+wDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148048; c=relaxed/simple;
	bh=UVbyXuODRjd0a08vh+x4Hs00396vcl3tWp9xsDzGNm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/LDRGzZMWG2Vi7/6jmttCPB5Z0DSYN1tq8edJHCVGeG/2LO3m2ZlE6lUfr3+UNrHsgHjsG+kI1jzGTPI4jPfUM+bEvYb0f3GUss7iTpXLiLT90OrJicwve9282gVM+j1udcdLF0LElg5wi7r1Otx0H55EcMwK1Fby9qkxlty5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWdbbgnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B32C433C7;
	Wed,  3 Apr 2024 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712148048;
	bh=UVbyXuODRjd0a08vh+x4Hs00396vcl3tWp9xsDzGNm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWdbbgnNRl8EB126hrz7STXp+gGefFgshZn4z3Yvg//OnrU0HM8bIM0g/zPc9hN61
	 rOmmLFWDNPaI01FLqg8uyjkBm2r/BuK+jRIdbDQKHJkhz4tKy62PsdhxHFpif9Ko/y
	 IZL3I3SbwnChI2PiVn2LVvkfDZUp79fZC+MHL5U3/LvmlfYJjdadKKzVmyTVRGYe+M
	 KglI1JeRsSH8UmEDpubgQ9TwotunGmM/WclcaN0tnbcz79r6h3+OjCY/aUgUrY/oja
	 c/1QSyJVZCfigLAq9NuBHkliS8rRKVRtmB6+NfDR+lixKMYLapZZrOe+/CZn3xC3mj
	 bxq8n8N+g3u7Q==
Date: Wed, 3 Apr 2024 13:40:44 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 14/15] mlxsw: pci: Remove mlxsw_pci_cq_count()
Message-ID: <20240403124044.GJ26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <f08ad113e8160678f3c8d401382a696c6c7f44c7.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08ad113e8160678f3c8d401382a696c6c7f44c7.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:27PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Currently, for each interrupt we call mlxsw_pci_cq_count() to determine the
> number of CQs. This call makes additional two function's calls. This can
> be removed by storing this value as part of structure 'mlxsw_pci', as we
> already do for number of SDQs. Remove the function and
> __mlxsw_pci_queue_count() which is now not used and store the value
> instead.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


