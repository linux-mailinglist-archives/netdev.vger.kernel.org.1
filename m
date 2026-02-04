Return-Path: <netdev+bounces-256582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KLiCpncgmnwdQMAu9opvQ
	(envelope-from <netdev+bounces-256582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:43:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87778E2108
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279273040AB2
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95883346B0;
	Wed,  4 Feb 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHbNPSYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D834D3AC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183800; cv=pass; b=ss+Lw5pq3j6c3ZHJ9jlqfKDP9SjvfqdW9gYUbLC+ZZ/bA/cYfHz5Le6DMEfC9FWa5whyH8P9v50yap1wiimEhsiN6j6TBAtEe8kpCBhJ9J4aQONtLMJ+MdbivvSeMSchIx8mA01zr8R6OJujy6LTCQeB79A+onM7CaTqNk55m1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183800; c=relaxed/simple;
	bh=YS/JI5oDud4CqpAKDSc7NIj+IXRDl6q2PzofVecr2ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQJCsihdaF9fAJ+oZFVmyEUKl/Q4amCw5RfwgAOg2UdFoD7YtW1vnbO61A0mXpE4UJvXzVG49CJlE84dIJz2WSLncapz0kRYU5ACTYaie0Ap8ZBygwZ+Y8J8qy3uTY7qnQs4ku4NU+wpRa4BqPQEG3zBVM46HsSJ2dD78FvxeDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHbNPSYm; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50336cffef9so49857261cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:43:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770183799; cv=none;
        d=google.com; s=arc-20240605;
        b=c+uvfp0i39eq3/DWu6FXjUHYisN5E1oDoxf9goYca+YeZgV4t0gDSNy7e1HNjk7Itl
         +P3yAmImS96XX2nwlwDUoFvb5OCIqscURespg/R0rO4UieZ6njRsjVd/HTaSWXj1/0jB
         cCyPgharNOpO2jDzK5H/9xakYGlYvw6HrEy7Y5USJN4l4Gfz56LlwdtkNaHUnnPSansJ
         YBBmma6YPMNVN8b+vVIlgT5GbBIPyb/F4ZzZdwiQSw++Q9NkzwcIV6lvgfec/69niJ/w
         LfUkO+dZLHRxettor1k43oSnQ13wmRd1Sq10If83uPAGZo0XyTP+B4/zoW51Ci8BUgFF
         R6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mv6ey1b3qhO92fUMC+ZsAtELLnKYerUkaAjffRNerck=;
        fh=rkr3KcYR71AkKvUidxz3LLGEgQehwiCohQKxFS6gmsg=;
        b=AraxfwhQfV0eP3LrCwCQML5mQsMr5yNqMlCPJUfAyAicWDxo7D0J5iJf8vDbBM5FAy
         Jv9DAOBbmw0r89EtFagLSDiuxij0HQAad4EZPK1kFBLhJBACVii85lfC/Ii86LIhkO48
         ZD+UUOmYBsBQAFzauNbF4OV9H6anqldeA+0oXPDxnEaBvNWSet9Lc+nbIZe1c9RQdRbl
         X0OfdvgqruRW5tOql/DWlF074xJAA1rcrp90JGsOFP5YmwJ/qkNzWT5sT1Ta+bbTPYaN
         YOX1cHjo/jXfvxKXLKG5J1puUnLAqS2KDit4Akw5GWSKYeTbPJfnDHPuCyEhpYl/A6nw
         iycg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770183799; x=1770788599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv6ey1b3qhO92fUMC+ZsAtELLnKYerUkaAjffRNerck=;
        b=FHbNPSYmTf1wJebyJekv6kkoj2GRuUaOS/lGwxf9Fo5K5Ny5v2HLJzh6rqORysZ6g8
         ApgbpgrTV75msHpPsbcF9dHOHXr69/gXyDzeBFATnAq9K7DOZeGRZI5IDDEdHcTllvwF
         vTFxaCHyGQFKn1YE1z9La/cxbC6nvEcMfk2UZTMEWEnJaTWBLQsjLgKdtw/HzCKG7dKI
         iqTMOjcusURMNWGpDvRu6Ktn2ZaVHDUgFtWV65in8lkoIozuWLZv53Qwmlm05RHkKOVI
         g1hvTcdW0V5zFdd22nlZY3LGqHWDQ4TuzCeatw4o4y9q6hIB0+iIVIDZMVcXkAfqm7nU
         0dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770183799; x=1770788599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mv6ey1b3qhO92fUMC+ZsAtELLnKYerUkaAjffRNerck=;
        b=JpdqPaulIvcMPR267M34iBiWdRG4iEAyjbfqax6Kn+aV/yjzNrc3ouBnWb0dlz49CU
         GQc9nG37f9WNFbx/k19PZqiqEY/wxEspZOCihPIshBUQvpXp665UonGriNMg2/DT/MSK
         +C7mouns49V0XllX2Xf/vxggRL4IwYCooMQCuxZ897AFhd+NEXWYYUrjtdkHg64fiOw7
         tiNUdUHfdZt3BHZ2mu0jnnLdOlmbpkwdavGgrJE9nK6UI6qO4dlDq99K1XvgHbGTzgSn
         A9gS+TI3QOFKSAIZQAoN4V1PwbbZwicVCI+SUILzn06tqg+31pk09yGq19h7/t8Q5Q4/
         8qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOHRWN4/e7dSz/mPDnCEGhE/X+n/pFajem9q8wrVb+Pq7OrFIKJ+U3W75hO8Lpr9fUZ7zmxWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMSun/ucUW2HTpTq6lVNQIv5DFT4mJRW9u7xHbv+ucX4ZRIPX
	Miv5fUgjZBIn3VlGKJ9XHFiLTe5RibvtMEDC9LEQui+2NprQRUo0CUUPK24vqPxLb9Js55nwiXg
	TnzZyKFucbOT0qjHjntnqmFj39OOxmRTzQvAuQgLs
X-Gm-Gg: AZuq6aJlLV7XmTnoRo9h4Ra4RYeoGIaZ6HoI8roymTSmGCpeAk2AxTQ8ylqtrLpRJa+
	HWOLKKff2TbTm6lie0PTpsTq+YWPi3DtWyRBdUTQx/EZgaAsEYmpFznNtdQtsNTYEbru1JdTgwp
	a1RDFrBoNPrIrdB/u7qqENkMnUGrd7GWjTz4zlklrK8gzL4vY2rhoFyFUhz9rl4IhjeoEn+q/0H
	NHN1OLVefSWocUEAO+lrF6EZuiT8Iv9OL8h+AKV3dwsNeQH6ewbrPCQyo8I2PCu9DLkzfdsRrsG
	mJEL
X-Received: by 2002:a05:622a:254:b0:4f1:b93e:d4d8 with SMTP id
 d75a77b69052e-5061c1d78cemr24552511cf.71.1770183799048; Tue, 03 Feb 2026
 21:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com> <20260203052210.3684125-5-edumazet@google.com>
 <CAAVpQUB3QEToRRcUQR4C2_K2OdwDa7sHQuuhA8K2Tbpkad+ocg@mail.gmail.com>
In-Reply-To: <CAAVpQUB3QEToRRcUQR4C2_K2OdwDa7sHQuuhA8K2Tbpkad+ocg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Feb 2026 06:43:07 +0100
X-Gm-Features: AZwV_Qil_CmdlISx7QflL7INQiohg1O7dEwofFLrfYosZ7xak9wMFRASEFYrpWA
Message-ID: <CANn89iK8_f5siuNOrDMLNL2ctSN_rYyuDFRh0iWbpAnUuvkBug@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/4] tcp: move __reqsk_free() out of line
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 87778E2108
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 1:38=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Mon, Feb 2, 2026 at 9:22=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.
> >

> > +void __reqsk_free(struct request_sock *req)
> > +{
> > +       req->rsk_ops->destructor(req);
> > +       if (req->rsk_listener)
> > +               sock_put(req->rsk_listener);
> > +       kfree(req->saved_syn);
> > +       kmem_cache_free(req->rsk_ops->slab, req);
> > +}
> > +EXPORT_IPV6_MOD_GPL(__reqsk_free);
>
> Probably this needs to be EXPORT_SYMBOL_GPL() due to
> drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c ?
>

Good catch indeed :/

What an abomination this copy/paste of TCP stack.

Will send this change in V2, thanks.

