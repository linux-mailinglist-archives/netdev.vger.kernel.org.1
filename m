Return-Path: <netdev+bounces-70601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8462A84FBA4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443FB28EDBB
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB837F490;
	Fri,  9 Feb 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="DLedd2OK"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F480BF8
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502175; cv=none; b=ezqoWNZeH4nDZGthvZO0wGftBVvEBfigpDIy8vQdzy71cmIqC6+QRc8omdg6a4AQkLqxTcgxElAyaFQPRU5EeBh6OZsdiMJyPkbm1FjIGHtnfnYetwUBPTlcVaFk2aySPgAqw2YLLxo+xXshMmXBDHwkrAJYu5bw9Aj8iPJQrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502175; c=relaxed/simple;
	bh=jgwtZY6Br+6RQYtM/fWMRBsyktZhTocx/l4vrTqdJig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvLU9OnyilUxuNMdIZAfYOS5A00UESgHkw6ilIuDQpRRpBjWPQAH69owtfpAhxnJeppOtwb74exuirNqdmlAliehPJ3+VhaQAUwfJNCLSsPjHQYLIDNJlb8xdD8M3v/shSvQUqE311f3PXbaOErqvyFA417sN7CUCY2M9xqgXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=DLedd2OK; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XFOWM3XhBimS2qTrXP2fKQ9j7YM3vCfRxVwfTzdYos0=; b=DLedd2OKW8ZaunUoGIfsXzjE3z
	xKNqdNx4cnEdasZYQrVM3J+d5RKNAkKR1nBI02Yv+TKbF5pwoj5AQJMSSywr0RkftloL3lyZRP+Kg
	P6eac6aRsy5WYzZPx2LD5DSK1L8vhLGclsHgV5flEOG/ivnhPxp6AQBRRShHI+OkUqjBitT95GZt1
	BQP28vIGokboKISkegOakmn1OhXd3phuUwU357DgM6bfQ4WfeJInjWAEOPgwSxCp6TU+XpIlxvMLA
	zoV6t19McG7N3oqpIbsMtSa3e+LjXW0PMScwxYfIBzgOpzjMS2/NAJbETVo+VjYDlAF/eEsy/RVLk
	qSMdcjgQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97)
	(envelope-from <phil@nwl.cc>)
	id 1rYVJU-000000002Mu-1TCr;
	Fri, 09 Feb 2024 19:09:24 +0100
Date: Fri, 9 Feb 2024 19:09:24 +0100
From: Phil Sutter <phil@nwl.cc>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC iproute2] tc/u32: use standard flexible array
Message-ID: <ZcZqVDfUeOZsVP6j@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org
References: <20240209170714.370259-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209170714.370259-1-stephen@networkplumber.org>

On Fri, Feb 09, 2024 at 09:06:17AM -0800, Stephen Hemminger wrote:
> The code to parse selectors was depending on C extension to implement
> the array of keys. This would cause warnings if built with clang.
> Instead use ISO C99 flexible array.
> 
> Also the maximum number of keys was hardcoded already in two places.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  tc/f_u32.c | 46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/tc/f_u32.c b/tc/f_u32.c
> index 913ec1de435d..a6e699d53d24 100644
> --- a/tc/f_u32.c
> +++ b/tc/f_u32.c
> @@ -21,6 +21,8 @@
>  #include "utils.h"
>  #include "tc_util.h"
>  
> +#define SEL_MAX_KEYS	128
> +
>  static void explain(void)
>  {
>  	fprintf(stderr,
> @@ -129,7 +131,7 @@ static int pack_key(struct tc_u32_sel *sel, __u32 key, __u32 mask,
>  		}
>  	}
>  
> -	if (hwm >= 128)
> +	if (hwm >= SEL_MAX_KEYS)
>  		return -1;
>  	if (off % 4)
>  		return -1;
> @@ -1017,10 +1019,7 @@ static __u32 u32_hash_fold(struct tc_u32_key *key)
>  static int u32_parse_opt(struct filter_util *qu, char *handle,
>  			 int argc, char **argv, struct nlmsghdr *n)
>  {
> -	struct {
> -		struct tc_u32_sel sel;
> -		struct tc_u32_key keys[128];
> -	} sel = {};
> +	struct tc_u32_sel *sel;
>  	struct tcmsg *t = NLMSG_DATA(n);
>  	struct rtattr *tail;
>  	int sel_ok = 0, terminal_ok = 0;
> @@ -1037,12 +1036,18 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
>  	if (argc == 0)
>  		return 0;
>  
> +	sel = alloca(sizeof(*sel) + SEL_MAX_KEYS * sizeof(struct tc_u32_key));
> +	if (sel == NULL)
> +		return -1;
> +
> +	memset(sel, 0, sizeof(*sel) + SEL_MAX_KEYS * sizeof(struct tc_u32_key));

Maybe a wrapper would clean things up a bit (untested):

| static void *calloca(size_t nmemb, size_t size)
| {
| 	void *ret = alloca(nmemb * size);
| 
| 	if (ret)
| 		memset(ret, 0, nmemb * size);
| 
| 	return ret;
| }

[...]
> @@ -1122,17 +1127,21 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
>  		} else if (strcmp(*argv, "sample") == 0) {
>  			__u32 hash;
>  			unsigned int divisor = 0x100;
> -			struct {
> -				struct tc_u32_sel sel;
> -				struct tc_u32_key keys[4];
> -			} sel2 = {};
> +			struct tc_u32_sel *sel2;

Not directly related to your patch, but seeing this makes me wonder
where the code asserts parse_selector won't exceed the key space.
pack_key() itself only checks it won't exceed 128 keys.

>  
>  			NEXT_ARG();
> -			if (parse_selector(&argc, &argv, &sel2.sel, n)) {
> +
> +			sel2 = alloca(sizeof(*sel) + 4 * sizeof(struct tc_u32_key));
> +			if (sel2 == NULL)
> +				return -1;
> +
> +			memset(sel2, 0, sizeof(*sel2));

The sizeof(*sel2) is identical to sizeof(struct tc_u32_sel) and thus too
small. Another point for the wrapper suggested above, as it avoids these
typical mistakes.

Cheers, Phil

