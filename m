Return-Path: <netdev+bounces-292217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOeNIeS7FmrVqQcAu9opvQ
	(envelope-from <netdev+bounces-292217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:39:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367E5E1EDA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 537B7304CFEA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C06F3ECBD9;
	Wed, 27 May 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfUGjTI7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B93DDDA9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874713; cv=pass; b=b3FAGi0jm4v/Rf4yT8HF8dO6/8CHuuV9WIHTOg5q+ujnz2WH3u3w0cyW97RtT0XrIj1qIZGJAOyd28huq05FkBM480PdSQgNNkiK2GXiUVctAmkR+U+muqaqYDdrKJNKjbVor8qW0mvSR8x+fEajYYj1KpyWTz7c6b9VX5j+qw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874713; c=relaxed/simple;
	bh=jkoyuLuzOPKsRZGw7+jyt2ItDJGLpRJtlXjG0vmDwCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj05ruIEtDmzZvVN4dmoEqgZlO2Yl4wgXx4u0iSDIF/zGA+qJUxjps18fZx4Qb9M4jpq+bIqsvoMX0x259c6kVUD9bdIRkwUlUgyX+EswgCtLlpPai0/P7poFm+OtR/rbDp7KefpcXZyDy29ZagO1eo37bCV7LAl9fNxlLSrye8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfUGjTI7; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65eb1b25c77so6189530d50.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779874707; cv=none;
        d=google.com; s=arc-20240605;
        b=iKgw8vzXFoUL1wkEyUvxDS30UhD8NIlvIn3BBAxhwv1qLer1S3/aGYpLPQiLNN+lJp
         QIpgWCXRhCg/a58PvAy9Vi7XZHgyAx+EwO4opV3YZa9JaeT1MyJ95PeO3EfgtbUuZT19
         pWflXJL9lOjK61okqO1wBPa5qZWsQCxJvb5JJS5LQdhd6nJR6Cwu+g8ehS/KwhONWNEi
         AA6PMmCttTwAzFpnbUim2QtrISofoR73JSAsqaKRAWiUGfjiobIVZ9cXbLHpWt2839J1
         7TwHapajrLh3GvMpIAEPLZPUY2QulvbFDXWMrDQ3xCWh4b48YS+PxvqrycQFMGJAGC/1
         Xfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4kn1CXbxr2sTPGEFG5RF06q2o/TEU5uocsd+TQJVadE=;
        fh=WCnroTeB1+jkLY2QNoOEDTxDRRoQVfo2SDiVkKWhS1w=;
        b=GmgXQpLTzIRH/uYlgIoKNs6gwvadZS/U/8O9mBAttnKUQghIsSaPX+PUvlzUEIZiNa
         cpEp3B2RqpKbJTO1odxGn+5wQrHhPl1fXVVNf2kTpsp6iO7Kbcl7NMrWQ1VwKxUdE6TV
         48Uk6HhwrUc1rNOU4q+NOU4BpLcR3L7Kk6EhmI9VlxtWM9qbnuPZ1AkOrT/8rsW1rQCl
         iQ89QS/9GDXLkZfpT4gepxZ3dMiJS5B2mQOlOotOCtHjdP+6PeYFXfXbfKBG8ela6ETc
         sRXIo9UjIKdalednHyeqhScMCSaIGuj9XSYUf+iDcPAACeMFeEGUwNY1jjY3cJkVfH8w
         6EdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779874707; x=1780479507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4kn1CXbxr2sTPGEFG5RF06q2o/TEU5uocsd+TQJVadE=;
        b=cfUGjTI7cBzLfnkwGfvm8P3ZUC/nczaz34F7BBmgKvsrSh0JSXF+SKGIUBLj9rD+pU
         GTc90AaeDweSgK7J+52SIzatoyFpbjIblFULCdclBsuFgUW0Y5R4sUR3s0PxxxvFEMfj
         UJ3NJzI394wSBOeDAb4pM65GUcHP95iGxLiXyoQ15l5Hx54uqEEsdwCoJHyQ68hPOMPK
         PRuM4podrRMmSfIkb7WXykztL8ANF3rymStENHXFFm1KpzgDVFU+rsYFCrLgl8EexX7p
         GtyoIksZmGZBIoufMqUk8P1rLRL5Glotcd7FKiOnwXg+lkXKUcAv38ocGLFwa0Bo2OGc
         R4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874707; x=1780479507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kn1CXbxr2sTPGEFG5RF06q2o/TEU5uocsd+TQJVadE=;
        b=kGgQoJydZtOvejzEM0Bq5rlsXEMtinn4BQpMlB37D2QboOGDgs24/j295paaylNgM8
         T/rhfJ1//md7biE0qziFTS0uaRC34a1UAOf51g6fK8q7y3Qq/u8Dh8A0lbc6aTGE+dpd
         GjYpOQrBO+59As2ZmhBMIU+LZRR6+HEYnRzrKDe7WVXBz03F6DtubiZqZXGezGAFeWqs
         pq59joznmPTMFl51JubSWSiNmJoZ9eUBBDP4dTB9UIrhJdZchtyBCbU4T5hDXPw9ZAeZ
         Uy3so7d1GLW1IIFUgiktPThdgguJbhKAsLmIYWWUZrZ1epqgB2CvTwhp+QggipRlRQkb
         dBdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WHnZwBBLArwU+fAqMbxXyzsmYdq+LEZQQSEKXq4RxYx2tvQfHstccb4B5WDg9870rw0LlpSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOiHKXokTQJM7u8pqsDIDIqpEgIkXNEekazAPIJiIc46Kawl9
	jDKgQDesUxYZVveBzn9/YiqvRUHF9/d087vKAQVVEhT/b0jrRJ6PJUhfpZBI2o2VOZgbm8eS9Hs
	Y1W4HB5fYl8MsCdu1PjGTUCoMrGIYsow=
X-Gm-Gg: Acq92OEZtntkb3xlNXr2vQqPnu8H4z87+G7IEGJUEcqJruxyO/1uPNvAqwgANRiE+TA
	cJApQOIylirG2GgTSuPD0yFCiHQCYnLQgk/iXI1XMdGhYZzDXaD4fL9YCdzdsa4MT+FT3bfLNZY
	tZIUEm1A8u6BDC4x0nf8uZVYDMOo9GxDfI2pH8zsc3N7/2ASxLdpwwCZKqEf4QzsdCkEWZQAglj
	Dhe+hG8koPbIet7f1vhuq5Pvf9Nbi0xh8vgbisgZbqxv/gri4u6eRhN9bGwVxs/EEfP/LCIHria
	VLHmpNV+2Q==
X-Received: by 2002:a05:690e:140d:b0:65d:7e2c:cbc0 with SMTP id
 956f58d0204a3-65ec98a9bc5mr21223294d50.37.1779874707487; Wed, 27 May 2026
 02:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be>
 <20260526-net-next-mv88e6xxx-cbs-v2-2-13eb49c29b83@luminex.be> <4d270516-a8ae-4bed-b316-c28a321c304e@lunn.ch>
In-Reply-To: <4d270516-a8ae-4bed-b316-c28a321c304e@lunn.ch>
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Date: Wed, 27 May 2026 11:38:16 +0200
X-Gm-Features: AVHnY4I3ZyVe3VtJsQHDwOHpQ331f4RXh0Xm5e3qUI3AdKlZ6oSEbQL6IlmnEnc
Message-ID: <CABvLYuB-LKk2St_HFVxQvn0P796PK0b8tM+0sCE2n+kR9LOtgA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
To: Andrew Lunn <andrew@lunn.ch>
Cc: cedric.jehasse@luminex.be, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292217-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[luminex.be,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2367E5E1EDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>
> > +     if (!qav || !avb_ops || !avb_ops->port_qav_write ||
> > +         !ops->port_set_scheduling_mode)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (!dsa_is_user_port(ds, port))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (cbs->queue < 0 || cbs->queue >= chip->info->num_tx_queues)
> > +             return -EINVAL;
> > +
> > +     if (!(qav->queue_mask & BIT(cbs->queue)))
> > +             return -EOPNOTSUPP;
> > +
> > +     queue_bit = BIT(cbs->queue);
> > +     rate_reg = cbs->queue * 2;
> > +     hilimit_reg = rate_reg + 1;
> > +
> > +     if (cbs->enable) {
> > +             if (cbs->idleslope <= 0 ||
> > +                 cbs->idleslope > qav->max_rate ||
> > +                 cbs->sendslope >= 0 || cbs->hicredit <= 0 ||
> > +                 cbs->hicredit > qav->hi_limit_mask)
> > +                     return -ERANGE;
> > +
> > +             rate = DIV_ROUND_UP(cbs->idleslope, qav->rate_unit);
>
> In the commit message, you mentioned 20Mbps, for a 1G link. Does the
> link speed actually matter? I don't see it here.
>
>         Andrew
>

According to the cbs manpage: sendslope = idleslope - port_transmit_rate.
In the commit message i've used the example from the manpage, which would be
correct for any network interface.
But the commit message  mentions only idleslope and hicredit can be programmed
in the switch.
So for Marvell switches the link speed doesn't matter.

Sorry if you've received html mails. Something seems to have changed overnight,
breaking plain text e-mails on my work account.

Cedric

