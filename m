Return-Path: <netdev+bounces-267059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJDVBAG8smmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:13:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2D272556
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21683300827A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB603C5532;
	Thu, 12 Mar 2026 13:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FC39936F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321213; cv=none; b=YIgJJrBVK06amcvFtjFPXNUrDshjZFXuz7ZUBtnu/j07LfHK4cZv4Zr23ybUgM9iMBMPb6q17oqCa5eag2cGlCb0Id2RZYSC/pS+fs6z8ca/1jlBbP8Orui0nGcgH4KSL9M+U2hkTavIl3L1YPgXRrPSCflWGrOkJzgAtJ5BAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321213; c=relaxed/simple;
	bh=9Xf09/CQRKakxUM97o3pjEHQxlgCJx2m/hZtTEYbHSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIHBu7PlJa+4ZX+rXy6NBPrEgYzmQSQoKH/TFwiNEbBtVQTadCJIyfvHBDAQLDvFEJ37dZ1alz/AyCKAQ8QZ19+hcByVj2jMu6lZUB/0eheJ+Y8NXXw069WRM1lHbM6BL4/WIinsC0dZsLQuhv1qrZxNzbUixGj59/JbtaNq83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b943b75dc42so153729466b.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321210; x=1773926010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udEH6r8HyARkgcp8nLO9sBcamtg2WZj/AdfmCmcqat4=;
        b=nLqAAUzbhEawdQwqU3mU3KXuO2GC8pq/vq/2gLovbPVJOpfCmvnx40QIAoUDHk9nVU
         sq0ZRdexy1hsqyij1SRQY+48YaZvn68b/3m+Jp1I85Xz6tkAa9fhjkNgh27Ydf7eCm+U
         VxsAjppMAlxFIABSUW6Ou11eN//sBrYSv4aCYEhxTFjyQnzDiSWQW1lHbKjheoBN1+3O
         rq7KJjVOYOyz+Zdf0XBttyyEJKvrCIWXFPzFxjYuOah4Sm4kikUqaHgnp8nS8iTJczVO
         hhBH6CbFnr0dw/3tPkjoiM90ZkZ/UAL1oZq7sEMYxy8KPDgfzv2vZvZGBwE3cu6HiwJt
         35Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW7VPaLbFW+LpknqAZ3KwyvTkN3A9j0035DROhNLP0aOJgNsTKT+o14zkQbepYJXgYnkLfY6ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sEVvqpX/2+2Kzuf+JjmjlhjkHmeDju18lygpsRb12O5g7stN
	IG1g2UYLb1/aB0EPxL3GS0demlUXbbDLJo3jZb8xaRQvgNsFQXk0bfwKSphtstio7oI=
X-Gm-Gg: ATEYQzxYxk9R+2pk2w3PytA/n3LNVLKs2tahRgamZHqq4zNwFOXuMCMBSjCYQuzB2bq
	R3InuP+ourufFDx/7yj/VZiKtQR+8I0WyCj0nXd/jRpVfuyVshghMv3auZaxLqf8emgo8EdsT6z
	jQEGKYE8vgf98f4kJOuB4baUGr9dm5dxoaGIXw6oodMtuh21WOa0YXIu/aQ71/pYZdJYSbppZLm
	39lUGTMCAVpiaEwfULTGQ2VghkeHuYRHy234NiToUEeg43Lg2EzBSbSPCdeZIrzgCn0dHY6t8TL
	B6ca4r8FsP639DyC+/5shaz32YsxyNT61oZdaLLsG4jppn9X0diDD5a/PwVeK2krIOeQzs+vcUS
	Dq/XdM6mTaAbv/OL/ko54AIvDGBvH8pmb+tls3czAyvKzONBvYW8TMaWlQ4hTB71GuaOr0IrLBY
	loyfTlP99b4naq41NiT087ijBUwZpVsLi/Sa4OEvmzKNtmM5SAmUrphObGuHSO
X-Received: by 2002:a17:907:ea8:b0:b97:344:7d39 with SMTP id a640c23a62f3a-b972e57ad5cmr369670566b.45.1773321209863;
        Thu, 12 Mar 2026 06:13:29 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14dc3asm134506466b.39.2026.03.12.06.13.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 06:13:28 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b943b75dc42so153722166b.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:13:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/5LF08o8VWbiPNWgDBEXs2x2AZVdDSegCHfLJwPdee8dOSanSD1DGudkOhF4RYHqygpQbVJY=@vger.kernel.org
X-Received: by 2002:a17:907:7b93:b0:b91:2f65:e938 with SMTP id
 a640c23a62f3a-b972e603b8amr390837366b.60.1773321208196; Thu, 12 Mar 2026
 06:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203121723.312336-1-biju.das.jz@bp.renesas.com>
 <CAL_JsqJK3brXxSeD-U42PBCeHoxUhWJYho3ZWj__t5C1LL-n-Q@mail.gmail.com> <TY3PR01MB11346B87DF83086FCFE19B15D8698A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346B87DF83086FCFE19B15D8698A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2026 14:13:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW7GeCF-xTNpRRNEBfzbqUA8ZNqFxctT8zufdRHkvSiAQ@mail.gmail.com>
