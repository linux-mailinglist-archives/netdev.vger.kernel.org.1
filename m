Return-Path: <netdev+bounces-173517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0194DA59411
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850B21883BE4
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26821D3E0;
	Mon, 10 Mar 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zIt1t3rC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E62846C;
	Mon, 10 Mar 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609145; cv=none; b=tYGQsXBrD+P8oSYxLdQTVpMtYldBG7wh71aNOpNNgVQjFHR3blfREsLLWbVnFFmvyXU4xealG+yn7eZsP0RELagrRosZY///sSy9dkBci+K2KjF45VDxhWrjGhF58IshhBnbS40co7fkgiAT7CxbrwNi5OcpHUUdEPZpe6Et4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609145; c=relaxed/simple;
	bh=hon+ZlpcdpiM2z4RWA+hrWnsN9KcBLw1pLs4yAL6aoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srOE5QLdn7pZjxmlsYatUUVZNIvMlpSQq3Y2d1xyrjZtcnXBUkWQl+I8XT3gp4kI6+WMi0W9TcDQFSxsZBvt13OUtDD8ScMzhu5Jd7FqvPNlYc+wEyUNoo0zsfxiE50Fpv06U/lvfsUNNJ/5dTJMlzILZLgpSfUWcdpaEu/B8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zIt1t3rC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ueh+7CZG9MPdobqMqruBWMwjX+BSXQ112an7S+3qACw=; b=zIt1t3rCv5RJM3i32AEKgTPGiZ
	6WejDzTTseO686uRIjXn1azeCg5OnLaiEG15E9gBGTbv9SaSYqCLYVTwgW6uyMBu83IdgRtjhPiNM
	/32cCoz3tMF+LS8hBBuG/o401FH/0h/J6pbCRVV3aR9+uMQBlCCz6FGKdIdw0wc607WE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1trc5z-0040LU-Mn; Mon, 10 Mar 2025 13:18:59 +0100
Date: Mon, 10 Mar 2025 13:18:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hanyuan <hanyuan-z@qq.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: enc28j60: support getting irq number from gpio
 phandle in the device tree
Message-ID: <c8553dc9-2d8f-4d4b-a381-f87660c2ee99@lunn.ch>
References: <tencent_83CBDD726353E21FBD648E831600C078F205@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_83CBDD726353E21FBD648E831600C078F205@qq.com>

> My embedded platform has limited support, it only provides a
> hard-coded pin control driver and does not support configuring
> pinctrl properties in the device tree. So, there is no generic
> way to request the pin and set its direction via device tree bindings.

So it sounds like that is your real problem. Please write a proper
pinctrl driver for the SoC you are using. They are not very complex
drivers.

    Andrew

---
pw-bot: cr

