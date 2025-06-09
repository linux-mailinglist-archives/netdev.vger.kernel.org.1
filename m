Return-Path: <netdev+bounces-195631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA993AD1891
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A353A9A6D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61D254AF4;
	Mon,  9 Jun 2025 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RooWsbvp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782D2F3E
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 06:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450313; cv=none; b=oBwA4lJ2Ui2+eO4NLdn4uabo4pMcuYJ2tSKt3YYDF8MuTJaqe9a0cM9ZNZYBK08YrVvTL9DgWC5hTqJ6jcXmmE50kDiT+jp49em6jF9vb3BSez+IAej3OyXN7aQOgCpCNNhcP1H41TluNivHmLvFa3Zoo0p9yS3CEQl4JKFI2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450313; c=relaxed/simple;
	bh=SmlShBUal8eQbq0PykLjs8DxWM1v6SBmlB+79j6IlRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2HYqkKHhpSh1TataMJ8HfivXVktWtyxllLExVICDMUTM3KGgSOfWX6n0SINZe9wJXM5P08L7v54eaKJfratav+3veutYFID3+FRdf8cgPvi3c+0OwkWuf61BJnZafeXfAOsVNx5dd0EM/1oM3PRkT3K5snLoeQyHmkmf0XcHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RooWsbvp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749450312; x=1780986312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SmlShBUal8eQbq0PykLjs8DxWM1v6SBmlB+79j6IlRM=;
  b=RooWsbvp4AZQLyVX69uWU+B4TB60QqU+EsIqhzX3KOpPjF3rUiJ7J52M
   bgJVIDEQvzL7/PVwfZdOtHP49wQg792CxsQjo5mTcvfGvZzD0gCmSuiki
   00XsTaRVUpDSbsg8rlRp3mlZ7z3/lP5wuII2OeI9Lg82EvO83jErsr3P0
   Ver1WHolOnDhNra8TNZ8mj5rCuQaomW6ihJ0SJ4vTO0my9cySL7krZCVX
   gIys7XlpoysTSxx1H20wxqvPMRiUZGnzqTfkZDfzSePEDptEpxRJQjpTZ
   0X+Z4xaAacDCk2IF4Kr1llw8tnNZ9SefvFlUWP47B5v84Bx19yeXERl/K
   Q==;
X-CSE-ConnectionGUID: HrnCfA/US2iHcNaLU3YmEA==
X-CSE-MsgGUID: 5jQLTai8S+CBMhS+2DLZMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="68964341"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="68964341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 23:25:11 -0700
X-CSE-ConnectionGUID: /iqeU4bbQ0C8Zjuj8OaScw==
X-CSE-MsgGUID: I/mlOubSRI+wyQK5BvwmaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="146409020"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 23:25:09 -0700
Date: Mon, 9 Jun 2025 08:24:26 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Li Jun <lijun01@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH net-next] net: ppp: remove error variable
Message-ID: <aEZ+GhgNtYS2E7yy@mev-dev.igk.intel.com>
References: <20250609005143.23946-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609005143.23946-1-lijun01@kylinos.cn>

On Mon, Jun 09, 2025 at 08:51:43AM +0800, Li Jun wrote:
> the error variable did not function as a variable.
> so remove it.
> 
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/net/ppp/pptp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
> index 5feaa70b5f47..67239476781e 100644
> --- a/drivers/net/ppp/pptp.c
> +++ b/drivers/net/ppp/pptp.c
> @@ -501,7 +501,6 @@ static int pptp_release(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
>  	struct pppox_sock *po;
> -	int error = 0;
>  
>  	if (!sk)
>  		return 0;
> @@ -526,7 +525,7 @@ static int pptp_release(struct socket *sock)
>  	release_sock(sk);
>  	sock_put(sk);
>  
> -	return error;
> +	return 0;
>  }
>  
>  static void pptp_sock_destruct(struct sock *sk)

Right,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.25.1
> 

