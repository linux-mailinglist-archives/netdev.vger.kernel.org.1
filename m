Return-Path: <netdev+bounces-186072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881FA9CF62
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D871BA011B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D884D1F3BAC;
	Fri, 25 Apr 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIRhYNBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4535191F8C
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601500; cv=none; b=Puwp2qEJaIBW7f9ZMbwuhgyvA0tlrVsbPBITLSDlhIP35JPrsaybozQe2bKwdVzJhJt9NLysXDzVDQm9PAyjx0WPrDtwYrYJEGrrY8WSPx3m8Atl4WmcfvL95zD0tl3jAm5PVj0lK+0c+jeTFhpcG1hUNj0bGh/kztiCktA+PQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601500; c=relaxed/simple;
	bh=Iz/DsBxzrjvLjAutt7NUQvez1xoEgkZ6nLimuv7dnnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dueb5MfrBBBc2RVp/6AsLzpTxdx0T6QxvrQbRjgeZKweOCVS/gHED6Hgc2Bshv428E/uBwR8FAs22AG5eW1sfdAtMWNkc7JhAR6KALLDlacgh5/McqFXlQqb0o39IKGo+GZ/CM2aY5azH8l2+ScKpei6hN343x3Llvq8HNwSIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIRhYNBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4544C4CEE4;
	Fri, 25 Apr 2025 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601500;
	bh=Iz/DsBxzrjvLjAutt7NUQvez1xoEgkZ6nLimuv7dnnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIRhYNBfNIwngkyd7raqmWRWxgjLNp2c8V8hdUkz//SsFSC/i6dZwJIFmD5xCOlk0
	 1wSjSgmYyb0SNr0pCzzZOJEKq0vtS6VBppsMtu6l+2dalzI7RuQZIRFva2YUCL1Mcl
	 E3SrEnM3dl+fQ6g6HZ0awU5Hr7/r1o7fRBGefntJc/0vJ//vMZI21phcI+Ed+jJfit
	 EzlSDw83g7Izv3grpZ0GgcLZw8UORhdsPKosoIWA6lPKYS8U9UfLWg/4i5ItXRR/Y4
	 tzPM6XvNyi1Q8zjHg8DnBTqeGErUYpQkueNzbuGg3Co+ooFU3Whc/Z0BOqqZf7eX5y
	 pMmv0lOINzQ8A==
Date: Fri, 25 Apr 2025 18:18:16 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 3/3] io_uring/zcrx: selftests: add test case
 for rss ctx
Message-ID: <20250425171816.GS3042781@horms.kernel.org>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425022049.3474590-4-dw@davidwei.uk>

On Thu, Apr 24, 2025 at 07:20:49PM -0700, David Wei wrote:
> RSS contexts are used to shard work across multiple queues for an
> application using io_uring zero copy receive. Add a test case checking
> that steering flows into an RSS context works.
> 
> Until I add multi-thread support to the selftest binary, this test case
> only has 1 queue in the RSS context.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


