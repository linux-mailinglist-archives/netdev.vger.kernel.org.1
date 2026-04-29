Return-Path: <netdev+bounces-282446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDi0M8o98mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:20:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 611214981D1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA49D30DAF2F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630773FFAB9;
	Wed, 29 Apr 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGUNV0Jc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9A410D12
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482937; cv=pass; b=frXj5PC7/WBXp9B/0Fh4kv7UREs22mUOSWH0xSyALLF94lzlOzszElB2YvhB2H+eI3dRlmYNsiKsexy5ijmqq9FTS3p8LK5xTV9+iGNrkwIF2pxSHhqL34AKKSxJ0568nXuMIJNFhl9wCJiOJvxkcTQrEbWTzRemfarwsOth5B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482937; c=relaxed/simple;
	bh=eMOr3n32LgXzzc/j26cSH1+9Lq4d3cay0qpZF6fVYAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mub5TAwlQk7Yo6Eauc2DIQdCfZ4FuSiwyPXYfnrxTb0Ch8C7K5MzxAAKJDOgS83TGRPqAVaSJaaf8mfy5G+s/X6cSfoPBrK3ji/5pJX12tuJ9knHh3PCCTnWv+FQbznhIutiA3TAaRuW9W5AKE2/H3ADzuFJtakZnZg7EgfNyqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGUNV0Jc; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-505a1789a27so62438211cf.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482935; cv=none;
        d=google.com; s=arc-20240605;
        b=iAbhev+dLAxZfcKSLl8HUkiq7qa49UeCAsLMrXUW3bPmjbE52vM+unhsqJh/A2eykV
         HnvreA5lUUWFKoiswQFzxO3Za40knGcKZnYz+FIO1JMqBKSCCwAa6T4ra71xraS3MyHK
         Igu/A3kjCZWDTRM/PgCBd0K0wH15nebURCNTnob7HBZHtmYR/BpFGhPeZ5agIDHb4Lhk
         wHRDzERZNOCbMfjoQxGd2vejUZmml3OOfbo2FjJSyKG1X9U76US0ltsgKmA6MWjB1EAX
         y8I+jlDDfEZ5AprdHI83OnU8TPNn3o6X3pN45t8ow3i9DsbQoCEqlaoNeJw2S3Bgvuou
         jXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DmSa3dulOiVLTvfcDu0Px0itSK2nT9bBEue826YOU3k=;
        fh=VyWJnwCrhPwNGQUcUOpaUQsn1Emk88BPA6raTwHzqL4=;
        b=UwTkgBiHyqoqtOJUcqWgPmipv8LdfolxMvUwlMdr0/6lYfnowgjWeGcNeelhzmYpbl
         P4Z4D9ebPlAlKHk51qSfAwA68XX1DvK3WgiClDnk3aCYQz35H/qmtOm1z0Vuh9eZM6S/
         CBtMBl62scL3VwHp0UC/DUpM0RhOgYFE0K6muOEWy2UDAoGe3ky49ArrXsFB6sBhY9IE
         4/tIGQkPdOK6b7u6cywH5XxAntcaSUi8o3BBlEULpUzKJiUW1wfZerXMMhf6sZty7pOI
         tu1Z7o8KiNE1jXsDCAPJqEZyMsPrG1/T9bygELZB4FP7RMbNUml/KOAB2F99oK9F2zyQ
         llfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777482935; x=1778087735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmSa3dulOiVLTvfcDu0Px0itSK2nT9bBEue826YOU3k=;
        b=wGUNV0JcIzdWLrkEvauyY5wmEHJ7ZcqQpdl5OUA0+v3LKjBZ8KD7G8+NR5ljmvi+E5
         O5R+0RVeaZdOQvBkF76kCFrguOx+kOi6eYnuLvhD2S+Fnap1lTKvutzIjR/FL29DJ7em
         /KaiYNvnRiDZeMqfVffYhuSn5xwUZ4ZdK6zpjxBuIsLyXRfRk2QGX7sOo3jOXTIrnpMt
         gNMJ0jQ7Hr4sJmfLLCC/vST2rcE8EeiTiksS3dPqI0NxmvDgKLo9JjK3dLYbnMA+1CgB
         CwbHQ5bakg/L3jWqjQse13qeK8foaS/gjg80NRm0VZPMH86F2xB+kL0GKZRH0hEkrAII
         PS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482935; x=1778087735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DmSa3dulOiVLTvfcDu0Px0itSK2nT9bBEue826YOU3k=;
        b=q/AgoRl7U4VfgcQLZHTmXITxJfRMGeRr+jdutarTUNi8Z2CIgQ2FmWxqkgm8EdoA3s
         J0FuCnvsSUpmiCLHMCX5901CukY7yv/70FBYGuEGSRupknPdJGx1rJ4212LLiXOITK2s
         MZsD9/kIXM3ElcCrDTVBoWJn8xk6oyCTNnzK6gEjovWzttJ6E9MCKTo3agfrStUnTrdg
         Z6sweB6UXLLWaG8EWxYezPoWmXK/ZJQd64VwHn6XR9G9EJEuFj9aE1dxEU1oj7JC3ALO
         nSGqgjbq2wWp3RHiT5X4dAbauh58Uoj411lkCfsWYVuhLLWJT3L96EvVX5WTgemgo0vo
         SteQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jFCxsmhtnXdqxl+1aC+W+zMuHsJQYM1qfu8euFnWZmmNU/zYJsSZTkFG9HLBvdx1LNCDuxes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPvZ9HQY5A5xJD9kC0bftu9ep6WT1m4Wk2h3XqNstBaiEfLzp
	WgGEgUKYupjYAvuA/iujl5U/LABXFuO7Om82FTsiFDKtGzCjfbEtMBNiBP0E8hfdyLtnFZ3aGGB
	5JLDllrH057U7976YOJxqYCPxEzGRYA0/kMFXAKPZ
