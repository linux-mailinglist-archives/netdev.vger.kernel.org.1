Return-Path: <netdev+bounces-182441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CB2A88C25
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD82F16BEEC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31528467C;
	Mon, 14 Apr 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERtIsFeP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38811991B2;
	Mon, 14 Apr 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658381; cv=none; b=SnFrPnSFaSmXfTuJELeL+tyGpwa5O0i4pFCuf6fmUEPHA/+uuLz4b9Urd0Hqny+s8qXKIH/nIbez4kppIDQbVVWhUFOsgJAVsq+eo9LCkuLCjR4L9W4CFxIZvYcJQcQh6klcv7is2KeIG1YPL+ZOAI4h49iWuvGVCCZYIXMKbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658381; c=relaxed/simple;
	bh=ycmvJtJmprkqqKFNE+7M2HetshQ2mwZSKGMRcsqaXwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEHw5WCIJ/CLewll6DXjtrFwMqsuxg3uftLPRU8/kEYpl3NE+zExk7EctjklR8v7NhuqF0jLvRjpantd6uiABRi5PTzn8s/zXXUkwwal04ZDEllls/wYGBywE6v1GacvCspYkCp3oAC7hZBezsrkhpYAW1N3z5qB82qBP+1fKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERtIsFeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA5AC4CEE2;
	Mon, 14 Apr 2025 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744658381;
	bh=ycmvJtJmprkqqKFNE+7M2HetshQ2mwZSKGMRcsqaXwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERtIsFePXR7ymJtgAcEdSXXMR3aPB+ML6N/Rms8nhPGV9ZuV4IPjCjO1PbNOlYAmS
	 Iy/dLPPs2mV9K7xOB7aPL9Vv2V1GUnezzgoUPoPBtIi2jX70WC7x/PpZTpshg0R6KU
	 NKyWIWWIuiIMM7Gvorows1EXpxJgVW8hiyuYKsE8ZuweYLxKxCkQJU6U3bDnHKnTZV
	 LOzIWIaqBMHL3H6xqE5xJ87FgJ2L9/TIr4y8czL/kGPHRH5JRsl/2x2R035+PQFQG6
	 Jga+C90n+dfia3AhC/Gda+vWBIppVdSgw0ATqDeCnFrpcnLIXO7iekrXhxcE3Qx0gm
	 lRu3q34+0yM5Q==
Date: Mon, 14 Apr 2025 20:19:36 +0100
From: Simon Horman <horms@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: rmody@marvell.com, skalluru@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com
Subject: Re: [PATCH net] bna: bnad_dim_timeout: Rename del_timer_sync in
 comment
Message-ID: <20250414191936.GW395307@horms.kernel.org>
References: <61DDCE7AB5B6CE82+20250411101736.160981-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61DDCE7AB5B6CE82+20250411101736.160981-1-wangyuli@uniontech.com>

On Fri, Apr 11, 2025 at 06:17:36PM +0800, WangYuli wrote:
> Commit 8fa7292fee5c ("treewide: Switch/rename to timer_delete[_sync]()")
> switched del_timer_sync to timer_delete_sync, but did not modify the
> comment for bnad_dim_timeout(). Now fix it.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

As a documentation "fix" I agree this seems appropriate for net
without a Fixes tag.

Reviewed-by: Simon Horman <horms@kernel.org>

