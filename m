Return-Path: <netdev+bounces-219341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E9B41064
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07DC5E5E60
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544F277814;
	Tue,  2 Sep 2025 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oxh3Cz6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF875275B1B;
	Tue,  2 Sep 2025 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853855; cv=none; b=E0TpzdXTAU/Bvc37vzgGvn8usLlT3Rg8IeHI9KLm76J1QTqBpoxvFqeItwkN9FdY1hFdx7wTefTpzYL41JNBOGp86mn43ji2TgUAQbGTQS4lBjI3rbgq6GVXAnBKJrvd6htDTfnFWH4Na6uNKTHtvxCWqhTo7zd3n3DgZEILCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853855; c=relaxed/simple;
	bh=FvxqjqBSAA3rroRPaw3cA0fLRMTiwbEBioineSL6S2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/bUR5bRQtMq5Cc+zRdzRbfNWjINxd788oCK3vyYq8kY42F7PIatTm99Tg/PNcFwEGI8RepprnvkBqrEnngil2Sx1JtZ48E0d270HJmrY6oohLHypiCcGFxyeJ0Oh0udKxa2Gz526ZJkgtDCuRavJoxl4ctB/5zIBQcWZ28E7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oxh3Cz6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F66C4CEED;
	Tue,  2 Sep 2025 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756853852;
	bh=FvxqjqBSAA3rroRPaw3cA0fLRMTiwbEBioineSL6S2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oxh3Cz6ZWiu1TNdgFIyXWPC1tQFEyai1+y76xpfVy1J7Ewhg0XzFUX8KNlpjMNL92
	 ADsXmHUsLar8/o/OM2DeaaA5juBFF5of0mSGJOrm1xcbRRTHdtnQMk50yXVFhdtn04
	 tdoIs+mHih76QZeuqcBoxcgk3lKXC4sbg2zdGtSAiAd7b6+fS+AWn21aa64cmFv8ns
	 qdHF6maWl0/QnKHGwZPb1tYqF4CBoSI94vlsIFvzZvLlvSKRlRaA9eJ2F4S8F+8eE0
	 At/9y3y82Ro2NtDqdE/9LGH/7tQFW3WeSrhHZowNmOHvfstDJr7t0YgKvAiw35ZIPQ
	 ufEG0/hiFo5sg==
Date: Tue, 2 Sep 2025 15:57:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Conley Lee <conleylee@foxmail.com>
Cc: davem@davemloft.net, wens@csie.org, mripard@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: sun4i-emac: free dma desc
Message-ID: <20250902155731.05a198d7@kernel.org>
In-Reply-To: <tencent_1489A82090ADCB83FAFDAD60B4D46B2BAA05@qq.com>
References: <tencent_1489A82090ADCB83FAFDAD60B4D46B2BAA05@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 15:49:46 +0800 Conley Lee wrote:
> In the current implementation of the sun4i-emac driver,when using DMA to receive data packets,
> the descriptor for the current DMA request is not released in the rx_done_callback.

Please wrap the description at 74 columns.

> This patch fixes this bug.

Please use imperative mood, "Fix this." or even better rewrite the
whole commit msg to be imperative.

Since this is a fix please add a Fixes tag.

