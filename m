Return-Path: <netdev+bounces-217792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F6B39D85
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2683986693
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F030FC1D;
	Thu, 28 Aug 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Etpij1k3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3D30FC01
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384854; cv=none; b=e1IGRYr3eWKnKHFaJ02TJsiDyIbdBQwY2XjcD/wcDk8pQ/WlE51JNZhgy7Dfg4scpCu56qYehMlo7KXOG1YhMOtf5Y9MLVKsXOKPjUuxmMZYYhfbCLg2tF5UBBCOx0bTxvON5ITj0aVeL1Ayo8fNkfSeJ9ckxaJ1WDiyGy5mUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384854; c=relaxed/simple;
	bh=9y76/GVki5leIoMO0+n76y4r2vr/6rl+ueCic5MGPYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBEM8xEpVkW64//kDbGl6EWf66akPdPm5YG9i9cc+Rwmg2aprqcRlttwQRkHtb3n1fkqGH2Dyv6JaTsD11qi3I5h6XpOrJZ7JkOUXhsVzz3KGbWBjs1C/p4YTLuSbfbmWC8XYmXzyV0hNPvOZp0HSc7KHgVvtbrqXg/0CcVVz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Etpij1k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D7EC4CEEB;
	Thu, 28 Aug 2025 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384854;
	bh=9y76/GVki5leIoMO0+n76y4r2vr/6rl+ueCic5MGPYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Etpij1k38JNx0cUl172spIOPNW+xoZLQmclH49LX/LVgxNq1ZBx82BeEXfoY5PM+a
	 WY21aQuqR+6lmsNs/BCwXjNXO10smtPjRnQsdoa/7esugHv7+m8pKQWJnT05Z7cRy2
	 v3TJn1bbGQR+cpmtWODHqjYv/qIu61ZUSTggci0mTTsHEFrcNKtOYuOhEgZCT95Xqr
	 8KV6DJlak2l3ksQgpbmFzkIXb1nr7/6Cu8Phhs0/PY1ltclX2DRJpZ8j1juXA89P75
	 QC2k5M9evEoaAZV2mpsqn6mIhlccuqfgJ0ajF2Nis94092E8d27fbNZ9d3FoIOzk+0
	 TyCW39229w8ow==
Date: Thu, 28 Aug 2025 13:40:50 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com
Subject: Re: [PATCH net-next V2 5/7] net/mlx5: E-Switch, Register
 representors for adjacent vports
Message-ID: <20250828124050.GF10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-6-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-6-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:14PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Register representors for adjacent vports dynamically when they are
> discovered. Dynamically added representors state will now be set to
> 'REGISTERED' when the representor type was already registered,
> otherwise they won't be loaded.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


