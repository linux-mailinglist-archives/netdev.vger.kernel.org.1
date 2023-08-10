Return-Path: <netdev+bounces-26562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B3778249
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54581281D96
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EE21D2E;
	Thu, 10 Aug 2023 20:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCBEAD9
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D18C433C9;
	Thu, 10 Aug 2023 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691700389;
	bh=/L1/FoIolTCX5+WO1AdKsvpi/9tkJrtA02vyz07SQxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSf0elE5/+x+ysK6HrH2O7I9Zc8jcBnZLRrpmX5p32f00gEXV58IY3TspVfxphrVx
	 vbfHvAGur24PsvXR66o0FN+OeK5fwQ+gHISM9LZ6KQsoHTn7+6uHP3dPddTv+KFnC8
	 qpnb1EUjGtkb6BqS9Dj1Hu20kn+3Mfqqs7SyQNkILQrf4TCygqkiLxOmgje6Crxbua
	 dW2BUae3XS06mcR05vZdBSLsx0i5YjAtwGL0oSTgdp1Rwrj68LROeMVYhWTfYN5KOO
	 sFo0EtpRXo0+XAAPXYQzcm2asCtDNENXxqC3WKWKBfrL6OLsPMR9NumlQq/J0SCkVD
	 H7HvMLIUSUkrQ==
Date: Thu, 10 Aug 2023 22:46:23 +0200
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
	Petr Machata <petrm@nvidia.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Liang He <windhl@126.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ethernet: ldmvsw: mark ldmvsw_open() static
Message-ID: <ZNVMn1HMuV0LvnqD@vergenet.net>
References: <20230810122528.1220434-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810122528.1220434-1-arnd@kernel.org>

On Thu, Aug 10, 2023 at 02:25:15PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The function is exported for no reason and should just be static:
> 
> drivers/net/ethernet/sun/ldmvsw.c:127:5: error: no previous prototype for 'ldmvsw_open' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

