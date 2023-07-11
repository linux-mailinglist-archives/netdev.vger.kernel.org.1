Return-Path: <netdev+bounces-16975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D074FA32
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 23:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DDC1C20DB8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 21:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B291ED37;
	Tue, 11 Jul 2023 21:58:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D91EA74
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 21:58:54 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12DA1705
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:58:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso70446495e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689112731; x=1691704731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry06/ZQVaUQHp3/s6xrOB+VqsoUQBDEQAyBEYqi53BU=;
        b=jR1DRXZJWdpTygqdeY1kYQNPHW3GF6HCwAKxuoxAs1xU6+4e4aV9hirqluSkBkpYkr
         a1CaaRUIzMyq9RD172Nx5J3YCNzOeRuqGVAExMbL3IKBmS2seQkhRQRYQLU+BkvgVG0V
         Vo7pCm+DeK4lqdgCdMTF2O0h6nA1UXVXfonqPUrtuptWa0vEl7cwzKvvz61+BBNJTZpZ
         isjR/uc3oTvxsXIrmHKS/QrA+jjqHF/JZ3IIuk9Ly7qIgDyPMYYavEAgQ3bZwqD6Dncq
         qvnWbFpM/qOlZ6wdDtPCyM3DlMRePJxA2eE+YBh8MQ0nfWFKTqhl4liTzvdKQvfPZXsw
         kehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689112731; x=1691704731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry06/ZQVaUQHp3/s6xrOB+VqsoUQBDEQAyBEYqi53BU=;
        b=LwxM1vylE+AmfHXTIDOjlr5KLgkPEYFhvWq7guGiyQvtOnqkmJtTw1ST1btgzYvlhb
         n7keSSffHj9Jzh4UDJ0CE2Yvl+r907B8vKQE5EVsMfpWxiU4f8ZLgGMHdxTnaQVFVzBE
         uVmVntTn9M+RvjbYnH/NFvFo/WiIkmOxMxgbk4l97mtWeyVSyu+6KufsxmO4l3tn3/MA
         B0+6aEK/p2qupKcg1MMorlKNkdMCDor2yFy84cdPCq5d1CVQAjf9WOfl7SFj6zILBofa
         ov0RAeHH0FQapWkxstg0UUb50oNcNxoK79NOcIyoglV6kxzV7Oq/yCqeaNGqbrC+mD9Z
         rMrQ==
X-Gm-Message-State: ABy/qLZwnNJhR/ZfzVr8lJ5bd6b7x5YNQiU7yMu7jEwv/Vbx7FBKfCm2
	nw2xT4uzy34/mmJqGjdgzSg=
X-Google-Smtp-Source: APBJJlH74owocfdQcj4y/8SJVwQkI13Ep2VFEAaq0Z5ocnN0Plh991ZB8f7LZnvv0DS9esEeWA9W2Q==
X-Received: by 2002:adf:e310:0:b0:313:f371:aede with SMTP id b16-20020adfe310000000b00313f371aedemr17162277wrj.1.1689112730899;
        Tue, 11 Jul 2023 14:58:50 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b00314145e6d61sm3300473wrn.6.2023.07.11.14.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:58:50 -0700 (PDT)
Date: Wed, 12 Jul 2023 00:58:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <20230711215848.lhflxqbpyjkmkslj@skbuf>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
 <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
 <20230710153827.jhdbl5xh3stslz3u@skbuf>
 <CABikg9xc5PryyT+b=3JsJoHppe+tfOs+BWrq+kETQK99A-DG=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABikg9xc5PryyT+b=3JsJoHppe+tfOs+BWrq+kETQK99A-DG=g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 09:09:48PM +0300, Sergei Antonov wrote:
> On Mon, 10 Jul 2023 at 18:38, Vladimir Oltean <olteanv@gmail.com> wrote:
> 
> > That being said, given the kind of bugs I've seen uncovered in this
> > driver recently, I'd say it would be ridiculous to play pretend - you're
> > probably one of its only users. You can probably be a bit aggressive,
> > remove support for incomplete device trees, see if anyone complains, and
> > they do, revert the removal.
> 
> Can mv88e6060 functionality be transferred to mv88e6xxx?

Honestly, I don't know.

