Return-Path: <netdev+bounces-230153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3ABE4917
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9A33B39DF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463E329C6A;
	Thu, 16 Oct 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRZfZSY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC75329C58
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631940; cv=none; b=YNYq2xIz1Feng/HbIx5IFLsr6r3XGrMVIghZetPXEcgdnCDbmyjO25+dQoU+D6BTIoMHKeQ/i5yXxl9gelfOvl4NRN8TVzBEbf6TsP2oXNNHzJjLVZqTx7MHy9VAmcsZ6HloBUNy3kDVFiE5wuavlo1PQXVElJNh6fcSWedSdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631940; c=relaxed/simple;
	bh=C5bfVnVieDnVvuFLtLPDnPLoc3SZgQ5zz39FOjIOY9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSC8iAH64D5yENmIwJvwGfem5GTBrgpkh8qPjcS8jTGtUqp2ZJD7GkyZGHrCWhPW8tsNB0y6PcU/az0lNMy177R6bQrB3pgw2kgzIHLaTy8Ga/mxWLEIhi0rOVmjYUzQTls/2yOQ0o2zusosJsdGcyI5ywFIGJzVKGJgsMJLDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRZfZSY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A9C4CEFB;
	Thu, 16 Oct 2025 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760631939;
	bh=C5bfVnVieDnVvuFLtLPDnPLoc3SZgQ5zz39FOjIOY9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRZfZSY1eNbF1F4KK7xw9HKIqkyO8iQEwa9bQHboU5L68UIo1mX1o/ElOEh7Eqign
	 X2mW4EefZYxocofQgsBQJlx6aoIQBxLTvtyynVdg5IcprFj1O9shfCv/qX+NIj6Hog
	 MNjfiI7I/DUpHeiCmHWfDPdmRw9t5sJoYctNQk+7Pkrf2d8ruzx6NzrV2PvgLw0PQE
	 V6ccWG89ITdlqPAHkOYOSve8wDs5oJoQLHB5aysJmkeL/I+Z7rHi1wD5S7ic34qLzg
	 JcC6nRWiCkV7x0LPL+om2pOscsTOn9/u++5vHQvYhcNYDsq/r+13hJ3uvhPeavwFEP
	 RwzNYIAmhPWSg==
Date: Thu, 16 Oct 2025 17:25:37 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: Build commit for Patchwork?
Message-ID: <aPEcgcsqFJAEYD_2@horms.kernel.org>
References: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>

On Thu, Oct 16, 2025 at 09:07:09AM -0700, John Ousterhout wrote:
> Is there a way to tell which commit Patchwork uses for its builds?
> 
> Patchwork builds are generating this error:
> 
> ‘struct flowi_common’ has no member named ‘flowic_tos’; did you mean
> ‘flowic_oif’?
> 
> (https://netdev.bots.linux.dev/static/nipa/1012035/14269094/build_32bit/stderr)
> 
> but the member flowic_tos seems to be present in all recent commits
> that I can find.

Hi John,

I'm not sure that it's explicitly exposed.
But if you look at one of the builds for the 1st patch of the series
then it will start with a baseline build (that is, build of the
tree the patch-set is applied on top of).

In this case, looking at the URL below, which is linked from
the first patch in the series in Patchwork, I see.

cb85ca4c0a34 ("Merge branch 'net-airoha-npu-introduce-support-for-airoha-7583-npu'")

https://netdev.bots.linux.dev/static/nipa/1012035/14269097/build_32bit/stdout

