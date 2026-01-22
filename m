Return-Path: <netdev+bounces-252194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DssKn2icWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:07:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61134619A9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DAA44E4DA1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFF3D1CDD;
	Thu, 22 Jan 2026 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIJdpQ1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD803933E4
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054835; cv=none; b=lvgCnV+tYHUq1c8Z/thRtetKD/4dSqs7keGOxLVH5msyj2yuTPZNgqVpfo/isocfnsdSw6Zae0FHJvLWVVgHrCJmxBzfOeQmDxgY6Ba+2Fnsz8tFrME3RxZm6iP3rMLzgzatqmMNHTATQoA1+bcdo0TMY0wD//f9F8jXdSPsLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054835; c=relaxed/simple;
	bh=pYKf1JAAXvqM1KiJ39QNevMy+s2lzOXg1IsZoMG4W3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nag/oEQ039lT21ch9EQad6a4cBnBCVNBUWbg1xtAOM+TVa1ft/up+UmA2QyhZ9JgqYrZKDWXhmlf0qXb2lvKG1XiQNoGAs3Jx2yhT1Jf3BSTZ0f6bkee5jGJ6bC/4WvIDb4HqZK+IWkzqTyFs+xsGNBZFdwpax/SPakaGE31bQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIJdpQ1H; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b729f4c154so452024eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769054833; x=1769659633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWpthCYRiRQKWxKiKOdwOg0cgTv3VLuSBcM5vN1ez5c=;
        b=nIJdpQ1HF5vVCJ/YALlYlinRUiJBT/d+3Ojtex3XwZyGc1S5kV3cZPZs085FKiIa0r
         JwVWCrn5xu9b+vBrsTrwm0UTdEGtqj5P2xoV4X/PkEjS+/oH1bMGPfqbygJFud+4y2MN
         ye4jGeSbTRW7U/RcTBdik5jOzL0hTGbcz38HiTVcmCdzYohGnGU9pFV2qRsovMkQsgl0
         KCE46IQpEdCe9bzN91tTVFUuj5q5kqbXA0cHMIKgeup33xOSYVcKwIe+qWJEq2ejHBIN
         jM8V3SGgTA1CdG+pV9ymNc0DcYE00txsmc0hCB4VF/lTiuyo1nTUstdhgN57g8nOGJqY
         qwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769054833; x=1769659633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWpthCYRiRQKWxKiKOdwOg0cgTv3VLuSBcM5vN1ez5c=;
        b=DyMwL4quUoiLUgfptTE+136wgb8xuCNOq7HmUERuHHUd/loDo+ItXssrWCqP9qjPEC
         mxkyWADWrq4ICBs6jUY4gDu3JI5yeBEYkAYOEVk1JDDeOjazDltdFhWv/SvPgVRcrRKH
         uoMe7nOFVWBCcQEXq6EA0PulK0zrlZQz5tHpvWQBanXlGKy8bCgvR/9nPxkIUqxZhnhR
         l0ECrl1j4/0z2R1CX0Vx+x7Xm+xo2XFsjK/ZCekEGwTL2AyFKd1W+ptSN3sHqIxk4oIA
         AMjHnGM6G9veYWsRrUjczxzuDgIhnpFdN6GyAw4y9wNh1GcxDuvrq6dJF/GG/Rzt5ZPH
         eW+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/drtACTB4Y6OkexgsfDcAt2MtQ+pJF5BV8k6arWBaO+aOImBuDv+bVvu+1AtjznJ1Ngm3MBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7GQnxXqFhaokvzZaDwOuTYYRcE1fohRcOTiW16OJEwoWIZ0Q
	vLm+Y1G7zyRACd0BTz8Lo4mJznEnsMejLRX51fpIkHc4CILRpYAZ4fQ=
X-Gm-Gg: AZuq6aLFpZbgWocYCMjgZW5ZuyVJDGZvzE1vwE6cmaTOkFez61NEcYTr1xespc6kRXE
	XLibUwkwhznNSLQPxXiSd+P4qL2pDP5dWUUBqcxg3i/9OyuiinB3CH9RAgL/V79TIxtDv8vKXXA
	lZtkOFxbHj4ximh59PkTaj8fJxKmzEi4e1jfSEF5958rj6mDjJMwoEpsRUoRL0MPiewaiF5eeju
	y84BxisE50tTf5b6y1ilAGQ+BImm+mHOSHavQygsDWjVCInn8Hhh9UaANdHemE59MBXP85dXkrX
	xjeOFTexlEudRSYWQFV22Q0s9ZiJ8YfWkDqJV44uvvGLrG190QucS4feeU7c5Zmsqs8BbD7fBu9
	iCG4Z/X0+1qysJDIvcam1Sn/NtHBC/8uqCDt4DymL9dddIXipDu2RN49qxHs5ej2/oyp0VuDlDb
	AFQ0ru5QRrOpMqeQK+S5f7/P4/c2rq/NRzGbVFAQuEtpKIqyCN8Fu7BA3HwwV9TDT3IaS/6j2kF
	HVEtg==
X-Received: by 2002:a05:7300:a583:b0:2b7:1744:725e with SMTP id 5a478bee46e88-2b7174476e8mr1771856eec.0.1769054832652;
        Wed, 21 Jan 2026 20:07:12 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm24054451eec.3.2026.01.21.20.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 20:07:12 -0800 (PST)
Date: Wed, 21 Jan 2026 20:07:11 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
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
Message-ID: <aXGib0OcNdHTLyZN@mini-arch>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org>
 <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
 <20260121173512.748e2155@kernel.org>
 <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
 <20260121185021.446b00e8@kernel.org>
 <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
 <20260121194615.33dc0812@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121194615.33dc0812@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,fomichev.me,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 61134619A9
X-Rspamd-Action: no action

On 01/21, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 19:25:27 -0800 Bobby Eshleman wrote:
> > > > That is correct, neither is true. If the two sockets share a binding the
> > > > kernel doesn't care which socket received the token or which one
> > > > returned it. No token <> socket association. There is no
> > > > queued-but-not-read race either. If any tokens are not returned, as long
> > > > as all of the binding references are eventually released and all sockets
> > > > that used the binding are closed, then all references will be accounted
> > > > for and everything cleaned up.  
> > >
> > > Naming is hard, but I wonder whether the whole feature wouldn't be
> > > better referred to as something to do with global token accounting
> > > / management? AUTORELEASE makes sense but seems like focusing on one
> > > particular side effect.  
> > 
> > Good point. The only real use case for autorelease=on is for backwards
> > compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
> > or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?
> 
> Hm. Maybe let's return to naming once we have consensus on the uAPI.
> 
> Does everyone think that pushing this via TCP socket opts still makes
> sense, even tho in practice the TCP socket is just how we find the
> binding?

I'm not a fan of the existing cmsg scheme, but we already have userspace
using it, so getting more performance out of it seems like an easy win?

