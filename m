Return-Path: <netdev+bounces-286203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI7AFap0/2nE6gAAu9opvQ
	(envelope-from <netdev+bounces-286203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:53:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B040E500D38
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E74C300A396
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935D2FE58C;
	Sat,  9 May 2026 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLJyqjfn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3958003D
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778349223; cv=pass; b=cYwOUErM90NfEWeUxpXhDGbyTWdoS077ZIvFNX6SfwI/CykygVPY0tFH8cNaLq6unwdnMc3BqH/PM+wquU5dxlepPj43x5jWn9deOpGwmaUV1TAoH0KC0PbyrUBvFurb0XTTPkFmKSGoxwRCejp2E5oatsx9hO4fYwbx13FZ0cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778349223; c=relaxed/simple;
	bh=/wERocRBBx+2tUEVqAwQjWoEe3tgy7I3Zsk9Nr2rHPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYsobCt8XxOadsVX7cD1QiZErD5yHvc6PodtRmPqvxZcXQ+sVyplY81nc4agkagnDmF8ubX0a/CmLWiTf75+/JHACgwnnrCpl1as9FDMwfeKRZUIsL5oLMAdDMol6wWKxiNcfOXb31eZqenITdHUI3ZGgEGuTMGw4h0mSCqLUO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLJyqjfn; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50fb4a7d704so22482801cf.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778349221; cv=none;
        d=google.com; s=arc-20240605;
        b=DPANntMhJKZ6H+EPEP8tXwaEtCGV7rVajG4MvoihP1mFbOyiXN49m8aey2dlgm2EcD
         975WMUv/ERVie/DWgVwnns5JgYFH1qDElDX5TFAVgBenVsNmlrXyIm2SznrCEND0U66T
         MWur73YB+WShs+odkHzxBXYwH98D4JBkkUdffBFHQb+nCv6VtiO8pYHW5owB4buoTNon
         H+Wb3s8nfRyIKnCr1pGF8PYozgXV1hX792JiT5hXGfs3/GlK3hjAkTgNTfnyBdZrAbOU
         YyY+8Wrpb9hYH7m2YGHelO6rKPcofytIOB13ezxUoq0b6+mNlatIyngCwqRKj3weGlme
         vtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1B5tP3GQztShCRFPoRFfuuVT4/kaOVIg0k/U1NSjmC0=;
        fh=JqGBteGTY1UugAvl+Vz1malbMReXGFbpAXZAE2rE0Po=;
        b=R/8VO6nbslB2dSLkd51G93HAwmVuwNzXREE6/Vf4F0FOydodoYkIM+1DH15INKbDXH
         Hwz2Iu7vlLPmnDEQgg48Rx2KMlZZ+4YVsAxv6aGmYP3UT1Pw8Dz1Nv8nBvqbUoONue9p
         Tr5uYgfjTSLFDU1uB6eC+S89+zhPXE3X0Vj5HbA1QY1/6V5c1mSbZd/Rr1lHaCnB6Z+r
         HlIiAdpP9Z8TjAU/e26oLdcBPQLodgSroR0zApNHwneL/sGLtv/+u63aWlfrL/CMmBeO
         vD2SMAC29srr1nR9TC4ML4EVLLdRKlHKGQ0FUUVvEqY5B4AYgnJSorOr7OIG/wB+onmA
         2JdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778349221; x=1778954021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B5tP3GQztShCRFPoRFfuuVT4/kaOVIg0k/U1NSjmC0=;
        b=OLJyqjfnymwTVa9JxnRJo941IE6wlDJ+0aI45aiZOzxikA6fFu2aCPhz4OBLD9rPcL
         nH/fzcg6VxSg+u8fTEbWA6Btro6FFBMn/kG4WbD1HOqPSGoiyozrINlXShtZLpKg+7No
         X5g+E8qXLpQL3kFEb3qBZVWYU9dStHW9suVuKxRH5I2ZgR/pRuszp9AZ6NFklMhjjRnN
         O2THgS1HJhZXBeAbpHzx+W1uJyMRLlju0RfQnic71MEa1l5+ashu69mbHAoMBppwpSzt
         b9hDNWdaJaTwI6NE3mH1Y25IfsbYHz+/YU5rFHIosxtG821/1ZJw1JquSjfcUoytZHr0
         9zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778349221; x=1778954021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1B5tP3GQztShCRFPoRFfuuVT4/kaOVIg0k/U1NSjmC0=;
        b=nSH9nLO4VuDlb2hL1NoKinrvIv8ZRtt1a5rUf+nZFgEnkKaaZ4RrY1IMcKbh82gFXt
         rddIX5qJ1FAQKNh15YtHM71spJ6JhHLjS/CLFYPgsbnLrDnvTwAwks7jg2pmoyFRP/Pw
         fbg9K8UGvH0GKULCuMUHm2cezgi6MnDTi3Fo2sIW48j/J7BimpxvxDxHlsyrqJRDk30F
         cY93uF99lMp1VATQcXENR9jLEGs+BXQFa6wX6Vg1QABSFBbP3qrySbMiiXgHv927L5B3
         T4YFa19zy26+vrlmhP3QPELmjAI0rgKegB4vx36zgf4tgoGWOlxPR29DQoiwaIg0PyDQ
         f99w==
X-Forwarded-Encrypted: i=1; AFNElJ9kUYoFYAlQYXzqss9RF+fdkeIvTg91Jiz+N5mEsTSpknuWEXuUOaMFFIaU6qra7bDsN1oeFIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsK0lD+FT2vmyXHNI4a7rOtfoYtSLJSigi8gTGteK9LLJTj7zS
	qPtlX/tyCxGrxWM7o7imN4zLk908b3JTo+YFefbuN9Yf7pQ5Jvlfv/tAeN70zWJJoefexeQ/fvb
	ofsoyrF1rUaJnZWKDKeWS2ZeiDg2IXgNQmVcxoYNO
X-Gm-Gg: Acq92OF3+SSC4Yxqtn03AkrSHcUk0+brS9M91KbZsi6SNNLZwjzuX69d7y4tlhpmjwF
	UbDzOlTwdr9QMCWHg9casdi/pHwVU7McmritIF9o1q50DJK5fdHnrGYvU724QJbCckMGPfg1+vj
	d/GnhBxGidYiR90oDBb2YdeQ8lEztDGq7B/4vcA+XfSZoFOdOwW1X5hRTv0uzTWHKakuf8ihU5/
	MjT/Tk702H7g/Qg3WWZrM4SVn4NUkftCssROFiQLEtG0QmLYGCgysgXfS2rgIl3/piA3wvmNIjF
	o63dXekWWQ12Nw6Hz0TmG9DcRfFkOJqlyriZUevPnuRRGV62EpKvd1w30+5/e9hqjk4wn4EkhQD
	W7o0WKrUjKQdc8XDfL6NX6eTKpM6OWUU=
X-Received: by 2002:ac8:5f14:0:b0:50e:5cc3:6f42 with SMTP id
 d75a77b69052e-514a0cf6c8fmr50395201cf.59.1778349220360; Sat, 09 May 2026
 10:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com> <20260507221948.335726-6-edumazet@google.com>
 <6b5d2268-ffaa-4746-87d0-8f16135aba44@mojatatu.com>
In-Reply-To: <6b5d2268-ffaa-4746-87d0-8f16135aba44@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 May 2026 10:53:28 -0700
X-Gm-Features: AVHnY4LBZr_K8I_MEEYpLloL7wmF8vR4-vNEvUr66i5ag32Sihw_RdjicnxRv1A
Message-ID: <CANn89i+eK7w_VXW+vva_4Uy50mBPN-pT_oijYN0T-US-AK-dZA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] net/sched: add const qualifiers to
 gnet_stats helpers
