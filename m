Return-Path: <netdev+bounces-150955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D744E9EC297
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440181889278
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE71FC7F5;
	Wed, 11 Dec 2024 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYtpjpSL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34F1A9B42;
	Wed, 11 Dec 2024 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885762; cv=none; b=KQgSIY3vhbXTgDMdC1Gr9eoj3myC5Ghs2adiyvyF6kYNOYVsro/s1cSGSSBm9hTFk6jCOucnImC+T1o1U5mXoUSOirViFp09EolMA7cztzQzdUrub6En3ioyOLqRUpJBP+vWnfRcCKwY/n0jxlTbrBZ8sy7vmoqYlelYBJaf0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885762; c=relaxed/simple;
	bh=XJCoExKGsGQHeIB6jDxYOvVS8vmrBSorDWks2M/Oz48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haL99p22j6BRytNwFJAVf/Arot05MtqLP9tTJqP7B0iYGtumUx4+/J8k6+AjWS+IFhJJOvdHPQpbVwCspm+UW9wIkPBtqgioodAA6g09ukW9BCiOnxJ6ltaUBU7iGOr1tAdk3e/1aMzxCK6zOY8EXSxx4r3dxAAK546aH3R/Bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYtpjpSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D34DC4CED6;
	Wed, 11 Dec 2024 02:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885761;
	bh=XJCoExKGsGQHeIB6jDxYOvVS8vmrBSorDWks2M/Oz48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYtpjpSLfsPuNSompZ8H1c8c2h9co0bh61FexI0JNjbcQLwSUqqpI/YXMrZKC0QM6
	 R5x0qT3JpIEzHrRjLvb9OXYRYTT4Wa+cFC1cHQY4ITrmrzV30r3UkC/6cmfCnnA+EM
	 bUar0tw8FHRBDMP/9P5XqzyiU1UJ1iadOS8fkDsoWpUAsNweN7kk5m8GDKd2YSQeOn
	 uQA6s2DZHzKo5dqGdlVOUdR/q7OXN++LfhU1TCDNW8wW0lObdktjlxcm/ThSI7ToM2
	 La0o9Ly4K1ExtXANJ5ODlEY9kl3CYNVTHVG33Hd04R6OgriGQoITvbNl6ypEuL3VJe
	 oVZJTwNGQ5rPw==
Date: Tue, 10 Dec 2024 18:55:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Phil Elwell
 <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 08/11] net: usb: lan78xx: Use
 function-specific label in lan78xx_mac_reset
Message-ID: <20241210185559.12b9e03c@kernel.org>
In-Reply-To: <20241209130751.703182-9-o.rempel@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
	<20241209130751.703182-9-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 14:07:48 +0100 Oleksij Rempel wrote:
> Rename the generic `done` label to the function-specific
> `mac_reset_done` label in `lan78xx_mac_reset`. This improves clarity and
> aligns with best practices for error handling and cleanup labels.

What rules do you refer to?
AFAIK the best practice for exits is to name the label after what
you're jumping to. In this case I'd use exit_unlock.

> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index c66e404f51ac..fdeb95db529b 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -1604,16 +1604,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
>  	 */
>  	ret = lan78xx_phy_wait_not_busy(dev);
>  	if (ret < 0)
> -		goto done;
> +		goto mac_reset_done;

...

>  	ret = -ETIMEDOUT;
> -done:
> +mac_reset_done:
>  	mutex_unlock(&dev->phy_mutex);
>  
>  	return ret;


