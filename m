Return-Path: <netdev+bounces-261111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K88DYudn2mucwQAu9opvQ
	(envelope-from <netdev+bounces-261111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:10:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1619FBEA
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CA730488D4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9F315D52;
	Thu, 26 Feb 2026 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoRU3j2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EC2D8DC2
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068230; cv=none; b=ndjm/eeAvOrbbzgqfIGLbsp7k9jDOhcAi8dscI+YYwFOE6I1yyGBGxe+mXaiCLeBjrMiZOEti9/RyyzSxsL6j6TTjAWsRw39XrVb8wZHoS727XCKCy7aIFQvC55mjJ/mepmiwH3IDpW3VbAOOg1O7zVPA0DWgP3tJ2018xy1EvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068230; c=relaxed/simple;
	bh=bVKeetAWpDWtNFOjR1cupYE2E+MK02JGDxKWHamheRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBbxwk69SK5KwT9Il5KIvIGSRmVYqb6E+c6eS7Lu3R9jVi6JOsz2PZRuQtSPaqeXUSIV332pi57WUZA48ztH+NivJuOwjmD7BTcU0LDJ4aW126MAJVcjgS7wDlNso4dKbwgqHj4CbLs143wrOHOb0eQ9z8Oj81sVkZHr+vyV5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoRU3j2j; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48379a42f76so2748325e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772068227; x=1772673027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mydpigOQEThp2HKi5IwwcPNGNIjpCFrRJAibYsBFDc=;
        b=OoRU3j2joHuRNxjXiBw9TlLN6FNUwyb4IsMIEixDj8kIjimU3r3Feisx3Kv2RTRK6q
         oxIy4H6cX6ke4fgxcTtUnhu52aDniXmMGPFobYfhoIhE55b1tSsCue/yNThCX7QP4lAH
         TI9ya+iSVvJydbYSFS+IDr3/wl7oHestaCKu9lfHQDyuHo9aAIzuLkf1G2DH7PwumvNm
         SvlFSCWQChDF3obDYf+DBbqyN/gkbCbrHsh1bZi4AJb9elMhnduqqs6h8aOzF9+QyB8K
         u2eJ+9igjwCSEFLQvyKCbbR1mojxJNUCMtpBGdzuK378TtxpLR7RyKBBFa2n+xqmQKFv
         7DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772068227; x=1772673027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mydpigOQEThp2HKi5IwwcPNGNIjpCFrRJAibYsBFDc=;
        b=Lo90YrxHgktQok5H4nJUt5fRxthVhJjC0RLDgkertLOS5Zrxi8+tieZ+RnsBuHHjSk
         Due0b4Xp/v95d7nYVgYOqeVn00/pnv6NjNVFnqOk7f6Ers7wPiapYdpCcef8D+Kh8m65
         TavqB1yhbcnOhRxiGqsVSqYp7SEnvLFBJRkNuN8vDAQUt3xF+VTTILBz2Z0kxdI8DFet
         snyi1nHURTdX0egPJostcE2LjMmMewH21SizTIyFPUGLP5IfaJKNnjNd9n5luN2KjVv6
         nUomjglmVfqwVf7/qMNyXZpyehcpaNyR0XWPMC2J5eFpXa0fjbEZEcm9ViTebbAEymtk
         +Jjg==
X-Forwarded-Encrypted: i=1; AJvYcCUQO6LrZPWebCR+PnXH5e9EIya4s6e8j6QxrdGb+lwKw7NSh5KmdOib9SZgfzmgPhFL6MdYrnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lDLscUiKwHU180FhW+mYR8s4jEmQPwc0EnreYL1dNLnvsTXQ
	F5IdulG5Vq0n1M0inbv9TJBr6Si6a8LnfiuW2Q3mepg1pOMgFuVqHv5q
X-Gm-Gg: ATEYQzxmxkVjlQodRDKLEVAIRmN1iA+B6LzWj1+0ndoywr+N7Xxv4oXDT6St2+8UvW5
	PLA3Zu7UD/lvMlkrpAOxwNbs+CfbRv7JydVXJfO26qxLpkEvX2Cha6qbYtU2LzpElHArupb3tRC
	1SyC+JeHuzjHu8FWHfxmNC3riYhqS7lRQkH41ThqsbKGxNhUqCbbf8fe8/nATxHZ7je+K8Ha4lm
	LYJ9UCqK9iUcoQYqybUuVzNHWpnAd7bV5zy0GeRBnW96Ui5s8xNbANZWvZ6hS5ZykT5exQbQz0g
	cmVJN2cRCKWNq3W5FtgOjmo1BoHSSUfLigQIBFjbXZdjC97G75fwhWVuvf4LUnXrxEh/nob9efX
	fpXv+pE4nAtq9GsYfqdDwBUsa2IFMs0BoB5Bfzzl5i3L4y5UhPnqIsw3nWQ7S8WWLkz2BBkFbKq
	oFo15USCrFbl3V35AMM2cbqxXtzIHcUhBq2Cl6/eh7aXeQsglUcyGFf6Eyo+L0kA==
X-Received: by 2002:a05:600c:621b:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-483c216bdbfmr40257915e9.2.1772068227170;
        Wed, 25 Feb 2026 17:10:27 -0800 (PST)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm57533635e9.3.2026.02.25.17.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 17:10:26 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id E52372FE1F55; Thu, 26 Feb 2026 02:10:25 +0100 (CET)
Date: Thu, 26 Feb 2026 02:10:25 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>,
	Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/4] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <aZ-dgdUFe0a7F6YE@gandalf.schnuecks.de>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
 <20260220-tcp_rfc7323_retract_wnd_rfc-v1-1-904942561479@gmail.com>
 <20260223232636.1ead2b3e@elisabeth>
 <aZ3o8RQehJDK_rcl@gandalf.schnuecks.de>
 <20260225223325.34468327@elisabeth>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225223325.34468327@elisabeth>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CED1619FBEA
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:33:34PM +0100, Stefano Brivio wrote:
> On Tue, 24 Feb 2026 19:07:45 +0100
> Simon Baatz <gmbnomis@gmail.com> wrote:
> 
> > Hi Stefano,
> > 
> > On Mon, Feb 23, 2026 at 11:26:40PM +0100, Stefano Brivio wrote:
> > > Hi Simon,
> > > 
> > > It all makes sense to me at a quick look, I have just some nits and one
> > > more substantial worry, below:
> > > 
> > > On Fri, 20 Feb 2026 00:55:14 +0100
> > > Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > >   
> > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > > 
> > > > By default, the Linux TCP implementation does not shrink the
> > > > advertised window (RFC 7323 calls this "window retraction") with the
> > > > following exceptions:
> > > > 
> > > > - When an incoming segment cannot be added due to the receive buffer
> > > >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> > > >   handling of extreme memory squeeze") a zero window will be
> > > >   advertised in this case. It turns out that reaching the required
> > > >   "memory pressure" is very easy when window scaling is in use. In the
> > > >   simplest case, sending a sufficient number of segments smaller than
> > > >   the scale factor to a receiver that does not read data is enough.
> > > > 
> > > >   Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") this
> > > >   happens much earlier than before, leading to regressions (the test
> > > >   suite of the Valkey project does not pass because of a TCP
> > > >   connection that is no longer bi-directional).  
> > > 
> > > Ouch. By the way, that same commit helped us unveil an issue (at least
> > > in the sense of RFC 9293, 3.8.6) we fixed in passt:
> > > 
> > >   https://passt.top/passt/commit/?id=8d2f8c4d0fb58d6b2011e614bc7d7ff9dab406b3  
> > 
> > This looks concerning: It seems as if just filling the advertised
> > window triggered the out of memory condition(?).
> 
> Right, even if it's not so much a general "out of memory" condition:
> it's just that the socket might simply refuse to queue more data at
> that point (we run out of window space, rather than memory).
> 
> Together with commit e2142825c120 ("net: tcp: send zero-window ACK when
> no memory"), we will even get zero-window updates in that case. Jon
> raised the issue here:
> 
>   https://lore.kernel.org/r/20240406182107.261472-3-jmaloy@redhat.com/
> 
> but it was not really fixed. Anyway:

Didn't that result in 8c670bdfa58e ("tcp: correct handling of extreme
memory squeeze")?

> [...] 

-- 
Simon Baatz <gmbnomis@gmail.com>

