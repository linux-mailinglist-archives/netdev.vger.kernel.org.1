Return-Path: <netdev+bounces-166204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B0A34EE3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E5188CDF1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D024A078;
	Thu, 13 Feb 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LHWbAqQs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2924A076;
	Thu, 13 Feb 2025 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476787; cv=none; b=WF6UG1i1EYonhHxc85K43v+0RkIRH67cbyVmHdhJdmlZltrnH+Q+qst4ZzV0vwEn1aoIc0kQReZv8FeNaQ0FHFiY5OD7oWNXMjTe+yYH3Ai3vHH6FFd9EKyO2vz0wN6Fj4/xvHPBfUUWZnHnhgifW4zEjFG7mI1NRrY5UV5SKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476787; c=relaxed/simple;
	bh=3Sowh1r0kWd47yhxz2HEHH0eC2Ler+ksBAJZHwtixVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqA3LjT8mCEec9YoRG69eHetvNhTmq/9I/X2QzyRoUwT5FXqNv3fZPICKalq9WXm1tey0lgBZAmW6VXDEcO1nwxbk8sO13ZvTzf4Bhtg2i2KedO3PTHBRvXq62Q32ovrGAfyr5gx0OpA2YpjDuLIGajgO4NX2GQYoiGbbeQRqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LHWbAqQs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RZlI4HGYXokTX4zqJIJa74/QdyZEoxz2ZxabCm7uDZY=; b=LHWbAqQsNs8Xcff5WtgJG4/ujL
	qWk/OzDcgaCgtZisxmAGVbkKlgq7ZYX1sDUxg9MweYPa+fQaY/GLYuUTpfODMeSvLCgd96Dxr8tSN
	Bd5xru0cOVZfwBDAXsIasqAN3rIehsObeqHTrmdczlS6Grw8k97DSbN6p8rTQ+sbdg9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tifN4-00DqVU-Hb; Thu, 13 Feb 2025 20:59:38 +0100
Date: Thu, 13 Feb 2025 20:59:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add self test supported in
 this module
Message-ID: <6501012c-fecf-42b3-a70a-2c8a968b6fbd@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213035529.2402283-3-shaojijie@huawei.com>

On Thu, Feb 13, 2025 at 11:55:24AM +0800, Jijie Shao wrote:
> This patch supports many self test: Mac, SerDes and Phy.
> 
> To implement self test, this patch implements a simple packet sending and
> receiving function in the driver. By sending a packet in a specific format,
> driver considers that the test is successful if the packet is received.
> Otherwise, the test fails.
> 
> The SerDes hardware is on the BMC side, Therefore, when the SerDes loopback
> need enabled, driver notifies the BMC through an event message.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Please take a look at the work Gerhard Engleder is doing, and try not
to reinvent net/core/selftest.c

    Andrew

---
pw-bot: cr

