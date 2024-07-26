Return-Path: <netdev+bounces-113180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BF93D110
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5891C20FFB
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885D178CEA;
	Fri, 26 Jul 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koQ9ULRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E32178CE2
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989402; cv=none; b=FleTfFJJSKEBqXQM1wv9Y3lw0hJOI7Z4qCucbeS1T0+PuQRw9d1pyhHl2bQ2bKVxxzNqsLILB8kX7jV/+k2GYVieqCigogb88AtHVXWUZBPidIhmC8l+R/WiS7rv0xCkcGoJYjhwTOw79dLspSjFKPg5dCDyYge28FopmmNrJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989402; c=relaxed/simple;
	bh=GvBUKN2Kc44vs0VravGlBXkmSRPHwCnI8FSCCwbR7QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8oxxcMxyYqkOrs6BO64VI3LdpsUGF8gi1G+Ul/q0BosfHlUikOMoAj/TEJZJ8Th3aD686InxOfzI1HE5L38hNuTUP9wbq68LxOJZSbp/iXDCZ18GncEfOuhWHSYd0QBZIXzkZgiJqkrE0Qfb55ngD9XxZAW+oadrIXjlptnSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koQ9ULRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC546C4AF09;
	Fri, 26 Jul 2024 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989402;
	bh=GvBUKN2Kc44vs0VravGlBXkmSRPHwCnI8FSCCwbR7QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koQ9ULRjxdCqE+SZHBerbTobc1gH80CkF7NONNDpp3yQaDMwEjBbKtOI6fDJsuCQ5
	 8S/i4xgQ4cJ1lfU5GzSNeIM/UlSbAgPwQrpzWbELJtv/Zc9HMP1IFjZmZPfn1zbu1D
	 D6P6bfLH5AY7mC8Gv4yUBtLqWIUJty9dirR8xzWQynyPkTfE3k/3zvDMPJKNsmw2YB
	 eWfKoUKuDf+bAjCwKvGSrMPl7aAIQhJq+c5//jqaOUkbY41j3pfN74ycbO6JtBM/Ds
	 NskzoZidswcXQasKxGOlXd5XHlvnuDWZFjQkuMRmH2QIr87rf4dxe4I/v/0xe2RU1W
	 sfDgM8EDgvXAQ==
Date: Fri, 26 Jul 2024 11:23:18 +0100
From: Simon Horman <horms@kernel.org>
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	David Lamparter <equinox@opensourcerouting.org>
Subject: Re: [PATCH net-next] Add support for PIO p flag
Message-ID: <20240726102318.GN97837@kernel.org>
References: <20240726010629.111077-1-prohr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726010629.111077-1-prohr@google.com>

On Thu, Jul 25, 2024 at 06:06:29PM -0700, Patrick Rohr wrote:
> draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
> Option to signal the pd-per-device addressing mechanism.
> 
> When accept_pio_pflag is enabled, the presence of the p-flag will cause
> an a flag in the same PIO to be ignored.
> 
> An automated test has been added in Android (r.android.com/3195335) to
> go along with this change.
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: David Lamparter <equinox@opensourcerouting.org>
> Signed-off-by: Patrick Rohr <prohr@google.com>

Hi Patrick,

This is not a full review, and as per the form letter below,
net-next is closed, so you'd be best to repost.
But I will offer some very minor review in the meantime.

Firstly, please seed the CC list for Networking patches
using get_maintainers.pl --git-min-percent 25 this.patch

Secondly, as noted inline, there are two cases of
mixed of tabs and spaces used for indenting in this patch.

## Form letter - net-next-closed

The merge window for v6.11 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after 15th July

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

...

> diff --git a/include/net/addrconf.h b/include/net/addrconf.h
> index 62a407db1bf5..59496aa23012 100644
> --- a/include/net/addrconf.h
> +++ b/include/net/addrconf.h
> @@ -38,9 +38,13 @@ struct prefix_info {
>  #if defined(__BIG_ENDIAN_BITFIELD)
>  			__u8	onlink : 1,
>  			 	autoconf : 1,
> -				reserved : 6;
> +			 	routeraddr : 1,

The line above puts a space before a tab in indentation.
This is already the case on the autoconf line, but let's not add another
instance.

Flagged by checkpatch.

> +				pdpreferred : 1,
> +				reserved : 4;
>  #elif defined(__LITTLE_ENDIAN_BITFIELD)
> -			__u8	reserved : 6,
> +			__u8	reserved : 4,
> +				pdpreferred : 1,
> +			 	routeraddr : 1,

Here too.

>  				autoconf : 1,
>  				onlink : 1;
>  #else

...

