Return-Path: <netdev+bounces-122817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60856962A80
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0634B2446B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98819EEB7;
	Wed, 28 Aug 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U53j9U2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AA19E81F;
	Wed, 28 Aug 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856043; cv=none; b=bymDPbUCgbYVdp16pFUbbuSGA7O498olThhS3rY+AgrAK6szBUYkwu321RzZreZUQwPbhwJakWw6JtLcqJIRG51QfnTHgz65qICp0QZGMuOafpgT63S5zY3gnTJNYxRPx/PAY/hlHWfMBpLMjK1SyD5VtwEg8RVKKP7wmonq1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856043; c=relaxed/simple;
	bh=Zp0WhBS7K+nAzYXjqWAq7s0F1PkS2I4IQGqnaKVbwSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoPo4EBuQYK0FVtyg/Ryb9+37TzD10c7ZXJZP64zg1Xw4MdrC/zN4cr0YBUjT8X/+ETwkf+Jvh/0zTKOqhGK35mX45DyqqSaWa59OXPpiJNv8bumvP2ExF1/dihFm0pUZT/1ah8Z8dRhG/zUVqMg1nBwMxEbcOJNCO4orL1rI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U53j9U2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26648C4CACF;
	Wed, 28 Aug 2024 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856042;
	bh=Zp0WhBS7K+nAzYXjqWAq7s0F1PkS2I4IQGqnaKVbwSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U53j9U2cpucQSZ1bT650HohHg8EFmnI6BnhmsUCtqFw9fAU1UXwe3BL0tUF/Zp68Y
	 S9hxvGr4uBB4D6dHKp8tFsN6xP5/3UwtafyyEa8dTE+m/ah5/+T6LMT6RVPlj/iZan
	 3CJyU/sWwrQF9epddZKGzDFM7x6NWlToAyLB/Yz/dqgq2Q+6k10nrdOVgFtU3BrBTp
	 wkwRS1pKqeQwEAj9i05bXVQibwYrj1oHmWaFWURKvJG6higVgBjvmurjmTrrgGVavg
	 i1ELfDGMXAilh485jxGtH1gwUd5XHD9AG/QEvwlxfu0+G94CG/DFROJNspqPsYNAE+
	 j0l1oJ7bnBRGA==
Date: Wed, 28 Aug 2024 15:40:39 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5 next] net: vertexcom: mse102x: Drop log message on
 remove
Message-ID: <20240828144039.GL1368797@kernel.org>
References: <20240827191000.3244-1-wahrenst@gmx.net>
 <20240827191000.3244-5-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827191000.3244-5-wahrenst@gmx.net>

On Tue, Aug 27, 2024 at 09:09:59PM +0200, Stefan Wahren wrote:
> This message is a leftover from initial development. It's
> unnecessary now and can be dropped.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


