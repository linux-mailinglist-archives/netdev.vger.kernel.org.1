Return-Path: <netdev+bounces-183420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E42A909E6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8C57B0049
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891642153C2;
	Wed, 16 Apr 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKa9zqtP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61291209F49;
	Wed, 16 Apr 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823942; cv=none; b=eufpviOdH7LAEOdFctoAYLIRTtFNeVHIvaxzyj0RIvQ6DIMO6kfjZr30E3szty/XMwv1t52j+wc60SlMIAo+yxbsKMLdVKtbF5vT9UbtaWzZ2MVftd2Nl8kmeSfJT/cpQai9kqGeECMhhcVGtok/W1YxJPppkNJtqMVIalUAiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823942; c=relaxed/simple;
	bh=kX3Hcx6vLRz/peT6QtCRqwbo/jPdXjFzJdXjF0hm+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/ABRn/aO0IQYBXlQHNhNe1avCQVanGWRpTsUWJYVim7VfLecgMRImvfOKuyy7LIe4LORE5EJNV7TdTf8c8gGs5wOSGy5yqcEkWdjRtdMY2Guvsi0M7tdD3LEwQdlXZ/U8bNJ59OuaM0Rh0aZuIRVhloiTzaCMGvJYyRkg9y9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKa9zqtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D3C4CEE2;
	Wed, 16 Apr 2025 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823942;
	bh=kX3Hcx6vLRz/peT6QtCRqwbo/jPdXjFzJdXjF0hm+RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKa9zqtPu9pXtFsrGiIuMdWomV7Db/AOeUUQCC/IUZKvJ84c3lgMiI5svex4AZVAe
	 umqRtCOChhGkBEHgcliRa/4oVaks+6nHyb0pRE4mY0abKjjucxOcjlOx+s8yXQNN6V
	 TxQAzbOGM7SU+h60zx1hDFUT+DeD1tnnG1XqFI0p3qupdBHkPy2CBn2kfBg8eQCVFY
	 DPfWldMdunn4DUwAEv83q0LUZRLSw7wzBF5Nfw076Kc5SHM7hVXpGCjURx86GZsKiY
	 FB9Wc7vLXuTkVA7Q+NkgpH2izt2F9Hk1XEy6U4Q7t85Sf3+Y6Rv/19xid8Y/QpxtQ8
	 pL/Fiw3PgdS2g==
Date: Wed, 16 Apr 2025 18:18:58 +0100
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] net: pktgen: fix code style (WARNING:
 Prefer strscpy over strcpy)
Message-ID: <20250416171858.GX395307@horms.kernel.org>
References: <20250415112916.113455-1-ps.report@gmx.net>
 <20250415112916.113455-4-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415112916.113455-4-ps.report@gmx.net>

On Tue, Apr 15, 2025 at 01:29:16PM +0200, Peter Seiderer wrote:
> Fix checkpatch code style warnings:
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #1423: FILE: net/core/pktgen.c:1423:
>   +                       strcpy(pkt_dev->dst_min, buf);
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #1444: FILE: net/core/pktgen.c:1444:
>   +                       strcpy(pkt_dev->dst_max, buf);
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #1554: FILE: net/core/pktgen.c:1554:
>   +                       strcpy(pkt_dev->src_min, buf);
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #1575: FILE: net/core/pktgen.c:1575:
>   +                       strcpy(pkt_dev->src_max, buf);
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #3231: FILE: net/core/pktgen.c:3231:
>   +                       strcpy(pkt_dev->result, "Starting");
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #3235: FILE: net/core/pktgen.c:3235:
>   +                       strcpy(pkt_dev->result, "Error starting");
> 
>   WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>   #3849: FILE: net/core/pktgen.c:3849:
>   +       strcpy(pkt_dev->odevname, ifname);
> 
> While at it squash memset/strcpy pattern into single strscpy_pad call.
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v1 -> v2:
>   - squash memset/strscpy pattern into single strscpy_pad call (suggested
>     by Jakub Kicinski)

Reviewed-by: Simon Horman <horms@kernel.org>


