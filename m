Return-Path: <netdev+bounces-261952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFrkMWjvoWm5xQQAu9opvQ
	(envelope-from <netdev+bounces-261952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:24:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91591BCB9A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF26319DFB4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363B3F23A6;
	Fri, 27 Feb 2026 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="LPstR1z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA443D9024
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220140; cv=none; b=NmysgxusNe/idqHz9nH13szsaYLyp/YHncr8oWZRxggT4oqL7dyw0CzQPfvRLDF9p9xtuVQLsHXisC1EJJn+Be+jmACRHYrE5yvqKoMGZcnOqm+xe7bvnnoxJphe6hUTpeCHh2mj0lt/bluYq//Z0WkmUgICNf3eZisgFkfdooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220140; c=relaxed/simple;
	bh=MBgx5n8kVrmMAULFhv6Gifju4mdIngN0FbXTRazCA6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVflLBRC5zUPmr12jWnDStgXbEW2LZA6Ea1Xj921K3IYfpT6yaoVqaT3gyNepGQHXq2mWvAtXvRW1sTnjOthCRUL+Ud4XvTT+1v2GlNzDIayM6Hym4BD/x2niYIOvgEo0qe9I/tVEn0Zai1tKHaTVQX91qs54hCDDHXYMFBLiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=LPstR1z9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2add623cb27so16344595ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772220138; x=1772824938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eApm0kVe0VS7HCotL7qJPWA16XXyEXQdPZROAKafgu4=;
        b=LPstR1z9Hl7Fdhyh+9KkMZ0MTJ6bHoQFBlBFlWn7mgUaq7pKkuEjFTy/8Q1FepdjBM
         V7wZJGCWrAwX3eqCIqUTR8I5iaU2RLmavU+62GC5bmJScFSI+pSuOxnDZxVuXTit7RlO
         zW80w8pC/dc7HgAvh+Jw2/JAAGQY7sHI4EzZHnnEXT3Y6mUepo8yBUxwXc1QKTjWTswu
         t7CHTRepwkkyo8g0nQl/dqnZSZSr6VVDP5eYze9fUktXc5bLRfZ30UV9mSeSBvW6Q0Wp
         PoTgfoAc1mmyknwOKcotSQwUfMvQOWUlo+uDauuGWlRljhgtN4yJXSc7rNtQnYUqSWlC
         r5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220138; x=1772824938;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eApm0kVe0VS7HCotL7qJPWA16XXyEXQdPZROAKafgu4=;
        b=oTFs6a/f353ctTxpHbV3k+5nqU8f5T2vCyjEbclYCAk6k2LrpabGzrbagrpdV0QZZ0
         LtabizB7VPIdZnryEg3k2so3lVoFcmJz4ycTHHNuNnFAo/2wvkiEDYwi9D0/fSw4SyIG
         leQ84Fby3k+tmGoztEV7OjZxZmDcqpbAnierlJefgRFC+e19106wOBsgumkM/mStlK2h
         EK3AWR+yhl+4Tcvncby9GMgLJ3FK+DpsrvC4jcvie8nh94BB4Jl1om5fvxd/HYmRQdFp
         RFJhPVbsuTVwNOJ/UreFQNu71woVnr7KLdjLrM8731Zdw4jbQdBjGvcIf62qjzzcJn74
         qGaQ==
X-Gm-Message-State: AOJu0YxE6vLHttcx2KDyrarNjpCWkjHB+OMhpnHbofHu1F6jw0Khzp1b
	CY8MSXBd/obdmdP80Tg1CRz4oex5D0jqTYw5Imu0i6byuIt6jIjC2Igt6irb1kcFVqM=
X-Gm-Gg: ATEYQzxo7ICigUoBwXj7rPMVMb8EXXEuyCxi2b0UM6t7g1vBI3vMTecqPTzND7F0Qgd
	uwDa5EZJFYb30oMYd93JyLzp4r8pW2HDQDzhDiDXQYN1TXpEqHrBz7QwderfaKcysWNEDJTo8zE
	Q9SWO3zfIBm+NwtYGxomFn7jrgeiAZaAyzlJkhvD02yZsmy1WgLHv7/4YKKV4C6x+e/f0O3dJ63
	xRSC8OkrPfrNoKj2w04J3A4Js5IGA/FW7OsUFhHr/zzcsVLkufmy9M+at4M10ymAXf9VNYq3gUv
	t2X+OtN+TR1iJHyhvGM4Q4c3XN1HBTwH0EdiLAUApFdnIGoEJVweT1lb/rk/cO46yNftDs9N8dO
	PrJZMTPLWYjwPJ1OrSwF0W3/WFNfs/70PWqWAt+IzfqC4RArW5y9dXoAh3OLO5llP2mOgBN121g
	a+c7Fm
X-Received: by 2002:a17:902:d582:b0:2ad:dff2:d412 with SMTP id d9443c01a7336-2ae2e251b48mr46204845ad.12.1772220137993;
        Fri, 27 Feb 2026 11:22:17 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5db596sm67886755ad.35.2026.02.27.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:22:17 -0800 (PST)
Date: Fri, 27 Feb 2026 11:22:16 -0800
From: Joe Damato <joe@dama.to>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v2 5/8] net: txgbe: add power management support
Message-ID: <aaHu6Jk6I2/3JS0d@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
 <20260227073450.23680-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227073450.23680-6-jiawenwu@trustnetic.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: E91591BCB9A
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 03:34:47PM +0800, Jiawen Wu wrote:
> Support .suspend and .resume and Wake-on-LAN.
> 
> Implement ethtool ops .get_wol and .set_wol to support Wake-on-LAN
> function. WOL requires hardware board support which is identified by
> subsystem device ID. Magic packets are checked by firmware, and
> currently only WAKE_MAGIC is supported.
> 
> And WOL related operations are added to txgbe_shutdown(), it matches the
> implementation of wx_shutdown(). So change to call wx_shutdown()
> directly in txgbe driver.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 +-
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 49 +++++++------------
>  3 files changed, 21 insertions(+), 33 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

