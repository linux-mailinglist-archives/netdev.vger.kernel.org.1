Return-Path: <netdev+bounces-70795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8057850789
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 01:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0471C218E2
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 00:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A810EF;
	Sun, 11 Feb 2024 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b="21WLuLlh";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DzUp40o2"
X-Original-To: netdev@vger.kernel.org
Received: from e234-100.smtp-out.ap-northeast-1.amazonses.com (e234-100.smtp-out.ap-northeast-1.amazonses.com [23.251.234.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24132A38
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707612993; cv=none; b=c5a59FFuGiPqaz/krnCX6bD8kf6OENadkM+/1uwzYSQL4PRhCnnQe779T0JyUfF25bWbnJ+jJjllVYbtmAAS0dWRddZZTvH1P376mckUXVWHRfUyFZqLOcwMx/5cWdQsJlkb1FIt69CEElc3xYPxg8deNONybTdiymHzHjOaFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707612993; c=relaxed/simple;
	bh=fnfY3bmYFyN0LRWagLFNHBKK7LzelgDIJg+px2OGCik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuphx8iDgbc9d3jaOsSpcIYpbFZc2OvKHIPfIVw2oIhVZBnrGKhal/4ZHXbbOq5In4hGMlA2cfORweqrSan+cqUpvArE2cX3C9Gm0tuYLdbw3gs1YNL9x4TiWw3xGxIIi5YApmdsGn4Zm1OvZ69GIBwS4m1O0u67rXVCsoZQSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com; dkim=pass (2048-bit key) header.d=hrntknr.net header.i=@hrntknr.net header.b=21WLuLlh; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DzUp40o2; arc=none smtp.client-ip=23.251.234.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hrntknr.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-northeast-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=otpfqkfjftndw3gmuo745xikcugpdsgy; d=hrntknr.net; t=1707612989;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=fnfY3bmYFyN0LRWagLFNHBKK7LzelgDIJg+px2OGCik=;
	b=21WLuLlhHY8Kmra1B+Z2811vrRzzecyYaaq0NT/ahMJP/Jv77AGrOkkh3AC7fK3r
	fMxjpf8KcEihDgvaM1rZHbX3buExKGISCdX1PDMlNpZfE9LAVSvZI83cAusdzW02P//
	mPTdH19QZLBmfpEyRQWDYPiq2Za+sjd/MCP3X7QKdtDTGkxJwF8G+5E7Pyey3C8lnZ2
	ShW4HjJoJYR7GY3ZIsoINW6cFW6Sa3sadwwvuAhzjqvh5peLcOqu7jUjzNFsA7accPi
	xZ9tiOrkEXy3Wm7Jp1Ytvcle/xrTTn6OSpStenYrSqTaney1A36T1JhJP1JoUNuFLLS
	vh2Fs4z0ng==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1707612989;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=fnfY3bmYFyN0LRWagLFNHBKK7LzelgDIJg+px2OGCik=;
	b=DzUp40o2WzN/ln7SghXUS9nsiYpqXPZS2hK7/MnvGxmFjJy2XAadU5E1X+xp2cOo
	c8LkNVlCzcN0e9hg+uGkbv/EkpMz0QmoZYXLd/0YpLxUlgjJsPSrw07Tz3WOkfsjQ2B
	W6SS3hA1lJ2gpsDcvkFVG0Z9LohQFuyiqMB3numc=
Date: Sun, 11 Feb 2024 00:56:29 +0000
From: Takanori Hirano <me@hrntknr.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] tc: Add support json option in filter.
Message-ID: <0106018d95aa6929-b0f30ab9-f719-4208-9f1e-f5738423d095-000000@ap-northeast-1.amazonses.com>
References: <20240209083743.2bd1a90d@hermes.local>
 <0106018d927d04ff-efbd5d4b-b32f-4b39-a184-a28939608096-000000@ap-northeast-1.amazonses.com>
 <20240210092107.53598a13@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210092107.53598a13@hermes.local>
Feedback-ID: 1.ap-northeast-1.rx1zlehJXIhTBJXf7/H1gLdwyBf0eKXp6+AKci1nnIg=:AmazonSES
X-SES-Outgoing: 2024.02.11-23.251.234.100

On Sat, Feb 10, 2024 at 09:21:07AM -0800, Stephen Hemminger wrote:
> On Sat, 10 Feb 2024 10:08:03 +0000
> Takanori Hirano <me@hrntknr.net> wrote:
> 
> >  	if (tb[TCA_FLOW_MODE]) {
> >  		__u32 mode = rta_getattr_u32(tb[TCA_FLOW_MODE]);
> >  
> >  		switch (mode) {
> >  		case FLOW_MODE_MAP:
> > -			fprintf(f, "map ");
> > +			open_json_object("map");
> > +			print_string(PRINT_FP, NULL, "map ", NULL);
> >  			break;
> >  		case FLOW_MODE_HASH:
> > -			fprintf(f, "hash ");
> > +			open_json_object("hash");
> > +			print_string(PRINT_FP, NULL, "hash ", NULL);
> >  			break;
> >  		}
> >  	}
> 
> Since this is two values for mode, in my version it looks like
>  
> +static const char *flow_mode2str(__u32 mode)
> +{
> +	static char buf[128];
> +
> +	switch (mode) {
> +	case FLOW_MODE_MAP:
> +		return "map";
> +	case FLOW_MODE_HASH:
> +		return "hash";
> +	default:
> +		snprintf(buf, sizeof(buf), "%#x", mode);
> +		return buf;
> +	}
> +}
> +
> 
>  
>  	if (tb[TCA_FLOW_MODE]) {
>  		__u32 mode = rta_getattr_u32(tb[TCA_FLOW_MODE]);
>  
> -		switch (mode) {
> -		case FLOW_MODE_MAP:
> -			fprintf(f, "map ");
> -			break;
> -		case FLOW_MODE_HASH:
> -			fprintf(f, "hash ");
> -			break;
> -		}
> +		print_string(PRINT_ANY, "mode", "%s ", flow_mode2str(mode));
>  	}
>  
Thank you for the v1 merge.
We will send the remaining diff as a separate patch to reflect your review.


