Return-Path: <netdev+bounces-117842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1804894F882
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97F2280E6E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E185197A9F;
	Mon, 12 Aug 2024 20:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241E19149E;
	Mon, 12 Aug 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495744; cv=none; b=bNKxmIbCcO6vLK9suYnCQfeFP6ap/6SD1oAknlOhJ/OtMty6yiGv7YBgNYuxTuH/zrD75D3UgRWKWDSY1C2ttkcE05pJGE1Jzv5jXAPMx/yum4UZPzaTsuRACHk6P7DTNtUcWTVazJOBS7WOyNa/t1mhX8HAsxvbtTlc/sLdSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495744; c=relaxed/simple;
	bh=ED3f/Tb433P02au29syvrev7Ewl+QZYhqLX0p1yePE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcMEll2AGXO8fGKvos0bfmXU9v8mZaZeiF5whfmyuaOXeLNKyjmWg8T7uADLReDWZZs9+nDePWTztyeDEqBvy7xQ5ULFrOUwo+J/1r7QjH08rWTPQ6IHU/I6WpSO/i5ScOH43PofgaD89iaZPb6nbiJQuFf+obEkS+9Nk9tTRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sdbyM-000000001YU-1BFi;
	Mon, 12 Aug 2024 20:48:58 +0000
Date: Mon, 12 Aug 2024 21:48:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for
 of_mdiobus_register
Message-ID: <Zrp1N5Eizm4jkmKW@makrotopia.org>
References: <20240812190700.14270-1-rosenp@gmail.com>
 <20240812190700.14270-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190700.14270-3-rosenp@gmail.com>

On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> Allows removing ag71xx_mdio_remove.
> 
> Removed local mii_bus variable and assign struct members directly.
> Easier to reason about.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

