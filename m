Return-Path: <netdev+bounces-23894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E5876E086
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433D6281F91
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74B8F60;
	Thu,  3 Aug 2023 06:51:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08D2585
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB7C433C8;
	Thu,  3 Aug 2023 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691045469;
	bh=43k3EvbDnD0qrF1ZOik+dSjCAEk8l1OcVzga1U7RXGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM4vpu/5tZk9q+Tqz9Abjqp/f132V1HhBguBhQIQWcQMje3n7qo6FKncCubHURu2m
	 gTtDgRPXw5fQf68bShyxy+PIwVvfithi78umYXwaCyUkz3UD4WPMxMTZ9KnuvoJPhT
	 EMYkx8XAudYc7mWsSyYMNBBB/R+sK8gT/UOK7P1c=
Date: Thu, 3 Aug 2023 08:51:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Message-ID: <2023080359-senate-expose-46b2@gregkh>
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-3-jirislaby@kernel.org>
 <20230802120755.10849c9a@kernel.org>
 <6808de4a-6002-e8bc-5921-06b5938dc69e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6808de4a-6002-e8bc-5921-06b5938dc69e@kernel.org>

On Thu, Aug 03, 2023 at 07:08:07AM +0200, Jiri Slaby wrote:
> On 02. 08. 23, 21:07, Jakub Kicinski wrote:
> > On Tue,  1 Aug 2023 08:22:37 +0200 Jiri Slaby (SUSE) wrote:
> > > tty->disc_data is 'void *', so there is no need to cast from that.
> > > Therefore remove the casts and assign the pointer directly.
> > 
> > Which tree are these expected to flow thru?
> 
> The intention was through the tty tree. But I don't mind either way -- it's
> up to you Greg.

I'll take them, thanks!

greg k-h

