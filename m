Return-Path: <netdev+bounces-266324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH4CMXSDsGnRkAIAu9opvQ
	(envelope-from <netdev+bounces-266324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:47:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B842625802D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F04C3008D33
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951D29AB1A;
	Tue, 10 Mar 2026 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt8QKHLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AD366067
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175626; cv=pass; b=fnrIeaOMYO5r15wyuxddMQxrz7r7hCv6bhlmNMmpOtVzbLmcxm9+NSdL2IGlRbKgjY0Di7j/ZPWaK0g9sWzTkS8jmAelSxIYTjdeuj0rP2gQS+YZEqfStguE5/zdRlOu5/If5D3WZRh5/XpMmcGGEFHZ4/Xz5t7HUdmThCMEt5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175626; c=relaxed/simple;
	bh=sK8jeHa5IALYFrStaKfcVjBtbuF4q+klznwp4C42oH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi2t/8ssEsu1o94QsRLTrO7IJwNa+hLtCRCg6e3TqHtB9mQK29PosfFpg4UscDBgvqECAnucjPhvsMkZlP2MmxjukAFdXf4bvqLiefMTEXQTHoOGe6SHn/OjWBGqAtD1lXCXaNoe/QSpNePPHxsmX0JAGfCckt+rQG/NSLJkdbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt8QKHLs; arc=pass smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-674c9673d15so705126eaf.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773175624; cv=none;
        d=google.com; s=arc-20240605;
        b=OsqfGxZytOhU5oWBUKN1inOQsCojq+6IAlhq1WLhXQYVVWjdrcIIS4iOslBmTXyTEP
         REA79zCNP4cNJ0OtvDFFCw6XrQIJI9N5+HHFEzfBIOn46h17C2pVnWTnqlZIohW3y+re
         l8Kg7tC81+/iYe4c9XxYUJCuRoNu58Uw3jk1fiIDe3/wvw5wNp8bf3XCPFdkQivk7mxB
         3Oxt4iHO1w0Ww00rViVAkvckrGAJ/OBDh8c8qCebCQd84bczaRCwIqyPc4MbjcCCkSVr
         AxW7JL07CM2aZN79QWBBYRC+sbjzQsu3/M5VMS62cB1xahDYgNLZK92O5xzfb1hzR6WQ
         EL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6zLp5E+WmWh/qPZ/f4KJKNivZCD+1lqBqyxPFBYuxmE=;
        fh=r+HRUQF3DOftOVPgXFgi8R4nSXqfa8pdQ9dYVQY+GgQ=;
        b=DSd3uSB/XlvZtUYW3vhh1CcuCSIFzbQuL1Cx1eCVkmzQSc27SvgvuGB7YIU7D/Pqxs
         q/H4icHC7TfMMNm5eW0482uwzmW4hPJy+dQLt4+sVMATLcyXi6nLYmpPD8eRRy2o9MTL
         UBQdL5dWI3kvPqBifOLlEPxjgSO7K7cx+/eTPhkjUOiMTF9GZ1xiNPFL1wG6LOUySjMl
         WJRTVgsvp6HUs8PIrRaKKijkh3XelL5L4sG0sHDddWeFy9JPcydwhzZ6d0dq/T2tv0AV
         CzQ6YF4v2AegHwAxpqbaQPSahnt30DI+4Es7GpwSAxsKoSxd/7OeRWarjracgG1p1Mfc
         DASA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773175624; x=1773780424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zLp5E+WmWh/qPZ/f4KJKNivZCD+1lqBqyxPFBYuxmE=;
        b=Xt8QKHLsEy+r78QVp7SKjn1NrsWAO47zakJZ26EopUwqvd65AG+xhwyMk5BDKhe7Yx
         9KzRrXLciAclFALrWrsWxaoJZU3dxC4zYZUrUBIEjfCUrn2JP/gzvy9fy9ikzn2ygDVR
         wvt2uw2bYE5o8BfcLyMBnLLiB+n5pN2qZM7TVDTb0x2JDW8qtYXa313iJjxFRq8z1w5Z
         5rO/b+PUdh+ufQpGukycdcT11JIUotfSC785y2LR2PqSHd56eyhvoDVnIPp6j94OHjxm
         ctVwgmjqAMkNEaZO/X76/PnAVTLaT88p6knDrMUkd2wEXJdAWzHwuuredRguLBVGpeJI
         yYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773175624; x=1773780424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zLp5E+WmWh/qPZ/f4KJKNivZCD+1lqBqyxPFBYuxmE=;
        b=FqL5X9mHnO1MrtmhNQj4hAYqW+t6OLln/poGt4EaSW5ilP8rVx1RGYoXxakrz+wDk6
         4RXMCYI+4UIqp+qCf7knxFnNDFgZxOJb3YSX3OoKczDZHSvfAei0SEo3ufEifOjhnhSP
         1o7JHTBNGDee6Io1+HA4drRdyNqq9NYQiCMEdGD96WX8ypqDcYHBj49/xTXVi/6RVr2D
         EzFRMaAeLi50CSY+5cfqbRrN5LhQYF8y3HG2SBJZbNXIDDCBaRFADR+QKpMj0rE6KuMP
         OrwEBS4JVTGl58iHYvl7QuFzRHwPF55ybj4hfcB4JTgi+B0NQJRClmIatNmV2bsp8Oxp
         VcMQ==
X-Gm-Message-State: AOJu0YyhfitYR9UEcO0D3xvJCSSVGu/esT+trCE0ptuGFv6mKIrMV9oJ
	54GUko3sAtKdQVsrLV+wdTzVOe2sQhJzwp++HO8HXGYte05edbWh/2GyVFN8rqbWhdzTtnE6vZL
	m8DhwSG5E7IHe/pr+LEVPMEmKSnmYZgA=
X-Gm-Gg: ATEYQzwOSz5hpzogM48ip5UEkqi2QhY4f87crB0c/nzqeeO3wMt+iwzbWHQyNQ6DG07
	6xOk3Ths+AEIGidffkdv8cdQCqO8WIbvA4xg80olpvk2JScSpiW/wkdx/IzCZLG5jwN3MlP+ai7
	s9xTlrKLuFeFFTNyL74GQiRkt8YNEmHH4xNdfgwQ6BCQp9tfzux84uIIByAGLtsjF88zvl8QTnK
	wSL1Em1Sh0TzPx/TxTXfzUnu4PYeRyp8h7iXE7gVY9Yo2FSw5kSJiHRhGDBOd1RS86tG9nfQzWc
	Op84kLrqGbw2h5rEbofQN2o=
X-Received: by 2002:a05:6808:1523:b0:467:2609:127d with SMTP id
 5614622812f47-467331e04b4mr82249b6e.0.1773175624336; Tue, 10 Mar 2026
 13:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-6-weibunny.kernel@gmail.com> <20260309163859.382968a0@kernel.org>
In-Reply-To: <20260309163859.382968a0@kernel.org>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 10 Mar 2026 13:46:52 -0700
X-Gm-Features: AaiRm520ZoVXj_j4JcHMnvWTt22QWWWQdevTj60QkcmMA9-ZoUIKafR8FNziLew
Message-ID: <CAGqc4nX-fCvppieWJhQ0=h_Jzv9diVDq4Bp0p6LxxbfKcQ6cgQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/5] selftest/net: psp: Add test for dev-assoc/disassoc
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B842625802D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 4:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  9 Mar 2026 11:34:53 -0700 Wei Wang wrote:
> > -    with NetDrvEpEnv(__file__) as cfg:
> > +    # Use a different prefix for netkit guest to avoid conflict with d=
ev prefix
> > +    nk_v6_pfx =3D "2001:db9::"
> > +
> > +    # Set LOCAL_PREFIX_V6 to a DIFFERENT prefix than the dev prefix to=
 avoid BPF
> > +    # redirecting psp_responder traffic. The BPF only redirects traffi=
c
> > +    # matching LOCAL_PREFIX_V6, so dev traffic (2001:db8::) won't be a=
ffected.
> > +    if "LOCAL_PREFIX_V6" not in os.environ:
> > +        os.environ["LOCAL_PREFIX_V6"] =3D nk_v6_pfx
> > +
> > +    with NetDrvContEnv(__file__, install_tx_redirect_bpf=3DTrue) as cf=
g:
>
> NETKIT needs to be added to the driver/net's config (it's only in
> drivers/net/hw/config now)
>
> Can we also add some code to handle NetDrvContEnv() creation failing
> and falling back to NetDrvEpEnv() ? Skipping just the test cases
> that need cont?
>
> Last but not least let's use variants instead of the test builder?
> --
> pw-bot: cr

Ack on all 3. Fixing them in the next version.

