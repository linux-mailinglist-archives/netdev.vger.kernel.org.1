Return-Path: <netdev+bounces-290665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIsyDD3fD2rQQwYAu9opvQ
	(envelope-from <netdev+bounces-290665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 06:44:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08E5AEBFE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 06:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07857300A332
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA303314C2;
	Fri, 22 May 2026 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdDSC+L0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B72335BA
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425082; cv=pass; b=DZ3bS/SErTXo3oa/vAQwKCWTGu7Tw7UQGwTUPk17kEbomyEYHlW/7fnHfbYXW4kE45faM40uEvtDVUfzJCZkX55oo3r6UARCZOL7QG8hgkA05FAXl29iHA8SiMW/0fD3p4EkC7aePLZK85z7Rf1q+tXNkgBrGBOeCObic+daY9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425082; c=relaxed/simple;
	bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZgf5yK3tKOo2aOlvXOhWd1c2pxAes+cdqsdotXUgfhJCXTRR/tlPtiKoLrF8WlansiNWW8Vjb+c84ULUdKdextv/5Ea0AcEDy6SaHEnZjgVik1rA/B1cnH1PVnEJ0pHblqs9HUKMQvb9v+06r6PQbGnMcpt8JBqHIdfMXi57fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdDSC+L0; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516cc5471bdso17269621cf.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779425080; cv=none;
        d=google.com; s=arc-20240605;
        b=DDSiDrIhXfWJH+Y7M5xJAnk/J6Q09/uSoWb8MLZNp20MsopnDPQklI71Cea1tbU/oi
         g12n7TRlfR9BQvEHMzvYfY9sQSiVdMb8dR7j/pgiRPw7zkxNzttiEc9hFicUxRReuWVR
         HOJmhQ0BpOJ8557E6MUdHGsu1H/uOqZdSQBjCv6E7cdGTTPgrRbDc9UcH3DT1REyIRtR
         2ty5I2Nh0l3mbKRInv3jg+fkMhuoXV9QxtQXFtuZ3T4EdllABgLHCYNbf7ifcDqa++Y2
         rrbEJdKqsr4V6zunx41c//z6O+AhXoMBQQJOOGdrjmQ6kcmi3pra8hCMM8dXdtbxBy0U
         xRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
        fh=6nWDXlK09WpTk61/yVE7YyfoShccJE3W4qCgrssOkUA=;
        b=alZXpIgI5NCPyRk0PJwLK/GLRd/pZcT9gCCX/wduHZfvD07RlT6vS955bU21GR+Y7N
         eAkI/zQX03Gmltmke+ME5F812B5VMv8bWB8aCuvuu+Wpt9FjSyJaf5VSPAFDRhI/JN3W
         xH7s1VlELJpUYLlhKqM35DbFRSPfsJpqiJbLUV3uk07dxXC5kXtqFUNJJDmku5kiq4Gl
         1zkThHK4oPszgHMMm5X9rorCU7W6woqC6d3+RG+s4Uh3aAK1yXMVQBnmp0g4A2yvAV6/
         ns3oOeMHqAJfmFfF0gO8t1w3lNFt0EOuzmH0gEhscPe0I9SUmvCmARIFypp6WE2MQ0Ss
         XISg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779425080; x=1780029880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
        b=bdDSC+L0fD8QLbKlv86FelhVK1Wll90JKLCYUVMv1dYuH/eW+PO3SoQfXRMR8wQRw3
         IlmdIyZw3oYsUE6Axp1BW9fztETMptgU5CrGeW26CAkwpKXct/kvkg8YyFTgZGjA42zn
         OSISzFATCY8fi9B9gqYG8qBdQk7f4kBXq3ZSAUxFpXUDbbqY4BitNeIcOUjhHxSHcfSU
         vbnIO17GXzJkGUVi8pSsWh397HUzScyDCOTmHMNSGY5h9QvNw4vBS9S+pUgLwto1XFMu
         juowsmaRCrHvT4XJ0vvb9Xl64bG0vnU+LazaEIDYNMUVx8jNu+Uuup5tdpd9lqzZb5Eo
         Uhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779425080; x=1780029880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
        b=Ee4GIU0iqrVHaxBa+t4LHNs0BoWZQcbFO3h9QIdGd7n+yMjnL7+CaCOrL08G8CuRTX
         280YAl8dh+AC2Htk9urBG2ppIEgoIjomG5KrxmnWph2WB6pSsuAUFHX2PKgiDKV92DQo
         hNaz2PxSaFytYT2Z3vz1TMY1fzyna/LenHbLc3hEhwN2GMi/ob4SHwAOcTIlB5noINJl
         Y3lQUigYcVlJG+t2/xJdc8zXcrb8JpuOxSYcSkIVPrVxjIYcH/t6CozDyfF8dV9HcqWO
         GOzzmMpOCJ9DDKPhk444t/ZCJqruCawHHi9C7Uy0fa/p5Z26nlO5af2RlbBqTG2CBYGP
         Rrbw==
X-Forwarded-Encrypted: i=1; AFNElJ8zslHZC4BuptG5K1/kRHiK+DdmN9JKLMdngbG8PEyxi2WxZ/TQvPDdDQcJ5y4HBr1jYtyLJjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFRzba3Fteim5kGwHdU13GSmlmxIxH7E6gs6EqtbyXSwyWSJU
	3oBbvfA7IE0nPlswDqTpl3jXoQkno2NXj13Kt8cUfagIjV74coc4r4sOQLkQNYoTV3CLYB9pqXC
	UsNuikG3FikHHqRvr6w3jmv2ad1XN8uKAoeT1qr/CXhV6FBp79Un06dRg
X-Gm-Gg: Acq92OH64SoW3gbwvodvN4lAn+LX055+ek9664aucY2TLOp2jgIPlFLwjPvVz3XQHIP
	94r3fmVQ/5sUoMf1pkiz5qRXytg/zsEfu34QpyTFm7YtJTFLXitTx3oCfLy0arTZEhySAnCWcVB
	LEaIDlFHIJnMNC3O+r08nUxUMCkzF6wHdUFH6v2RTwD7y2SxVzaUkY0GAblslF/x6xp6lS85pmq
	khndzNt77mNafH9iK5i4FjldNrh70XkKow8WE4Ka2kuIG0vJ1yJja/JK4R5mxpV2fTvPV9X2oht
	Tja/g98YcMHD1NMIKtpqtH2I5SSnmhfn8Bv29BO0Uu2fkLUADjlS/91MScbdaYUMaj1fpwBAbPY
	BCuaa+9vj3CSh01LchVqPzwKcNUvoYQv6H9qv5wga8Nx1QVwFjLNoE48/vCMHOfPR
X-Received: by 2002:a05:622a:19a3:b0:50f:b904:454 with SMTP id
 d75a77b69052e-516d429ace6mr35034201cf.11.1779425079512; Thu, 21 May 2026
 21:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
 <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com> <CAKxU2N_63D7SFPkr9H9UYWif2DRW_qnV0SzZoRHWcRZtC_HTWg@mail.gmail.com>
In-Reply-To: <CAKxU2N_63D7SFPkr9H9UYWif2DRW_qnV0SzZoRHWcRZtC_HTWg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 May 2026 21:44:28 -0700
X-Gm-Features: AVHnY4IwHXQN7oTjZfKPdY-BOjCmCpO8SOOCKwqxNusbTrpv-CvTAEc7R2CudbM
Message-ID: <CANn89iL1fC1UB=wE23Q7rAkQfFNE-XEZaj7bGybbZMNKkfUEHA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290665-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD08E5AEBFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 4:29=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Thu, May 21, 2026 at 6:41=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, May 20, 2026 at 5:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> =
wrote:
> > >
> > > On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > > > Collect received skbs on a local list during RX polling and pass =
the
> > > > > completed batch to netif_receive_skb_list(). This lets the networ=
king
> > > > > stack process packets from a poll cycle in bulk instead of handin=
g each
> > > > > skb up individually.
> > > >
> > > > GRO should be even better.
> > > GRO will result in slower routing performance because there is no
> > > hardware checksum.
> >
> > Then provide a knob or something, instead of trying to avoid GRO.
> >
> > For end hosts (forwarding not enabled), checksum will need to be
> > computed anyway.
> > GRO should be faster for them.
> >
> > Note that GRO also uses netif_receive_skb_list_internal()
> so you recommend switching to napi_gro_receive even though there's no
> RX hardware checksum?

Certainly.

There is a reason we added support for sw checksum in GRO years ago.

Most linux hosts on this planet do not forward packets.
And if they do, there is a big chance the egress device supports TSO
or tx checksum offload.

