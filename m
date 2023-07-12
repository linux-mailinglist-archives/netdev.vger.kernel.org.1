Return-Path: <netdev+bounces-17139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD6750882
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15571C20777
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83D27724;
	Wed, 12 Jul 2023 12:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0901F957
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E22C433C7;
	Wed, 12 Jul 2023 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689165567;
	bh=tIlxPfmp2OWx7dJ+GCTH34FEXTusbmN/uXpptGTyHm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=un0BVUVwdzmqkRCSU9zDHy5UpETM+o/iWECeXARNOsSWyTHYluRUMxloepOR9LXwy
	 epjYbq/XWOxnCHFO17POZgqVPzzprofH06IHsj7ZAMJ49TlRVDnUykgEryzCbeb6BK
	 7KCUWfR7uVaZE9xsz7mYTU4PVTDpfgrTKiymvp+Dh/EAH6ThDOq4EiogGrfFk0DWg1
	 UBv4dnDh4Kn5AcxayGwpauJWa70hz9ZDLej18/DEJT+VuWlVhrbI80sQLVUlTaAEGh
	 KMs4TwXv0ff3rEJypIRXIsfmV7VggHuhag6PtNMPmP/OFQeBwVeQgRDykI4RxJfl2u
	 QNrjT+I9YqJOA==
Date: Wed, 12 Jul 2023 15:39:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH 3/3] octeontx2-af: Fix hash configuration for both
 source and destination IPv6
Message-ID: <20230712123923.GD41919@unreal>
References: <20230712111604.2290974-1-sumang@marvell.com>
 <20230712111604.2290974-4-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111604.2290974-4-sumang@marvell.com>

On Wed, Jul 12, 2023 at 04:46:04PM +0530, Suman Ghosh wrote:
> As of today, hash reduction was supported only for source IPv6 address.
> This patch fixes that and adds supports for both source and
> destination IPv6 address.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 37 +++++++++----------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

