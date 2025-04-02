Return-Path: <netdev+bounces-178863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BBA793B1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAD9170583
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E31A23AF;
	Wed,  2 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ72hOQE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211519E7D1
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614242; cv=none; b=K+sv0JPd+lgc8slIf553l4Blus3siIx/ZTLmJqwAVY2Mt+OQJ+AdkzfsSMw8OMcXQ3SbxE4CP45p7Hi6IvQoDFDAToiduUAoo/f5fRwcEIqPcrmEO/San+eroHf6vVyNsp7yNsRrdw60C94OXvNdg7BcvPJLUgdCbMRIoCfh3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614242; c=relaxed/simple;
	bh=ON026Py2RCyn/rrdfsj6eaQKF2/OF5A0fOi/BWyTS3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMm987UYvDTw/yyezXipveGIWWfFm3l6UL8/jGurgj7uPtQF4eBvuZM1JN7iWJp8RsyOb0XXvRNAC1thVgmMk3QyOCDgLkyhXlWPpwmVHruy7wyfjk/1irvNq/zGnVRvsH6Zdn1aMq48R4mJ6u+iuI509NihswWvNX5JtGUPUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ72hOQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84102C4CEDD;
	Wed,  2 Apr 2025 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743614241;
	bh=ON026Py2RCyn/rrdfsj6eaQKF2/OF5A0fOi/BWyTS3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RZ72hOQEin3+2l9/eVcmQl6coWSva90HcKx60Qgla3i19nXW+2C9cFMheiPq6QWJm
	 WMnQO6QQFEA29LoNfZ1eiapVNDBMsb2XyxcN8uu3FlNrbmxBBG/WeDLG10dyI5lJhs
	 L2pUnaK9OWlNiarNLV9Z4nQ/hxtBLVe3EUx1iwaYMlasV+o+njT2ixklIr4+2uGH4u
	 ZAt94oRD5iex1iYec86MZzpEeoP1D+YumHMXBnp8ZpVjtVzppASVqmucP9ycX0+OOn
	 RKpQw38h6Gk7oemmcyARbBQw+AZT1+JpLiEsI72Wxv+jFZI+i+ks2XJ3tWAPPMoN1z
	 j9obJvUhYWGIA==
Date: Wed, 2 Apr 2025 10:17:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <20250402101720.23017b02@kernel.org>
In-Reply-To: <de9d0233962ebd37c413997b47f3c715731cfffd.camel@gmail.com>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
	<174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
	<20250402090040.3a8b0ad4@fedora.home>
	<de9d0233962ebd37c413997b47f3c715731cfffd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Apr 2025 07:21:05 -0700 Alexander H Duyck wrote:
> If needed I can resubmit.

Let's get a repost, the pw-bots are sensitive to subject changes
so I shouldn't edit..
-- 
pw-bot: cr

