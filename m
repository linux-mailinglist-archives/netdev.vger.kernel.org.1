Return-Path: <netdev+bounces-206334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A6FB02ACA
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C631A460E7
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37667273808;
	Sat, 12 Jul 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMMS45UF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85D1F4C8A;
	Sat, 12 Jul 2025 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752323116; cv=none; b=UfU+tACD3is6vXDNTNapwffsmZwdROR+J9DlcjjVnHQwfjO/6fOrJjTbdxM9EAOXMkSZ8/1s0OmvhBpy9qo6sHxrAq5RmG8dH2rJGVe3MNlpgysQ3OBPJLVm3FHBZfAAQlH1iUPT7sgSNlafvHhOsuB69pr1Or1X7XJBZOiuYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752323116; c=relaxed/simple;
	bh=RqejI5DOw1iUZMpia2d/5KBfy5b7EP2ulqeSlQb/K04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs0u5s+ncBpP/RNiGoVUdTPaeSBAGkD4Yszi80e4+pDxcG8oPhstFu+nH09pRyGXi75jdfDq0/6ehvPK9JSu1/w2v/VdLoh7ZrhWVp9g1q1cU0HN54zeu/jmnY0P9tx3K5zEzt/T2sZ6pK5uMAi+iRWk6stDaH/6n1JACFeL5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMMS45UF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C826C4CEEF;
	Sat, 12 Jul 2025 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752323115;
	bh=RqejI5DOw1iUZMpia2d/5KBfy5b7EP2ulqeSlQb/K04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMMS45UFxk6B51oKcgpjGZ3KKBxQoKRODz6kCYjewSz2KcEujy3dvWmKU/pdyPICX
	 Js3kliNxpGVDfvYo3owfKV9GMR5UXTYbZZ7OXKjyBSrJIrhhJ0fI/cxW3kz+sUAW+V
	 SeRpw7c+DrZV9BZTwqjEdrJOAzZgjPfydRxHFdku91beAYM8WpgREk3uRsUzf29qIW
	 QenOxCXD0ata9tL4cJTKDQXbUudTlknrdufRk3NG+WvMLwjpRt4TY73y8Z1lWSa75z
	 SMVwV+OVpd2EpZEUVifrKMMIqfR17Hk3jbc/O1QhRnOLwUhp3v5RcSFWYTsmlCSLfi
	 YdZ0Oq2Q/L90Q==
Date: Sat, 12 Jul 2025 13:25:11 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 1/1] net: selftests: add PHY-loopback test
 for bad TCP checksums
Message-ID: <20250712122511.GY721198@horms.kernel.org>
References: <20250711072449.802677-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711072449.802677-1-o.rempel@pengutronix.de>

On Fri, Jul 11, 2025 at 09:24:49AM +0200, Oleksij Rempel wrote:
> Detect NICs and drivers that either drop frames with a corrupted TCP
> checksum or, worse, pass them up as valid.  The test flips one bit in
> the checksum, transmits the packet in internal loopback, and fails when
> the driver reports CHECKSUM_UNNECESSARY.
> 
> Discussed at:
> https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - Replaced manual calculation of TCP checksum with standard kernel helper
>   skb_checksum_help().
> - add test documentation

Reviewed-by: Simon Horman <horms@kernel.org>


