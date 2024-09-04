Return-Path: <netdev+bounces-125022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FFE96B9A5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACDE1C21498
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD11CFEDD;
	Wed,  4 Sep 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9M6oxA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC261CFECB;
	Wed,  4 Sep 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448051; cv=none; b=HWF8QWbleY6pFWZXxxFis0OXmFkWqTE+xZ6IC/cs6oZMehInPvzgccoZD7jK5IwZEO0j4E8/+tAey+X1fTl2EwhOOqQTs37UjxAhh7ck3WW5QixpvNhfRvvgLuTAKXt4cLJOKHT4uuKANMbqBvXAUo0wHPLnSSDRLxAUm5b8JQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448051; c=relaxed/simple;
	bh=3LxCbzOrcd32cpSLLorrYPVCHiRpIIXIzIKd0XC8+y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ1qLl7Xk0SUYdvAQTYZWLIBmW2HHxspDNO+SruGMfGaM7k2BN98RwOStkKP5xfT80/+h6Z53fVDklsxc2dA7OD+d653D16fy6GjM/McWHiGQeNFchWYpmoK8ypSZevjuBWvvM0FYV1gnXplY2Xw+U4qoLkSaw62DRlBhZ6nrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9M6oxA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8BAC4CEC2;
	Wed,  4 Sep 2024 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448051;
	bh=3LxCbzOrcd32cpSLLorrYPVCHiRpIIXIzIKd0XC8+y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9M6oxA6iOImHoag4dqtxbOj5+mqu/6uJm4zX172TMcoVW0+6Q8jXFuHpZoB1vNd4
	 0JzFkNj70QyoGjA5dQWXrrIeNK6Bzto83g789ISjQGg7GaWF4sTJ191XFDCEEtGHb9
	 D7JEKqSxkDaaUsm2Biv/0iS452KtgIXUHl16SpA6NjEfMEbMgjqxEujBybE9/qTPc2
	 zVb87N55Gx76QjwqdPPX30j/qEKDLxLfY2wPDjCyoptEnfRB76cNEURkV/XAkZpQMs
	 l+MUmF080yTX1EVL5QLYpD9PWneg4gMehm9DZCmBY2P8OvrJYovv7nHbDfEWoZf1MA
	 ptNjMYv2wrMRg==
Date: Wed, 4 Sep 2024 12:07:26 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 6/9] net: netconsole: track explicitly if
 msgbody was written to buffer
Message-ID: <20240904110726.GT4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-7-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-7-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:49AM -0700, Breno Leitao wrote:
> The current check to determine if the message body was fully sent is
> difficult to follow. To improve clarity, introduce a variable that
> explicitly tracks whether the message body (msgbody) has been completely
> sent, indicating when it's time to begin sending userdata.
> 
> Additionally, add comments to make the code more understandable for
> others who may work with it.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks,

The nit below notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/netconsole.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 22ccd9aa016a..c8a23a7684e5 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1102,6 +1102,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  	 */
>  	while (offset < body_len) {
>  		int this_header = header_len;
> +		bool msgbody_written = false;
>  		int this_offset = 0;
>  		int this_chunk = 0;
>  
> @@ -1119,12 +1120,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  			memcpy(buf + this_header, msgbody + offset, this_chunk);
>  			this_offset += this_chunk;
>  		}
> +
> +		if (offset + this_offset >= msgbody_len)
> +			/* msgbody was finally written, either in the previous messages
> +			 * and/or in the current buf. Time to write the userdata.
> +			 */

Please consider keeping comments <= 80 columns wide.
Likewise in other patches of this series.

checkpatch can be run with an option to check for this.

> +			msgbody_written = true;
> +
>  		/* Msg body is fully written and there is pending userdata to write,
>  		 * append userdata in this chunk
>  		 */
> -		if (offset + this_offset >= msgbody_len &&
> -		    offset + this_offset < body_len) {
> +		if (msgbody_written && offset + this_offset < body_len) {
> +			/* Track how much user data was already sent. First time here, sent_userdata
> +			 * is zero
> +			 */
>  			int sent_userdata = (offset + this_offset) - msgbody_len;
> +			/* offset of bytes used in current buf */
>  			int preceding_bytes = this_chunk + this_header;
>  
>  			if (WARN_ON_ONCE(sent_userdata < 0))
> -- 
> 2.43.5
> 

