Return-Path: <netdev+bounces-95714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCE8C328B
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02C91F21A35
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD47168B7;
	Sat, 11 May 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKfptXyB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62DF1B7E9;
	Sat, 11 May 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445496; cv=none; b=L7eZPIEEVQ/THMDHF8rElVU78QM2dXY0r3dO6YAOJLDeBj6vFa/tvvl0s5FR638HqdDm9/xJcapTbBjc6uiZ2DxSfxKypRydKo32ww4J4CdxXcc1ljsyKaX7bi8UaD87mYsb5mju6SeSttgEYToTO/0GlQY5A8/w8zSCe/XgnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445496; c=relaxed/simple;
	bh=e94BgLcLEdR+T6CinJz6xb5bntXFyDdNlBr4TIoWFHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fllR+wKqAGWsliTNUSTTWb2q0IzXWx0kq0UvdObSXyYEpBfAE+eam559bfeuqHKLtNEWUT61NCo42t+KMdYYUThb2cuiC3S9WgSkMd8vdNMUwNLlw47ASedunECBQYK7PdjXKRRup0+bnFwo9S4gBhl7T55/xNfKSpBCaaVwwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKfptXyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C5AC2BBFC;
	Sat, 11 May 2024 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715445496;
	bh=e94BgLcLEdR+T6CinJz6xb5bntXFyDdNlBr4TIoWFHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKfptXyBYmoClepdP/CjknBDwgtvv7FtGgfdpmQKpJSA8mp1gTDxw7zJEq1CPE+lP
	 EQ+LzPPY6INJ6SyEqNngj5VixGphDfyn6Wlg3Wn+Dk22GlOggjq/oTiYnEg5lCU/fP
	 Am7B+lRaSGxZC+8NU0FE3ia80oI/tgR9/mcJ+nznzHpnD8AyRMolsQg5fxz1UFC0Gg
	 sWEUC0BgONbmRKBdifda+X66NiBZJw8u5JRvdqw8ggSrfmE0wv8Id/f1KwQw7HhVtm
	 S+lkesdmCXnOMZEtGQOKotoXYZ6lM1zY5Qqi46qx01VZS0UmNV1AUIKHqmKLpT+tlf
	 AhnTPdext5dGA==
Date: Sat, 11 May 2024 17:38:10 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, alan.brady@intel.com,
	maciej.fijalkowski@intel.com, jesse.brandeburg@intel.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	joshua.a.hay@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: Re: [PATCH iwl-net] idpf: Interpret .set_channels() input differently
Message-ID: <20240511163810.GN2347895@kernel.org>
References: <20240426154125.235977-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426154125.235977-1-larysa.zaremba@intel.com>

On Fri, Apr 26, 2024 at 05:41:22PM +0200, Larysa Zaremba wrote:
> Unlike ice, idpf does not check, if user has requested at least 1 combined
> channel. Instead, it relies on a check in the core code. Unfortunately, the
> check does not trigger for us because of the hacky .set_channels()
> interpretation logic that is not consistent with the core code.
> 
> This naturally leads to user being able to trigger a crash with an invalid
> input. This is how:
> 
> 1. ethtool -l <IFNAME> -> combined: 40
> 2. ethtool -L <IFNAME> rx 0 tx 0
>    combined number is not specified, so command becomes {rx_count = 0,
>    tx_count = 0, combined_count = 40}.
> 3. ethnl_set_channels checks, if there is at least 1 RX and 1 TX channel,
>    comparing (combined_count + rx_count) and (combined_count + tx_count)
>    to zero. Obviously, (40 + 0) is greater than zero, so the core code
>    deems the input OK.
> 4. idpf interprets `rx 0 tx 0` as 0 channels and tries to proceed with such
>    configuration.
> 
> The issue has to be solved fundamentally, as current logic is also known to
> cause AF_XDP problems in ice [0].
> 
> Interpret the command in a way that is more consistent with ethtool
> manual [1] (--show-channels and --set-channels) and new ice logic.
> 
> Considering that in the idpf driver only the difference between RX and TX
> queues forms dedicated channels, change the correct way to set number of
> channels to:
> 
> ethtool -L <IFNAME> combined 10 /* For symmetric queues */
> ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */
> 
> [0] https://lore.kernel.org/netdev/20240418095857.2827-1-larysa.zaremba@intel.com/
> [1] https://man7.org/linux/man-pages/man8/ethtool.8.html
> 
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


