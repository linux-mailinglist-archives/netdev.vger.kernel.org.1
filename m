Return-Path: <netdev+bounces-137580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A511B9A7039
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECF7B210C1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489E1EABBA;
	Mon, 21 Oct 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIbxEAMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A451CFEC0;
	Mon, 21 Oct 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529941; cv=none; b=atW0Yk/0mfK1gT94B8CdfAlXdOeZBTdk0wMpEuXw+tWv3ZcEgiDYdyL2OFGukt2i5lGAZaDtt341WzDuTFzEdQ2kxrpZ6pJcpSwE6gWUWrmYEPG685+HYYYjBICcmMbiYBwfuozFzZNyMa43pivfHBTwAMFmA82pUOIgPYgCtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529941; c=relaxed/simple;
	bh=NiahaY8n5n6gRreDK3Q5jBIqM207hMEUO21nI9xMAI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2PxqlxJtsY71VhANngLfdId4JKkoQbLiD7hSPWRmy37vmhlHOW6m7+JZ0c+6nlq/+u0nAVc4Oo54c2vwKi0d3JpKNNoBfsVXOrrPq18nRs/IPzCRg0YL9+AqG8Td/P9ZQdtL0ZAwsLS6XP4qX/VxxrAdKvhidoFe6d5yTYihJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIbxEAMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E5EC4CEC3;
	Mon, 21 Oct 2024 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529941;
	bh=NiahaY8n5n6gRreDK3Q5jBIqM207hMEUO21nI9xMAI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIbxEAMC0WunqanomYvH+qww0M0ViJi6prLYSK2C2rLXRQfmDT3JP80eHfNlQ05GK
	 OO5C5gmkvJ8WOAkvUpJp+Hfo9LKxjWFDQmW64w8qtUatR/HenM9pl0+PhbG2XCCyif
	 n25fIOTxmOtBETNjk7sKC04y+BrOKlrXFxhxmZ57iDWkqa175eeBw3akBCuSB2WCQC
	 n6EmPALbYdi5/ag3gluyFOzv8uQsyjVsBVbF4EyY0NsJ71gwyapqD981OpVDSCSik5
	 StbjKqrzepXuZgPtvQ5/vR5WUw+4hgkX6gKiEgABfCsYMR660VJi5zv3p2bbkgR2yB
	 ezycFIuAbk1dQ==
Date: Mon, 21 Oct 2024 17:58:56 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: bnxt: use ethtool string helpers
Message-ID: <20241021165856.GM402847@kernel.org>
References: <20241021022901.318647-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021022901.318647-1-rosenp@gmail.com>

On Sun, Oct 20, 2024 at 07:29:01PM -0700, Rosen Penev wrote:
> Avoids having to use manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


