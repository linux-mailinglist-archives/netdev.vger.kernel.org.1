Return-Path: <netdev+bounces-39726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5F7C4388
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A8E1C20C31
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CDB32C77;
	Tue, 10 Oct 2023 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv23xLrz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B232C60;
	Tue, 10 Oct 2023 22:12:58 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1819D;
	Tue, 10 Oct 2023 15:12:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so1070784866b.2;
        Tue, 10 Oct 2023 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975975; x=1697580775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMacfqqqTJ3/jfPswDnIlI2NnWBnSCY0raKFLC0zeYk=;
        b=Kv23xLrzWCTU9W7DGrEN2jqi6tV6hs/OWPs47Ol76a7qSCGIVD9CSTK3IyV62TO7iB
         KWTwvlsIkQVSIfmDoWZZOcs8SpURwfu5B0jZqyfPQUuQKEScWPmpgHHdGWX1Zo+TDdbS
         Ts1PFq6bw8W6kjTNZlZMj8/SvFOS79mM9auIIDYK2WO/MXrVASGPRCpwlrROi1libmQn
         88R9reF8mOph3NPH9EV8+vLdCa6CIqtfHbyi33rJzsBfHBv1UzPbInzL8EgbsVJoqmzd
         UCrCMxBwZs7RbB446GX5buWOCy1UfrnE+j8eOSIJzO9F/e8lbF+Qy+6r+VhlUdGOdf8g
         pniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975975; x=1697580775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMacfqqqTJ3/jfPswDnIlI2NnWBnSCY0raKFLC0zeYk=;
        b=WypXl2/eQMN6W1cjMWZbCCetXNPLJsp5z+VtVNIOusYJSPaUUpIms99cjXsHZcwi9i
         povc53Vks8scESPxkOGeOL+gUebYgsfUP+Kgf9fhiC/hQdbeJin3YYdBupSJHjC06mZ7
         LybQdjnsIxyRKIy6G8GSLsYzYoo3J4khu9rpZzOBuMId3nAUinYuXOKYEGtrEXrXjyD8
         Mu+LKSGKsGJU6T7IgBQLo8aqMz0cPx7CIfd1AL13qBoL+YtOn3/JeChDRf8DAgX7RWS6
         Mp+U8eZn5o8VjWP17vSMz/0/cTtz66wNfFItL7OYnLKNJA0j0yZFe8Ya9QdeHVnR1HNW
         ncfg==
X-Gm-Message-State: AOJu0Yw/wBuWMoJ5xSVsvsFMZ1slf+rzZe9u3YeNfwJN/5OWLmvRZPoa
	4N0o2PPK1ci8+Hwx44ctKC0=
X-Google-Smtp-Source: AGHT+IHtxkdUCJyGCRCOewxpG0renGpMKFEwmq7z7YDvTUje2A9FAz1AugGF4japzs/NsLfN0ooiYw==
X-Received: by 2002:a17:907:75db:b0:9b2:9741:e1d9 with SMTP id jl27-20020a17090775db00b009b29741e1d9mr17098098ejc.63.1696975975061;
        Tue, 10 Oct 2023 15:12:55 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b009a13fdc139fsm9002309ejb.183.2023.10.10.15.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:12:54 -0700 (PDT)
Date: Wed, 11 Oct 2023 01:12:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <20231010221252.ia4ffibu555rt7jl@skbuf>
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
 <20231010112051.zgefbx2c3tjneudz@skbuf>
 <CAFhGd8qoAy49FnnsZVn89f-cVgsfivDzhu2PzYZ_UwCvhmrhYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qoAy49FnnsZVn89f-cVgsfivDzhu2PzYZ_UwCvhmrhYw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 02:49:26PM -0700, Justin Stitt wrote:
> On Tue, Oct 10, 2023 at 4:20 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> > Here you don't use "%s", but everywhere else you do. Can't you just pass
> > the counter name everywhere, without "%s"?
> 
> Because it's a string literal, no warning there. Maybe an argument
> regarding style could be made. I have no style preference here
> so I could send v2 if you feel strongly about it.

No, leave it alone here, don't add the "%s" where it's not needed.
But I guess you'll have to send a v2 anyway due to the other comment.

