Return-Path: <netdev+bounces-282486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE2jLWpu8mnbrAEAu9opvQ
	(envelope-from <netdev+bounces-282486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:47:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FF49A3DD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB8C3017065
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7FD3A5E98;
	Wed, 29 Apr 2026 20:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvwZPjvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D838550A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495654; cv=pass; b=j5tSbMlOdxZv8ApXeDDZT51Ql2SD0rZsjVaeWyvrmxWp6JcUfxs6kAnGy1AkG0UTaBWzXmsBNl0LGBcfxu1jWJqPG0uhaoVmoa0YQW2JCUNilGrFKXNQBn5MYSMdHWBIZ7B5FzxQ1cxiCkBrffk7FcNZMJaZKc4HnCC5Ot+fSq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495654; c=relaxed/simple;
	bh=xxpVo9VADcJWZ5Rw/BcfOodgHejdClQG1LcA2vjR+9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uflLxWe7qV9Ae8x6Oq0Jvurr4kdvERIGAVv3bMIFSnz+YwySHrP5f/nFRhJcjIQoSyM6EJXMUL4zBtstUI0p+6sIDBlsCMddKiOqu8tVK2vUDdGLDmReXxe+P5kET6YtwFwhonENSgNquiA7JA1QmmB2YtkimMj2cYzUyY2hIi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvwZPjvm; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d864c23bdso61161cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777495652; cv=none;
        d=google.com; s=arc-20240605;
        b=K0rwdNXVp1LDKyJ/183ZoSGu8fOmlOKgFCbQsyBaow69OI1gzPyqIf1KgHvL7+T91X
         YtJlqwnCFYSbtr/dAYlBKGHurYtk5Hwgxzl8u+kRdweR8ZG5+qAvmNzNJb2r60rJVnIq
         D7gy06zGkXGgqnGOruNk8+LM5mJEdpeuzM0INjplNuvZUVMbNW7HA66NVkzOjxTrgvXz
         EBKfuuconhLuNPgbW0FKT1Q5QGJT9ULlk/zplCkvyrVRbW7iSVmmK/w//CQjblxjZTkj
         mRvBg5tBRmqJzM/otAYHjxeKrM6cEGajHsKe339MCyVciLM+QHQyxIGoNNyQ/iz2FmY4
         9eXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecRuB/6i+9UMzvvn/8bl8OOBs0mGsTmgmv3uTcJUmxE=;
        fh=cH00qHlPL/yYAeItXk4BK+0GatxFg0OfJQnfbxHzcN8=;
        b=B7HavOI0zvKA9mxsVKlUTGFVs7F2Ks2hBq24Iifa4J9CUic2ZBviiKhH/ZhEENuTYL
         UFkJ4SbDazhsc55WZhKU2O/3bC1xOVBY2Rgjld7sz7G9jqXsyyW+wwXrC274ApI4CH2V
         HSg8x4yY97/vPJqQIfJcn6gH8uZ9Dqvr7GW2dQhfOLPDr3BeoNdkNvIeKwWvf5B/Jmdc
         DqrTotUVkRCE6yV7S58UuhIX57A6qNPhb1iMOwAstAl7U+8VNda5fe2EYEchVIfWucNf
         +2YaUdc78MnZareH/i6b02SKVxzzejbzWOSg55af8C4CYrnUdSYpT328dlOwC5FGK81D
         Rbrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777495652; x=1778100452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecRuB/6i+9UMzvvn/8bl8OOBs0mGsTmgmv3uTcJUmxE=;
        b=AvwZPjvmTNMPGzhnkdyNWRobnbt/Uq78IpdsxcHL6is7MrLHOScCXkykJuwOMEPJcT
         rNgqIg7Jzy0arQJCwCbsSzow/Y1MIWbVYRGtLvFIoGcBV/Dv+5VrRHOrvXpKj8Tw16nh
         TlIWX0ye864YWDD5U+eBB/ePccuk0Fq4wLRGbKJ/pM4U7Giw8Dohhy38Lr5DYrct+VBu
         Lxwl+sUNz0zKe8xPopqjgWVLpunJwIrnt8AO94uQo/7mLcaWj37Oc+u5kbfnRv8BwsUT
         Eo0ULZ9fVQHXOjsqy7OQbVglUXAxQGspppDRxoJlbYRK9gIAcAkB08NCv54OvmZA1GpL
         BWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495652; x=1778100452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecRuB/6i+9UMzvvn/8bl8OOBs0mGsTmgmv3uTcJUmxE=;
        b=UksFxsQyM27JGaTeNfH3TxNdZYwlo6UIatQe1uYAfrdooSdcgxyT9gg+CYn6oNKGpN
         UdksCyWuqRVAP+sKMsTLJYQ0aAEko9I2SRBiKCggYWiYvjKwUZ1jmdivpByKiNzd+1oo
         iPeosUHQF4BV+58p8WH3JolT4fPtlJRA0bdlAr9E+WDfGHWpsfwJMtzEnaayWy87klnW
         yIW0SV3nZLInF2qKaZU+Gk2ihhIADIJCK44wfVGJu5t2rqrzXzaneKRGiJlIsmRzPbYU
         O/1Pf1YAcOlnjaxNZKBOxNmwegz5g/SZNiWKbkuPZWh4EocMCnWIvmsNnGZBLUQtIQPv
         d4PA==
X-Forwarded-Encrypted: i=1; AFNElJ9032hMlJvsrn2KrFLxbHUgcyH58ymdgIMWFbvbm3k5CoM7yo6ECl99euaI9yrF6QDyltOZI+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4PkExTOhqvhDjAu+YnzM/P+tfWcYeXyK7J+5kUa7ON6yuEnI
	poPvqSXozktjwRTXGhwD8L/nXddhhlCvW+wXniAOHjfIa+yyES5MaLZctsgizaE9I/FDOMP/uMp
	AZ5QByVLk2sQuYKDDJJsyq5UivmDd76Lo5i2SfoD6
X-Gm-Gg: AeBDieu97QENnKiFSDGHyQVMcibWZfW3UUY/79YTiJYu36My7pKuxJjW67pTXTCI/sl
	CWOsqDZX6UI9T0ulXxiefeNolrZqBPEPXokpNoJs6X0F1kuedU02gVGH6aNy0yMgPHo1Vsr7+Ok
	mSP2l4exlg9dKJ9flg+DHaVOxDCU41lEsHUxQNt11wHE2UM32HWSbDvuan3mV/aX1IUCr2M6Gzo
	06ZXQ7LarUi5zIifrkQLasCAhFCHjdB2hcEgRFG/zHtZ16ZFvqyq23uXPJxZ1cnN7QzGsIUh8AM
	H54upYMt0NlSh9vZ8WV8vaxZgSIBWLHYuqNHPMecb/8JdWetbH6cAVgpwVCooH9lAsodoq0lma9
	KFBzIhc26RLTYPEW+UQ==
X-Received: by 2002:a05:622a:1f94:b0:50e:38f8:9885 with SMTP id
 d75a77b69052e-510286340d1mr3553681cf.12.1777495652017; Wed, 29 Apr 2026
 13:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429080036.1528533-1-edumazet@google.com> <20260429094805.1aa6bf3c@kernel.org>
 <CANn89i+KuSf8PhAsf7a=h+tR1c8aLNdiM6NzaBU8tjpoLAfcQA@mail.gmail.com> <CANn89iJrvSvw2XKvB7LfXc2egeaqC+seiCiKN2USMw9gicqM1w@mail.gmail.com>
In-Reply-To: <CANn89iJrvSvw2XKvB7LfXc2egeaqC+seiCiKN2USMw9gicqM1w@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Apr 2026 16:47:14 -0400
X-Gm-Features: AVHnY4Jwb9FMxPT6sFCf7y7njQjHa2dIODiRifvFUF1cQqVk_n3xvMyvcUMDKsE
Message-ID: <CADVnQyn-U-QgyT-HqeqZVX3FJi-UCgwfGJk2VaBBhjajKoih6g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 375FF49A3DD
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
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282486-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 1:15=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 29, 2026 at 10:09=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Apr 29, 2026 at 9:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Wed, 29 Apr 2026 08:00:36 +0000 Eric Dumazet wrote:
> > > > This test checks syncookie mode is able to reconstruct some
> > > > client options when TCP TS are used:
> > > >
> > > > - wscale option.
> > > > - sackOK.
> > > > - MSS (in a limited way).
> > > > - ECN (not tested, because of limited value).
> > >
> > > We're getting:
> > >
> > > # TAP version 13
> > > # 1..1
> > > #   File "/tmp/code_oyWax9", line 223
> > > #     assert tcpi_snd_wscale =3D 10, tcpi_snd_wscale
> > > #                            ^
> > > # SyntaxError: invalid syntax
> > > # tcp_syncookies_ip6_9k.pkt: error executing code: 'python3' returned=
 non-zero status 1
> > >
> > > do we need to update packetdrill ?
> >
> > No, this should have been
> >
> >  assert tcpi_snd_wscale =3D=3D 10, tcpi_snd_wscale
> >
> > I initially had a value of 8, and decided going to 10 just to make it
> > different than the output wscale value.
> >
> > Sorry for the confusion.
>
> Neal, can you take care of adding TCPI_OPT_SACK to packetdrill ?
>
> Thanks!
>
> diff --git a/gtests/net/packetdrill/code.c b/gtests/net/packetdrill/code.=
c
> index d90bffabcfe6..6d8d20e64d8c 100644
> --- a/gtests/net/packetdrill/code.c
> +++ b/gtests/net/packetdrill/code.c
> @@ -129,6 +129,7 @@ static void write_symbols(struct code_state *code)
>         emit_var(code, "TCPI_OPT_WSCALE",       TCPI_OPT_WSCALE);
>         emit_var(code, "TCPI_OPT_ECN",          TCPI_OPT_ECN);
>         emit_var(code, "TCPI_OPT_SYN_DATA",     TCPI_OPT_SYN_DATA);
> +       emit_var(code, "TCPI_OPT_SACK", TCPI_OPT_SACK);
>  #endif  /* linux */
>  }

Sure! Done. I added all the missing bit values in the following commit:

https://github.com/google/packetdrill/commit/faa0dfb54065118625e169d3111ce0=
9c65b20229

This can be picked up with the following, or similar:

  git clone https://github.com/google/packetdrill.git

neal

