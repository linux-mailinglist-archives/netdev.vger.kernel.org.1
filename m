Return-Path: <netdev+bounces-70527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477284F632
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 622CFB2140C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A768D4CE11;
	Fri,  9 Feb 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M1u0bQG+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69604CB55
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486805; cv=none; b=qq5KMUEAw1mMoZ2hdnk4HTSbMWLQGSahEqKIze4hqY1/pPI5jZB9L0g80Vlb46Y9KyiNYDJRf0iBL3W5UphYO7RSCnCpxCXHDM4ToAOICn1f+kA69hpFv758FgzvbeA/TUD8qV1mbHvZIqeOC5bJDbCwEe9j60RCj+NViYqGLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486805; c=relaxed/simple;
	bh=5RhsgdJresF56qDCXIphNCFUI6oED9nM8lGKzMGMzXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4ism3S65Bgy3Lnm9oRynT1tBcE1rcxSbjcVQSECimfbS8cVQgb1TkbELwBMPtxKWqr6krI3o8DqkpWi5gm/8PoxchEN6s6lFrbKvUcG0F6Vm6fzdOee0rpbRqp7HxXWMns6B4RlLspCzyNE7/JvRMl0KkfMIJL7qEaUOLrVmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M1u0bQG+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=65ARAjROPYkna+cIwJ13eOj0iaHSf8+W5VwZKxBMxR8=; b=M1u0bQG+vumn3qbuEtBnzbAiyA
	rk6qXFLVNbNOxRBttLnFzpaypDtjeHUdAnnBwOrjU5wSjkiRHXEeTw9/7uUJORTCo2iRKH4JI/435
	a3wJydCzobVDtp6Y/XQS55otpDws/HRCr1dP9rz7bXAbwEL009iiR6No5sdvgsi3rbFk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYRJk-007O6J-O2; Fri, 09 Feb 2024 14:53:24 +0100
Date: Fri, 9 Feb 2024 14:53:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] net: fec: Refactor: #define magic constants
Message-ID: <2f855efe-e16f-4fcb-8992-b9f287d4bc22@lunn.ch>
References: <20240209091100.5341-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209091100.5341-1-csokas.bence@prolan.hu>

> @@ -1181,7 +1194,7 @@ fec_restart(struct net_device *ndev)
>  	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>  	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>  	     ndev->phydev && ndev->phydev->pause)) {
> -		rcntl |= FEC_ENET_FCE;
> +		rcntl |= FEC_RCR_FLOWCTL;

This immediately stood out to me while looking at the diff. Its not
obvious why this is correct. Looking back, i see you removed
FEC_ENET_FCE, not renamed it.

Ideally, you want lots of small patches which are obviously correct.
This change is not obvious, there is no explanation in the commit
message etc.

Please keep this patch about straight, obvious, replacement of bit
shifts with macros.

Do all other changes in additional patches. It is much easier to
review then, both by you before you post, and us when it hits the
list.

       Andrew

