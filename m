Return-Path: <netdev+bounces-183679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A5A9183F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CBE19E0182
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D41C84AD;
	Thu, 17 Apr 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czBMGF+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A33189B8C
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883231; cv=none; b=u+9ySNfbPsK/+6h8KqThMZVsvAmedx6O6qUl/z0DnY8sTPM60ZhqQosovo5eI0AEDDVlIyTPJ1tm6ppvmYPYgllrU1mZeyqz8H1bEtNzyUsF3ec6+AXMFABdOuSFNU4ICpGpCJGRUV8gfoYxmIpDVL1IQc4GLd9pgfiYXAsHNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883231; c=relaxed/simple;
	bh=JOnCaaEBBJjYNu/JfuV++HtXUU7o8UuDqdXIgzjxtG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7DZP2jek6nkI00qXE10qEwIENnlOgTsnPGhewyWKDAHao9VYj7odeeKb7dK53ZYnsv+uG/cq6juPu7it6Jr7VnIZ6NQGyBG078vCkdVyzhUjBfE1a4M6prSgViwCdttBn6HQyzy5xwlUE8mr5+wpVeFlAx2sawga/3PQo5+XxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czBMGF+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57A0C4CEE4;
	Thu, 17 Apr 2025 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744883231;
	bh=JOnCaaEBBJjYNu/JfuV++HtXUU7o8UuDqdXIgzjxtG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czBMGF+H2G0pBgbT6Zzmb7zXD8S8QB2huBd+BI/iIkCmDP7oGbzsZc3bAszZwx0HT
	 ARFaTPH1OaZc2U2khPfBWv2Kkb8BkjRHFW1GaMfpcNPPzp5mS19/F2IphtRJd+6R/D
	 hjPVYC8ievinH8z4rRgyGlPVwFre+gFI2WMWC1iS9X1sg1Mk8M7X1ZywHqp2KCmQDe
	 lkK8HE7/ef8gOkyoJhTbSXA+jlqv+7GO+wazDX5ovvQVWCEO+2B7+yr4/BP9udDilq
	 n5hbYy7FnOZAL9zE1lI+G3kNgEb5WKpLZwHCD9pFfOuN5Dk0zR2dKOfAS/95DpTk3E
	 9E7p5pWOBJ0Cg==
Date: Thu, 17 Apr 2025 10:47:08 +0100
From: Simon Horman <horms@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 7/8] net/rds: rds_tcp_conn_path_shutdown must not
 discard messages
Message-ID: <20250417094708.GD2430521@horms.kernel.org>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
 <20250411180207.450312-8-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411180207.450312-8-allison.henderson@oracle.com>

On Fri, Apr 11, 2025 at 11:02:06AM -0700, allison.henderson@oracle.com wrote:

...

> diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
> index 30146204dc6c..a9596440a456 100644
> --- a/net/rds/tcp_listen.c
> +++ b/net/rds/tcp_listen.c
> @@ -299,6 +299,20 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
>  		rds_tcp_set_callbacks(new_sock, cp);
>  		rds_connect_path_complete(cp, RDS_CONN_CONNECTING);
>  	}
> +
> +	/* Since "rds_tcp_set_callbacks" happens this late
> +	 * the connection may already have been closed without
> +	 * "rds_tcp_state_change" doing its due dilligence.

nit: diligence

checkpatch.pl --codespell is your friend :)

> +	 *
> +	 * If that's the case, we simply drop the path,
> +	 * knowing that "rds_tcp_conn_path_shutdown" will
> +	 * dequeue pending messages.
> +	 */
> +	if (new_sock->sk->sk_state == TCP_CLOSE_WAIT ||
> +	    new_sock->sk->sk_state == TCP_LAST_ACK ||
> +	    new_sock->sk->sk_state == TCP_CLOSE)
> +		rds_conn_path_drop(cp, 0);
> +
>  	new_sock = NULL;
>  	ret = 0;
>  	if (conn->c_npaths == 0)

