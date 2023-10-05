Return-Path: <netdev+bounces-38418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607A7BAB6E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 597ACB20959
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064FD41E3F;
	Thu,  5 Oct 2023 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCKnPK1f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111F41E38
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 20:26:25 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FA98
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:26:23 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a229ac185aso16695047b3.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696537582; x=1697142382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+vFXwmp+9tswjf710RHJJtAQWo4CXzsbf/R25OOJto=;
        b=HCKnPK1fVFM2Fy0yEDomfm4PnWgHeKspsIxXI2vr07ZBFJgNesdQr8NErgrCKrfLN+
         RFnA/X3eHHgNaRXpgfNgFsFHjFwPJWyW3jVpeVuod+/PomNT6foiqcwUGqfaUnB9GWax
         CLbUHwWu3jgaL3y+aD7PGOBV3r3ov69rPI96fH1lHoo+605aVgnykNNZvdZ9ovSNSpbh
         DI8o6vYcWXoEj5BPdySBJyo3qnkNggpWdi9DzMjmUxx1YJRd/sPGCunWHKKY0+2YwSmm
         ZWSg5sXCY4KTdYkzU2SE9GdmYzfW8zXWSiZZCCfn7vIG72H9/jL0fHDDfYpIAioTHLeQ
         /4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696537582; x=1697142382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+vFXwmp+9tswjf710RHJJtAQWo4CXzsbf/R25OOJto=;
        b=ohLtZ5wjUEaTrGapSPMKTCIE+QjqcjNDDJb1Q3X5eY8xIkS5MWwPHS1uLhPZGRFDdk
         GE1LiaxWPa2Ypqg/3Rt33KYgaj6ilq8iJdJ8LypaDFIs8UQPlbFbYQ/EEes1bQoutVT6
         5nekTZxq1kXYYMgwjFNTLdeeBph/Lyi1yK8g4Q1YLCjZ5fxk1YFi0mtX0/u3SGh0vPtE
         KDD7sNTt/s4Pem68JSs15UukT5QNxcwPPuOsiTsmPEzIIdy0d2NULL0gctDFOSvVBBXn
         YQBs15S/yY75FWgr+3dyjLvj68W1PakjFIJ76S05+xFUEI7+RkyltLVGUfwv28me15tZ
         NJaA==
X-Gm-Message-State: AOJu0YzysCJDyrQi9sLPqifaQu6AwNSsZ2aTUi0GTUzIoJnK0+p5kmRB
	0FvCOws5ptOoXba6RyrkQWUoScfxaTeRDwuLLMS7iw==
X-Google-Smtp-Source: AGHT+IEGpzdAhuxSYuqOwe4aCJHv9kTL7tagkbcdujS4GlykXJh/4hKMn94/znw1qMEseb/YeerBjXKnmSgSFHqsr4g=
X-Received: by 2002:a0d:f783:0:b0:58c:b8b4:2785 with SMTP id
 h125-20020a0df783000000b0058cb8b42785mr5719790ywf.45.1696537582399; Thu, 05
 Oct 2023 13:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
 <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
 <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com> <0c0b0fade091a701624379d91813cfb9f30a5111.camel@redhat.com>
In-Reply-To: <0c0b0fade091a701624379d91813cfb9f30a5111.camel@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Oct 2023 22:26:11 +0200
Message-ID: <CACRpkdZU6hxqftMmNyu68iVJDmftDYe9tYk7+1bZ4_Ne7CevCw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
To: Paolo Abeni <pabeni@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, khalasa@piap.pl, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 9:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:

> > Sorry Paolo, this is the latest version of this patch, which sadly chan=
ged
> > Subject in the process:
> > https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb=
9@linaro.org/
>
> Ouch, my bad :(


It's chill, I already rebased and resent the patch, it's life.

> The change of subject baffled both me and patchwork. As I process the
> backlog fifo, and was unable to reach the most recent versions due to
> the backlog size, I missed the newer revisions.
>
> In the future, please try to avoid subject change. If the subject chane
> is needed, please explicitly mark the old version as superseded, it
> will help us a lot, thanks!

OK in patchwork I guess, I don't understand that tool very well otherwise
I would have done it right, I'll try not to confuse it more.

BR
Linus Walleij

