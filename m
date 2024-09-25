Return-Path: <netdev+bounces-129838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A3986734
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF1B281F4F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CBD14F9FB;
	Wed, 25 Sep 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/ln3DH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A5146A83;
	Wed, 25 Sep 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294039; cv=none; b=itJlEz2QxBwr1r81oq/SjiqJXvMERcCIgI1FD7Mv3cvVRygvu/IBI/Y4zc/lm1ZRjuGONKWL4dP2qiHKwVC+UUrqjVAbaCaqH3u4+LZkM/v736B4No76k6+t+d/NdKV2PYLHqs5q3rtE5bqgcK+bz3iPcuAY7nwVMThlABL+mI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294039; c=relaxed/simple;
	bh=PsewtJ2NK1B0orZJR3lv20G81kf/IkJEtGPhtMCu6q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLsqeNPNDamly7SPY4e7yONzV0Oe0hwwas07MmUjboMoAwXT0NiQJoGVi8SDxIMsYkb5Ms0djKVIzVf02kzXmofuj5Vol9S/Qs2VSs49UetaCdNTasQC24LP+Z3TZuNEw5Qne0H6NC4ip7WDc5JqBFy8WeWDUrU+8Dr8Bp0D8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/ln3DH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AAAC4CECD;
	Wed, 25 Sep 2024 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294038;
	bh=PsewtJ2NK1B0orZJR3lv20G81kf/IkJEtGPhtMCu6q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/ln3DH6185xuGtUi5wm20wr6/1/j4M02AYz5dwmA8zmRDk2tfPMzjfKL14u/1BYP
	 VhfE75TWa7dG6QUa4GI/d++PKeBBTx5EoUI2EtYx1Y365ENVkOFCAJruWWp/2xvttg
	 y5B+G2RJ2+pClOhU6bw7g+SpCRHf7PzevtuuxTyKqz+RCjfG6mo+YVeczwLw/O42lW
	 /sllJVtSuDqFa3UsKviDDNytjza5XbFMZRco1Ipfr2eI3Lkv8O0zOndUC1SzF4i8ne
	 hVz7Ybf+dauuZS8bigzWu3Kb5XHleBGgYzKgh35UrcMeP4t7k4ex6tBW1miyRI4AW/
	 tiGqHXnAxhXMg==
Date: Wed, 25 Sep 2024 20:53:54 +0100
From: Simon Horman <horms@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/net:Fix the wrong format specifier
Message-ID: <20240925195354.GY4029621@kernel.org>
References: <20240925085524.3525-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925085524.3525-1-zhujun2@cmss.chinamobile.com>

On Wed, Sep 25, 2024 at 01:55:24AM -0700, Zhu Jun wrote:
> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Hi Zhu Jun,

Thanks for your patch.

While this change looks good to me it looks like it is for net-next.
Currently net-next is closed for the v6.12 merge window. So please
repost this patch once it reopens, after v6.12-rc1 has been released.
I expect that to happen early next week.

Also, please explicitly target net-next patches for that tree like this:

  Subject: [PATCH net-next]

For reference, netdev processes are documented here:
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

