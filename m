Return-Path: <netdev+bounces-217873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F01B3A3DA
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C947ADE7E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF625A359;
	Thu, 28 Aug 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+yN0kWa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D82594B9;
	Thu, 28 Aug 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394057; cv=none; b=tz13esB7ZZiJJGa5JU/T1ETIr1O3lW6lt9Hq88A8iwy5gp5JXuwIYvYgFnkZs1p4NwpDQTWVppWgExFgkpo5lcnuiOixMiZuoPiI4S7qOuNjRGvnTPkpPiNK1SdyCFALLvejb6k2eP/oAgR6SNRxrSEiATetJjw3dLWQMUNog/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394057; c=relaxed/simple;
	bh=gndeF+vhib0mU+Pk2BD0WCwMGuEN3ZORonMKaxfoE04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7OHnlFaCjZCzs5xt2F0fZ/lPm0pOvCyyJOJo/3pFKvofHiTmU2+WAbVIB8P+Qd2DNQiWLzRpXdiE+4hZg8TXCZ7qSmxxE5wmQVvvLfl5/a6SLc6szoOqyKScxDgGEHn3WnJgV6oAdda3DOPa7uj6G+y36y5PTyWFw9aaZGAVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+yN0kWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26459C4CEEB;
	Thu, 28 Aug 2025 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394057;
	bh=gndeF+vhib0mU+Pk2BD0WCwMGuEN3ZORonMKaxfoE04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+yN0kWapSWMzK74XWB0ZF01sWE/YgDTr61wfaZkfJyeQok8+q/YtKP/IBlXwJmJS
	 WGpTLSp+yAeJbJHTeN4Ge+vksc0kXRPjkw4IoPIdFFYyby5AlVFtOXdW1VqyoJ6VJw
	 lZzpXFMKMIkRm76Sk8kv/1bdmhC2M5J9JkQCgk2XlJitSvAuxGjK278pxbqtV/CkVS
	 LBUU9G0pdD3Il4hiexv62wbYMFZg9Jxn3AyINHknlKgY/2qoYW48CxnT0Y2Nsa3fNo
	 S1cNryBuJNH6Bhx89dM6nS5H8yWlTm6oT7Q5uIeQB4mOsyaZUJFpgt2sVRmuQne1ZC
	 aCljY0ITwdsTw==
Date: Thu, 28 Aug 2025 16:14:13 +0100
From: Simon Horman <horms@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:HUAWEI ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: hinic: Remove redundant ternary operators
Message-ID: <20250828151413.GO10519@horms.kernel.org>
References: <20250827121413.496600-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827121413.496600-1-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 08:14:12PM +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr


