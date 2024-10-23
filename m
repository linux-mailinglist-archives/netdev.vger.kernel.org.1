Return-Path: <netdev+bounces-138205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373FC9AC999
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20D61F2238C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2884B1AB6CB;
	Wed, 23 Oct 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLmmHE30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4519F13C;
	Wed, 23 Oct 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684962; cv=none; b=l3tGmDVPTL+c2hraxOz2x36uyfHoboHsETBtOC/mJEdB5iWp4fa8n/522F8rp/za89rqrGkepxCG25xiEqNAC52KDiANRh4LqdwQ3bLxqGzBl07kGbYUFDFgrbBMlPRdht5JRRKF5c/qmM+JIPi9n1z6ZiN1+z9TbOR8bB5KxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684962; c=relaxed/simple;
	bh=JXY75s2u6rRPudxtXz5fP+1Bnsjq+f7s0nxJfypNBvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmb36HUF79gdz3Wlj1Sq1DPUCQrpbHFHAz4HFprbGLLSqGrcMu/jd2HHW0I1cnAgMfqWyuNb0aOTzfaS0NWuA+WTkzWRcEjjsyZSIqsrUp4rp2o56iLoILL5zxLmyOyKzSOekmHSAQLXxg2CZkB7IGWGGq8azaPgndCOW6w0HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLmmHE30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AF6C4CEC6;
	Wed, 23 Oct 2024 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684961;
	bh=JXY75s2u6rRPudxtXz5fP+1Bnsjq+f7s0nxJfypNBvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLmmHE30MNdMidUIAvLPu6/pyXAM2u588vAzss1L0k5zJJhCgcQcvznT8of5FXDrg
	 m9OOQ9oF3qZwMdI3W2RAnyBt0UJ6mL4A0mzMB4pj91TlwzZAO3yb594fCOJK598+8a
	 75vmcYOgTAYrJhBoI0PDbcfgUjpubbZHvRrN8OE+zUsQgiVdG9xWcN15snJGPScdhm
	 Y3ZxdjsFEawR15u2J2rErqr2BqCj/YwuKjX5ZVX/tGcAYBRvlRX/h6PbCv+5aCyQxQ
	 B/gXYcwlKeXgEoCulSLAs7YpPP3HgaM4kw6UH6nu1LL30aaEKXT7ncw9NSY4sh7wrS
	 b0o/hFQ/P43GA==
Date: Wed, 23 Oct 2024 13:02:37 +0100
From: Simon Horman <horms@kernel.org>
To: Johnny Park <pjohnny0508@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] [net-next] igb: Fix spelling in igb_main.c
Message-ID: <20241023120237.GP402847@kernel.org>
References: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>

On Tue, Oct 22, 2024 at 09:21:28PM -0600, Johnny Park wrote:
> Simple patch that fix spelling mistakes in igb_main.c
> 
> Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
> ---
> Changes in v2:
>   - Fix spelling mor -> more

Thanks for the update.
I checked and this addresses all false-positives flagged by codespell in
this file.

Reviewed-by: Simon Horman <horms@kernel.org>

