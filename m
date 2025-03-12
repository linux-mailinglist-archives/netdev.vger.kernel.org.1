Return-Path: <netdev+bounces-174286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7DAA5E23D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927C11899026
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC823A9B4;
	Wed, 12 Mar 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWwTIVeR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020F282F1;
	Wed, 12 Mar 2025 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799236; cv=none; b=YM8Vxw0y+j8jKUtLRCKG0Nh/ww6W+4zKZ+RaUL522MsV7ylr0XLp8nWKRxgAn039kItnHkNzcVw/QyXZMgULUSpXlQdZmtyxLoQXVXnHZ+Qg/XG2ltNxfCzW9VrWWBEU0OSJXKUIO0EyhncHlZiVyeCstSG9xYhw4WLDlVYs6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799236; c=relaxed/simple;
	bh=FP+WHfpDqrQUet8b9rSagtq/sf/6LIUq8xvSIayKDzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9gpA4XDeV4y2UTwXjlOA0pAWePqWBs8HQMGuxgBzMpzC+Qc6dDdb1qeGp+cszISIpkOPh7vc+CKskUSFMnUKAXxWTrSe6UvtXMMQLgOhqsmQkU2im8mWlai7AIMTRdb+39km7dHDim/zAl6jRoIEI3hpEG/W8zNnAwmC6u3g4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWwTIVeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AECC4CEDD;
	Wed, 12 Mar 2025 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741799233;
	bh=FP+WHfpDqrQUet8b9rSagtq/sf/6LIUq8xvSIayKDzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWwTIVeRtrSJ9GCwVKdanu88XwHvxCI5wr1Z3x9Zb4uZR1KWJDGeAZgidgP+ofwg3
	 YL6jRKj7tpEzMnayJVx9xlvlGMo7OlN+2/GVxObGwDk6MgBREA9G9OfxDrY3+4NpDl
	 WXQ/UhnyAV+Jjf9Tz5Gj7kOA0PzQFuT6IPYWBoiH6eCtgK0LAjS9FheJuFxg2nNbXE
	 3Zsx4/Ze/KsSly0ZjySGkB4oN+sAcWEohfuTXVmW7rKppksRIBiggvqRIrnNHP42Sq
	 7ljVY/+o436uBfnM4RouI9xYV2OZwfIuiZ+ZR2YI+YB4NX2boUwQtEpsbJFUCcuJ0Z
	 B6cS333GhU/3A==
Date: Wed, 12 Mar 2025 10:07:11 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: macb: Add __nonstring annotations for
 unterminated strings
Message-ID: <202503121005.DC5E16ACF8@keescook>
References: <20250311224412.it.153-kees@kernel.org>
 <CAGG=3QUJ4NztStM3GDxLqMyT4_O+8WuhaYCiK4rin-i40qwCcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QUJ4NztStM3GDxLqMyT4_O+8WuhaYCiK4rin-i40qwCcA@mail.gmail.com>

On Tue, Mar 11, 2025 at 04:04:24PM -0700, Bill Wendling wrote:
> On Tue, Mar 11, 2025 at 3:44 PM Kees Cook <kees@kernel.org> wrote:
> >
> > When a character array without a terminating NUL character has a static
> > initializer, GCC 15's -Wunterminated-string-initialization will only
> > warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> > with __nonstring to and correctly identify the char array as "not a C
> 
> s/__nonstring to and correctly/__nonstring to correctly/ ?

Whoops. Rewriting glitch. Yes, "and" should be dropped. I will fix this
locally for all the patches with the same language and send v3 for this
one.

> 
> > string" and thereby eliminate the warning.
> >
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org/
> >  v2: switch to __nonstring annotation
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org
> > ---
> >  drivers/net/ethernet/cadence/macb.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> > index 2847278d9cd4..003483073223 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
> > @@ -1027,7 +1027,7 @@ struct gem_stats {
> >   * this register should contribute to.
> >   */
> >  struct gem_statistic {
> > -       char stat_string[ETH_GSTRING_LEN];
> > +       char stat_string[ETH_GSTRING_LEN] __nonstring;
> >         int offset;
> >         u32 stat_bits;
> >  };
> > @@ -1068,6 +1068,7 @@ static const struct gem_statistic gem_statistics[] = {
> >         GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
> >         GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
> >         GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
> > +
> 
> Is this an errant inclusion? :-)

Ah, yeah, I had removed the truncation change but the whitespace change
stuck around. Also fixing!

> 
> Reviewed-by: Bill Wendling <morbo@google.com>

Thanks!

-Kees

-- 
Kees Cook

