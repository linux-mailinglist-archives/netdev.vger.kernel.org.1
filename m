Return-Path: <netdev+bounces-17137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEBD75087C
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD3A281924
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99B200A7;
	Wed, 12 Jul 2023 12:39:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE0385
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23119C433C7;
	Wed, 12 Jul 2023 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689165546;
	bh=2G6y5g6BO5AA9+KodQorTlrJ1hYxvQ5qjHQHxScxn/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvSoyALBT91Fzs4+F58gLJK3K1FzI/Rqc9tttvQBNKq99Tvrj2tIbxMdRvLCj8Z5v
	 v5IFyndc2xRXZxzuc70J3eVgtjewhUDkCuwDWdDdz6RqLcXVvzF6/QP3ptUtePZX08
	 lom9aU/h2qraVdztS7vwiWtKaleVFv3TB6gNVw6hm745xcz3w1wfeH48oXujXNPmft
	 +HdoTHR1AqAOtPY574zMhhc3sx+6zyzJsNOeLiEbky/3IY3qq/Q3HjARg4F2cxx5N/
	 fKpg/Rix4fR6MrIBMZLhVTDVehbbn0LMWArHxhbi99LAGGLFUeBhwqEWueTLYEJSkk
	 vCH07tgLm/u7w==
Date: Wed, 12 Jul 2023 15:39:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH 1/3] octeontx2-af: Fix hash extraction mbox message
Message-ID: <20230712123902.GB41919@unreal>
References: <20230712111604.2290974-1-sumang@marvell.com>
 <20230712111604.2290974-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111604.2290974-2-sumang@marvell.com>

On Wed, Jul 12, 2023 at 04:46:02PM +0530, Suman Ghosh wrote:
> As of today, hash extraction mbox message response supports only the
> secret key. This patch adds support to extract both hash mask and hash
> control along with the secret key. These are needed to use hash
> reduction of 128 bit IPv6 address to 32 bit.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  | 16 ++--
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 80 +++++++++++--------
>  .../marvell/octeontx2/af/rvu_npc_hash.h       | 13 +--
>  3 files changed, 67 insertions(+), 42 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

