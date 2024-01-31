Return-Path: <netdev+bounces-67594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959BD844320
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0EEB22FAE
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541D84A57;
	Wed, 31 Jan 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tQKIsYzR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57B83CD9
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714777; cv=none; b=WOrd5GOhMsbGPqhCLG5JcQms88gCVQmZmiU/eu1lNInlL/QiNNtNquVsShdazXMg8Gy7nmKHzZKlBxXX/xgrqwK2QAMmgxBsfEJBTdUORFnDoQ2KEJ9okYYRqQlXLi9WOpyVnCUf/EyKKlhiTQQ9oxJrln7UvOjBlb1rkBCivLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714777; c=relaxed/simple;
	bh=we7drgb4hCZaTzFFDjfURIKc1sZEXo/21aFoeXmbVyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMwsTV2lkofLwEe3Hu7YfB14pLiFuPfVBy0wBuTpTcjFd+jCke9Iz+1DpFknZVeeQGIpYc5sCxcR/6OqfGKuCuivsj3ZLGhBqHLq99f3gTvQrN1taPtrrQ8Lbu4ZxvZ681MJ8yR0BGq8Mv4dgfcGMXq5haoNda5DXJtvu7TMndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tQKIsYzR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3vPRNiVd51DaypjmK44mTplMC+EIyR6GmaeSnddIGMM=; b=tQKIsYzR1cbh9/0TnS74VwLOCv
	TWNmbAFJ5xf2Awi1lBIlM//TChMb2GaWCmoBeFsBqZ89CS+8UgWcisp5KPsYGCm1ORXirv//2ecUU
	KcJQGGLij6XpVkKCzdsZA33QTsskJLUCpZnuru/7xhChXkTpz8hi/nnMLaLDnZZF/2Ww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVCTY-006auE-H9; Wed, 31 Jan 2024 16:26:08 +0100
Date: Wed, 31 Jan 2024 16:26:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next RESEND 1/1] net: phy: dp83867: Add support for
 active-low LEDs
Message-ID: <b97a8aae-2a16-4a14-8eac-94ab6677cfbc@lunn.ch>
References: <20240131075048.1092551-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131075048.1092551-1-alexander.stein@ew.tq-group.com>

On Wed, Jan 31, 2024 at 08:50:48AM +0100, Alexander Stein wrote:
> Add the led_polarity_set callback for setting LED polarity.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

