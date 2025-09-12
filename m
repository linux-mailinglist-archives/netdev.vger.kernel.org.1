Return-Path: <netdev+bounces-222685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C952B556EF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CC77AE01C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA5270545;
	Fri, 12 Sep 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmJM52sF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253A136347;
	Fri, 12 Sep 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705719; cv=none; b=cqdWptMkpBc3E41AnvNoo8oI4Dznx0AtapshYseqCvFRdM2LD1poAdi270b+/aSACjOpZqB61UWlqC7sYn4Wv0JdXpSz/9KVpRKDkBKQoNETHbKEs2AHbV/H6eHIM8qX3hbTUyrU8KYRQ3DClVBJZevML384dgnwmcNmG+054O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705719; c=relaxed/simple;
	bh=WsK/WJ4J8Byf5IkWEudUlpY48s4oWhzX8ky10objrAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gx//GnXwKtnjjLuZWe9EAd1FzXXvW+xvx+nnHVSdnPXJm6MPK5i6XwQpYDMhVVD6411ghprEylRgj4BIw3xliwfFDXN7WXFS0lv21hsBRZEODAdMom42B8mITvQNalKh2VAk7PbdEW5zZuzSBFv21kIwV7Ivr4h7YMqfjJkLDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmJM52sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A5C4CEF1;
	Fri, 12 Sep 2025 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757705719;
	bh=WsK/WJ4J8Byf5IkWEudUlpY48s4oWhzX8ky10objrAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kmJM52sFm4DP0TtRK7zJ2IDuzl3mkOETcMpK/kkXRZ51GiZbeDnneFx1oWBJLDlXV
	 7+DaU3wkKuN27XoSifL4NmX7Uis4XFE1NDj4C9eNsthzvnJ7C+WZ4v2UWkHcPH/78u
	 NvWccpoLULtnINcVycKDax5HqjeJsp2/g8m/ZbslhYu6HDYaPn4a57Yp98r7qTnwfY
	 Exfl+bN6IWSS2m6eXpUiJgcIMGkQ+/InPSuSkV0elkLSutkOu/qSyuC7kc5+iB/O8u
	 12AdMsGVWTa30trIQdBIHZ7etqzlbFi4wOc2VHpdQ83sbjjBGVsgEo/c65hWrIVJGp
	 STNCtFKuU7H5Q==
Date: Fri, 12 Sep 2025 12:35:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] netlink: specs: team: avoid mangling
 multilines doc
Message-ID: <20250912123518.7c51313b@kernel.org>
In-Reply-To: <20250912-net-next-ynl-attr-doc-rst-v2-2-c44d36a99992@kernel.org>
References: <20250912-net-next-ynl-attr-doc-rst-v2-0-c44d36a99992@kernel.org>
	<20250912-net-next-ynl-attr-doc-rst-v2-2-c44d36a99992@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 15:23:00 +0200 Matthieu Baerts (NGI0) wrote:
> By default, strings defined in YAML at the next line are folded:
> newlines are replaced by spaces. Here, the newlines are there for a
> reason, and should be kept in the output.
> 
> This can be fixed by adding the '|' symbol to use the "literal" style.
> This issue was introduced by commit 387724cbf415 ("Documentation:
> netlink: add a YAML spec for team"), but visible in the doc only since
> the parent commit.
> 
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  Documentation/netlink/specs/team.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
> index cf02d47d12a458aaa7d45875a0a54af0093d80a8..fae40835386c82e934f205219cc5796e284999f1 100644
> --- a/Documentation/netlink/specs/team.yaml
> +++ b/Documentation/netlink/specs/team.yaml
> @@ -25,7 +25,7 @@ definitions:
>  attribute-sets:
>    -
>      name: team
> -    doc:
> +    doc: |
>        The team nested layout of get/set msg looks like
>            [TEAM_ATTR_LIST_OPTION]
>                [TEAM_ATTR_ITEM_OPTION]
> 

htmldoc is not super happy :(

Documentation/netlink/specs/team.yaml:21: WARNING: Definition list ends without a blank line; unexpected unindent.
Documentation/netlink/specs/team.yaml:21: WARNING: Definition list ends without a blank line; unexpected unindent.

Shooting from the hip -- maybe throwing :: at the end of the first line
will make ReST treat the attrs as a block?
-- 
pw-bot: cr

