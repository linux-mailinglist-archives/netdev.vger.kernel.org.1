Return-Path: <netdev+bounces-223300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F1B58B25
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F81B1B2019D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD01E98F3;
	Tue, 16 Sep 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMOPtzsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799981A3172
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985998; cv=none; b=mtYMJLEjnwE5Byylv2wMb5C4T7SrhkSyFst2I0f6P6gFujBlJQDHAGcO1nvN7MojWmbaKhzsklQD+BKMnLK7jNOOWgnyFWv+I8hESti8XuZQRINtY5sx5bra1lyazsCbjAvuwMeGmQDOJzNQCWTDsvGzF3GVJ3gjKzWwvXKBOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985998; c=relaxed/simple;
	bh=N9K2lSbMY9MsiMRz4ZwFKfpt4d3auIjGYtraxpQf+eY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opIB5tdefgLjkYLABisd6y/N4PHeQlwi6s2OjLbUTLov9jyV1ZDNDGllxvlw9dsFm+glgmvrcNV4b8UN4n6dTqFJdjFWojkI9GzIKgvWvc9kGb2A3ikPCQwc1j2LEvkZXx683fKbUUBGqyRXATO8lN1yUrUJlvcH0HrcnhE0Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMOPtzsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65A3C4CEF1;
	Tue, 16 Sep 2025 01:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757985998;
	bh=N9K2lSbMY9MsiMRz4ZwFKfpt4d3auIjGYtraxpQf+eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMOPtzsFCTV3rm0/f1GxX8v/XSvuoFhYNe6CyVM2s3AnvBhRtNEw9nw3Q61S9uOTB
	 lwKxAlIVDeHllWqRWe/VL2M3wN3anLyfWvzxF3s0FTJ8OtJkkRrA7EzSoINYQc1qdL
	 Louy7C1V+icM2rl+lRzrdA7MqmGyQaL/ifO8IAWLIsgnoJmHUY4PJdhH4pWoNnoNUv
	 hEyRSp0MdqOcopI3i146jpKdtr+0PFPR6BbKxCuap/CIhOmFR7PvbjRnZOYDp6NBPh
	 WSWSGnEFEJ2ne7eiOVrxKnSCR6LBQ1xQX34VU7G6upSZiVlIrkPxCyXsEbQouTgMqZ
	 s3RBQ+fPi7Xqg==
Date: Mon, 15 Sep 2025 18:26:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 fw@strlen.de
Subject: Re: [PATCH] doc/netlink: Fix typos in operation attributes
Message-ID: <20250915182636.7284c0ad@kernel.org>
In-Reply-To: <20250913140515.1132886-1-one-d-wide@protonmail.com>
References: <20250913140515.1132886-1-one-d-wide@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Sep 2025 14:05:28 +0000 Remy D. Farley wrote:
> I'm trying to generate Rust bindings for netlink using the yaml spec.
> 
> It looks like there's a typo in conntrack spec: attribute set conntrack-attrs
> defines attributes "counters-{orig,reply}" (plural), while get operation
> references "counter-{orig,reply}" (singular). The latter should be fixed, as it
> denotes multiple counters (packet and byte). The corresonding C define is
> CTA_COUNTERS_ORIG.
> 
> Also, dump request references "nfgen-family" attribute, which neither exists in
> conntrack-attrs attrset nor ctattr_type enum. There's member of nfgenmsg struct
> with the same name, which is where family value is actually taken from.
> 
> > static int ctnetlink_dump_exp_ct(struct net *net, struct sock *ctnl,
> >                struct sk_buff *skb,
> >                const struct nlmsghdr *nlh,
> >                const struct nlattr * const cda[],
> >                struct netlink_ext_ack *extack)
> > {
> >   int err;
> >   struct nfgenmsg *nfmsg = nlmsg_data(nlh);
> >   u_int8_t u3 = nfmsg->nfgen_family;  
>                          ^^^^^^^^^^^^

cc: fw@strlen.de
Fixes: 23fc9311a526 ("netlink: specs: add conntrack dump and stats dump support")
Reviewed-by: Jakub Kicinski <kuba@kernel.org>

>  Documentation/netlink/specs/conntrack.yaml | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
> index c6832633a..591e22a2e 100644
> --- a/Documentation/netlink/specs/conntrack.yaml
> +++ b/Documentation/netlink/specs/conntrack.yaml
> @@ -575,8 +575,8 @@ operations:
>              - nat-dst
>              - timeout
>              - mark
> -            - counter-orig
> -            - counter-reply
> +            - counters-orig
> +            - counters-reply
>              - use
>              - id
>              - nat-dst
> @@ -591,7 +591,6 @@ operations:
>          request:
>            value: 0x101
>            attributes:
> -            - nfgen-family
>              - mark
>              - filter
>              - status
> @@ -608,8 +607,8 @@ operations:
>              - nat-dst
>              - timeout
>              - mark
> -            - counter-orig
> -            - counter-reply
> +            - counters-orig
> +            - counters-reply
>              - use
>              - id
>              - nat-dst


