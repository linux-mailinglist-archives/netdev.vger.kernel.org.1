Return-Path: <netdev+bounces-271447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKQuBquVw2ncrgQAu9opvQ
	(envelope-from <netdev+bounces-271447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:58:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC2321017
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 292FD3042D62
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83F38B7C3;
	Wed, 25 Mar 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADRnxOma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762F391512
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425500; cv=none; b=ckzx7c4y3d6thtCyg0KqjmtpGaUqQOKu2xCOplFORNWYgLd+kEwiKF3arStnfnevtzrfl/BiJ9iDEX/eO/0W7y/87cWv6uvPh2bzHu5y51nfjj+k1szsH+XXAfejACdaC3smhGTjtCK8FIThAxz4d9IC97YrsmqIFFoBY+bF+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425500; c=relaxed/simple;
	bh=Nhap5OhlbJUhpDgM6+uH8Oq9B9taI42X4+dQ4vkduGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgt+cOSmkbbi7iCi0Rjh9TOSVKWyKSckxX1m+WIn4yA0z+HJJ2VLQKdgXMpjOCcX6vdeQ0lhQobUSwMnVbXhzQ0qNjfX6+ro6q+9dEEFrtaIpwrVQXIsPHzJCmU8W1Gk2OcAeMb9bj3e22ywgaTWMMsNUCM4r3TommSGzeWOFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADRnxOma; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so23741625e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425496; x=1775030296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp3ZUuQmKrx5ida+JuBhp5jYyBoGT9U4aJdscJfGhLY=;
        b=ADRnxOma4KaZIVu7gdekTzo8IeuFtoeqOT78gJndnAJsesAWEuxWtv5hGdXrn6DxDD
         wBrKUh6M9PA8ayfpY5m3BIEVh5wKvPkY1lw2Im93zr0ST9jH3059gUu9dVY6CF9J6DiV
         dBb9rahntY4i1UI6ndBM45UcInJ1Mo0cwAmvrpAKTZtyIJ/izp5Ag2x8XEeG5IKGv8nT
         U2fEmbtyH4W6OqZFl44FVQGnHY8Kkibwpsh8SqNYpHXawAUh5itFTUTprXcQVMpSJUDN
         3TATwestEqL6eesNA+p/8j06oIzUSkEe00/ROgjHFmOmTk3K6JxWobjQQXWkZOXEXaZY
         CQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425496; x=1775030296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp3ZUuQmKrx5ida+JuBhp5jYyBoGT9U4aJdscJfGhLY=;
        b=WxTdMIFebLl41vys3Zj8Z12ODjsEkoOvp8mbe3eTYoDmxDAnUhQqzJUwdyJGhd8PPT
         +YvqdJnJtdy4GJUm+WZYRRB6ZRuuT87SOKcHpzyN8oGemY/mn3cL9zJGzlw+rSXb7L0D
         YsveJoywhjMTcIDyZuVLQYUUfHqilC+VTSvSIdbNQnoP6Uw5MQNKlTw06YKazWdGT0Mn
         23oCFufr/kDOvb4xaeP9X6eFUj1k3HGJwJm247Ng8XrrqbZHbS+Z7YEDl1st8vvfnLy5
         7LQmxpVsprXLSvoZY6zMBIj6NE0/pHMuREU01n8lp3qPmn58lm+MxvbLFY9DQctN6OGt
         T5ew==
X-Gm-Message-State: AOJu0YyqPBT1gucCh4e7/KfzyZw6Vw/sDQt9KFAvr6wFTp1VL6VMoa67
	XoS5Q1XNFUapIQCpwMZe/JvgTrNs4et4p67SWIBe393fLbQJyaAZ1DMP
X-Gm-Gg: ATEYQzySny7IANO/J5PyRqNU8NNPrirjTEWPmI6ggyE1SQvoOXjmcZyQ+5HO8Cj2qhU
	UnWlgrgcjC30G6u2jc41mHS69uLy9zz1WhPeeXi6sHeaLO9OaNQku3fLEYTqw/MDSy4AbyiHGWK
	dhY6ISag+jz3C1PTGQKSyBqBUgc5FQ6CsSFKugozMi+9yEAeUElCcVW9+JeBo0Bq8WjDK0/Z0nL
	wnJF1sEIt1SKnv02ZECvteKT6I/xDTXP/lNve7RsM7yAhtN4r6vtDMliARWM34mU7WzPIrse1wg
	ZlCZPWbT8lt80LGOAgkwytsAFTiU2bAbhnK6zDNz15rehlV68u27pmsjAgIt+EeP1i1kYDxlC77
	v/G4sCGiEc3Hltd24hK3FV7wlfDdYoZS0EtebFfRpa3iwVkJYtSTT8y0Lwj9wjet9GwDIYJdoxm
	+jL0BExQRwvHblBQzwBaaWndjFQ/+EUAVWLDXLVBp1VKCSo0qehJ7SGTExGkEnmw==
X-Received: by 2002:a05:600d:8453:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-48716051e4emr24433745e9.19.1774425495723;
        Wed, 25 Mar 2026 00:58:15 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2f9c.dip0.t-ipconnect.de. [91.46.47.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487172a72b6sm21687395e9.3.2026.03.25.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:58:15 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id D1C4F305DD63; Wed, 25 Mar 2026 08:58:14 +0100 (CET)
Date: Wed, 25 Mar 2026 08:58:14 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] tcp: fix scaled no-shrink rwnd
 quantization slack
Message-ID: <acOVlten_N_5evGX@gandalf.schnuecks.de>
References: <20260324205301.1361608-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324205301.1361608-1-atwellwea@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CABC2321017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Wesley,

On Tue, Mar 24, 2026 at 02:52:58PM -0600, Wesley Atwell wrote:
> Hi,
> 
> This v3 addresses the follow-up review on v2.
> 
> Eric pointed out that 1/3 does not need the added packetdrill comment
> and that 2/3 compared signed free_space against an unsigned
> granularity.
> 
> This revision drops the extra in-file comment from 1/3 and keeps
> the scaled-window granularity in int space in 2/3 so the comparison
> stays type-safe. The overall approach and reproducer remain unchanged
> from v2.
> 
> Simon was right that the original 3/3 only showed the explicit
> rcv_ssthresh-limited ALIGN-up behavior. For v2, 3/3 was replaced with
> an OOO-memory-based reproducer that first grows rcv_ssthresh with
> in-order data and then drives raw backed free_space below
> rcv_ssthresh without advancing rcv_nxt. In the instrumented
> old-behavior run that shaped this test, the critical ACK reached
> free_space=86190, rcv_ssthresh=86286, and still advertised 87040
> (85 << 10). With 2/3 applied, the same ACK stays at 84.
> 
> That follow-up also clarified why the broader 2/3 change is required.
> A narrower variant that preserved the old rcv_ssthresh-limited ALIGN-up
> behavior was not sufficient: earlier ACKs still stored 85 in tp->rcv_wnd,
> and tcp_select_window() later preserved that extra unit because shrinking
> was disallowed. Keeping tp->rcv_wnd representable across the scaled
> no-shrink path is what lets later ACKs settle at the correct
> wire-visible edge.

So, you are saying that 84 defines the "correct
wire-visible edge"?  That's a strong claim.

The test in 3/3 adds OOO packets until the window calculated from
free_space is 84.  But why stop there?  If I added further OOO
packets until the calculated window drops to 83, I can claim, by the
same reasoning, that 83 is the correct value and the initial 84 is
wrong.

In other words, this is a very synthetic scenario that can be steered
to arbitrary values.  As stated in v1, I would really like to see a
packetdrill (or real-world scenario) where the old behavior actually
hurts (after all, this series claims that the current behavior needs
to be fixed).

 
- Simon
-- 
Simon Baatz <gmbnomis@gmail.com>

