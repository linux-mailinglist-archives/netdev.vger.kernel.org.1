Return-Path: <netdev+bounces-280112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNiGGxNx52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4143ACD7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72B71309B20E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B283D3302;
	Tue, 21 Apr 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2f3wpAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B433122A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775046; cv=none; b=DRpAeO20HtJVU1hrilOXrplz9YJR3t2m14QqqynoKYGXZJmWIxp6baH1FPWbAKiZl8PvhtbEC+G3DByFuqcWuKBTghggH7FtSlphsmzrNoohhjEjHR83mGuzenWJhZnKV3rH7tkQg59mNEQOKOZ3re4zHlUO/D+iOoh0qqhAQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775046; c=relaxed/simple;
	bh=ideP4jrO/m036pXeZo7bcsWjA2k3UgxGXAL0J4EOJJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmcm2vTsCco8UMvjdb6dookGKxFfB6Oyz79EzUUsGKrEIz/ZGJVcZPg/XxPfiugBuYIYOTFp5iLREjp+3EHQdy7p5UvU/6lPOU7RUDC7JYkEIgDMMLGNPt6O/6Z82HVP9g9RLOFdZnjZ4ogWSR36xDuH/eQw8kaQrYubTWPPmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2f3wpAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93E6C2BCB8
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776775045;
	bh=ideP4jrO/m036pXeZo7bcsWjA2k3UgxGXAL0J4EOJJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b2f3wpAgM9QrvFFTlHMpdrImlw7Iplmd1KiU/fQ4R2yhjf+ZmARXrYrCDBaFmScdh
	 sk+IibBstdbWBgUJmI4mVtd3H6EZIx16B4A3k9epI6JpWYgTOnujYOi8937zmE6NHF
	 mX3Y+FfGdl/IlDVef6ewRYMxjjsel6D3Zx2bcacm+0nJsiEfowPmsXsq1ycE/53MCy
	 akU3n/yxpYvz6WB35tcbARG2lm3pqIwHP2ziXyvNZDh2rDlLk3wcZlv2GwlnN2DGy9
	 zbgI9Migue8IeZxEk7m0kvutVYVWep2TOoGfFb0DEd9eGqlD00H2QpCBG50GHjF4Bp
	 LPghQRR0ACMNg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so6444978a12.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:37:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Xoe7zxZCXWfo7S45OtDSwmUr3lCEvSbnhnObocqzBMbrRxpYAJ63bELFnqiuTLTCZZbu0ijk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKnKb490XqYiN7n3FNLhbqbNYNIHKtSyyKhhYLmQOQ+PEnAsn
	wWJk0wei0R9+txgyeb2kvw1gt4L8acP4yZ2+HpaOapuO7Nuxf6JLyrIJfqJoB46D2TBYowUALRh
	KpnIADDOI5/AnlhaPRZbLgNy3h94MOw==
X-Received: by 2002:a05:6402:e9c:b0:672:523f:1bf4 with SMTP id
 4fb4d7f45d1cf-672bfd999d1mr7012282a12.10.1776775044253; Tue, 21 Apr 2026
 05:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-4-minda.chen@starfivetech.com> <20260420133930.GA2322456-robh@kernel.org>
 <BJXPR01MB085573DCF307E33E43FD664AE62C2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <BJXPR01MB085573DCF307E33E43FD664AE62C2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
From: Rob Herring <robh@kernel.org>
Date: Tue, 21 Apr 2026 07:37:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+PEQ7x_3V2173KHyffzY7CzLoYoFDNvTpdn2-Q_eKR-A@mail.gmail.com>
X-Gm-Features: AQROBzB2M3mNV2WntzVbuyGm-8OM0dCyGRaPWNfGo4jCW3v3OLTBz32FUX-FwZE
Message-ID: <CAL_Jsq+PEQ7x_3V2173KHyffzY7CzLoYoFDNvTpdn2-Q_eKR-A@mail.gmail.com>
Subject: Re: [net-next v2 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 sgmii rx clk
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	TAGGED_FROM(0.00)[bounces-280112-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:email]
X-Rspamd-Queue-Id: F2E4143ACD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 10:39=E2=80=AFPM Minda Chen <minda.chen@starfivetec=
h.com> wrote:
>
>
>
>
> >
> > On Fri, Apr 17, 2026 at 10:45:21AM +0800, Minda Chen wrote:
> > > JHB100 SGMII interface tx/rx mac clock is split and require to set
> > > clock rate in 10M/100M/1000M speed. So dts need to add a new rx clock
> > > in code, dts and dt binding doc.
> > >
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > ---
> > >  .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++-=
--
> > >  1 file changed, 36 insertions(+), 6 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > > b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > > index edc246a71ce3..3802cdbf1848 100644
> > > --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yam=
l
> > > +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yam=
l
> > > @@ -39,20 +39,26 @@ properties:
> > >      maxItems: 1
> > >
> > >    clocks:
> > > +    minItems: 5
> > >      items:
> > >        - description: GMAC main clock
> > >        - description: GMAC AHB clock
> > >        - description: PTP clock
> > >        - description: TX clock
> > >        - description: GTX clock
> > > +      - description: SGMII RX clock
> > >
> > >    clock-names:
> > > -    items:
> > > -      - const: stmmaceth
> > > -      - const: pclk
> > > -      - const: ptp_ref
> > > -      - const: tx
> > > -      - const: gtx
> > > +    minItems: 5
> > > +    maxItems: 6
> > > +    contains:
> > > +      enum:
> > > +       - stmmaceth
> > > +       - pclk
> > > +       - ptp_ref
> > > +       - tx
> > > +       - gtx
> > > +       - sgmii_rx
> >
> > No, this allows any of the above strings plus any other random strings.
> >
> > Rob
>
> Got it. Thanks. In JHB100 I will using "oneOf" 5 clocks or 6 clocks. 7100=
/7100 are const clock names

No, based on what you did for 'clocks', you just need:

  clock-names:
    minItems: 5
   items:
      - const: stmmaceth
      - const: pclk
      - const: ptp_ref
      - const: tx
      - const: gtx
      - sgmii_rx

Rob

