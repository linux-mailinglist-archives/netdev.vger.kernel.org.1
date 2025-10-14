Return-Path: <netdev+bounces-229138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C571BD873F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE3E434AF42
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072F2E7BB5;
	Tue, 14 Oct 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n12pOraa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9022D2497
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434426; cv=none; b=g96JuNUwxmPnYAw1202gWvKMjWXFLOuILrHf0R9b5+feAloZi08BAlLA4yOVf5CDXmw/jQFMRLQHgW69t/HcAmk5gj10CNfnPRmbxvYE9TlXfPPP7WGEKPMtPbLDTvyNUbk8F3voStoLXENQPP4NftTQ5mPSuiR4UA5ooQZ6Y1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434426; c=relaxed/simple;
	bh=1t68mVHBp/WdRDPwnxheJdkgCoDsNF5KZ4j4Y2jtrjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goERyUoY62E59s1tTCb3k5Gg8jzJ5pKY6bGHt+YBiFbmj5jVTfQ6MZ7K5ioqNKFXjEjwXKfG7TkCserIqIloceTyLKAUNZjaIWDZIH+Lb6Qkp4b7rFXnl7MTZePk3RC/4rk0sUGFNWhSrRwcAeVRR1iBD1XaeiWA7mSpJImYL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n12pOraa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50105C4CEE7;
	Tue, 14 Oct 2025 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760434426;
	bh=1t68mVHBp/WdRDPwnxheJdkgCoDsNF5KZ4j4Y2jtrjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n12pOraauFDFFfTURzKK6h/yyY16kiEu7fRyi6cAr5ePv7nyWvgvvIlbVPR4JTpQA
	 4H/0eGhFd1iJj6OoecnSKqUQX1k4q4zRoc2Y03myK9B3TX9VgoaK8gfVetQ6BlFXAq
	 kZ+GTgN/U5MZ5XeMmWnqBwEayUwmDY1GeQxsca0MUJqwMFGl0nfIyXKtZTuakToU7H
	 KsMIEv12IXtnVzwvGyV2nUfvgVR4saD3dHAoeBkrXvjEcTEjE9QRQlL6bSc9yJFniw
	 CU88d+91yvPdnPXAwi8BeEvZgHKVww6sddAo36UvXvRKrF873l2abQbBjodH5tBh1m
	 4rj0dOCQXPd4A==
Date: Tue, 14 Oct 2025 10:33:42 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kernel-team@meta.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: fix various typos in comments and
 strings
Message-ID: <aO4Y9sC1pwgq2kNc@horms.kernel.org>
References: <20251013160507.768820-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013160507.768820-1-alok.a.tiwari@oracle.com>

On Mon, Oct 13, 2025 at 09:05:02AM -0700, Alok Tiwari wrote:
> Fix several minor typos and grammatical errors in comments and log
> (in fbnic firmware, PCI, and time modules)
> 
> Changes include:
>  - "cordeump" -> "coredump"
>  - "of" -> "off" in RPC config comment
>  - "healty" -> "healthy" in firmware heartbeat comment
>  - "Firmware crashed detected!" -> "Firmware crash detected!"
>  - "The could be caused" -> "This could be caused"
>  - "lockng" -> "locking" in fbnic_time.c
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks, this makes sense to me.

Curiously invoking codespell locally only picked up the healthy typo.
In any case, these file are codespell-clean, in my environment, with
this patch applied.

Reviewed-by: Simon Horman <horms@kernel.org>


