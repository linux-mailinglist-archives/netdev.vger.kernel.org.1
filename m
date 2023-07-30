Return-Path: <netdev+bounces-22653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CB7687B7
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 21:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67A128168A
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089E14F7E;
	Sun, 30 Jul 2023 19:52:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE814F6C
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 19:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4658C433C8;
	Sun, 30 Jul 2023 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690746764;
	bh=q6hhOZkoXhxMvYqFPQ1Z+qQRU5p1Zz9lZvoCEx4F4EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1lckKZV5i8eyVgwOnKZYUcpNNH60WXuY7KUiSq2kQBeOkTZqA/YihmaJK+EMr5PB
	 e1xYfC8mJipj3eYWbcip5VLy/Otmsxog2l7XVIoGnZnD3yGsYxBh1sgrcU99X7vOU/
	 2qS9sPcvRP1lcXFHwXwGMDovVG03Nx4Snug5kUUWAahAOCSoQciucdbAjErqwE4w09
	 McaVF0h1ZScFzTANVawTaQGGboRsqYxHd48A08LNjFbIc7XyaASaCYxreIi8Y+UoGU
	 1jSPhd+36IB36M5MzuG7Z0bO4lU+TkINDuWO9JD4PDDdDd86b3CONY5peyI+ta1vGA
	 W8TBQlbPeAEAQ==
Date: Sun, 30 Jul 2023 21:52:39 +0200
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/5] net: dsa: qca8k: move qca8xxx hol fixup
 to separate function
Message-ID: <ZMa/h1SdZJCgBs+O@kernel.org>
References: <20230729115509.32601-1-ansuelsmth@gmail.com>
 <20230729115509.32601-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729115509.32601-4-ansuelsmth@gmail.com>

On Sat, Jul 29, 2023 at 01:55:08PM +0200, Christian Marangi wrote:
> Move qca8xxx hol fixup to separate function to tidy things up and to
> permit using a more efficent loop in future patch.

nit: efficent -> efficient

