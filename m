Return-Path: <netdev+bounces-117640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B994EAAC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166521C2110B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB716EBED;
	Mon, 12 Aug 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzrQVGUu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9616EB79;
	Mon, 12 Aug 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458146; cv=none; b=i6M4q5BD315D4gfLOcpq3X8nIFEMxS4fRwiACSgah/PbUY3mD2GuVp68i1zT5+EvL8IxLxHYt2wmAFCAP84H263E9wNyOjDMadW/a5h3v/wJF/b1UJ+Edg86hkpzE2BE6Mxp21UkOFEsfczCGVLhT6d2Xia9trYRhUbLwoRQY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458146; c=relaxed/simple;
	bh=BzOa45nizXmPfTNw2HBpcKGNcVahtK9fFG2WEryxV2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLTJMMYd3aTVQsKH4YFbUmyjM4P/J/0ogF/NSb1h190YpXDVMFEriZGiGF4L6vVbeLF5RGWUc53pgcek2M2qAwuUVSrASefxOpnkOm8P+el2uXz4/FSnth5JcdW0Od84MUWTEt5lAmJ5QmPV0hqotAib28CHkH4xHkPYvV6YhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzrQVGUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827A4C32782;
	Mon, 12 Aug 2024 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723458146;
	bh=BzOa45nizXmPfTNw2HBpcKGNcVahtK9fFG2WEryxV2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzrQVGUuIj4MyJAeuzCGhfyrfxylp2nwWmoPtpDVEzPvRsKJGW2JOJ2hn+0xEGZWI
	 kPWROC1FLY6qR+6mTp6ZM1U3FFjWIosXnMhPQLi6YIq22x/XnbLB1a0ch+AfXBj5HC
	 Zb2HihvIiwjbGxHOlxdHyziJgwdBfO/oMXoHMRMnGnOAXw2Uqgxu5WSAQn4pDpDW51
	 hyhl7aphS8dtwfokWdsht7+LHAaOYo+bLJh0D2z91qygdumSPb+A4HM0eF1Sr4dsF3
	 znXqMYmhmZQ2elIaWxdGnluCkNQdECNXACyl8XfTZKBqjYEPdONpGMGQ5AWlPFb1sG
	 4i8CSE0iEkvsg==
Date: Mon, 12 Aug 2024 11:22:20 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] nfp: Use static_assert() to check struct sizes
Message-ID: <20240812102220.GA468359@kernel.org>
References: <ZrVB43Hen0H5WQFP@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrVB43Hen0H5WQFP@cute>

On Thu, Aug 08, 2024 at 04:08:35PM -0600, Gustavo A. R. Silva wrote:
> Commit d88cabfd9abc ("nfp: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct nfp_dump_tl_hdr`. We want
> to ensure that when new members need to be added to the flexible
> structure, they are always included within this tagged struct.
> 
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