X-Gm-Gg: AeBDietax/7MlqV5R+M6xWJyQucrPfOZcGe8iMgIKuzKYZEfce8y7m7kI/mFCQQPdjf
	hx2Qz+2XwLFiGtvZMhuh+MFQRK2YakYCJIJ1Xi1ZbUxwXnZzelBpZy7SM24iWD4uS2mFcrlAwgZ
	tOHbIVk5GCsYXe5SmlUALwF28K3LjR5gdCFpfS8cvu9o+LiMLGrBgvwNmQRu1nlNnNCbllfs0lR
	jisBSY3H1VcyrtxBLtcqoQ1BLnl+Bxb26tKuELQuvjR0cstnb81N33JIQe2vG/wg1eHOOdzDw3c
	wKkotiWk70TpcWBti7hOeVEumASUbUeICfTxmG3F73cpT9YoqkaaGfFnUucV4Iy5bpLgPnqnr6G
	NR8hUgQME
X-Received: by 2002:ac8:578e:0:b0:50f:b465:94b2 with SMTP id
 d75a77b69052e-51018a34390mr63511401cf.28.1777482930636; Wed, 29 Apr 2026
 10:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429080036.1528533-1-edumazet@google.com> <20260429094805.1aa6bf3c@kernel.org>
 <CANn89i+KuSf8PhAsf7a=h+tR1c8aLNdiM6NzaBU8tjpoLAfcQA@mail.gmail.com>
In-Reply-To: <CANn89i+KuSf8PhAsf7a=h+tR1c8aLNdiM6NzaBU8tjpoLAfcQA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 10:15:16 -0700
X-Gm-Features: AVHnY4JEm87XKAwR15JNiH3jW0vh5p06b7YusHrBqAy93KO83oYeTpvbxmPlZt0
Message-ID: <CANn89iJrvSvw2XKvB7LfXc2egeaqC+seiCiKN2USMw9gicqM1w@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 611214981D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282446-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 10:09=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Apr 29, 2026 at 9:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 29 Apr 2026 08:00:36 +0000 Eric Dumazet wrote:
> > > This test checks syncookie mode is able to reconstruct some
> > > client options when TCP TS are used:
> > >
> > > - wscale option.
> > > - sackOK.
> > > - MSS (in a limited way).
> > > - ECN (not tested, because of limited value).
> >
> > We're getting:
> >
> > # TAP version 13
> > # 1..1
> > #   File "/tmp/code_oyWax9", line 223
> > #     assert tcpi_snd_wscale =3D 10, tcpi_snd_wscale
> > #                            ^
> > # SyntaxError: invalid syntax
> > # tcp_syncookies_ip6_9k.pkt: error executing code: 'python3' returned n=
on-zero status 1
> >
> > do we need to update packetdrill ?
>
> No, this should have been
>
>  assert tcpi_snd_wscale =3D=3D 10, tcpi_snd_wscale
>
> I initially had a value of 8, and decided going to 10 just to make it
> different than the output wscale value.
>
> Sorry for the confusion.

Neal, can you take care of adding TCPI_OPT_SACK to packetdrill ?

Thanks!

diff --git a/gtests/net/packetdrill/code.c b/gtests/net/packetdrill/code.c
index d90bffabcfe6..6d8d20e64d8c 100644
--- a/gtests/net/packetdrill/code.c
+++ b/gtests/net/packetdrill/code.c
@@ -129,6 +129,7 @@ static void write_symbols(struct code_state *code)
        emit_var(code, "TCPI_OPT_WSCALE",       TCPI_OPT_WSCALE);
        emit_var(code, "TCPI_OPT_ECN",          TCPI_OPT_ECN);
        emit_var(code, "TCPI_OPT_SYN_DATA",     TCPI_OPT_SYN_DATA);
+       emit_var(code, "TCPI_OPT_SACK", TCPI_OPT_SACK);
 #endif  /* linux */
 }

