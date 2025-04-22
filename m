Return-Path: <netdev+bounces-184820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995EA97500
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DFB3B2F20
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D202980A8;
	Tue, 22 Apr 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXvAH024"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA938382
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348301; cv=none; b=E92YtcN5ZRxJNCzyDN0pBTUXYtKIyeHdzvgMFY5Apr0XgJ9jysJZQs628x/55KcUS+gsSdHlbez9upT0hqjZMKAmqWvdy+liCTkubBxD/266ariyPWSzqzPN3ino1px6LlZmVarQFeUn/z8g+CFeGedKMYp0uUVqnEaFlmgDRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348301; c=relaxed/simple;
	bh=CMpt5bYhaQyjXV8xBjXhp7hpdYIjsyM6zZaJsRI8B0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtdn4FsXJ9SLVs+b6/4g3eLpHnXrMeyhgnw/H4F7arVK6vvZxTJrjAmdFADFEvmvWa2nBeqD9L4eYHi+jzVGiyrDUdDmfEGVCgc23TGVrVfkpwySvoZFGulnnfPsdNPIYNFCBdDWFy7bsnem2NhIn9JWNjJKEKJRjHRhQxA44IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXvAH024; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3579C4CEE9;
	Tue, 22 Apr 2025 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745348300;
	bh=CMpt5bYhaQyjXV8xBjXhp7hpdYIjsyM6zZaJsRI8B0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXvAH0244aCGU1zcl5o2HJB9SNsL1kQTBn5snYTe1PoKyrrXmfzoaLnODQWsHhq8l
	 bDBhbPO/j6Cr8rbeMwbHW2DX+H31bdAEVhEw25RgWQ71ewmupB+2DKiBNzasbo0lMs
	 qwlDu3PLU+cGMT2WbMt3rL0VLiRwzJIEFgxr4jG8ePv5io/xdpUCeWk436hFxJ4nkg
	 5iiA1KXihZEIL1V1UkqPUE3a8AVXYC6KWDdHZc4ZhfIUcVxW3nPp/eNgPgv+/b6dBT
	 9vyVr6aLFCSKjGYfMpVeabDywo12GwTJkjBj2kT0oEd+xehVckq7aBOMv7d2HweGa+
	 iGFXOGcf6iusA==
Date: Tue, 22 Apr 2025 19:58:16 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] r8169: merge chip versions 52 and 53
 (RTL8117)
Message-ID: <20250422185816.GQ2843373@horms.kernel.org>
References: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
 <ae866b71-c904-434e-befb-848c831e33ff@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae866b71-c904-434e-befb-848c831e33ff@gmail.com>

On Fri, Apr 18, 2025 at 11:25:17AM +0200, Heiner Kallweit wrote:
> Handling of both chip versions is the same, only difference is
> the firmware. So we can merge handling of both chip versions.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


