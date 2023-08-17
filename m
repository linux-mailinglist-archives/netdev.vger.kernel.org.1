Return-Path: <netdev+bounces-28299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7F77EF28
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 04:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DDC281D71
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949737F;
	Thu, 17 Aug 2023 02:38:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89A36A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 02:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E74DC433C7;
	Thu, 17 Aug 2023 02:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692239903;
	bh=4x/GXRMqUfVWkiWIlecQe+cNgDVppb7XvQESrkF1OKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AjYIy5Lk8V0WS5MPSOKh2rJ6TWcW7CaqOx0I9ariScfgvuGY6u9sZJeq7Joebz2b6
	 UyPFekHCtPes5vibrKzhW3EWC+v+Tbk5uODDmiClg0p/JNLyes8r1IRb2inAtm7wrW
	 eIgwgoXl6khLRJGy3xvjXfYkh5grpGm6K9uQU65VffhIcRUzhcVjRch9dfEJQRkQat
	 lYTgam56dlOiw6yZoKorjFj/iEhNbtwYfkgWMm3mazbaYJIBUYOXAFQRhBYCVs2g65
	 8YRAuDtY72b4Y/IysWKqVmk8AOBLov3PiohzP2fmodzjBBvsxlMfkq0/Hud/EuLKql
	 0eGOhvfwL3x7A==
Date: Wed, 16 Aug 2023 19:38:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Vadim Fedorenko <vadfed@meta.com>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Bar Shapira
 <bshapira@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Richard
 Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value
 to improve ptp free running mode precision"
Message-ID: <20230816193822.1a0c2b0c@kernel.org>
In-Reply-To: <20230815151507.3028503-1-vadfed@meta.com>
References: <20230815151507.3028503-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 08:15:07 -0700 Vadim Fedorenko wrote:
> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.
> 
> There was an assumption in the original commit that all the devices
> supported by mlx5 advertise 1GHz as an internal timer frequency.
> Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
> as an internal frequency and the original commit breaks PTP
> synchronization on these cards.

Hi Saeed, any preference here? Given we're past -rc6 and the small
size of the revert it seems like a tempting solution?

