Return-Path: <netdev+bounces-223509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D948B5963F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0407F2A316D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEBD2BE034;
	Tue, 16 Sep 2025 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/ljuU8E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F12298991
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025908; cv=none; b=bZdhuHDvFBlcwH1wFzmKtIdq37SnPqx8P/WOesy1j8pYb7qPD3p+Z5tWMZrbTreTGPIZLkWCXVZ6+oRDaA+Q+RoYpdD30dV08G2f6RKsJICb8seBSHEcIuSZj4CHA6dSgpuTKnJ41dJngqMtCwLiyiGfsKPYITLgt1QXz8u26zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025908; c=relaxed/simple;
	bh=jZWMRY9mUhPPrj6oZ8u8ZvwgE9DdtUy1L7lAUtkCW4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKeZIIBjbOxWSwGI4z9c/oK5vqbk7HGL5iqkaGbkcCU6ANY9OsvM7yqaXXq5s8hGAVa5F4A6kBy9/fDUWK8lU7akgLjALBWoD9TYRBxuIZBQCcEYvzM5KKgFmiiCKKLSE4UvtQMdXksNvDBcGT8TNxi846JZYLc0cxU8hJrB1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/ljuU8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB2FC4CEFA;
	Tue, 16 Sep 2025 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758025907;
	bh=jZWMRY9mUhPPrj6oZ8u8ZvwgE9DdtUy1L7lAUtkCW4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/ljuU8Ep7u3m7cHpJzV5q0AJzs9lrKaiZi5jTGHTF+eWHFmnwVECVVOA5HWekrMy
	 8CqDHWr8P/yxuj1vYrM6Y2k0ffpodjrWESQCe8ABq7r8LmDIVuKMMGRTWGdfq5MCeo
	 P0BH92DW877OiUxSyG2seNnidtNpmTkw472KZaIo2XClgGOcfUYnrx3ugn0Mzv7k77
	 zIM1mEOTQ9XYLwk6qPIGE4dL40n0vyEYgYYR5tHUx8BSncqwFBl+pd4eDS/8v9YLDd
	 1zy55kHqK1BCxctR2++drstDO6PtXBzQVchbcSsy9rPZ8cbI3U/iMxRqETVJ18EGyM
	 Eh2Mmb+B6grOQ==
Date: Tue, 16 Sep 2025 13:31:43 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 1/9] eth: fbnic: make fbnic_fw_log_write()
 parameter const
Message-ID: <20250916123143.GY224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-2-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:04AM -0700, Jakub Kicinski wrote:
> Make the log message parameter const, it's not modified
> and this lets us pass in strings which are const for the caller.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


