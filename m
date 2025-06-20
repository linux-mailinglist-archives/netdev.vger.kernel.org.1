Return-Path: <netdev+bounces-199756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BAAAE1BF3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593427AA155
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EEC21C18E;
	Fri, 20 Jun 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9lNzGBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F2A95C;
	Fri, 20 Jun 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425612; cv=none; b=aoHZ/pPdxYgl6hxntNAdjQ4UoumZh+iDQ+jwOqy50fI2XdumA1l2APF5Qh/gU3v2dCLLCPBicaXFmFg5LcqkxsLbyJegoCVQIJZU0qWHGNBuFzXyX8FMKMjYa7ly0p0eWTK/B0vq7ULeOXa+7CqciVwr0MBYt8Er4TvmF+YM1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425612; c=relaxed/simple;
	bh=flwZF01k22+K8skva0cXN6o1f53O8RCdfBgY2yLeLJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IldQBxd8rXLmG7gQ/NYhv5hVlRQr8AQZiXPj//p/MHcMOD/eeZqm9fVjgXg00V/6FLatVfd0zIIC8s2UVpvvO7+xpM9HkQZvFPl/aKgAsmqVycMNlMzQ8XpERA7I6bkaGM8Q1Bv+t0H6X1baXjaw+TNXrGe4DqOixGxvHoMSjS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9lNzGBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF80C4CEE3;
	Fri, 20 Jun 2025 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750425612;
	bh=flwZF01k22+K8skva0cXN6o1f53O8RCdfBgY2yLeLJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9lNzGBxUkynLzsG90EXw79hslD4rJ427bs5j7tS8AI9tfT0g6C4OlS+kM6/euxTo
	 +UZ4liT/ZG5BfzZKG9tUz96OMrP+L/kbr1f/wloIUmAcaIg4DnwtwpWSrFgOWNsYwc
	 8PiJBd79qP5kW5wkbsY+HK4MZHm+aVGzrnUjDfURX5Ra+RJiiGvVnR2idZBaGu68pv
	 0aTGLMaN/+F36HeEZ9OoR82Beydb80bidcB5yFffnO/PRVwow1O+xnOKQI1lLcD/QH
	 /KyJTSCZj8p+mLXqPXS886T/s23MAbwyLSXJ/pS9B+eS8W5r+h3o2yeUjBkpW5onGc
	 E1gjr8gbZ68eQ==
Date: Fri, 20 Jun 2025 14:20:08 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Bluetooth: Remove hci_conn_hash_lookup_state()
Message-ID: <20250620132008.GM194429@horms.kernel.org>
References: <20250620070345.2166957-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620070345.2166957-1-yuehaibing@huawei.com>

On Fri, Jun 20, 2025 at 03:03:45PM +0800, Yue Haibing wrote:
> Since commit 4aa42119d971 ("Bluetooth: Remove pending ACL connection
> attempts") this function is unused.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


