Return-Path: <netdev+bounces-258245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGKMCK9SjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:58:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEBD123107
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82F8F3009008
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91083612EE;
	Wed, 11 Feb 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGyPRlJc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D935028E
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803884; cv=none; b=JG5eonb42CHcDlORWM3Pk9Fo7Wk2I364+N1r9I8uk47M1Wx3gA9brDSjHtzcOmgW8OWyq4OJw+uiN4ICD0M9voBbhdUPNAxifvd8Pa7wZ48ce/jkVY5+rH4bIbJ4YBYlyMEuWW3h7ZXaczf+3acafAr8yP08ok01ZqLqK9wmszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803884; c=relaxed/simple;
	bh=j1gGwzFrPEp55EzVIdvTaxzf5VDVeMo4Ihv3OYZ5rOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG9/y5rX98jQWsJJmOTCpjqFje11baeqdl537RCBc5/Q/rgn1R38d9ge7+dPytmPsjzXm+uDVOd43Icf17cSe4C4dAlLWPRtbeaL/FLsCNlikcUrxiTqbaUt5TaEND25RNkmAkz1L3pqZyIU8epdzVYWVkSuDB/nd824EZRnxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGyPRlJc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee57c478eso5881125e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770803882; x=1771408682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLronaqmOYx9+5+0YsCI13INff1FSvhU4CEpmAvdKu4=;
        b=iGyPRlJc25xse5U+nEAT7D7xFYzl6ZRhWXF69+2p6Knvr4EeRFZYXWT/ratiAb+6nu
         emjdMVkjjEBHLNEUHdJXbdwHBYOEbr73U9N4ZIJiiTHBl6l/grN1h9Ytk+/3blLwc3nO
         iRpqyQ9CPiGKdQauEgV9+ZEOcKfLQcsU2gEPpMyhiqulymOs7UDqgX4/AeYBBUZkxAhO
         g9ZFUAaPO8OZOHEu/xTxCL7zdXb0x/csAXd8xweCvlmbOjBkwYthpV4Wd4EqUWGwlCGb
         b5EdC2w38enNCgQFneW7dC1ziNfm3s7OhhIwmiqFKM9+sYU8qOLRXtMrOpMpGOjjia9X
         Eolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770803882; x=1771408682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLronaqmOYx9+5+0YsCI13INff1FSvhU4CEpmAvdKu4=;
        b=j7n1A0nLby09iHTMdqzPJID+2TXk1aRdY+2O2rdrYmwhOnkYN8G0OywiN6xGD2Jrd5
         AuuJs8D9lD2tX5oukeQCkQe56QkNr+27DvOgdobQYCx2BvAzOrpp9obDYwzZLQaFHO91
         8sQP295PjtNPInjyRR6E1T2Kdgyuml2g7DJBzuC+u39uyd2rBhk8hFAzGuIXxJlSzHZ9
         VXnlonTRWtZJVXZaO9aKr4jhvRpQ/SainSGj0azvGVmPVwSv00MRg8WD0Cnhe16eNtCq
         FvYn6HiRFPJ4TCwNb90S31gZgC5UDc2ktQ5EyuiS4TCOmTwXXBjjFuGsDxaPFh1rswmf
         mjjw==
X-Forwarded-Encrypted: i=1; AJvYcCUj3c7lQiBfKuQ6MND/RXeaAmit2D8qiUGmq7PkdNi5ok/JwQfKxmQeqMPAkwvQViqoqyln+LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3dxPqKTNpqKSpUJkYI01mva3MyTB4EJhVse5E8U6gYtyCD/v
	BbWjYXQPJFMxp2vqFF567K7X8OhKejxHVaogGW8oUIiR8Yabd37BCfsj
X-Gm-Gg: AZuq6aJHPYQCNeWJtccRgIQTX8ZywhoqX3JDSsLTpaGmbEopBrkporeu7K+rsmudxb/
	CEtJ9yPbe1krNaZbsuGCx23IJa9cWzYBEF60NOzJ3Y5ISahyWZ9dL950AR/5vTdldnSi2Fz2zvm
	fnHncneh3Kz7d8MarXhPxF1FHIwMMokhhy7v+he/cr/Zf3W/Qphxe3p1PzcSjvR6Hd55JnjF5pZ
	8WrOC4bSQ/1O3gleTLUPyz+wnyVAnCiMO11wCuOCiVZpKktZ/NmnLS5JbXbnAXpMyfrQi6LxhiX
	vRgCLwxeyTOupDtUWwNIMB8qjTN9oDzrZ0d4vulRPgBwZz2IRDibiCM7Ge5FqZFDGI3W1Urttxz
	7RLp+KJs9/eprro2sHwYNADiGtHyM+rCLFGF/Cp4Jkg9RMt6aVgJSFdeQ6P3HTBIkIgtJL3yHSw
	9gJcHSeqqYksxC1ho=
X-Received: by 2002:a05:600c:a02:b0:477:7bd8:8f2d with SMTP id 5b1f17b1804b1-4835e321172mr11637965e9.8.1770803881559;
        Wed, 11 Feb 2026 01:58:01 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:d8ac:c964:9b43:1b13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5c550sm3671505f8f.36.2026.02.11.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 01:57:59 -0800 (PST)
Date: Wed, 11 Feb 2026 11:57:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v14 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <20260211095756.cejtseyheagu4pku@skbuf>
References: <cover.1770433307.git.daniel@makrotopia.org>
 <20260207214733.m2zvh6ozo7vsc5hj@skbuf>
 <d6393a14-fe50-426d-9dd8-5a33b2af0a0d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6393a14-fe50-426d-9dd8-5a33b2af0a0d@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[makrotopia.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FEBD123107
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:49:56AM +0100, Paolo Abeni wrote:
> On 2/7/26 10:47 PM, Vladimir Oltean wrote:
> > On Sat, Feb 07, 2026 at 03:06:48AM +0000, Daniel Golle wrote:
> >> This series adds very basic DSA support for the MaxLinear MxL86252
> >> (5x 2500Base-T PHYs) and MxL86282 (8x 2500Base-T PHYs) switches.
> >> In addition to the 2.5G TP ports both switches also come with two
> >> SerDes interfaces which can be used either to connect external PHYs
> >> or SFP cages, or as CPU port when using the switch with this DSA driver.
> > 
> > For the entire set:
> > 
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > 
> > with some minor comments I'll leave in individual patches, which I'd
> > like you to address.
> > 
> > I don't want to put anybody in a bad spot, but given what time it is,
> > this set should get at least _some_ time in net-next before the upcoming
> > net-next PR, to allow for some reaction time in case of some unexpected
> > reports like from static analysis or similar. 
> 
> As I'm wrapping-up the PR right now, and the series is not applied yet,
> I fear the above is not going to happen.
> 
> Since a driver is involved (as opposed to the core stack) and there will
> be the usual release cycle to address issues before the code lands in an
> official release, I tend to think this series should still be merged -
> unless someone voices strong and valid concerns _very soon_.
> 
> Thanks,
> 
> Paolo

My feedback is non-functional, so it likely won't be addressed in the
RCs. Anyway, it's probably fine...

