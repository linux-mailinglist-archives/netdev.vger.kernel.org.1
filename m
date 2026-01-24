Return-Path: <netdev+bounces-253054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLMDJ7aEdGko6gAAu9opvQ
	(envelope-from <netdev+bounces-253054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:37:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F437D001
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3370D3001FC4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889C20D4FC;
	Sat, 24 Jan 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgUUY7jX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1903EBF0C
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769243828; cv=none; b=RO/kTt+0jNeOGyn5lDrGrg8jU6a4gIj0KkM3+nJ+HbP0HcbSydFrxSNetqHvIRBQE8hoQx/L6uCJ22eoq6we9qnKd1IJshJjiThl09dIvA6oZBuGejO6qbQqV4OycB69zcVsnKE5aToHr9yCM1nzjImuOFTTSE9jOhpcwY3R6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769243828; c=relaxed/simple;
	bh=yBi19T5gG8BLiVfxxhJjA+yHmC4/2vPx96tRERd+cBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDsdoNB5Ezdv6hg02kksMle4eb+yrJBAvRnEUYCxxNvRewwrlx7T0flyDyQ0qGxgtTzJeOnxfty+BILbpHkq5p45xtHhz0SqfO5XyzeLIq+BjSxJFItsqF2ERapl/qcN82uMVoXEa6u7UfjbUJSDYVWeGTyHnE0XvX5jQiaQn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgUUY7jX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4357b308f28so312217f8f.2
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 00:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769243825; x=1769848625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t3Uf+uON7+JhKvsd7FkUSsmqwCPr9nA+llFpVr7IvEo=;
        b=kgUUY7jXdiuC1m/u7p04YJGSgYH/qz8D67gWCi5QJGq7/r7tPq/LKT9Qlrs3yH+8kS
         SjBOGwh/1b98BmMVvIryrikXXLpiSFzWP7v9uqslzsnU6T4MzetkarctrbCg1QL/osOX
         UoW0wVpbro8qey97NdKYTy9eBB7cKaooIGTMSarvUH4Pwi41B0ND2cIW/JIkV6atEU8k
         0NCQGtTNhJWmQGIA2GflSFB/BLJ8liO/2J9uYqOfqZxZidHSddndQU3JyzMlkLXR6PfS
         k290SKIHcWJSM8++OTcobYivdXp3yuq7gFXeS+sG9L4VR0NdXESun+tP6iQCkGtU3MPH
         no1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769243825; x=1769848625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3Uf+uON7+JhKvsd7FkUSsmqwCPr9nA+llFpVr7IvEo=;
        b=wTE7tdS+O/OUGCqOr4JF5vB8/4pcrqVcx1ZVoErVbZRajZihL2sUI3LnmUvu5qP6A+
         BN3fTnDpQGgTfWDfLkFXYO8ZcxKdhxZxpXNoKrjeNn9UsRpNo6zeaKEP5hMc1yuyAbxx
         GL9IP8Js9BrzKbcUMfTN5WjrR6JS/JPgiWKtzSF6FtJBzoizAV54pzTAYtbcohzj2cgN
         U4rFZPEus1HHdOn0Js8Tr7c5tsXfzrOFeIgL4W0QNo/3jczLJFtfUNQte7/ClBalOpLJ
         htPWYLU5Ocf4xwWppWxzUxgU8/7Vk5dq28ercoGIhoygqPKhi4KMPzYj3X9rzevmlJ2i
         YquQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2pSGsCu52Y95SnW14mIqJM54S1Rygo7wPofWxkVwpsRiapNGbmbYmpVcaNGXL8Fa2tq8wo7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEDGhfsVE9DzoB0XNglsNoJjIY3kyQI7mitr0WgDwAEnNUgFp
	Ht4OrEEo3q6ZPAeA6ukwuI7nb+0/1KyQUdGQ/xpXvwBOVP6xEmxtiYPG
X-Gm-Gg: AZuq6aKe4scpK6VqVEEABs7vbZWms02lTtkUoujY11karZC9YKoLKGL5cpS6amybv9q
	RA4I1IWuvkc+zMGV+0SrH4er3sSobev+W4k3Bxw2HDDai4aofuzLfV3jAurtaeSunOzsFBZ+NlP
	gOjCcWlbYiId8r9rCv7WupjWhkH3NvIVF0eGT/gNibUzGsUxHksSg56sdbNJpyntkh9UYnrjcf/
	LsIhqrIj+uB/SW9+/Rw5oO3UK9PL6VEC0xzRWgHDgaBjaHlajGqV21WGv6kR+c5PH5WhW8vKmJl
	4YUBCocHWo0/kBVtDlHVTWhx1HPHgB91ZMEfa1Mo5QZBnMDHZXJlCn+Hn4KIwInEbVHY2LR1x60
	xbDNE1xKYk4XDRC8CweioC7Y9OaT0GskmSFiepKtPI7hkP8DLKfnL4/UsHhAhU3OZdV7wlFHfri
	c/kQ==
X-Received: by 2002:a05:600c:3f0b:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-480541df18cmr18937555e9.5.1769243824865;
        Sat, 24 Jan 2026 00:37:04 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:1430:8b48:2d45:6c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d84ef51sm101897005e9.5.2026.01.24.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 00:37:04 -0800 (PST)
Date: Sat, 24 Jan 2026 10:37:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: yt921x: Add DCB/priority
 support
Message-ID: <20260124083701.ihffncswmoe6fw5k@skbuf>
References: <20260122194233.2777550-1-mmyangfl@gmail.com>
 <20260122194233.2777550-3-mmyangfl@gmail.com>
 <20260123234759.bj2gik3oobluyjs4@skbuf>
 <CAAXyoMOfMPzSAqePyiFLRx-Cth3LDq2f20TY+GpXOaVW-p-vRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMOfMPzSAqePyiFLRx-Cth3LDq2f20TY+GpXOaVW-p-vRg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253054-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25F437D001
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 10:05:58AM +0800, Yangfl wrote:
> On Sat, Jan 24, 2026 at 7:48 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Are you sure the "port" selector represents the Ethernet port default
> > priority? It seems odd for it to have any other trust order in hardware
> > than last. What would be the use case for that? Sure it's not an L4 port,
> > which could be mapped over IEEE_8021QAZ_APP_SEL_ANY?
> >
> 
> No (with the "port" selector) but I'm wondering, do we have
> corresponding port prio methods
> port_add_stream_prio()/port_add_dgram_prio() or something like?

No, but it doesn't mean dsa_user_dcbnl_ieee_setapp() can't be extended
with the IEEE_8021QAZ_APP_SEL_ANY selector if necessary. I wouldn't
bother to do that just for testing, though, just hack something up to
determine what it's about.

