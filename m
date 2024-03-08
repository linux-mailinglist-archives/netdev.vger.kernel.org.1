Return-Path: <netdev+bounces-78755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F6876587
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1543D1F21375
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86C38389;
	Fri,  8 Mar 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="itcBRQqE"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68687381D4
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905426; cv=none; b=iYTl0s1r83hw69tlPptgJDIJ5ggAO1BQ4o5RAQVTCGxfLMzTBXaGQLW1auai0zq9Tyn8iH4ECluq1O+z0gGBo6NaZP7eQSrRrRDd2ARIPAMDVFRtEwcpFL8MxZjdyega6WvfffNQc2R5NTsJMhre6uPrWOHSwpie995SOrYaNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905426; c=relaxed/simple;
	bh=dWHptPFNi5Jb/pZ5gDwCbcxObaqCQE1qAbuWRvhDLmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1V9wRUH9LbVtYPw23Bk7W24i29xa1rdD9xKda+fLgOpGu19EPO30cnmRYrpeM1GA+qqAxWzzTJibWi5sJ0dZDwGC+FKPBk2HyUiVaL78bfKyVRlQ6VFrMQZfiUkuprP/grOppw6U2fmgsP4APmpDtnU4FcIk0fm4wR4L9H7wWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=itcBRQqE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8ED031BF209;
	Fri,  8 Mar 2024 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709905422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIqOC9HJbzWtBW3aP+v1GYzgi6W32ej5jw8WHceGrGs=;
	b=itcBRQqEELBlaES3W8KSfSpcjAoDxVHNxn0X61kmvnkUp98xsV/IMpw/ezNLcJ4t1TgyCb
	ke0j9SAdwjty7/nOaODDv/xETZndFwHoQXQMuwNdYS19SKdpAsN8JtNwlT3G7dOPQqB+FN
	KiivTsJ034rhFWyCzi9NO/IvC655Eo143Kh7PAxwV2VLmzAJNEfYRKvdeVRq47j5lEzXwx
	RimxopZl1Kn4CiczVdqja6yv5jXDVSVPiuXI0Qg2kg4OHdNLVAYRhoh69xu95JKUGdniE1
	vbEYOdnK3RpOuxvjCw6lrlBB7oRvRR/PI5TAS9nES8LEFQJs/1KdRlF3nH/4BQ==
Date: Fri, 8 Mar 2024 14:43:40 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] net: wan: framer/pef2256: Convert to platform remove
 callback returning void
Message-ID: <20240308144340.6d9c13cf@bootlin.com>
In-Reply-To: <9684419fd714cc489a3ef36d838d3717bb6aec6d.1709886922.git.u.kleine-koenig@pengutronix.de>
References: <9684419fd714cc489a3ef36d838d3717bb6aec6d.1709886922.git.u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Uwe,

On Fri,  8 Mar 2024 09:51:09 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Thanks for the patch.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Regards,
Hervé

