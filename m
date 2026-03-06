Return-Path: <netdev+bounces-264882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK6tH0kJq2k/ZgEAu9opvQ
	(envelope-from <netdev+bounces-264882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0495D225A32
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4A0B303524C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5D33BBC6;
	Fri,  6 Mar 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHqpi50L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061E927A904
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816485; cv=pass; b=rtOG7otanvc5g4Dh91s2EctW/iKtFiarxHxQqwUN4IZ2TPtjQE1qoa179//ljha1qE11262OkV/Zn30sbYxZbNE/jS9uNm3BCeTKtYgc1TY1SqOIiTm6W81rZeJGJWSLHVv3DB7RhF0DRhh/CMvk4o8ph1LNLDnRlsUm/K/fH3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816485; c=relaxed/simple;
	bh=OPulFZY8f2IEbfikyrd9eV+a3ovAPh7NaAs3Gl4dRsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kjo7OW7sGSbSYfyfYQvsacNvKrn7DmRUt5W9MeRFJoE5OhMME7ZjIiBLE0Kr/VSealW3cNjpJGvObVgUbE1P6peFLZKizytuY5+o8mc9kAEHNtuYjuURwPj/ECShXFtq9z08BaGQU/xUJqoVOeh5mbv/97nQk5sQEhdzdVTbGfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHqpi50L; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c9707fc11so7113599d50.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 09:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772816483; cv=none;
        d=google.com; s=arc-20240605;
        b=dAo2GymDmykWNf9rrviihQ4YTCKSETr5C5ZTttBloVMUlfiwD0VZ8Fzqfg56Q286Ah
         U1jmgHko9aTKpwzmouhYnxdW9fSPtDfRR5/TZKfU009J8Z5XfHHUsFFGXgBJ3BnghR4s
         BRnjz4CKb9GRcvEqgV4qVzVCBZirG9+8IfikTjDfDtxywlFaijcqG8xQCWPghzLVgOui
         U/D8Wo0taqIlqwGd8UKren/dCHXT3giNOd52ta1Obxd4HFADjkmkdF3sqNxDYkfb8BL6
         wNuh7lCJA1DIi6KoOD6cCBDrVal9ON+07147+1U3/JQiepoa+oqSRD20hNI97DuINuR4
         hmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YBn44UjODys0hFtJ5mkQzEdiIeNGr1o81nJ8JZzZFmQ=;
        fh=XAm9L16s/hfy+kFL3LkNXrGv7ZBbKSwHWH5A8wEmm8s=;
        b=YD04w8r8AXXBrvm58Sex4j3bqftCBcpqvj6flwGSNEYhIOit9zy3Yw5OZjqng4BlDz
         OLUMIQnzGnP0vnUU81aNcZyxBpJlCe+WTuTMC6CRzIbo0nxZCxLXooU+baW63kFZLprJ
         K6kyJLJQwTCC/yKElzDl+fzspW+r+HGlJBHazYKaUXYQdqCHjj2OTEjy7oVFjDq+pnQg
         nFAJbLmnIz5rcUt3T08EzllDio/QSKAQZlLTDN6IkPkKOnA6XZ1N6+jSOJavbDpdO3Ft
         pbXXXgD6dnWvP3XStBn1tSKuN0qs1mSAF/pTJ9q+Hjw0R9D3RRgwrYXFXfTRXPAE6kCN
         QiMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772816483; x=1773421283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBn44UjODys0hFtJ5mkQzEdiIeNGr1o81nJ8JZzZFmQ=;
        b=LHqpi50LPUcHi4Jw++dFnNGUFjX26G2H6DnWnXAXORCI2JBye05EGNEwzBeVTU1nSX
         8A0H6UROwneLDNTjNbIwrAQZ966L3MrRweQZkUEzRX26xL6ygefNjj9JT3iNWXaPCz96
         ko+PjekCKtTxcmn6niKqwDLCzzLBT0gip2bc9yy+oQbcSu1JJTrW6gMad83T5y3ialtt
         h3rslokg7E8r4o5PXouyjyuKUHs/9w/Y8j9emJG/7ZyaIKR3d8yBZncV6m2MrDt0TofZ
         dDsledQVlK6tePCe6j6L0En4pispFQiEbckW5yxbyLYyLVGlAuJLSwhB2afd8DNqDyW6
         y7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816483; x=1773421283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBn44UjODys0hFtJ5mkQzEdiIeNGr1o81nJ8JZzZFmQ=;
        b=go9PLbBmkhkEh5pSrJYrEYNsTb1yS6G4IeHzZ8xI3kynlfLa8YteU6Eifv5uI4P+s4
         lWhZu7iEETtyY/sIFCognn+Ee0mtT6uiGQ51Yc/sMzqUFAToHnEmVwuhl9LG/5+Hrvkk
         M7V2eihWocrqpJSXd7Hw1oZY+EB738rX6BpyI/+bcS1J0LDsrd2sQ9V9kAqeTKg9g05F
         DfMTGjcC93gleBXC4xpJ8M7MNnAYH3Hlz+vvSKJ5/0AgGyr19oRQjDN8JGipP/CafBUi
         0jin6KQsnlPyvHq6Wlk2xw5AulDvhXZSo4fbXMln6oJc00m76eqW2b4RC7HvCDH7d/x1
         cdnw==
X-Forwarded-Encrypted: i=1; AJvYcCWLgb99nvMInA3N2ldxTOo94YIQstO8kwLNrX14hEa5J7hbKS5h5j13m2qJ5lwhSpIm3ch8ogk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16KO4Eq4m98HRJS7Se85czWPaQKdLiL+hzYY+IPdbJMGJVhUx
	mnizJ0r14LJpFXHn4DJ3tG3aQTSc0gEVjh+oq3MCxN6Sqg9z5envOxvnaCPL9nsQA69WTAOXsin
	Wm9XDCH4K25kYAAerJW6jqaJEbfecrOs=
X-Gm-Gg: ATEYQzwWWe8ZKZR8Qj3vJwT3KII+YuxaVtpf+oWdRKjryJdvQfqr6xL/anCUvxbJzmy
	GSIZyeQTpPszTH6gJYvkKuWaCBR+21AcMsO1voHe4DKFWevFe8yk5AwsFlrgLz1sHwZatxmCxfw
	TrGEkx/PGbORfkF2z9MPkcyUGzA1fKsReywzscF/6JNHwdbcZy4Bgrqh+DptAziXmVPJtZwTLp0
	JqV8WHtPnqRk6w4eqGawNQW+lmqDbaGaBcBqVOoTkL8MkFW9xFMfuuSIGRWdjS2lyPeIVCDZktD
	yAnad4fqfi2SBwYOM/iRH2kn2rSKDGWbf/Gasac=
X-Received: by 2002:a53:e194:0:b0:64a:d6eb:6e with SMTP id 956f58d0204a3-64d1436ec4fmr1862432d50.80.1772816481719;
 Fri, 06 Mar 2026 09:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305070525.184945-1-the.latticeheart@gmail.com> <CAAVpQUCoPoMPruAetG8zt=o=iZuqUKs-xaVxtf9HSrh=hi2jLw@mail.gmail.com>
In-Reply-To: <CAAVpQUCoPoMPruAetG8zt=o=iZuqUKs-xaVxtf9HSrh=hi2jLw@mail.gmail.com>
From: Soichiro Ueda <the.latticeheart@gmail.com>
Date: Sat, 7 Mar 2026 02:01:10 +0900
X-Gm-Features: AaiRm52AxAjCpXnVj9Um9IT9AAUAp0GBuCFr0p1QAu7o4sYyaB10uftLOdCPiw0
Message-ID: <CAGq10mhgrtvoSo6W_HJ-GrScX9SOgSD45V3BroWwBoCX845RQg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: af_unix: validate SO_PEEK_OFF
 advancement and reset
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0495D225A32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thelatticeheart@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

> On Wed, Mar 4, 2026 at 11:05=E2=80=AFPM Soichiro Ueda
> <the.latticeheart@gmail.com> wrote:
> >
> > Extend the so_peek_off selftest to ensure the socket peek offset is han=
dled
> > correctly after both MSG_PEEK and actual data consumption.
> >
> > Verify that the peek offset advances by the same amount as the number o=
f
> > bytes read when performing a read with MSG_PEEK.
> >
> > After exercising SO_PEEK_OFF via MSG_PEEK, drain the receive queue with=
 a
> > non-peek recv() and verify that it can receive all the content in the
> > buffer and SO_PEEK_OFF returns back to 0.
> >
> > The verification after actual data consumption was suggested by Miao Wa=
ng
> > when the original so_peek_off selftest was introduced.
> >
> > Link: https://lore.kernel.org/all/7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@=
gmail.com/
> > Suggested-by: Miao Wang <shankerwangmiao@gmail.com>
> > Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
> > ---
> > v1 -> v2:
> > - Add peekoffeq checks after MSG_PEEK to verify offset advancement
> > - Unify the length in the non-peek read
> >
> > v1: https://lore.kernel.org/netdev/20260122033605.148626-1-the.latticeh=
eart@gmail.com/
> >
> >  .../selftests/net/af_unix/so_peek_off.c       | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/=
testing/selftests/net/af_unix/so_peek_off.c
> > index 86e7b0fb522d..9640a3975aee 100644
> > --- a/tools/testing/selftests/net/af_unix/so_peek_off.c
> > +++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
> > @@ -76,6 +76,19 @@ FIXTURE_TEARDOWN(so_peek_off)
> >                 ASSERT_STREQ(str, buf);                         \
> >         } while (0)
> >
> > +#define peekoffeq(fd, expected)                                       =
 \
> > +       do {                                                    \
> > +               int off =3D -1;                                   \
> > +               socklen_t optlen =3D sizeof(off);         \
>
> nit: Can you insert one more tab before \ here ?
>
> While at it, please sort variables in reverse xmas tree order.
>
> socklen_t optlen =3D sizeof(off);
> int ret, off =3D -1;

Thank you for the review, Willem and Kuniyuki.
I'll fix these formatting issues and variable ordering in v3.
I'll send it shortly.

Thanks!

