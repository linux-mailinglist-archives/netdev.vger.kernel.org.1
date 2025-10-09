Return-Path: <netdev+bounces-228417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF5BCA246
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E95E3E083D
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3922A7E0;
	Thu,  9 Oct 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="RFC3ufez"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEE1E1E04
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026689; cv=none; b=YS2rDPRxLT7rlf9UmfPcjT0srNa/DX5V9mf31smUBJdT12oAA30sa77xofOcxbDFGuO5az7I6cfKcmDvtU/fAx+TAhk/xHQSwsdzALmsS4ZbHtkYc9ovAIE9aaHqtlX2fAein6Eefz8HD8UWYNcsA25c0mmhXfLrgWcjVrbhCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026689; c=relaxed/simple;
	bh=W67vTmrsYh6ioc3TPmM1/PN+zzN5kNCzEFDvZm3korY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=q1dkfrGONOxX8ELuG/AN9zv4gn19cMapHfO9IHcpd4/dLCFeLjgDT0GP1QfalOsBWWyRiqbTy7Ed/Pz26NrbnuWIk3q0XLdB040T2hg97wOCwlH5SXnfke24WohMmmgh0fmKDkXg1DAk0T9xTe2gBMlGQMewcZwF/0zTeprrQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org; spf=pass smtp.mailfrom=pmachata.org; dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b=RFC3ufez; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cjFQv4CSWz9v6w;
	Thu,  9 Oct 2025 18:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1760026679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DP1mtsYsSXLzCSMmFGYExwu1vKSH1khVfWyAj29Tkqk=;
	b=RFC3ufezZ4P4SVVnzvIhzwWgLO347+8VyLL3oxc3qW2EJjeI7QgMOTBztjKFEMHI+mT6N8
	Z78PTxJBROPvM4Aj31b+P616iAijkOsntFsSu+8bfIY0X7XrPPPcXEXJ0ZD7NAfVqVMGTm
	GClgCC2kRDuZELJNVAssEl3tZH752XjSef6eFXJsYalEafN/SJC4LJE0JZOnmGZdjoKTj3
	BgmGlpril+p5nsSF1KIO6pUs+F4W6Nvh7ZBBkYtD/tecP88wsPlCoSaQwJTjfqdEwIfucb
	ubqcGc1+qd/EORrX+aYQRehjbsSL51OOwos3y8MQitY9p+R4CFw0YZkIwB3dXA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of me@pmachata.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=me@pmachata.org
References: <20251008031640.25870-1-zengyijing19900106@gmail.com>
From: Petr Machata <me@pmachata.org>
To: Yijing Zeng <zengyijing19900106@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, me@pmachata.org,
 kuba@kernel.org, yijingzeng@meta.com
Subject: Re: [PATCH] dcb: fix tc-maxrate unit conversions
Date: Thu, 09 Oct 2025 18:01:57 +0200
In-reply-to: <20251008031640.25870-1-zengyijing19900106@gmail.com>
Message-ID: <87frbscamm.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4cjFQv4CSWz9v6w


Yijing Zeng <zengyijing19900106@gmail.com> writes:

> From: Yijing Zeng <yijingzeng@meta.com>
>
> The ieee_maxrate UAPI is defined as kbps, but dcb_maxrate uses Bps.

Hmm, indeed, "values are 64 bits long and specified in Kbps to enable
usage over both slow and very fast networks". Good catch.

I think that if anyone actually tried to use this in the wild, the issue
would have been discovered and reported already, so this might be
actually safe to fix without breaking the world.

Thanks for the patch. I have a number of relatively minor coding style
points. Please correct them and send v2. You may want to pass the
candidate patch through checkpatch:

 # ../linux-source/scripts/checkpatch.pl --max-line-length=80 the.patch

> This fix patch converts Bps to kbps for parse, and convert kbps to Bps for print_rate().

Please wrap this line to 75 characters.

> Fixes: 117939d9 ("dcb: Add a subtool for the DCB maxrate object")

This should show 12 characters of the hash.

> Signed-off-by: Yijing Zeng <yijingzeng@meta.com>
> ---
>  dcb/dcb_maxrate.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/dcb/dcb_maxrate.c b/dcb/dcb_maxrate.c
> index 1538c6d7..af012dba 100644
> --- a/dcb/dcb_maxrate.c
> +++ b/dcb/dcb_maxrate.c
> @@ -42,13 +42,16 @@ static void dcb_maxrate_help(void)
>  
>  static int dcb_maxrate_parse_mapping_tc_maxrate(__u32 key, char *value, void *data)
>  {
> -	__u64 rate;
> +	__u64 rate_Bps;

Lowercase this, please.

>  
> -	if (get_rate64(&rate, value))
> +	if (get_rate64(&rate_Bps, value))
>  		return -EINVAL;
>  
> +	/* get_rate64() returns Bps. ieee_maxrate UAPI expects kbps. */
> +	__u64 rate_kbps = (rate_Bps * 8) / 1000;

Keep all the declarations at the top of the function, please.
Make sure they are ordered longest line to shortest (RXT, reverse xmass tree).

There's a small concern regarding the * 8 overflowing (likewise * 1000
below). But it's u64, I don't feel like we need to really worry about it.

> +
>  	return dcb_parse_mapping("TC", key, IEEE_8021QAZ_MAX_TCS - 1,
> -				 "RATE", rate, -1,
> +				 "RATE", rate_kbps, -1,
>  				 dcb_set_u64, data);
>  }
>  
> @@ -62,8 +65,11 @@ static void dcb_maxrate_print_tc_maxrate(struct dcb *dcb, const struct ieee_maxr
>  	print_string(PRINT_FP, NULL, "tc-maxrate ", NULL);
>  
>  	for (i = 0; i < size; i++) {
> +		/* ieee_maxrate UAPI returns kbps. print_rate() expects Bps for display */

This line is too long.

> +		__u64 rate_Bps  = maxrate->tc_maxrate[i] * 1000 / 8;

This variable can stay here, it's start of the block, but it should be
lowercased.

>  		snprintf(b, sizeof(b), "%zd:%%s ", i);
> -		print_rate(dcb->use_iec, PRINT_ANY, NULL, b, maxrate->tc_maxrate[i]);
> +		print_rate(dcb->use_iec, PRINT_ANY, NULL, b, rate_Bps);
>  	}
>  
>  	close_json_array(PRINT_JSON, "tc_maxrate");

