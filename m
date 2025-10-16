Return-Path: <netdev+bounces-230137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B10BE455E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D792519A8175
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC34734F495;
	Thu, 16 Oct 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erM9eQUQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1A1C84B2;
	Thu, 16 Oct 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629626; cv=none; b=uTBGjROF7SQ2hWOKPnpRZYaW55U+e1OHF8UdRT87tS/86DwW6UxITp3/r4jOXtOcavNYVUH1cV1bWoOYpGtk86PvM0pRyYadQ/96LHVy/oK6PtP61RjVMCc6ZpLBisXId232fIX64ZaM3EQggCe3En94Cs+lpVgnIvMOXn7sm+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629626; c=relaxed/simple;
	bh=XGpBa+a0iKSn9D3dLoUUmRwWIRv0Hk8B3N4MXNUHev4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2uXnxWKucy/MAepQ0QziG/sWi955/9fpJT0D0dOuAsGAIFl8+5jAKqddIupjv7gqE2/2etNRE4gZ/pcyUS7FTwekhM8RwhHYD8bPfVh773wP1egXzPDRP/ZcSt2lPg0q9/Gm1UCLvnPO7EHiOabgt2ts+XkxJs6bAZTrtKwlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erM9eQUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE5C4CEFB;
	Thu, 16 Oct 2025 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629625;
	bh=XGpBa+a0iKSn9D3dLoUUmRwWIRv0Hk8B3N4MXNUHev4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erM9eQUQKEyJYflO5Eb2nYfTKT5vUqI9SZvZYGJwH+n/NGpjOnek+V4upW5ANw0Id
	 QhAYTeYQ94ynt1VpQgHpMTe1qeZORStP/aOV0glnYQtyC1DvQ/oI1feU2pCusUp7ND
	 vLo3f33d+YtHMKVnSmgajwG0KEYYMJOMnSPHO/4MwjfCwkdpADasf777CdUnLoJ8WT
	 uVkNOl5F+an9yCzLmv9KE7H1Z8HM5GP6hxja8SDMHx2HrCmQx1DXVGNAw5tBg2PgGu
	 h6+3M/LufjqMVmk8rQF948a7xWL8nJYyXggV4/ISFwcC1nDlTYEj3ve2K2MOU3t5DY
	 oO11cp2+Qjzkw==
Date: Thu, 16 Oct 2025 16:47:00 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] net: rmnet: Use section heading for packet
 format subsections
Message-ID: <aPETdHwdVoqycFVB@horms.kernel.org>
References: <20251016092552.27053-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016092552.27053-1-bagasdotme@gmail.com>

On Thu, Oct 16, 2025 at 04:25:52PM +0700, Bagas Sanjaya wrote:
> Format subsections of "Packet format" section as reST subsections.
> 
> Link: https://lore.kernel.org/linux-doc/aO_MefPIlQQrCU3j@horms.kernel.org/
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


