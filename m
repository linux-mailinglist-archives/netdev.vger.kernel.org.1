Return-Path: <netdev+bounces-50799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184717F72E7
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8363280C95
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7E1DDE1;
	Fri, 24 Nov 2023 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAPLy2dH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B21A72A
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 11:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08F6C433C7;
	Fri, 24 Nov 2023 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700826015;
	bh=zYX4CjsWwIjrMsq2uKCmc6hdvPNc+HvF1KoWV8vTooY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAPLy2dHbO+E5r0XKsyj0RLhtiDKiepo8tz5yOCZhKJ5lio/dhCGp5YpbE6AjLLui
	 wb17Hx6LUTORquA640FaTKuMFkUbomJg3Ji9RQOsWYEiw63ECYgjfkyQAsEABJc7kF
	 kmcmScK3WdQ+HzELV5n7ufXb996oGnnjpJ5PpG0PWFX4uXrVh0aMk8MmP45kr3vUJ7
	 bMXxjdOFx5vrZnRtUpd7O1JYZpPoNi6odh7VHzHpClXiqJwdr5hvvtSCosZumUBx8J
	 xmb03JKkaZIns/77LnULkK0+baECLS+pqpNiZmKmIziP1n5X0e+1HrxW/0TwNWzBg6
	 F2hNjI8rWkGbg==
Date: Fri, 24 Nov 2023 11:40:11 +0000
From: Simon Horman <horms@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH net v1 2/2] net/mlx5e: Correct snprintf truncation
 handling for fw_version buffer used by representors
Message-ID: <20231124114011.GO50352@kernel.org>
References: <20231121230022.89102-1-rrameshbabu@nvidia.com>
 <20231121230022.89102-2-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121230022.89102-2-rrameshbabu@nvidia.com>

On Tue, Nov 21, 2023 at 03:00:22PM -0800, Rahul Rameshbabu wrote:
> snprintf returns the length of the formatted string, excluding the trailing
> null, without accounting for truncation. This means that is the return
> value is greater than or equal to the size parameter, the fw_version string
> was truncated.
> 
> Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
> Fixes: 1b2bd0c0264f ("net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


