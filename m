Return-Path: <netdev+bounces-123474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D03965040
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D058128B2ED
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE41BE24B;
	Thu, 29 Aug 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMdnEFCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B11B86F2;
	Thu, 29 Aug 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960875; cv=none; b=dmi0hbcB+pezZcqjg9REdgqLjx4foCDfJp6S0Yssg0grvYP5XSTarC7vIpS3i/eWOGmYHXIR588tpa8TtirDjKlijz2Y+60gRokLE89C6M8Srgygg7XqwR7qWeLCoO7HaMFcN1+XImncEeeA4pzcmw/e5gqw4Y+1Lq/Ci6tDenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960875; c=relaxed/simple;
	bh=4UOSVpveq2TA4+lEIboJWj2PiE++4cFUl4B1Zxcx110=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIzXWOXR3+QNT/yZEjwqQBsKeAkmlP8fIM4YdqrrMBtXCzmXT7+I2n/o+F2VVBrv9ZjKLODQLM1omwAz8Xu3/chgdNWPy/U9kDslIcO3BGleX2lolg/iT7hf/zJrA/qcZfQbejzS3pE9Vr2j4pxhZ8Af0mkryIcDZsqdNrngeC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMdnEFCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038D2C4CEC1;
	Thu, 29 Aug 2024 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724960874;
	bh=4UOSVpveq2TA4+lEIboJWj2PiE++4cFUl4B1Zxcx110=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AMdnEFCmUtdDtt5LUlzIKXhF9LruCntnSbFBsWZTHCFXhg3eH3B0+p/O17w9oDqWG
	 +5M0nnHIB6PWmlYM5hfbG64heMZpvilVTYZqIWeMhCpget4/zoVdwvhQgpTiOaqyv+
	 GtLE0Lb/z6Wp973zK0gO57mwRryozbm5A/bwHcprs7vi1TlXTs1VHovnc+jEXCpvNF
	 bxaZ+Bp14Lqx1PJuHFwMJ/qzumvH4poYqMOnMN8n6ydxCux/8nb9tOAzWfEJeLFc0u
	 f4vUCM8k0fxswN6OKaFM8QAbOGK1FuN+qPKV2eT4vmusCNlDHI7C4Rth8sSuBm/PFw
	 CFKoR0ckH3reA==
Date: Thu, 29 Aug 2024 12:47:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 o.rempel@pengutronix.de, p.zabel@pengutronix.de
Subject: Re: [PATCHv2 net-next] net: ag71xx: update FIFO bits and
 descriptions
Message-ID: <20240829124752.6ce254da@kernel.org>
In-Reply-To: <CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com>
References: <20240828223931.153610-1-rosenp@gmail.com>
	<20240829165234.GV1368797@kernel.org>
	<CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 10:47:01 -0700 Rosen Penev wrote:
> > Please consider a patch to allow compilation of this driver with
> > COMPILE_TEST in order to increase build coverage.  
> Is that just

Aha, do that and run an allmodconfig build on x86 to make sure nothing
breaks. If it's all fine please submit

