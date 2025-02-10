Return-Path: <netdev+bounces-164916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C13DA2F995
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC893AAF6A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449224C681;
	Mon, 10 Feb 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oilG5x/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D625C6E2;
	Mon, 10 Feb 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217154; cv=none; b=UILejjttG+OUGDQPeT5rm7yNgxUbGa2Udhq7Lif+0KJGFWdQ3nyqUtXzgKhhAJ+O6jz8IthHrMoejPZ0NRuX8YlQfGFElYZrM7WHfDR8O7N4kCHte6p7fgbt3eL1vy0y0uka7pNGAV9jKfiB1W0QYSGeImo3uuI6ClETJJJjjsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217154; c=relaxed/simple;
	bh=/D6d+sjlL6BkmyPK4ooZ5CTEN16NxmyezNw45fqLVzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7U+aYzHTuFBWAM6Ics45y8HXi1kzbQ122rweLrRk+pMQt/u37T/oWkXiPIBjtmKOPtY9XD84SZ6Ajt6bBPTb+6CjNsDueK2YTYqrur9sJOWdA8bn1lSxo/eZIskOXGPjVgeK6gTbh+/oaBlrnhHvCdcFSfBcXmhzFCu+2r0C3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oilG5x/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73E1C4CED1;
	Mon, 10 Feb 2025 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217153;
	bh=/D6d+sjlL6BkmyPK4ooZ5CTEN16NxmyezNw45fqLVzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oilG5x/+q3qud/uL21jyC5sLtfE6gzzqXFo3IRia8GrCnxMHkcm3yzYhTFz0cSElD
	 hQVpCZsdiL5gew0RFpBTJzOb28AymQnepu8xX4NyDcGnlU+oa4DSFEn/ANBP+XKf9o
	 oIBkLUfhnu9EeMcTTyI0iyOBJZHeoycU08MWHnu8Q24QTEVFTgAB2OS+ej2eMSxswz
	 LU0njQab18ueCDbr/2WPp0WbYr9O401/9MU3osFZgwNRLWWYZTT9+nZkO4sn46bUkR
	 qXotPem8ldn7p7gLaxtLbx6SY9cuzlb3sBy4LUgZigVMA2QntgIaS+6nVjvR0j1oUg
	 rSebjrwX0Zwkw==
Date: Mon, 10 Feb 2025 19:52:29 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 13/15] mptcp: pm: drop skb parameter of
 set_flags
Message-ID: <20250210195229.GA554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-13-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-13-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:31PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The first parameter 'skb' in mptcp_pm_nl_set_flags() is only used to
> obtained the network namespace, which can also be obtained through the
> second parameters 'info' by using genl_info_net() helper.
> 
> This patch drops these useless parameters 'skb' in all three set_flags()
> interfaces.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


