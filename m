Return-Path: <netdev+bounces-259755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EaHHsCsmGlSKwMAu9opvQ
	(envelope-from <netdev+bounces-259755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:49:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FFD16A2D4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D782301E6CF
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20714366545;
	Fri, 20 Feb 2026 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E80IzUOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235A3128A2
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613374; cv=pass; b=GE67oR0xkSrzHRfCkPWqoyqaoKqoiVC1zIhBNzRyIcpLg5rfI0PDqWHdPdTstO9tJnAJtSkWN/h2GfUQBtm9mdtDs8qO6MTcWXy1qU3Ty2etpdv6ZUduYvEI0Tg4cp+dfbPMKS2hsRnv19aa0aZvxLdHg2ydqy/tRJnWE5hJMJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613374; c=relaxed/simple;
	bh=TOr5HOHrQ2xjuVTHunziB5WVpm1ag/FbTe/dq53usUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QThZXd1+cAn7k7uSAkUts38FaWubL4mq9nZTbutEI8YoaLoknd9R1GufZUSCTsIFiXIaFbgUixa+geah2vqX2qgBwXlIpibsApiyCcXaS5rl4h1y6b4BFPYC4kuhV3KfuN9AfXu7UFTGCduuG3Q0rdkinNb765hKH+nNi5/Woh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=E80IzUOf; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b885e8c6727so433882666b.1
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 10:49:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771613371; cv=none;
        d=google.com; s=arc-20240605;
        b=J4ZmNamPlZ3/v1VueC0Cng1M63x9zDugl/coekYnavmMZdifirv2f095EP/WrXun3r
         lLXq+2UhvDoRCjrFRcKVvoucAvxCoD1z3rI0d7hw5dpufCYSzIMxdCpwLWEBOe2ZCc32
         wkT3Q6XpBx4ffnfV0Vg1vbsCNSZCAIhXiOEAF72XxIzpOP2xEkVDdrKtJ7pJdDSo3AaD
         0aYNIfVc6JB5ryv7a9nv4HVMmI/ZEeRjiWcdlACyDdo0HxBSEjN3LUD3CXbYlfRd05E2
         YrYo6Y/eppKRUaKKahdDi9X81ogldsxODQATCLpRu9COEyD8tcqekTObnAHdAeE4fvjp
         yDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wx+eX0mBS59Zy6hvZp9IaEVvMB66mMGe+OdOIYRjb5w=;
        fh=AQ/rjUHojR1l4iAP3oPmfzpQpf20Y/uaAuX/QmYQ7wQ=;
        b=DWNS/myWjF/cFY5u3Se9SeK8fzQCV9PtAePn3WT3IO0Fv3EnDkpeR1Qt3OqgRc7rJB
         YAUg7jYB4aFA2BDDnBWh9g2IDyA0z5RHKrT1yuW/SW/LOh7xtiD5Dx7HVaoBTe5xqBCr
         /Jrkow0L/Gv/YDNT+G+EcA7lxHLk2S7t+Gx3/uWO2vr8US9o6q4OeI+ZRaJEQ/q5O5V3
         Y82Z2SuGdqcxWPmToBHHX7COakZjOhHbUdtLBDtrPlr/mZxi9bUpOKdlnTFdY97kvu65
         zOUfZ3jq+W7x8Fn31xyIKl4hr5jlBpo3yr38msftzn+DBK/6lDc7a9j8mTwh7Ppxe3La
         2KZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771613371; x=1772218171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx+eX0mBS59Zy6hvZp9IaEVvMB66mMGe+OdOIYRjb5w=;
        b=E80IzUOfgMfPpS+VtjXgjqT+6ZLZ/zkoLDchI/2ZFnJ8LPL4o2dmasugc7NdoMh3Oe
         wnQ52LtUQfhbFp3GwwcNk86jmcq012cO2qdqwncPJqVfNDEsWBydlIjhc7i7pgnYK19b
         vo2GnC5rVPMuDo7WtsRQGkkBTlpZM1S1qbix+NgZC27WIE2uWdxVa6fBSw7o24+dTBZ8
         fq+0HouLZHPmlkSP+mjO0rL47BL7Lx0VuwG4mcWf1f1UGC5qmYEb10Xf5UUnJ1T5X+Ik
         LWzTbwLGDuVNayxFygjbkRcsFJObpjFmNfEaal1kwGwljwhg94mYk1LAVzdtpMXQbZKA
         M/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771613371; x=1772218171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wx+eX0mBS59Zy6hvZp9IaEVvMB66mMGe+OdOIYRjb5w=;
        b=ORJ6NxA7Vwo5YBU1u3/DtzFLQU9V6RtxDY0oIfSckAAI5nFy9avwp9KX30vrBacGwh
         XG6rb7lmDq1X/OIGE3Za3WnVJBXnIlISv1UZAS6zA/SERcl35Zxx9etgVsnbbTgqVX8x
         A/Y5/653reWr8/V4BpYwUSCiih9LoX647W+QvoBEMHBqNwucWxQ0GoeReDEBXLTKfDVw
         ih0RWbcDTOgdhR5g3Txj0Hf+Zanx9h2HC0Vdpin5/aRc1vOJT6tugD8uZWdgLoWLnrfQ
         dvegF3+z6PLKjAIlC0p+ubyWhW6L75Oic75s3dARcYyBSVOyX4qgELYQnwOtHZo1JK7w
         cTXA==
X-Forwarded-Encrypted: i=1; AJvYcCWhg20qVgcr1CYO78qWUdBmiKLLz679Y44CsTrGIveo/JvpaHx56ZRqXLgfVO/9HE4G4Z/36OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOrazk/QHZ3nBmS2tYNBi0SYMvnWlnH97fVaWMSaVTqR8CHOE+
	6BXOAoF0jQPVd01lK1Co57BDwKg65UCz3L6uvJRuQrr1WgRSpxjtROuHdSer7a+A3BKvi6TNcbm
	b8BVyn3oebM8mXWvw3z+0Zt9WvK8FuGRAJt2ZRdOGoA==
X-Gm-Gg: AZuq6aKze24xHkve9vaVu7k8a3Dqz8c1wOFaE+OAlF0ROyCr14Cm7c/Rb5Ge+KoluZe
	Y/sf7GYiu0/b7den9XBvHWtdgnMBKvle+ISLBCihGSisqQZbW9L+tuzPeEPpklbaFEpC/HZwKln
	HXv//kOIjZu/z5FlB/RfUjloCRkmWXjcGhfFHhDRS+UVDTe8m4+TtTiefkJJPdZox1ifPHNlRhp
	LIxvcwq5LfNH34WyAAJcNU0UdHA4fIgGglK9PMmSxR1rjX192EbKBNsqwxw/aaHbwAK40J924lT
	RgLmfxkgsg==
X-Received: by 2002:a17:906:99c1:b0:b8f:dec3:6606 with SMTP id
 a640c23a62f3a-b90810d9416mr39173466b.23.1771613371158; Fri, 20 Feb 2026
 10:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com> <20260220-fu740-v1-2-c8af54130c58@sifive.com>
 <20260220-contest-ambiguity-1a4099520bdf@spud>
In-Reply-To: <20260220-contest-ambiguity-1a4099520bdf@spud>
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 02:49:19 +0800
X-Gm-Features: AaiRm50P1Nlh0T0vDWni0aUkbrbTe6xYAsBq75SA6rKDY3TAVmB4kTeN4YB9xj8
Message-ID: <CAHibDyy1mA2s9_UjKGPemRaKNSvyq07Ok5+4yruQ1uXX+R-Pkg@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: interrupt-controller: Add SiFive
 FU740-C000 PLIC
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Thomas Gleixner <tglx@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259755-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sifive.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,sifive.com:email,sifive.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: D3FFD16A2D4
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:23:18 +0000, Conor Dooley wrote:
> So do the general rules for devicetree bindings, that's not something
> SiFive specific FWIW.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the review and the ack, Conor.

I'll update the commit message in v2 to reference the general device
tree conventions.

Thanks,
Max Hsu

On Fri, Feb 20, 2026 at 5:23=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Feb 20, 2026 at 04:27:06PM +0800, Max Hsu wrote:
> > Add the SiFive FU740-C000 PLIC compatible string to the binding
> > documentation.
> >
> > This follows the SiFive IP versioning scheme which requires SoC-specifi=
c
> > compatible strings for proper hardware identification, even when the IP
> > blocks are functionally identical.
>
> So do the general rules for devicetree bindings, that's not something
> SiFive specific FWIW.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> >
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml   =
   | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sif=
ive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controlle=
r/sifive,plic-1.0.0.yaml
> > index e0267223887e..351d26ab1956 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,pli=
c-1.0.0.yaml
> > @@ -63,6 +63,7 @@ properties:
> >                - eswin,eic7700-plic
> >                - microchip,pic64gx-plic
> >                - sifive,fu540-c000-plic
> > +              - sifive,fu740-c000-plic
> >                - spacemit,k1-plic
> >                - starfive,jh7100-plic
> >                - starfive,jh7110-plic
> >
> > --
> > 2.43.0
> >

