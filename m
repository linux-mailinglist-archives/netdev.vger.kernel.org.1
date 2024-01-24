Return-Path: <netdev+bounces-65379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518FA83A458
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BA71F28600
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FB17995;
	Wed, 24 Jan 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPMaaG2e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75621798C
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085631; cv=none; b=Dp7IKmy5JjOZje1oHTOljH52a1Udzc0ARTD19Bny+Drtu2673loYmLwGZBNq+HbYC3R7aYHSaMUVJGVLiSEcptuRc+cypdTT3aCZ84JtVBRUDq+EVtZFJQ+vYD0bBuPTvI8ktUhr0FN4kylJ8Fgzhn6FZHUpBl2FCWNKE5fg3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085631; c=relaxed/simple;
	bh=RmOinWO0LyT2ngc+Nm9l7cNtMZI1us/tJSjcDA0BmKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7NWqUh9POpl9ZJ5UBTJndOULch/66tADRkeZpLdfjmvUZDPVa6vWjBKi/U22QiYNGoqZOiqDN5fE5ovTY9khYhzvYhM39OITfogiTRThzCD/ENep2k/eKr89isUSXEeuiSkCYzSemG8JzLGhe7qDFymiFJjrKAvdMxyw6d9vLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPMaaG2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABA2C433F1;
	Wed, 24 Jan 2024 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706085631;
	bh=RmOinWO0LyT2ngc+Nm9l7cNtMZI1us/tJSjcDA0BmKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPMaaG2e6N1LOYSBlwkswZQ5m98NsV7R4miFEqXdtPWXB0El2e4d1wrfZITRzkqNF
	 D3PbLwqeJc+OPfApDeWveWSPQbI5d+L/LGazPB2HIdzq63xHvBv2cwhZaClim5Unjt
	 23U/BZlg0AQobCC5FXHvCw0unYh6csaTVJs/cte66Bsq6sLYxq2aFo6EuQ6CeiN4Df
	 UcgcwNAdgyl7c7KrDqUgXrHlHn9LOvcdjD2NGDWm4pmCoZQZZB0piHJ46igl6Bt4NT
	 MuUV4kFGXDwMJUUOhQPtlVukcbYKIoGnC3eHC8leUOWzvkXfZgDtH8rz/rpDRI1RbF
	 O4KhKN7Qyzirg==
Date: Wed, 24 Jan 2024 08:40:27 +0000
From: Simon Horman <horms@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] connector, linux++: fix <uapi/linux/cn_proc.h> header
Message-ID: <20240124084027.GR254773@kernel.org>
References: <3878dc5a-9046-4d7a-bf9e-70dcdc5d9265@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3878dc5a-9046-4d7a-bf9e-70dcdc5d9265@p183>

On Tue, Jan 23, 2024 at 01:16:46PM +0300, Alexey Dobriyan wrote:
> Rules around enums are stricter in C++, they decay to ints just as
> easily but don't convert back to enums:
> 
> 	#define PROC_EVENT_ALL (PROC_EVENT_FORK|...)
> 	enum proc_cn_event ev_type;
> 	ev_type &= PROC_EVENT_ALL;
> 
> main.cc: In function ‘proc_cn_event valid_event(proc_cn_event)’:
> main.cc:91:17: error: invalid conversion from ‘unsigned int’ to ‘proc_cn_event’ [-fpermissive]
>    91 |         ev_type &= PROC_EVENT_ALL;
>       |                 ^
>       |                 |
>       |                 unsigned int
> 
> Use casts so that both C and C++ compilers are satisfied.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  include/uapi/linux/cn_proc.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -69,8 +69,7 @@ struct proc_input {
>  
>  static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
>  {
> -	ev_type &= PROC_EVENT_ALL;
> -	return ev_type;
> +	return (enum proc_cn_event)(ev_type & PROC_EVENT_ALL)

Hi Alexey,

I think the line above needs a ; at the end of it.

>  }
>  
>  /*
> -- 
> 2.43.0
> 

