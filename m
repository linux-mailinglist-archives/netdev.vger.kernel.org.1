Return-Path: <netdev+bounces-138620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40EF9AE4C0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FF928415B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEF1B6CFA;
	Thu, 24 Oct 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgWTuAlP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE92744B
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773056; cv=none; b=RN0M+xeBErpZKvbnT5x4d+gPnsA6NMjwA6ZibC4XoSDKmgWJtLzML73c0PbhSvRxs+5AnU8MmE81v2lOtLhSHK2FtuyPk6YH0yDUBxPg/Q2HEXNAP56BvcMSoRJrUcwDwr864hGdNnFsrc/+DE82DdCVPzkWdGtb2E78u/ptkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773056; c=relaxed/simple;
	bh=efSoxFaQK9nNhTg4YhgK8LbXFhSklRHDegjNv4R6mkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS5B7RX6kia8tT76KY4H4jPckAWYRj1gveuBDrCTXigM2Brt+l3JNmTp6+aTk8e7YWKavxilBhaQBVKM4/wNPHNvMqp2Tnly3/0Nk/R+Xw/QDfqbC5p3krdHZkNZa7oRrsposUWt81EkjgV4NT+IvajaCf8bBlwzJNf8xxWHto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgWTuAlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE9DC4CEC7;
	Thu, 24 Oct 2024 12:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773056;
	bh=efSoxFaQK9nNhTg4YhgK8LbXFhSklRHDegjNv4R6mkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgWTuAlPN1XWGsuwKEYsuyWWNh0mkhvW53Gl5Hq37WdmSc2TUeiDK/v4MYFCjoR1V
	 7fQTieLxSSH/1Ig6Np7jzeNpXXs+nalJraqUqVrXYTd1zE1Sg06VoshkTJmZ75jUf/
	 VqLZmdz1ixP5NpB6quegS0XN9xhf6V7w0sFxswcDNlkAzCGpXlAzBVeVrQgl6CsoTz
	 8NbsgX5v2Cl0w7UH1z61jc8zU/gDtkfb+0O2IjgsKPogpR/l4c6AkhPNprEmF+gLrL
	 2/jw7lF9kBFWFBbqCrbipdyGRNVWkZyOSwvctNpn3/dkkZ+raPppGCnb2jVNWGxEFb
	 bKyvZ0oZ94ImQ==
Date: Thu, 24 Oct 2024 13:30:51 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de,
	pespin@sysmocom.de, laforge@gnumonks.org,
	osmocom-net-gprs@lists.osmocom.org,
	Cong Wang <cong.wang@bytedance.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] gtp: allow -1 to be specified as file description
 from userspace
Message-ID: <20241024123051.GL1202098@kernel.org>
References: <20241022144825.66740-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022144825.66740-1-pablo@netfilter.org>

+ Cong and Andrew

On Tue, Oct 22, 2024 at 04:48:25PM +0200, Pablo Neira Ayuso wrote:
> Existing user space applications maintained by the Osmocom project are
> breaking since a recent fix that addresses incorrect error checking.
> 
> Restore operation for user space programs that specify -1 as file
> descriptor to skip GTPv0 or GTPv1 only sockets.
> 
> Fixes: defd8b3c37b0 ("gtp: fix a potential NULL pointer dereference")
> Reported-by: Pau Espin Pedrol <pespin@sysmocom.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/gtp.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index a60bfb1abb7f..70f981887518 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1702,20 +1702,24 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
>  		return -EINVAL;
>  
>  	if (data[IFLA_GTP_FD0]) {
> -		u32 fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
> +		int fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
>  
> -		sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
> -		if (IS_ERR(sk0))
> -			return PTR_ERR(sk0);
> +		if (fd0 >= 0) {
> +			sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
> +			if (IS_ERR(sk0))
> +				return PTR_ERR(sk0);
> +		}
>  	}
>  
>  	if (data[IFLA_GTP_FD1]) {
> -		u32 fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
> +		int fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
>  
> -		sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
> -		if (IS_ERR(sk1u)) {
> -			gtp_encap_disable_sock(sk0);
> -			return PTR_ERR(sk1u);
> +		if (fd1 >= 0) {
> +			sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
> +			if (IS_ERR(sk1u)) {
> +				gtp_encap_disable_sock(sk0);
> +				return PTR_ERR(sk1u);
> +			}
>  		}
>  	}
>  
> -- 
> 2.30.2
> 
> 

