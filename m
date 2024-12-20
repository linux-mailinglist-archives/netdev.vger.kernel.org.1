Return-Path: <netdev+bounces-153549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A239F8A12
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB73B7A21E1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA8134AC;
	Fri, 20 Dec 2024 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTXPFlP5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B52594A8;
	Fri, 20 Dec 2024 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734661409; cv=none; b=jbzzX4UawrsXUJfRV0shnNpSq2MVzp2JYVCfJrLUGBlqmK6PZvuC2UKRTLZ7R6WeShgSrp7PqKXd15LTGuZybZ0wh/iXvwoH9Oe6rCNclbR3l2WpyhXzEoys4fbe/RdCx6DVCZkUXB1eQG8dExjpapSx6b0z3yLaCa2md53tZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734661409; c=relaxed/simple;
	bh=A4hLd/n5alBrSidQ2EP0QPR76jhwDN1pWVBOhejGFgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shXeF3CdwEQy918U1CjU0zRGtZFBb+1MXmrrQ6uTHzUvp4m4B+TrLFiaUIbXkMV0edImw65C70YXLVDfSrJPXohdyC8gD7GYd2glDnhpWxEWyA4v4rfzRaG3EowLfpI0zucKK6uyBkBzd3TAs3FiY8IRNRBgOO7VEA1j8knF15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTXPFlP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE0C4CECE;
	Fri, 20 Dec 2024 02:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734661405;
	bh=A4hLd/n5alBrSidQ2EP0QPR76jhwDN1pWVBOhejGFgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bTXPFlP5mliXnYOmGgTrE9LwMGqmGEIjYwlS0Fl7FWt0XoiWT4rw/VpIuYzpp1R/u
	 EWVT68+TrubzuKzaJay5+jtmgVNGg4x3K9V5b83IGiaapenf+HxtfHswLaPmxbkZ+B
	 DLsIIY5gF0wxw4/7LJJUrl15aH8bLf6ocwn4TN7yVD4Qq3+qMDerGp/P/J1tTvJIdZ
	 +RlKcTOMwnvmznXECb+A8Vt02XUWKkbi1/89KjoN9Unvcw4uowYwTOd2LhnJKjHgYS
	 RvFmJMEmGaHTtLCD+pnLWNybapLM3pomo2LpZ2VcOLwveKzgH79VutdI2SxdPVpX3f
	 cQKjm6NBbx48Q==
Date: Thu, 19 Dec 2024 18:23:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, pabeni@redhat.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] netkit: Allow for configuring
 needed_{head,tail}room
Message-ID: <20241219182324.4707e425@kernel.org>
In-Reply-To: <20241219173928.464437-1-daniel@iogearbox.net>
References: <20241219173928.464437-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 18:39:26 +0100 Daniel Borkmann wrote:
> +	if (headroom) {
> +		peer->needed_headroom = headroom;
> +		dev->needed_headroom = headroom;
> +	}
> +	if (tailroom) {
> +		peer->needed_tailroom = tailroom;
> +		dev->needed_tailroom = tailroom;
> +	}

Since you use the same one for main dev and peer should there be
something rejecting the use of the new attr in the peer attrs?
(IFLA_NETKIT_PEER_INFO)

> +	struct {

static const?

I wish more userspace learned how to do reverse parsing.
We wouldn't have to bother injecting the attr names to all the messages,
NL_SET_ERR_MSG_ATTR() already points to the attr :|