To: Victor Nogueira <victor@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B040E500D38
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286203-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 11:33=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> On 07/05/2026 19:19, Eric Dumazet wrote:
> > In preparation of lockless qdisc dumps, add const qualifiers to:
> >
> > - gnet_stats_add_basic()
> > - gnet_stats_copy_basic()
> > - gnet_stats_copy_queue()
> > - gnet_stats_read_basic()
> > - ___gnet_stats_copy_basic()
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > [...]
> > diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
> > index 1a2380e74272de8eaf3d4ef453e56105a31e9edf..3b2f9ea2eb072dde792aad5=
b60cf00dcc2efa76d 100644
> > --- a/net/core/gen_stats.c
> > +++ b/net/core/gen_stats.c
> > @@ -124,7 +124,7 @@ void gnet_stats_basic_sync_init(struct gnet_stats_b=
asic_sync *b)
> >   EXPORT_SYMBOL(gnet_stats_basic_sync_init);
> >
> >   static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bs=
tats,
> > -                                  struct gnet_stats_basic_sync __percp=
u *cpu)
> > +                                  const struct gnet_stats_basic_sync _=
_percpu *cpu)
>
> This seems to be causing a compilation error:
>
> net/core/gen_stats.c: In function =E2=80=98gnet_stats_add_basic_cpu=E2=80=
=99:
> ./include/linux/percpu-defs.h:238:1: error: initialization discards
> =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddis=
carded-qualifiers]
>    238 | ({
>          \
>        | ^
> net/core/gen_stats.c:133:54: note: in expansion of macro =E2=80=98per_cpu=
_ptr=E2=80=99
>    133 |                 struct gnet_stats_basic_sync *bcpu =3D
> per_cpu_ptr(cpu, i);

Interesting, no error on my side wth gcc or clang.

