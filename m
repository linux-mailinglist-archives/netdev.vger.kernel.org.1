Return-Path: <netdev+bounces-198829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA618ADDF82
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966113AF243
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2E2957A7;
	Tue, 17 Jun 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8j89+jY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D02957A0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202390; cv=none; b=sGepC/UKSSaxPEMLX3WxAVnX/dnsQuycmZLqjjXfHRSN6WHRJB6gnui4sl4wv4O7HH9i2LhXzCORIj40YfYaC7FFkmrtadT5SkrevyCmlQ/J437iL4B0OTK+FSkfgi8aazvCMgFTX3U7nEG8j6/QyKnzvBNgQU5HW6rvTspywFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202390; c=relaxed/simple;
	bh=xwErtfx1oZZk5KtXH+yo33f7wFefCput2SOyitQeFc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBm6LY39xzyo3Tvg7WIHDEQHLWoUCM75YxryGTrSxefsryvuM8ROP1EpWIIZR+oEH8F7xH2iXIXIicKColyWOOdXeEj4gAwEb0oLW7jRGmYNkAOsBB+vNJrlEeOG/nKLl/a5Dj3At1zKelX/TiEVmZnnGDmDfml8nF7whQ5tMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8j89+jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A248C4CEE3;
	Tue, 17 Jun 2025 23:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202389;
	bh=xwErtfx1oZZk5KtXH+yo33f7wFefCput2SOyitQeFc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H8j89+jYdF3eO2z6jY1PU9ZYXfnzaZYd1l5CqHpR40YBHFsYWx3mvZHK2nlBULwNQ
	 YQwE33fFU12FXWF6KANceNcGcfZ305rAwqQdrtaMj661082ztZt8ETMEQIfiMjN/jQ
	 9js+I1w+QmwUapwpbWMJ196clA/LNxogdTKp9Z6tfQkoEUoM9YJQa2Ow48JBm7nNs5
	 OeZbe4yn7JOCDQRMnPAFRPsVUQBoHwDNmAK1tutbHFpoLWCUsyPXPwbN/ad/BR2tqe
	 ywMQkOOqrBQ3wkCVldrytIgICwJ32s9tIAL2h8K8aNjkhAl07G7zHoND/Tb696Mqsz
	 fnO1hoVLFRAsw==
Date: Tue, 17 Jun 2025 16:19:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>
Subject: Re: [PATCH net-next v2 1/3] tcp: remove obsolete and unused
 RFC3517/RFC6675 loss recovery code
Message-ID: <20250617161948.3a0ae368@kernel.org>
In-Reply-To: <20250615001435.2390793-2-ncardwell.sw@gmail.com>
References: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
	<20250615001435.2390793-2-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 20:14:33 -0400 Neal Cardwell wrote:
> +	RACK: 0x1   enables RACK loss detection, for fast detection of lost
> +		    retransmissions and tail drops, and resilience to
> +		    reordering. currrently, setting this bit to 0 has no

                                currently ^

fixed when applying

> +		    effect, since RACK is the only supported loss detection
> +		    algorithm.

