Return-Path: <netdev+bounces-45429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D67DCEE1
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D7B281816
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC81DDF5;
	Tue, 31 Oct 2023 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAxwaCYB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E81DDEC
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:17:04 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D74F7
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:17:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a8ee23f043so54671407b3.3
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698761822; x=1699366622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fVXL7vb6GbxabG5we2Eq28H8QOY1kAFg3Bko4ORL2g=;
        b=dAxwaCYBtixPEx0tcuSEUmDR+j3Xd/7t+51p35EK3TSX+NM8bW/I557Ydz72DBnQ+s
         W9MkaKImcfFDmtcihHHlpEPBZlo9TrXqE8ImQWMhPk46qNwnqqi3baBKEseKf0DwAFDn
         RnAAcIU8bfmqdNjuhpIxv8OH60R/E09szocCVpHuYZbQBS9oCovQBqpPzVYHEMfxCOaJ
         oLgxAuHcjSM+62eWPXaExDuzPRDN39eW+scxi1OXyixEHA6lcTm7+7bmAZ4+Ze+rY3hd
         uak5LG7TiNGy3CvHVOd/sUhpAdq8Cs39dN0wfTSC5Wenj3k5lC6MLvvJxzS7zeNccHrJ
         Jzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698761822; x=1699366622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fVXL7vb6GbxabG5we2Eq28H8QOY1kAFg3Bko4ORL2g=;
        b=aiMF5RJAzeKQnpRwixn4GIYzRAFpRI1Oi6o8HKbPGuivaw19ijUOQ4PxnYCxS5PiMC
         76LxT0uipCyg1Tjw7Wyujn7Le5GlcLHdFTDlRJqP/MlLRNICeU8CvfIzQK/D/vsl4x91
         38wLPC11FsP91y/wColZbmszIr8D9u+j6W4DHgWbCQMeAlyck9/CBGO0FJXpn+byucG6
         /O72ekHyijA1m3sSZZMYa1UKfyRlTDgbu/BDtIAJRyudZpbps+CVQmrpxF+g9iXRsvWw
         xh2NmFT50jm7e6vXgquXfUpel5dz8Fm0Avxxl+6Wa67QpgOaBzPQ2kez8ecdEeCv3yU+
         60RA==
X-Gm-Message-State: AOJu0Yz1Z5rn4y7n2AwLUpeA/L5E20Z352iWuOFTdd6Mv/LJMtttMta3
	pmvTcgFaF7uc8Ce2kZpQVvtXtiTUxd/nDFf0HevQpg==
X-Google-Smtp-Source: AGHT+IFCck+AHxWiEdyT40Wws/dE6mHlB2i4QggXWgD7qWIthaYxhzHpcbulHD6te5HSkKkST4qKxhqEXvsPPhwoXhs=
X-Received: by 2002:a81:79d1:0:b0:583:3c7e:7749 with SMTP id
 u200-20020a8179d1000000b005833c7e7749mr11832766ywc.41.1698761821616; Tue, 31
 Oct 2023 07:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
In-Reply-To: <20231030233334.jcd5dnojruo57hfk@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 15:16:50 +0100
Message-ID: <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 12:33=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com=
> wrote:
> On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> > Here you can incidentally also see what happens if we don't pad the big=
 packets:
> > the packet gets truncated.
>
> Are we sure we are debugging a switch problem? On how many platforms
> with the RTL8366RB can the issue be seen? Is the conduit interface the
> same on all these platforms, or is it different and that makes no
> difference?

I don't have any other RTL8366RB systems than the D-Link DIR-685.

I however have several systems with the same backing ethernet controller
connected directly to a PHY and they all work fine.

Yours,
Linus Walleij

