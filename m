Return-Path: <netdev+bounces-230360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971BBE6FAD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2E054EC931
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9327423B611;
	Fri, 17 Oct 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rtasIfaI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED222D4FF;
	Fri, 17 Oct 2025 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686973; cv=none; b=l6aI/uK39G4h7Pq/7sP9b/zfJ8D+H5LOcf5Y9VfYI45PJsfOSNPR/ZJqgZwTpp07qvtAppHjHpyp6HmZOIuyn1yX3QS8bSS2AA/joFO4fIVIjeVuv24PYw2Dp76z3xSViFadC19/iOVu0S3RqtvEH26QdS9DeqCiUipaYD3zTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686973; c=relaxed/simple;
	bh=8lF/IkG8BuKqpPmY28HPChkuY6z78bRVariz9ZPuiHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPeD/ftBN55Yizriy5Q3Bh1xSY5TJ1zYBnThX//vLVGPSC6SiHNehZnX9yTTrOW5u5+FbSzFhdg6VltZ46Of1Fpf2jAIiUnpk8Fl/5p5S9GNSMPQA0EL6oyWF9HqcAqR6KHdqodIl3FxsC0rqY1y8DVg/0Yq3IUjWz6FOHERpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rtasIfaI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 61D484E40B36;
	Fri, 17 Oct 2025 07:42:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37CF7606DB;
	Fri, 17 Oct 2025 07:42:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB12E102F2292;
	Fri, 17 Oct 2025 09:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760686966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qbTFg4rC1Ve+JxEYeVc+wYtUBa68qS4Pco5KgKDMaUQ=;
	b=rtasIfaIECYu2oieUTyQCB9tZYqGJPJJFkl+1dbacEDK6eEx2HmHEO8ZjeBjbmu33uVUFt
	k7yfrNrhN/Yvfb/lNc0cz/SMPw+jCcu7EKK4icqTSiXRgEMq3rBzYnx7vlS1OjtKfC/zKu
	xcIODd4Wi6yOmUl90MWUm3aZxNjLGLPHYEz7m1Ttxmd2KeoqL2Ovko8OPuoG6VmbnXHp5B
	bgufpgtlho4IRy+IAH+/jWywku3G0RHUJj3P4aySeAaVYSRww2JrN9HtsSSkCJQmVLSe1+
	Bg9BS/7tjoN7UGZLAOMV12pikQCmSwAoHuynuftTMZtmBvWHt72mBmUbgB4qFA==
Message-ID: <4f9bbf6c-146e-46e9-9506-e5fd444ae195@bootlin.com>
Date: Fri, 17 Oct 2025 09:42:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] phy: mscc: Use PHY_ID_MATCH_MODEL for VSC8584,
 VSC8582, VSC8575, VSC856X
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com,
 vadim.fedorenko@linux.dev, rmk+kernel@armlinux.org.uk,
 christophe.jaillet@wanadoo.fr, rosenp@gmail.com, steen.hegelund@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
 <20251017064819.3048793-2-horatiu.vultur@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251017064819.3048793-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Horatiu,

On 17/10/2025 08:48, Horatiu Vultur wrote:
> As the PHYs VSC8584, VSC8582, VSC8575 and VSC856X exists only as rev B,
> we can use PHY_ID_MATCH_MODEL to match exactly on revision B of the PHY.
> Because of this change then there is not need the check if it is a
> different revision than rev B in the function vsc8584_probe() as we
> already know that this will never happen.
> These changes are a preparation for the next patch because in that patch
> we will make the PHYs VSC8574 and VSC8572 to use vsc8584_probe() and
> these PHYs have multiple revision.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


