Return-Path: <netdev+bounces-209890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2EB113DF
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FE71629E1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD523DEB6;
	Thu, 24 Jul 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9Y9vu6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8C23D281
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396083; cv=none; b=gMTFclWgnwBWiIS2D3SF/xF4EFnhNque0Y6f58vxmTDWQu1tc99C/LoIau2CRG8yqM+bRP9ls2CzX1C6dJiIl5RNY29Rd2byT6QXyH9CaetE/LcPql4e/D0i9pE3R/IcHn4gzObn+JfNbDXSYTiPVLZMM1kE/8VtW/HsiXvXmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396083; c=relaxed/simple;
	bh=63zITmk/1mSkFS40iXszBVOcqkpfa5q1GrAAK6/iNOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwf/6p4afnp9yLWyekq9yvxzL/v+pwYmDRfw1BlTqCgXnSXXd9OlXJPAp94svlTJneOS6mypLujz5V470eKpMsxeiXobsbhfMnoCsvFwQIrWpyIkxvsQoZg/uy/jBoukYS14l0BJJ/2FJkPfGtTm9X0unpsx5/s7sSeL2wTga14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9Y9vu6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1683FC4CEF5;
	Thu, 24 Jul 2025 22:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396083;
	bh=63zITmk/1mSkFS40iXszBVOcqkpfa5q1GrAAK6/iNOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9Y9vu6puJYKuKxSBos2GWQNZf2QmvkXHEFzsLiB+wACNfh9J5jXumjLKyoGjA26E
	 yWwiEyl9X9dS6PJ3feeHzan7ha+9xjOpOoAMkGP5iCPj0VYmifZeWhII0wrTmYGsWA
	 T+oqx5gYzZQQqYFEzvez4U2bQSAdUGLgJQRErfbVItiiIhGk06LYdQTNCAMGEMszou
	 zemaSpCtXanKECd/JghduC4B+9io80yfM9SrAMEUNCdi3XQo3jvt6E7yB0r7VAQcuA
	 joTDNwjTQEabbtf++ff+c9KgouBv1ThYgR2sv5aO6HCpxi7F8tdF+7TpTuGP9yISlS
	 xuUhA8n+Gbv1g==
Date: Thu, 24 Jul 2025 15:28:02 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/6 net-next] net: uapi: Add __kernel_sockaddr_unspec for
 sockaddr of unknown length
Message-ID: <202507241526.292798770A@keescook>
References: <20250723230354.work.571-kees@kernel.org>
 <20250723231921.2293685-1-kees@kernel.org>
 <20250724144046.36dd3611@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724144046.36dd3611@kernel.org>

On Thu, Jul 24, 2025 at 02:40:46PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 16:19:08 -0700 Kees Cook wrote:
> > I added this to UAPI in the hopes that it could also be used for any
> > future "arbitrarily sized" sockaddr needs. But it may be better to
> > use a different UAPI with an explicit size member:
> > 
> > struct sockaddr_unspec {
> > 	u16 sa_data_len;
> > 	u16 sa_family;
> > 	u8  sa_data[] __counted_by(sa_data_len);
> > };
> 
> Right, not sure how likely we are to add completely new future APIs 
> that take sockaddr directly. Most new interfaces will be wrapped in
> Netlink. I may be missing the point but the need to add this struct
> in uAPI right now is not obvious to me.

Yeah, it was pure speculation on my part. I am perfectly happy keeping
it strictly internal to the kernel, but I thought I'd try to show some
possibilities.

-- 
Kees Cook

