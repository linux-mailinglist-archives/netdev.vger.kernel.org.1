Return-Path: <netdev+bounces-53591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0101803D2A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB21F212C2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203C2FC3F;
	Mon,  4 Dec 2023 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb2Hs7Y2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646B2FC31
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 18:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFB3C433C9;
	Mon,  4 Dec 2023 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701714904;
	bh=gVIM9sG78ieBu+roFlguZWgJQ4rQiow2Qm23javDmOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fb2Hs7Y2keSFGxwBrik9EzSjcJYeplfAGXFnb5D2bmzN5QOYo0LzgsZNa5NGFpIw9
	 pgA7qoYUgnNjfTm58nUL6EwP1R55tPh4EDogznjHX+nnUdTjWp5mh4YEB3uI5R5NZC
	 RZ9uWtdHfUMcWHgJDycVP4+tit5K1gPiSj0F9BHUKb/rmOlyo22DhCZd5LnWn1C0md
	 JecVDYuEfDn+ByYlKtMM/PXEgyY4Atwd0IFiPMb7pSbLTCeJw7gc1T527GuJdkKRCG
	 FPWR/nZPSCUmJw2OBCcVsG8TF3DQcAk414iV2rhRsUn5qWEfBiLzWtmhpv0AvJv1a7
	 k14FFvvNhskZw==
Date: Mon, 4 Dec 2023 10:35:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net 0/7] ionic: small driver fixes
Message-ID: <20231204103503.757bafb7@kernel.org>
In-Reply-To: <6c5069f1-d689-438b-9c1c-ba3dd62fdb4d@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
	<20231201174223.34c6ac58@kernel.org>
	<6c5069f1-d689-438b-9c1c-ba3dd62fdb4d@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 10:23:40 -0800 Nelson, Shannon wrote:
> Okay, you would prefer most of these as net-next, and you like the Fixes 
> tags, but normally if there are Fixes tags they should be in net.  So, 
> do you want the Fixes tags removed when these patches are sent to net-next?

Yes, that's right. What goes to net-next should have Fixes tag stripped.
If you want to preserve the reference for your own needs, you can say
something like:

This code was introduced in commit ...

Just not a bona fide Fixes tag, please.

