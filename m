Return-Path: <netdev+bounces-262521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJdGMpgqpWnY4wUAu9opvQ
	(envelope-from <netdev+bounces-262521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:13:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33F1D3643
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9451F3011154
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B932D0E3;
	Mon,  2 Mar 2026 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM7Qc+cy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDE379ED1
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772432017; cv=pass; b=s/YPdUfWM1AziHx48QiQdaSAN5zXK58aFOfVhARR4Pan6ZC5WmjLs/GooeWWYTV4i4SV+fzS2Pn09r9CrbbtNrzTNaelJJCn+bmXVZxgdauC68QuTFXKLz2BhubvM7lK0R0m6QxKo+ggjrYshtfGDou6eI1AobjWubdhqqtlFtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772432017; c=relaxed/simple;
	bh=+Q6GGX8zNMM8BQ0PS2o57GNeCicr0Q6irsXem04CyRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avh8u5q+JAXfnazC8y98snbNWKXgNAHi/ERiPOi14TA4LC6Uof7SfQryzQBq4truTIXqKVSG48rSVhdp8p2KM/1DCA/7II1kCBD8xW6pA/TO0hIXBW1Nyv37H4dJ6mEOTDenpO2nYlHFKbEbt76D92RJ85aG15+vsQPJjKf7N4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM7Qc+cy; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-389fac627c9so56447941fa.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 22:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772432010; cv=none;
        d=google.com; s=arc-20240605;
        b=JpziyhzKHZo2EnV7xBOeXaOIEkBTuiEjc4uZZcevJbor9al1yi4s61ywjIOGWQ9WIB
         uhygKPa+c778tG8cdvObMjkY47vFhaiL9jVO2nkU3YkFa6F+gQE/kLGgQ25EBgKPp+oC
         +JX/BRmi6uNM8QrBZkJMLpVMEutFKlkbkcfPq/sD3exaLShtkkIPlJzPdArHJvgQ7XSO
         5+l3a1umzC6nfo5ojTpn2I2PpKSQ8TEkwwW3Q9re42SiFFoRkw2bTPB9T5Yxn45nSlqv
         EHlnWXhnYSxfPoFSstlMMCOEn/05XeMCaZFwWHxDj86LMzOxLee9mGFHJMjGTicIv/QO
         +OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ux5RqO/ZTufyk9Xe7c4ok2Mzm+WSW1boQMNoNgz5Yho=;
        fh=ajCJDNaXQdZ2ivfohX3FUfS+0psEvWv70WYKYVV+YYs=;
        b=k7/yP76/ORP5SywhGd7bA+JgweDv3CyCzJI2mY9BXYek/5pw7RB/HyhyYI8ONJA8xc
         pK6tbbOwTYHFe2f16Bzh40BMgOj33cEs1jWttH7jhVAs7s1x1FhDEq24N+hdyFkBsu1S
         04YxY1NJlh43XdfWW6RlVxW/QuhlHpMdCN79S4TpCRjwznFZoqxdMqytwVs7nuRTew6F
         XHpb/fV757TpGHxSgpvv+ty4Mug3bmHpvoY9j5T0DPpC3O9hRFwBa4GdiUGrf5CzX3q9
         fphvKqNDi+x99+yrlaCN2OvFieDEcxluruyVcHOrqSAMy5QzSRDN/UOgMd+XcMhGzmua
         Jz4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772432010; x=1773036810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux5RqO/ZTufyk9Xe7c4ok2Mzm+WSW1boQMNoNgz5Yho=;
        b=XM7Qc+cy791Tkrs0X/C4f+Zo0iSQlwkMu324pfrHMyZgCJ925/a71vA6J+ixkrGxh+
         k+p3fXGhB1uBhwuzK804GQ9C1GkBNq/BiQ4fOI/wa9Mlz/vOwdzYN1BSocuCrRpLmlsH
         R+UtB+bfS708/QoMemCBjJ9YJTToaZrRbPdW8ZGPCxa+QpBQ3JilPIYWKJLP5H3u0nV+
         ud6KZRvWaDWlUNaRJVeAgL6ti6rexdjjYAj2cIzBHjVVOq2saRTh/ou6BDMycwCvGZGw
         Trac4h5x1relQEKR1El0wp8F6nwylWycJkCTzjvtogLxdkkNNrjZ3vYXrd3IJSxfgN+m
         kibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772432010; x=1773036810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ux5RqO/ZTufyk9Xe7c4ok2Mzm+WSW1boQMNoNgz5Yho=;
        b=gRbCsOkDvxRdMlB74eGzSgfLoR6qTnicCSVOZEjj6olvekcVRlP77Tv7NNO6HhWjq2
         FZtVbkMbjLyl9In8QbovtjK1ey+CGIg+sBKCqCr3zgvvcjyVDvYOwKOT8720sU5TlDM7
         N8YfhyPrw/FIncqFxjmXtDLjb5OCKkSKcbuLB3imTSP8/KqCI7QdqJVUaw8z0ewWa39c
         1iH6dOO2jaWDPywLCYO/EnBB0gApaY5lpO4G39w0TnUyzaqUASWBl7plVl/y5V/Rs9h4
         /S2srb8HaoayW1/Ujum34JdWZ2M2zJdL3OcBvusMnm79RvbPCrrjj4/2c5238Q4mjFCh
         Ow1A==
X-Forwarded-Encrypted: i=1; AJvYcCWuFCuRXjK9bnrt+GrC15Eou13rQ5JDcR2mudTQfbGj0z0296eLuTkGOMKgrfqv85t4bR6RLu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvo+1tZWHp3+VAJNCFnJZ0ZgwGgNoiQuiL8cCWlhPwmJSRhfIj
	73kpJtABR14B9ia9nXhhd1Fxblpv1PpLzJ3rbB7pcR0FxnwWy9xVATR3bBD+b0AJrxHxtaEGv4K
	vjsJnooVs+6KfMEpDzO/4gZXT0J9eAqw=
X-Gm-Gg: ATEYQzzzIz0lDlRMkLE/kYSrVcXxdqbJUImMijCimW738cIblF9vKXMiS9Nu1peCqBf
	YFO2qhXHVlCOPoqSEYhEMegpsdHE4atPCMmzxk07FtTqbwL3dJJfC2scIzHImsjxDXhSk4y1o/4
	EjwJhxFvUOrVWTiU6WhB00z/RxYwz6YWOUNFrYgW8+k+txF+BsuY6xKKVE13+l5TGfgsRZZaOHN
	Tfvu0w7arjmOAsbmHm83qTjiz1dqmD6ugDsp+BeI3f7RBNvJEJ7fRx5G4xuUrGI1R+GprFZVWY1
	CogHLKujcA9SM4Og55sZvnJtfGf1Z1KrbCb/ABQ2N7A4LC14gJm4Kd2EDEmNmkSE23fcjU7FsHo
	t1ll9yFHaLKFaqSzdf8iHN5cSMkQ=
X-Received: by 2002:a05:651c:19a0:b0:37f:a216:e473 with SMTP id
 38308e7fff4ca-389ff08accdmr74673101fa.0.1772432010206; Sun, 01 Mar 2026
 22:13:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226111721.25454-1-yuuchihsu@gmail.com> <20260226171401.7461b9da@kernel.org>
 <CAPAzCqE3k9PehK9gec7pcfq-Tnjsx-reD63GUaO+MEnP8LZ0Vg@mail.gmail.com>
In-Reply-To: <CAPAzCqE3k9PehK9gec7pcfq-Tnjsx-reD63GUaO+MEnP8LZ0Vg@mail.gmail.com>
From: Sam Su <yuuchihsu@gmail.com>
Date: Mon, 2 Mar 2026 14:13:18 +0800
X-Gm-Features: AaiRm50l6QwVrBMPu3EbKOf4uYs_vW7YhtWWMq4Ps4rEAgTsv1FkTCq0fhJK2-0
Message-ID: <CAPAzCqEmfhZNk4Ysjo80QXX6ijyek7Vz9mexQ91tO0pwA67tvg@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix ARM64 alignment fault in fib_multipath_hash_from_keys()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262521-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuuchihsu@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6C33F1D3643
X-Rspamd-Action: no action

Hi Eric,

I just sent out the v2 patch, which includes this missing READ_ONCE()
fix for the read side as you suggested.

I also wanted to share a quick update on the WRITE_ONCE() behavior we
discussed. I tested the sysctl write on my ARM64 device and dumped the
assembly. Surprisingly, the original code didn't crash.

Looking at the objdump, because the ARM64 kernel workaround for Clang
LTO (commit e35123d83ee3) only strengthens the read side to use `ldar`
(Load-Acquire), the WRITE_ONCE() here falls back to regular store
instructions. Clang actually splits the 8-byte struct write into two
separate 32-bit `str Wn` instructions:

    b905ae68      str     w8, [x19, #0x5ac]  // user_seed
    b905b268      str     w8, [x19, #0x5b0]  // mp_seed

This completely confirms your concern: the current WRITE_ONCE(struct)
quietly destroys atomicity and exposes a tear-write vulnerability
without crashing the hardware.

Splitting it explicitly into two 32-bit WRITE_ONCE() calls in the v2
patch was definitely the right move. I have tested all these changes
on my ARM64 board, and everything works perfectly.

Thanks again for the review and guidance!

Best regards,
Yung Chih.

Sam Su <yuuchihsu@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=8827=E6=97=A5=
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Jakub Kicinski <kuba@kernel.org> =E6=96=BC 2026=E5=B9=B42=E6=9C=8827=E6=
=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:14=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, 26 Feb 2026 19:17:21 +0800 Yung Chih Su wrote:
> > > Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a =
sysctl to set multipath hash seed")
> >
> > Please use the traditional abbreviated format of the Fixes tag
>
> Hi Jakub,
>
> Got it, my apologies for the formatting mistake.
> I will format it strictly as 12-char abbreviated without brackets in
> the upcoming v2 patch:
> Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash seed"=
)
>
> I am currently preparing the v2 patch which will also include Eric
> Dumazet's suggestion regarding the WRITE_ONCE() and READ_ONCE() on the
> sysctl read/write side.
>  I will send out the v2 after my local testing is done.
>
> Thanks for the review!
>
> Best regards,
> Yung Chih

