Return-Path: <netdev+bounces-24712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE2E7715EB
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DBC28122C
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067353BE;
	Sun,  6 Aug 2023 15:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29F5666
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 15:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507FC433C7;
	Sun,  6 Aug 2023 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691336269;
	bh=QBn8NPkWp6aHEu6yqGnfnqh3BbKlk/in2dLR6TFx3Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzXQcRhjhBj2ZK+T6UAU4DoxsC3QkltgzNCXm+GSy9pqhdQ/+PWTCOUGb+yZqMMwp
	 tBqu1TeODn5BWFhqfMxTyQaiP43OFpKKrTxeZ6QdIL5ZKWycbC/d5WvCxtZ4qyKpBe
	 izThVgiRrMgq6TH60LLS4bqc+eAtI0E2tlp6eOmrWIHVXlea2qJhPPhgvJlN83zv4u
	 O+dNfIEcfoRgDoDT2d8oiKxMOSmsLmViSzF6mMHN/k0Pf1ahfX5lKcQlb5vJUUy33E
	 FxlpINzYSxakrSfqXng59+OMSQ+IxvvJRHeU1+gytDUw+uStFPvwnZ71CdkL1bMnR8
	 XuSFNlfpwhlKA==
Date: Sun, 6 Aug 2023 17:37:44 +0200
From: Simon Horman <horms@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, robh@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 00/10] net: fs_enet: Driver cleanup
Message-ID: <ZM++SM4xJ1K6bBxc@vergenet.net>
References: <cover.1691155346.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691155346.git.christophe.leroy@csgroup.eu>

On Fri, Aug 04, 2023 at 03:30:10PM +0200, Christophe Leroy wrote:
> Over the years, platform and driver initialisation have evolved into
> more generic ways, and driver or platform specific stuff has gone
> away, leaving stale objects behind.
> 
> This series aims at cleaning all that up for fs_enet ethernet driver.
> 
> Changes in v2:
> - Remove a trailing whitespace in the old struct moved in patch 7.
> - Include powerpc people and list that I forgot when sending v1
> (and Rob as expected by Patchwork for patch 6, not sure why)

Thanks, this looks good to me.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


