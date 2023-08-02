Return-Path: <netdev+bounces-23689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8730176D1D6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85B11C20319
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58415C8FD;
	Wed,  2 Aug 2023 15:23:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30813D2E7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81936C433C7;
	Wed,  2 Aug 2023 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690989837;
	bh=Zu3eb4D+Sy8IqrzR6uy0ZGNkiAJzPj6+/YJRPNDNgrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQvFB1gGB11rznAsCy+ANpuFzhCOrDwnKHDicTZqM3N0Dk1rcex2NgY6hiClsM8iM
	 wVx45gdDSVbeYVkRq4sVhqOTqMLrulQzT3EhXMW0dtbWBHcI2hLlC5eZOniDg4Sjpr
	 PxbKifbw9y0B8lw+hNTtPyKOi2WNjTWsj2qaZoMu0fWlIdmzApUlXe2J/8YI5i4rf4
	 NAxFaNqTyM3sSg+z80PWxPjGbyuKtyreyCs+dcLitoz0y6DyR1/CPQFkYKbCre7I8Q
	 8372h82JoQ+Kuc/aqZeOoxPsCQR8zsEq6PXHzl0d46OT6/WMu6xtZk3ul/8LjIVyyM
	 9BlS1bvasXslA==
Date: Wed, 2 Aug 2023 17:23:53 +0200
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_section_table
Message-ID: <ZMp1CdK04+VYip0R@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <ddc1cde5fe6cb6a0865ae96d0d064298e343720d.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc1cde5fe6cb6a0865ae96d0d064298e343720d.1690938732.git.gustavoars@kernel.org>

On Tue, Aug 01, 2023 at 11:06:30PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_section_table with flexible-array
> member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


