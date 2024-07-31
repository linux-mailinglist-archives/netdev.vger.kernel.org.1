Return-Path: <netdev+bounces-114669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B6943660
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 21:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C7A1F2773B
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAF140366;
	Wed, 31 Jul 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AxWRWXN8"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D50219FF
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453994; cv=none; b=Mz/Elqs1ozwSR/yEkP9JUSiZ3JUebBeKy4krEjbSCkdSkPFzSlRWw24/b3zuxQnDm8/0ohQhfnvSDnDvFdh68eY3Yi3Es9a6uF49WIrYNTBz82DaCFd+r6Js4cmDUSizsFg3sXWF1Lye5OBnNvWa+Xr7/aiCxs0F8NxkqDS3Di4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453994; c=relaxed/simple;
	bh=RouL4ZT2TTG3vff6AdEiWIrgR6I+8k03m/5AGYaQsqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUSMzmLXBAuTGIqNOm2a+VUHZplRsvU0ZAHc9HeeuQ1yfqIrsMURc1vqhKAzGUkV8U17Aq9wbv3tUlEbqHAzu+gOl5ObTv4L67i4v1gA8Hl0uJCRxMeSER/wmT4OJEyP+R32IldbZa5B3nqoFDJEmvbuVkyT/IbAXA3lvTDDt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AxWRWXN8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B5B9C0002;
	Wed, 31 Jul 2024 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722453989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCd8HwyzhR+uIw3hdcM5/zOXo3spXwRtDNSc8ah/AWA=;
	b=AxWRWXN8DXg0D08AL3fbfIxqMrDHZMSFMg5UN29XIcnM1urVstYeWbb+8j/lR5dMHTCTIo
	kk6xW00NlqttAO/yWsjZdKB/TEcBpPM4zCPAq2SBIQ67wYieN4OqkDgJtaCrj8OEogh+02
	B2/mIYS0GVJv0Us7MKVjrfoTzn0jZje7875x4WY4tgfdS7WJWpJcOwaUXv5Hknb8YGTN0L
	OBDYSeEYZmmy0EHmVXsEc0oigutZhXyTkGg8qURwteayP2SJL32W1Bdnt3ajwAaEjPF2jg
	05Ej8cgvr2k+2r1XDnkjbY6OPkg0ALrDbANir4VSNUrvwSmdnhjueRM/LsQDkg==
Date: Wed, 31 Jul 2024 21:26:27 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: pse-pd: tps23881: Fix the device ID
 check
Message-ID: <20240731212627.16b1bcf1@windsurf>
In-Reply-To: <20240731154152.4020668-1-kyle.swenson@est.tech>
References: <20240731154152.4020668-1-kyle.swenson@est.tech>
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
X-GND-Sasl: thomas.petazzoni@bootlin.com

On Wed, 31 Jul 2024 15:42:14 +0000
Kyle Swenson <kyle.swenson@est.tech> wrote:

> The DEVID register contains two pieces of information: the device ID in
> the upper nibble, and the silicon revision number in the lower nibble.
> The driver should work fine with any silicon revision, so let's mask
> that out in the device ID check.
> 
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>

Thanks for the change!

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

