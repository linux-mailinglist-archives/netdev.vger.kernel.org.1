Return-Path: <netdev+bounces-259512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO93ILM4l2l2vwIAu9opvQ
	(envelope-from <netdev+bounces-259512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:22:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC71609B9
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1219300E387
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84934B1AC;
	Thu, 19 Feb 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka79Ke0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A6348469
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518101; cv=none; b=GitqUsIMkm/YeIuLXXiwDnUv7zjtlMNC2Tn5X7XJb9oDnRFVeFCjuW/21zRE52b2JGKSsKQ4OQ9YUCJoaTRTgZ5+lx9VbYPCQCMzKXwaCTZpNN9uYIc8mzyiSOZSdzjYzpsZj/s2EUyBFT9q3U3DTYsQj5HItVdjgcqyJdqrHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518101; c=relaxed/simple;
	bh=495kOlwnrMTCkuFmO40akfaFo9M+9mcvTROvYleSjDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP/YEgVXqLrkgWc5IrpPypo/x1PelZoL6tDk6a+grtN4INTHW8b/GsBYNh51nGYajKr8CM2HEUCxLwOj8DTZk05eE8M9AeHuV5V6ocOfkeFuDVKsfXTsddn0tzhP+w/HNiZWCWACf/LPDE6XOhVWio35Q+rn7++OFob7hrOjLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka79Ke0Q; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7980ca83937so4750247b3.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518099; x=1772122899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yMbxlGezH4sa14/TBr2ZfFYSUw/HBsY8h6kQEV8fEQ=;
        b=ka79Ke0Q22mX7wYxaHB+HoCdoTPbbspZC/cvY/P6LTt9fVvBRz+w8iyWmptYdEehz4
         ycCEOs/QisBD5yIDdludlT0Ofx3GtnOzpYCsJABjgXx83qi2St+UvS45Cfvn/zBH5dPw
         3nRamUxQMRvhPNQeZIDURs1BkR5jK6OgKGmL2JZJrAoJH7mnsITIxyGTULpHLs39aejP
         1LoTpRLzCHOi5WCAZyEKQrr2Fm7UctcvV7kCH+MYTs8KN5PujHBdDqqx9l342fqCsDKp
         X98CXWukDhid1i4LNz4bEQw/rCrg/jkMU2YAPlX2cKsuHuQToPua22WgD8fzP3I05nNq
         +LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518099; x=1772122899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yMbxlGezH4sa14/TBr2ZfFYSUw/HBsY8h6kQEV8fEQ=;
        b=LZRogv1enw8Th4r7hh17IyrgzSEMboiN3ZUMq/9VZUHXvETAFlgUzE79fUaULfaa3V
         peePiq4eJU6jdxYfZWy4ihqw8DZ0KjzdrvuAapED4IqZg5qCl/r4e/pCcWPN4iq6TRwO
         UxG4g+LLmk3mPhHiqVZugE77jufOYlWKG9uXAb6cLGD5SE87hKi4gBbU+I8D7yu90riC
         8pH/h4GDy9oHU1zCD8OuEZt35v2duUSX9lLi117uYpaaIf34ZmNuosrYmLOAnoeDoaBn
         DVPdYxNsWs2j2VLPS3ggCuheqXQFqYM9kzoxc/vbQsXHxUc7qVTABYHv0lKvyiMgjuPr
         rlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYyd560jUNxEFaZhqYBIDlfSYLaLigpEaI7uEGxRDW8QNcO4mYdVnYAAKOQOgpR1SOQYIi9Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCWVkLObYOuzHoPY6xqwdq3j9296aG5EZr+GQGN56dMzFuuvw
	jmZbsFAAfPjA7XAWOsSk1UVF4aSttc+jYOQh2yHGZChKWadugITFmRFR
X-Gm-Gg: AZuq6aJNWeaAFCKqdB0giuEb7+Rq5sOBUhLrEe6jvClzBoMiVn5jK70ijUZy3/1bKDm
	FvrVVT5wcZ2AhyQg9YI1/ZiLlWy8NewwB/O+lUlKmAstPB24xaQhLcMhxlOpwa+QyHI3h63XSp3
	HqPMpOUnWRffWvJwp+QGOh8wkNyfZaPORoJYh0lN3smniSW4+f/JZihi81kK5EFY8WlaLge4wEh
	xIE/sCO+9IchayYfk9Va5EkmDUHhFAK00H1Jn6dZfGQAopCySjVq4D7Qi6kvunRkkWuYxS0Jj7S
	PKBUXn2OMemh0Xcs4cG0YTHrg+kWfBKXSNM5DUZj/1IMz+rsuVPWdAtaugSPm8HM5NP1US2VDZx
	LLuUjzdjUa2bJZakvQflqrsP09t7Rab/4KNrynmzZ/pQqGjidH0I+Rm3D0g3fSNqC4Ccsqsw/uv
	0bA0AqifXD4tmgYJ7KaZFh5xb1kSUaiy90UL5tzQVc3Pyhtpc=
X-Received: by 2002:a05:690e:4091:b0:64a:cff3:8f3c with SMTP id 956f58d0204a3-64c556e0056mr4348350d50.91.1771518098772;
        Thu, 19 Feb 2026 08:21:38 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f651sm7284854d50.5.2026.02.19.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:21:38 -0800 (PST)
Date: Thu, 19 Feb 2026 08:21:37 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net] vsock: lock down child_ns_mode as write-once
Message-ID: <aZc4kUOikmKKCdhw@devvm11784.nha0.facebook.com>
References: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
 <aZV6HRAIsf_rNRM2@sgarzare-redhat>
 <aZWUmbiH11Eh3Y4v@sgarzare-redhat>
 <aZXlqv5ukWymz/NI@devvm11784.nha0.facebook.com>
 <20260218164119.72368d53@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218164119.72368d53@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259512-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,meta.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm11784.nha0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAFC71609B9
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:41:19PM -0800, Jakub Kicinski wrote:
> On Wed, 18 Feb 2026 08:15:38 -0800 Bobby Eshleman wrote:
> > > > I'm not sure what the policy is in netdev, but I would prefer to have
> > > > selftest changes in another patch (I think earlier in the series so as
> > > > not to break the bisection), in order to simplify backporting (e.g. in
> > > > CentOS Stream, to keep the backport small, I didn't backport the dozens
> > > > of patches for selftest that we did previously).  
> > 
> > Sounds good! I wasn't sure if breakage so tightly coupled should be in
> > the same patch or not, I'm happy to split it up to ease backporting.
> 
> FWIW the netdev recommendation is indeed to split the selftests out.
> Also to bungle selftest patches with the fix into one series targeting
> net, even tho the selftests patches won't have a Fixes tag.

Duly noted, thanks.

-Bobby

