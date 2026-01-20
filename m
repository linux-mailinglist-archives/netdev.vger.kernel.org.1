Return-Path: <netdev+bounces-251579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLPWGZjab2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:42:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAB4AA54
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B87AE32E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAF3126D3;
	Tue, 20 Jan 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKOE7EN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6544A73B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932877; cv=pass; b=MPlx92LAv/LaNlZ2M0oZjmcdHsa5AMxrBK8L3lQ1vsBvq8YcNcrYX9rGb/EKf5LuhBR86qEN3m39KhCZg8VxOlRaRqaQJEhkaLfQmnSET3bSoGrARzl6k1QEsqaYuhgnsRvqJTmaKFER/eeNGACUA5MuwVcCFFxUWBmRvplqAA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932877; c=relaxed/simple;
	bh=LOlvSDRbLt+/6UseKaqs6fE6lsPU1CVSaEsYMlRYSg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv1Zkx86ayDL0qPeWLE42FELjFEM+wsGkFxiBMxf6bVG5JAE4RJRCMNLUGDYIWH08k+XgtLkGe1nvViHB2ghA0U4JLCnlCzZiY0OIAhcpSQlbrqzrphEKLYXXD8xWPBM6Q6RUNb9/aTgwR7zqSgd5UYXal3RuJe2O3wBZR2SYgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKOE7EN4; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8946e32e534so4096566d6.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932874; cv=none;
        d=google.com; s=arc-20240605;
        b=MRLlXyDhvPFzwi7NwJ9NzXFqfa2zTu2QQxjT651LQEoHkXy6NfpP/emAOzEpo4Srus
         Lbz918HnujKC3yV45h+noctBLMR0bj1hHrSn2i9tj7CjGIs93H3KO+ZETHHzYVWbshb4
         cXgTPo2BY4gF4d4QLB/dOqOgGZnwzy+ejcil70MBFytsMwRXtnxByFZg+77A/Qa/gtvj
         IprJyXLuaN+Sy4iA+/dpDpF4PTJ8se9/lg7n56+TKHp0w8ZqKHXIN0sCnAdc3/iWg0eb
         rvMqFvGWFyRFkM6akfHgmwEHzsZYezx1VfBmAnFGHQ4qhGnCkVGulTg73HBpaYxo5cV2
         FSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRJxXzBWMEHHmUy9O73DapdIRYUgQeffv/qDUmagvec=;
        fh=R9FuNr2eCQdNNYK4ngEMXr9oETHwkbQUm4Dqx0ebsdA=;
        b=Yv9Lhgehl/z3UT52AYHrhCoSFoBgro6WgkDaiDtlVAd/Ggu4pOp3W7wZhLmeQWE9jR
         fPjl20+7K7V9xjfzgT3RQDmiK3yHxsIFDFUQlvZkPPpfUZcZsIJfvakxpDXUCUE9qiSw
         RHStT0LMcg0rCrpmtkkYpfcjHHwEicQ7ScTCsdQ0OlMiIjdIvHG7zotEcFgkObH3xPdm
         kOjMqWoKDN8vkHvADZHDvtht1Zb9iF6tOh98lm7iwfGGDakAGY8lJCaD/PCByTH+7lQM
         edJaatI/hUdLEvh69M0zjW2/R3FvdUOBrXYUFR9hqxY3/cJCBu3NLikuXKBnpXeFu+kI
         7XYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932874; x=1769537674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRJxXzBWMEHHmUy9O73DapdIRYUgQeffv/qDUmagvec=;
        b=dKOE7EN4vjfVDH/jfJrpTHPDzk7rWp8OW5e+hs4McGASwnBBVADjURKQ82fcV1MiFf
         P1NrNHTnTnPP+/a8diKTl7VrxSWgcN6JQ5ZNvMJ0+MJOnxl7SNS01q+nGUftptevaY8U
         Da5z4xWsPeROuBSDUOs2sdUaXPPBgAddiWFoRWfwwcI2huTbdOmLCHn7cTRquY3kPBa0
         L09FqXpQHGgOxBPZBINf6go1/yePJ0iUiBSToFDt73zSfEgJcZSTAZPmafhbo9Gwklly
         U2r/yxFMCyEn/xx7X4kuuLi1IGMQGkP3iRzwIIcrXKf+QXZSmDzVELVI/8DnjQUfRTvq
         8p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932874; x=1769537674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRJxXzBWMEHHmUy9O73DapdIRYUgQeffv/qDUmagvec=;
        b=blUQCXM7biqHjyy5h7dfDeLNMWVeNNy8kH3migDXPutbxstAHRJbLRBSjiDa90CiE5
         msKQc+L+B8Tz7ahagteQ6xXzfTZitK7Nf4wnrBE3IZkQeJbpO6YDY/lgOZApP/TteIUH
         eP6QsaeGVBEflBnwnIV5ydfnN8GsEDLsA0Cin7mbQqziZANdxdV+Zz+hq3MbTV+wvmXt
         9JvyXpjWpSUupHc3dqBtvmsuigxWBsELJs77VIlvtyNi+yhvdWEsi4/YGkS2PMK+xf1y
         lBMpF4Hdeb51eiSb1S35pfm+2zDAMJN0J1VSIr7ktwxZo1wZUfqniyvaqNPpOkkCFnKl
         cwxw==
