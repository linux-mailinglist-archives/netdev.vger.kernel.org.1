Return-Path: <netdev+bounces-95925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9C8C3DAA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C6F1C21074
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8A147C7F;
	Mon, 13 May 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmBnULog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0542B9D1
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590772; cv=none; b=aVG2CAF7g2lV96epCx8B+UDkCvUHSjfwkTpicQJnUa0aPuwzwwhxH4VowZfL0ZFIF/oNF0IlC026/80VLaSTMrdOKYK33Wrd8Z3JssPUUBO2D5EAtQbKJUT9wE9IkbN1bZlZdx5ej2cfDXMVhLTo8Q4n0Sqw4P5oksk9OVas7Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590772; c=relaxed/simple;
	bh=r4pKTXlS2ryoI1Ro8ktIcDEZu6BDrxUHK5bZhdePow8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgZecjPkNoAcPU9nQMJtJDXbRFZu7J2ZpI9DnuxankpnY2cjTRHJdvyvlEo4KGBWm9saj1cB/EbZVmqml4OvIJWPDQ/ighZbOV7vKS3D/5qbrGPtSVC5DPj9fsZ49yYEs7l3FJpetm0+G65qhV2hXIz9VrSzpo4jSWoEKgomatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmBnULog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0554C113CC;
	Mon, 13 May 2024 08:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715590772;
	bh=r4pKTXlS2ryoI1Ro8ktIcDEZu6BDrxUHK5bZhdePow8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmBnULogpIf1LOq0GbdCb1rL+lvQ3j7RsHl9j3ZUvMYDCNMXud+cPHnb3qpHJ2hLY
	 G5GK7wIyhE3eiByYVo8wbGEMSJFlgl7z83TrTuTiRhq4WCbHLupFJF7EuTuqxeS6un
	 d37drB8sNDv3vSuQbDH2KAPX28kKHAuQn8TyTjTnNsVtcjCozG2+Z7QJ+GWAuw1P+n
	 dBuTl/D3T86zuVx5ljd+EE+bpAuieOL6VndxDamRffSYN3iuz7jD6NpxI92kPHV01r
	 46hTHroXxKC4qfhCduOTN8ZwjnZwexZT6HJbhcZlcNDCcjzOcOJj4AGzw9K5mLtZR3
	 kUmxA9gTeGVeA==
Date: Mon, 13 May 2024 09:59:27 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net/mlx5: Enable 8 ports LAG
Message-ID: <20240513085927.GB2787@kernel.org>
References: <20240512124306.740898-1-tariqt@nvidia.com>
 <20240512124306.740898-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512124306.740898-2-tariqt@nvidia.com>

On Sun, May 12, 2024 at 03:43:03PM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> This patch adds to mlx5 drivers support for 8 ports HCAs.
> Starting with ConnectX-8 HCAs with 8 ports are possible.
> 
> As most driver parts aren't affected by such configuration most driver
> code is unchanged.
> 
> Specially the only affected areas are:
> - Lag
> - Multiport E-Switch
> - Single FDB E-Switch
> 
> All of the above are already factored in generic way, and LAG and VF LAG
> are tested, so all that left is to change a #define and remove checks
> which are no longer needed.
> However, Multiport E-Switch is not tested yet, so it is left untouched.
> 
> This patch will allow to create hardware LAG/VF LAG when all 8 ports are
> added to the same bond device.
> 
> for example, In order to activate the hardware lag a user can execute
> the following:
> 
> ip link add bond0 type bond
> ip link set bond0 type bond miimon 100 mode 2
> ip link set eth2 master bond0
> ip link set eth3 master bond0
> ip link set eth4 master bond0
> ip link set eth5 master bond0
> ip link set eth6 master bond0
> ip link set eth7 master bond0
> ip link set eth8 master bond0
> ip link set eth9 master bond0
> 
> Where eth2, eth3, eth4, eth5, eth6, eth7, eth8 and eth9 are the PFs of
> the same HCA.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


