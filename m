Return-Path: <netdev+bounces-116579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2694B084
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F411C21BD0
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59B14389E;
	Wed,  7 Aug 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s3gSTMnD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9C58203
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059640; cv=none; b=RXWZIken8NcA6xG0inT9pRyqVdb/sPcH4lv9jUqNtIV3mixQBHNn7MxMwtr5rfagddj7oGFXatHdlTYodM2Ht+H6HOxs0lWLH+7XqFlAfNWaWN4paN0Wku/MAgGP1aTvKmoVztWH44QT8kvnwkbaOuDP2PVgJSf2no2EmjmdVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059640; c=relaxed/simple;
	bh=LHzWTiXFQIvJakM1Tsf+MFzjnXSWw0wzTubbmvLa+BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMpfmbM/uy34kuYZv12NnFlHzHVIaXt2Ga53aUKPCg+I/CqXFczVNc8VAHweVn5cNRPPk+DP90AzUJq9qypLBwrXTW/tTUY/Lc9a4RPUvsTJm0V50j2pjVyefFbp1HuGI1Tw2Ydix7c0IdMtl/POPN3ChPCZosV0iSzMx59j6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s3gSTMnD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pLZ+9WZd1+RjbszYR81XZrOAyP9iEWN/bxaHACCq2GI=; b=s3gSTMnD5thDuQo0J8vugHipyq
	IiwhnPWzyQUSljfHuQ6mtpAVwO7MytPtD1sJbS6e+eBQi9G2LgivfI4bADUU28hhkjgSuBE+TlN/w
	+QypCBcxl45VCK6pzrd4b0workuWQf/893H7gQaVWhuogRwBjNZnu11wOV6cY16ksRcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbmWR-004EDY-7H; Wed, 07 Aug 2024 21:40:35 +0200
Date: Wed, 7 Aug 2024 21:40:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: mediatek: use ethtool_puts
Message-ID: <34ec4fe3-cbd9-4ed4-b92e-9b5acc2296f1@lunn.ch>
References: <20240807190042.6016-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807190042.6016-1-rosenp@gmail.com>

On Wed, Aug 07, 2024 at 12:00:34PM -0700, Rosen Penev wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.

Please run ./scripts/get_maintainers.pl on this patch, to get a list
of people you should Cc:

https://docs.kernel.org/process/submitting-patches.html

The change itself looks O.K, but we should try to solve the processes
problems.

    Andrew

---
pw-bot: cr

