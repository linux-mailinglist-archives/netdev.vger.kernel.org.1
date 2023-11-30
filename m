Return-Path: <netdev+bounces-52345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9A7FE7AD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802FC1C20A1E
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AB125CC;
	Thu, 30 Nov 2023 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCyhMZiT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BFF50C
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199F4C433C8;
	Thu, 30 Nov 2023 03:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701315349;
	bh=XGqmWD77sXdnGWOA001IM8JkoCwVcsIqbJiBnf0OjS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hCyhMZiTzDYBthI+byvs2789ZnDTPq0GnqTTPL2rMWSORvLiSJ4EmbdSqHHTnmEo0
	 NF+m8Op4fqbfP5oJA9Bq91IeuuSyaHtTSjLGMg1xuYXjToltPNpxkj1Nco7M9nOQzf
	 3TG+5ru79RtfwvaBTbVxXgXSqk3hnaBbhSmaRg7FZaszOzwYoJoKjHo/hQnXDuM3vY
	 1wJFwgKPN1riIlGlOlCub1+7Y5vI/Zecmq0f5n/7uQHfDNideKOe6M+JPdDwljpRrq
	 qfcjllUGfLrfFThL+cKUnpQCCwW96n6YAbDi2EC7/dWe5doZ5TPvhNikbTxbYfGNXz
	 ixPXyT316I/PA==
Date: Wed, 29 Nov 2023 19:35:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Yinjun Zhang <yinjun.zhang@corigine.com>, netdev@vger.kernel.org,
 oss-drivers@corigine.com
Subject: Re: [PATCH net-next] nfp: ethtool: expose transmit SO_TIMESTAMPING
 capability
Message-ID: <20231129193548.1e77e7cc@kernel.org>
In-Reply-To: <20231129080413.83789-1-louis.peens@corigine.com>
References: <20231129080413.83789-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 10:04:13 +0200 Louis Peens wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> NFP always supports software time stamping of tx, now expose
> the capability through ethtool ops.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

