Return-Path: <netdev+bounces-162047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE14A2576C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10741882D41
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DE1201100;
	Mon,  3 Feb 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTJx8Kgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C12201034
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580074; cv=none; b=b18mSjfwWbVS8yjPFvld6gUL63uQw6uKo7CZBW6db3n0sXFesthrnYT2cIAnwWhTT4AmX0580vpvmjuLEzuHdN+/sXOSDSA7CP0RJBi388MDV6XcPe6VKMlZZLlMMkNK4bZ6a47PZcG4z/ETEABQbOSbOLZOPTu4uhCYLRta5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580074; c=relaxed/simple;
	bh=YkJ0iA0PvGBxK73iZc/Ad2T0p6eaIT0zXok0raV0HSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZE0HFv3pCe3HjqO6bhwHPPS6SmrXyNKyqOgfkNlumc+9ZkCgvFiotng1FFsjORMRVcIV55SfJNIUYPKNaDu9VvuN336cUke4PnAZUw1knbpn7MFALylTSNM2MRe5xMTNQfmalHqwEUT9Ej0iSicQc+JRIPcMlhc1D0krl02Sls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTJx8Kgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6477FC4CED2;
	Mon,  3 Feb 2025 10:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738580074;
	bh=YkJ0iA0PvGBxK73iZc/Ad2T0p6eaIT0zXok0raV0HSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTJx8KgkrceZRHcYKcMgRZkwHfbez+/OI8E9hK35gSOCdTq9ZCeUIWnO52PFc5KTd
	 IapMDTBffRMyMXET+pL5zOtL/+W9zTrNP0xZXuh248zyR6KYqRFWLE+v+OWWvUdq4+
	 11n2RLHmVyF5SKMFxJ5R2yqKhfxRBgKVtbdfcx9T3Tw1CDCAe+FumoHQ2J0QwybDEv
	 Q6BaRVQW2cXZ09AYOcC/tozI0bZIZRRb7NQR3jXPQ5xtUARvqejrkwlo6zBOUq0c/y
	 3AlE+EztJ/79YVrR4QVIdjKP3r/a3ucMmvLwNaGqHCNuZVeskuwN+6etaMAGNcuQ+G
	 rfwOkMr0Rn27Q==
Date: Mon, 3 Feb 2025 10:54:30 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, kuniyu@amazon.com,
	willemb@google.com
Subject: Re: [PATCH net 3/3] MAINTAINERS: add entry for UNIX sockets
Message-ID: <20250203105430.GE234677@kernel.org>
References: <20250202014728.1005003-1-kuba@kernel.org>
 <20250202014728.1005003-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202014728.1005003-4-kuba@kernel.org>

On Sat, Feb 01, 2025 at 05:47:28PM -0800, Jakub Kicinski wrote:
> Add a MAINTAINERS entry for UNIX socket, Kuniyuki has been
> the de-facto maintainer of this code for a while.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


