Return-Path: <netdev+bounces-210214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DEB1263F
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C81C2726D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAC23ABB5;
	Fri, 25 Jul 2025 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aupsIF1T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1291E5B82;
	Fri, 25 Jul 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479949; cv=none; b=s0tdX2rBvwKJxX9TnYtQm/16/AokF8MVH+nhfbS4iel6HWOJQSgdwjSz4K/hRkyzQYBiuEcgTIppUllbKR2o+TRTDwonXWUL7YTPH3ZrbHX3EothXDznobiDPaasiu+cVS+e9UG7pWyHmaua6OSX0A9NeNH7kW+vd9pb9yStWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479949; c=relaxed/simple;
	bh=ZzeP/+jy7Sq7z58XRmTr3rt0YqrgXN5DBxaLDVPouGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OygBnyRcZy93L910/bOuaioN5iDCuEbARRpasQYmr+l67BaliS6nKYplhoPW7CtWAbJMwXOh9dVYJA8DorFRe+rMnmfLc574sDh7HnrLZ7H/zXC3P6Dl+bNB2NTiu0Tiifr7v+aDfviQlpQE8ojE36FJs35YGjLS/SAPboGK20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aupsIF1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56008C4CEE7;
	Fri, 25 Jul 2025 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753479948;
	bh=ZzeP/+jy7Sq7z58XRmTr3rt0YqrgXN5DBxaLDVPouGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aupsIF1TpwLUEJ7twNfwof4wmHfOGFBvtGJ7C6/6IA/3SgvaLiKHhppY0QIZ0D6pn
	 pKfMp6lzPQv5c1wMNFBPrmOYlE8CGCqzinxo0S8elwqTqA5KYpW5RHkgduQkAauv6e
	 SeeR7K83Tr7NcjDFfKeWIacwhxND61VBG7MefmeBO9dZzIMSgaitIls/P3/O/tnf9d
	 2imrKffX8bmUzo5+raxHSYONhjiX9R/kbXENrPT0liRz4kd+KHGUfvMKSZD0rjShOh
	 9cOWTb8Q+vfhA6BboqDHLvKvl0cNPKvdXUWe05Tm6y+J5B/2PCrbl4QWVTfuOB9idj
	 OAZRgH+maACfQ==
Date: Fri, 25 Jul 2025 14:45:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
Message-ID: <20250725144547.05a48cc1@kernel.org>
In-Reply-To: <20250724115631.1522458-1-yuehaibing@huawei.com>
References: <20250724115631.1522458-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 19:56:31 +0800 Yue Haibing wrote:
>  net/ipv6/mcast.c | 76 +++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 40 deletions(-)

Dunno if this is worth the churn to save 4 lines.
I was waiting to see if anyone will offer a review tag
but it's getting a bit later in the review cycle, 
please try again after the merge window.
-- 
pw-bot: defer

