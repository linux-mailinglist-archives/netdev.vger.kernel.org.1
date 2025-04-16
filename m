Return-Path: <netdev+bounces-183418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16676A909E1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B405F7AEE6C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625F7218AC4;
	Wed, 16 Apr 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln3Kwq1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D04218AC0;
	Wed, 16 Apr 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823915; cv=none; b=CMiplOKp8Pia5GxeGnyclQSxjXw6biHjyAhOGC4wmt7n91vldMoCGb9HxpC6Ql903zp5LzF3m0Dr5b5H3nw8c0lKtQB/84NHNliT8hOpFDUE2kbN7nk8t87hhPw3Yy5WoheyoycZ+kJS6XZqPtbXcdk2tFudJUqcDe+47l9rnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823915; c=relaxed/simple;
	bh=SXq6SDvMNQuDgmWdK1v24CyGZm8PCH/SgWqutxDEBg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv0mM7z5U2vyPE2LLA/JUJs7VGO3++jcWs/y6CCwEy3kTj/KaOjkGOI1j3OmQDMJe4I8NdKsQY8NNBfxrkY7Q2RLzuKquTR2bK60tNQtB422mCo9wGLshdBaOhQWQJcKdqGsWL2vewnMHngrT+5K7PpQzPQrFEwx/y9nVnlA8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln3Kwq1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00816C4CEEC;
	Wed, 16 Apr 2025 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823914;
	bh=SXq6SDvMNQuDgmWdK1v24CyGZm8PCH/SgWqutxDEBg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln3Kwq1mXqaDoH/8hSBc8WPRz+4IsVha6tp0O++U1L6hg4BtQQuPeyGTeFbFjcETS
	 4eP/Zvj/f0uyTFvuyL6b0Yq1XOGIyhPhwGXSUSohDBTiNILKjMXQGihvT4cQkRU8fr
	 5OtCEXZQZtq2vdFyEV4xhfe71ykIc0Sfa7p9cG4OsCUi3EUABTvtE8rBiQmL5UveR9
	 N/bPirn8LeFWtkBHQG2i6qGwaoVGAamgvpG2ByL0QoF6f/VvnuU8LKCUpJZN7o4yGg
	 yTafi5u83malwPUDZWpG13wDzlGp21e2VJl9BsyR2x3AWV7xD1MY3mnqYAn6dP6N/F
	 PadN+iADDVEQQ==
Date: Wed, 16 Apr 2025 18:18:31 +0100
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] net: pktgen: fix code style (ERROR: else
 should follow close brace '}')
Message-ID: <20250416171831.GV395307@horms.kernel.org>
References: <20250415112916.113455-1-ps.report@gmx.net>
 <20250415112916.113455-2-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415112916.113455-2-ps.report@gmx.net>

On Tue, Apr 15, 2025 at 01:29:14PM +0200, Peter Seiderer wrote:
> Fix checkpatch code style errors:
> 
>   ERROR: else should follow close brace '}'
>   #1317: FILE: net/core/pktgen.c:1317:
>   +               }
>   +               else
> 
> And checkpatch follow up code style check:
> 
>   CHECK: Unbalanced braces around else statement
>   #1316: FILE: net/core/pktgen.c:1316:
>   +               } else
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v1 -> v2:
>   - Additional add braces around the else statement (as suggested by a follow
>     up checkpatch run and by Jakub Kicinski from code review).

Reviewed-by: Simon Horman <horms@kernel.org>


