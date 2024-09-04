Return-Path: <netdev+bounces-125282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A630B96CA0F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C01287E90
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA1714900B;
	Wed,  4 Sep 2024 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mW2DJ//n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAC82863;
	Wed,  4 Sep 2024 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487618; cv=none; b=HFCaIgYPjQUjadyErLwoNAwvFnkIwD1tZQHfGsaW9t6eQf7Tk4UMFI4G4w/u7DU8Rkgl0N1Ny+pj2zOmUJ7luFlVh34TGnuK4HM+VvyBGupWwi0v5CzcZRmohcmZr5OfkTSnFmi7Eo2Y6PCsRBYkE7oRIAFVEcx4w3aUmiP2eq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487618; c=relaxed/simple;
	bh=/PkLBpT7/reyt7goIJoL/OpgwtTSslcvfcuM1N8/qew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkh8VgkVfIhFeqcxdgWq5J4+yHTMHEyFX47jOI3Apv3ZTzL/X/70P/U45Kd5ojLuPpt6dRYoI2YcExZFKd9gxqw8HiiXLd54Oq1MGpusTJFEGZazHGrsH/dJzVzByaFxec/E4udCuK78kkLY58O7kiXedLz7QSSYsLumF/SFkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mW2DJ//n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BnzCKBhFTKrC0Gcs7UWY+nJdaKfeo6Vdq0H/mpP0lOo=; b=mW2DJ//nH0112Ak/tXDUMaHmEv
	RI3TSWT9At73F32UnquugP3SdH4cmbTtwd3/8PrN3qLZEsRBH+49dBAuIYIRyfyJmkTX6+byC3uwS
	hamjME1DG70O/WB+ziKuSipZpAVtLZ0jcdOW8Daveq3Vzw4tdcL0zrARy7vhvSnQvU7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sly9I-006bk5-D9; Thu, 05 Sep 2024 00:06:48 +0200
Date: Thu, 5 Sep 2024 00:06:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH] net: phy: qca83xx: use PHY_ID_MATCH_EXACT
Message-ID: <02af18e9-df7d-4a26-ad18-cfae5f60eb39@lunn.ch>
References: <20240904205659.7470-1-rosenp@gmail.com>
 <adcde43a-aaa4-4f2f-a415-e15d77ec7c41@lunn.ch>
 <CAKxU2N8sXUnMvXmJ4s045J6Y0UiQZVufJFaxA4=cXOvnEt=8Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N8sXUnMvXmJ4s045J6Y0UiQZVufJFaxA4=cXOvnEt=8Bg@mail.gmail.com>

> Procedural mistake. Need to use --subject-prefix looks like. Should I resend?

Wait 3 days. If it does not get merged, please do resend.

     Andrew

