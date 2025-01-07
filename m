Return-Path: <netdev+bounces-156070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C265A04D82
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE23188645B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4642D1E47CD;
	Tue,  7 Jan 2025 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXCmlcG+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49670813;
	Tue,  7 Jan 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292537; cv=none; b=lPpQ2SRVlaq9n6azSlq9PPnpwilJBPI17dC9y80epnZaKLJFq2zoe/WbnNNPUZnuBV0XpOBmiRwyeLdXgDdGzg6cXTsIQ4nVmW1/GWAi8ORni2kXH277Sv0Qj8Abxrjc3elhpFzSTGt6fbMGpPFAYpGu7MS76YvXkkSl7wFdUK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292537; c=relaxed/simple;
	bh=/XKTIuIIzi6eYy1OOQwUAP45OfK2UK6TuDBibJwD58M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MPN9yyNj+7+8zAv4FbQNH2lj87WJu59KCj4Tzh3EijFNZ8jOIERXC0jUUA+cu7gkcS9k06o3eARMkSu+Abm7389YmVp5UxwQdXP58DIs1dQ7AvKuCO4NJTyhOTPF79+2rxGMWDSP+mLdA3YiOuRNluslQbs++uhMsCiOzXcIdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXCmlcG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A46CC4CED6;
	Tue,  7 Jan 2025 23:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736292536;
	bh=/XKTIuIIzi6eYy1OOQwUAP45OfK2UK6TuDBibJwD58M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bXCmlcG+FdCq0wy01Z+iWRxrX+6eBH26tABZWHfsudqyrXdte7SjbRB54jHNoKuf2
	 c3SGRKvhIXPdJlJC518StW9hql+vUYU4Cs02inDEQ6OKf+fd6KlkOu6UrrCXoiVwUD
	 1g2r1sQ6GotJvLCbIY3ObD53Hw7MqM7KFmsiQXomHfV0W8FxnSr9YQx1U268vtTkvT
	 MeJbjbhyyS+PcclqW2CTcQaSteZK0SCs9+26WOXTijdrVioFe/dGTXUTLeIcLAqoi1
	 +Q9MP+2g3TMMhaEJSYsVlXZrFtjnfJIMAomwScoDAVkwo2lzPlBXfvs/Qo1aEBSSjQ
	 UYzzXz0IPNfew==
Date: Tue, 07 Jan 2025 15:28:54 -0800
From: Kees Cook <kees@kernel.org>
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-hardening@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net=3A_Silence_false_field-spanni?=
 =?US-ASCII?Q?ng_write_warning_in_ip=5Ftun?=
 =?US-ASCII?Q?nel=5Finfo=5Fopts=5Fset=28=29_memcpy?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250107165509.3008505-1-gal@nvidia.com>
References: <20250107165509.3008505-1-gal@nvidia.com>
Message-ID: <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 7, 2025 8:55:09 AM PST, Gal Pressman <gal@nvidia=2Ecom> wrote:
>When metadata_dst struct is allocated (using metadata_dst_alloc()), it
>reserves room for options at the end of the struct=2E
>
>Similar to [1], change the memcpy() to unsafe_memcpy() as it is
>guaranteed that enough room (md_size bytes) was allocated and the
>field-spanning write is intentional=2E

Why not just add an "options" flex array to struct ip_tunnel_info?

E=2Eg=2E:

struct ip_tunnel_info {
	struct ip_tunnel_key	key;
	struct ip_tunnel_encap	encap;
#ifdef CONFIG_DST_CACHE
	struct dst_cache	dst_cache;
#endif
	u8			options_len;
	u8			mode;
  u8   options[] __counted_by(options_len);
};

>
>This resolves the following warning:
>  memcpy: detected field-spanning write (size 8) of single field "_Generi=
c(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struc=
t ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels=2E=
h:662 (size 0)

Then you can drop this macro and just use: info->options

Looks like you'd need to do it for all the types in struct metadata_dst, b=
ut at least you could stop hiding it from the compiler=2E :)

-Kees


--=20
Kees Cook

