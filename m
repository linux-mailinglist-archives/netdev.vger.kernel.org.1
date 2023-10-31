Return-Path: <netdev+bounces-45456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C2D7DD1B8
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36B41C20C69
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC31103;
	Tue, 31 Oct 2023 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8ZqAomZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE632031E
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 16:35:19 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556251BD3;
	Tue, 31 Oct 2023 09:34:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a6190af24aso918176066b.0;
        Tue, 31 Oct 2023 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698770082; x=1699374882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npROlWWHLd9eG8P7dCgq4irOOFIkyMuBg6D6zLA4SMA=;
        b=X8ZqAomZ/bF42tIkKKkMdrPuoOhhCr6dllw6SZFKcB1X7wm4mQouYKLYaI07VwRV9J
         J3BYFZ0NTBA+5oyebgA3PuOdrAg8Rp+AnzJUUze/3HgPSoX893fPttYWBWghKGk5+sWC
         37c+pcXU/MO/wbyb3GD7JExLdWszs0zycQthtw/PEbMRkn6wvwkDi14SX9tnpL/hofx5
         UEMx+rvaNGvHWeASlMdgI7GkAkRfvapiCo0RubYM1inKmaPg8ZkTcGzdAvyO5Zqef61R
         BlZkR3ey6neZ06pC7XQqNYpk2rW/5Y16fxau+tvDjWwNCKy72/5f8Q3D/Y8AHAkERUXr
         30Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770082; x=1699374882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npROlWWHLd9eG8P7dCgq4irOOFIkyMuBg6D6zLA4SMA=;
        b=AGBNAELniBgXRNXrT+PpydvMNgxz3gT2vSQ/zxOg/T+EX/P63DcEam6PheCOMllMYC
         GfjtmOECwb5cZCPm8ud1T8/75OqYxkyzpF9dJoiZ62yHDNj0UAV4Mu8CKa0gbvmytfLq
         1WzQcchrM6BGPnVtGZtXXNsKP4jFUrVRPAiWIXfUBNrHAKjFMQyk953OeXQJjlu5C4uu
         FDpL9eKKg/FNEtVKb6SId+12dk4LIDtZR6yijDnaXMZPP0G9XvaHw6tSXcdI+eZHYcIB
         VxL7l9nFA19GKy1hoSiZUenrPelygz3Mx9ule4dNf4V3+RQSlwivYU9R0VgbIVxHjpHG
         wqsw==
X-Gm-Message-State: AOJu0YyQTriqEd4PdH3xoGKg3u68tEcRuTmekPRDWt6y6t71wVXysAGL
	Njz8pAbp5h07XeIVflZvetw=
X-Google-Smtp-Source: AGHT+IH5USwQhwT8MSNugtJz/VViP8UM4cwRku7P9ocJAQmWum5AXQA72zfDiIRxnh4dXacOdD3dag==
X-Received: by 2002:a17:907:6e93:b0:9b9:facb:d950 with SMTP id sh19-20020a1709076e9300b009b9facbd950mr11850982ejc.72.1698770082298;
        Tue, 31 Oct 2023 09:34:42 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906a41300b009ad81554c1bsm1215532ejz.55.2023.10.31.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:34:41 -0700 (PDT)
Date: Tue, 31 Oct 2023 18:34:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231031163439.tqab5axhk5q2r62i@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>

On Tue, Oct 31, 2023 at 03:16:50PM +0100, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 12:33 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > > Here you can incidentally also see what happens if we don't pad the big packets:
> > > the packet gets truncated.
> >
> > Are we sure we are debugging a switch problem? On how many platforms
> > with the RTL8366RB can the issue be seen? Is the conduit interface the
> > same on all these platforms, or is it different and that makes no
> > difference?
> 
> I don't have any other RTL8366RB systems than the D-Link DIR-685.
> 
> I however have several systems with the same backing ethernet controller
> connected directly to a PHY and they all work fine.
> 
> Yours,
> Linus Walleij

Ok, so we don't have a confirmation of breakage with other conduit
interface than the Gemini driver, either. So a problem there is still
not off the table.

So on the gemini-dlink-dir-685.dts platform, you can also use &gmac1 as
a plain Ethernet port, right?

If possible, could you set up dsa_loop (enable CONFIG_NET_DSA_LOOP, replace
"eth0" in dsa_loop_pdata with the netdev name of &gmac1, replace DSA_TAG_PROTO_NONE
in dsa_loop_get_protocol() with your tagging protocol) and put a tcpdump
on the remote end of the gmac1 port, to see if the issue isn't, in fact,
somewhere else, maybe gmac_start_xmit()?

With dsa_loop, you turn &gmac1 into a conduit interface of sorts, except
for the fact that there is no switch to process the DSA-tagged packets,
you see those packets on the remote end, and you can investigate there
whether it's the switch who's corrupting/truncating, or if they're
somehow sent corrupted/truncated by Gemini on the wire (which would not
be visible in a local tcpdump).

