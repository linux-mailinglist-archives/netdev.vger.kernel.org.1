Return-Path: <netdev+bounces-65656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A783B449
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE7F1F22D9F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFBC1353F6;
	Wed, 24 Jan 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z73P74dm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B042A8E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133140; cv=none; b=VBVBgF3QGVpJI5Os8HYgdfwjeWV3Ry0eUjW8zkuTKvEYDlC4y2ZNITM4S4juPs0S52C80FfdUhNuIg9deUBmyDGFUEhbdjFDaYN5vwXxbL1hplkodLljLngp7ZVhEra0+k5VMhmJuyUQDQZKcO/hSb2K/QKLaGdXYAPlM+Aor9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133140; c=relaxed/simple;
	bh=zPm+RWP6kzPeOxf7n4uxm+jwm33qImVQNBwcjQt5ZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWsTgVtT2GcpW4Sus0G0ae4jGUr61gdqS0jynlllcDRBlbXDieSxG+MuJSrbJ2oxKfgu85zwwc69wh7sidFbBVhmrFhzemnmnjsqKhTOOvCbJQsjWzNv8NrRq97K6ckoGnspNIZKGRohsH6vJvXZHt9RUwsqRezeNihYYQOz2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z73P74dm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xZieFivIRR+qZkM66u8Vp/j+fHUnHH2DjcGNne9o7Pw=; b=Z73P74dmS+p7IF5kAvwIfSg0pW
	lvDNRIOCT67DiIF7F20bUP4PxnviUbgJvtC4Wiw82zvwpkrBC3gQMNfbSoeetELXBUkRBqzoSiIaz
	ArEvHTBPage3x14c2mL6c7XSfUiAQ5UBbKiTVxF7g0rLc8O+Uv3qTWipWMCp9A7YyB1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSlAC-0062A2-Bq; Wed, 24 Jan 2024 22:52:04 +0100
Date: Wed, 24 Jan 2024 22:52:04 +0100
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
Subject: Re: [PATCH v1 iwl-next] igc: Add support for LEDs on i225/i226
Message-ID: <de659af0-807f-4176-a7c2-d8013d445f9e@lunn.ch>
References: <20240124082408.49138-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124082408.49138-1-kurt@linutronix.de>

On Wed, Jan 24, 2024 at 09:24:08AM +0100, Kurt Kanzenbach wrote:
> Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
> from user space using the netdev trigger. The LEDs are named as
> igc-<bus><device>-<led> to be easily identified.
> 
> Offloading activity and link speed is supported. Tested on Intel i225.

Nice to see something not driver by phylib/DSA making use of LEDs.

Is there no plain on/off support? Ideally we want that for software
blinking for when a mode is not supported.

	 Andrew