X-Gm-Message-State: AOJu0YwCOGRm5ZJjHnAioNNCf0eZmRMBPOx9PXhjfZtp2KgYbN9nhXHl
	F52oEtOzl0nihVqDA/Z4CMas9JZsH6jqGXLRwAsYd1YVqiLlI1iHwb1rvOlOY0Fcx6LE0VOLUnQ
	xPakT5Y2zJIWYTJo3rMx68rfxNPBvfFkaoZc/HBYU
X-Gm-Gg: AZuq6aIFsO2Gd+0pYD9bn2HQFIMqmNn1Cs5ULASgoWVVtVSfh/u9nzLEPdIs1A1ZKv0
	jAjKf2KTsewPMVdfikhualC7YFxA0qbHikDNSdgzbvoQR19rOB+SpOxJ+RRPKW/V4R6rB7JYaZo
	rnJc/GM7w5+lIvfWKJYRHP8zHSYZosCKzKqevFPBI5oMOvRoDfKcrWvI5dRGlYvmnveeQ7Y7CNI
	MikOE7JIYnVkneY+68ItLOA2RFaaf9YDLOsZ4yK/jc0HqYok/kxSNBEB9HXsQC+GK4cBvyh
X-Received: by 2002:a05:6214:f28:b0:88a:27b0:9096 with SMTP id
 6a1803df08f44-8942e4b07aemr238907366d6.53.1768932873507; Tue, 20 Jan 2026
 10:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h4kZQu6CY_U6cfakQ7Zozo8fg-LpQ_n5UiLZDVhqxMC4A@mail.gmail.com>
In-Reply-To: <CAFfO_h4kZQu6CY_U6cfakQ7Zozo8fg-LpQ_n5UiLZDVhqxMC4A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 19:14:22 +0100
X-Gm-Features: AZwV_QgCrJmUO5-nrda3HP_hrFF6FGl01bcEtE8Tl67RQTTnU8EUBA2ImtQrNm0
Message-ID: <CANn89iLu1DTn9xeqpWAfiKPajh-bkhss4awNWzUd2=0iZRQEWg@mail.gmail.com>
Subject: Re: Question about timeout bug in recvmmsg
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251579-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 24BAB4AA54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:09=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> (Note: I had posted this before in
> https://lore.kernel.org/netdev/CAFfO_h5k7n7pJrSimuUaexwbMh9s+f0_n6jJ0TX4=
=3D+ywQyUaeg@mail.gmail.com/
> but got no reply, so trying again. I would really appreciate
> suggestions on this request. Thanks!)
>
> Hi,
> Hope everyone is doing well. I came upon this timeout bug in the
> recvmmsg system call from this URL:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D75371 . I am not familiar
> with the linux kernel code. I thought it would be a good idea to try
> to fix it and as a side effect I can get to know the code a bit
> better. As far as I can see, the system call eventually goes through
> the do_recvmmsg function in the net/socket.c file. There is a while
> loop that checks for timeout after the call to ___sys_recvmmsg(...).
> So this probably is still a bug where if the socket was not configured
> with any SO_RCVTIMEO (i.e., sk_rcvtimeo in struct sock), the call can
> block indefinitely. Is this considered something that should ideally
> be fixed?
>
> If this is something that should be fixed, I can try to take a look
> into it. I have tried to follow the codepath a bit and from what I
> understand, if we keep following the main function calls i.e.,
> do_recvmmsg, ___sys_recvmmsg ... we eventually reach
> tcp_recvmsg_locked function in net/ipv4/tcp.c (there are of course
> other ipv6, udp code paths as well). In this function, the timeo
> variable represents the timeout I think and it gets the timeout value
> from the sock_rcvtimeo function. I think this is where we need to use
> the smaller one between sk_rcvtimeo and the remaining timeout
> (converted to 'long' from struct timespec) from the recvmmsg call (we
> need to consider the case of timeout values 0 here of course). It
> probably would have been easier if we could add a new member in struct
> sock after sk_rcvtimeo, that way the change would only have to be in
> sock_rcvtimeo function implementation. But this new timeout  value
> from the recvmmsg call probably doesn't make sense to be part of
> struct sock. So we need to pass this remaining timeout from
> do_recvmmsg all the way to tcp_recvmsg_locked (and similar other
> places) and do the check for smaller between the passed parameter and
> return value from sock_rcvtimeo function. As we need to pass a new
> timeout parameter anyway, it probably then makes sense to move the
> sock_rcvtimeo call all the way up the call chain to do_recvmmsg and
> compare and send the finalized timeout value to the function calls
> upto tcp_recvmsg_locked, right?
>
> I would really appreciate any suggestion about this issue so that I
> can try to fix it. Thank you!

I think it is too late to change behavior, set in stone for more than 18 ye=
ars.

This could break many applications.

