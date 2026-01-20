Return-Path: <netdev+bounces-251585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJNkGlHPb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:54:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1849D92
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13EC38A678E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93C44103A;
	Tue, 20 Jan 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACbmQf4m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB743C06F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933629; cv=pass; b=T3dOnXkRHlcu9tzohN8+ZG8VVKeDHMAovP4j7TBiqTlky1HZDRBU17ZWcDlu1cNl1zofftKSiBh2fsVPv1sOF0cH9xp8IrsuYdUp6wUuxKQNEqQQpmkGCRtJr3ayjY7wn4VL/x98VafHdzq16VrAKZQYdmaclBPuwQNm+yhqBDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933629; c=relaxed/simple;
	bh=WjyrYejoNDCqoUNnjbJPM5/Ul8BkhwhbjYspZsnE/ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOUUCJ4ZyGCOGvbm0cGhXOpgpapXge2kKJD6fRWkGBPdy5CXbMqS0mGb4EoKCzsRPDE/K44LUuyqNRWmbweR7I7zXHrPc8rE3rSFezfVDLX4m9+yB+jwYEKL/y1m5ui1IwmwlY20fBbZ29HwAELv41SOkI3PO+yoOc74HPhnFS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACbmQf4m; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93f573ba819so2077933241.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:27:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933626; cv=none;
        d=google.com; s=arc-20240605;
        b=PeTocd1+Ccj0vmNXZI4gG4f3PbSZYhJBGWlD99l7SM7TUzeBkCr3ql9pkMLi4moZKM
         WO0mX7rp7IGyZPwav/EsP+taLPn9KPh855pZ0sTOhzfdYHq4lg8Sh6QrkqAgLvVOnIVX
         WgkhZ7NEhx25ZBskfxdx8pfv0o8mhuzWLH3NW9BRO+lGvsE44snAHrlxAIX7XBgg3ZfM
         /j4RlQJt/HJ6UhELaW8hmLwkeiBuwRVxdj1ob2XrCWCn3k9bJeF9LFJwhvoKu4Pz4PjF
         +xuQHvBwDYCJtN3H0HKyzSGYz9f8IcXz/tp7Wpe+PJ2VUY9dweZvxAsy2nuYNeQzNVqr
         TO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=05dxE5YDetF9DljE4cqyNw51lJAscnnJTYEC67eYOGU=;
        fh=WH7lMV2ZUh0XixLi7mmftMBZg8XTxWXlc8KkFHGyvgs=;
        b=R6AXP68qcsHIwA/hgRPL/+upltTzw25+TNhQcF/ugqBtgdKA5FAnf6Mlki62NFXnSC
         z0dLzQM0OYrH5wJdUI22AjBHHMhKsY/OGJst5JhD6dAixpxaKFhS4MWZnmKBxJFXL5Gd
         2F2+56QkolXJlA/lxeW6m4SNwFFFpUIN4cdC0N1N2EL1MypUvV1mBp1aD9z7xFnuvh5c
         TBnT9Wwtqyyp9NHpxJP5R4MQvgz3X2UX+qhaU8AWo9xDyWF71d5+8bPKvtAB4IbZjdZQ
         cli6+W5M/qZAlNM9D1mWUdiPh80Y8sMwvxGgBgiwjMdGqm7rWT6cSx2RTR94euO9FjTQ
         9IBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933626; x=1769538426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05dxE5YDetF9DljE4cqyNw51lJAscnnJTYEC67eYOGU=;
        b=ACbmQf4mZhkRLKPwnEnnL46lB+PREy5Kuh2h0m9/UssPfRBgsXGO7SpqEo+9057pmB
         gAEIDd3GK+HDaiIekDHp19kk8RJs5N5TWLdm2RuzFk6sKozxnFhkU+suCitbwXTd9KoY
         sHrXstSd6CYZ4XM/+XZ89sYGY4s9FVdB5BlOxX5jbkzxJvpW+tHWmxsCObUQgJ7VQOkx
         mwHfmyAEEa90VZc1WMmKCrAtycqZ5Eki6onz1XAKSzc75FagQ6+fhjJ/qXF/1uvP0G2k
         R5JACr8Xhzx4LOlo2AqEcy7CExsUj57a3ALwdddqVWd7U7sF+DII9BiFBpMVANvUDps4
         qPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933626; x=1769538426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05dxE5YDetF9DljE4cqyNw51lJAscnnJTYEC67eYOGU=;
        b=dtTMWNwm5p361pbAu329LUvUQO5l3fL/nT1U/VNUG4e16bjYtF/5i0D/Zf2GL1/VYm
         LZ8EpfQSy+AnRBESx1+METaJDoQQPXpq5eMheXt8EIifgiMYf6ehhOYk5Efmf49Ol6dn
         mWT/t06OJZDw2aC1lRodF0bA1yV6TY3CCDFihBgZiT2Z4k9/to8p54hE07zul2KKpfFd
         YXVHyeOy8eXb8FCeR5ijvpsixpucBoN8Dd5iHr3q/JFOu5EOGkH8YWwK8xIU1Lxh1l99
         8lY4pZNUCE6RIJsjRNB+SHMzmXXLVZsZkyhPCUvpRNyqjm7FhNoUDM48D7i1c4tE86B1
         P4LQ==
