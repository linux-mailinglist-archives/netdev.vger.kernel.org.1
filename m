Return-Path: <netdev+bounces-163328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F233A29EE0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B67163F46
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78E136988;
	Thu,  6 Feb 2025 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSgnTcni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3C2AC17;
	Thu,  6 Feb 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809474; cv=none; b=BJfn/HPGeRu1lxTJPFRfaoAADB+fdVcOBAYtkklbkTboC0Tiji1zxQZaGmB4gffPuLn8hCGp/yhkYbXwvkoj2Xtny8hN+1MVExc9EWnmDaBJNBzAQMNK7i52d50sYLLgysLv+wfKoXIjPjbtfOZ7730dSm4Ua3GxPMvmb3MRkl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809474; c=relaxed/simple;
	bh=Ps4gQcDzgiXW8dkA1LVY3aArFd+5dNSRWTrIkIXRnzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sm5tXY9l6t7trG0fL8HJyYDP7Xsr/nUvcO2xvyaPQkJTqMPdaubsEYOOgsKa105AkCym7XrMOaUwq1Psamqc7WmM6KQ8KFNXBuWoIDspPHU1/xlEYqG9TcBv7CDv+l4fZjEqa8jG/hvnYG0MOb/VDTCoyYlXt7BggMvSq5W1+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSgnTcni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F152FC4CED6;
	Thu,  6 Feb 2025 02:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738809473;
	bh=Ps4gQcDzgiXW8dkA1LVY3aArFd+5dNSRWTrIkIXRnzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tSgnTcnilkWlobQkn1hq3tN/jsQVds+HgSKDYhtgrJpQyWCiZN4wobjw8OEFE+sLe
	 Y4xTcR9eGtwceGUq0vpWttGDBtcIlV3E4EGD/sDlD4JME6EtNdk6N2sA9Adu69CQzW
	 NtBH0RvbCqAu6juHc0NHVgqhaTqVdfQsjDnOkRa8A1aT7RyDZ9K0h1OQJ3v+KV6DlX
	 7O9TRNaBv7YQZc337i6q/iYCzRCqWctLyDv2qNCJr9C7Y5sdhMmFY+KhyxQxcfLiAG
	 ED4l/lJn0p74M45u5R0hU+sgNA4WGdd1JmxoSWCyzrUYMht+t4D3zO92guLJ2N09SU
	 B+veZmoRL3BPg==
Date: Wed, 5 Feb 2025 18:37:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] net: ethtool: tsconfig: Fix netlink type of
 hwtstamp flags
Message-ID: <20250205183752.31d8b220@kernel.org>
In-Reply-To: <20250205110304.375086-1-kory.maincent@bootlin.com>
References: <20250205110304.375086-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 12:03:01 +0100 Kory Maincent wrote:
>  	data->hwtst_config.tx_type = BIT(cfg.tx_type);
>  	data->hwtst_config.rx_filter = BIT(cfg.rx_filter);
> -	data->hwtst_config.flags = BIT(cfg.flags);
> +	data->hwtst_config.flags = cfg.flags;

This chunk feels a little unrelated, but okay:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

