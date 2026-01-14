Return-Path: <netdev+bounces-249698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FCCD1C360
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE03300949C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0432F6920;
	Wed, 14 Jan 2026 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Kerekv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9221FF5F
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360284; cv=none; b=g3G4dMZqxoAnGclWXXD8lYqXS/r4mskayntZ0va2FUEKiJ25/AmhyvTncv2OjQJMByW6lxLcstFIG6OnAgtuATf0wUbnt2TQtT357ZhM4c1akvW83ivStxhpN9m/oVdz9l9kGtlJVOV1Wge6Qf4e9Y/Cm6SbjUCThBCHCsTwft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360284; c=relaxed/simple;
	bh=M7TYh6FlKn9OC4w77BQZZM3jmcLVgxboo63sSmjy01w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbd5RLDyWfxBOQEsB1MDBRuqPxxyapDlYJwFfg0LmiR0Ix5788q43cxFNoNi4bitAiz5p+7vX1XGnXoJS5s/L3xr+fPEnLmAQYFR5KVSWfPJCfBdWWIrip9dSkqM2fMw79ocoopzTdeRzvOeuiE4Lp7/1TPyJr3F0IWEcc15TyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Kerekv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15E9C116C6;
	Wed, 14 Jan 2026 03:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768360284;
	bh=M7TYh6FlKn9OC4w77BQZZM3jmcLVgxboo63sSmjy01w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1KerekvCCq4UZicaeJtQlluHFWZx7FBXaE6WbvKkdgesoZhsy2/FhxpmH1BuncOD
	 j/WcKA0GU31TSVgfHDpi04CstbZpPE1AC6fRd+61amlPNZtGlBQBZa9XKrTqGE38UO
	 phtb4Kua1iF2Gz6Kl0SbdkXSH8nV4mYcA0vRGXltSE3m/6M/bs20fvP12IW57HxWTz
	 TT300nsJB4o9gsEQKl6paCkrmV1ArUAx/KJ4U+u5JMhmT5obFYrRBjR6ip0ypzrFbS
	 Z+6/IyirAkv3LFcRo+9ncLsX2w/Xqkvc26E/8DBFai351FetVDGdoShOqflVoQN0xJ
	 7pWukhUb/Gzsw==
Date: Tue, 13 Jan 2026 19:11:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tom Herbert
 <therbert@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
Message-ID: <20260113191122.1d0f3ec4@kernel.org>
In-Reply-To: <20260112200736.1884171-3-kuniyu@google.com>
References: <20260112200736.1884171-1-kuniyu@google.com>
	<20260112200736.1884171-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 20:06:36 +0000 Kuniyuki Iwashima wrote:
> fou_udp_recv() has the same problem mentioned in the previous
> patch.
> 
> If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
> fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().
> 
> Let's forbid 0 for FOU_ATTR_IPPROTO.
> 
> Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/fou_nl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
> index 7a99639204b16..0dec9da1bff46 100644
> --- a/net/ipv4/fou_nl.c
> +++ b/net/ipv4/fou_nl.c
> @@ -15,7 +15,7 @@
>  const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
>  	[FOU_ATTR_PORT] = { .type = NLA_BE16, },
>  	[FOU_ATTR_AF] = { .type = NLA_U8, },
> -	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, },
> +	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, .min = 1 },
>  	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
>  	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
>  	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },

This code is generated, please use :

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 8e7974ec453f..331f1b342b3a 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -39,6 +39,8 @@ kernel-policy: global
       -
         name: ipproto
         type: u8
+        checks:
+          min: 1
       -
         name: type
         type: u8
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 7a99639204b1..309d5ba983d0 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -15,7 +15,7 @@
 const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_AF] = { .type = NLA_U8, },
-	[FOU_ATTR_IPPROTO] = { .type = NLA_U8, },
+	[FOU_ATTR_IPPROTO] = NLA_POLICY_MIN(NLA_U8, 1),
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },

