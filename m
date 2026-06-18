Return-Path: <netdev+bounces-300528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 90CtKFtRNGrpUgYAu9opvQ
	(envelope-from <netdev+bounces-300528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FEB6A278B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:13:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CyqSJFfb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300528-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300528-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749EB304808C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05B3314DE;
	Thu, 18 Jun 2026 20:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436E30675D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 20:12:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813548; cv=pass; b=D8ZinR2rq3P/FoKUl8oLhz+W+HJbrVYhtOS+VJogM9ZIj2P2TCs4XkoFVbxu770rwqfNST1lQcJ+u+BDB3SCxB6hNwnzcDu+eWL1hqh1wIHMYwKYwgf1mKeoERICY9ppP1sGmwrWQ1yLxbp7ic6VduAvgPkU1kdpPOcjyzmfMSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813548; c=relaxed/simple;
	bh=LMakqLJ6DkcTSQEvzCOdk0uSWAk9ih3/TMMLZUgSXv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAel4B50GJpKhlyIMpXJ/adhZeiQge4UL8MwIDlDmS4VOXcBt8NUZ9PPeFtOaGa5EBVF/mClunwSlZHIJadnkm9HMq/Gmp7wIz4LW07sqL5lFATIGfGNb3qZTlapCvULUWpMoDV4Vt5ethKVQF81o2ZXWnLzZYtxruK1g60KU0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyqSJFfb; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so2504654a12.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781813544; cv=none;
        d=google.com; s=arc-20240605;
        b=Bo4pYax4TkkpHLHs3nuO/df81nZznMmwl6DPSPQTJ+RQc3l7X+8/KB8x4m0YWRHiXo
         jxzsxfBeShYEmz/r63r5Rkf0Pm/Kq5qfdgfivCEhcUWB835L+LnNbMf/WjXVkRFKqoto
         s6WijTnK7E8VVew7eTMaArQlLyLGkj5MefenI6eTtf32eGLk6utpnLVLkFrTaOBbS4Eo
         SMTJiYFO1CXBfj6CWLawLSPztoQMl6lduGKOCbsZt8WNzaUwpSbjvgrjjjEQS7wbv0eF
         wf+tKuWLJGqjfewg45HpNTu2X1YOL25dJz9/6B2def8IQXPMtil0F4yMKjKBVVg9Afz9
         2Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bFVUtXxyP6VoM5jqUw1jZWOdMMyM7Iu3TpJdXEYl8Xo=;
        fh=Ibpb3NDHBYorcy6rSqtY/VElMVqmuA82aeigzoz/Xc0=;
        b=VlCg1kdDn1+IbQKEzUadfzLNTe13AZ+aWDnhRvxLMtgk6lH0SjyqNqamwwGDMQIbZw
         th8sKtoUEJj2KNNA5AdWqhib+Y5Afrv74CXZqgXj7P2ZFez404shhjkbnaArOA0fqR9w
         ePyilMzJ/dwV1E7/p+ClIHficL4z7SllCTfSeMX8QTjIPJYcWftYe2UHzHdkoPcFFkDk
         AgKUxn0WFVxus+kC2K5tS8niDZF7vlT5bvbKNzqnxXxY1xvdwXeVwMYVqhob6Hsg7Hb+
         xmgEdfnBU3ilQh7tqi7DsomM4xN90aWNUBq0dv/eukA3JeLfNX2zudjtAAZ8LHY1hieq
         qkzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781813544; x=1782418344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVUtXxyP6VoM5jqUw1jZWOdMMyM7Iu3TpJdXEYl8Xo=;
        b=CyqSJFfbj14vgXG4O6MFQGT4neY1d6HyVYoHw5wBS3+43dJl5zqpeJyECm2f1tyCT1
         tCv8BRmvcovgnUSbyaxH/dC/ZtjgXXekKLe5dzYsoU7agh7BCdTZQ7Rm77HldTdEOU00
         nB2MlEj4yWZGyXOFNs78o8uTG+EtLp2Sap5dr9sZ92PhdF4LlvSu5Fl5KgUb55MTPIwV
         OtMRkDdFfRRpz8ziB4Sb6XwXLhxk23nt53SMX21gm6fS1qFeZReJwrKgAPyuPOVDO2fE
         GqmVKpBkblZkIiAdxDr+l3R40oZZGaXDkYw5K2mUq4X4im9Xr5Xrm4XgE1jQs9xzWtz9
         vZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813544; x=1782418344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFVUtXxyP6VoM5jqUw1jZWOdMMyM7Iu3TpJdXEYl8Xo=;
        b=ghpFJR477Sk/6uUviy4FefXZGLLl6McISfTZgX/Zl1PLzoxGKohYMs9Gw9WZgzvX5N
         /rlwPoQN6aw1Y4nk7flCPXpS6zo4laxJNB3RZQtI8QT6CEQRjkE1Rn+19fW1DYLzJ19w
         QgzTNufyfa4XB6pd3OdJPs0OxlcTya/mWNGVMeSQiXI8U/WeDwaE/jMPgWyhTPDaK5mh
         HS5HaDvodneaZOO5pL1PhzbV8Mv9N/s2PUwUhiFiuRB7NoOEAbFUUXTny+cYX8MElHVG
         2wCQeOlZbllyTR3CIWaLXlOmKt2gOoavJdRXe3NvXD3Dp5syewcTXjaOP+x+2SpkTEqN
         hAFQ==
X-Gm-Message-State: AOJu0Yy2RCX6Aab2izAqRN+rd2qEpDGmTUi2AJdIOXz9dsS5A96gDVcf
	zE+tQGgPXzgNMI4G8JLhRXlIFNrOP1ReKTUbW1rA+aObfyT+6FCgxQ1UT87QDruAw2U4VjtGe0z
	v9axUfvXGBhpBGr1LZADt1czkPiIma5Y=
X-Gm-Gg: AfdE7clnAsav7lLnt8rhfnVx/PNa7ZqLivkFhr31y4FgNI1AHDl8tst1gjQTJ4dsY2o
	ECoSeliJipLm1PKCue5f9PUVLwNZP5ucz5VTHuMdFyfK6Ln/2qt42bSX1FBYv5I2sZXBJUGKJCq
	XmcgE7v1C1NmSpzI2AnFyhhFUPdTpPR2l1YTv1GujbUKT2XX/y7KM4hnGCC5i+qDAsQka6CuRy0
	sXVupRuQlSpf4MZwIdoKMfafkaPg1k2NBzgzJk91NJQwEUdH2tr4i/b7xA/cR6mW0KO5GUUgw==
X-Received: by 2002:a17:906:fd8b:b0:bec:5ebd:e169 with SMTP id
 a640c23a62f3a-c097b3881bcmr33922566b.22.1781813543526; Thu, 18 Jun 2026
 13:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618140200.1888707-1-mmyangfl@gmail.com>
In-Reply-To: <20260618140200.1888707-1-mmyangfl@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 18 Jun 2026 17:12:11 -0300
X-Gm-Features: AVVi8CeZMaZG9qRSL2sCRrsIisg80Q57ZNYJ-TUgdL61DGbSatq9lopZICrX2wk
Message-ID: <CAJq09z7fBSdknaNW0ufBYm4wO2vL1tuBjBW5FV3NeGRg8749SA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300528-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2FEB6A278B

Thanks David,


> led_classdev_register_ext() only reads init_data.devicename - it never
> stores the pointer. However, the caller allocated devicename with
> kasprintf() but never freed it, leaking the string memory.
>
> Fix it with a stack buffer to avoid dynamic buffers completely.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/realtek/rtl8366rb-leds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
> index 509ffd3f8db5..ba50d311cb15 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb-leds.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
> @@ -89,6 +89,7 @@ static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
>         struct led_init_data init_data = { };
>         enum led_default_state state;
>         struct rtl8366rb_led *led;
> +       char name[64];
>         u32 led_group;
>         int ret;
>
> @@ -129,10 +130,9 @@ static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
>         init_data.fwnode = led_fwnode;
>         init_data.devname_mandatory = true;
>
> -       init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
> -                                        dp->ds->index, dp->index, led_group);

Indeed, it will leak. init_data is local and init_data.devicename is
read by led_compose_name, not stored. However, stack is a limited
space for allocation.
You can alternatively solve the leak using devm_kasprintf() (my
choice) or adding a kfree() before leaving the function.

> -       if (!init_data.devicename)
> -               return -ENOMEM;
> +       snprintf(name, sizeof(name), "Realtek-%d:0%d:%d",
> +                dp->ds->index, dp->index, led_group);
> +       init_data.devicename = name;
>
>         ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
>         if (ret) {
> --
> 2.53.0
>

