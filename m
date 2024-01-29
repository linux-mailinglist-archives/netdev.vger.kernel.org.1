Return-Path: <netdev+bounces-66859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083478413C6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0CB1F238C3
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FE6F07F;
	Mon, 29 Jan 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcNRY/h3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F207604A
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557968; cv=none; b=WiwSkIcbWfV4pnfx2dzPQGxJBqD2OKkexYzXxSlMre2fyKIXjBQI7bb3p2xOItoNd6tiUxZM86XFlxmHbciSvMn5LQ6c1vPyreWATyC+xPRjm2oyp1ZeagqRdUqYd5Hbs0aphTO3AlPwPV6pdgZrutN/JDH/U0pCp5+NgqynJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557968; c=relaxed/simple;
	bh=qmmiUKe+Djyudq4uR00EdYD9I6f3810/urXknVkPW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZTp53hA49T2bEp3ONTIhKfXntc5XI2/7w1Cr/AKMhZEUa2KpdHnPpBQmdUUP5ldsYWptAVm9PwB0mFCRGLnuh7YB0/HJ+GwufG+lONEHmhb+OYob6KfCMkBaOyRrKcF6TU3m/4JA5x2N2zjm1vyrdM6K7O0yvoL6tBGEOI4frM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcNRY/h3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573DCC43394;
	Mon, 29 Jan 2024 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706557968;
	bh=qmmiUKe+Djyudq4uR00EdYD9I6f3810/urXknVkPW5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcNRY/h39PT9sgqYc6lljPCvyX2k+/6NNUey78MSCfOBpew0LJn2SICU/uizzp21i
	 n9pxbFABu/VlBQsIeIu9pN2Kq4zTFAhl8NeILN3l2rrY+tr7D75tDVZwIR7tkPKFJf
	 Zj6LNMhQY0x8ZQW6QWJYjFSjzeA8gcNUf2gznL5e7Hg8pB2kRIawNue25XS5st1526
	 i0BE/MR1Lzl497prppPpuAhQ43zS/Uq/aKswvGeI1KVlkgJWdKlC5GebLN/MmDJjUQ
	 6j3fQDhpoZJ3TvLhHIR0roMSBJPZNgmLvvVxfCYOugfpxwqL/13GGuDH/w9FVxbGeA
	 fPWsjPJCSi3+g==
Date: Mon, 29 Jan 2024 19:52:43 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 1/6] mlxsw: spectrum: Change mlxsw_sp_upper to
 LAG structure
Message-ID: <20240129195243.GL401354@kernel.org>
References: <cover.1706293430.git.petrm@nvidia.com>
 <fe86c956bb9e2e798ab943267dfa2b7642d91afa.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe86c956bb9e2e798ab943267dfa2b7642d91afa.1706293430.git.petrm@nvidia.com>

On Fri, Jan 26, 2024 at 07:58:26PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> The structure mlxsw_sp_upper is used only as LAG. Rename it to
> mlxsw_sp_lag and move it to spectrum.c file, as it is used only there.
> Move the function mlxsw_sp_lag_get() with the structure.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


