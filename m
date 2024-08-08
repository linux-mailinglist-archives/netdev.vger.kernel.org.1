Return-Path: <netdev+bounces-116870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111C194BE8A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3281F2383A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14218E04F;
	Thu,  8 Aug 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUnTul+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6B18E04A;
	Thu,  8 Aug 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123810; cv=none; b=Fd8p+sRSfXCtA7Xa1BWW52Q09OgTsPneUfZHaEZMMAnkF+LYnTdJ1jFKCr0+nDQkdUnG8YJcfP/YfkBsuJTtsS267JRrXVAqLXaaLmdcqHG8n1iGITaCMbUohViAIIjZnrdNjp6OzZwgZvIFVqdKF/3uzv+hlHNA94sNYwceD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123810; c=relaxed/simple;
	bh=DlP0zX3eBjD2w3vvB5KSjQBTWHK/NSxJgNxSmFXeafs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhtTGcEf55OJ9SShYf210E9/tRL/Nz5BiWzIR2A9MljWEfIeUps98Xw5qGN4xA0v13oSOcjHxT6ksnZBt28aoWHfQB6x7IpoisHQVOZLKdFziZ1BBBdTnMkvlyhTf4GrSINY+AteVk0L3NIPeBCingb5L2ygrtVsJ2URqB9BAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUnTul+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666FFC32782;
	Thu,  8 Aug 2024 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723123809;
	bh=DlP0zX3eBjD2w3vvB5KSjQBTWHK/NSxJgNxSmFXeafs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uUnTul+5LO3hEZu4GmsiOxTvMojWVRD41pJpnNiZSVNSrFqBcVFfI20U9s75KlFGb
	 fG/vt0815niVIHfs3exCPPbCJj7Hh+WaZoT7E5DnemGDR4Be0UsLaEbCJ+vxOFiDkh
	 8uhyN/jEStXlYYjYldEeKJACAzZvwh1GgIfwLWEi9Wpg6UzKeOjk95rpOSdDo5dQDC
	 iV6rTkhDiSfTw2w+A4/L0ooei6hRFCfasHnJyvDg6wbEvSBES87WUnnnuUPm+S1+x8
	 6JSsbE0sln1jn1Bh9d8i1zJrXbH27Ox2VnrTH8HQWwXNwes7maTubPAFNjC6gJyJIk
	 c3sXvh256FXeQ==
Date: Thu, 8 Aug 2024 06:30:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Message-ID: <20240808063008.6cce71f5@kernel.org>
In-Reply-To: <20240808145916.26006-1-Divya.Koppera@microchip.com>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 20:29:16 +0530 Divya Koppera wrote:
> Date: Thu, 8 Aug 2024 20:29:16 +0530

Please fix the date on your system, I'm replying to you an hour and 
a half before you supposedly sent this, according to this date.
-- 
pw-bot: cr

