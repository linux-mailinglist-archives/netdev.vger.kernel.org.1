Return-Path: <netdev+bounces-148769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B469E3180
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3277CB25E1F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912D43166;
	Wed,  4 Dec 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TANkfJTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29894A1A;
	Wed,  4 Dec 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279947; cv=none; b=bXe7zSVejkmDGY3M6pTk8KZaZ7W4Na1z97JbgMAbgVxWVToWnHngNRIbwX4/3iodrRjhtXfrpY5/aKyh2lVvndQb3DO0DZUnWNAbTMAYc93a7k7AbGTwpoSZGDSljr3sHXzPVKLTqOyjGdIWvgYhEwSfUbJc20xGBfmaXjh5HlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279947; c=relaxed/simple;
	bh=YfGuKivpCnaAxscooG0Rdp9GxjweDHDwFPdmw4ZztZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYwGhZ2/+mI/EXhha7Q5Vs6Fnvfc4b4xdbiOJtIzPK6rVcclzUynVayUH/2l8v1yjOUpBd8CF28HxsLeEKCOxjxL4IXWJMudLmCcOI4swt5KIiGT/0JzteMtRLs1OxW04CEwWcoVC1vxs1tMzDdPNOjwmnanYNqJotfSgHFE6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TANkfJTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9064FC4CEDC;
	Wed,  4 Dec 2024 02:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733279947;
	bh=YfGuKivpCnaAxscooG0Rdp9GxjweDHDwFPdmw4ZztZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TANkfJTHmIIRKBk9HgnjAY5n2wORlf0cFoNmi0k6Xel/i3704XlgWVAX1JTVsAJeH
	 PM2lmbuBkoYqW38YGJO826fZ7aD9nmXudC6rWDJb2OPW08CDtITHevui7fXIsTCuQU
	 Q9LteOeZQu01BQuxe760/kOxHqIlaZFS9ZqAWusi+T0fcpuA6ngwDlnDlVLdBxSzBM
	 Wyx+uIdnagluxHMPxQY+7u1q+OqYCVj67LdlxaYUeh+1I5PDA5ztfjV1h4tUaEErAd
	 E6Z1da9O5cY51TM2fP63VKhYOrCnvb4ZoKxEVIaIjvi61ahen5rNLYmYf5ZsoGf7kB
	 x4fwrdHfwcrzQ==
Date: Tue, 3 Dec 2024 18:39:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, andrew+netdev@lunn.ch,
 kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 0/8] ethtool: generate uapi header from the
 spec
Message-ID: <20241203183905.3343d9a5@kernel.org>
In-Reply-To: <Z06SGszVaXopVlhR@mini-arch>
References: <20241202162936.3778016-1-sdf@fomichev.me>
	<20241202195228.65c9a49a@kernel.org>
	<Z06SGszVaXopVlhR@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 21:07:38 -0800 Stanislav Fomichev wrote:
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index efa00665c191..859ae0cb1fd8 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -60,7 +60,8 @@ uapi-header: linux/ethtool_netlink_generated.h
>      name-prefix: ethtool-c33-pse-ext-state-
>      header: linux/ethtool.h
>      entries:
> -        - none
> +        - name: none
> +          doc: none
> 
> The first one fixes the bullet list (seems like mixing entries with and
> without docs confuses ynl-gen-rst.py). 

Ah, yes, that makes sense, either all entries should be objects or all
should be strings. I will spare you trying to figure out how to enforce
that in jsonschema :)

nit: "-" and "name: none" on separate lines

>          -
>            name: error-condition
>            doc: Group of error_condition states
> @@ -875,15 +876,15 @@ uapi-header: linux/ethtool_netlink_generated.h
>          value: 0
>        -
>          name: pair
> -        doc: ETHTOOL_A_CABLE_PAIR_
> +        doc: ETHTOOL_A_CABLE_PAIR
>          type: u8
>        -
>          name: code
> -        doc: ETHTOOL_A_CABLE_RESULT_CODE_
> +        doc: ETHTOOL_A_CABLE_RESULT_CODE
>          type: u8
>        -
>          name: src
> -        doc: ETHTOOL_A_CABLE_INF_SRC_
> +        doc: ETHTOOL_A_CABLE_INF_SRC
>          type: u32
>    -
>      name: cable-fault-length
>
> And removing trailing _ fixes the rest (don't know why).

Mmm. Trailing _ must mean something in ReST.
Can't decide now whether we care more about supporting ReST formatting
in YAML docs or protecting unsuspecting developers from this sort of a
surprise. So let's do the easier thing for now.

> Any objections to folding it as is into v4? I can go on and try to
> understand why ynl-gen-rst.py behaves exactly that way, but not sure
> it would buy us anything?

Yup, v4 with more or less the diff above SGTM!

