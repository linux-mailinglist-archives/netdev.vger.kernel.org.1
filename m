Return-Path: <netdev+bounces-273758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OZ+Iqg4zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 025973716EE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C22433095C03
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF673FB042;
	Tue, 31 Mar 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="htBThJpk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AE3A5437
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991496; cv=none; b=eph0mDpvUwCnoQjFYv+I7XfOE6mY2tJ8Ek7L8Jb/3svJS6ESB9h5VMu+KbQ2jCdisC/5GdY1ClUM3Tr6T74oTwFtOn6b3oanHC1rUm91YQig/KonEpzthp1Ho1HmqVxdKmevtOIGE6LtQ/961Jk48jllvkZUDWgTtqBWp9//Bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991496; c=relaxed/simple;
	bh=FWRC3fOXOYfrSoAOEpVCTCqjxvELujNq8j/OczlXMas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld1BR8WRVNxNjlENgfuZXeoFN/budOibloEcWxauR0ZXBnxwvwuP9aF2yjT1Hz4/hv5kiG3xLCTE46XvGbc56lvzAk7eCIy9Bo6JGRXIZNcBE/KP+lCedJhpxO2eGj7In/XlAUqEJ3Gw+zgenEEdtCDRInxHpW8k4I3TE9IsvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=htBThJpk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-827270d50d4so5398510b3a.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774991494; x=1775596294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRLI2nmGdFJjDdlaJeIJBPkgXFafuXmLsFAn4yY0FP0=;
        b=htBThJpkMhWXfbpNxX60+Z1D9MokrG9caZA4OwLF6mLVKfF/Of9Z8Wtoo6eYdbdX3o
         uU6TLWFV/I310JTWXq/qHEgeDhko62Qyoej1cQt8KDJfwTq0OQCpWd6A6jwuPE1GBdfh
         9CN8xgJHNMKppn0a4HOI2XJsnZcnkFnUjeHNTYpebMddWjrMes+l3vDU5gAT9Fj1Sqb3
         dA4tzlUAF2qd8b/7olXhZtpnkv+OHD7YCXSbEfXSjzg2+OEY7KpZIrgI3ra3AOomY5Vn
         yPE935/yFWMNGBXo6+nuwrV6dRkRZ8wsRY3DAuZNP5BFWy2GID2pNHvG3CZYDxQ50VMN
         iFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991494; x=1775596294;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRLI2nmGdFJjDdlaJeIJBPkgXFafuXmLsFAn4yY0FP0=;
        b=gH54mxtfAqH6AxJZBaTuE16w1oonIt8L0MiyJcogHTEakiUJKfrTDzicDQyEBRBewK
         7HCjO6b/ty1sR9vxnYErQQLoHaoUkWlVFjHmOeAMnc8VuhhZRNpLzWUgnKNiFVyiS1gr
         XxRqElXyOwVcud95RBC51FFDF+aLQdaECfifwHpb10wsocx1J3+m8aHAZ8Blb3MYL3uT
         51WRehkAwASdZFOM6DUZUmewdi62KTb/wypekLoHZ5/yrtP/rlCzlSHgNUe8P2EJL+Io
         l+apK5BnOPztsUPDSoNkDxYW0tW2BJZsxzLRZRfz3MMu1Q4O1kTL8WMc2UZSa5iRUyFL
         QD2A==
X-Gm-Message-State: AOJu0YySwCuJtSTERBwi9564+hU4qBwU2pw2kUFIupbsTAOwjfPc0TfM
	TaJ7DeJACh9+AAmsSP2chT109dTMYT/J3GNvWclyZwZOu0Kwp6KTPDouqRG6W1uzO/E=
X-Gm-Gg: ATEYQzx36TJKXmly3YXyWGeqfd6SgasvPiRF4ERERKwovonLFVq5yhHFAVF11aSHOgR
	I7uD9QO/X4oePZEZC2RYR46+xMxx0QsMKKUDN1LubLpFuQEo5qoN70/KgOFd8N562YHvqWuB0m3
	1FRXmilKs7f8T5ew40c8qpvDvVmMwc8qUElSVTtEqJstJsC4/d+euJifk0yEY08JQdKhokvgNAA
	MxR8iDmhX7z6nY27m+L5bNadYXbs/0KjUOL0XoF8zP+fKva/1xqpCUeiICJmhauXVOhKYoXbeVr
	WvYrf07VVH5J+9If3avZXv9xj6kyDGfUNGg9//Idast4yqSwB8DuitXk0Nn/LCnr54YRRmBsj5C
	MOJazRZQGYpd+Ab4paap7DDahg6rsxPp2Y4tJiXnOSFoQ9Rjin4J2baU6spwwKuIdOu598sXtSH
	6dmpz6
X-Received: by 2002:a05:6a00:1951:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-82ce8aead3cmr1033738b3a.52.1774991494490;
        Tue, 31 Mar 2026 14:11:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85ef1bfsm11111542b3a.44.2026.03.31.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:11:34 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:11:33 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 08/12] net: bnxt: Implement software USO
Message-ID: <acw4hWuS4xt/bCwJ@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-9-joe@dama.to>
 <20260329152016.27646fab@kernel.org>
 <acqqjfzDK04j2APz@devvm20253.cco0.facebook.com>
 <20260330165357.31a30b68@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330165357.31a30b68@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[devvm20253.cco0.facebook.com:server fail,dama-to.20230601.gappssmtp.com:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-273758-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 025973716EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:53:57PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Mar 2026 09:53:33 -0700 Joe Damato wrote:
> > > > +				   bp->tx_wake_thresh);  
> > > 
> > > Is tx_wake_thresh larger than the max USO even for smallest ring size?  
> > 
> > Yes, it is.
> > 
> > Maybe its worth adding a comment in the code somewhere to make
> > this more clear? Not sure where would be an appropriate place, but maybe
> > bnxt_init_tx_rings?
> 
> Hm, as long as BNXT_MIN_TX_DESC_CNT is updated I don't think we need
> any bespoke comments 

I am hesitant to update BNXT_MIN_TX_DESC_CNT because it affects all hardware,
including devices that do USO in hardware.

It may not matter in practice since I would be bumping it from 19 to 210, but
we could just leave it as is and let fix_features and init_tx_rings deal with
ring size (as they do now).

IDK. Feels "safer" (but maybe less clear) to leave it as is. WDYT?

