Return-Path: <netdev+bounces-269173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEyJLnH+ummAeAIAu9opvQ
	(envelope-from <netdev+bounces-269173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:35:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 373032C20E6
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90D3B30241BB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B83F0AAB;
	Wed, 18 Mar 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="I2i+tJ9p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2F3F0777
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862490; cv=pass; b=PlPdgXX7Pcbyqza8VarIwWM11PjMZWlmbEJc+Cy8DA9bCkiMwg3dbSaNYs+N3J8n9cDUPX+g6J1bM8qK8qpAXRECZAwFkxqGoQmafi763YFidNfGEHLf0TyGgCTRs7Et4yIKAjHTnDnbebqTL0v+59tt2UHHlOdh/hrI0bV34DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862490; c=relaxed/simple;
	bh=EihuF+w0a8DOBQXLSTD0mDe1YuGR0Mu2ey3up4bmU7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UU/F3i3aBQD0/K1OX4J4aNxseJtgwo38sbL/WKxR/Gjue5c41Gv8Jn0TBMyn/Guyf9SPSq5UzSuL0NY3MOYHmrBuHlHhTUxc68dlLcBbaF4zJZUyxs/iVY+INwXdYDfsNFSgvBUXOJBjPq2PEQzTITSLjsMaXaPGNnugKHInEtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=I2i+tJ9p; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ca423ad53so393141d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773862487; cv=none;
        d=google.com; s=arc-20240605;
        b=KAakmqf77IhDMHC3bo0sHAz2b0opHVgAcPuzuJllkbufJs6W6ZB0QuX3MzjvE++Tai
         CrKI2Bh84wVozp4nU5ES0ClHDPyftTy5Wi1qEsAVIQTbmlmPGJvwMhgCXSiIMUPM2OGw
         cf4U0B7vvcXwjxL+s0Nh+COjVKdx6udasuo8EVeAv2E4G4FXSz1EZ4/Au23w59TSi1r/
         qURkYGSuOGDKGvUjFQh60xQoQ6AKl78eC7Sv8xX9VbKRl9kvB1nWmhEDsc+C6kk98eRq
         /u8MP907fqlT/vK/X0/DR03WPHBtedGUkcFzYSGR83dl1irz3PBUUmYUqV+ojUsGaGx9
         ebPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oxoLvFQEyrKPYZFKxqDO4/VKjhat+HqeRGs9tNuMWjA=;
        fh=4hPQTJ6zwbT5WvXzPx7ld1OsCByUjuabpDnIsXMyt4s=;
        b=afY6slK9nuyNuLtuKZWYwgMFGQni3xsW7kjvS92y1ANpWiZQGBFSOVcJ3CUruBVUIE
         MNrioV0jzsS5NRjes2sDaW4x9aXRSA4iqmJukkVmBfDmj150g5iLCpLnSBU6mlZcZQYy
         D6wWy4aqpHLtSPcLhc6DUV7CcECTrko30X4mpDgs+GXiDXgKXU64XbcbtTS6T9aSnvIc
         4XIVZPb4TcaUAWfJlCUdPCl3bCTmNOh29rSekKqFG+KFxy1xCZS85VWJeTvQ4MesvzR8
         1Ve6OiqcUMVXoy/6FfSHwGVD7x9LsC4++n3xjNmk7jOSvFaUCaERS7HQQx2pVW+vW0+W
         AMxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773862487; x=1774467287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxoLvFQEyrKPYZFKxqDO4/VKjhat+HqeRGs9tNuMWjA=;
        b=I2i+tJ9pCRYHVOkIg1vNbMOk92gBQlQ7pB/UBWsuyGCchW/KpXKueSHcd+VR/agjts
         Zknh6HIFf6TfmdMFdupi0pOKi/I/lomp0oaRn38uvEL2KuKcEPJAheS8idElkLpgmfhh
         n/uhPLRHHfsUslNNbqdZ2O6muK0dukOIapAxVW6PnhTxQGNVuHb2P/kx6vKMbeN52ZF1
         ql0T0L02pLC6iSpYKiqujJZN+SRVK+U5phnjeokHRUIlmUoDxvt8Guvi3IAzp6a4Hntb
         YfdXYBf0wtd/RwcVNn+i+ZtFAEui/O45tbLadljyKfInb1vhW1YotxdwRT859g1TAmpv
         J4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773862487; x=1774467287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oxoLvFQEyrKPYZFKxqDO4/VKjhat+HqeRGs9tNuMWjA=;
        b=qb0sZZAgRGImP/dGy1rOLSP0jmDvk+sZACEOJ+fAL1UtdGyNzlmei9bJ5ylE1xp1Ly
         2iYclexQ5wr/YrKgRZ0BJztqnnZU6FC+iXHmPpSZ6a1cR3muOf9Au/ubVBg2lyvnYmnh
         BqwXxuR6Cvp3yzALW26RfYmUuWjwIycdppRjPENQHpcu9jmczlZlJR6zJwa3xpWELgGG
         LQVVTZWUQqs/9Z5YZcivy3jIqomnvO3oUvsVAU2UZ37ZE4DrPeL9D7rNxYz4pmjPrWQh
         Hc/l/a5MFSA6KVVoABUfoC5Jx7FGRGgpiBzpG8aUaY14nPyrYqDj6GFhVxafLwTLp1mU
         CGfw==
X-Gm-Message-State: AOJu0YwFYw8eIIcxDRKUuMsRoIwb7soar7mCjQZ/N8j+mYgYKNKR+umB
	HJrlmLojv5C3tDSmkqCAvt2UJhu0V93UkaMrV73LeK6Yt9DpdsN3NEKc/tBCJ7gLagJsNgD4Vzr
	7rJZiu5UHzc0247eBm5OHXks7Upecz2krap1uUdns
X-Gm-Gg: ATEYQzxWo7SZ9v4BxhPOCbB9IkdgyYG+sLiyTp+jkeg/JAkvFINZxrR64mRWib0Jgfw
	SsYWje50Htdd/7rekDhyA7FvPhHk8gcTep8snWL+ZFq8krBiSgWtQVTExLGhynPPE2vIRCGA/1o
	7jxjQsGFCQs1IN1At3uyB+d8hxpjlRiOXsiMvjE2BwRLwSbSjlpUGyI9wbNIH11gnbcty2KLg6n
	S++7edQVNrnvvW7yDrw4Sfy5lajtH3FogLUdu/FRXH8bigsrnDdlPiVq8pN1826onM+zKY3EBb2
	UQ7OeSek9tw3j6I=
X-Received: by 2002:a53:acc2:0:10b0:64d:294e:8614 with SMTP id
 956f58d0204a3-64e9160916dmr4049143d50.59.1773862487314; Wed, 18 Mar 2026
 12:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316211052.332383-1-jhs@mojatatu.com> <20260316211052.332383-6-jhs@mojatatu.com>
 <20260316175705.2ef5004e@stephen-xps.local>
In-Reply-To: <20260316175705.2ef5004e@stephen-xps.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Mar 2026 15:34:35 -0400
X-Gm-Features: AaiRm51Uhf6hasplezozN6QhMyu1nmfWQiQSMZxwgobhYv8dD4wB13MRpFUOQnI
Message-ID: <CAM0EoMmso3BeWwBd_6tWPhPqTiZ=4ZywNuMeWxuvgZADXd1OUw@mail.gmail.com>
Subject: Re: [PATCH net v2 5/6] net/sched: fix packet loop on netem when
 duplicate is on
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu, pctammela@mojatatu.com, 
	savy@syst3mfailure.io, kuniyu@google.com, toke@toke.dk, 
	willemdebruijnkernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269173-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 373032C20E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 8:57=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 16 Mar 2026 17:10:51 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
> > @@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
> >       skb->prev =3D NULL;
> >
> >       /* Random duplication */
> > -     if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q=
->prng))
> > +     if (q->duplicate && !skb->ttl &&
> > +         q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
> >               ++count;
> >
>
> Would prefer that if ttl is exhausted packet was dropped.
> Rather than silently not duplicating.

so return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;

Note, this is a change of behavior, no?
Actually - when i was looking the first time the bug got reported in
my view the bigger issue is when
skb_clone() fails (which happens nastily when you have that repro from
William). Unfortunately, the surgery was too big so i gave up.

cheers,
jamal

