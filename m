Return-Path: <netdev+bounces-81377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CAA887962
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE13728223F
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862B4778B;
	Sat, 23 Mar 2024 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFVhEDm0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F545BF3;
	Sat, 23 Mar 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211401; cv=none; b=BGtqG7bTvUofOxbO6oIv/9HSkhza6zKxGUTDJswgbaj0z6Dtqo4SWt258G3EuGT39NKoKk53YC9V4eEKwBlPf2oZe2UfrnPgChtQK8akT9cGtLN3VmX2URI2RZhK9y5x+2Ckt7Q79Jeb9jHcAXSy8ZIQQ3e23k2vr4Jdtn+gXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211401; c=relaxed/simple;
	bh=0zNODIjquihCQsfOJOZQfa/hkNYmPJ81y3LTC3osk1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmqVW/EqmXyBjXRT+Ij1KEUUumZDYw95qX2kCPL3o6YoAUy2lwbDzjHg1NYBq3Z+5h7B2LihPNhIszujMpa39qxBaIS6TPYQXnkDLk2NIoLSpDI9vuhN4l9XuJPgS3f17evWmncisIh2456C274UF9zI1oYnGx/6/eaC+9cXIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFVhEDm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8BBC433F1;
	Sat, 23 Mar 2024 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711211400;
	bh=0zNODIjquihCQsfOJOZQfa/hkNYmPJ81y3LTC3osk1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFVhEDm0dQ3ZgK3LNq7A1ywjh8hL0004p1ZReXgz67P7XitkMu08tLmyMO91xKakr
	 SYXbaihEC6GvKlm2vhYDb/CejnZtP3zK3tZUFzglxR0AKPDUXPXHSP7ZmeOqV1AaWF
	 XxkpKb6dK+QWg3Bpuqe/uLKBaQ6VhIDH0/hYT0elgVxq0OTABEXuD+ev4ovFP+1Dw+
	 54X5J6c4GcJCfWIzl3n/AMED1fNG2ZHPelz40pNwAxHQ9nNLsgvYxOtbwBgjQr4IdF
	 XMH91a6MqQERkOqPOVp7AaaHUP2PjOc++hS1/hWGjJrSjXKtRqBPl6AYEGC4Pt4p4x
	 7u2nL9NofaN9w==
Date: Sat, 23 Mar 2024 16:29:56 +0000
From: Simon Horman <horms@kernel.org>
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
	kuba@kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	corbet@lwn.net, pabeni@redhat.com,
	Bharath SM <bharathsm@microsoft.com>
Subject: Re: [PATCH] dns_resolver: correct sysfs path name in dns resolver
 documentation
Message-ID: <20240323162956.GB403975@kernel.org>
References: <20240323081140.41558-1-bharathsm@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323081140.41558-1-bharathsm@microsoft.com>

On Sat, Mar 23, 2024 at 01:41:40PM +0530, Bharath SM wrote:
> Fix an incorrect sysfs path in dns resolver documentation
> 
> Signed-off-by: Bharath SM <bharathsm@microsoft.com>

Hi,

There is another instance of "dnsresolver" in the same file.
Should it also be changed?

> ---
>  Documentation/networking/dns_resolver.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
> index add4d59a99a5..99bf72a6ed45 100644
> --- a/Documentation/networking/dns_resolver.rst
> +++ b/Documentation/networking/dns_resolver.rst
> @@ -152,4 +152,4 @@ Debugging
>  Debugging messages can be turned on dynamically by writing a 1 into the
>  following file::
>  
> -	/sys/module/dnsresolver/parameters/debug
> +	/sys/module/dns_resolver/parameters/debug
> -- 
> 2.34.1
> 
> 

