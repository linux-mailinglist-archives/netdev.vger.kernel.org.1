Return-Path: <netdev+bounces-266305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBgfEyt0sGnejQIAu9opvQ
	(envelope-from <netdev+bounces-266305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:42:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05296257171
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C1F5300D762
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE7351C3D;
	Tue, 10 Mar 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmp6i5y1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645A239E63
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171751; cv=pass; b=LYm5uwy3Ox7Sp2pZoASCvXf8jhcHeB+GVhUFphRm1WO9MKWmqIekfRVLfVacYEEbFkMkvT5pAIz/K7gHgTfmHoDL0X5jco01uXvPqCkjWblTVLsRG576Gi9b+9ONB7BiW/yBEmZibpc29T8Ykf39AILpnv7/7kKQ2n9WUyQmeAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171751; c=relaxed/simple;
	bh=YOPazVwyCUag60TOJ5EwGjcIbyWsLDxMHcCXTPyHcwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKwmFW9Ecpr7y1mAfOTr4AKNXIN8HshFiwStcGX0YsiOs4kSeiT7ip2iIDeTp+4hu4zq99LCqU8JPx1/j3y/OMlvkk8l34XqxJY85Nmvr7ClqcQZF0AMnv8JLDeczYXhK8yRBpwWCKR1r8Nfeoos0mHSsb3PIQgDc8PHc+2Q+vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmp6i5y1; arc=pass smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-66b0418ebe7so668385eaf.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 12:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773171749; cv=none;
        d=google.com; s=arc-20240605;
        b=GUrbMrqxXYwaC4NQE8/CruOnaN7xTJ9CLShnIFjQKziSFeSZufKOEiziXuTQS1xFsm
         esgU9G0sO4J09KQ4H57CqRGx/ovh4v0m9TgcEilKRwW+/Yq32H47BGVT3dRDS4j3HAZ3
         NMYpgvUdMzVlxnsftg7xM8npZ2QFB6TeNhhlQ8s029EgoXtWObhHt6IXdCttaKQqG4SH
         4W6xVpLq+XQQXxfYNCqh8UhHyWwRGG5cve2Q4K4DKAG3K7ZcsV0dUg5Og/efemo+HZjS
         zg8RWxW5SlELG8kXOHfB5gn1Cdxr8ypdUR9OE7Myk2X6uwXh1dXCrqu1K7epRpaqyDZx
         8XNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrSZmBhb+FpmdwQApu/RhAcQKR/9+Z4LOYsPgxaxZqU=;
        fh=m+MlybpBgAvXRatjRUI4/rwZ0BxaHes2eWqCG1qWzds=;
        b=dNfYV9/tDEQu4flLAeUtAuIXlBaycC9cD3K0NC5YtsnPeZfzGAqXsRUO1tCli92lU3
         y3xmihea3yBfNgyxrdTKFAxE2xjZhc3CPJbazUCy1aVroMxqDRqsQTTc5W8Nj3/RImGq
         0rfXOXFgODFWbnLatUQE29wzRCGJ2hb5310QUtjXKDATSdMkAvkIMmxlOpWYLirPpMW+
         18W7T3Hh1feohUq8YozNTzvFtgGI+7V6MDJQPg6WMkrEFbnzQQlJvGQZ9COQU7oswidp
         H2C+CBDd20TJ4KLe8o5/F5l0tEplTZs42cltCnVVraK2refeALOfR4tPAhZGIbl2Hr51
         4Kgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773171749; x=1773776549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrSZmBhb+FpmdwQApu/RhAcQKR/9+Z4LOYsPgxaxZqU=;
        b=Zmp6i5y19w3FbzaWbVTKQoy0XOnIRwlEz2CAgAnrcbdQq3NtmDSKJdclSop+GjJUa4
         rHIg4S2n5QMasr/LmxIQpRYOJ2AfIt3mIb0H0lLhm5JK2OckCADQXQQCMUxKwNgG/S1f
         LHxKCnIBRaq84ZSQ1kcKABpuPr7vpTaDlvtijOsr3EahwO5GWamLO2DFKwsK0snGLD9J
         7QASBgOSiELj0XM6+XYYn2HEweiV/sMfkJRQaisBXZSQ038It2+9t1YyO2oIe9MDHiYP
         uZANWKLULj/D3S4JpyD3ByzS5zibF5pWWJoTa+nQeZG8Jlmi1qt/VczHJM32+wXWyJs9
         iheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171749; x=1773776549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrSZmBhb+FpmdwQApu/RhAcQKR/9+Z4LOYsPgxaxZqU=;
        b=vKDutb7dVfwoF1IQqgy6MKzR/RjLIo4fwygrf/teQFiWeXfp+HPMeYYDnT6N8MGR+q
         shJJw5eJf82UvC85Pv7yNRUIOiftFRL6+1jCeiiSNLE4cRfHFlYqPxjS7zZnhHF9/CDm
         XFlfNRncn9KewqNkwp3i7LT8WaMABojSnLHwMQs2kMIxfIJJ8kvLn2MjLEZ0aMdY6+oA
         0GcxHUT4ezFMxVNmgHyUhnsZfZ80FGGP1Aow+xNaFY/sZeqc22Q+recfP+oRdQpiVkRl
         /QPCXdywLWZlAFvI9ED0ukBLEItLSY1hhfkxFWAGteLxZE7KJXyQv78u0eqOfLUcYC3t
         VEMQ==
X-Gm-Message-State: AOJu0YxsBUL1Ns9fymTdgQjOa46cqGPMhuXHgyXF2lV1kd+qe5fHysj3
	K6aE8U/YeuVij5PcIbzCEHLJ5+oZ8XhAScpiL+TShv1qeLjT+c7RyizKwdFKZa+1QBiI8pkROT0
	c643khMcwtdbhuV1BU/4kikft63hLdjE=
X-Gm-Gg: ATEYQzw7qUnZZta05LbJsNFiii5mm6ecUcRGXJ1t/TZU0IoSEZ6F6M4wUEsVszwp0nq
	yja4htNeWlfeS3qYSZTKiFgOJosSo+pBiPmxmE5uuTXV6gGZxzOHZ0vmqsWX4fA4Tl075QV0n3m
	6MVc0xx0vgfyEVXn6BD9ewTZx9C+FR/l8zT2wHBwvi9R6xpVJAsGLEed+KZNOyrj/+4ySES2qHt
	XdeGKxqBfbtCmJOtArlR5a0wT+vzaf6jChNMWYMWz001ZEorx5zFm6ROusva1uUrpLJbx7b/VDH
	z+uMHmv5NxNX1D9OSpTv9tQ=
X-Received: by 2002:a05:6830:2681:b0:7d7:4c91:13ac with SMTP id
 46e09a7af769-7d76a78717emr59149a34.5.1773171749538; Tue, 10 Mar 2026 12:42:29
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-3-weibunny.kernel@gmail.com> <9b7c4207-1bdd-4d56-a3fe-ea3e25e62559@gmail.com>
In-Reply-To: <9b7c4207-1bdd-4d56-a3fe-ea3e25e62559@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 10 Mar 2026 12:42:18 -0700
X-Gm-Features: AaiRm53pc2qKyRqXBOJscIxo6uizkt-y4pK4WTQ22jv5BJG6DzzcAjn-zuXhMRQ
Message-ID: <CAGqc4nUrYicU82F01vDB0kiFa2b4j0QW57AP2vrPT5fs_G7oFQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 05296257171
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266305-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 8:08=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
>
> On 3/9/26 2:34 PM, Wei Wang wrote:
> > @@ -131,8 +263,7 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd=
)
> >       struct genl_info info;
> >       struct sk_buff *ntf;
> >
> > -     if (!genl_has_listeners(&psp_nl_family, dev_net(psd->main_netdev)=
,
> > -                             PSP_NLGRP_MGMT))
> > +     if (!psp_nl_has_listeners_any_ns(psd, PSP_NLGRP_MGMT))
> >               return;
> >
> >       ntf =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > @@ -140,13 +271,13 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 c=
md)
> >               return;
> >
> >       genl_info_init_ntf(&info, &psp_nl_family, cmd);
> > +     genl_info_net_set(&info, dev_net(psd->main_netdev));
> >       if (psp_nl_dev_fill(psd, ntf, &info)) {
> >               nlmsg_free(ntf);
> >               return;
> >       }
> >
> > -     genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev)=
, ntf,
> > -                             0, PSP_NLGRP_MGMT, GFP_KERNEL);
> > +     psp_nl_multicast_all_ns(psd, ntf, PSP_NLGRP_MGMT);
> >   }
>
> I don't think this will work correctly when there are listeners outside
> of dev_net(psd->main_netdev). psp_nl_dev_fill() will prepare a
> notification containing the unfiltered assoc list, but then that will be
> broadcast out to all listeners regardless of netns, so those listeners
> will see peer nsids relative to a different netns.

Yea. That's true. I can't just set genl_info_net to
dev_net(psd->main_netdev). And I have to compute nsid relative to the
netns of the listener instead of just using the same passed in netns.
Let me see how to fix this.

