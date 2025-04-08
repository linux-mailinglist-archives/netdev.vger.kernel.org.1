Return-Path: <netdev+bounces-180386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D6A812BA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2057B2236
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AFC232786;
	Tue,  8 Apr 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVedNvoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261722FE07
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130605; cv=none; b=gi1+eGpy6pwC2Bwc4Rqjkl4eX9X8OqYsDt/lrGN/a3J6zAM5zXzKm24vuK5OXrobLCu0/GrYNz2ZCtu4PLYQb2J5LTm5WvPQZ3/giLVg0mmD/tve5ijI+s3TgUBHpVwp8z18KQYxh2z4/q0bdq90Cmzoz+bqapvY7RA8Pk541LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130605; c=relaxed/simple;
	bh=/MlJWQFuaabI22/5MO3CkuNl5VfcTnHDycnsFiz/YXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZzJ5NNrgBmAahBGn0KV2GT9HzG+HWEJsNkEfThSnNw3c+/VRnHn3yqf85DtOeYReDhbOtgGCj8hc5z3ZrtAALIK7zfQLulmTBZrsbhaHzGVOgjlOoWeODALLW985+RCQ2d/3wWNm05uBWzNBOfFhUNyH3RtukPc2nmMfpWxbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVedNvoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54028C4CEE9;
	Tue,  8 Apr 2025 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130604;
	bh=/MlJWQFuaabI22/5MO3CkuNl5VfcTnHDycnsFiz/YXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVedNvoaNmypjn798q20JA2+ZJlxcbDCP4HEz2XbYyL75rSpv484lIbBdsK/8XM+Y
	 WWI5Puyot7sGua+GbbGcsR5bewplvN+wU4EF7DIgHlUXrEyzx4SJgCxd3e6wSxxuPS
	 sFOPy8B7O8kpcIbiV4o+EeApZgLk95xNfW2hO28GZxKZc4YDG+fcWddxcIv56pXWwc
	 6Ml/1v9RVP2ZoMdQkngkHcPC49q0jPJdDuMC5ihjxkStBk7RC9wZoemfqJqm+vKuVY
	 NT+RV64Rt4aPnpcaNqXzzBv97qbnlTN5CkugmfxZ/2wOhDAroN0rsr1mUaAxlRgh7Z
	 qxVx+2zIdLVlA==
Date: Tue, 8 Apr 2025 17:43:20 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, suhui@nfschina.com, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/5] eth: fbnic: add support for TTI HW stats
Message-ID: <20250408164320.GE395307@horms.kernel.org>
References: <20250407172151.3802893-1-mohsin.bashr@gmail.com>
 <20250407172151.3802893-6-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407172151.3802893-6-mohsin.bashr@gmail.com>

On Mon, Apr 07, 2025 at 10:21:51AM -0700, Mohsin Bashir wrote:
> Add coverage for the TX Extension (TEI) Interface (TTI) stats. We are
> tracking packets and control message drops because of credit exhaustion
> on the TX interface.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


