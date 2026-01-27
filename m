Return-Path: <netdev+bounces-253690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDj2CAs2eGl+owEAu9opvQ
	(envelope-from <netdev+bounces-253690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:50:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3983F8FBCC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FC923007B23
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE246314B65;
	Tue, 27 Jan 2026 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlHmRwF5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA2314A89
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485829; cv=none; b=QKiWGTQFI7+gqVkgfgKDFKP3xkxIhTz3ZGkkb6JvUGu7ypa5uBRz3N/FILcrKnxaO0PDaFehe/bRZv+iz+KgptlAU8CvDKlSski1GtOy2OXcbL7rUnzfsokxtzgnIYcQa1YhrcTyVY2jXUdasVk03W7FoemVZ2NJm1pG+baF84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485829; c=relaxed/simple;
	bh=XFau8Jrxlk4LXIMH1Jv2O6G95Tj0q5XrMIWKxPxgJns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmXeR9EH4wpNPn4jSrlTQtKfW6B8VD21TXNu48jt9Xk7fAmBSf4dQVl2bqEzyRppZQygQ3DquFyPnD/t25BBZWUFgsI6ywZQQQeoBki9LtOnpwUUY47ce1B2Rj8Vf2lg/KU5Tb4++4YdgxClJCHdK/UCBBxQOBguF4450Jpk+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlHmRwF5; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-793fdbb8d3aso46136977b3.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769485827; x=1770090627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wIYgb+a7uSPkKcjbr0/XF3iL0gwOJMcDzBmEVqlYIw=;
        b=OlHmRwF5N2BKtQa6utkLg9IHGGN7ZPMa2V/Pc+0f8qpSSBM9BGLykGo6u/U6L4Y7vH
         GomVPA76dxPIlicZsiR7ReiF4N6UtZmem+77uxvrvM6MtI/p3ck1TH504E2+mL4qiLP2
         XlJEqFvtAktkva4UZZ8lyJHf60oC2+aTDUXR1/PmtvqxW0wchMpspvqVRXDUy40V94cb
         r3O7TfAq0pab4BTENotmBSBVo5jP6KHv4n15utCs8HFRL3XkUPU3Ga6rDRlEW7iS4i6W
         +KSDsgMkBCzWNHJxlcoUk+IXsB/GL3sBjMy6+PwODHHaOWzag0tz7zpGn+xU0l9pMsyn
         PxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769485827; x=1770090627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wIYgb+a7uSPkKcjbr0/XF3iL0gwOJMcDzBmEVqlYIw=;
        b=vwdH+qL8lD4BW86mTXw08X7Io/61OXnS7rsZgkcWfbErw12EzAjMEH883is4jcJDXx
         yleFP8PNL+4P0fpzM0uc3NNGveAGovZ65gs1d36XvQGD60LMhf2Lm7lAMob0qmNpoTOF
         mS169R3oBuX/EcI1B1g4QGqzGxsm2qIK40+vsiBf7eJtuvJdBLWibCoZfObiTL1WLDxw
         5cxjSw5mwZKFq8YM0ssRxzYQQvrnQxiK48Xjt6tPcDNRSmQBTqou0jfuLwa7uoH642qz
         u3Pa1mkoGoqJxLlCPoEBQAirpmumEaHd27mKgI4Nbfc+BaSE9yKQFsS4xqorhedWkTsJ
         vvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT5D8gnJgfT92oxzyK/n5OgaWHVsv+Mu62KyQ9kP6DGT4F6g6jZrGAO0H0uVMcLRVb2/ArrVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIbahF2LsPzKnLneXoBS3tdT+npClrbY2MSp1eUubv4rWkVek
	t6uoc50mcG7yLg0+jugktTnH1vCIl90RryVmx0h9Xz4e5mJdVWMFMTwJ
X-Gm-Gg: AZuq6aICXQAc8h7gEzjrax1vXS7EQsFNnnS3O057x15JbATRitmEJpc2hNb+Ibl0yOF
	3q/wsh1CMvWKpJQg7u6Z0FCrowaMIl3EzZFn/kW7gheNAxRsMWxNEUm36mN9yD9xXerWV2s7Ic2
	x92hPzyrpVFCWGoiLebtboLFiZ6BFKV0E8ry3ImFRRQkKyHbxO2mpz+Vr/hWPqzMkqyO/MUgeYO
	4LXZi4/0Uu26HE4TSc4byGW2t0zMnFiS2ei/3M9P1DM3xisLPtxih5zdHVckZXjkzKQ2t1AJd6T
	em0WTkllx4FaHte6IdzYNeUh5mUfxj3fhRxXKhU+8x2UYhAINiUjNbcp1CFJON2nzWbWv+52GHn
	Rp29pkvRPoRsXMY3VsxfwGnFezH6F1GUsFtuQKwXA/jB77PRw8giecpyFeKZc6NLYhO+LyFngxZ
	d846BjYChhQOICwBBcFlxED3efovqCAKnci+oZiaaFDidH0w==
X-Received: by 2002:a05:690c:88b:b0:78f:b0d0:bd71 with SMTP id 00721157ae682-7947aca9140mr2169367b3.62.1769485827182;
        Mon, 26 Jan 2026 19:50:27 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a2cf6sm56637077b3.33.2026.01.26.19.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:50:26 -0800 (PST)
Date: Mon, 26 Jan 2026 19:50:25 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
Message-ID: <aXg2AQMMk3obScYD@devvm11784.nha0.facebook.com>
References: <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
 <20260121185021.446b00e8@kernel.org>
 <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
 <20260121194615.33dc0812@kernel.org>
 <aXGib0OcNdHTLyZN@mini-arch>
 <20260126172646.2e5af2d4@kernel.org>
 <aXgjVb5PVqdPM10J@devvm11784.nha0.facebook.com>
 <20260126184440.755a55b2@kernel.org>
 <aXgryaSx9CzFR7kv@devvm11784.nha0.facebook.com>
 <20260126194359.461f908b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126194359.461f908b@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,fomichev.me,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3983F8FBCC
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 07:43:59PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 19:06:49 -0800 Bobby Eshleman wrote:
> > > > Then, if the dmabuf count encoding space is exhausted, the socket would
> > > > have to wait until the user returns all of the tokens from one of the
> > > > dmabufs and frees the ID (or err out is another option).
> > > > 
> > > > This wouldn't change adding a field to the socket, we'd have to add one
> > > > or two more for allocating the dmabuf ID and fetching the dmabuf with
> > > > it. But it does fix the single binding thing.  
> > > 
> > > I think the bigger problem (than space exhaustion) is that we'd also
> > > have some understanding of permissions. If an application guesses 
> > > the binding ID of another app it can mess up its buffers. ENOBUENO..  
> > 
> > I was thinking it would be per-socket, effectively:
> > 
> > sk->sk_devmem_info.bindings[binding_id_from_token(token)]
> > 
> > So sockets could only access those that they have already recv'd on.
> 
> Ah, missed that the array would be per socket. I guess it'd have to be
> reusing the token xarray otherwise we're taking up even more space in
> the socket struct? Dunno.

Yeah, unless we just want to break this all off into a malloc'd struct
we point to... or put into tcp_sock (not sure if either addresses the
unappealing bit of adding to struct sock)?

