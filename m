Return-Path: <netdev+bounces-281965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLp1Mdnb8Gn3aQEAu9opvQ
	(envelope-from <netdev+bounces-281965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3A48886E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF22309FB75
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB044A71C;
	Tue, 28 Apr 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVv8++xB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A542885D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391874; cv=pass; b=WAGS0VtwTT11gRpjQrdIDraacI6kxGAvK0s7+kPROM+Kh1rjzUGdELpaUWKgCQsLFJTwFrxm3/P6to8FY3KbqJwa5rCYwfCDtt5lpOkPUtcmUfdoZ7CMVZdwF9PNf6qjMQbnWZv7Pzj+dF/IRMY65Ngt7N1CqKDaHoD0BoniSEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391874; c=relaxed/simple;
	bh=GO81m0B3ypym/wCmj9ULAMrxp4f8qXv+w9Hr4vZT4bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YezU53uggHgoENmQUmnW9pwgPvPSpc6o7WdopfrboK+W7fOzGbhCvcCrF1upqpcOfX8vVNEk5W22SYLV/Dba1W3xfTLG0ViNM00NNIuzMKDedNBwPRNGmi+dqA249Bg23bM8E0r7DA9oVgp2WcHsAGz5sKvgeA5/o79OPDZpmxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVv8++xB; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a747448dso83301771cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391872; cv=none;
        d=google.com; s=arc-20240605;
        b=PSrj+w/XWlnmk1X6dV3SP0Dwu+cVUUF793gHNAuHGc96YMEbh/zZalx7Qc81MJSmXw
         xhAUJsa487I8U5UmFa4y/xZtIzgHB0420N3w4kxO+5NgoXlfvZDUyflwsSpk/9JFfgj8
         nH8j+ndkV57hv0w+EEpA++Cg5PLYq1EsEsXDHgRwmkojoPTnmZryuSpEomZJt4UHN1f2
         fnU0Snw9nkdaCI0RfUyPdwiSOR3G7kTrxno8HEIoGqdhXh72/f5xyCiv9LCkihtx48DM
         0ELowSbfB6n9wWyxsmFRqodgoV89DKzV9C7ivZeZnJXwnz8zx70mNLO/7lqGWhbd7rHR
         y5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/hpsE9ezKreWGn94AUhdvDRrk6m3bZ84ndpOq64p1Y=;
        fh=4nHYTmJijZWJFQk3lXk0cpArogrbnJiwno2rTAMJgtc=;
        b=LMyARWASNPpvRHm9eLo4Sb1FQZJKvlSu37kX6FexA/6wWgOchAv+ioLpm0FOjIyPQ7
         /qNnqEpOPvkFFoEpVk52E2LcFbgvfm2PE0qL8/S2rd5OMHeDuOsOvaePlumsJFMmioxl
         A53pD4/mTeSFaJY+IYslGzggh9zHKWFt7rqz1ZoV1AaVdQFgvQgVCExq3jQb0c936Sqy
         jMmvtl5k5gl+0jIBSKlNlp77kVriw6P3dPc9icJVw99J1DrlCzc1LGRTcTj0e00TSbK1
         HA/tqCa7mjH92QPWCmxtBMvXqLFYRttjqUnVPzcnlX7fVVP8ivBOF6Y0diV39UQ69iAX
         UJ8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777391872; x=1777996672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/hpsE9ezKreWGn94AUhdvDRrk6m3bZ84ndpOq64p1Y=;
        b=GVv8++xBkPzX3RKNGk6n2uNTY5T5/GSdbGLLBKMjWXV9Nt2qyiveRSZ55jZK/zkWGc
         eKHaG2+4h8+cZ0qGun6HE0vvDW+JRflqmJopviM9Hru9G14n5Bc/U8nxKle6/CG4pBN1
         1y9lCvnSdGRS0UCjSGSeYatZ/ntGfL4Nr/fBhQctE6M4ckqa0qjfo9aFYQ0aBpo6uOYB
         ONXl0HEcB5fXO4Ya6ePN+ejg/F36oFgTfoAVmzVvRqVIqj/BOQa3OkEgBt1Hq9XkOzqY
         48ciNWzr4fha7lySD5tImf0wOrLRpJdHiDfdQ6zbPLpF7ov+l4KHPflavak4No3D1UAr
         LgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391872; x=1777996672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/hpsE9ezKreWGn94AUhdvDRrk6m3bZ84ndpOq64p1Y=;
        b=bM4klUF1UbX/jhKafNWKhtczllCtKwmBxkTOXLzHANIyVcVcvQEUlWSLuhBjU2c49U
         rqGgs+wa8bws2c2OaJ0EQqW6CpawlDPO5GQy1t6+hDmaeZkWNoWjvjJZI3wzKAkTMS6O
         Pus8hrbihbAmSL12vxBrET6QlgVjfM2mhCWYoy37MLF3eqWkJFSW7o8/AZMbwsyWcVK+
         vPXJUSca/FBpJm0HEKhEIkSgLdX2EBeO+MafBhW9k7TPOyZFruHs+UHqwruhS/zHAiFL
         /NHhQDhdZx0VZSIqoGP4Uxawixa1aow9GmOSj7GXBR0wcfGu5sCQpbf2BkbNUSEyE0cx
         k83w==
X-Forwarded-Encrypted: i=1; AFNElJ+lyX50bQJ12Mu51ysxuTOIX1fDdAOkKU6B4UE80QC05Gx0OwT1UQjUjHy+S2l1RZA48SiPzUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tKkjCrt4NjE5TlfarF1LUQBR+MiHkpsRXnbYLeaxXc3qcRhv
	08T3mrRGBp66ddskKHXbEXAVXgw8/e3Ny6Xj1mfhpFHKjnmoBdpfQFc8f9ckwsV7iEen2lC/ST1
	A+JRGHCBhVJ6/ONYqs1DggvbF47Nv/rWOgQSm0FDX
X-Gm-Gg: AeBDiespF8DTmfXM6pECgOT9THGdYAWyyesS79bF+gomfXXHuM767vPTNt2l3ryVUOm
	R7phLH2Q718dgxjjcok72XjGb9Fuc2r1qiTo1F/XbfNm5SaJ9Sr6jMXoEdTyPTDHRXqIbDp8H11
	W1KcGLi1st6MFPhUzDBSG6czIW295LlhYTCE0ZijxyeGuk4u9VzdTx6RuZv+/9FGYPAIuXEVVxx
	BpGQEOBohBqqxhIiNCIQyE1gk0h/CdKD5O/oSQ72iDL+OJxnUJXd08r15CWfu02uFpoUZJXq//9
	wGJnGvXmRGx7RRGU5fsLCmOzxnGnZ12lzgWYQ3ek5r5z/0TJ+T61HrPgLq2SDAMpVLXq97TSqUU
	Grrorq2om
X-Received: by 2002:a05:622a:580a:b0:50b:5336:1d20 with SMTP id
 d75a77b69052e-5100e1efec8mr43160511cf.53.1777391871058; Tue, 28 Apr 2026
 08:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427132555.1791636-1-edumazet@google.com> <20260427132555.1791636-4-edumazet@google.com>
 <20260427161335.500f80d3@kernel.org>
In-Reply-To: <20260427161335.500f80d3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 08:57:39 -0700
X-Gm-Features: AVHnY4J-Mb0QB2sCwfpP4trERuhnI_jYCI5qiPYEs1NH6VV1B--ptjWUz-MEREU
Message-ID: <CANn89iLRNjan1OKDZSL1nq42cwNHKq8NHipq8-AND+Xe=pVT6g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6EB3A48886E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281965-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, Apr 27, 2026 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 27 Apr 2026 13:25:54 +0000 Eric Dumazet wrote:
> > +     for_each_netdev_dump(net, dev, ctx->ifindex) {
> >               struct netdev_queue *dev_queue;
> > +             struct Qdisc *q;
> >
> > -             if (idx < s_idx)
> > -                     goto cont;
> > -             if (idx > s_idx)
> > +             if (ctx->ifindex > s_ifindex)
> >                       s_q_idx =3D 0;
>
> I don't think we need this conditional now that we use for_each_netdev_du=
mp()
> We can just add
>
>         s_q_idx =3D 0;
>
> right before closing bracket of the loop?

Ack thanks.

