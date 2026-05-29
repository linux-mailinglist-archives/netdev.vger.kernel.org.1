Return-Path: <netdev+bounces-293012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHwYFI86GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:04:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76925FE47F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F34C30B0D96
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A83A872D;
	Fri, 29 May 2026 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih86F3MI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6333A4F26
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038256; cv=none; b=BHRo9ZRdYCekG/pPdhNSavzkk5Ih8WHnuLr5+44kiw+FCP/D0genarsViEO/OduQbMx2B0TF4WY8SxhfrsqdKq+NPwn8iSMzPY6ME5HFbYGPzea9kmul5/hqzJ+155YuM7AZDjNn0v1KCxMlPQIxmfQAba9rPCdEgS7CUlAAddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038256; c=relaxed/simple;
	bh=djmXfk48xDFduREUqzGay1ucW970HXSFZ64D1LozYtk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwm6gfRRjw1t2nnK8mcckd77IVSDxH0iloIcdwjAtzL1EJ+k9VDgm9dVXgyNzfLG2d0t7YiGS98KDxVJ+OHkFVTvZbvTC/y8EQde42/jxq0F7JWlvVzV/rSrYFpwqs8/lGmHoG1zIYYliNof1TCTvaZiukmK8bmXLhCUq4L3eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih86F3MI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4909def6a21so925305e9.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780038254; x=1780643054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dmz7ES/Z26yzweUmM5cTH/VSInT7Ou5ujOIFH2kVq/w=;
        b=ih86F3MIjvtTr/KTU3FY05JDA2I58hvXEO1FcmF1+b34JEVMUgC11N9kFS4u6iULxC
         VS/aBDaQiBtuPqsH6Yz6oABQ2vc5t40nmOYeMfue63KCsbstJz5lYGLRzURQ+oGaQ2el
         vf1UFgRWyVTiq3Sl933Qfc078fm0Uv+/thB0TmnLuoQYw8hMeK+FeLkh8pd8SzY119Fr
         XRF9Uk9vTo/M3B6wmp0xlE4b7i4CFuWEctEo22jNhjk17T9dwquW9gvFW22Ax5cHKFgf
         zIZFXakEsIsfb4nacM4pIQ4TQ+IND+o2NFNwzQKW8uwmDT4/1ysyCGBIT448HiXT4BrI
         51JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038254; x=1780643054;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmz7ES/Z26yzweUmM5cTH/VSInT7Ou5ujOIFH2kVq/w=;
        b=LT+yfw6iBPLkDSGQpwyhCaLIF0SJ1wg3RM4rFZ7FgF//G4PDCvfViXQTCAvDEbQc7/
         tnAbqyE6ZFJ3LjLp+TkWwsHiRdX4Iw4KAmJ5FPy2p+KghLvEJfAtMjkY2eis8RIbD81H
         N/a8RoI6bE7yT6gF5TXTcfOVXTMhseuye+HK6yeVNS+jAEIK46nbyxa+1AE2y4lEhQVG
         0kR9VZtb0gSzcbUYsmTjfIl1/adgwoDjafEgimV58XMzJyvFCH4cq5P62QyzUG19uyuW
         hcYDE9mI0CmJnJwiHtj4+8+/HouAxaYfQFoJfVVCqM02M3pQ7gbOb37iZwaVTrX9HwwR
         VYaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SZBE5lRMN7jl5MJPdJK3xInjgrm0V9Qg6MZP4MCibXhab3lTLcv8EVRFnAtJ4PWNYU5r4OEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGipHmq28fQ22T5caUyGDL675xxp1jOc+41bqKnH5t1NU06Yss
	icVNHiizyn7xtSdnHWfNWB4aqOSzl1bmh72en0wQPycKrcVXdInZr4/LIzBVCA==
X-Gm-Gg: Acq92OEkJ0p/Sute5afvjk5NLOgBX4rp3x70Rl6/xGGGWEzGuSCvVLa/blVh440eZKU
	LlXA3uZBn0fyf8D8a4kEWWgC4O8dWXaxT2cG7G6rdt+vsj1fEbmD/v0fybjjfH0ohlthljnEUzf
	Nuofp8DhQSk8qYwbvkAvjm1FdSnIaHOYL6scfOT74PdBY3lrorJtUNYXuYu3YAh+9N6N9PoQGAD
	/EMLHMndOjOOrTbMM8/7KAT/Qgd7MV8mKF+3gP+UesNuFiUZ976nEKdFkurUGNZK8h8gZsvdcDg
	mrZRQ0W8AisD6+sLEqCMacGezMqvJLjIKRiFmtv34kF3phvd8/HlH/hOcaZSa2yBZJtEsEFFW6V
	TrNeDoiKDVWUN7VBcsamIsEbgvb6s9Xt8TDw2rIsPaEdHhoCVquqS/fGK2SYP2OHGm0nKjmoqLT
	riB7GGKaZ9VU9KBGsw9JGSRRVRkJ1pwsaGjD+9OfXlD+pQ6ILZ0MPloVpCEwdZArZOejWIeZ1H4
	YkVWw==
X-Received: by 2002:a05:600c:1550:b0:490:846d:e2de with SMTP id 5b1f17b1804b1-4909c0bedc5mr28137125e9.28.1780038253663;
        Fri, 29 May 2026 00:04:13 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-42-252-49.retail.telecomitalia.it. [79.42.252.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm20305395e9.3.2026.05.29.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:04:12 -0700 (PDT)
Message-ID: <6a193a6c.0c2aff9d.3966d9.f87c@mx.google.com>
X-Google-Original-Message-ID: <ahk6aincHowmarJ5@Ansuel-XPS.>
Date: Fri, 29 May 2026 09:04:10 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: as21xxx: handle corner case with
 link and autoneg complete
References: <20260528193545.11160-1-ansuelsmth@gmail.com>
 <9d3729f0-8d2a-4b21-ae87-aaade72e388a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3729f0-8d2a-4b21-ae87-aaade72e388a@lunn.ch>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Queue-Id: B76925FE47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 02:36:07AM +0200, Andrew Lunn wrote:
> On Thu, May 28, 2026 at 09:35:41PM +0200, Christian Marangi wrote:
> > Add missing case in custom read_link, when autoneg is started, autoneg
> > complete bit is reset but link is still not up.
> > 
> > Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
> 
> If this is a fix, it should be based on net, not net-next.
> 
> Otherwise it looks O.K.
>

Hi Andrew I didn't want to introduce patch conflict with the last patch.
Should I split this?
 
> 
> ---
> pw-bot: cr

-- 
	Ansuel

