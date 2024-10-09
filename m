Return-Path: <netdev+bounces-133640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D9599698C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C3C284107
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790B1925A9;
	Wed,  9 Oct 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgBEfFbL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432FA19068E
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475681; cv=none; b=g63HWayoptHOgY7MJ9Knh0XzFtT3DduH+9Gztc9aP6B+ACV+p6pNzFW+XY9vBGk5AgB2O9dOdJwvpfPzGh+H+AGyGSJOOx0MIVTSsLswg8d9GLB+fi/DRb2YQlIsZEpd0Y+AE2juOtEFJIcWM+472S5ddJf27DbvIfqFjymzVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475681; c=relaxed/simple;
	bh=N9gUu/K/DADF+qCkqOrYMNYjAiRz/V0wSxjI3TuDX20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHYde7gDLy1nHJJOjgy3pCX/PBuujv2vG6gBjffEjihYYk5b7HmDQ4C2B+8AkIfd3ZKGcyJe92yrKzzeUWqlnjsumOOyyIisQVFOCHHsy9QgAKt63Z6oBBOJ59J8Q1wxZfKLN1lM3pmdSH8XD2bzaS4GQBE+BmxjTJ36oIp0dFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgBEfFbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61718C4CEC5;
	Wed,  9 Oct 2024 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728475680;
	bh=N9gUu/K/DADF+qCkqOrYMNYjAiRz/V0wSxjI3TuDX20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgBEfFbLAOoUfC/aniHKrTTHIgT0z06KgMlsupcctpEISM9cjBwMeIl/7wLJ6Cu8T
	 oy+It1gWN4oYxRdZZf3PGbGMa9ppOaZn06MirBOaJ3sb804dWiFrzxIaw36PMghu/g
	 26XjO62LzlhfLWgoYF+MOe+Veo9F4X3ic53h71+aSJpF7G13VGqrorLy/ho5XBnOwK
	 J4g8r25Ouafn1eZtl1PLpcSayZ5okTTGqwMnSzPe2sZFbVtX+40OwdBMh3qo6kP6pg
	 fwgucBT3Xgh7E7yqln3qZrqOxLuwwBiP8lJd+MDawtAiGRfAesCVGmmFgX89UZVKJF
	 bpiKHdGU+sf/w==
Date: Wed, 9 Oct 2024 13:07:57 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: add kdoc for dev->fib_nh_head
Message-ID: <20241009120757.GM99782@kernel.org>
References: <20241008093848.355522-1-edumazet@google.com>
 <CANn89iJ7ts91-pEqL3wAHAu9Cco6MDPZfr++fUjTUxY8Qu3L2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ7ts91-pEqL3wAHAu9Cco6MDPZfr++fUjTUxY8Qu3L2w@mail.gmail.com>

On Tue, Oct 08, 2024 at 11:48:12AM +0200, Eric Dumazet wrote:
> On Tue, Oct 8, 2024 at 11:38 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Simon reported that fib_nh_head kdoc was missing.
> >
> > Fixes: a3f5f4c2f9b6 ("ipv4: remove fib_info_devhash[]")
> > Closes: https://lore.kernel.org/netdev/20241007140850.GC32733@kernel.org/raw
> > Reported-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/netdevice.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 3baf8e539b6f33caaf83961c4cf619b799e5e41d..b5a5a2b555cda76ce2c0b3b3b2124b34409d1d69 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1842,6 +1842,7 @@ enum netdev_reg_state {
> >   *     @tipc_ptr:      TIPC specific data
> >   *     @atalk_ptr:     AppleTalk link
> >   *     @ip_ptr:        IPv4 specific data
> > + *     @fib_nh_head:   list of fib_nh attached to this device
> >   *     @ip6_ptr:       IPv6 specific data
> >   *     @ax25_ptr:      AX.25 specific data
> >   *     @ieee80211_ptr: IEEE 802.11 specific data, assign before registering
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
> 
> Hmm... maybe not needed, I saw Jakub added inline:
> 
> /** @fib_nh_head: nexthops associated with this netdev */

Thanks, I see that too.

Sorry for the noise.

