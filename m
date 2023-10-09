Return-Path: <netdev+bounces-39192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B57BE49E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2627B281A01
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F037150;
	Mon,  9 Oct 2023 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVVe3U5s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7010A36
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55786C433C7;
	Mon,  9 Oct 2023 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696865032;
	bh=ObvrkQNowN6D9lhZvrmX8Q8RKyFQ6TGkfKqLJZbpLMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yVVe3U5s4a6nvK4Cw7WftLl1t96uUaXLOc/CtJwGzyzOdTc80E2y/k9l5Jz+LIiEW
	 VhjMe6aZrayIu2SH6tzH06ElK4Kb0Drsou4KmDvvWVqcm2Ndr0IdwS/Q2zp8AkBtZF
	 RIhXV2nZBV3vlDdAqPF1I4SyysK5jr9pF/3eQ1+0=
Date: Mon, 9 Oct 2023 17:23:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/10] staging: rtl8723bs: remove dead code
Message-ID: <2023100941-luminous-hula-7551@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-7-arnd@kernel.org>

On Mon, Oct 09, 2023 at 04:19:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The .ndo_do_ioctl functions are never called, so the three implementation here
> is useless but only works as a way to identify the device in the notifiers,
> which can really be removed as well.
> 
> Looking through the exported functions, I found a bunch more that have
> no callers, so just drop all of those.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

