Return-Path: <netdev+bounces-282021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE5MJt/u8GkvbQEAu9opvQ
	(envelope-from <netdev+bounces-282021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D7489FEC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF3A300D965
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8937C931;
	Tue, 28 Apr 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUFu5plL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899B2877F4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397231; cv=pass; b=C+LVczqG34zCOQVm5KleIN8oCZxBNjoMVEg9antf2jbjI6tuan69ag4968Bx6lXUXEI/doY7os0bIGsr6UN1M3aHgsEItqtm9ry0RDIea0yCutk2fj/wcH1edjLRTN5kJ6BivtuoLwduVic/Ovk/uX97d6rCEXM3f/F0x+vmIGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397231; c=relaxed/simple;
	bh=srmIGLk0XNRHEiJS7sFyg4a4uizVocTvnsyziFtbPic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGSNnAcN4jXT1XOIx5nHiMnVzDaarCRnXyy9NHx5m1zjK/RVZN4evrDdm5idQRu+HDjzidwcgcu7H8aTwcx9kOLq6x7gN3hW6IL0pUaGg/8rDadVPbLW8y1pJPNthAlrG7mPVHHzZLJe8qF3G8vKIjqfr6USS7b9YhfR0A2KNoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUFu5plL; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e594413c2so567351cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777397229; cv=none;
        d=google.com; s=arc-20240605;
        b=Uzv90L1x5BNuXG9emOecGpf+46FN1IoSitN/trvDi87UhsnOji58lKNi9SsUW906IN
         9iRnKvn0caA9Ky6eGjxK7EY3x5icUUO7dhkG91AsizRTnwVBVz46KSzFaHzDCesg6wfm
         Kd2AtlBWMi8Roh8zonChIZVDJDLf5qFHngoS0zrAQIy0zc+O47GERA6zd1X8BGpBzsKY
         iY6Vq5K921mrrc2XOVyLrOLsZ9UBYh0nNzxY2VB9XIGYR2wix92dUcoEPeeDjDsCnKLi
         X3/IUV9dU8np4XmmYmfK+MpRpMlOlaq7/LOy/8uSxOjl3YhdiDnRHvPMdGjE7m1SOHMM
         N9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WTyKuGvVB8nEvXL868PSa+UdsMdTlnKOV2qdeLp521U=;
        fh=XyndSbCYQZLu3w1W8eAfW8GjRc03kFEY5V+wbNtbNAI=;
        b=FtN4ozSS9YQjTFJNbqdEgP/J+yojzY3DlC+lIFJDeK2CeFefrPoDh59jLe5RIDpiHL
         if8PTAcHkykYb59p9HGoV+hN/xuR75FEYgj+sxROSGHSOh3WBBtKQboNVK0AeY74hGcW
         Ukw9WmWwZWqQtqoGrV/3+xKG85iogULup/EEufUdQYrCU3Fp32cK09Q9OC8R5+KKjQNc
         ragd3vtIC81m32bolXKZFcmnWUfhfCqnufJ/tPBN3Pc+xjjG1cQJCDsRLJsJ1KOW9nGC
         2y8PS1AhdZoj4PL/pUEKq7sQbDgKI6xqQfW+/CFruspgJAPiHoqDenr9/8/4fuHl6Arl
         dT8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777397229; x=1778002029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTyKuGvVB8nEvXL868PSa+UdsMdTlnKOV2qdeLp521U=;
        b=dUFu5plLscyDTzV+fN+74gmPej1nAp9HuudMjBL3SVJd1Y9kBE9AARcvy3tU5GzkHY
         tBYIziGIFz4vtzZ7SJeP10qjjWcDuo97WRgRaEA8QF7uPkpTLUJqcSLmKa3MdEIWHjqW
         8TcCcPfvWZpsYB7bAKgV2wAFk1dt86A8FZ81dsfNlhY9rqmw3hU6LhN6zu+75KB6fYa4
         9TfRkTAGbYzJbr2Brn7VRi2AdCJzwrz0KoDO5HsTW2ZCkD8A/U/fCxCp3UMNli9bMIHp
         s0IaRxOK8bngDx/DlmKKqDGLqEVEGSE7b5ZeoM2rkx+7TqzgXwTAV/lB3I2PPpkCsJu/
         uo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397229; x=1778002029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTyKuGvVB8nEvXL868PSa+UdsMdTlnKOV2qdeLp521U=;
        b=tNLpB4V5VofqI606vCqVhOOjDJ3n5A7aMjwVHwqm+qNRR4+C7mBRQwNP4ux70T3ADq
         tiV9kejh3EFro6Uj9grd9ZxoyxVpiWKnovrSMP+2dGJ+D4eTpyXNKcA1rwJpihEX0uze
         RFBtkOSeBYhqRvbA2nLQc22r3UP+uw/rFNph2sNhSGCw20uRwcDDHlOTev7Q3ooApbK+
         jOzSZhcnmzQwA2UWiHIm6mIhF1yyFr06wMADioNSYdKKAkFDIp5SN1eDSi5c+0bJwrEU
         vUmhWVjIwBwXTlW5RN18Cg5h+sg7AzkXgOBjJKUo4LanDNNzN3l+KMai1hCnXhcKC1Tf
         TmWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VNQ2MrceILFvpVqimMnU9dh8LwiAR17F5xisze2pL3KVUd3cmXI9ASgsqAQwhs5GtH3PCB24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqh9xGQUtiXFm6nt79ZKMgAvLBnyn0xlDC1gIZwH6vaSiJwiWm
	LIXA5c3D8jJcZkgxcUOxtGhTIpk4hyHjwCQp2BvywPQ9lnHtKSE7OwsENtzVonewPUA62p40jcW
	bLf0XgxCUIJ/Uqu1ACemNJAqRFHQ1McYo2f3Wbtrv
X-Gm-Gg: AeBDietl26/P3+18hFWpLJB6gsAin7BbSpnNIDfvx6iX/aOqqAUZjKHUuo2uYbG3ztr
	4wztFPWB0omSu5LfL24cn4Hua27aXtmOhVL/9qoIb4WHzaBU7/N4jOhWsZiG8r5eTITXZTk7M0l
	NjBjP1IR5QVC/nvAH7iw4IPnQtPS9DwrJNO7U7Wb9yNX0LdLks6SXEvw63BLQ5qKJSLDxmtuVlO
	J33LlODTFoEVxne3UPhVs8wSfsDuxcaz8+uTAhXxwsa9Dph/KfnQgkDRFYa3HlB8s5qH00dgzs0
	N3uP+sLzRzC/FLLaeYba4ot30N1UusLb9wUOwU/mBLSl5VWbpFklntBaqwZ/3ywFKm0UD084Ifp
	9cB6TQmID
X-Received: by 2002:a05:622a:8d04:b0:50d:3efd:bd93 with SMTP id
 d75a77b69052e-5100d9cfe5emr48497051cf.11.1777397209089; Tue, 28 Apr 2026
 10:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com> <20260427132555.1791636-5-edumazet@google.com>
 <20260427161830.78193ed9@kernel.org> <CANn89iJ4MjaQP047jWFBquLd+ed-QfEOx3fUMUTdw328NOHc9Q@mail.gmail.com>
 <20260428102008.6f3aa32c@kernel.org>
In-Reply-To: <20260428102008.6f3aa32c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 10:26:36 -0700
X-Gm-Features: AVHnY4K3-BHBuaES-tz0RBMBvLktsqge3WUVRywNgzHHcaHveNF0hujE4P7omck
Message-ID: <CANn89iLbJSonJs64BqTaNfvf1qfhhRXA0c6yL1=dxt10q0GxZw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net/sched: speedup tc_dump_qdisc() when
 tcm_ifindex is provided
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 156D7489FEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282021-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 28 Apr 2026 08:40:52 -0700 Eric Dumazet wrote:
> > > On Mon, 27 Apr 2026 13:25:55 +0000 Eric Dumazet wrote:
> > > >  static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callb=
ack *cb)
> > > >  {
> > > >       const struct nlmsghdr *nlh =3D cb->nlh;
> > > > +     const struct tcmsg *tcm =3D nlmsg_data(nlh);
> > >
> > > nit: breaks reverse xmas tree
> > >
> > > I added this tcm assignment after parsing:
> > >
> > >         err =3D nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca=
, TCA_MAX,
> > >                                      rtm_tca_policy, cb->extack);
> > >         if (err < 0)
> > >                 return err;
> > > +       tcm =3D nlmsg_data(nlh);
> > >
> > > because nlmsg_parse validates the struct is in range of skb->len
> >
> > Note tc_get_qdisc() and tc_ctl_tclass() use tcm =3D nlmsg_data(n) befor=
e
> > validation.
> >
> > Do they need to be changed?
>
> To be clear - I just mean that as a coding nit pick.
> I seem to recall that some AI was flagging this as a bug, it's not
> really a bug. But if we're touching the code I think it's easier to
> everyone to follow if the nlmsg_data() is after the validation.

I included your suggestion in V2.

I will send a cleanup later.

