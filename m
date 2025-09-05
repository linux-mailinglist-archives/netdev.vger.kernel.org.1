Return-Path: <netdev+bounces-220496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D1B46688
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB21C3AE537
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50CC283FC5;
	Fri,  5 Sep 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPy+t+Rw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF01D7995;
	Fri,  5 Sep 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110740; cv=none; b=jXQOtVsa8eb2CYrO3rcAayOCywCNpMxR59HlIu/pyDe3/xPm3tbzz9nR4VwgoS06NoCGbRlyeahP26pHM4LcXCA8YSYMKoi1Zeszdh8W9qox/S5f3pKh9Bom1Ntzucr9eWvgwZJ+sNpm4K0pw3wEHdtjcXO0xKehhdpMGFieYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110740; c=relaxed/simple;
	bh=fr1L5O9T6sQLQSH5FWhvtM3wJ8aCnRcMGPUHkZ6k6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge7WRmBCcs1uBYhOHkb0DQCQg4wgIfxrmOuhjilh+UXmHW8jx1ghtg1LK3vJP5w2c+6mYfXt5U5pznpmL4wav+yMzXsBzNTOpiruoUC7uKP4aWTiCTJClbIwt8vgih8zI6y2WbCAlak7HXiLTPrfM9uCYLWe4zqdsuqrZc4OsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPy+t+Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2D4C4CEF1;
	Fri,  5 Sep 2025 22:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757110740;
	bh=fr1L5O9T6sQLQSH5FWhvtM3wJ8aCnRcMGPUHkZ6k6Xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPy+t+RwcaP/34pNJ9hGO2jyGw9dneGW4dBARkRdCgz10+Rr0hskDOYXg0WQN8B+t
	 VSM1Gd4SSeGlTZ3/poQffV+R2ztMmpJFnoZiq1oHMJhGhURvq1gDBQZbaOA4q4GFHE
	 0rff6i4UoStj86oD6XJgkRDqx7x2s/+tMB6Gzrl7194H/VpDCaiYOIjyCvBx/1lVgV
	 4xgtgp96XokpLKrK7dFiRcWzsrZ2h8V9hLaJcj2x/iAe20aUC+XcNpz1Tzn/vLYhoY
	 rDmZXjUr11IyTiesQelXL3SFNknwfqEa7vK1SptTu8hfy3W6TVHy9JY8GzNe1jee44
	 2JYmxg33q9CQw==
Date: Fri, 5 Sep 2025 15:18:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com
Subject: Re: [v6, net-next 00/10] Add more functionality to BNGE
Message-ID: <20250905151858.222c6b67@kernel.org>
In-Reply-To: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
References: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Sep 2025 22:46:42 +0000 Bhargava Marreddy wrote:
> Date: Fri,  5 Sep 2025 22:46:42 +0000

Please fix the time(zone) on your system. I already asked you once.

