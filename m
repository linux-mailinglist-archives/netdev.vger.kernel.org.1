Return-Path: <netdev+bounces-143800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F039C43D9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D01F22EA0
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB11AF0A2;
	Mon, 11 Nov 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgGdRqei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1901ADFE8;
	Mon, 11 Nov 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346619; cv=none; b=XMrphtHsLNSC82FJncJXD54J//q1UQk8WGHTGbe/ClB3qJaCT/IzvLGSpyE0eMQ76HouskQB6YRf/prFFEqmI5FW0WL9/YzIZaPEQsh9quxwncpgXSpbrefvBxcPHCOv8A02AroUnfN+Ned7k7ipO79iMcH+lXNzhLGzEnAd8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346619; c=relaxed/simple;
	bh=P37qWEBbLtz7MY6pyPJCqUtq7fE7VPPx6e5ZFCgP3ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElsxwOYYslC1mbPCr0DJqOYuRmNEsctqaH2kMP6kjxDzMM/DnB8R/1oxS8QJzXrzA7Dz0126pBrsxVlChaZaLn8ROWCFeiT/URh8POvHytsP/stj1uzWZdzVPsTBlQDTOiTjML2BWTdS+wwsexgg5/AznyfipZr5rU+8xW2ohA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgGdRqei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D7C4CED5;
	Mon, 11 Nov 2024 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731346618;
	bh=P37qWEBbLtz7MY6pyPJCqUtq7fE7VPPx6e5ZFCgP3ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgGdRqei3zpr0Dhb9g2Vihv5+HIEKFwenHpmFeNoHq/exSlkIMeSpFgtJddb4WTNK
	 Y2M1SlWZOBKWQZKmBxNF5LO8qwJXqYTpARk5LaElOhD9qby3fi0lB+RIREDndqfXAs
	 oF++HtQotT5n0F5nXKjDpHuRQIUn70Ra93gBNqsp0M5vMmElUvPOu5VpSyx3yil64N
	 OrUIp+aIJAssa50XtBOa0GwhNtUX5cerQXjSEnQEGV+MfMGiawxBcSos24WdfSuPLW
	 A+tdQiqXEkrNT3Xm3zDsacrgkRmIJALSHC9w301H76menfNzNDfYcr9rU5iEzuUzAo
	 V44bHVAGWVosA==
Date: Mon, 11 Nov 2024 17:36:55 +0000
From: Simon Horman <horms@kernel.org>
To: zhangheng <zhangheng@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] net: korina: staging: octeon: Use DEV_STAT_INC()
Message-ID: <20241111173655.GG4507@kernel.org>
References: <20241109092024.4039494-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109092024.4039494-1-zhangheng@kylinos.cn>

On Sat, Nov 09, 2024 at 05:20:24PM +0800, zhangheng wrote:
> syzbot/KCSAN reported that races happen when multiple CPUs updating
> dev->stats.tx_error concurrently. Adopt SMP safe DEV_STATS_INC() to
> update the dev->stats fields.
> 
> Signed-off-by: zhangheng <zhangheng@kylinos.cn>

Hi,

I'm unsure what happened to the other 3 patches of the series
(and the cover letter?), but only this patch seems to be known
to lore.

This path looks like it is a fix for Networking, and thus should
be targeted at the net tree.

	Subject: [PATCH net] ...

And, looking at git history, I think just "net: korina: " would be an
appropriate prefix for this patch. Along with a slightly more descriptive
subject. Maybe:

	Subject: [PATCH net] net: korina: Use DEV_STAT_INC() to avoid race

Next, is there a stack trace available? If so, it would be nice
to include it, succinctly, in the patch description.

And if there there is a public syzbot/KCSAN report it would be nice
to include a link to it.

As for the changes, you mention that the patch fixes a race wrt to
tx_error. But the patch does more than that. Are the other changes also
strictly necessary? If so, I think that should be mentioned in the patch
description. And I'd suggest that any changes that are not strictly
necessary as a bug-fix should be handled via a follow-up patch targeted
at net-next.

As a fix there should be a Fixes tag immediately above your Signed-off-by
line (no blank line in between). It should cite the commit where the bug
was introduced, typically the first commit where it manifests for users.

Lastly, information on the process for Networking patches can be
found here: https://docs.kernel.org/process/maintainer-netdev.html

...

-- 
pw-bot: changes-requested

