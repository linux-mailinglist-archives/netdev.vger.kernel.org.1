Return-Path: <netdev+bounces-289726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHLsJlYdDWrZtQUAu9opvQ
	(envelope-from <netdev+bounces-289726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC8586DC9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22EB63046418
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A9517BED0;
	Wed, 20 May 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1vx8NsV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B9212554
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244372; cv=pass; b=DXs81WWofkSHO7Fozu00m1LBxN3t+GWnSQr1PJVU4xpVi/PbdhnPWzhsf4/iioI3VXTVCJRATQ2erxAKwLKzWYkc3qJuPzyi2rIfU2WLQe9TdUV+H5Pk2EC/5sli8Q3nSSCQehRqnrugUtdau0pNMqq9/u2hzRrqgYSKuW8pq+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244372; c=relaxed/simple;
	bh=0IzU19FPXW2H2TM88ACN+eWu+//FSAxEfgL73Un5O0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyVtAsJ6vpeWplO2wAIxrmnypal9BlOOd8kp2FTANEmCvvnbh+qCFjxHfodUjYb7bTlVKRuekATx0oXpBS9oDkOT9ekrNar1ubFPSb8KbWwtJ1FDS2NEz74EMYDUdFEer9YuJoYJxJoCy31Mo47LM81g+Am+v+QZQGfyPtapc/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1vx8NsV; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c1a170a50so5392317c88.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 19:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779244370; cv=none;
        d=google.com; s=arc-20240605;
        b=JU+mT9cd5vq13gzCPTIqCcHqirCibsUPX5fXSySRnWTOQUNaTOwAteUfMLQ1ONou1B
         YYDvPMabbLRQ7u8O4tbq6EmeOiJ/vZEQrSNfWTpbrw9/HhLbOEaIb3qQMgzOpKg+cz4L
         XUo1dejt5M9SmH7d8VKGpjY9mlQGeoTsFfCWxe8sb26ymANoTRSDi5a+F+4yKQTQMeCG
         Lzg1+F38TQHqj1sn+PVLsRMraeXWzpGLJJJmsRxC1TMxwUJrREt7x3TNlAr6Ykfuf7aR
         yBPrIZKYwiKTwsU0JumweIbZrtYQAK4BFibgB6h0BK0BZFM1KGAMzG53jpcTvSPcU2Ck
         V1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TOuVDgQGU+f+1u/58wwaeFqVXTyTyKt59iPLq47VrI8=;
        fh=5hGq1nUam+GjxtsXzQxTx6b95SwUReML8pK87ZpF7k4=;
        b=doguG84Uwz/0pG+sUVzVKm4L83P7WsksPVpuxlAaTJyoCCuAA3cK1D7fsYgy08akce
         YwAPoFN2CsuLVi3QoxfW9R0498gT8R4lRZSlfs+05OBnJnQ1sC9WxBYTWHVQVAmQBJr8
         H1f/tPB5zH1/CE7XOmn9xhKPUMUHA2Bfc7xOOtwV4SApOspqkbhWvhRIFmldwkBI6Igl
         gbarV3cb34zao0NzRAkFw4Xz3Sy6fIWFN6698XCt7ViBBd6KUnUE4f0g9Cog/5FKMNfm
         jEYXb9W9623rGSsDeKxF6n1Fx6BTZCZRcrJRU52iyzdQlN16w5aqvsl4q9FcNOJGt8za
         8/zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779244370; x=1779849170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOuVDgQGU+f+1u/58wwaeFqVXTyTyKt59iPLq47VrI8=;
        b=X1vx8NsVTvlQP1kM9GafUP0ERgG0bhjQtpB3wLwMPhTtP6X7Z+idpcnkeuY37F48i7
         mm+Og//Y2UpX+NjhpVHV8Gn+ui9X1wo6hHOLAS3m1GSbBXhe4g7mm6Mon9LFKVomQSij
         0f82MG2bGfFaEb2LqZvKhEKtPGj6HPKMZ7+8Yz6Jf/kG8TquS+8sqtInndytqaDkEhSC
         gtUcNoOF5u8LvCtjtXXP1z9SZBz+SZnbO93CiYAyO4YS0cOXtlZjgyeSvpxrg3FIrKxP
         gJmdYVSMJSg0y7jWVPuTcPnHJPhjfjEGgLtMNddOvvYUvDkTdbUBscyKkiUVKvTrfBdn
         teCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779244370; x=1779849170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOuVDgQGU+f+1u/58wwaeFqVXTyTyKt59iPLq47VrI8=;
        b=eEYec1UV5Nm6BpVSphJjUUwvraK35cHDis/SiSESHpnjDY0aA/qlOnJk1HnhiW736C
         puMZG1EtfLsS85t963tObPppJ0nPG3cE5b4Rvy+N7Uh4PAb3UluUMDNp1MTWvH0MA1Ej
         q4QSjz8bqNuav9pz9tKDIzxPyqdd9GqXQtYaSdDVFTGn+xMei1joI/8+kIu2IK0JdH2O
         RLN2QFhjqWHrd/kp781X7o8pyFIFQy+EQh9mguZMs3YvmDiDBzWQvjnPhtImA3KuZaT2
         sFHX+pyHgrlMknyS+ZY8mSCyAcLtHYWWgJ+1UDTWCyjUGFmnIpe6HAcODXGcg2oeQ5zc
         E4Sw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qe93atPY6hLGd55x6nf2ccy4ii8W6xEsUozxWMuEqrSBouazNBNNajKLOc9vub8tI5kGaIC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0PeT09wM1+uSkEAH9YLKMRlgybOD2WTfLK2wzD21K60DqUjY
	dJI9Y3yyfu5e27wrmqj4XmIZbWk18qlgGHljVOo5IL6D+AWMeFj52yUiR5pt3qYGH3NAI2uG//U
	uxN/p/SVhR35eFeY3TrpG/MPq4c6SX1oyQ6m/sWij
X-Gm-Gg: Acq92OG8FU6GULtmLh/7rJec2+bWgu3wH03BX3dVUWihvbYRBJFutWckHuMDEn3rPlA
	CjKiSWYTOjfoM4cWjylblwrRFDzqbDswc/iMzbInWs7Q3bd7cDoB7bWDSFKuPDIWDR0PPU4Ja0H
	g7CrYXbgg3WevMzcAk34Bj1okEM4ZR4fHkdTXj/qyJrQztq7jsalRRYHvm5mat77BUFFwkIgp77
	434K8Jqgyq889QEaqrzzwyY5sMPWMoosvdVJSuZ57ASyaRdTIqLXALTbO8ejowG8dbG3YUuMeAO
	Fsf/D64rbsvwKec0oE8Qy9pAaI1pINA04VTObXuNE/2F31n92tUnEMhB6CXRrT2FFXy+4IgCiRS
	/k8TUEFF+kD9B+QOMSC1ukHSCgZ/s
X-Received: by 2002:a05:7022:23a9:b0:12d:de3f:f3e4 with SMTP id
 a92af1059eb24-13504951d60mr9470268c88.36.1779244369297; Tue, 19 May 2026
 19:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com> <20260518050726.318824-4-kuniyu@google.com>
In-Reply-To: <20260518050726.318824-4-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 19 May 2026 19:32:37 -0700
X-Gm-Features: AVHnY4L8p1txP70EuVLSz-aReZLtZd-pnWF9iNixHV1kXsZXvgk82okVtd1KJH8
Message-ID: <CAAVpQUB9hbU3Jt1g8qZa=M+vpXqrBJ10716PkvuUL4fvVQ1ZEw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/5] geneve: Remove synchronize_net() in geneve_unquiesce().
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289726-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 44AC8586DC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 10:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> When changing the geneve config, geneve_changelink() sandwiches
> the config memcpy() between geneve_quiesce() and geneve_unquiesce().
>
> geneve_quiesce() temporarily clears geneve->sock[46] and their
> sk_user_data, and then calls synchronize_net() to wait for inflight
> fast paths to finish.
>
> geneve_unquiesce() then restores the cleared pointers, but it also
> superfluously calls synchronize_net().
>
> The latter synchronize_net() provides no benefit; with or without it,
> inflight fast paths can see either the NULL pointers or the original
> pointers alongside the new configuration.
>
> Let's remove the redundant synchronize_net() in geneve_unquiesce().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  drivers/net/geneve.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 4e5d0a09a82d..e8ff03ed87dc 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -2206,7 +2206,6 @@ static void geneve_unquiesce(struct geneve_dev *gen=
eve, struct geneve_sock *gs4,
>         if (gs6)
>                 rcu_assign_sk_user_data(gs6->sk, gs6);
>  #endif
> -       synchronize_net();

---8<---
Can the fast path read a torn geneve->cfg during geneve_changelink()?
...
---8<---

Yes, it's a pre-existing issue, and probably that's why vxlan does
not have even a function like geneve_quiesce() and accepts data-race
during changelink.

