Return-Path: <netdev+bounces-175706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D6A67322
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2473B03D4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F620A5D8;
	Tue, 18 Mar 2025 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djb39rZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA9204F80;
	Tue, 18 Mar 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298578; cv=none; b=WSWOsdbWFdqKZmYM1Mc0HOygqZBSEeg/PzqKNz8aj7CKvy48a+IdWvGRQixvv1l49HPHHewRo7YHm7yqayi1EphSfEc7Y1VYshXogO/45OFxyXP8scYFow/XTsZWrX8tEmPnGfrVHDYJCEJhvIkYRbymzLj04+d0JxxRY7+x9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298578; c=relaxed/simple;
	bh=/7gUA5wr5lSbtn6XGDFZQHcPv+nxkvvS/+Cn6cdpAGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6DlpMz/ztiogRp3Eo4v6rKSKcmtK4/0LlOwMinZORf/SKOJw51PBnGlme1YTpIEX44b7Zni4QJdQd/CYX4X9Y8spDlYsthOGV1Yib5egbyac5pFf76Wya911XGS1JHNspsw4dDrFb8ySeb+7KwBw/2chek8tYnxioUh6pAB4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djb39rZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4FFC4CEDD;
	Tue, 18 Mar 2025 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298578;
	bh=/7gUA5wr5lSbtn6XGDFZQHcPv+nxkvvS/+Cn6cdpAGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Djb39rZS2Mg8xNI28sjEjETHsq7/6lvK38g4NtBsxaYxey/r4QYHSmiObWHcF/mBM
	 P84kePUcEam/V90h5POW8rIFJVJnI4xKjJn6lQtXJOQhI5BJ5O5oiZyWDcReHioIT8
	 dRkLX07l9F/iYFjaNoBakjG/SZeJxFr17cryMUkWxENDrLXRkisaL71PUP8z3AT3f6
	 6avd68fUhyAFj6IXbTEXFxpN16Fuo88lSwrV+TP+VsbJEtlr2rYaWbUtcS+ahA87zU
	 XmkWuCzRFIkNoI9z9P3kHjlUV92tuX5mgFz35H7oICvOSqU2o3GV7cZcu/qf9QnJSQ
	 M1fbu9ZtFGDZQ==
Date: Tue, 18 Mar 2025 11:49:33 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: macb: Add __nonstring annotations for
 unterminated strings
Message-ID: <20250318114933.GP688833@kernel.org>
References: <20250311224412.it.153-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311224412.it.153-kees@kernel.org>

On Tue, Mar 11, 2025 at 03:44:16PM -0700, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org/
>  v2: switch to __nonstring annotation
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/ethernet/cadence/macb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 2847278d9cd4..003483073223 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1027,7 +1027,7 @@ struct gem_stats {
>   * this register should contribute to.
>   */
>  struct gem_statistic {
> -	char stat_string[ETH_GSTRING_LEN];
> +	char stat_string[ETH_GSTRING_LEN] __nonstring;

Hi Kees, all,

I see where this is going, and I have no objections to it.
But a member called *_string which is annotated as __nonstring
does seem a somewhat unintuitive.

>  	int offset;
>  	u32 stat_bits;
>  };
> @@ -1068,6 +1068,7 @@ static const struct gem_statistic gem_statistics[] = {
>  	GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
>  	GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
>  	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
> +
>  	GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
>  			    GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
>  	GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
> -- 
> 2.34.1
> 
> 

