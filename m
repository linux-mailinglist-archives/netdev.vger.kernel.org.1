Return-Path: <netdev+bounces-191874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C65ABD806
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C823A4F9C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F50427C863;
	Tue, 20 May 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLb8KxgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA521CC40;
	Tue, 20 May 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747743267; cv=none; b=LfpCR/MZDVKMeq3ozqkU6FkD6P/qlgJkuduTb1OZv+p2s5gT8zFcjIOHUL3kCTT+4s1WuRGuGrgj2Um/UReVZ0VFIFaz7AWrtQkdqujEOf06A1QcY2uEKTzOrDEMvfex7ZQO9eW5ecdlkF/NX7hS74fm/StQnRNW//oiYKgmuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747743267; c=relaxed/simple;
	bh=Kk26+sh4u6wI4Rsy53/+Tuj3pi2s2ltLOLxjehuWkD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7NtHyLvVZ3I/4MDyuax/4bAVD93Z1Me76/P88QbAWN8WNXZu4EpTWAYPr06tZ2r+RkP0unnxk5iYeKB3bGDHqa1/Jyp7tz2yEtedAuvqlJfOfd+ZAKn5tQ1gIGwUM/HmUGyXHrIg/g1YqMLHdKUVHsxAZEow5o8K5JS9onEJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLb8KxgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E697C4CEE9;
	Tue, 20 May 2025 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747743267;
	bh=Kk26+sh4u6wI4Rsy53/+Tuj3pi2s2ltLOLxjehuWkD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nLb8KxgA+zRf2ExApRto5sRHe6QmAjGlAXHRrm9Ie0uhesV9AL+jF7gRNzxG4z/iV
	 I8OCEitaVzyCywuGtItLXKsQzIrInd3Me/ox7t50REHjHVqp9XE85xBqJXbFTQcXc7
	 mRPSnaM4V6yF6nOReXRc+m+HHk/zrvJhbmikrj62ZmFRQd0IdlXI/9IqcLD/sQQiug
	 0ljU7yu/BpPi3e8gf0Xx0h61oL3EUUPGgkF48a50VbcpI3cAN7bdgX2E1r52UUiwn2
	 wQDrBz62xQpCOo3MicZTbNSAJeEHvEBqhFS890zuYhMgK0/PnwZ6BhjOAkLxhruLTr
	 IR8Dh4JsIVFEA==
Message-ID: <c28bbaa1-c01d-4928-8791-1bb921a2f163@kernel.org>
Date: Tue, 20 May 2025 15:14:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Lower random mac address
 error print to info
To: Nishanth Menon <nm@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250516122655.442808-1-nm@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250516122655.442808-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/05/2025 15:26, Nishanth Menon wrote:
> Using random mac address is not an error since the driver continues to
> function, it should be informative that the system has not assigned
> a MAC address. This is inline with other drivers such as ax88796c,
> dm9051 etc. Drop the error level to info level.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> This is esp irritating on platforms such as J721E-IDK-GW which has a
> bunch of ethernet interfaces, and not all of them have MAC address
> assigned from Efuse.
> Example log (next-20250515):
> https://gist.github.com/nmenon/8edbc1773c150a5be69f5b700d907ceb#file-j721e-idk-gw-L1588
> 

Reviewed-by: Roger Quadros <rogerq@kernel.org>

