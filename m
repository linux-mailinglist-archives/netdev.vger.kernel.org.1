Return-Path: <netdev+bounces-139663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1799B3C2D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE001F22CFB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560F1DEFC6;
	Mon, 28 Oct 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zf8Q3oMW"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827618D649;
	Mon, 28 Oct 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148437; cv=none; b=ViwFYPFe7scm3CTiBV+WlL6/gUxOMnAgP4aM+gTGxHJDS1tNL2uNuNwJuFyKBsXMRBN53ccTDMf/ieMUo9ZTj9ckkOrZ56TmNC+xNnnuTCK9ADRiVRvV/G5Wlk0KxPihNtItds+qFcdO+KJv2g0fctjXetpv+OWFb7+rDqS7SGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148437; c=relaxed/simple;
	bh=9zhy4+xfsoY/yelPEXafdYgdMnBrE4lgFH5t3MkDVaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ROxP7hAf1WQHn4PpZbeZEufbjULkI/yVJ982UrG1LMxbvgCBgJ6LBKdUMD7JCe9Pp/PmcQwttc4KuW4WLBHd0rCeVP28MOCvlFhVGrBzRa0sXTCCz+1A2BBFJw71IMvHQXany+zBQaRCH2v4lnH8bbgWXEAPMX9B3SNbkze80RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zf8Q3oMW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9zhy4+xfsoY/yelPEXafdYgdMnBrE4lgFH5t3MkDVaM=;
	t=1730148434; x=1731358034; b=Zf8Q3oMWL6SkyN8ILTcgGD0wN0mDy94Rl5Lq150WXAFDUTV
	CS0+fZ+m/C024Wgmc6yYhk4avlXq7RFSTe8zpOsRtw5TygawUJd2GdCJzl7HuP2XUQzqN+Tjw26zK
	lYuO5hbv1zbjMNCAtV8HcXNIQnHnbJreea3JQNovW030nSvEYomgaEV7GLt5buVbKsWHZNHHpRe5o
	veZI8sWEBqqNSF+AP499lB4w2q1Cfol+7VaReczhkjuBVxwi5KrWzXoROjCQH1PVmQK0fL8MFy7u1
	0R+gxBQMl/WbINVh0VZ9T49Jbgw4AlNO02MUYHzmdlaSm8gA37uu+M9iKFxL4EMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t5Wdp-00000007PAV-1Uhr;
	Mon, 28 Oct 2024 21:47:09 +0100
Message-ID: <bc7d77fdbe97edc3481f9f73a438742651bd4b8b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Lunn <andrew@lunn.ch>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, Simon Horman
 <horms@kernel.org>
Date: Mon, 28 Oct 2024 21:47:08 +0100
In-Reply-To: <66641c32-a9fb-4cd6-b910-52d2872fad3d@lunn.ch>
References: <cover.1729802213.git.gustavoars@kernel.org>
	 <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
	 <66641c32-a9fb-4cd6-b910-52d2872fad3d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-28 at 21:38 +0100, Andrew Lunn wrote:
> > As this new struct will live in UAPI, to avoid breaking user-space code
> > that expects `struct sockaddr`, the `__kernel_sockaddr_legacy` macro is
> > introduced. This macro allows us to use either `struct sockaddr` or
> > `struct sockaddr_legacy` depending on the context in which the code is
> > used: kernel-space or user-space.
>=20
> Are there cases of userspace API structures where the flexiable array
> appears in the middle?

Clearly, it's the case for all the three other patches in this series.

> I assume this new compiler flag is not only for
> use in the kernel? When it gets turned on in user space, will the
> kernel headers will again produce warnings? Should we be considering
> allowing user space to opt in to using sockaddr_legacy?

For the userspace covered by patch 2 this will almost certainly never
happen, and I suspect that might also be true for the others (arp and
rtnetlink ioctls)? But it probably wouldn't be difficult either.

johannes=20

