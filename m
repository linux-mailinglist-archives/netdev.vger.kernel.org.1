Return-Path: <netdev+bounces-277127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDZ3JjwZ2GkfXggAu9opvQ
	(envelope-from <netdev+bounces-277127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB63CFEB9
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02898302FA96
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB93793DA;
	Thu,  9 Apr 2026 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byAtKDMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000337A498
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769853; cv=none; b=UUFRm5S84a83OH2oafw4XAmaA5nGXu/Ho/uh9cqDrFxZqRBtqqxDLDl0ZIQ9eXyWYpkNpp+/+KtUUtS2MhMv3/BMA6GWlLlaBGcuPmrLSg4e+uwbAMssYpKNRJt+mmWdWBaEvkkrcZLgDYEIBUkUue+qIYIMZRQtgPI/TCuwOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769853; c=relaxed/simple;
	bh=tXHJjxhY7a1ukas0jJN0XXs4Hv2oxV3jM5h+edfD8I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdQPL9Z136fLRCDQ86LX2SE+Nne2+H/VGMUWMFAwblyJfD6o2JtDEWYct8vgTkBZbQ2X8OTU0UQ53+DPw3hVsdrhLoxFwXO0h5OOUKcEghPUZxsFqQrGzyjTk/zILp9TL/drTYVy7l5zmhrZCgvLiDisMLOqUTSLCUeeBWMu4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byAtKDMD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so8710795e9.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775769850; x=1776374650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFcOyXKSDdWJDWwV3kR5HIHMwA3CpjaVRFCSqyqSd88=;
        b=byAtKDMDj3zGj1I2w267dEeJC3KdV3bAL3TLzavY0VnngFPn+wxkqU84ZytWyQMxb6
         dP/ATmmD6057DvYtIs9F2zfrl9/dk3BQdATi720rjyidrePgYrDGweoRT82UQGxIZApB
         v/2tJbab2EwA73PVqzkWkkauklGg1RvqLh9KzZ7sl+EkLuV4OarGtA/HocBZQtFPL6Z8
         7H8ypW7IG3OyHAM8fSWilcIoz6pd9iDNDfrpiSimtvKEJb61ftW+tfhI2cC5850a8T0s
         Ocw74sdgZ5NkSQdBCj5mqu9p4BdUa1RV6/GYoR9Pes4REk8+2Vysy35yRwQw2op7As4n
         p/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775769850; x=1776374650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFcOyXKSDdWJDWwV3kR5HIHMwA3CpjaVRFCSqyqSd88=;
        b=SXyPq3jTsVFV1FX7ZxDT/cmYvVvUMX72u+uRAP/tzjdNGOlLUf2uEpHYQx8dA7ftAd
         z4v+RCTmeW7YNcaw9OnD5+3/K5DComCvaQqsTvrd0KvVNiQ3Pvpzm2YMejyoihFcnwGD
         daroTG3nXXlVTXcSHTLYJNHR+Nanx0EVnGpvmED8LG0o8WqdyPbNZbCcHnKtXpxLb0qx
         02Urf7/np2EAvp74fdUXq7ku9BvR3Miamq2gBhSwy4WlxoRkwnXDR516VfNbupaEvwUe
         t6mcMPtCOFXPdUcLl9cnuoLxTd+/zsw9piW1SDS0vsL8BSJzYINO/0GRexgX0/Fha3Nj
         hJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3GzX8gEXZnItEibqiQj9TFmOQ/syUaTyqTtFSFM7UqH/IHcmcD8MCHYZMNaSH5y9kI9Tpsac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmOC6f3wWACI19agrtgNXAjx5PQ6bK0UVHq0bzMXUDDdmde9N
	ztpyUc/IGwtRXNR74WhWDn1rUGKAlea73ZFqTonGH6YgEwLE9JkjBIhm
X-Gm-Gg: AeBDievWFFNZezhwSBlo9ESGJQTW72k25OQga/sTJx1+s1n5aH0KDqsuXLrw/PNNp2j
	pdmTZ5cmFFGlvxuTxuyuVg55uAh5AVLWPO3xSWB7gMr2HljR+xqAlKswdRqwApc+qR373uZJepv
	67TrSUeKyARU9727Vasu0vSXHjHWlDD5/vOjyKdbsqeuod/1JZkfsG5CakQj9E8NWPt/pGcR2BP
	7P/yYIZSQnGsiybN32lAA+uf2UnNaq20WsthH809Qu1/PMFFc17Zo0cb87FPiT5zxmLjv3f5lSF
	EgJvjcAEqmMSteB45lLYJUx2v6uMXEhS2kud7ORX/Y2MqaEyFbeXL9fs2+XzEJbetuMVt9uaZI1
	1bae7S7eYPsCXeP58t7g0f1y7bVoAtH1NJGfMvSQzFPQM3B1i0JZvHD0XZ/8g+qKt+2K120ebXO
	RY6krGdoE2XDnQj7rBx8ByRPkF8cLjucN0rf1g/WaL0DlpPe8DqfvCs19jakG5CQ==
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-488d6808507mr4911535e9.3.1775769850332;
        Thu, 09 Apr 2026 14:24:10 -0700 (PDT)
Received: from gandalf.schnuecks.de (p54a24f39.dip0.t-ipconnect.de. [84.162.79.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a8438sm20720405e9.5.2026.04.09.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 14:24:09 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 2C4403093748; Thu, 09 Apr 2026 23:24:09 +0200 (CEST)
Date: Thu, 9 Apr 2026 23:24:09 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] tcp: restrict rcv_wnd and window_clamp to
 representable window
Message-ID: <adgY-Yn6-OophYXb@gandalf.schnuecks.de>
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
 <CANn89iJO5DTWeVVfMYh7y3e9Npsu+FQ_a=W9ZqbMtb_wLeBL7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJO5DTWeVVfMYh7y3e9Npsu+FQ_a=W9ZqbMtb_wLeBL7A@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06BB63CFEB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

On Thu, Apr 09, 2026 at 07:52:03AM -0700, Eric Dumazet wrote:
> On Wed, Apr 8, 2026 at 2:50???PM Simon Baatz via B4 Relay
> <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >
> > Hi,
> >
> > this series ensures that rcv_wnd and window_clamp do not exceed the
> > maximum window size representable for the connection's window scale
> > factor.
> >
> > This is most visible when TCP window scaling is not used for a
> > connection. In that case, the advertised window is limited to 65535
> > bytes, but rcv_wnd or window_clamp can still grow beyond 65535 when
> > large receive buffers are used. The resulting mismatch breaks
> > calculations that depend on the advertised window, such as the ACK
> > decision in __tcp_ack_snd_check(), and can prevent immediate ACKs.
> >
> > Similar effects may also occur when window scaling is in use, e.g. if
> > the application dynamically adjusts SO_RCVBUF in unusual ways or when
> > the rmem sysctl parameters change during a connection???s lifetime.
> >
> > Summary:
> >
> > - Patch 1 keeps rcv_wnd capped by the (window scale-limited)
> >   window_clamp at connection start.
> > - Patch 3 and 6 ensure that window_clamp is limited to the
> >   representable window when it is updated.
> > - The other patches add packetdrill tests to verify the new behavior.
> >
> > A simple iperf test on a virtme-ng VM (Intel i5-7500, 4 cores,
> > loopback) shows a noticeable improvement with window scaling disabled:
> 
> Explain why we should spend time reviewing patches trying to help
> stacks from 2 decades ago,
> risking breaking other usages.
> 
> Almost every time we change the rcvbuf logic, we introduce bugs.

As soon as someone gives me access to a link with a bandwidth delay
product of probably > 500 MB I am happy to provide another set of
benchmarks results:

`./defaults.sh
sysctl -q net.ipv4.tcp_rmem="4096 2147483647 2147483647"`

    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
   +0 bind(3, ..., ...) = 0
   +0 listen(3, 1) = 0

   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 14>
   +0 < . 1:1(0) ack 1 win 32792

   +0 accept(3, ..., ...) = 4

   +0 getsockopt(4, IPPROTO_TCP, 10, [1073725440], [4]) = 0
   +0 < P. 1:65001(65000) ack 1 win 32792
   +0 > . 1:1(0) ack 65001 win 65535
   +0 < P. 65001:130001(65000) ack 1 win 32792
   +0 > . 1:1(0) ack 130001 win 65535
   +0 < P. 130001:195001(65000) ack 1 win 32792
   +0 > . 1:1(0) ack 195001 win 65535
   +0 < P. 195001:260001(65000) ack 1 win 32792
   +0 > . 1:1(0) ack 260001 win 65535
   +0 < P. 260001:325001(65000) ack 1 win 32792
   +0 > . 1:1(0) ack 325001 win 65535
   +0 < P. 325001:390001(65000) ack 1 win 32792
   +0 > . 1:1(0) ack 390001 win 65535
   +0 getsockopt(4, IPPROTO_TCP, 10, [2113929215], [4]) = 0
+.1 %{ assert tcpi_rcv_wnd <= 1073725440, tcpi_rcv_wnd }%

Fails with:

 AssertionError: 1074511872

on a current kernel.
 
So, I think we should spend time reviewing this because currently we
just pretend to clamp the window at its limits.
 
> Not using window scaling in 2026 and expecting "iperf improvement" is
> quite something!

I wondered if providing these numbers was a good idea and apparently
it wasn't.  I just found the difference to be striking.  The only
thing I wanted to demonstrate is that basing our calculations on
bogus window sizes can have real effects.

> Out of curiosity, which legacy product is stuck in the 20th century?

I have half a dozen of these products "stuck in the 20th century" at
home.  They are called IoT devices and I find saying that TCP
connections to such devices need not to have proper sequence number
acceptability tests according to RFC 9293 quite something.  ;-)

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

