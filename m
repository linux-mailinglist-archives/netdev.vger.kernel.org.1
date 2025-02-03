Return-Path: <netdev+bounces-162046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A750AA25769
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36938164D57
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC42010E1;
	Mon,  3 Feb 2025 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYhMxQgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448120103D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580053; cv=none; b=unlBKAw3wrSlGyvlFkli1HZhb+uHTYFF/wjZhr23cofNjbN6sAt8ty+sQvDMaF3cEVIb+2/zzEg+APUHwCNYcKNvmCmCuD9zk0mQVCMxf8j+0lpBpp2IR9zUMabKY4j1YC7I546gVD18s17X0JBX+WrMgwcyO2S1xD72ZmD8SCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580053; c=relaxed/simple;
	bh=sWPAx9725SuEKdSg6cDYX3AOQe7Ms+and4jxx3Wx0FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpJ4dkK/CLBKBXVtMFMP2ik5zB3e+9319B3TX0xgB6Nk/G1bJkd2BXt00SjBjtgcwQCf+yYYzCjYY8obgpH1SD3jUsXeRlbZNMP1D+1shY0JNo2231xWCOze8iRFNivPkqhAcAiFSNuHM1kjQgm5ZPfAhuCALUe1211i46OPV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYhMxQgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB853C4CED2;
	Mon,  3 Feb 2025 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738580052;
	bh=sWPAx9725SuEKdSg6cDYX3AOQe7Ms+and4jxx3Wx0FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYhMxQgGC26MKBLxbj1LSGI9cYobw++Z+BTtRKB0X3v2EpvDwCS8wmWCAkFen4SjW
	 iv7gGJRpe9AtQQxh3Vmtjy6CmbmoShXedLwcjB2UZHNTzfmyjvJ+FBCn/j563othPF
	 R7/OUhXe1kSaWB1W1qqLIiSBnN7qvKI8iMgrxJa1pw/6y1cPnT6vIYgGar4mRKbu0K
	 VLqIS4wGAFdfViuH0+lTkgmesV320E8aNvAiPD7bVgM+vt7GqmQKmP18EecoxQlXT6
	 G04w2FAyk6Tfc47jPP9/8AiFL3UvcotvZ1OyBdAnWJCju6XSciCFCqVjflsTXzFSj2
	 ykeHsG8Rets4w==
Date: Mon, 3 Feb 2025 10:54:08 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, kuniyu@amazon.com,
	willemb@google.com
Subject: Re: [PATCH net 2/3] MAINTAINERS: add a general entry for BSD sockets
Message-ID: <20250203105408.GD234677@kernel.org>
References: <20250202014728.1005003-1-kuba@kernel.org>
 <20250202014728.1005003-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202014728.1005003-3-kuba@kernel.org>

On Sat, Feb 01, 2025 at 05:47:27PM -0800, Jakub Kicinski wrote:
> Create a MAINTAINERS entry for BSD sockets. List the top 3

4?

> reviewers as maintainers. The entry is meant to cover core
> socket code (of which there isn't much) but also reviews
> of any new socket families.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5c59ec5126..f61a8815fd28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16647,6 +16647,22 @@ F:	include/net/tls.h
>  F:	include/uapi/linux/tls.h
>  F:	net/tls/*
>  
> +NETWORKING [SOCKETS]
> +M:	Eric Dumazet <edumazet@google.com>
> +M:	Kuniyuki Iwashima <kuniyu@amazon.com>
> +M:	Paolo Abeni <pabeni@redhat.com>
> +M:	Willem de Bruijn <willemb@google.com>
> +S:	Maintained
> +F:	include/linux/sock_diag.h
> +F:	include/linux/socket.h
> +F:	include/linux/sockptr.h
> +F:	include/net/sock.h
> +F:	include/net/sock_reuseport.h
> +F:	include/uapi/linux/socket.h
> +F:	net/core/*sock*
> +F:	net/core/scm.c
> +F:	net/socket.c
> +
>  NETXEN (1/10) GbE SUPPORT
>  M:	Manish Chopra <manishc@marvell.com>
>  M:	Rahul Verma <rahulv@marvell.com>
> -- 
> 2.48.1
> 

