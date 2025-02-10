Return-Path: <netdev+bounces-164917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F67A2F99F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614CF3AB85B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B224E4A6;
	Mon, 10 Feb 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq3/m16Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50F24E4A2;
	Mon, 10 Feb 2025 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217167; cv=none; b=jQIQizdLt/1N31ujbXf9gUEF9KRz0vvxXXx8Rr1HdErLgglU+PfrRxOYxJZADLSJQX7F4bpD0YGn1T1sTJII4mNfJuRhNXWflfilWnYIktE5XrK/ModP2gcvP8hlZ9p5LUzi0gkkHKGvwvEkKxNJOMTpfqTebEUpbYXflwUW2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217167; c=relaxed/simple;
	bh=zbqmjJ/TxKX7U/m5+hgRgAGIrFw5+CmX9sFh4piK0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCETnbD+ARqhxbWKJAm1GGkP3DEZ8Yb207et1+XcTxikKBh9aiXgLO3CywuwXMSJ/r0FCYCE8Lc579wA8terQb7EQvbJDNM58zDvOuiYGPJmcZ+RrJtoKGKGRVP/XCf6IXQvpH2Pp2dGR/4DpUExWGfq9dy8Wxga62iGpI3zMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq3/m16Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAA1C4CED1;
	Mon, 10 Feb 2025 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217166;
	bh=zbqmjJ/TxKX7U/m5+hgRgAGIrFw5+CmX9sFh4piK0QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jq3/m16YbpHRVW3WrViZSasayOPhOgS0RarkIDN/ckhjaXkLhhX27+jUBG205L/3/
	 gVM/zdrGSjchlJpkubN3yy9tIwqpI2M7Vo0kcs3OmorAv/YioarMOCPIeXestE1LPS
	 eD4evm8zr84wT1WLNb+nfwy5fp+2I8A/NQxA6Qr/hfwG/fREK5EJIym1KpqfnUHzQx
	 rlfPYW8rwuEHLEj/1B65MlSvY/qIpKfbmzLo6dw0HzFzfOgRenCX+NX4xZ792ip2Yu
	 QSV34ZX91SAADWwMO7m2Y/xf7UWdiT6K1qHzQl3fC7gxlAvPWq0q3W2MduKzBlNKsZ
	 t3j3Y+yAxZXvA==
Date: Mon, 10 Feb 2025 19:52:43 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 14/15] mptcp: pm: change rem type of set_flags
Message-ID: <20250210195243.GB554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-14-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-14-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:32PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Generally, in the path manager interfaces, the local address is defined
> as an mptcp_pm_addr_entry type address, while the remote address is
> defined as an mptcp_addr_info type one:
> 
>     (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)
> 
> But the set_flags() interface uses two mptcp_pm_addr_entry type
> parameters.
> 
> This patch changes the second one to mptcp_addr_info type and use helper
> mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


