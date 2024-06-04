Return-Path: <netdev+bounces-100707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A68FB9F7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D0C1C25032
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC71149C53;
	Tue,  4 Jun 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnbSj/j+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC81494DB;
	Tue,  4 Jun 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520887; cv=none; b=ow0FFW+IoPRR/K79xKfJJqrvrc9laeVIOHv9o9aHh4IV3vlHh10orWBhCCEesQCtEAXOMNFNeB6AB4sX5Ce6QnnQK4C0kYX6ZtgpDuTx/nRGe3g3kFhiu11jA0XYHU58qZFd5bWGEzgx5P81VdbToqeEdje+7QQssWhqHXfcoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520887; c=relaxed/simple;
	bh=54ydihiRs3glxrB7j/VdgJfU7tdLQHeIoW/Ag/kejKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1eSejn7815kzmomLQ2vGEz72187+u53leJf1+fJcWs4kAVgV3RwJOpOaeZYoUFt3cADrn1xc4F59ZgIxTUp2d/gPFdU8qzvitPDVwKyzkieENnuZB9fwOU7QeBtX0W4mA7DiMTxbGgrtiguG/1ZPJe4LmCGXs+Oy14WX1TdQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnbSj/j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ED0C2BBFC;
	Tue,  4 Jun 2024 17:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520886;
	bh=54ydihiRs3glxrB7j/VdgJfU7tdLQHeIoW/Ag/kejKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnbSj/j+GifQ7H4Z4ICILKkdyo0+KlrBQ+gxHcdwdXJ+Q2W49CVb8vW4agM5ba3zB
	 CmAWMTeFiz7Fz500K+4mjrN0fql9jTYK8o0YWXbjoSvtxSKlc+P0esCcSuWQk7E22D
	 Q/hGLntRGrf9TCvgt2Ul4XSt1Zgyy9k2lAwxBFvYH6gcAiApDDMb7Eyon8UR9dxoYc
	 b2qI0MD4VjZvPMEKW2RRHlcTAgL0O16zmp6clO90EDe5mMZ42AghgGH3gpD6NATU8H
	 MXcxD8fIopZYm9VAE5gh5U3MQC6bVUBwxAawjizw9zjBptsNsdWuMlAzcweN/MJf2X
	 1K1U1p6ioIdtg==
Date: Tue, 4 Jun 2024 18:08:02 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rds: remove unused struct 'rds_ib_dereg_odp_mr'
Message-ID: <20240604170802.GC791188@kernel.org>
References: <20240531233307.302571-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531233307.302571-1-linux@treblig.org>

On Sat, Jun 01, 2024 at 12:33:07AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'rds_ib_dereg_odp_mr' has been unused since the original
> commit 2eafa1746f17 ("net/rds: Handle ODP mr
> registration/unregistration").

nit: Maybe commit lines are best not line-wrapped.
     I'm unsure.

> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

