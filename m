Return-Path: <netdev+bounces-196999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CD0AD7441
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533C8188FD88
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AC24C66F;
	Thu, 12 Jun 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAS5Z+Yk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2624C06A;
	Thu, 12 Jun 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739030; cv=none; b=kKtxgLmUGUVfRtJAB55zwu8cW0J7s3AutSYwuyrbbTHltcAPJBV37372zZhL3zGOaSAelhC4gfLDvZMukieKBkr1XxjwmImP09sFIZ5jkbV3nEjS5zGjnDFF62Qx4+L8QGQ/qOvnxC1SSem7wdnl7QGHx6xWQm9brEZa7yy8p7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739030; c=relaxed/simple;
	bh=XjylmrRqZ48JZY8HZ5z1esy1sYe5LmPYknndof2mkwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gh0eysaMoNmXLW/qnGJU1fWxQ4cULWQq+ZTca6VGKuC0ibfqMe2J41TPDkYIgiu2uYnaXsJJ9GJNuSlYg45EWqmRbMLDgJoNcFRBBxUbqa7qFYIa9r+0YlY6xw0sHSuZtepQYW3VsPx2QWq4/jFOHdbBCiiH8e34cvVxbgnXpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAS5Z+Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB4C4CEEE;
	Thu, 12 Jun 2025 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739030;
	bh=XjylmrRqZ48JZY8HZ5z1esy1sYe5LmPYknndof2mkwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lAS5Z+Yk6ujy0mqVXbxU0MD8zqK3f11QGtQgLaObOTArWWNB6dz0YpeYoEuTRnS/B
	 aajjVn9I2j73wiyftslTWJRwYx+zQiGOZ7OtLSpvL014ktvQazBM6JG/M3EntCtfLX
	 bke+zAqp1zvE4R2qA3POsn5fxdNetskS9JEay7lcfGingJwuy3jR6ERYfB+f7vWhuE
	 2rbqcPLc7m4uDwSB2UlrVTdW9463736wVNOQS+TZZs1luDKaaLCd1Kmb+SZw1WDRe2
	 4+oKzAe4sVBNdOWp+JiC2Z20Q0ELDBMB0WyJgjU2d2hX0fT7Vf4nQ3wk+ud7Tq3HEB
	 r5hq2OHQcTTgw==
Date: Thu, 12 Jun 2025 07:37:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Read firmware-names
 from device tree
Message-ID: <20250612073708.69902ffc@kernel.org>
In-Reply-To: <03555d09-e506-4f48-a073-b06b63e1af4a@ti.com>
References: <20250610052501.3444441-1-danishanwar@ti.com>
	<20250611170211.7398b083@kernel.org>
	<03555d09-e506-4f48-a073-b06b63e1af4a@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 10:49:17 +0530 MD Danish Anwar wrote:
> > You seem to be deleting the old constants. Is there no need to keep
> > backward compatibility with DT blobs which don't have the firmware-name
> > properties ?  
> 
> ICSSG-PRUETH driver is only supported by AM65x and AM64x and both the
> DTs have the firmware name property. So I don't think there is any need
> to maintain the older hard coded values.
> 
> AM65x -
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso#n28:~:text=pru2_1%3E%2C%20%3C%26rtu2_1%3E%2C%20%3C%26tx_pru2_1%3E%3B-,firmware%2Dname,-%3D%20%22ti%2Dpruss/am65x
> 
> AM64x -
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/arch/arm64/boot/dts/ti/k3-am642-evm.dts#:~:text=tx_pru1_1%3E%3B-,firmware%2Dname,-%3D%20%22ti%2Dpruss
> 
> Let me know if this is okay.

IDK much about embedded but what you say sounds convincing to me :)
Just also add that paragraph to the commit msg? (without the links)

