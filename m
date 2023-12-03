Return-Path: <netdev+bounces-53327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669518025E9
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA4F280D90
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134C168DB;
	Sun,  3 Dec 2023 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej5APuMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6F156EB
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 17:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77BDC433C8;
	Sun,  3 Dec 2023 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701623605;
	bh=rlaUK9BhjAxFUUruue+V+gdSfXD9N/wY0G+9oUs7vp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ej5APuMwlpVatywcA69Z6fCzo/KKY6+s7kERhGPkwKUQKpzWB/fjnj6b4TUSQb87T
	 PCo3Vtbv7o7pSgXBThWxrlF7diWQDiqQcqJjI/wygKKPvoto5W2c8mcvz/XtUvI47q
	 xKd78TPBEzaj502FxEVXWqpvl1B/ktUyknnTPiRIj7OE4b8t0HZJg9jsEzzt5NRPl6
	 ccKGfY54wavyq88udlTqLIkw4CSiy08jEDEI4aNdzpHqX4uor3zOyOvHA+PcB18J5S
	 Ts9lfc6+QH8e/YPnBfOyxTD4lJSXJOYQ2IOLcHIPNFJQD4Kv49909gD5TVxyJ2BHzz
	 ISkSxJXyOZKgw==
Date: Sun, 3 Dec 2023 17:13:20 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 5/5] octeontx2-af: Update Tx link register range
Message-ID: <20231203171320.GO50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-6-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-6-gakula@marvell.com>

On Thu, Nov 30, 2023 at 01:28:18PM +0530, Geetha sowjanya wrote:
> From: Rahul Bhansali <rbhansali@marvell.com>
> 
> On new silicons the TX channels for transmit level has increased.
> This patch fixes the respective register offset range to
> configure the newly added channels.
> 
> Fixes: b279bbb3314e ("octeontx2-af: NIX Tx scheduler queue config support")
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


