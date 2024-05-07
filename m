Return-Path: <netdev+bounces-94334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA0F8BF344
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540BEB264BC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDD4137938;
	Tue,  7 May 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql4FZyWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44D8615A
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126140; cv=none; b=lq6HJQWmXwS5hFRvf1hJzuQMF5U2R7Gq5NT65AE+VeacOMc5v1cLKTeiCnW+ipjJX375cCVodf3VLU/R8Jl7T2pSMiDIXbepzI+8wqpSvEHjTnmZ9c4ikd75oZwWYLmsvqSS58bohk/Pn9TEdBbAzunTbK5Cx4rvqeD37zkjqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126140; c=relaxed/simple;
	bh=FlBxcv4ZKz+pdS004N5IoDqRqKw2ycRNFdOm6xLHxSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2cDTcEtk+Pnwnmb5D5UilMMaKe87DEkko+SAb5lloZQQIOlqLVk3n/4Xe7fwTp4mhyvjXYcrDuK6O64CAxXIzHJwcX3vCywSz24A+vV6ZezwomhjHysdTvc1InybwkLcixLpb639yqIrnxzl5P/IcvcohxjTYm4OA7IbYoy/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql4FZyWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2825DC2BBFC;
	Tue,  7 May 2024 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715126140;
	bh=FlBxcv4ZKz+pdS004N5IoDqRqKw2ycRNFdOm6xLHxSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ql4FZyWurgJrJ4rj/gRcByIPddrWA2Ah6ZNcXlYH2HAzFCl8EXkMeeSuKJ6NeUfGE
	 Qy34uKFAObgX8Q8c1u9yEpxcQR8pMf8dte3T3FkapYTKq+XN+btgbJSH4R/Lh03YQU
	 o55r4tstR5pJp+uqIgDxDYtPGQHosTk9vviTI0nGkVzBp8By4rIXSKG/oP84ZndPtW
	 wlku0c5xRdyixkJBukmLx1xFfAlkQwGxdisKIAjrqTtnQh/rf6t3IDc9wx9hVId2qx
	 f+0HFa5dclUG4B6KencG0W1ZSsEUGSMTiLX1zmLd1gCdr52hX4bNNiyO87aFlGRTWD
	 R6OmCoUZ2o9og==
Date: Tue, 7 May 2024 16:55:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 24/24] testing/selftest: add test tool and
 scripts for ovpn module
Message-ID: <20240507165539.5c1f6ee5@kernel.org>
In-Reply-To: <20240506011637.27272-25-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240506011637.27272-25-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 03:16:37 +0200 Antonio Quartulli wrote:
> +CFLAGS = -Wall -idirafter ../../../../include/uapi

This may end badly once the headers you're after also exist in system
paths. The guards in uapi/ are modified when header is installed.
It's better to -I../../../../usr/include/ and do "make headers"
before building tests.

> +CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
> +
> +LDFLAGS = -lmbedtls -lmbedcrypto
> +LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
> +
> +ovpn-cli: ovpn-cli.c
> +
> +TEST_PROGS = run.sh
> +TEST_GEN_PROGS_EXTENDED = ovpn-cli

TEST_GEN_FILES - it's not a test at all, AFAICT.

> +./netns-test.sh
> +./netns-test.sh -t
> +./float-test.sh
> +

nit: extra new line at the end

