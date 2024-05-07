Return-Path: <netdev+bounces-94139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315008BE521
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FFC289C01
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2B15F320;
	Tue,  7 May 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cRfNIVHb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65515EFD7;
	Tue,  7 May 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090724; cv=none; b=AHrrlmNVmCqSjZEihPzypLnVfLI+c8hXuerTXUQT4yYeIl4ICiXDKNHQH2TfnNM5j24GcnHCAcxgfu3rWrc6zGZVlOr1B2Uq72HIglxyrfVsGtcKa+4npFsDus/MF7lL3qK6/Fpq0zLfb1KilPI9U9NhQRJ+y55HWoDoICKbyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090724; c=relaxed/simple;
	bh=Yvt9trn7k5sg0grmFzj/Z05xPhosOJKV+oMEXF2UGKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoRTRzwmlW+17e3YPw/xB22OGu3s0P7x8B6ppXrgekpBhZm1QrYC4/RscWR/H/0hJo/pdn7ZpZeRwJQloCYoV5nqtwIGGpCcp/fgSzgEwNrmvvbdg0rC+EGNxSqgWCX9mQqMZxNN66plN+cKIH5mckgAcA+iTVUJFPjUQiBK8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cRfNIVHb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+/2zFWULxAWvPzLT3urQNWLL10z8co/qMxogQ0U1TR0=; b=cRfNIVHbInwOfaoVrM/wwS4GHF
	6zCSqzt9oKQ+zHZzagNSrZWDbKAwzFANpG6yjB5MKtqa+ayim3dr530/3vmqZFYZhYQlBx3P23HkH
	cG2kejCgj4iAOH8V4gaZ2MncEd5U0PaGBPdxBowgbi5rnccc6WRNH8jPpwfI5vMRMj5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4LRY-00ErbN-N6; Tue, 07 May 2024 16:05:20 +0200
Date: Tue, 7 May 2024 16:05:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - May 7th
Message-ID: <2730a628-88c8-4f46-a78d-03f96b3ec3e2@lunn.ch>
References: <20240506075257.0ebd3785@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506075257.0ebd3785@kernel.org>

On Mon, May 06, 2024 at 07:52:57AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU). Last call before the merge window. No agenda
> items have been submitted so far.
> 
> See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn

Maybe we can have a quick discussion and poll about:

https://patchwork.kernel.org/project/netdevbpf/patch/20240507090520.284821-1-wei.fang@nxp.com/

Do we want patches like this? What do people think about guard() vs
scoped_guard().

	Andrew

