Return-Path: <netdev+bounces-137433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8C9A6425
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E11C221BA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44FB1EABBA;
	Mon, 21 Oct 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMY+zFby"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20C1E47B4;
	Mon, 21 Oct 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507095; cv=none; b=kLeHXqPHNf5jp1+Pk8zkdEgO6JHOZOq9N9lHnHvx2iBrG8R/fJrYbBPLZfIj13exytkcGcUgZgLkwfnBZL++dxJQ60NwrrtsFNNf54bET123Dh9rhOSFKy+KZAmwt6EQsSMjDIIM18iIJQ0IbYja54dDPFrJ9vK28GBcaD5jHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507095; c=relaxed/simple;
	bh=f/Pgf6sVC8iDHUx5J1HoQI7caMHHINdmEFgdp1QrZdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5pu5Lyk1XxYtJ87k6TIX5H1sgmF4bwehP+thdEDnIi9HavtAcZ8rVMPOdETAzEckxyDcWHmQOUWTHyRR16jkXTlmHFupOOCPU9KLk1Lj6/Ny/JhE3dU4V0K4sOYiwRGreHGTSDlRDkF+KKqE1Wi7ggVUV23iFX1updzISFDC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMY+zFby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3D6C4CEC3;
	Mon, 21 Oct 2024 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729507095;
	bh=f/Pgf6sVC8iDHUx5J1HoQI7caMHHINdmEFgdp1QrZdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMY+zFbyJuV2ZJayTeWA5K+QUK0IfnQ6q8uy6Fluu/kxORKedJvKeaF13ExyvYE5w
	 Js2r6NPuAwFCX7ZcQxPAjWNjVhwZ1rBXdpCbx1pITOeUWeqqdpYWSAmpTwlibpUbe8
	 iM4NRBCSztPs0/IHsoeRW388NgRHS/ZnZSEM7HeRZ5+PED7XkmhhQoW4Fom5+u/Caf
	 SYoVJplVuQTVo9m28yNG8xE49NJyHFHOr4TQ6anRWtPywIyixPEtlhrOtPse+GKyuY
	 WqMlYrucBADQT7kJM7Tg+oUIpyWcUlkibbblaXfV9lstMl22hAk+IEs3DdisiHMZX2
	 1K6N/r9uuDW7Q==
Date: Mon, 21 Oct 2024 11:38:10 +0100
From: Simon Horman <horms@kernel.org>
To: Benjamin =?utf-8?B?R3Jvw59l?= <ste3ls@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: add support for new USB device ID 0x17EF:0x3098 for
 the r8152 driver
Message-ID: <20241021103810.GD402847@kernel.org>
References: <20241020174128.160898-1-ste3ls@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241020174128.160898-1-ste3ls@gmail.com>

On Sun, Oct 20, 2024 at 06:41:28PM +0100, Benjamin Große wrote:
> This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
> r8152 driver. The device has been tested on NixOS, hotplugging and sleep
> included.
> 
> Signed-off-by: Benjamin Große <ste3ls@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

