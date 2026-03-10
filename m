Return-Path: <netdev+bounces-265864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZZEkuBr2n7ZwIAu9opvQ
	(envelope-from <netdev+bounces-265864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A5244351
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46EC2301F384
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE732D0D3;
	Tue, 10 Mar 2026 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIGaSHul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1F321426
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109577; cv=none; b=o4MIK4F8I+s17rCw92kIXhAJdoalfcsD/qg8aBNXbrGVNX261k5kLwSN7+t+EBIVzO/oPUNM08Lr/fSiEBe0K9lOe1CQOuR6a3y7kUoSIbQv/j7OA9vO+mhxSUshtZbK3VoEuxObaokM3wh55amp+2YIdoN2WSnpVw7aeXWo5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109577; c=relaxed/simple;
	bh=REWaekNfQQuxdD1I3RxqzpQkwwFTv79tGtEzJMSNPw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMkwGxebSFZm6UgKzTdR6a35IkxCmbIXu4Z9fst+7G1Zsbx/3AlJQCO3s0yP8xAhIkhE4k8Nd/jCNrza6xE+2lWAZBx0mkX2mNUorBBgYnFqBMZ+NoL0EeUIBHBlC5yEGrP77Qa8kx3oSFLsMJH/IfNddDqW39LyYiKavs92T6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIGaSHul; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927261a3acso111317607b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 19:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773109575; x=1773714375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJjSo9viGbZ2CWxLJdla0BFYZe3WZ5+NbUT0dpWASZ4=;
        b=lIGaSHuloGwDDobC+Mj5q7xKoOeYTaa18A8GuRKZ6EABmz4+FjQlVuj/l14DpihiiZ
         vNH+Xys5iEfwa3mv72rQLKPRiDjFiTnIbq4iUxtKv9JMLxUaFuGJxyL3fg+lZu9Zouyh
         Se8ykUvj4qnj2pm69eQj6SJmFIGEHCH1Fo4gxCS8lPjmlYYEy3Ve4zm9/kcktYvdaVZ+
         oLTWBsC4y+oR5W2Ruvd+uQoVQe4e6IDfLx+cG1w2+OGUT8Z6oc7yMyEsugo14o5oqthh
         fuRZ8oQAmwVPVmbcdqg0yGfEaHSfbCQTERYYDfpZheignaluo5CyXaMIZcyGFcc12JEl
         MfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773109575; x=1773714375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJjSo9viGbZ2CWxLJdla0BFYZe3WZ5+NbUT0dpWASZ4=;
        b=l6EoErz7ceDu2iiI0bnYhBmftV5n2C3eqfPbw7cJCiBF2RfopnFUfLJxxOFfR8WcY1
         sHVNoso3qKoInkMtmKyiK5bcNOqGGAl8osyZY+HsubgkUnQPXdMpQCi9i2z2F5khMPlc
         IQ3v1gFcxOE0n+HxjsZBi0dMZ7N6Bcw6O8l6MVAdSmrRiRekAsskOelZqFVXtM6dOTHz
         OUgWGIQRSsclGTGk0IS5Bw728xTMhUTvix55tYo8s5B/4Y2VPrlqRefqaK3pYGmsjntw
         QAVrckK8dVKZrgaObfsyWv+wRmJDLxrgE/w46RGvSeoz0Op4xysYoj5aGX2uIQghrtk1
         TyWA==
X-Gm-Message-State: AOJu0YzDKMF9btZ9ApIpjzdSUJ1XP53FRhncQkh8TIyOM86iiY/fg0xu
	ZX35R8p1wQuPZqhvSl8FkSlgOUbEynxs8+3h3gJVVipE9xvHl39ZYs6n
X-Gm-Gg: ATEYQzyZUy2lHwxuYmNOc95Ay+lXyHwQfxwD8x9IcRhQevlJlQvkCRHvl1cDJMLkJGl
	EMQqlLdlqtZtjawMX0AcxpBQeJsctNxKlYMkshgJEFCcLTXACT5j1MNKhvsmTeS5dkTtsBlnOAc
	97GC/PO8VPqM9Hw90QoKHnfXPs+i9Lrdqa7a6Cri4vuxkAO7mtKGkQMkQGC9muciWr2WpILrJ1Q
	+TpdIu0PAfdA9hGGn4mSL9N4NdlWnXzoogdAJnFQMtQNJQUGvZv8okhdmsXPvIMUvzb9oAQg0bM
	tVlf+TXFWSv2nU25fxgyxWOA1qyeg7F4RN0o3BnNzZwzkdHHjT6zUJd/P+rjzmKfvxdM7GSZxxW
	20wnRCwkcVtVDP7sFytF1uXXJMqKqCphHuwD1C/DO6/aFxz1zvshubatYcvt1qfgkRyC6pj1kB4
	bkMunUeyxfum7o3NIUQZECZjB7l5Xfwz7f5l7YTzKvIMoRKw==
X-Received: by 2002:a05:690c:6d83:b0:798:6ee8:2126 with SMTP id 00721157ae682-798dd7bc412mr125038397b3.56.1773109574960;
        Mon, 09 Mar 2026 19:26:14 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a67348bsm8543127b3.38.2026.03.09.19.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:26:14 -0700 (PDT)
Date: Mon, 9 Mar 2026 19:26:13 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Subject: Re: [PATCH v3 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
Message-ID: <aa+BRWjDfSKqcAET@devvm11784.nha0.facebook.com>
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-3-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309183454.2872967-3-weibunny.kernel@gmail.com>
X-Rspamd-Queue-Id: E67A5244351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	TAGGED_FROM(0.00)[bounces-265864-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:34:50AM -0700, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> The main purpose of this cmd is to be able to associate a
> non-psp-capable device (e.g. veth) with a psp device.
> One use case is if we create a pair of veth/netkit, and assign 1 end
> inside a netns, while leaving the other end within the default netns,
> with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> With this command, we could associate the veth/netkit inside the netns
> with PSP device, so the virtual device could act as PSP-capable device
> to initiate PSP connections, and performs PSP encryption/decryption on
> the real PSP device.
> 
> Signed-off-by: Wei Wang <weibunny@fb.com>

We'll need to follow in your footsteps for TCP devmem + netkit. I wonder
if it is possible to decouple this API from PSP?

I have a hack POC that works similarly to the psp associated dev list
here, but is implicit. It teaches the devmem TX path to allow skbs land
on netkit_xmit() when that nk has been leased a queue from a device that
has the support needed (namely, netmem_tx)... but I expect that if there
is this explicit API, it'll probably be best for devmem to follow suite
instead of the implicit approach.

Best,
Bobby

