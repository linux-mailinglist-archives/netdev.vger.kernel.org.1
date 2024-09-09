Return-Path: <netdev+bounces-126582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F8971E9C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706B71C236F5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E254136320;
	Mon,  9 Sep 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1yIKfL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F41BC40;
	Mon,  9 Sep 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897788; cv=none; b=f7A5QurlET4HyA5aLGgGNy8aj30JKe1U+5AeH3sPpUa5VnDDs5NioqIoN1+4muOt2B+hB5uSiNtHSQ6VSbHKgEBXlNsTk6Q++KDH2sGa1ZBDzhJgukrS4bwtx8mh1eDC1Ngtq9WT8ShPwWpJLvI+Of4bJMkX7KKnTvk65NTBcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897788; c=relaxed/simple;
	bh=YBKzODlnZLU+WZtqDnq4JHe13ynjNkPgf4RS/wmDTKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKMOgFAdXITOTH2yDMVtd+M6ocIzffcnTEq14yEZxwEEqI0SJGLkJAGBGTy7gdFiOJnPccSjArmimjpcoqBrfkwhaHHeD5FK7PSxYJct8RM0Qpd6Mwi19rIXjjSBK9DTXyNjCpbnVZObSrftx4SztoGOvAMtpi0vMUaoTGRo6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1yIKfL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB10C4CEC5;
	Mon,  9 Sep 2024 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897787;
	bh=YBKzODlnZLU+WZtqDnq4JHe13ynjNkPgf4RS/wmDTKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1yIKfL4ngydf85vFf1ba1U9k68dBtjMYvkypOtkkJwoS7rvKS7j9SfpxhtoSR7Bk
	 mrXKWQEmMwNeDtQU2cnZVpsNsZLjV3KOuFWjU/IW9ROGZPTA5Yi5M3TjwMpCDp5DF8
	 rEFp354Ye5KvWf8OX3tQTeoHE186qxV3uob225RsRY9oyxYUA+8GJotLAaF9oC5WYm
	 HLeCjHI15+Yd9lYKGWTCemlq5pYmifSXHcZpiTQWTTdqr7CxNkdA7vrAWa73fhrAjy
	 b7PXX6N+zdYRIkIMdhY27lAQyRxfO4GwH4rz4PmFeZHE54zSxa3Y0mpAxxsD+39n9O
	 3GhByeq9k787A==
Date: Mon, 9 Sep 2024 17:03:03 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v2 04/10] net: netconsole: rename body to
 msg_body
Message-ID: <20240909160303.GC2097826@kernel.org>
References: <20240909130756.2722126-1-leitao@debian.org>
 <20240909130756.2722126-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909130756.2722126-5-leitao@debian.org>

On Mon, Sep 09, 2024 at 06:07:45AM -0700, Breno Leitao wrote:
> With the introduction of the userdata concept, the term body has become
> ambiguous and less intuitive.
> 
> To improve clarity, body is renamed to msg_body, making it clear that
> the body is not the only content following the header.
> 
> In an upcoming patch, the term body_len will also be revised for further
> clarity.
> 
> The current packet structure is as follows:
> 
> 	release, header, body, [msg_body + userdata]
> 
> Here, [msg_body + userdata] collectively forms what is currently
> referred to as "body." This renaming helps to distinguish and better
> understand each component of the packet.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/netconsole.c | 48 +++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 8faea9422ea1..c312ad6d5cf8 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1092,22 +1092,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  {
>  	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
>  	int offset = 0, userdata_len = 0;
> -	const char *header, *body;
> -	int header_len, body_len;
> +	const char *header, *msgbody;
> +	int header_len, msgbody_len;
>  	const char *release;
>  
>  	if (userdata)
>  		userdata_len = nt->userdata_length;
>  
> -	/* need to insert extra header fields, detect header and body */
> +	/* need to insert extra header fields, detect header and msgbody */
>  	header = msg;
> -	body = memchr(msg, ';', msg_len);
> -	if (WARN_ON_ONCE(!body))
> +	msgbody = memchr(msg, ';', msg_len);
> +	if (WARN_ON_ONCE(!msgbody))
>  		return;
>  
> -	header_len = body - header;
> -	body_len = msg_len - header_len - 1;
> -	body++;
> +	header_len = msgbody - header;
> +	msgbody_len = msg_len - header_len - 1;
> +	msgbody++;
>  
>  	/*
>  	 * Transfer multiple chunks with the following extra header.
> @@ -1122,10 +1122,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  	memcpy(buf + release_len, header, header_len);
>  	header_len += release_len;
>  
> -	/* for now on, the header will be persisted, and the body
> +	/* for now on, the header will be persisted, and the msgbody
>  	 * will be replaced
>  	 */
> -	while (offset < body_len + userdata_len) {
> +	while (offset < msgbody_len + userdata_len) {
>  		int this_header = header_len;
>  		int this_offset = 0;
>  		int this_chunk = 0;
> @@ -1133,23 +1133,31 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  		this_header += scnprintf(buf + this_header,
>  					 sizeof(buf) - this_header,
>  					 ",ncfrag=%d/%d;", offset,
> -					 body_len + userdata_len);
> +					 msgbody_len + userdata_len);
>  
> -		/* Not all body data has been written yet */
> -		if (offset < body_len) {
> -			this_chunk = min(body_len - offset,
> +		/* Not all msgbody data has been written yet */
> +		if (offset < msgbody_len) {
> +			this_chunk = min(msgbody_len - offset,
>  					 MAX_PRINT_CHUNK - this_header);
>  			if (WARN_ON_ONCE(this_chunk <= 0))
>  				return;
> -			memcpy(buf + this_header, body + offset, this_chunk);
> +			memcpy(buf + this_header, msgbody + offset, this_chunk);
>  			this_offset += this_chunk;
>  		}
> -		/* Body is fully written and there is pending userdata to write,
> -		 * append userdata in this chunk
> +
> +		if (offset + this_offset >= msgbody_len)
> +			/* msgbody was finally written, either in the previous
> +			 * messages and/or in the current buf. Time to write
> +			 * the userdata.
> +			 */
> +			msgbody_written = true;

Something went a bit wrong somewhere, msgbody_written isn't declared
in this scope.

> +
> +		/* Msg body is fully written and there is pending userdata to
> +		 * write, append userdata in this chunk
>  		 */
> -		if (offset + this_offset >= body_len &&
> -		    offset + this_offset < userdata_len + body_len) {
> -			int sent_userdata = (offset + this_offset) - body_len;
> +		if (offset + this_offset >= msgbody_len &&
> +		    offset + this_offset < userdata_len + msgbody_len) {
> +			int sent_userdata = (offset + this_offset) - msgbody_len;
>  			int preceding_bytes = this_chunk + this_header;
>  
>  			if (WARN_ON_ONCE(sent_userdata < 0))

-- 
pw-bot: cr


