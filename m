Return-Path: <netdev+bounces-177497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45DBA70561
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029061886884
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D843E25332E;
	Tue, 25 Mar 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDkrMtXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BF252913;
	Tue, 25 Mar 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917512; cv=none; b=Qu2QvY0FWyuMeWKxiotUI6s+BYPWcTvJL+VPypPKmUykLPCQuvaGoNqEHQCGb0BR9ElE1jbrbElnqA+a/5GKQS60TK3qUZKGLm1FaUt8tvvVEG8J1S0cMjQINGcmLn6D9ucq7V08pOfQjBx35Er3Q2tsMfyjW3gJMhCFeVzIaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917512; c=relaxed/simple;
	bh=JbZeuUPZYgk4ybrrYUcVviZldyWreG2g92bwH14qTio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fmpm7lFzkpu9ks2417fXuowR0sd3CmIm+S2gKPPvOcIRJz4uIxPyPR+JsRIq7HW8fSCw2nuhoBH2t75+mdHylX1kh4fjIi6OljierQ3iM9hZVucgEEBXiHuKfBWVi+aTVcvFy0hCbkdW38YiBoYsdWc3TkAZf8GjYrKMbvw+9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDkrMtXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E55C4CEE4;
	Tue, 25 Mar 2025 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917512;
	bh=JbZeuUPZYgk4ybrrYUcVviZldyWreG2g92bwH14qTio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDkrMtXX80Ymjlcddg/1qVdVciKqkHG3JLgEKanzB42pLYOml1k0sebJTVLxXy9ev
	 djXpB2HwKpicsT5KRrguy8ppTrz+K6/rIYULE6WQCUdt42CNHl0pTxV7nebt/mQE32
	 oUzz9GSqV5eplr7mBqEcZ/kPK5tAYzUt4xgHd1NSzv7RwBIJOr9sreonad5oiE+Avw
	 +4xuGd8+qeF60hKsopD45F94/XiUgn9cD+sKc33z/+eMuiJX2uIAB9JvtoPgog3NSZ
	 TZaeWIbPtXGHw3NrNgiyAMYDG3oWCL8fPr7d8Ak5I3gyX63FQBNYN2exhDhByBZ1BK
	 KvjVV4sm/ZgUA==
Date: Tue, 25 Mar 2025 15:45:07 +0000
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-af: mcs: Remove redundant
 'flush_workqueue()' calls
Message-ID: <20250325154507.GW892515@horms.kernel.org>
References: <20250324080854.408188-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324080854.408188-1-nichen@iscas.ac.cn>

On Mon, Mar 24, 2025 at 04:08:54PM +0800, Chen Ni wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> 
> - flush_workqueue(E);
>   destroy_workqueue(E);
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

