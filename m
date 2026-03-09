Return-Path: <netdev+bounces-265695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHhmJ+UTr2nJNQIAu9opvQ
	(envelope-from <netdev+bounces-265695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:39:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB323EB6A
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AB7730F25BC
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA1C349AEA;
	Mon,  9 Mar 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPetDQ0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658FC340A59
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081322; cv=none; b=IDAjbdR1gh4HY9Qz+uE3S/Rt1Xhmx0dychQCFZoZwDcYCbn5Qyiy5ha5uQClJGPno1fFdGy9FLFC0fay3RYayg0giOYysIVWYBxe21iNB74BeeuRDOXiqyJMfMZjVixINCHRSgs6v/QQLimSUZEs2h/QzHFPqPSmG89bLquGIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081322; c=relaxed/simple;
	bh=srg+dxIhiAQAT4kVm4zitW6wSGv/aiVh6j6o8T2Wnnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osg5ppok4uq6A3bPWrE1WRIvJ6DB3jLLCIWQM7RUOfBi68KYVeqKMMfxOLVVZFpRTfb5DShrR0my/d7aerugecpIN0vBGEblN7LpmZQOJGTQEUjlIHRLL7oBbgwen2gm7uFPhTOyYhMvQsooBNmQ5yaXkHzpu+yioBuapNDLcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPetDQ0y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c6fc2910so4160244f8f.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081320; x=1773686120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHSASEtvOfEiBqmxuf7zhZcsqNoilbHkrVseGDfvsXw=;
        b=kPetDQ0y6fBaOc5IIyI/eB4U78IWK7YFrH4bskAlLavqNBSWSmv+zPfRHAx5fE7vn7
         bwH16kkGOJKUeKxtqQNVWzx+gMQKikEf+EHXHlBMtfOWkVtdNisFHJUndOrWB+m52Tbh
         YF1NRGyd5lZX6nVtVsdQDWl/FHr6s4MTQmXm6QznPYNJZQ9cuQjKritvC7CfIGSRvQ2S
         UoX4CM9SIYy7oAtexG3njEUeMyAQLx+ANx+zupdgDi5V1cBKlFfN1oifhqeOpBIDbvdn
         2TqRwFB1FAT89Cs9FWMwvzv17J1Pga4qOYskDm2ZjayvKtsdFRLtDbkD2/2QVTzYoOb/
         ZO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081320; x=1773686120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHSASEtvOfEiBqmxuf7zhZcsqNoilbHkrVseGDfvsXw=;
        b=MVBBYwx3ugPNovho8P7FUJKJr4Jrr1npYViF7UWCkTGVN4IeEhC2kKIKetYfHpqzTM
         LAxNVdFs6dzIZuih2lY+kdcAZ3X0l8DEgpmUfkzbNXSn23OsNPgsA6A9FaQBKKaU6F0q
         vVIhHaLDVP5b0q82EqJGfPc/DJzbuB19qtWPiVQwHVVVxh1xnvxYdcBUf4XjFcQuZKYz
         5ecj+4RuNPOlpDiW8KXY6TRiRU1YXALvY7+X+UlVt0wru+tW/TfTzPIR7EQE+cp43dsn
         DLu6TE9sCDE+iAtqLE9f7f3e2e6m3GMOuhrzgh2XboPfZL3MzdmgqLKQ0+nzQ0hZtwzf
         I3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRDszpIwL1d+e2vImEGxfVD7uKh8ChjNIYN38fgSs94b9Q6Z7eQ+dArf1Ef+fp7JO/RuHpDas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhnxu+savOUfeWX7txOsqJ+22LCd5Ohg3OHfo1LoENnO1MZU/k
	bfwco4+xz+2+Z84+pGaOy+zaE3mAisL2ceXiMsq4z+GOg2AgWdNlJhtN
X-Gm-Gg: ATEYQzxODP9MlwD5MM85hDi41UtwSS7njUD7SDT1HcGBHS6qGCXnASMqHjK3ZDKI/1k
	1PEErUcTVjkh/LM5ja3sWH07g4jx9tZK4N0aAxpmfZVXh0Rh4fje2IkBnhApgsvAFWDTzJwkONa
	bLNbtc1EQuiHKT5n5eIBU2OQfUJHW5jIhD5JEQYF8vVupgNzH+EE8b5ec277vxzqzI2TQNKMt1/
	buJHEr69H8DSsbZQqu3y1gFa3GZ5ZBdmiQOwIWKVeDxBHoPADNlFORHh3RV0kQ9UlrQE+luFk1y
	OOcObVxXd7CNryPNC6IA2n3MC6DrjCrtF216Xx9Du3Sd5IugcYNW0m9acEQ/+YW+FTZQZWI/tfx
	DErAnIEvuz0S1KXJbdDMJRgqqAHXYmb4PPgetzYRiPTm7jcAy6GZ+nEsYFPMWkonRfNnZQRnG1I
	01GwGHIpxtWOiPnz+3Nj1bjgYVwIx5uKL1d8PTZe7z8XPM6NTicvU1tdr8OrW8Jnbl2GBR89YNC
	+OJ5Gk/gHsIEuhgtqA/+/0=
X-Received: by 2002:a05:6000:2285:b0:439:c67d:9fe8 with SMTP id ffacd0b85a97d-439da3526ddmr20856163f8f.22.1773081319621;
        Mon, 09 Mar 2026 11:35:19 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm29257753f8f.0.2026.03.09.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:35:19 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id AB67F30287C9; Mon, 09 Mar 2026 19:35:18 +0100 (CET)
Date: Mon, 9 Mar 2026 19:35:18 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <aa8S5pEbxXIG5oZQ@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
 <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com>
X-Rspamd-Queue-Id: EFFB323EB6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-265695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Eric,

thank you for the quick review.

On Mon, Mar 09, 2026 at 10:22:39AM +0100, Eric Dumazet wrote:
> On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >
> > From: Simon Baatz <gmbnomis@gmail.com>
> >
> > By default, the Linux TCP implementation does not shrink the
> > advertised window (RFC 7323 calls this "window retraction") with the
> > following exceptions:
> >
> > - When an incoming segment cannot be added due to the receive buffer
> >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> >   handling of extreme memory squeeze") a zero window will be
> >   advertised in this case. It turns out that reaching the required
> >   memory pressure is easy when window scaling is in use. In the
> >   simplest case, sending a sufficient number of segments smaller than
> >   the scale factor to a receiver that does not read data is enough.
> >
> > - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
> >   allowing the tcp window to shrink") addressed the "eating memory"
> >   problem by introducing a sysctl knob that allows shrinking the
> >   window before running out of memory.
> >
> > However, RFC 7323 does not only state that shrinking the window is
> > necessary in some cases, it also formulates requirements for TCP
> > implementations when doing so (Section 2.4).
> >
> > This commit addresses the receiver-side requirements: After retracting
> > the window, the peer may have a snd_nxt that lies within a previously
> > advertised window but is now beyond the retracted window. This means
> > that all incoming segments (including pure ACKs) will be rejected
> > until the application happens to read enough data to let the peer's
> > snd_nxt be in window again (which may be never).
> >
> > To comply with RFC 7323, the receiver MUST honor any segment that
> > would have been in window for any ACK sent by the receiver and, when
> > window scaling is in effect, SHOULD track the maximum window sequence
> > number it has advertised. This patch tracks that maximum window
> > sequence number rcv_mwnd_seq throughout the connection and uses it in
> > tcp_sequence() when deciding whether a segment is acceptable.
> >
> > rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
> > tcp_select_window(). If we count tcp_sequence() as fast path, it is
> > read in the fast path. Therefore, rcv_mwnd_seq is put into rcv_wnd's
> > cacheline group.
> >
> > The logic for handling received data in tcp_data_queue() is already
> > sufficient and does not need to be updated.
> >
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> 
> ...
> 
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..c86910d147f2394bf414d7691d8f90ed41c1b0e3 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -293,6 +293,7 @@ static u16 tcp_select_window(struct sock *sk)
> >                 tp->pred_flags = 0;
> >                 tp->rcv_wnd = 0;
> >                 tp->rcv_wup = tp->rcv_nxt;
> > +               tcp_update_max_rcv_wnd_seq(tp);
> 
> Presumably we do not need  tcp_update_max_rcv_wnd_seq() here ?

When we don't update here and are forced to accept a beyond-window
packet because the receive queue is empty, we can reach a state where

 rcv_mwnd_seq < rcv_wup + rcv_wnd == rcv_nxt 

I noticed this case when instrumenting the kernel and got violations
of the invariant rcv_wup + rcv_wnd <= rcv_mwnd_seq.

So, while not strictly needed (tcp_max_receive_window() would still
be 0 as rcv_nxt > rcv_mwnd_seq), I opted to include the call here to
keep rcv_mwnd_seq the actual maximum sequence number at all times.

> 
> Otherwise patch looks good, thanks.

-- 
Simon Baatz <gmbnomis@gmail.com>

