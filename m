Return-Path: <netdev+bounces-108549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11D924270
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274561F21CAD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AAD16C69A;
	Tue,  2 Jul 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTPAtXVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A226AE4;
	Tue,  2 Jul 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934315; cv=none; b=olOev/6HKeU3chCfPwbRacYyWtjq4YMDj+lrEgVHs53QC5BlsEsicAxUZFbfX7zbkDfqXgkSDFzshbDYQvUgGbzMAwn1aJaHmSQsL6E8yzr3MRkyAHLUcNTAt9KEkLQqvvIAGU1ASqinAkrn0+F10I6Rjz65oFlsAH+/aeAstVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934315; c=relaxed/simple;
	bh=RFGLGMiTOQuaIOj4XBf/lsM3IeIboCZHHQ/Oc+NJt+s=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrdhVCdrHSboSovQxWxWk+p/FTUEZDoeGq+S7aDbfWT2LVclh75t/UbpKFbf5juqqnAkVXatknzGdGGDCRyDdavSYPg9U+d9/soJRVeN68DqhaB8O3X5bWFxzx9zCsZN5l44lETdEZxmSK7wo2itNX48OcOLU2IZY2FE577uc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTPAtXVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC1AC116B1;
	Tue,  2 Jul 2024 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719934315;
	bh=RFGLGMiTOQuaIOj4XBf/lsM3IeIboCZHHQ/Oc+NJt+s=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=oTPAtXVm080ISZNO4FfspK/koc2L3Vp+qloHY0YaBhPCb65+Va9asD8HC7E+d/O95
	 Mkrsy0ho9u9cJBwrcNdGF3nztGZVy+9t7q3IrX9ZuJP52pWi5m8DnUDhtmxoueCe6h
	 F2D10b1eGD0Cmh5cO7VhocBH5J7BPjVWnM58SEvVeHnarSSWW2T13DkcPfy7lAUfUh
	 OZqbYcGI1tVhSlrNSI1QUYP8cSej6o3B2XjlfBSI1SUddkN56U7dxf9Gw+4oYe4irU
	 j4fNghlpgw1JFYFPlptwdde2Zdy7iaePsXI8V6J9dRDHXH90kdixVjzBZf2QY+DEn/
	 IMSp6+v1U4gDQ==
Date: Tue, 2 Jul 2024 08:31:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jul 2nd
Message-ID: <20240702083153.21668022@kernel.org>
In-Reply-To: <20240701132727.4e023a1e@kernel.org>
References: <20240701132727.4e023a1e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 13:27:27 -0700 Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/b/jak-wkr-seg-hjn

Hi!

Looks like the BBB instance got reset, the new link is:

https://bbb.lwn.net/rooms/wxy-rp7-fqn-w3k/join

