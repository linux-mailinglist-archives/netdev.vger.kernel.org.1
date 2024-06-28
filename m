Return-Path: <netdev+bounces-107707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8D91C07E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C34528666A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8147F1C004D;
	Fri, 28 Jun 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eVhylS6i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6251C004C;
	Fri, 28 Jun 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583759; cv=none; b=sDKngAiivVhhjyLtPzzf3TWjqZjqrxRnn/gD8h4sn8ezQq45GtmMclKOQy7QqklAzt1ZATrgnuOdk5fHtvOC70Apnivuwb8Ithrg/O2m04ynz9D4AEtLDTnrwecB3Q88EZy2FYCrvs7fJfMUh+HVi8YLKMtBtuSBJQ/AkIA6AIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583759; c=relaxed/simple;
	bh=fiTFD6LjLZevOhP5yqiiJPUwf69YV0v89D1EEDrdqn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJgxQ9W0C2MlwBvjTrl/0fmxAm1MKVqWJ8KMa8ZEfON44PFVFFT06EcVI8cKkBWo96t040ywUugX+wf4bFYqDGpcH9r55EnRgIoOBTw+IQxMFqMgELxkRE5ZLJIj8bNreomiMPBE2p3Lv9eVTttauXt/o9qGwu+s17UVwkKhPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eVhylS6i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PUFq+r93SMKyXpphr8wL2rk6f2o0adTTc3NqfeVDy4s=; b=eVhylS6ivpR1cr0iVh/m1c4tFC
	VHJsE5NfuUL+8ls44uXWFvgaBFmbOgUVNm9WekxIdE98o88NQHhLhBttw+R09fo3AxOko7a3GKlnw
	82iWfEpMWNyCIA8EZtQAu5BafQw0HtucAPo7LzRWQf4X2f+53As19LApQi/f8WGkjPZQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNCHd-001HyW-W0; Fri, 28 Jun 2024 16:09:01 +0200
Date: Fri, 28 Jun 2024 16:09:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for
 aqr115c
Message-ID: <92078d5d-3b10-4651-a42b-4b2ffd23daca@lunn.ch>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-4-brgl@bgdev.pl>
 <Zn3q5f5yWznMjAXd@makrotopia.org>
 <d227011a-b4bf-427f-85c2-5db61ad0086c@lunn.ch>
 <Zn4Nq1QvhjAUaogb@makrotopia.org>
 <CAMRc=Mcftb9MRAP50ZNMfQpsjLzc-=OKvxo5Xkeqdgs-rZFNug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mcftb9MRAP50ZNMfQpsjLzc-=OKvxo5Xkeqdgs-rZFNug@mail.gmail.com>

> Not sure what to do, should I still be adding a new mode here or is it
> fine to just explain in the commit message that this really is
> "2500Base-X-sans-in-band-signalling" and keep the code as is? Or maybe
> some quirk disallowing `managed = "in-band-status"`?

Yes, please do make it clear in the commit message. It is good to have
a full commit message explaining all the messy details to help the
next person who needs to modify this code, or has the same issue with
another vendor specific glue driver for stmmac, etc.

	Andrew

