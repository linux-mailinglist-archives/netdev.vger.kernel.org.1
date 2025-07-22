Return-Path: <netdev+bounces-209059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D86B0E20C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E5C5453C7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD8227B4FA;
	Tue, 22 Jul 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oToRm12z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87C27A909
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202433; cv=none; b=ThfoCY84+R3OYfdI4GuWPlBkCqj1lqlKTWdcmO4a6iWc+HJo265nyJJsEygx1Z0BWyw7/7Q1Q8qQkVrTfYEPI6/lRzM2e3KgdFh0cYxkiejtqJZmNYM2svKA96jwxJlkLC5AInMEWIEPOj33S5l6ZME2nnJq162tQYb6Ub/s4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202433; c=relaxed/simple;
	bh=qTdNZ00bF/QD6U8ntALkccKt9Ovtrx7ev+aHjkvKWyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUpvLgdyUvXBX4rRBrPGNuHWzqGDsm+7svgmzLghdriMsLB/dDqFuPibETq3w8SXWvqplpNsttqU7kySbUyJd13j/zcT216jVMw5w41Ss18IVcEW+x9elej/w/AnPXiwAO9uP6zzipXlRtGalzkeM1lR3PJu/1I3ZT+T8m9MHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oToRm12z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA51C4CEEB;
	Tue, 22 Jul 2025 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753202432;
	bh=qTdNZ00bF/QD6U8ntALkccKt9Ovtrx7ev+aHjkvKWyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oToRm12z5+cU5QxafgEtl0Fg5r2lDOFplGvKXjMbzasF++1qumc77/MKDBg2xYAyS
	 V8oSvjKBA8inSniDSo6DfUTV7Pg685/cXB1St0yz8aXAVObZj3584ORnfd9XxkPWFI
	 F3G45X5T+bmSogS8Y26xTi9DAjGhG7cGACRLn7nEYxfB/E6bh90A+W4LLOMRxsj0y5
	 ZbLZVw08OvWlUA873fhu/78F1QP4YeiX9Qz+T9gfnlWi+ir1fZht6X7JY6aWHW9LqX
	 lQWlcP6VCxstmkOWqDF0+tGYs/Q8negdPtMa6k0/iesOjg2uP8jdgIxyYoV9qkqZHG
	 aLbOka7+bVrOw==
Date: Tue, 22 Jul 2025 17:40:27 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	lcherian@marvell.com, sgoutham@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 03/11] octeontx2-af: Extend debugfs support
 for cn20k NIX
Message-ID: <20250722164027.GR2459@horms.kernel.org>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
 <1752772063-6160-4-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752772063-6160-4-git-send-email-sbhatta@marvell.com>

On Thu, Jul 17, 2025 at 10:37:35PM +0530, Subbaraya Sundeep wrote:
> Extend debugfs to display CN20K NIX send, receive and
> completion queue contexts.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c

...

> +void print_nix_cn20k_sq_ctx(struct seq_file *m,
> +			    struct nix_cn20k_sq_ctx_s *sq_ctx)
> +{

...

> +	seq_printf(m, "W11: octs \t\t\t%llu\n\n", (u64)sq_ctx->octs);
> +	seq_printf(m, "W12: pkts \t\t\t%llu\n\n", (u64)sq_ctx->pkts);
> +	seq_printf(m, "W13: aged_drop_octs \t\t\t%llu\n\n", (u64)sq_ctx->aged_drop_octs);
> +	seq_printf(m, "W13: aged_drop_pkts \t\t\t%llu\n\n", (u64)sq_ctx->aged_drop_pkts);

nit: please line-wrap the above two lines.

> +	seq_printf(m, "W14: dropped_octs \t\t%llu\n\n",
> +		   (u64)sq_ctx->dropped_octs);
> +	seq_printf(m, "W15: dropped_pkts \t\t%llu\n\n",
> +		   (u64)sq_ctx->dropped_pkts);
> +}

...

