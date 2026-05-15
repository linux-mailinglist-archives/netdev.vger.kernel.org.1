Return-Path: <netdev+bounces-288200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMA9E53HBmrjnwIAu9opvQ
	(envelope-from <netdev+bounces-288200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF454A629
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07596306D93E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F743E3C55;
	Fri, 15 May 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obbxUZIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B3383C63
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828867; cv=pass; b=WAXnUjCv/tJlzqvMJDjZyZHUlUBx91U/rB/ns3hY7zSTltfyVnOce7nTWU64fmiUMD8yzQtWFL+eK/kNnFoXU4AXylR1tY1vjJNSO6wQr10HR9PVwebi9Hbo/h2fKHUIvgHwHbwq41+RtvuvV55qN3Vb1uip9kkhjnra09mRTHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828867; c=relaxed/simple;
	bh=GcT6enGnn1gx1YwPls4H8sf5/+EYHPFEUnaVy91G1rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTN22+pgTn/GbJK/XdmIX4VAEG7MjfSyaYM7iHbntcQLXXNGl7cpPVoLZDtAVGhjSeObB0Op2TQJQ5BmRZRB28SDPIVxNKcyAJGctJzWDCB4oDZ0a9+EMnc6L6b2G4IygkhQMjBclUMUdP+YR33dWiY9TlHfy0KHFj3Gc8Md8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obbxUZIp; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e63771eb0so82531551cf.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778828865; cv=none;
        d=google.com; s=arc-20240605;
        b=WzJAvl2NeSyk16f81XoUWSliaeU9M3mrmLN5aP8zZfDhxT2P7lJe0CmjWo4UzxDj3J
         jEBOnVzM2U/9iU4cIUOOnfV8xFux/VJ9ait6GNFVkRsG3Dz4nFCSRaoDwMaH7Gnjqchf
         1Lj/m8UO+B7GhPiw0jk+4Ra6s75oI+1cnIv6E/S40fAG2RmXX+ig6b6ZSeu6PUCgiHzP
         Ip1SEVzwmwYVOYV5r5sjSV2mODuHhzcSVL19/xi9GV7Be9zsKMPesFRp6/q8MRbGZ5sr
         1T+Plab6sSTod6YGsAIkVa7sfz7mtkh6YXCvvVLQ/6g+XvMYjlTxFmN570rqqLtVKgLo
         eJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e0rW14Osa3ro1o8CiTBrRmJQCVvpZ7llq8UftzFj8DE=;
        fh=SBHocAIx8YRVdPMYc3mDfFusYqJvNfbMOSYGULpLa2k=;
        b=akhDmw2+wKsvzdjGpePIy8IIgmcJZ05qkWAj/hT+hV+eO4YrvcUXyJKUSxJ/MTzVtd
         wJePOiTq5Se1VOIA/JOF5lXnNqUe31NNOIQ3/Jn4QCuUS3s/ThfKWH6QBcjBtJ5+Sa4D
         3EirH3nB+ir7I4MuxILXxVqswkbjQQI87UiOVlHgvgcEizlWSPgoP9CAzy46ZajTZtzX
         8NpgAr6iHNLr6icQfPNUcWODcnfxnUpjNdaRIP0UjN/uqFoOpy2nZ4iMhKWjNWrF189m
         lDyVPd7OjxWWfzb8kl1gqqCLJZl2pivYkgFJLAHl+MMbsX4ApxN7sbG+ZF4QVoxE+73m
         FLBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778828865; x=1779433665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0rW14Osa3ro1o8CiTBrRmJQCVvpZ7llq8UftzFj8DE=;
        b=obbxUZIpIxTQay6alrhzOt7SM7uuIWquwB0ERqNmcOrsNN5LSmu81rHL2Sc6BgC1xq
         pQEd06XWaOJuyFwNTIZsr/ENHg46o2R1KMQ/j5M0lTcU8CrNiBzszP9UekPFuJzDpMHn
         QpcP/xyIdTrjYfWVw2IjW4qVTGTl54gZ21eSS7CCaR5H2QrzEmCzev6spoaAJ3pTMTYf
         Ctdo5idQQeniYMUVqAA3G1sL4AhwHFv3/r6kt8MwQI+P+hWkTdqYqaS9KJv7BoAxGVY0
         WX7bqJLZoG2JS4GmTymMz9V9yYYd7Yci/MhpJy9pXSlNUB6GypmgU7S0TfMnFBb9TM7O
         mJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778828865; x=1779433665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0rW14Osa3ro1o8CiTBrRmJQCVvpZ7llq8UftzFj8DE=;
        b=QM2wdZzeNbWTcgRnK81yIiUnsO6I0MHrySx1k5dvnrV2QUU46fkKysBJiB2zhsTC7x
         SDb//ZUp8qlyuJbow/8hHzjTaR9mhBogvFf63le33FFNy3p9+SulM5tk3bOCPwtXLTLt
         J+EMoPwsHyx9Xy45VcEuVMEtmZkabV0TwGfPItSCVAegitbkq0PbFmsd1txFL183hRF1
         oKrThebt6CLWLPpEOLODdKqZeu4gsN5kPaosmSYJbPehjXDnbx1kovnL6FAR1b34bOPc
         WzR4bbUPFz4dDbFFLmFTpolwQ6LhhgTDS74CunZzpEqArlMwkee8MZQginaAhNzc/5J2
         hhCw==
X-Forwarded-Encrypted: i=1; AFNElJ87XWkoOJPoxFe6KTx7VxXsXj0oaoX4e9vMIQyFmVpoifdgAAv6D1BBHDGxyMKmNH9oUOV/8fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5izeycyxz5CcOrBq0+TZWuMwhMrzV8OBpjNc28YYluw6Qb76d
	lMVBn5RbLTWplZgT+Roo7N478z2xuQhVQzM7emuAG6Ee52+WyrkG9CRIJS4D242rwg74OA49/bH
	MD1RNHiAawLeXgtCVc97CLhT4+97hl4Tdp5eEThOydeX9yhBLtd7NK9X2
X-Gm-Gg: Acq92OHh2DbQZEqK8+qf0Z2Rc9WpsdgJFF9oql2ZlUmz36rXSqHpNNiEIvBw/rg98xb
	dC6q+FZf6n4tfPpVvDoFUj9GhB6uI9Ilk2qU0XN8zpwUtlBomoPplE89Q5/DAWKljyuWM35zKhj
	YDd0tNzvzU1vs097MN28XQD01BpSBbV/PKLnUM5mF9rcAD0FKNIkxzXbrJX5AeNM9IRCuWoZ0mI
	Srr549JD1YXlLAxlbCQhC/AQS8vHaTwppANmFsLql2ew/odB3Y3G3rtHULVNjbRhELaazCtS8b4
	ZpFMUwTxWDmZwQ4egz4hpV+h5CXdftUJ1vz9Ff8p66i2Wm26IzYGMwqVrPEUW0ldYLHKZpZmZTl
	0TVOUeeZRxfLeyzDS5QvOJbEGBfhO3A==
X-Received: by 2002:a05:622a:544d:b0:50f:b17d:7e4a with SMTP id
 d75a77b69052e-5165a2766b0mr38756271cf.57.1778828864136; Fri, 15 May 2026
 00:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512175250.346486-1-edumazet@google.com> <20260514172509.4b38e684@kernel.org>
In-Reply-To: <20260514172509.4b38e684@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 May 2026 00:07:33 -0700
X-Gm-Features: AVHnY4IRxxVT5p-_cF0WYCBeMCJhQkcsJhhTpeagpSmVqzij4cifBHtsdnYrH8o
Message-ID: <CANn89iL5F_SUD+j=njSfpK9VrSPq0fDUwDq_5MddWoXiMeDNYQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling
 ISN prediction
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C6AF454A629
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288200-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 5:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 12 May 2026 17:52:50 +0000 Eric Dumazet wrote:
> > Fixes: 41eecbd712b7 ("tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a p=
er-cpu field")
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 2bcf78a4de7b9edb0d1342319d4340c0a9997eeb..93c6072c97b65ebabb5dd02=
45edff0728ff082d1 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1066,6 +1066,7 @@ struct sk_buff {
> >       union {
> >               __u32           mark;
> >               __u32           reserved_tailroom;
> > +             u32             tcp_tw_isn;
> >       };
>
> for better or worse I gated our CI reviewer on build issues, and this
> generates:
>
> Warning: include/linux/skbuff.h:1103 struct member 'tcp_tw_isn' not descr=
ibed in 'sk_buff'
>
> If you repost could you change the reporter to Chris Mason
> <clm@meta.com>?

Sure, I am sending a V3.

Thanks.

