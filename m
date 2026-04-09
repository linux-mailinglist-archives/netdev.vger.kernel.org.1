Return-Path: <netdev+bounces-277128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DgeCwoa2GmSXggAu9opvQ
	(envelope-from <netdev+bounces-277128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:28:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60E3CFF26
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4C993019D51
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7737997E;
	Thu,  9 Apr 2026 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klZcLxvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FF377034
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775770119; cv=pass; b=LQWEB77vHV+Y/3VpoJmUow8jcDZ1Zd9DNOx6nW6uPmSYosRvShhTpsWOn+RW5ouTvuOUOjbSCGLEpZWeYt6hqBB/zDAGzJ1r5KX7+C2XgKJpDo/a95S9bQyABCXcaDsF8IlqNy+Y1yVFjQUEgqpRHYMmv+zI+hYhpXEh9NxvQtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775770119; c=relaxed/simple;
	bh=RaYJEZzanC61uoOdMaO3XMpqg4i/JlSZVat02vaqKxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D26Gj+2EoFK5ZmBGQvFqo8CyXsF+zmXR93TqU/dSXZEk8xxk0W7gn2vBjtqpURxc02EWNHxsm8K76Je2sKQ5AWKpOK7aai9GOwxYtqmzujJ/d3ITccC4vcmG1oWYs2FA+rI/einP5kiWJReID+GJHhvjIz+B2z+OKc4jmX8s7bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klZcLxvC; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-797ab169454so17724797b3.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775770117; cv=none;
        d=google.com; s=arc-20240605;
        b=LJUzPZmbHSfxf3AZtlkQQBI1sOXDZHUWZoQF/WrJr6r7xnPsV19s5TLkop4KrIc3Ms
         BXIhXQuHNK2azUmxfUQ60s+/XZ/6rghlOtOejJJMmrmHAnAR8QEMeJ05dK11IdRNUvKD
         hJkSzQgclx9kmF7Ryw4vWLnCyT5APx2ib+VOY3GK1KDp4dSe5rHVoeGYs0FR+Bu4Ienl
         RnPXCtNDXb8Ec3fDQ3VqyZo+P10R2OCCXIu9WSL5YRlwtQ5jZc89056rHXfBhFh7Z16d
         COKnOXsH2Heqvi9C1MmULPiP5ohrDl7CJg1mBiUZE6vMXdIFLbWArgghugiLTcm1+H0i
         eOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EYWprL2m9ZZ8ZynKxJB4VDW07R2WJhXHCUG9VenkIc0=;
        fh=0D5eH4l+iRPlbvCDvu2/u9ReNb8x6HC90GzmuoKNNYY=;
        b=cUlccfoRJBTyGZ/TWxMQ+stImZvNwMSc6Z8DahmcPK0CwnRby+KLVFT4iYhwFkdips
         nq88+EFIpj9MJE1uREEV+M8v+glPALa4iUjXdOI95KEYbWDWsoPIW0cNOJXhwW4K1WUU
         Y/eQ+wAHVftPMx3QbA1x6fAbecSBmNjmfWYtPIExzCWhclOm9RvhMg/tLqW3uZXDhASF
         IGrDChlVM4/xSGxIZt3m9Mw5dCJ5EsOvIRplnob8e8Yyi342WcYZtk0TEP449Db07VsP
         hbfdM4nNHa0+phQVDYgcmE9xy2GcMPA9mFGcGMqqiwLd9vvvDg/OaLGImyHLvTTk1fKc
         Ux+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775770117; x=1776374917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYWprL2m9ZZ8ZynKxJB4VDW07R2WJhXHCUG9VenkIc0=;
        b=klZcLxvCZaQDtIo71ESj0mRBvuPBe1u6K9WM5+/DHkWeYIEH2chl1MrflMG36QRCkU
         2IZNt3HMt3mHvc735eamSrIzllZkKhaSUajDOinZtjCBNLFlxMjUZ4/707gk10uRtBXv
         skq/69Jqvizf4/lLpWRYUS0VwL6yMkBIoXWq13Ws2GImaLOKOkvuAvXZNf80pLRze+JU
         cD/zH3CyEP6twLecjmojipSVRPwjDzVc+ljyzhKHRzTTgw14Qb1wbM6smzcwAd7yJ0ld
         2SGZt87DJ26iaq8UHND0eXkXJIygoFeITs+VQNvLLZqizytMbuZkYEYPFvbzm7UkZhbl
         hP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775770117; x=1776374917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYWprL2m9ZZ8ZynKxJB4VDW07R2WJhXHCUG9VenkIc0=;
        b=hoJOXycMBT6kHQeDnUSKi+7pdDjZ1Z5RRTm8GX201qjcYhGA3wZCBC/RYJW6Jb1KvQ
         kbRitSIx1K3gHL3TQvFs8Bvp0evxkLx/yJbUEqtI+J8MDmBRG+k9ioxUjEEhxIl5+fZ9
         5mlBlHy9w9ksTxpEzNPxCrpkLbQf7Lb90JvHXB4tpCM+PvSKEJ7ubZumKuCFq+c5U9QM
         JokfkkvU86Umjd3seB9lStmuIFZJZkAa0A+kkGExZldXRo649yo4zNXhF+Ig9VwuA11S
         MikeNz9sob+yVHJV/D86TMjxIjKchSFWjtj+NLq5dOodHjbpaN+M05hihoSu9fdqpNmE
         pe9w==
X-Forwarded-Encrypted: i=1; AJvYcCWUDJ1wu6sPFontRDI49OAwXe7g8HS/OCy1T5W2JsThe9X2GIIdhjjBcio/IkMzZayewsO2JRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjSQzORdyG5Kpz/1Fw9uy8Eb13KRXi6JjPGlbhbXyvPwUFaq3
	K2SGTcZgI9SFeuMX1AZKsa25UTwxfvvvwvOqn5VWMD+ztu2syqgh3uAmmXd30xf+mZ9aIwklzzP
	wGx13eEBfcv7kH3u7B3PolX82ZiJGMZNzb4Gv5DWJ
X-Gm-Gg: AeBDietYDffNOoe/65P65207qzmqy3Fk0X+GbOWjoD83fgawBAkgIyvlfueCUbj+mYM
	wrRs+X+S9T/WgYq5zS+pEiQvNc9Cjzl0Zt2rn8Qa6Wt2BKkIX6bIEIF00jYNi0fy/mWpgosgExs
	6m9ekPS+cnVZqr5QfQMawGgl6uTxcMAGXAxuEprj7Rki1x+UTIMLDod7V/emtGa0CwhN0sPmb9P
	1EHSYruS7Nx84txsj+rn/dX7UtqN0yIGYe7hmD3b8Thw2/Wm36yOLEUOGaxnuhc8yj+D3X7Yej/
	Iheym3NUM40KHLnhgg==
X-Received: by 2002:a05:690c:9404:b0:79f:b903:88be with SMTP id
 00721157ae682-7af6fceccf3mr6348577b3.16.1775770116803; Thu, 09 Apr 2026
 14:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
 <CANn89iJO5DTWeVVfMYh7y3e9Npsu+FQ_a=W9ZqbMtb_wLeBL7A@mail.gmail.com> <adgY-Yn6-OophYXb@gandalf.schnuecks.de>
In-Reply-To: <adgY-Yn6-OophYXb@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 14:28:25 -0700
X-Gm-Features: AQROBzB120AVgt8kbc-hZ_stDalVZW6NMlnB7ybihX5MZfdhrGorHPI8CA22N5w
Message-ID: <CANn89i+5A+J=_RTvKn9aJrJFYs13U-X9s+fXYexn-_-JDN4SxA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] tcp: restrict rcv_wnd and window_clamp to
 representable window
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277128-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF60E3CFF26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 2:24=E2=80=AFPM Simon Baatz <gmbnomis@gmail.com> wro=
te:
>
> Hi Eric,
>
> On Thu, Apr 09, 2026 at 07:52:03AM -0700, Eric Dumazet wrote:
> > On Wed, Apr 8, 2026 at 2:50???PM Simon Baatz via B4 Relay
> > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > this series ensures that rcv_wnd and window_clamp do not exceed the
> > > maximum window size representable for the connection's window scale
> > > factor.
> > >
> > > This is most visible when TCP window scaling is not used for a
> > > connection. In that case, the advertised window is limited to 65535
> > > bytes, but rcv_wnd or window_clamp can still grow beyond 65535 when
> > > large receive buffers are used. The resulting mismatch breaks
> > > calculations that depend on the advertised window, such as the ACK
> > > decision in __tcp_ack_snd_check(), and can prevent immediate ACKs.
> > >
> > > Similar effects may also occur when window scaling is in use, e.g. if
> > > the application dynamically adjusts SO_RCVBUF in unusual ways or when
> > > the rmem sysctl parameters change during a connection???s lifetime.
> > >
> > > Summary:
> > >
> > > - Patch 1 keeps rcv_wnd capped by the (window scale-limited)
> > >   window_clamp at connection start.
> > > - Patch 3 and 6 ensure that window_clamp is limited to the
> > >   representable window when it is updated.
> > > - The other patches add packetdrill tests to verify the new behavior.
> > >
> > > A simple iperf test on a virtme-ng VM (Intel i5-7500, 4 cores,
> > > loopback) shows a noticeable improvement with window scaling disabled=
:
> >
> > Explain why we should spend time reviewing patches trying to help
> > stacks from 2 decades ago,
> > risking breaking other usages.
> >
> > Almost every time we change the rcvbuf logic, we introduce bugs.
>
> As soon as someone gives me access to a link with a bandwidth delay
> product of probably > 500 MB I am happy to provide another set of
> benchmarks results:
>
> `./defaults.sh
> sysctl -q net.ipv4.tcp_rmem=3D"4096 2147483647 2147483647"`

Please do not do this. Stick to reasonable limits.

You might have missed that we are flooded with bug reports (and buggy patch=
es).
We have very limited time for bugs not proven by real-world conditions.

