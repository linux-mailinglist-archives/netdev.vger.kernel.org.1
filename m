Return-Path: <netdev+bounces-81115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23289885FA4
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C9FB253D6
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7313174A;
	Thu, 21 Mar 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOroP2ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0F131745
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041784; cv=none; b=geFRgAlLTQEYuTcCoz4MrtwIfU5LMI6SdqeLpL18+govcOqRgX5qh1fbyGWBrplhxlWKux7nRLCHeu95QhBbBTywqySMw/cUNpDxuQEhFIXPtxxXvC+sMKeiqvMfc4vGSxfuKrdFWOAeCiymU3iUM5yg1w2jxERZptj4E+Q45XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041784; c=relaxed/simple;
	bh=/MeVqg9iJotRbAjFqt6wS/tSZfcmem9iZn9MwmQpq+E=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hmc0q82OENU/08a3J4ILOvmPZJJ251dGd25yqTyeJI3xWBXld/9pSR7kNrtJnowI2vHowhDVQ+WCUoMaeg1xas3IjIm5e1op97VZh7BjJP7+VhuUWTl3nSKWIOUXOb2PLQ2646xZfGgs5PHjln7nZkCyok4CuLxVgH5KZmJHvaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOroP2ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59565C43399;
	Thu, 21 Mar 2024 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041782;
	bh=/MeVqg9iJotRbAjFqt6wS/tSZfcmem9iZn9MwmQpq+E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uOroP2htjneOprtoyXaJMLrQ9AeGl0fvTiGfn0LjxHuWzEnB6ykBXRxwZhaz508Fs
	 XatclFYQpVkqDgCR8OBpPXFVl+4Mu0Q0/WiH2S8J0iSFfTg1WMj8koUuUTNOd+s4Iw
	 dnG05DbtdeMNVkRELAmrxaRGah5Kn5Mqfr3UFXuRuPAH3CG8qC1xM+uZyNT4SuYHEc
	 PKkkzRCr1bmXN18WGmY2DuXt90ZpVzDfHCHkizbq1m2hOL3MsJ7Ni5/nKdEWZzS8Le
	 KUaZGk6KTos51zcN/bjJ9112HL/HjBdjCkqvmq8/9SpDL5ttY2wkKvklj27rKI1z7F
	 SshEO+k830o9w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65fc4b09a422a_2191e6294a8@willemb.c.googlers.com.notmuch>
References: <20240319093140.499123-1-atenart@kernel.org> <20240319093140.499123-4-atenart@kernel.org> <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch> <171086409633.4835.11427072260403202761@kwain> <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch> <171094732998.5492.6523626232845873652@kwain> <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch> <171101093713.5492.11530876509254833591@kwain> <65fc4b09a422a_2191e6294a8@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to unnecessary checksum
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 21 Mar 2024 18:22:59 +0100
Message-ID: <171104177952.222877.10664469615735463255@kwain>

Quoting Willem de Bruijn (2024-03-21 15:58:17)
> Antoine Tenart wrote:
> >=20
> > If I sum up our discussion CHECKSUM_NONE conversion is wanted,
> > CHECKSUM_UNNECESSARY conversion is a no-op and CHECKSUM_PARTIAL
> > conversion breaks things. What about we just convert CHECKSUM_NONE to
> > CHECKSUM_UNNECESSARY?
>=20
> CHECKSUM_NONE cannot be converted to CHECKSUM_UNNECESSARY in the
> receive path. Unless it is known to have been locally generated,
> this means that the packet has not been verified yet.

I'm not sure to follow, non-partial checksums are being verified by
skb_gro_checksum_validate_zero_check in udp4/6_gro_receive before ending
up in udp4/6_gro_complete. That's also probably what the original commit
msg refers to: "After validating the csum, we mark ip_summed as
CHECKSUM_UNNECESSARY for fraglist GRO packets".

With fraglist, the csum can then be converted to CHECKSUM_UNNECESSARY.
Except for CHECKSUM_PARTIAL, as we discussed.

Does that make sense? Anything we can do to help moving this forward?

Thanks!
Antoine

