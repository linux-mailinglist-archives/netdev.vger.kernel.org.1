Return-Path: <netdev+bounces-129344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6697EF57
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC03B21BD6
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DE019F131;
	Mon, 23 Sep 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDtZFy62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301819F12E;
	Mon, 23 Sep 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109376; cv=none; b=GDEO7tiJKnw3ge55dQlU/C5QNW3k6XWH1iBkwhr+VpbLStbXn2pqbzCbLnPXra9H9KZbSPmh84B3KSsoN1M5++ZMrTS82Ro6vaVQg4QHirV150G2mJDNjG7sDEdJ/dox1ctQkYDptYCgGHY6obID1B+uO7tpDmoaUhoUEhCSDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109376; c=relaxed/simple;
	bh=W4pEEes5sAHPdGAmB+aDiKOGdZ3Oy9MJDfhFcv6nVks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bekfSou5zj6sqkUfHpkoGOE5WxlP5Ax9aAQ7YTvN0NUYXIZ3+tNqC+eCEMdu10NDnPEFtvWJjj3EweQWiTe2nyK/ycZdMZkdjuarCQqHyeCS1lW2Fz8Oi8cxbVKgGRRogQnm0xeEJFgX2TpS0kJalsj7pEc80AMYTJzCxRNubIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDtZFy62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2771C4CECE;
	Mon, 23 Sep 2024 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727109375;
	bh=W4pEEes5sAHPdGAmB+aDiKOGdZ3Oy9MJDfhFcv6nVks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDtZFy62VrrLR/wISvROgrA+SBhKO+d0o3kT5V+t0X6UPj4iLPQEVnl4pSz+XB8xZ
	 aGkqV/uapqjmmeGMDQwzsPMRkIzzem8jWUWqcDojP7t45xGLxyV/ardIc0dZ2eVzGV
	 2rf9Y/IX3PAp0CDvBt+AV1mnTuGgBsG+uUNi0uWmsSR+gpud1bXjG/p0jsUY7ZiE6w
	 H+SucymxtFuLSCzsIoK8oUNTgXA87ES7ZjgF4zoqb5idYb+8IYGBIN2e6xJd9OrP85
	 8I/GFJqe20+Caw/z0E57LQDlbCQxOiE14BMKfrcI0EYrRf66cqYZSjMgm3iXkcMJ0Z
	 Ryv1w2Dk1PnWQ==
Date: Mon, 23 Sep 2024 17:36:11 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] cxgb4: clip_tbl: Fix spelling mistake "wont" ->
 "won't"
Message-ID: <20240923163611.GL3426578@kernel.org>
References: <20240923122600.838346-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923122600.838346-1-colin.i.king@gmail.com>

On Mon, Sep 23, 2024 at 01:26:00PM +0100, Colin Ian King wrote:
> There are spelling mistakes in dev_err and dev_info messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin,

codespell also flags that 'actul' is misspelt in this file.
But it is in a non-kernel doc comment, and thus is not user-visible.
So, while that  would be nice to fix too, I think it it can be handled
separately (I add it to my todo list).

Reviewed-by: Simon Horman <horms@kernel.org>

