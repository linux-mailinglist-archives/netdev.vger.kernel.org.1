Return-Path: <netdev+bounces-264483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LUpHkqyqWkcCwEAu9opvQ
	(envelope-from <netdev+bounces-264483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:41:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B721584C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D463010BA8
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0663C279C;
	Thu,  5 Mar 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi/MxqrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EEF386C3E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728852; cv=pass; b=Lp98oID0gcH7d22YZI3h7ANXC+y5mf0vGkH+vckOCkn1z9QLTZL0CaoNJEc4EDFhwiv0V3F78p7qGka2hJflmIUgAg0iHvOGJW7JRMkvxLG17Oe9wyxVFgnBIQCVKKwtgFK3ATa0ipBqxnmFAUOVgO2ST0hXtJkbhCNFuoExP7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728852; c=relaxed/simple;
	bh=Tw6/Lg1Pcxy0M3+6F2XbADf8slbGTAkbrXkfIPCNMWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA6m3tE3QkAvm8wpdhQ+aMBOivvUhzBqaNoWQVA0ItjIZrvDasUayugzPoVc0AzsxwfGH/BuxqjsvpxzmyzjteXrrA00m8hRj+FuQlf0ZyFIeJ/9+M6D1l5v3qQ48koskpMXpp7MkDQ9PShGjLh51RI3HMJUsV1CLgxFUZvH5Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi/MxqrC; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94dddb3c3f0so2182580241.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 08:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772728851; cv=none;
        d=google.com; s=arc-20240605;
        b=L95zJeMlt9K9ZMwl01F3xrwjldGdz2IrYNnSOcbuclArqIbNBfy1Wz+2iqeMYjSHJ+
         +wkGHlXd1Yej3VxoteKgcBn2xVUXYRfkqZ5bgdPqGgE7Nu5J8e/adOUkAEWtZLTg1bDl
         FAZEUQTYr+XXeDrHrSIH6yHcSr+h1qMKijacGxTa79oaKMtY4zkFc7vVOT3NRXaAtrlG
         gULybVQ5s8eEWYEm4V7vksfYRTNN6IEnG3X0fK3EbejOZ21RKobQsFrOUCTWceR6J9XG
         r3uZAFypTrdD7od6sdAxhR9MpQ8vQ0ojgq12oq4F3SHXKnEHITPS/OuYTAHSx5vsvN8F
         aSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xxN+7bGcR7TVtZCDh7DHmoMO7X0+dXFHhThsJH/WJv4=;
        fh=f+11/uB9K26xBOUifHAxB4ijaSvgOni7YdGfre6sloY=;
        b=da2wl/C8XC4pQ9xdKGzaYgIUIUHQGfLCbIz8DW8G4p3GcL3Cq0yFV+8S+jG3pIUs0+
         mSVqRDc00QEjJ1W50IuvWrXofcxiWSGtwe/mLuErcqmUMOC2eVeZ3GlF3E6uXl+V8CFk
         vsiDn9RW2Fe+oplIZQyFEY4B51s1gASd6OObcwpMpMSrrdwEcAEDyTnjnxfBPbvDVy5V
         AMYu6tfSmlByOKbCnrSKfl6EQ/vDfxTh6TTI14xzgDK4k7PKUPkjRpAl7ljC1cc/HdIb
         s6OqUpn+uoEAScTkt+LYqFAqIXNG0yPf2jYT+4kUWQ66fazPBAMF5h4OjJP3EzJV3+kF
         LG0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772728851; x=1773333651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxN+7bGcR7TVtZCDh7DHmoMO7X0+dXFHhThsJH/WJv4=;
        b=Mi/MxqrC4c8SQYKqKiiBBzyBSqFgGDmNUIPHL6B3wNrJlTIl4xcPKmooy5jNxbAj95
         PRi0yhRZObFI5c8AUsOLaMDRH0s2hWMGd/eH1cr5QRbej4goS7cPvbhKEsS+HpRLYtBg
         ZGQ+JkxlTSUWi0yBulZwSJr+l+37Zqu8w5P6ohrXJfiY/dV6VMEg7OqzN2hZSAguLc95
         3ifgvKSk4mUQm6iAO71QJsooylW5YvcBE2OUWd/1Hod1UYgLozUaG/TXJZ1HGsqoHh5B
         BjZCztNEV9OY9XWAk4W7JRF7yiCuK/fbX4paGp9tQ0drt2KZYkT4TV5muLAjImgO0iul
         kKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772728851; x=1773333651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxN+7bGcR7TVtZCDh7DHmoMO7X0+dXFHhThsJH/WJv4=;
        b=pGzwjibtT+cbG5lhn5x8KQAE33xSk/weYGuEew+05Lm7jnRsLmXbJAsUoRSwMO6b18
         huWA4DNl2whVBYT7JxfxWaYRR3qaZF/N5r/8hG3TgMT4kRGItmX6mCCWdNSDfewvql+r
         qvaqwmc3SHpMIm8vp+pPJ1qrT05GAhSDCA0EPZu+arFuFUYp0V9MD2TtNCIISOdZhEt7
         kncn+ku5HMmeJC6VTOYvFXAqYP1cjudh9nl13IqGi7iczLgbglYtypZIlLJTpYEF1+wJ
         7qPJOQy5px8mYVul22D/pFoC8i0jRG/DLX4Gj/ZkUzGPE3seOGyyXi1BEQL2hVxpvLXQ
         Ru7w==
X-Forwarded-Encrypted: i=1; AJvYcCWA4GtQpYRqsbjndw+rYCXLAfMkdU2Rr8rHimgVV0uATj3LNngp5b8nMKjfECfSYjobswdCe3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOp3d/XOmbKeuwdDqFS+FNyt1BLS/0QmNdj53pR2udNhmQAtMd
	9KoLi9sl52kbu6Ofa4O57hdI0Wvc6S8eKmOvD8h7Q82FiL29hm4n6ZSzuPAVgd7Oji5tjdeLcmZ
	HcaQoUYMaQErZF+N5tQF7xsUp+/Um5hlrXTYwnqc=
X-Gm-Gg: ATEYQzwM68DtfmW1nNpzN7dnjr8fEZpSc+MRPbesR8gYa7vUA3WbwubU+UaJLYAoaKU
	7+Hi6tRywfkn4DpM+kLVdstfggZqm4ACioIQz04qSUQbw4aE7jwwu1SHZRe+xNA1vhTknfSXjPW
	AsC6Oyyid7j+J+Iw2gGWIQQyMflzhXyBPwIUplDoHVA13oXKLTKqbVTBMUmtx+GjOlELP0vsGyo
	vR+aeWV88AqVZ6DST2MqOp6RAEUCEavkePP7cnJgXdS/JgMlVaQZHTTmkmxog+khKyBDa4YlaUk
	ntEJJn4=
X-Received: by 2002:a05:6102:5125:b0:5fd:ee19:8b30 with SMTP id
 ada2fe7eead31-5ffab038d41mr2901480137.35.1772728850730; Thu, 05 Mar 2026
 08:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305092226.27379-1-sawara04.o@gmail.com> <20260305092226.27379-3-sawara04.o@gmail.com>
 <20260305112428.GA57792@j66a10360.sqa.eu95>
In-Reply-To: <20260305112428.GA57792@j66a10360.sqa.eu95>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Fri, 6 Mar 2026 01:40:39 +0900
X-Gm-Features: AaiRm50POQVPuNAx2n7WNbpqRNDkt6y1WKj2gjYD0yzvSLj9JZYb9vob_AkNBLY
Message-ID: <CAKNDObDc55sL1fuQGfEiw13GwzG4WuNm5_ZfAf+_gZNVXuGJQw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/smc: Add documentation for limit_smc_hs
 and hs_ctrl
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 190B721584C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sawara04o@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

> > +hs_ctrl - STRING
> > +     Select the SMC handshake control profile by name.
> > +
> > +     The selected profile controls whether SMC options are advertised
> > +     during TCP SYN/SYN-ACK handshake.
> > +
> > +     Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
> > +     Write an empty string to clear the current profile.
>
> It would be better to clarify that this string refers to the name of a
> BPF struct_ops (type smc_hs_ctrl) implemented by the user.
>

Thanks for the suggestion.
I updated the hs_ctrl description to clarify that the string is the
name of a user-implemented BPF struct_ops instance of type
smc_hs_ctrl.
Does this address your comment?

```
 hs_ctrl - STRING
        Select the SMC handshake control profile by name.

+       This string refers to the name of a user-implemented
+       BPF struct_ops instance of type smc_hs_ctrl.
+
        The selected profile controls whether SMC options are advertised
        during TCP SYN/SYN-ACK handshake.

        Only available when CONFIG_SMC_HS_CTRL_BPF is enabled.
        Write an empty string to clear the current profile.

        Default: empty string
```

