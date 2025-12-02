Return-Path: <netdev+bounces-243280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EA0C9C727
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15BD84E4018
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F122C237F;
	Tue,  2 Dec 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="WjxIgsfL"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF072C324F
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697511; cv=none; b=BLuoVB6sdFjVwHN79ULobxLGtUqZDA+bl758jUxFlrPsWgPz8QA3aHOx6clsmLQdeGRj4FgKNtgeLhCpFSAEUV4dvWnOloWhXLqBUdqD4ViGCQOzVIIPMP+w9lfU0hyny2yY7h+7DAfhaaZ2nL4Av0zE3VUBv3I4KxSL+Y8AK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697511; c=relaxed/simple;
	bh=YxzepmY16yMlFRX+sxkJWC8hc8gpAtMMk5JzYvyfeVg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LcpENdrDY4T+7MB7VNfZQOn/N4uGffV/KK6rh9DJae952kdJgtZHDbl/Hy0SIyaSgkwbS0uQIojUVsb1BYSVusGLrKztGEcxEqL++4EhfvYZf6xWD8csQLPc4S2GAzuBmV1rnEogQbg9wVPF3zqSo3i4yiD3wdaFwZmRZ/jca7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=WjxIgsfL; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FIaK6dPA5PDsWqXf8+ZmWXJDPvcGA4c4zF5ltBN9Okk=; b=WjxIgsfLGEt7UOGYi5C6Wc8A2V
	aTJU1vKJi2AY5rU+yzYMgkCQzzVxn0gfI7cibhhL9q2x61WLnY/VWlGQhrd21IOR5JqR6OUNQBFGV
	NDL43+8g3ZxvCQaHPppyAEE1zAjQ5BF8n5b4C3imQ6rWppbqjzVLjz59v2ZQYdu4AqJPcAUHrvtdq
	0rNA6p8Q+uHszuzIqHKaoBKuhAFeKrfpAvi1JLS4euA5n6yjE/U3YsbC5jfj5fYDXO9aTHNxBfOeT
	wR1+wr2BR+pcWDjv0yKLywEXWjVxDnLmg2sRddOpWE13LcHApYGUzDPn8cvtGpnGN2aDLk6H3Y28p
	ZoqlmGEQ==;
Date: Tue, 02 Dec 2025 18:45:07 +0100 (CET)
Message-Id: <20251202.184507.229081049189704462.rene@exactco.de>
To: hkallweit1@gmail.com
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com
Subject: Re: [PATCH V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <8b3098e0-8908-46cc-8565-a28e071d77eb@gmail.com>
References: <20251202.161642.99138760036999555.rene@exactco.de>
	<8b3098e0-8908-46cc-8565-a28e071d77eb@gmail.com>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Dec 2025 18:19:02 +0100, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 12/2/2025 4:16 PM, René Rebe wrote:
> > Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
> > X570-ACE with RTL8168fp/RTL8117.
> > 
> > Fix by not returning early in rtl_prepare_power_down when dash_enabled.
> > While this fixes WoL, it still kills the OOB RTL8117 remote management
> > BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.
> > 
> > Fixes: 065c27c184d6 ("r8169: phy power ops")
> > Signed-off-by: René Rebe <rene@exactco.de>
> > ---
> > V2; DASH WoL fix only
> > Tested on ASUS Pro WS X570-ACE with RTL8168fp/RTL8117 running T2/Linux.
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 5 +----
> >  1 file changed, 1 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 853aabedb128..e2f9b9027fe2 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
> >  
> >  static void rtl_prepare_power_down(struct rtl8169_private *tp)
> >  {
> > -	if (tp->dash_enabled)
> > -		return;
> > -
> >  	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
> >  	    tp->mac_version == RTL_GIGA_MAC_VER_33)
> >  		rtl_ephy_write(tp, 0x19, 0xff64);
> > @@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
> >  	rtl_disable_exit_l1(tp);
> >  	rtl_prepare_power_down(tp);
> >  
> > -	if (tp->dash_type != RTL_DASH_NONE)
> > +	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
> >  		rtl8168_driver_stop(tp);
> >  }
> >  
> 
> Patch itself is fine with me. ToDo's:
> - target net tree

What is the difference? The patch clearly git am applies to the net
tree with zero fuzz, not?

> - cc stable

I was under the impression this is automatic when patches are merged
with Fixes:, no? Do I need to manually cc stable? Nobody ever asked me
for that before.

> - include all maintainers / blamed authors
>   -> get_maintainer.pl

Of course I used get_maintainers.pl and thought I included all
relevant. I surely can include all of them it spits out. I usually
filter to the relevant ones to keep the noise level down.

	  René

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

