Return-Path: <netdev+bounces-35394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E697A943D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C161C20A0A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040BAD5E;
	Thu, 21 Sep 2023 12:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E73AD49
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA3C4E67B;
	Thu, 21 Sep 2023 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695298935;
	bh=fQu6GvJDZbSLIMB2LytnPhxIQsfdrcgJ3S+/YdRzesg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSwpSpBf/7jR5NG6dUnG39SjsTUtv1N0KcqXj9q1ML2w6VkpGAxNitpN4U9ZQo06X
	 X97lOLK8c0i+2BgycJpyyJ4SlU96Je5hWlmXrTkt0RZG9k1KgsAlIzB+kfiL37LZd9
	 nxDM7fxFoTMGVnJuWEkRSRnNEztBJqtkoY1uYRHFHSRaxsqMQ3I3k1eU/tzcVn8BKP
	 P+uzLDDyxiiYrLovjduHZQRSVfpwTR3eiG6psskHO39LTvVUq9lHmsqwGsAXET5Cji
	 thtXOWuVpQ/V23+ec68qNDDX+IJlXrs67sKihAoQhU6lKZU6WXOX0GrcLjaXMW3D6U
	 RXGi+tteWc/8g==
Date: Thu, 21 Sep 2023 13:22:08 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, nharold@google.com, lorenzo@google.com,
	benedictwong@google.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next 0/2] xfrm: policy: replace session decode with
 flow dissector
Message-ID: <20230921122208.GL224399@kernel.org>
References: <20230918125914.21391-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918125914.21391-1-fw@strlen.de>

On Mon, Sep 18, 2023 at 02:59:07PM +0200, Florian Westphal wrote:
> Remove the ipv4+ipv6 session decode functions and use generic flow
> dissector to populate the flowi for the policy lookup.
> 
> Changes since RFC:
> 
>  - Drop mobility header support.  I don't think that anyone uses
>    this.  MOBIKE doesn't appear to need this either.
>  - Drop fl6->flowlabel assignment, original code leaves it as 0.
> 
> There is no reason for this change other than to remove code.
> 
> Florian Westphal (2):
>   xfrm: move mark and oif flowi decode into common code
>   xfrm: policy: replace session decode with flow dissector
> 
> Florian Westphal (2):
>   xfrm: move mark and oif flowi decode into common code
>   xfrm: policy: replace session decode with flow dissector
> 
>  net/xfrm/xfrm_policy.c | 277 ++++++++++++++++-------------------------
>  1 file changed, 107 insertions(+), 170 deletions(-)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


