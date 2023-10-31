Return-Path: <netdev+bounces-45491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701167DD88E
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 23:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E871C20BAF
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39125103;
	Tue, 31 Oct 2023 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMXvc1HG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF220333
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 22:45:12 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E8B9
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:45:10 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5af6c445e9eso55223487b3.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698792310; x=1699397110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFKvWTyDCWBL9OQU/8hWPAY1ypzqmRlRhrzmC//TK/0=;
        b=PMXvc1HGovDdOgdkRz1v4Q3k6/CIteWWFtrKVjAqOHlXJiwbUEq8fyEWOXKZJy/7t/
         atC/W06dSLAtMne9lxd8OBUdP+AVt+lQygPzuEKAA4FjfKACY0V6ZwdsTPCC78O7mv86
         j3ZhjKpWbtzYylbkQ+J44kh7/d1/4mAUtJx6zzSQA6dFyi/51GKKrWL8BDVjQrJI2V4D
         l5uC2lbUq2dfOpvBuyXrFgO+qUzSTbNu7IC0qVPOr+nBicFam8UHMwzKkOV4LNIUW4oR
         mHFDG9fLXynwFKGsOCl297SngxJESWWhCgrHoFH7wnWVLyeJ7ZANUjwo8kDJ5XTIhkrY
         RkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698792310; x=1699397110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFKvWTyDCWBL9OQU/8hWPAY1ypzqmRlRhrzmC//TK/0=;
        b=Zj3qY2BnOxXEMsK8DGcPbVxDgDpl4f5zc9rasdxiqqjictVfhkJ27CBjKKPnS8QhWW
         62cq/nVAwntshlecuBe8MAmxUJtU/oMyVtVaVy2e6fOuDJdhpPDOhzlDku3rk79Ac/WH
         Y7/bXAvr0gjSXZIFrBIMNW2FNeQ0k0V+j/XBIPKHWouqdYoq0e7Mh+y9K9k/1A0hor8q
         8v+jyj91ErTmnuYPasyJ6Yms1AHnCv/dJVUA+d4hCjip4H7DqM7MNriGKK5tVRuCorY6
         CNymYUKnfnMB4eFG3/DGytHvCicJCT2+jVzsj6bY3OIkuaUK/RBHxHK+HN88CxhCBXOj
         N1LA==
X-Gm-Message-State: AOJu0Yy7kK04g5BtpH+9CDjRcAx9RTIheSurm+5oyKTzxCmJlSy8dodB
	rVmc2kiN2IieZrEZEJSTRP7lW98C+YqJMS3TrduQrw==
X-Google-Smtp-Source: AGHT+IEVhT08slaD0cviprClJ11oBBkTF7KarPEXR1oQtHOzYSbbVOhednfPakavUA9zUqbBJmyVFLCqc9EqXQvgNk0=
X-Received: by 2002:a81:b668:0:b0:5a8:8330:6f20 with SMTP id
 h40-20020a81b668000000b005a883306f20mr14934750ywk.23.1698792310074; Tue, 31
 Oct 2023 15:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org> <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
In-Reply-To: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 23:44:58 +0100
Message-ID: <CACRpkdZUYg6APYU4vz5XRUDSp8P0jndgZH-J_q27MUsmZkQODw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 3:16=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

>         if (skb->len >=3D 1496)
>                 __skb_put_padto(skb, 1518, false);
>
>         (...)
>
>         skb_push(skb, 4);
>
> which means that here, skb->len will be 1522, if it was originally 1496.
> So the code adds 26 extra octets, and only 4 of those are legitimate (a t=
ag).
> The rest is absolutely unexplained, which means that until there is a
> valid explanation for them:

Indeed only 4 of them are needed, I tested to add 4 bytes on the tail
for > 1496 and it works.

I'll send a new version.

However that its "tag" is bogus since the extra tail isn't needed before
the paket becomes 1496 bytes, i.e. 1500 bytes including the tag.
It has a logic to it but ... yeah. All I can think of is bad VHDL in the
switch.

Yours,
Linus Walleij

