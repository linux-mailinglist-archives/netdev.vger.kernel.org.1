Return-Path: <netdev+bounces-126136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4B96FEED
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEC41C220AB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D68BE0;
	Sat,  7 Sep 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkfBScG9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18315D512;
	Sat,  7 Sep 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672037; cv=none; b=I2UxQMW/jYdnr0b7g98j+Z7FX3cTFMNTZ0rCpfExBAA9KX6Z0H8cJnOyg1YNybQ9gSfHJlFWjCQr9Siw9OgEQMNetyZLktmeJaOMV1r3ZEMcL7tVkagypvnaMuhqXSB0NeDaGN+0TkpyKNV5TSBApYcFPHhiLnuKkPxc3GltBCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672037; c=relaxed/simple;
	bh=+Cuff5rKqy5TPadkKv9nzeCHPT3SjwAGmeFZkmlVRR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ela2Ekq2k8lF0rT06vaUQ9gxJ78khBA1K+28xKwygAihkbfNE5CKRhH8GIudvS7X4x16HLHtuSWFfM2W5lyKVPoBq1TtA5oKj5fv4eZBGGEZ1cpQKf/rBQMKd/EhOX7hwAZIPA6jw5KvjDGGe2xBALhjEXWcpy1DFz9tgbNLems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkfBScG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86873C4CEC4;
	Sat,  7 Sep 2024 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672036;
	bh=+Cuff5rKqy5TPadkKv9nzeCHPT3SjwAGmeFZkmlVRR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkfBScG9lf9iDg9Guvbs7ieA+CCvWyaydEfb3t3jZe0wNkaOeRzRUIyJIxR3FdwE7
	 oyfT6uf1yW4gSSAfUZGPoj48qIirSkxJa2Ku0AVyrUWufUrZDvABAQd0IP7bcqq13W
	 wRXn+81VmK1sKzJCks1y/4lZiq9N3AMka/Yl4Waab+Rr7R/MtV9jyozIpuyVbCx/JR
	 o0inFpN3Co87LvoD7d52Yqur9HaInzJu+xCxLrzhCGU8IZYxRS20PJ8MMjdPRCC9z7
	 dSdLnKcTdMm+mxsuqpZkiLw+vvPxljbYn0PMRt/9x3d2A268eFa3ow17t7JyguM+sW
	 R+Ys/30QQJuEg==
Date: Fri, 6 Sep 2024 18:20:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@collabora.com, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
Message-ID: <20240906182035.57c478bf@kernel.org>
In-Reply-To: <20240904105143.2444106-1-martyn.welch@collabora.com>
References: <20240904105143.2444106-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 11:51:41 +0100 Martyn Welch wrote:
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -static void enetc_get_rx_tstamp(struct net_device *ndev,
> -				union enetc_rx_bd *rxbd,
> -				struct sk_buff *skb)
> +static void __maybe_unused enetc_get_rx_tstamp(struct net_device *ndev,
> +					       union enetc_rx_bd *rxbd,
> +					       struct sk_buff *skb)

Are you sure you need the __maybe_used's ?
Nice thing about the IS_ENABLED() is that the code is still visible to
the compiler, even if dead code elimination removes it the compiler
shouldn't really warn about unused code.
-- 
pw-bot: cr

