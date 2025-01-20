Return-Path: <netdev+bounces-159881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46225A174CC
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5281889F2C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC31EE7BD;
	Mon, 20 Jan 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0zpLICk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67254765;
	Mon, 20 Jan 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737413506; cv=none; b=Ul2JqIowFtBoSrsVwGxH+ynY0aZ37Kt2CuIv/XnlLPPwlmC4LRF9PFabMkqunOpa6FVt6K79aaX3Nml3M/J5euFdDgDgTtkxnDl2c1+PgG/8TZlL2QfRKmi6gymtUzRjg81S9r8X7Dz6fR1CjvpbHUJuTKu/B+849p3Lva1nSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737413506; c=relaxed/simple;
	bh=K9qPg+M5o25jVaq3OfvNZmB+hTjKAQWtTnIr3lmlqTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3ecxEhNFQjVXy0BEKdeXIIDJ+PuoWA2/pNNBu0C2WRJWsA+WYaCL0mg1RM3oGe3IkX1tvzo6PafliESGfAtsz9+YAvNxHFbV+IMz1XhTDrkMrImgXnCbtFLXw4MyLFSMLqQGBfUBfbRuzx+EJxPyPHTz9+bVs797W7n2S3Nxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0zpLICk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228CFC4CEDD;
	Mon, 20 Jan 2025 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737413505;
	bh=K9qPg+M5o25jVaq3OfvNZmB+hTjKAQWtTnIr3lmlqTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0zpLICk+QN5IKD0DRg0CAyQrFHvUPfzJVbnnV7nRK8tULE4ar5rn7WhKsZrqRhyI
	 BHYelpZ2GsaufJgO1kKkG11QYUvK6dV5zquddSgkvQdg6u09f5xdQWPLLw7PefpQc8
	 rnkjOETvi0s14QeXEIT4/hJyUM4lHdodBcoTVUbbpKS/a+2YefJ6EndHKgewPLc0Qi
	 /ZmlUohSaFFz6Hsf2n2oDCvmHLAW3UaDy7UytDV1v7CdxAMhXjcbkZ/oKs4oHEhN/I
	 U92mZ0X+EOxdqbXmjAhZGillXVawm38ISvEraNq9sfN6tjubdemc9fdcgn+vUvVIOY
	 xOAujEElZgbgw==
Date: Mon, 20 Jan 2025 14:51:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com
Subject: Re: [PATCH] seg6: inherit inner IPv4 TTL on ip4ip6 encapsulation
Message-ID: <20250120145144.3e072efe@kernel.org>
In-Reply-To: <1736995236-23063-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1736995236-23063-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 10:40:36 +0800 Yonglong Li wrote:
> inherit inner IPv4 TTL on ip4ip6 SHR encapsulation like as inherit 
> inner hop_limit on ip6ip6 SHR encapsulation

Could you add some references to RFCs which recommend this behavior 
to the commit message?
-- 
pw-bot: cr

