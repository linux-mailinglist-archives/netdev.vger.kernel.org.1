Return-Path: <netdev+bounces-259753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BpRHwqrmGn5KgMAu9opvQ
	(envelope-from <netdev+bounces-259753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:42:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D9016A265
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 835EA3010B54
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257636654C;
	Fri, 20 Feb 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="J0/AXPPs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E86366814
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612936; cv=pass; b=FwDj0CdFToBF18gG4ZVoMkuFcDSpIpjVCfZMhl2HpcbLHLOBRgbp6+6lP9Pgj3M1QZAc0dnroDvuhu+qdIWZEAa4fcp20SKO/HRw/tegSO3HtXQR2VNimU2ppLjcMLgVM1/2EsOimczezCQnkYfAsI+K4kpGf7B8TPof6sgcxPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612936; c=relaxed/simple;
	bh=MEbnmaRSVOaD3qvUhFZbrCco3pz6n4O0mEK+V2687z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB7GZGMcIeIuy9dBaVUJ2XqoeJmBeGWUj4bAt6f73e6dN8bkDE5c/Uo54TfGFoE/LZpQMTkIq3JbZOf+CLBOHPjU4aJ+pcH6WBqOyA8St8rmIUEDKvpzm3DCrisDgRKZmi6Cxg9ppgmvuXPQ39dKoVuQx9SniKpDEVpxN0Rysco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=J0/AXPPs; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8871718b00so387097266b.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 10:42:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771612933; cv=none;
        d=google.com; s=arc-20240605;
        b=h3cWQtGvwyekrxa0Fq0UsL5CVR83VqeR3ALlydbnAEvtrvioGeNHVRGtg52JTXOSrN
         NXC69ibUVwcQ/9M5dgJTRaBwfawqg8/fJqWTqv2N0yHBmqdPvyCxBgsepx5lT2hKMPUp
         XHP3RX3QGpzhOo9XF/7n/qmXj5VIkXg8rpQnwZW4CeEPiWI9l3Sg1gmOX45hcOcCXg6y
         V+cawZ3NKa4bn+arp5ASRnpPITBxHcRyCNEjkXa3jG4Fn8Y2MQZjrAPL1gXzi50CxoeJ
         oBvR1UCW+7X+5/YV6Bc18INhNBCHCcet4L/msTV08R/jvsHXJAZCpeFPsubJAXeu9v7M
         1ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p11SnN2G51FYoourvAP9oOti3rvVoOX0gxT1KHWDCOM=;
        fh=degdy3OOg4mAG8oEN+8h65XSg8vnd+XnVIlSYNSKJuA=;
        b=TiguM3xav99XH4OYMw1oi06J6GNO8udyvcPFHe2V9Z9TOxQllv4dD+rx+lzgVOkqAi
         Z4z+fsF6fY8EI+R+xfszVbNNDtn0AGnltZ0oyDxwgDlctc98CrfJRd0Eyy/+BSa/ymQZ
         RHAbF48CtYGtK1lnhNg27bNFxkeFJeHIFR+pyy+n3VCKDjmABJ850Q2nP3/HXLAPEDw6
         GojHhvgA/jTGzSZP0BG5P0FIE9W55fNs4wk4ZRonnFoXFxUAi0G9CYTxXfSXPQY6EZa8
         H2bTytHzZK5qMAUWWVL+tDNkzRCZyuXrFcmXNF+k2CWZmu0sfCz3J0l59Sfmhfp9nT3l
         4p1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771612933; x=1772217733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p11SnN2G51FYoourvAP9oOti3rvVoOX0gxT1KHWDCOM=;
        b=J0/AXPPsDMt0+BYRAxbHaUFZSFi/I7N7w9Soi52mD+M+BfIXiLcnKk4+TmL1Wg8x8H
         YacNL9+3PikPbi7vkl8VbeJ6C4cSas2yFrcFiOZvwe3YvvLfEiLhUDDb+mtmcpCCxPua
         ruXBXJy/0ua+U4Ffu9gsdg+Pga931eJEUGe6PO4uch0QPyKrjDaAsbjkd9XYqVq1jxBR
         dDTJ0ehRE6TgpLtLokJXJ/36kROm4WDD52INEsf//KmaE+4RhrfYvg49DfJx4Ayz4E8D
         YeJ7Z8AWRGsxaMSwS2ifFlIjmpg0NqNzccrN1JqafVFPEV3uc54rCkgeOVu3BopizXPj
         3hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771612933; x=1772217733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p11SnN2G51FYoourvAP9oOti3rvVoOX0gxT1KHWDCOM=;
        b=xDOFm5Yqw4OHfmCRoF5amiUyF153UgI0Tdi+IwrhucaWVtF6CGJ0zPwHiv11gwBGc3
         RHhZEfZEU87yQM5qEdygEa0FzOaK2m+hO59HB9rOPMHRuqNnrA3a4+HSUyX2JpOOOCrz
         sQQxxUE0XaC9RzqHT3X2JxkPX5It38v+EKZsnNlhsUuK2TcqFGKmawNPJjxIFMDp5qSV
         05xnpLMusyAqbjqldvlxH3xmDPulE7QEQ6y0Y+nj3T4U+D5hLOV90zcTBRav524l89fl
         rF4HL76Yhb3v0p2T3A8AMFfeFsjnGhDriQLfnOwXZAwv5GRXLMkEgrfFXow4csU7eynp
         ihag==
X-Forwarded-Encrypted: i=1; AJvYcCVTo8lFAt+k8CaFhwBS/CQ2Ov/+bu7U6tbGxvltohKwdw3ch8Rln5b4IKqkHIUD9cNiFqb7OGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcv7ldsy3BL72xkhnn6h45Cqfnsdf8bAaq5QB7xB5rK8oSkRA4
	PZfhvQaWM0Rl8jhWRtVXMd07GVDmnrCSKgE759/mWKhXgxC91DfXbTo6PorBrrX+xuTTDpyi0u0
	6VBsSCoWUQmLmNkazXFKGIuRBsu8NYzcVVcV4Z7AxjA==
X-Gm-Gg: AZuq6aI/Hz8ab/tTajlq/R7+/3OQmqT7TSAES5dbQfbCAIJmqHaIhLjd1PbKsqPUZvG
	nxgq5FpFejFFIR1ZTcPWdWl6myEhmJmDvtDuIB0TpK4IpcDsXIwiu/kJ2EejvO6ErNChfAMRUf3
	Y4zSTGQRAm5b+/79kGfBEJ5o6LRuiwmkH0jR7NSqFrLxrv9bVE+U/u03mGZfNMadRzTGdL1uW+c
	lrUwqJfK6/W+4DWIEasLwv0w6+cJQLj86WkGOAKpFuj+JmTqb795UoN5VKv3e6dL5Rq2TYvH13J
	y3qj/Ae2bQ==
X-Received: by 2002:a17:906:f590:b0:b8f:c4be:f1f3 with SMTP id
 a640c23a62f3a-b9081c1021amr28639066b.59.1771612932640; Fri, 20 Feb 2026
 10:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-fu740-v1-0-c8af54130c58@sifive.com> <20260220-fu740-v1-1-c8af54130c58@sifive.com>
 <20260220-repeal-glitter-acb73cc75564@spud>
In-Reply-To: <20260220-repeal-glitter-acb73cc75564@spud>
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 02:42:01 +0800
X-Gm-Features: AaiRm53jWwDc1WCYeQ_HcYo-kwfyEnIvzDX6KWSIO2LiUkTSOMUZyC3C08_aX24
Message-ID: <CAHibDyyV4Ss_2HCqWxHo4hcW4x2_VJGnFsP02gkWVyjo=XNf=A@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: net: macb: Add SiFive FU740-C000 support
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259753-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sifive.com:email,sifive.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 20D9016A265
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:29:28 +0000, Conor Dooley wrote:
> I don't think this is right, since it is identical to the one on the
> fu540 (as evidenced by how it has worked until now and the contents of
> your driver change). I think you should add the fu740 with a fallback to
> the fu540, like the devices from Microchip that fall back to the
> microchip,sama7g5-gem. The rest of the changes to the driver and binding
> can then be dropped as they'll be redundant.

Thanks for the feedback, Conor!
I'm taking your suggestions. and will prepare v2.

Thanks,
Max

On Fri, Feb 20, 2026 at 5:29=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Feb 20, 2026 at 04:27:05PM +0800, Max Hsu wrote:
> > Add the SiFive FU740-C000 ethernet controller compatible string to the
> > Cadence MACB binding documentation.
> >
> > The FU740 ethernet controller uses the same GEMGXL management block as
> > the FU540, which is tightly coupled with the Cadence MACB IP. This
> > follows the SiFive IP versioning scheme which requires SoC-specific
> > compatible strings for proper hardware identification.
>
> Your rationale for this change is misguided, as this is not a SiFive IP,
> so that document does not apply. On the other hand, the general rules
> for devicetrees require this so this just means a change in the
> rationale provided.
>
> >
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/net/cdns,macb.yaml | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Doc=
umentation/devicetree/bindings/net/cdns,macb.yaml
> > index cb14c35ba996..b46dde1da170 100644
> > --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> > @@ -63,6 +63,7 @@ properties:
> >            - mobileye,eyeq5-gem        # Mobileye EyeQ5 SoCs
> >            - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ether=
net interface
> >            - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
> > +          - sifive,fu740-c000-gem     # SiFive FU740-C000 SoC
>
> I don't think this is right, since it is identical to the one on the
> fu540 (as evidenced by how it has worked until now and the contents of
> your driver change). I think you should add the fu740 with a fallback to
> the fu540, like the devices from Microchip that fall back to the
> microchip,sama7g5-gem. The rest of the changes to the driver and binding
> can then be dropped as they'll be redundant.
>
> Thanks,
> Conor.
>
> pw-bot: changes-requested
>
> >
> >        - items:
> >            - enum:
> > @@ -74,7 +75,7 @@ properties:
> >      minItems: 1
> >      items:
> >        - description: Basic register set
> > -      - description: GEMGXL Management block registers on SiFive FU540=
-C000 SoC
> > +      - description: GEMGXL Management block registers on SiFive FU540=
/FU740 SoCs
> >
> >    interrupts:
> >      minItems: 1
> > @@ -181,7 +182,9 @@ allOf:
> >          properties:
> >            compatible:
> >              contains:
> > -              const: sifive,fu540-c000-gem
> > +              enum:
> > +                - sifive,fu540-c000-gem
> > +                - sifive,fu740-c000-gem
> >      then:
> >        properties:
> >          reg:
> >
> > --
> > 2.43.0
> >

