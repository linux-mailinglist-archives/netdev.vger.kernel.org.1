Return-Path: <netdev+bounces-45470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF67DD678
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 20:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACE72817D5
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975922301;
	Tue, 31 Oct 2023 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQz4eMEI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435121A16
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 19:02:43 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0CED
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:02:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so3397535276.3
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698778961; x=1699383761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4KGArxAse9OlmNDHK67l7i0Cf0qekzekrdh/xlwJmQ=;
        b=yQz4eMEItzBmFMC4dabipGKrJS1ip23YbP8+4da9G2lnbELZFRJaCROodOwdtrGgha
         cUY9sB+uLHDXjaSlo0M570FH62VcuBCTk1UfPiCchgOyGp+peuL1iawzEnWqViPVcqMH
         vtdh8E4g39daL/AlMHA/fBUM9RtOF25BcoZbW/NCnj+FaZ7wkIhOJGibL/aIY252AiAS
         o+q5t/QNOsS9Dv/HXnhpadiWupdGzwv7zOTyywOdiOelUfym/Fr+XN2orVQ4DPDfT34M
         6xbg6GWxRUKfki3n2HoB6GZrh+48OUaOzDsUdIrn/sUWDaYlJ57yd6XfeqTguzQhBBu6
         cB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778961; x=1699383761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4KGArxAse9OlmNDHK67l7i0Cf0qekzekrdh/xlwJmQ=;
        b=HVmiGQ296syOWE1OavB8YTIxxMTkekeWTbZbVx/UKtGK0HoY+xwz3UQWvogq3d83Hc
         +lS8kOv/CeLmXBYIFumfnB/Cu6R5Hsdau9j1n0COMpR0OueLjOmEmKobjb3ER0LRPmxi
         m8yv+OrUcLSADCWSMyW6qM450mPIpkyBDfnRDI+B5hEeSdEzGPGSK6NVmc6kdqcYxlX7
         uz6Kw8G6WiFx9g8mbugLlvaP6QonC7dO23EBpW5rHJm0vVKoKvYo3+b1UO7xkhIuto/1
         QEWETv7ewNH25GS4/LCu3M7PDmQx2QyFHvM85CYOqeCLMqhi6B9GPdoi8hQAgiRbri5K
         roGQ==
X-Gm-Message-State: AOJu0YwqzqR/GPt+PWk+NCiw2rY2Atw4fQjW+Jrs7B9G0iviUNCkwLsg
	Sp1KSjA2bp8Mfg6Oz8X9RsobfuKN+VookGf+3lfBZxqBTeFA4M3a
X-Google-Smtp-Source: AGHT+IFr3vYMDVg5evYLFpLKM2lZT9hhsdNKErYMijLOZGzm/zFiSNML75lGDwp7FixY5bxqeWQAteCakEzmlrwjtcc=
X-Received: by 2002:a25:ab73:0:b0:da0:48df:cafa with SMTP id
 u106-20020a25ab73000000b00da048dfcafamr12634653ybi.16.1698778960745; Tue, 31
 Oct 2023 12:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <20231031163439.tqab5axhk5q2r62i@skbuf>
In-Reply-To: <20231031163439.tqab5axhk5q2r62i@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 20:02:29 +0100
Message-ID: <CACRpkdb=16uLhsXhktLCwUByDAMv9Arg2zzCA+oJW2HBJ35-Bg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 5:34=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Ok, so we don't have a confirmation of breakage with other conduit
> interface than the Gemini driver, either. So a problem there is still
> not off the table.

True!

> So on the gemini-dlink-dir-685.dts platform, you can also use &gmac1 as
> a plain Ethernet port, right?

As a port it exist on the SoC yes but it is not connected physically
to anything.

&gmac0 is connected to the switch, and the switch has all the PHYs.

(I don't know if I misunderstand the question...)

> If possible, could you set up dsa_loop (enable CONFIG_NET_DSA_LOOP, repla=
ce
> "eth0" in dsa_loop_pdata with the netdev name of &gmac1, replace DSA_TAG_=
PROTO_NONE
> in dsa_loop_get_protocol() with your tagging protocol) and put a tcpdump
> on the remote end of the gmac1 port, to see if the issue isn't, in fact,
> somewhere else, maybe gmac_start_xmit()?

If you by remote end mean the end of a physical cable there is
no way I can do that, as I have no PHY on gmac1.

But I have other Gemini platforms, so I will try to do it on one
of them! Let's see if I can do this thing....

Yours,
Linus Walleij

