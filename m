Return-Path: <netdev+bounces-255284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMKbOP9NfWmkRQIAu9opvQ
	(envelope-from <netdev+bounces-255284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:34:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A655BFA4C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB53830143C8
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534862FD1C5;
	Sat, 31 Jan 2026 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Rali/2oT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F202D8DDD
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769819637; cv=none; b=WRonHg5ksfKmMJWuizyNmPLPbIJdL25vBrBbdEJgiQb0qqJAJhr1yRMwp+PjbDu5zDWqY1zn9/RzMUdwxGzvJa6KPsQwcj1YfGHmN33LiuHQmjMXX0hgeu9VSV/jpPcTtyNckB+wHl5XthcAtzL6ygONTKaxaueXTAt0Wp+IvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769819637; c=relaxed/simple;
	bh=kXkaAnZDH5mIjoW4y8q5Q8QTe+7i086MQPfEVs63Pzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOds8DAfD7q/NbGN9+hhh9sWZ1djOaYSQfVeLfKPw6wHNodwsBSg6Ar2XxosW5VlBWjhNVE4AYkNtbKYtbF1A6NbXKx4bBlcMJse4tnjhLWAi7pW2TDH6chUPYb00DMneB9AmCiUIwb+zrI88Tjl2K+2gMbhdH/Y36UUvpr4ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Rali/2oT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a78e381fc1so12732895ad.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769819635; x=1770424435; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RB9dKGGm5zaCQfa6GntcD1JuM3+Ig5ioaznQVVa/kZs=;
        b=Rali/2oTC5XJwqHHCpOHxrNp+QuLjasxeaYHWU1v4S98BsMTaXagO3CfJBuKVG3Ax6
         ma32m/o6DLIm8mqV53Ms+06OCARw8z5G1Efrfs7VcHvQxTns3wSO3rvPwul0y1ZWAzZf
         8o4laUEJNYVrXCCOmx/cmCF6Eb1KoBw51PtjgoKgWZzS0jyIwSBafgH3r4MkjearCZ80
         4OBgjvcCFKYkqKSlvO3FS4l02kLKj2zXWAqBlmfo0OAHpexb3xORH0w5L/P4Pwa79G94
         BA22nJEKSR+stSK99zmJRPUc3/4zimIN36MPDfErnmZoaRBJoWo7gT9shNJ4lGWddfp3
         9udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769819635; x=1770424435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB9dKGGm5zaCQfa6GntcD1JuM3+Ig5ioaznQVVa/kZs=;
        b=X1aZiSZtOtoNKSHhZE+uGbOnYY8kFn2XucBOiI2qQOHf+DMdPOAULbmSG3ykMmDX6G
         JntB27uEaLiGHj677/jllWnfzOJcvAerPJ1b5YYWdlkpljZ3byhr8d7ZLRIJO/X39377
         zaMOop1uvnLXN7PG2GDd9X7j5aA15vDyQmkEVXewDi0lBhfTi2jJ77Z9QxfjpSO1YUiD
         h/ZPYv8W7zjNrvBHMeE3bVXg+bDx9xqSY6PW5h50pf5bUcY+ZZZ6bJeYeBugDlDPkAlw
         OQlwKgDz9P/H3isjjKPr83gELajpJPzCbaNrqi5HOHmQNAIDIpqYbimRI5RBUdEYMiKa
         gzJQ==
X-Gm-Message-State: AOJu0Yz5JOZ9NB1OLm0yKNLrHdojuRI0NZFybC4YZ1z7Q5lwdrGO7WYw
	Fd0FAa6zFDc7xH5fV5DUPq16mB5Xji1pUc6dTgI9PGDMazm3k4C527EMJR9ixx1bf2c=
X-Gm-Gg: AZuq6aI7jBkOFK4wqgxsh+9eDZefQWKqwVYU4Q/18TKW3dpOUL10gvTDiGaVBmyFUo9
	zNzqpnHhbvMxvEqalqQoUsKDF3oYXXXOqWreCB+toz8L5BXq9EDsTKk2aPTYesfA8BBjFoYwO6f
	+AYIyPN4Ghe1RKG5i7ttdVwOiuJTyHDGnHUuyWlRTw1nJ6D3suympNNtzSycZlcsHpf2hMpB1pE
	59XGuWl2zmKdwtuRGgEUCEZrYdYJeCoXqY9F5T8YwQphog873WbI7Gvg8AOu4R5gNwW8JZf6JzZ
	DiB1mDyuo24oOp8TKrRn0TFV2pJ+dNoINh7CHGpOVZ3yvclwdxFLc/avg6VU2ir/zRMqr5An558
	DVOcDeOBnDYGoQvqh4GFwrPLoYstEFXa93RVhf6PcWsh5R2DYLY99HOKH2u9YhMOWBi0=
X-Received: by 2002:a17:902:d489:b0:29f:e787:2b9b with SMTP id d9443c01a7336-2a8d9932dbemr38719225ad.41.1769819635320;
        Fri, 30 Jan 2026 16:33:55 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3ede23sm86209455ad.5.2026.01.30.16.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:33:54 -0800 (PST)
Date: Fri, 30 Jan 2026 16:33:53 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	shruti.parab@broadcom.com
Subject: Re: [PATCH net-next v2] bnxt_en: Allow ntuple filters for drops
Message-ID: <aX1N8UfZ4I+8ZTii@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	shruti.parab@broadcom.com
References: <20260130002323.2561266-1-joe@dama.to>
 <CACKFLinQD_fuJZDkzqHo=qFMQZrhXujjNOxuhBzHGQ8KwRJ8Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinQD_fuJZDkzqHo=qFMQZrhXujjNOxuhBzHGQ8KwRJ8Uw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255284-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,dama.to:email,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A655BFA4C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:28:38PM -0800, Michael Chan wrote:
> On Thu, Jan 29, 2026 at 4:23 PM Joe Damato <joe@dama.to> wrote:
> >
> > It appears that in commit 7efd79c0e689 ("bnxt_en: Add drop action
> > support for ntuple"), bnxt gained support for ntuple filters for packet
> > drops.
> >
> > However, support for this does not seem to work in recent kernels or
> > against net-next:
> >
> >   % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
> >     rmgr: Cannot insert RX class rule: Operation not supported
> >     Cannot insert classification rule
> >
> > The issue is that the existing code uses ethtool_get_flow_spec_ring_vf,
> > which will return a non-zero value if the ring_cookie is set to
> > RX_CLS_FLOW_DISC, which then causes bnxt_add_ntuple_cls_rule to return
> > -EOPNOTSUPP because it thinks the user is trying to set an ntuple filter
> > for a vf.
> >
> > Fix this by first checking that the ring_cookie is not RX_CLS_FLOW_DISC.
> >
> > After this patch, ntuple filters for drops can be added:
> >
> >   % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
> >   Added rule with ID 0
> >
> >   % ethtool -n eth0
> >   44 RX rings available
> >   Total 1 rules
> >
> >   Filter: 0
> >       Rule Type: UDP over IPv4
> >       Src IP addr: 1.1.1.1 mask: 0.0.0.0
> >       Dest IP addr: 0.0.0.0 mask: 255.255.255.255
> >       TOS: 0x0 mask: 0xff
> >       Src port: 0 mask: 0xffff
> >       Dest port: 0 mask: 0xffff
> >       Action: Drop
> >
> > Signed-off-by: Joe Damato <joe@dama.to>
> > ---
> > v2:
> >   - Extract the FLOW_MAC_EXT and FLOW_EXT check so it happens unconditionally.
> >   - Eliminate the local variable ring, which was used in only one place and
> >     call ethtool_get_flow_spec_ring instead.
> >
> > v1: https://lore.kernel.org/netdev/20260128222718.1679581-1-joe@dama.to/
> 
> One minor improvement is to eliminate the vf variable since it is also
> used only once.  But I'm fine with this patch.  Thanks.
> 
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

I made the improvement you suggested in the v3 I just sent. I retained your
tag because the suggestion was cosmetic; I hope that's OK.

