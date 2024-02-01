Return-Path: <netdev+bounces-67998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF9845912
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BCD1F260FA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20435CDD6;
	Thu,  1 Feb 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pfWVp3HE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01E5CDC8
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794757; cv=none; b=J+tTNJ8FHIu3VrSZunfNp/SJmKH6MFxHoMjynqMiorYPmQ/NajQUvta83JLIKv+tF/1q+gdjMRaRCNoG4Gaw9utgQcFAxH9Zoq3VJvNqdazKLBqqqyU/8RiYucUNotZ7BsVRZUzZPMr6L6tqxxJyGbmOHOR9DGk1hhLTTe9vPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794757; c=relaxed/simple;
	bh=YcbcylD6qExP46bj83aJ2sa5Y2kT6vpzafn3QAxGkIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNoIpvP8dEqXRlWMA44ORtX7BF5T3eH1osApzRAFFXBZEzL/c0Zh43qJVyW7OdbRHTjq4+NVN13eMa9DngvtwogyXzJO+ahzE95nTspTtqp0CxrdwIYH23ID8REKMg+PPcSfIGLBq6va0DaVkJOnaRwYgsDg5K/9nfhzbzVMwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pfWVp3HE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d30XK/xhz/M8EM/HxhwiWkuWUBYT82Myggey1+TGD6g=; b=pfWVp3HEOPYU9Q9TVf75m3an89
	pKfeQElyNcmTeR+Eho2Fr1P7Hrd0ajyQ1o4xTBIZNrgFn0fOoKqFCHnuOKn5SjNWueJXLYXLW91h6
	pZu6PyytOQOt1SKwYWB7II4655SSWPWPgUy/2lrHGm/Jre6oHABvH/L9WPlGu/wmwn9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVXHR-006g6Z-Aw; Thu, 01 Feb 2024 14:39:01 +0100
Date: Thu, 1 Feb 2024 14:39:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH iwl-next v2] igc: Add support for LEDs on i225/i226
Message-ID: <3629e504-4c22-4222-b218-32c9945ff77e@lunn.ch>
References: <20240201125946.44431-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201125946.44431-1-kurt@linutronix.de>

On Thu, Feb 01, 2024 at 01:59:46PM +0100, Kurt Kanzenbach wrote:
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading link speed is supported. Other modes are simulated in software
> by using on/off. Tested on Intel i225.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> 
> Changes since v1:
> 
>  * Add brightness_set() to allow software control (Andrew)
>  * Remove offloading of activity, because the software control is more flexible

Please could you expand on that. Activity is quite expensive in
software, since it needs to get the statistics every 50ms and then
control the LED. So if activity can be offloaded, it should
be. Sometimes the hardware can only offload a subset of activity
indications, which is fine. It should implement those it can, and
leave the rest to software.

	Andrew