X-Gm-Features: AaiRm51xpIeuv2QHPm735sslWhSiZm3fYb3vmdcw6ZXZmPeZ7Qqh0uUgQF8JQ5U
Message-ID: <CAMuHMdW7GeCF-xTNpRRNEBfzbqUA8ZNqFxctT8zufdRHkvSiAQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: micrel: Fix dtbs compatible
 too long warnings
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stefan Eichenberger <eichest@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,bp.renesas.com];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Queue-Id: A7A2D272556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Biju,

On Wed, 4 Feb 2026 at 10:18, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Rob Herring <robh@kernel.org>
> > On Tue, Feb 3, 2026 at 6:17=E2=80=AFAM Biju <biju.das.au@gmail.com> wro=
te:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > The KSZ9131 PHY is suitable for IEEE 802.3 applications.
> > >
> > > Fix the below dtbs warning "compatible: ['ethernet-phy-id0022.1640',
> > > 'ethernet-phy-ieee802.3-c22'] is too long" on the below dts:
> > >
> > > r8a774b1-beacon-rzg2n-kit.dtb
> > > r8a774a1-beacon-rzg2m-kit.dtb
> > > r8a774e1-beacon-rzg2h-kit.dtb
> > > r9a08g046l48-smarc.dtb
> > > r9a07g043u11-smarc.dtb
> > > r9a07g044c2-smarc.dtb
> > > r9a07g044l2-smarc.dtb
> > > r9a07g044l2-smarc.dtb
> > > r9a07g054l2-smarc.dtb
> > > r9a07g054l2-smarc.dtb
> > > r9a09g047e57-smarc.dtb
> > > r9a09g047e57-smarc.dtb
> > > r9a09g056n48-rzv2n-evk.dtb
> > > r9a09g056n48-rzv2n-evk.dtb
> > > r9a09g057h44-rzv2h-evk.dtb
> > > r9a09g057h44-rzv2h-evk.dtb
> > > r9a07g043u11-smarc-cru-csi-ov5645.dtb
> > > r9a07g043u11-smarc-pmod.dtb
> > > r9a07g043u11-smarc-du-adv7513.dtb
> > > r9a09g047e57-smarc-cru-csi-ov5645.dtb
> > > r9a07g044c2-smarc-cru-csi-ov5645.dtb
> > > r9a09g047e57-smarc-cru-csi-ov5645.dtb
> > > r9a07g044l2-smarc-cru-csi-ov5645.dtb
> > > r9a07g044l2-smarc-cru-csi-ov5645.dtb
> > > r9a07g054l2-smarc-cru-csi-ov5645.dtb
> > > r9a07g054l2-smarc-cru-csi-ov5645.dtb
> > > r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
> > > r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
> > > r9a09g056n48-rzv2n-evk-cn15-sd.dtb
> > > r9a09g057h44-rzv2h-evk-cn15-sd.dtb
> > > r9a09g056n48-rzv2n-evk-cn15-sd.dtb
> > > r9a09g057h44-rzv2h-evk-cn15-emmc.dtb
> > > r9a09g057h44-rzv2h-evk-cn15-sd.dtb
> > > r9a09g057h44-rzv2h-evk-cn15-emmc.dtb
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  .../bindings/net/micrel,gigabit.yaml          | 23 +++++++++++------=
--
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/micrel,gigabit.yam=
l
> > > b/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
> > > index 384b4ea6181e..284c3ba379f3 100644
> > > --- a/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
> > > +++ b/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
> > > @@ -17,15 +17,20 @@ description:
> > >
> > >  properties:
> > >    compatible:
> > > -    enum:
> > > -      - ethernet-phy-id0022.1610  # KSZ9021
> > > -      - ethernet-phy-id0022.1611  # KSZ9021RLRN
> > > -      - ethernet-phy-id0022.1620  # KSZ9031
> > > -      - ethernet-phy-id0022.1631  # KSZ9477
> > > -      - ethernet-phy-id0022.1640  # KSZ9131
> > > -      - ethernet-phy-id0022.1650  # LAN8841
> > > -      - ethernet-phy-id0022.1660  # LAN8814
> > > -      - ethernet-phy-id0022.1670  # LAN8804
> > > +    oneOf:
> > > +      - items:
> > > +          - const: ethernet-phy-id0022.1640
> > > +          - const: ethernet-phy-ieee802.3-c22
> >
> > To avoid the errors, you would need a custom 'select' that excludes the=
 c22 compatible from this
> > schema (IOW, lists all the other compatibles here).
>
> OK.
>
> >
> > However, I think the correct fix is probably dropping the c22 compatibl=
e from your .dts files. I don't
> > that compatible is useful on its own?
>
> I will wait for Geert's input to drop c22 from .dts files.

Makes sense.

So we should probably fix the following, too?
Documentation/devicetree/bindings/net/ethernet-phy.yaml
Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
Documentation/devicetree/bindings/net/renesas,ether.yaml
Documentation/devicetree/bindings/net/renesas,etheravb.yaml
Documentation/devicetree/bindings/net/amlogic,g12a-mdio-mux.yaml

> > Also, it doesn't make sense that ethernet-phy-id0022.1640 is sometimes =
compatible with ethernet-phy-
> > ieee802.3-c22 and sometimes isn't.
>
> OK.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

