Return-Path: <netdev+bounces-271971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAxtNUAJxWnn5gQAu9opvQ
	(envelope-from <netdev+bounces-271971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:24:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E396333403
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C7A4301F68C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61D3C0611;
	Thu, 26 Mar 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUSZFZv6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E73A5456
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520509; cv=none; b=D4ZJok62vgarkfjOvyI52KWnVVbMLv8TKZ5pWOeCyt2KCX8lZxD7pTeJ9yIFgl+ZktIfJo8T+Vnas/rvJQNVG/8zR/cvdXBvLWpSxbeGqpqKBTxIM20wcvt5uyruXg97xpFTGYogHK0G991WxTI8Wu7WGLxiGXHgHxIWABlLATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520509; c=relaxed/simple;
	bh=KdfAd2MtERcYLU3RLFCI8hbuUz6oy9qMFn2mLox1ooQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA4+0yILwP6l7x9PiSWz24kq3AfPNUIjNkjysAB3ydy9hdAnjqR1aRTsZS1m2kTN9wAZ3IwDcfbXnEF7nHvJRpfSI6DiKHPFnNYWBH+o61PXXgLfRxSA0gj1SgrQXfPYGuoj9uYTb/gsP+gz2+N7sMDrBqMQT7bFsAeu9IXaS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUSZFZv6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b8822fc05so106009f8f.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774520506; x=1775125306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSAlyRcQqM2RCuOQHAatvVT+Q/NgzH2YHmeBBevIMjw=;
        b=aUSZFZv6K+G/IVLHSFhhlc9NqtbFIPEVnOU9b+0shtScgEW1UvSJHekhvYI7qaWoyM
         VZYFb9JcCRJz2AGOjMJBFXq6G0NYmXFWZEGCCvym0cny5ss/rnvzgVt68h2vxVqUmTwm
         P+4hQC3JMCdEA2jjGeQ7D3euZXhxUDiA3arscGUrb4I3ZCtEXfqSWn3W3uvYmxtSWJdz
         6hh4u4C7lN2oW4zjy80Lvteo8t6Va9DmtiGqqz0YBPyf+cDmaosz2KTtsNRvINDmnyWb
         /oMfa4dJkdQjN2VBzoLoJH1BgqXVHk2iRSKBxHwfeHXEs0CR70R8YdEuBw6JJFeTqPw8
         TPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774520506; x=1775125306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSAlyRcQqM2RCuOQHAatvVT+Q/NgzH2YHmeBBevIMjw=;
        b=Ef611iI3Upyv+QZ6Zif6l7LrDgtTG6PfTsIkqI+fEj+Zt20TbNdiVB19vIrTugbb+S
         0MTkKO1PPhYzbs+Kged74oSA9F/Zko/GL1cPtJew13ieaW2OS6SBu9I4f8sV1XPSuYLL
         HElRUrg2Jm50LDyMDySzA3lL/05X2vPlRj/t+G/F+f4CK8K3M56Gq0L+Y5ZXIcXEtO1h
         +GJm4rITxdGsBR1GI5lKQNxgT2CgXx1aBsivoO6bYo0Xgx3GcmPkuttiMouO6Y1RF9rw
         ywuQyA8Xq5EldiXUSE02jWHQK+vYvKoIoqjiFgBosnPIeqzT5pr2wcCGDuevrkGgLKIc
         +Qkw==
X-Forwarded-Encrypted: i=1; AJvYcCWe7yVtSx4RVF/FdXIlfF1S3tZ4vl3XsqGzfuhWu3KOfKw04zYC9e18UgLVYRsxe50nps1ZakY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBpR3yhWPytSmiAwKVNtyiDNmpuJgy2Y1rFXSnMvpIsT0VUTg
	RXK2hiigTG08YFrOSbTz6DlxWpr+Ppnjm8VfFf7sncdB/VBwd35KqW9ikJ6yFU+/
X-Gm-Gg: ATEYQzwZR6E+acF7qLBVeYgK2ZVx39JTi/UBs/UDCihiuzfxioAi3mZSns50Y0DhCRR
	T3GzlHKnEsmxkJoQXB3MviVi/XG9lgNcUID7fSTnzsS4FwDBhKPJ8u2vm1gHiq6oo6qYcvbLsfl
	6e4r7rQjhd65VhuxvltFC8vVktDWpWtXFYreOBKcgOKPIpLDHx3eqkdzF2m+4xjfz6IpVWvf0Jy
	gn1ShysZa0/ooCggoG4YEoaL55Pl3qUN/bJb70eRg2Kvw1Yqn2h2E8JW5auw7KdnIUN6OiVA5s1
	thto4uPi3VSXlQKf8emOhhFR873nHY6YgHSBD/nDqLehnevCbVLSUTfBesXmDbBqWx2nrLsqziB
	t4qfO81uRVOLoQZktUwugm0IER2Z4q5xVkSdAvcEqSTcZrPhZE16mDVyttBORmbPfVzURfzpxkZ
	Y2To7SZ9LZN5ZZfuw=
X-Received: by 2002:a05:6000:5c6:b0:439:bf55:f5de with SMTP id ffacd0b85a97d-43b8899ca98mr5521837f8f.1.1774520506004;
        Thu, 26 Mar 2026 03:21:46 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df85csm9621541f8f.28.2026.03.26.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:21:45 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:21:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 3/4] net: dsa: ks8955: Delete KSZ8864 and KSZ8795
 support
Message-ID: <20260326102143.hh3g6oo2jp22i6ps@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-3-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-3-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ks8995-fixups-v4-3-989abba8f077@kernel.org>
 <20260326-ks8995-fixups-v4-3-989abba8f077@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E396333403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:57:34AM +0100, Linus Walleij wrote:
> After studying the datasheets for a bit, I can conclude that
> the register maps for the two KSZ variants explicitly said to
> be supported by this driver are fully supported by the newer
> Micrel KSZ driver, including full VLAN support and a different
> custom tag than what the KS8995 is using.

And more importantly: support for the internal PHYs? Tristram pointed
out here that this is is missing
https://lore.kernel.org/netdev/DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com/
I was curious how you are avoiding that issue?

> 
> Delete this support, users should be using the KSZ driver
> CONFIG_NET_DSA_MICROCHIP_KSZ_SPI and any new device trees should
> use:
> micrel,ksz8864 -> microchip,ksz8864
> micrel,ksz8795 -> microchip,ksz8795
> 
> Apparently Microchip acquired Micrel at some point and this
> created the confusion.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

