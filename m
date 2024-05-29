Return-Path: <netdev+bounces-99069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94618D3985
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D31F2178D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0A159216;
	Wed, 29 May 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GNR06GsV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD669158201
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993713; cv=none; b=SnmczLXlcLEHS7vHVY/XxUmt1UFv9yJdV0uRCQZVR7k6UVE74QM8hTvch4Uuc3LUrU5F3/AUzh4ZxA9ULCRDxP9qB8lz7/7hJ19Hi+7bxqt8sWP02u7a2m8qm7ZGo7pgLPfIihL7RHU89+HHmgIZTb464mPAlbkoiYhv6XSXpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993713; c=relaxed/simple;
	bh=DzVZnr8EehHCqgwrX7C/IbrclTvaKjtee2Mh4zEhao4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmIcHIOUa5CpcMgQsz/bkb1U9YFoDJ/NvxHK10VbvteYIiMgqq+B09lWbmz919T8dTe5/PaljbnduO9Oo3lTE2cHfQv7kbXnofXJt4zWcjh1oucfkglLCPYIQxIdunpSi7qqqVvZNkDuuAnzj4Io1uw8OvJI+kZLK0GhzUAlMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GNR06GsV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IRZynocr/tTeUilm4xkJlwqyjNdzY/FslPNT5Qd8p+o=; b=GNR06GsVUQnBLY0V5w8USH6PfR
	Xz/kNmbZPIs4i/zAIud/9cce37YliOJE9E+zBFm7YVx/ZY5yMdVhq8Qfw/t0d9snL5qNAWu9W/AYK
	Vr9Gdzu/DZEJqmhUlbJyNAv1+ugNG40/pqw5UYLsiWcK3WYAa8CXtcOeKo0/obEOYTHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCKUt-00GGUJ-MR; Wed, 29 May 2024 16:41:47 +0200
Date: Wed, 29 May 2024 16:41:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, arinc.unal@arinc9.com, daniel@makrotopia.org,
	dqfext@gmail.com, sean.wang@mediatek.com, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	nbd@nbd.name
Subject: Re: [PATCH net-next] net: dsa: mt7530: Add debugfs support
Message-ID: <9ad6b014-11e1-4def-8217-b1fbeac768c3@lunn.ch>
References: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0999545cf558ded50087e174096bb631e59b5583.1716979901.git.lorenzo@kernel.org>

On Wed, May 29, 2024 at 12:54:37PM +0200, Lorenzo Bianconi wrote:
> Introduce debugfs support for mt7530 dsa switch.
> Add the capability to read or write device registers through debugfs:
> 
> $echo 0x7ffc > regidx
> $cat regval
> 0x75300000
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

In addition to Vladimirs NACK, you can also take a look at how
mv88e6xxx exports registers and tables using devlink regions.

    Andrew

---
pw-bot: cr

