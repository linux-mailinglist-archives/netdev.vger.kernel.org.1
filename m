Return-Path: <netdev+bounces-164913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8440A2F980
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEFB188A637
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A024E4A3;
	Mon, 10 Feb 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/utK/m6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CF25C6FF;
	Mon, 10 Feb 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217115; cv=none; b=t95EzhLLY0hWfz3/EaiTYuamol9mUNh98S+fIz9beHZKHy2mqNsqPYRpXbuczq+8t5x6qZSbDFCM6fyKgvHP1ep2BjC3yCaUDnh3pmeHpWLqD4HrJ/h6VSfOeEoLof5v6W1CS+nEjfKJB1MEGpQrac8swpfUEZd1k+VvvNcD5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217115; c=relaxed/simple;
	bh=SrfUjnLSilqSMNXBVss32PA8D52BUWRrB/lANfk8IjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltNFMVd1dTosWhh3zp2HyO+S4/PTl2scRvLtuOgbDbnMjto/LZEsn0bkMOuREXWsfKPfb9L+NWsxvyHkHZNbmaYhpWNecwSZuPuhtwpCi0L/nciYNlYNosbBwrpqA/RZ8CRslImFdZTzQQRPBy5idMScT9B8iU5QjC4BqFzzzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/utK/m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D1C4CED1;
	Mon, 10 Feb 2025 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217114;
	bh=SrfUjnLSilqSMNXBVss32PA8D52BUWRrB/lANfk8IjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/utK/m69ytOAnyKyeD7B5wUjHPqBw9Hq972eoztUtKqCIx17ROotcFqRW9u1tKt7
	 1OdETaAmkA/TNKdW6zmC6CJ1HJFD/6Tmks31KDAZJid+5+mdyf9qY/3lyKc5DfH4gK
	 EFPZ3IggK8e9UNcKu1IABo6Mr0AmjpUOGDXJS/U9YZ3almZWCGGHrua4H1NfU0qA+h
	 7NRDEV0/QrbvfHBysEdHhVjB5dBPa6tXL6U2x1QaP0h6STXQKYlMIG9TcSNY8Xq9Z6
	 2idOlEOKvX4VCKTlO20/6xQwNW3wBZBe7WHLJLdWgaQAyZQq6hVc5FicTdTErLSS1o
	 ZP3o4PT01vQoA==
Date: Mon, 10 Feb 2025 19:51:50 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/15] mptcp: pm: drop skb parameter of
 get_addr
Message-ID: <20250210195150.GX554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-10-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-10-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:28PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The first parameters 'skb' of get_addr() interfaces are now useless
> since mptcp_userspace_pm_get_sock() helper is used. This patch drops
> these useless parameters of them.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


