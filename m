Return-Path: <netdev+bounces-108981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A39266B5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C515A1F21879
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0021836CE;
	Wed,  3 Jul 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByXDISKa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A8170836;
	Wed,  3 Jul 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026349; cv=none; b=smk0tDYVhqq4e6TJUVJghcBdLHn/Yqvb+azZsb812wY7CoIH504AewdzCPSmuHVjoKd+TguzcQZ3IG1f19TkLO9kVFj/EEUXPGccHwdxcjwk/e+8P8Y+rdxt/o3TIKI6llHVVQIq295uHPiAO4FuQi8lp22slKf/bcnBa/zociI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026349; c=relaxed/simple;
	bh=0Di2M/LZ9WT/cOov7yHyC0zXiGG70ndJqTm1uwOP8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEIA/2B3sQX25YD8AwtuS4EGXdF9wo4avZ8Yw4CJDqcvzwR85H7eVPSoryn4ZB5buK2OOgtXl7a6dR4rEFXrKbdzkuTJqwXVnOXUIwThUNpfF/hunsongcMd7l23DRPo6mbIj64tn4AghRnFx7z1qJ3/KjwmHoyh7oztjc3Duos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByXDISKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B59C2BD10;
	Wed,  3 Jul 2024 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026349;
	bh=0Di2M/LZ9WT/cOov7yHyC0zXiGG70ndJqTm1uwOP8fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ByXDISKabK8WI5PjhiQmPIV9XCbni6cBbULpTYJOCVvHnka/6a9koMf+AYTcSQBBC
	 U4frj93DWadxWK3oYgcAB2UrWjOJ0NGrbgLZ3sHaWQCywBE9IhGxEd8RPILcxgIZIW
	 aYfHPEoS9sGflTSehjDyp542AmteRTNqFcbJwQVNMEgN9IotaQcS/5bhnkWOfpwoDQ
	 expx1B6L3LAGnL5f+9yjB2brZxBWShJcX9sMiwsAp1FaL0KcB4+Wndn1x3/sXXKtFl
	 FxqKAQHZAdCMv0AW5aUmrgzJIEhLmIbDUdlOqYIbXegkg0dYcI+Ez7Wmv2qzdPnY7A
	 HBvs71/gVFarA==
Date: Wed, 3 Jul 2024 18:05:44 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 11/13] rtase: Add a Makefile in the rtase
 folder
Message-ID: <20240703170544.GE598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-12-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-12-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:54:01PM +0800, Justin Lai wrote:
> Add a Makefile in the rtase folder to build rtase driver.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


