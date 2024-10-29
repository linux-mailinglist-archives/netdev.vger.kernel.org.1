Return-Path: <netdev+bounces-139966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217BA9B4D21
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9111F2403D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD1192D6C;
	Tue, 29 Oct 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CoxBPvBY"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F07621;
	Tue, 29 Oct 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214662; cv=none; b=UFaLHofK3VoMRuKBPIdZ3gzf5HTyeGJIFh5iySbmT0U0zIwpsdGmvBydUwtmIwtQACG2UaH4ZeiQlO3mqkAdju+oDydCS1l47AI0oDc5Bufs6tEfmDfOzPpmyOFreB0Zq9h/3hVYz2WNeUdIsgoWCJ097F7QxSBgmdO3NbJiuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214662; c=relaxed/simple;
	bh=BsDZZY6yiykZ45faEqI9F2yUyq4ifIp6Xhi5tmSZAAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfqikLbiEQ4aEAb3jg+WZv3vz66MwfsAHIk0pNLIkuEf86m+ft4vPjTDhGrGBipiToF+sD9FaYxDMsPQQ9DqcxzS6XgGGvCu/VGCCMU5/Mc+BLTBXLanklePxD4Vj/uYMUQSVnZ29JJQWJiWYrAmTo9B7evKuCFOBaP9UBiGx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CoxBPvBY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E77E8FF80F;
	Tue, 29 Oct 2024 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730214652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPeVUbqHS8MRxHHrDe1tYiaW2g1nyaO1y7xNCKPP5sk=;
	b=CoxBPvBYtvK6ebfIWc/nGhPxqPplLCYERBGlMYjOkHX9Vl/8cdxidsMxb4mlS0g8W82zJW
	PP/ro2qsjp0iSErW3bO/+CSC9c8Xy+lIAMcvzi0yVLQ09dFgHkf4BKZlD8GXlXLDTmwPm6
	QH8l8Exhy8HEzClia14eOpp6DGC2PkTfGOuIKIeA12Fk72Z3WKety/S1EIdWyR+Yz+OcOc
	r2IQUXUL00MxNJXJ7irxyp/Ejy4Vyz2noRrE6q32/n9bkwiqWU1RwxbC8jQQNNrEbm4rQk
	P8u2jNXTqyBLgc8dLt351cUcSK1uxcoh7mfdyT+Apo3TYPxbutXV5Fcp9vYwDQ==
Date: Tue, 29 Oct 2024 16:10:50 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman
 <horms@kernel.org>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v2] Documentation: networking: Add missing
 PHY_GET command in the message list
Message-ID: <20241029161050.7f5ea91c@fedora.home>
In-Reply-To: <20241029080804.7903239f@kernel.org>
References: <20241028132351.75922-1-kory.maincent@bootlin.com>
	<20241029080804.7903239f@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 29 Oct 2024 08:08:04 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 28 Oct 2024 14:23:51 +0100 Kory Maincent wrote:
> > ETHTOOL_MSG_PHY_GET/GET_REPLY/NTF is missing in the ethtool message list.
> > Add it to the ethool netlink documentation.  
> 
> FTR ETHTOOL_MSG_PHY_NTF is not present in any _released_ kernel, AFAICT.
> So we could still delete it in net before 6.12 is cut.
> But if there is a plan to use it soon we can as well leave it be.

Ah true indeed... yes I have a few patches to actually implement that,
I'll try to send that during this cycle.

Thanks,

Maxime

