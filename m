Return-Path: <netdev+bounces-40671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566757C845A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547711C20B67
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300C13AD1;
	Fri, 13 Oct 2023 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Gq+lks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD313AC7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1979C433C7;
	Fri, 13 Oct 2023 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697196391;
	bh=VUVHLBiRHXjhW61mGyevLaLevEHHRMY/4VItzR8UTYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7Gq+lksQ9KNWiBY2s6EWtGYMe9UD9XLs4wAqs0yucWxPWaicQyIeAACDhS6VgIc0
	 6+wF5dTWz2VHfIvzWWFCQfVbOsHNBwzNIhpeq3DTNC79IsX9vTTzo8f62Ob+NZKBm5
	 woyD45KN6rzbIU/C22Yrwiz/vySWrK5RKjDr5WzjnB5M2m2HrXY6hKLzsCljRlbejr
	 gVAIdKzJuPeoU/WgHJqhhq8IZ4P+BjKUtEBvy4Ks+08uUZPulF61OQeXAEyePfOpFa
	 uj/tHO8cOcPL16NKDL24AFCKYHPqJIHJ/fIthKNOhPsgO3MJCdHgQJ2S/3jUuTOAx3
	 5QPNt/SV6TEGw==
Date: Fri, 13 Oct 2023 13:26:26 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com
Subject: Re: [PATCH net-next 0/2] sfc: support conntrack NAT offload
Message-ID: <20231013112626.GF29570@kernel.org>
References: <cover.1696974554.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696974554.git.ecree.xilinx@gmail.com>

On Tue, Oct 10, 2023 at 10:51:58PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> The EF100 MAE supports performing NAT (and NPT) on packets which match in
>  the conntrack table.  This series adds that capability to the driver.
> 
> Edward Cree (2):
>   sfc: parse mangle actions (NAT) in conntrack entries
>   sfc: support offloading ct(nat) action in RHS rules
> 
>  drivers/net/ethernet/sfc/mae.c          |  3 +-
>  drivers/net/ethernet/sfc/tc.c           |  8 +++
>  drivers/net/ethernet/sfc/tc.h           |  2 +
>  drivers/net/ethernet/sfc/tc_conntrack.c | 91 ++++++++++++++++++++++++-
>  4 files changed, 101 insertions(+), 3 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


