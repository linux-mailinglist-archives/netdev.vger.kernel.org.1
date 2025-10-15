Return-Path: <netdev+bounces-229683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A8BDFB42
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E81B3BC2B4
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8612F3C31;
	Wed, 15 Oct 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfC89rgC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DD338F52;
	Wed, 15 Oct 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546369; cv=none; b=doWjuTDT5NjJwT1NuVy32q/g3LW+hY20RClzOOeicgSYdLOERni5GxqOtc+Up49MVthseSWs3cMrAe6xa/azuEUQG8qAOz8WZQGmGby2IImn/ImJfmuvy5wxORHTOINjLlfKfqtXZfGtUM7wGFO7c5u+Dd2OW/L3EuxVYOiqZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546369; c=relaxed/simple;
	bh=HV9NwvWL4EDdRVNM9YXPzSHAC0plgc4YGZuCjbhJgxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUv/mQKTwx/1V++sLN1HXwbtpf/KjO5QtN/9mWNJoL8c8+m/VtQKEXNIdbcWNlcjiBdDmu/AeezNl4SGk5ruogsFULDaGe25Os8XJdgFBOkFOto/kZZYaipN7vcwSs6hGflLT8AYzgcRVEh5yerdgBDgOHu8P9Lq6zAO6eOB86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfC89rgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F220C4CEF8;
	Wed, 15 Oct 2025 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546369;
	bh=HV9NwvWL4EDdRVNM9YXPzSHAC0plgc4YGZuCjbhJgxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfC89rgC4v1JRG79tdR6L3gI7okRx4RDp/49z5LEXfvgWkFk9TWnmV9eCKxndFfG7
	 ZuXsC8nUeu1NC1/1R4xFuwjNJia8o1bJ/PTLXq08mF/EYM8ZGYKOhuVOsIOGRbwBLs
	 n87CpXHVG2OU2c10ge/BwoLKRnRq+novYgbXyxvWZBke+OxqvLX8dqoSK7jGPlPe7F
	 dYIlzCUrAnYYnw7V3LxeZG/pixK5HL2fimiuAoNe4AglR/dofQf2mn0T2DbhLxyIZY
	 JOHd3+aYjUpU3dmvvTAbSt09EhHAwiyVasKe93xOyne1pBYGYHpUgduoOoyYQNFhkF
	 kmlNr46/r8j2Q==
Date: Wed, 15 Oct 2025 17:39:24 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vasudev Kamath <vasudev@copyninja.info>,
	Krishna Kumar <krikku@gmail.com>
Subject: Re: [PATCH net] Documentation: net: net_failover: Separate
 cloud-ifupdown-helper and reattach-vf.sh code blocks marker
Message-ID: <aO_OPBukiAjmO43g@horms.kernel.org>
References: <20251015094502.35854-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015094502.35854-2-bagasdotme@gmail.com>

On Wed, Oct 15, 2025 at 04:45:03PM +0700, Bagas Sanjaya wrote:
> cloud-ifupdown-helper patch and reattach-vf.sh script are rendered in
> htmldocs output as normal paragraphs instead of literal code blocks
> due to missing separator from respective code block marker. Add it.
> 
> Fixes: 738baea4970b ("Documentation: networking: net_failover: Fix documentation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/networking/net_failover.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/networking/net_failover.rst b/Documentation/networking/net_failover.rst
> index f4e1b4e07adc8d..51de30597fbe40 100644
> --- a/Documentation/networking/net_failover.rst
> +++ b/Documentation/networking/net_failover.rst
> @@ -99,6 +99,7 @@ Below is the patch snippet used with 'cloud-ifupdown-helper' script found on
>  Debian cloud images:
>  
>  ::
> +
>    @@ -27,6 +27,8 @@ do_setup() {
>         local working="$cfgdir/.$INTERFACE"
>         local final="$cfgdir/$INTERFACE"

Hi Bagas,

For the above maybe this is more succinct and intuitive:

Debian cloud images::

...

