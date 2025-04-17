Return-Path: <netdev+bounces-183744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A75A91CF9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19EE3AD9E4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A594E39ACF;
	Thu, 17 Apr 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU8T60Ew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81712288CC
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894394; cv=none; b=mEDG95bbXVvdygSqmobXWqBwr3nuYXC1CHA+5LFSBI8c/gAXPzmCGTZkuyYcsZ1sYXHy0IOdsOzj8i9w7gad6WMBoKtTx7dsOz31UvSBRPGuVX8GrgeRvk180fsEqxz5ooVJdYte4n+KwRYLOsYMw5gB8reccOvjkKK7EH9m3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894394; c=relaxed/simple;
	bh=zQ6iv/g9cFyIU58sjjLYV9supL/8iBXis76hshfpnj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeA+MmdGFzACwV1CEccARxhUezqUhriYU3gU3gHZ0CiigO5P2W3G4FEBSsgbpYmJqY8K5iFvTFZ4dmNT2SfyfmyKdR+4WNsTxhXd/hoEBHi0R9WyrNGlVenfkHoyeIS+so6bKEKRYZDgv8JZmh5y3QJtFgpak46eXvW5zcJ4leY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU8T60Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D31AC4CEEA;
	Thu, 17 Apr 2025 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744894394;
	bh=zQ6iv/g9cFyIU58sjjLYV9supL/8iBXis76hshfpnj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kU8T60EwwL0Stl+vdeoKHWHvbn+7bizFCJ2JvOtpLWfLrTLh577rMhbfLOl6Qan07
	 FriGKLyPm9VaGfiCOblGiZ42YVouZM085zHgJTtUyEHa8Ja4wbqtv/YpUhWtjU4zGS
	 IjsZdwzFaISxIx7BXWPmwsY0RqvRjRS1PBxbBsnxbBlRx3GmKAUX2NZG0+JM5HbVhZ
	 D9N1R8vUEP94+ww/RiyC3FzKRADoZcTBqisGcVY7I8atuzIQuEKOuoy1LwORYnyAmD
	 MZ5aPHnKxPew5wWRoPkHH1YDqPIWIny1QpqmD96E7+C7smbCtfXHM9La6VqV3BDbA4
	 xRG2r+2IfxAxw==
Date: Thu, 17 Apr 2025 13:53:10 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/7] neighbour: Make neigh_valid_get_req()
 return ndmsg.
Message-ID: <20250417125310.GG2430521@horms.kernel.org>
References: <20250416004253.20103-1-kuniyu@amazon.com>
 <20250416004253.20103-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416004253.20103-2-kuniyu@amazon.com>

On Tue, Apr 15, 2025 at 05:41:24PM -0700, Kuniyuki Iwashima wrote:
> neigh_get() passes 4 local variable pointers to neigh_valid_get_req().
> 
> If it returns a pointer of struct ndmsg, we do not need to pass two
> of them.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

...

> @@ -2893,17 +2892,19 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
>  		case NDA_DST:
>  			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
>  				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
> -				return -EINVAL;

Hi Iwashima-san,

I think you need the following here:

				err = -EINVAL;

> +				goto err;
>  			}
>  			*dst = nla_data(tb[i]);
>  			break;
>  		default:
>  			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
> -			return -EINVAL;

And here.

Flagged by Smatch as:

  .../neighbour.c:2907 neigh_valid_get_req() warn: passing zero to 'ERR_PTR'

> +			goto err;
>  		}
>  	}
>  
> -	return 0;
> +	return ndm;
> +err:
> +	return ERR_PTR(err);
>  }
>  
>  static inline size_t neigh_nlmsg_size(void)

...

