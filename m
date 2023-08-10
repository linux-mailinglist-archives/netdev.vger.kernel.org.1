Return-Path: <netdev+bounces-26248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E43777522
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8135282047
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5531ED21;
	Thu, 10 Aug 2023 09:59:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B91E51F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395A1C433C9;
	Thu, 10 Aug 2023 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691661557;
	bh=irAw8C1RbIzipfSt1MnqWhrjlxxoQRCkAeMq+VcRA7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYS9XZ2gch8tOZFweR+abCikrsOTVWRnN3vXDIbjcrUfrDUWu96X3Eev55KVFElOY
	 7kajLAH9n+49UZj2rxzfpHxngpCglRAWIx1j40PAF4HRI36aYeapTKiq5pbKvk5UVi
	 mintMg9N1d+7ODhGW1WpIdTw8lL8Z5tXY58vIbac6YWgh35WZL5O26D29I8cz5+9V4
	 i7aqSBpi8nF6Xtj0xjpAUEiVVGlPzX2HMg3Rhp8E1yHiShqJk3sxjidgxQH4ckRLAq
	 aLonGSxc7+fch0bMq8UBUq990+t+gCGpSRXQmd0c8djyr7NNKXm6OqyQvIjOTItWho
	 c79/k6XLLFc8A==
Date: Thu, 10 Aug 2023 11:59:11 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, nicolas.ferre@microchip.com,
	conor.dooley@microchip.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, maz@kernel.org, srinivas.kandagatla@linaro.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	sre@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	alsa-devel@alsa-project.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <ZNS0708cDAt7H7ul@vergenet.net>
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <ZM0Be8S8zII8wV4l@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0Be8S8zII8wV4l@nanopsycho>

On Fri, Aug 04, 2023 at 03:47:39PM +0200, Jiri Pirko wrote:
> Fri, Aug 04, 2023 at 07:00:07AM CEST, claudiu.beznea@tuxon.dev wrote:
> >Update MAINTAINERS entries with a valid email address as the Microchip
> >one is no longer valid.
> >
> >Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> >---
> >
> >Changes in v2:
> >- collected tags
> >- extended the recipients list to include individual subsystem
> >  maintainers and lists instead using only linux-kernel@vger.kernel.org
> >  as suggested initially by get_maintainers.pl
> 
> Consider adding entry in .mailmap as well please.

Hi Claudiu,

I'd like to echo Jiri's suggestion of adding .mailmap entry
to reflect this change.

