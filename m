Return-Path: <netdev+bounces-299130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xqySLhUlLmpvqAQAu9opvQ
	(envelope-from <netdev+bounces-299130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:50:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82E6804CF
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b="DziB/dQ0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299130-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299130-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D8AD300A124
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED44244694;
	Sun, 14 Jun 2026 03:50:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4960613AA2D
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 03:50:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409043; cv=pass; b=N6fO4CgD4OwEU908ItwZ0Bpxy2HsSzgCKjKy/Xnx1+vBniWakMKhgLI29CqE+go9YEzl+LXyI2x8BfemGJmAP9Lsw5XNeUmxFp+ArNjkamIjs8Dbe/weEDfQxCHQFlE8dF95HYt42juMqseAxQAja1XqynkpAH6M8iUDMcoy2Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409043; c=relaxed/simple;
	bh=KkfiQerEAQFPhNuP2DUe3isI30rRJpWqVG7KeJwWnPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb5FiEvpIYDSo7Wrsjs5aWtCReMcR81LIKu7437ujtGE0fuhuyvu1JMcic5NmTq0+zkA75NGRmDtztih3wPrg9C7pYcyb+LtCBmZHmEN0V2KVu4yLcWmqV+GCA/db1ETZvRNVGjB82w8M+XPybrN9JFNTf/Y15Msg4m8B+D51Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=DziB/dQ0; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf237e1433so27067305ad.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781409041; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0Dn4wH3tqjFLUQwVtRA7B4NT34up2sU1nxn5WY3RUITq2adrIakQrpPD4oYWSfza6
         N/CcPsMMOhlqMrruqZjPoc5fLDqlQF+j88Gx5wBXQKwEwvDNdGTTRwXGSV9d2cN6JNzU
         Im30sKFQ9iM29SSPiQPG+uXKbGgO+1DWtc7+hVnHrNDZtlemFBllnctAR3LT+MTH/EeH
         O+oDcVepV1xi6z2HBHU5HEr3YXKExMdUUV287fD+/WuCkuQHGdMe3GA802jbqRWNYOJg
         OrZ2Iuf4kztIDJl+Ed2sh4/TmexfhASahtjRpQXLYriAloxD2PB9KuB/PuSnTY5k9b8b
         3XSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YgtaJRtn47yniJqSuUEdgEZ2iDNmLr75v1SjdgEcQJk=;
        fh=ZYxaXIYMvabb9dHeZ2FhzI5l0he1avKb9pG0M/0Xuwc=;
        b=bffsUMs9kXQuw2JwJ36kgAmX2JhN7h+AbEBB2Ll8hR5BxtfeR3aRO+VqP7qo85UI+8
         UYfsewArNErG+WDqFZ4kzLP83mtQlcOkfqw86vXpYoXgGr8m6XnDvAYr00DfziiYHVhF
         dNiaoI3wrLFVhqX/BdpL9MXwRsVDfowxtN9dG3HLosXk1FlURfgJLmosGJWMoiOSVNpl
         K8KVi04wqkbanJBcZTU6263oZSA/RRH9VXk/R0h7H8ON+VTUjNFo3akqQZiMRjibJjz0
         NvohBIh4yHe0plIuN9gE+iM+eEusjOKi9bg+qsQXe0AXKZTXRfoX3EASPAGXZoJrjMFk
         07kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781409041; x=1782013841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgtaJRtn47yniJqSuUEdgEZ2iDNmLr75v1SjdgEcQJk=;
        b=DziB/dQ0dk4UN96Lma9S2lAeXZlrfSvrwCfwQP3UpV8mxjoWfrQH5HH++szANIXbu/
         801T4aNRY4YZOo2UfrWidKSSuETIl9LlLySAvgNmKkhiwBLeiS5tC1B9KYCDn9HAt/Rr
         54nVVXHapdZnZcSAngwgwPtdnG6KVY7nZxTCi+QghUfuuJf3mqbHPeV6DHhnYWUVuBmQ
         t+36/vecslTLTTGkeIltxO/bMPY2vLY2HyJo5NEslvcm1//X5Ni3HVtg5+VQ1nEV0rIf
         O7gGJKXnpSt7rDHM0xH30swkWzDAQR0w140DEzoeDcb4PKFEvVF6CRwwwmMRVo6IBjau
         ULkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409041; x=1782013841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgtaJRtn47yniJqSuUEdgEZ2iDNmLr75v1SjdgEcQJk=;
        b=P4eCCZTz4X2ZgylFxBj8c7bA6w+Amtrf72nNxP4IR9Nx3/FB/Qedw8SyyZqfLyihg1
         jLmxY2TMQUhM0amqmcgKjo27gRAC/6DPQEH7GdzuV/kdBUY8rg7ckwNWr6On5q1W3HOQ
         1d9779B9sS5i/aOt81PsMEaARUAVsq1CQK+TWKWaliAdZ6fZLGkxhq0pYWUiuKM75Wcr
         lbUGJQm9XqVt02FSfcBN0pzG7edFwLX+Wju4zICOSJOI+fwx6ac5zmUvvOsiyv2VZ9cy
         nYzFPiA+1dXTw2lyQmKXneybxu36yiisnntU8vCeuU/nNHJ3zb0fWaPy4S24zYPDjb8Q
         NHtw==
X-Gm-Message-State: AOJu0YwzL5goT+/Eptik+LYPCPqWKmmK340+I45xNQg19BG2/LiVNS7b
	iM4XIMhxE/srdn//iKXfo0YgUoL04EDQNGDaTWhA5hRJbzUOsE/OTAUkTqC8Ac8ScUx3VlnnTDZ
	Pfr9V8P2t3StEXPDwrN8bmf0lD4ACETxwqtAnDqjV
X-Gm-Gg: Acq92OE+RNzH/aKrCIETegMpqxCpLUOw0sGyQffP3zTH1QbZEg8JJCSvSYOK0ClWQ7y
	SSoU1FUOgCnoKrMcFhv18WQ7ykD4qXDTLSSh46BjgtK26fpZnGFfvebweZYs83KJfBWCgPZj8FB
	AggmKSQ2iUkdhuIjrvtOuyA7k6QKDzed7tTYuXLN8tePiI2uQma4pWftZvVFDbseYGlUjXiHueX
	pDHeMC/6cJMC6RXSbpFBjKswjpq1bWBl/Nyb3NjahEaVlliGu22Dk62WqtwM/UnYdl1LcH7+2nX
	y3pCdR42zNMrsUdDhw==
X-Received: by 2002:a17:903:1aef:b0:2bf:2e06:2ebf with SMTP id
 d9443c01a7336-2c412653828mr105149065ad.31.1781409041635; Sat, 13 Jun 2026
 20:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607031640.2743713-1-xmei5@asu.edu> <20260609183018.1764046d@kernel.org>
 <ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel>
 <20260613164820.491226a7@kernel.org> <CAPpSM+RuCaNoYFN7JKGDeUScK2-xLjSULA4i8bnChmG05hBaNA@mail.gmail.com>
 <20260613171052.0dbdfea4@kernel.org>
In-Reply-To: <20260613171052.0dbdfea4@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 20:50:30 -0700
X-Gm-Features: AVVi8CfIDXQxjAOpMhwjcCdLmtbxBO4EuX00PcRD11tCRNjH-csgI-daSb47wfE
Message-ID: <CAPpSM+Ri4KA+L33T5F2MmE07YdN4QYq6G=eU1b1mpi2+fjQjCw@mail.gmail.com>
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in PSAMPLE_ATTR_DATA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,asu.edu:dkim,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D82E6804CF

On Sat, Jun 13, 2026 at 5:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 17:02:39 -0700 Xiang Mei wrote:
> > > >       if (data_len) {
> > > > -             int nla_len =3D nla_total_size(data_len);
> > > >               struct nlattr *nla;
> > > >
> > > > -             nla =3D skb_put(nl_skb, nla_len);
> > > > -             nla->nla_type =3D PSAMPLE_ATTR_DATA;
> > > > -             nla->nla_len =3D nla_attr_size(data_len);
> > > > +             nla =3D nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_l=
en);
> > > > +             if (!nla)
> > > > +                     goto error;
> > > >
> > > >               if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
> > > >                       goto error;
> > > >
> > > > Let me know if the new patch makes sense.
> > >
> > > I assumed the author intentionally was avoiding the memset for
> > > the memory we will override with data. Otherwise the whole dance
> > > could be avoided and nla_put() would have been the answer.
> >
> > The reason nla_put() isn't used here is that the payload source is the
> > sampled skb, which can be nonlinear, so the data has to be gathered wit=
h
> > skb_copy_bits() rather than a flat memcpy().
>
> That too.
>
> > There is no nla_put() variant that takes an skb source, hence the
> > reserve-then-copy.
> >
> > But that doesn't require open-coding the attribute: nla_reserve() only
> > memsets the alignment padding (nla_padlen), never the data region, so
> > nla_reserve() + skb_copy_bits() writes every byte exactly once with no
> > redundant memset over the payload. The bug was that the open-coded
> > version dropped that padding-zero step.
>
> I find it hard to believe that nla_reserve() was not considered.
> It's a widely used function in the networking stack.
Thanks for your time of discussion. v3 has been sent.

Xiang
> Please move on.