X-Gm-Message-State: AOJu0Yz8l6kOC+7EbuVYYWPEhz2k3FvRxR4uuJElbowu+ZUvRv+MMOq0
	M2xMWXIaFYboi0fwETjPo7YqX/0GWrkZ7ITl8IHEHcV9+UjwgrY9nQ+yvEqssrOMG38dmhVAYxt
	E2vIQ1eaof62R4r3cZ2Ek5K0AMACbeSU=
X-Gm-Gg: AZuq6aLk99GeNJXN3//DSrfyv7DFU/9COCv2lL4XD7d8hAjy2OLmqduMCNdB90OaFML
	ykxnyangbH+plzBGePjeJP07cTwFFBDASUhIWNB0nUl1unSWNF8EZGaqvEXkmTJFXMgUtfH0G6j
	esos03R2mJUTjGhnOKDOcTGLnsfJdU78NZQZ81gt5ciYw5qChhwLdKt5Hfn70KPdvH4a/WRzh8C
	gq7WIDwbUARnUm+IkCrHC8PZE/IqKNREfmBt9VCu+awbxXbFs6zHRlTRwjjrqh509GC5bgMWrND
	X/t/e7xfrKvm3Ka03OWM+4JKU+MFwvrI04WpWYKJkA==
X-Received: by 2002:a05:6102:3910:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5f1a5579199mr4695639137.29.1768933625876; Tue, 20 Jan 2026
 10:27:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h4kZQu6CY_U6cfakQ7Zozo8fg-LpQ_n5UiLZDVhqxMC4A@mail.gmail.com>
 <CANn89iLu1DTn9xeqpWAfiKPajh-bkhss4awNWzUd2=0iZRQEWg@mail.gmail.com>
In-Reply-To: <CANn89iLu1DTn9xeqpWAfiKPajh-bkhss4awNWzUd2=0iZRQEWg@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 21 Jan 2026 00:26:55 +0600
X-Gm-Features: AZwV_QgO7_gzkcibKJWs83NEexL220V0UjZGbx9YsMnfJ1_Q5-b1apvXTsjHbh8
Message-ID: <CAFfO_h4cX0+L=ieA_JF7QBvH-dDYsHnTUuN4gApguqxVpWyy2g@mail.gmail.com>
Subject: Re: Question about timeout bug in recvmmsg
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-251585-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3EC1849D92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

On Wed, Jan 21, 2026 at 12:14=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Jan 20, 2026 at 7:09=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gm=
ail.com> wrote:
> >
> > (Note: I had posted this before in
> > https://lore.kernel.org/netdev/CAFfO_h5k7n7pJrSimuUaexwbMh9s+f0_n6jJ0TX=
4=3D+ywQyUaeg@mail.gmail.com/
> > but got no reply, so trying again. I would really appreciate
> > suggestions on this request. Thanks!)
> >
> > Hi,
> > Hope everyone is doing well. I came upon this timeout bug in the
> > recvmmsg system call from this URL:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D75371 . I am not familiar
> > with the linux kernel code. I thought it would be a good idea to try
> > to fix it and as a side effect I can get to know the code a bit
> > better. As far as I can see, the system call eventually goes through
> > the do_recvmmsg function in the net/socket.c file. There is a while
> > loop that checks for timeout after the call to ___sys_recvmmsg(...).
> > So this probably is still a bug where if the socket was not configured
> > with any SO_RCVTIMEO (i.e., sk_rcvtimeo in struct sock), the call can
> > block indefinitely. Is this considered something that should ideally
> > be fixed?
> >
> > If this is something that should be fixed, I can try to take a look
> > into it. I have tried to follow the codepath a bit and from what I
> > understand, if we keep following the main function calls i.e.,
> > do_recvmmsg, ___sys_recvmmsg ... we eventually reach
> > tcp_recvmsg_locked function in net/ipv4/tcp.c (there are of course
> > other ipv6, udp code paths as well). In this function, the timeo
> > variable represents the timeout I think and it gets the timeout value
> > from the sock_rcvtimeo function. I think this is where we need to use
> > the smaller one between sk_rcvtimeo and the remaining timeout
> > (converted to 'long' from struct timespec) from the recvmmsg call (we
> > need to consider the case of timeout values 0 here of course). It
> > probably would have been easier if we could add a new member in struct
> > sock after sk_rcvtimeo, that way the change would only have to be in
> > sock_rcvtimeo function implementation. But this new timeout  value
> > from the recvmmsg call probably doesn't make sense to be part of
> > struct sock. So we need to pass this remaining timeout from
> > do_recvmmsg all the way to tcp_recvmsg_locked (and similar other
> > places) and do the check for smaller between the passed parameter and
> > return value from sock_rcvtimeo function. As we need to pass a new
> > timeout parameter anyway, it probably then makes sense to move the
> > sock_rcvtimeo call all the way up the call chain to do_recvmmsg and
> > compare and send the finalized timeout value to the function calls
> > upto tcp_recvmsg_locked, right?
> >
> > I would really appreciate any suggestion about this issue so that I
> > can try to fix it. Thank you!
>
> I think it is too late to change behavior, set in stone for more than 18 =
years.
>
> This could break many applications.

Understood. Thanks!

If there are other smaller fixes/improvements that need to be looked
into, I can take a look if anyone can point me to them. I would
appreciate any suggestion on this.

Regards,
Dorjoy

