Return-Path: <netdev+bounces-17432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796357518D6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8AD2811D1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A415EC7;
	Thu, 13 Jul 2023 06:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D11366
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B05C433C8;
	Thu, 13 Jul 2023 06:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689230030;
	bh=LqgghM2Zej1VAWt7omsVvgwe20Q8z8XEZpXrbAV10SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iw9RGwDK+QYaciKqeb98iq3tpPQrDwW4c+ruxvfllPKiBriByJRDn3z7LYQFUgtWc
	 rRmkMXmyeJYxI3zw/Sg/nBYPahe3lKpckq0h1mkG8vbfJi7XgLeAas27wBRLET3NpT
	 gZF+sQZCFQpMbM8Fcgga3QPWyAW/QVEZo3281uYy7RX1xo92pEkJpiNEinzx5stLRi
	 I9P+ayGV9217tRnhxFKzy0Q1TP0FynqeXDGjMgtZMrPf57le7zpp2dIwS43E40Gniq
	 WKQJQ7WMmP28aOv8kAsNHO+40d5KXXotPK3WArR4qU8qdqOPFaNipeheExE5Y2tgt3
	 L6OD8Zr61rAuA==
Date: Thu, 13 Jul 2023 09:33:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to
 modify rule destination
Message-ID: <20230713063345.GG41919@unreal>
References: <cover.1689064922.git.leonro@nvidia.com>
 <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
 <20230712173259.4756fe08@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712173259.4756fe08@kernel.org>

On Wed, Jul 12, 2023 at 05:32:59PM -0700, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 12:29:07 +0300 Leon Romanovsky wrote:
> > From: Jianbo Liu <jianbol@nvidia.com>
> > 
> > The rule destination must be comprared with the old_dest passed in.
> > 
> > Fixes: 74491de93712 ("net/mlx5: Add multi dest support")
> 
> This says Fixes, should I quickly toss it into net so it makes
> tomorrow's PR?

This is a fix, but it useful for this series only, which actually
needs to modify flow steering rule destinations on the fly.

There is no other code in mlx5 which needs this fix.

Thanks

