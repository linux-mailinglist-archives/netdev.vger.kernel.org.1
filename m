Return-Path: <netdev+bounces-37190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38037B4214
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CF4941C20979
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC161799E;
	Sat, 30 Sep 2023 16:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BC23D8
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 16:23:37 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD5D3;
	Sat, 30 Sep 2023 09:23:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405417465aaso144296555e9.1;
        Sat, 30 Sep 2023 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091014; x=1696695814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xp4w/jRk0j30kIVSxaj/yp9HIujxwao61ALVGlcGV7U=;
        b=G6YuluCqVBg2JtAS3fQS8TFBU8vYq6BGFkFq74KTHrGZs1+Vh4MAtXPdzGF/PEbqvB
         TYgNBtQogm5oqmZWzOw29SkTm6DlrqyHt34KUGG6hS6YC7JtG23FbM57exFw7xYbSaIu
         muDsBTqNBLm+IYDCT1OHxSx8K77yDHYIDKu4zAZnBvGhmNJH1GSUeZLxXogZJy2OAXxu
         +WqWx9Nu8M9mIJ5Rk8qyBqYvrg9DFpyTQFGa4xTPihJZK4d8UbSOjy1tP4HZcubD0jRm
         9u7xtt9Pu5r5DTUxrZ+g54P+XT/z+19O5Hnh4tKGZnXixzM90RL2/y/G50+qCp9zV0m1
         w6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091014; x=1696695814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp4w/jRk0j30kIVSxaj/yp9HIujxwao61ALVGlcGV7U=;
        b=D/Ivx8XIgFbk4+gpYXEFSmxsBO64p+1DqnaIgXo91oLyEMHyDWrl4tljkd/Quu8sqF
         ZFa2AUzdt3PjY7luBFrDR8N0x6x9YbmPRLMdzu5KXv91YftpbyvSThHRsQo1Kcis8V6G
         fLY2hBlaey2cdm6+S6ysvVyyKcMnSjptjPswUlBFK1wBlMj7P02GTdi6PTv2bM9Hww3F
         vgWqkB6zzh48gxFsXMoBxVted2DBktLsOAJ3sniq2iPixpVb9M7IH8qGC0Ex94SyO5wo
         zEq2D3007SWHz1HDPQhtghxea2hlRw8JJ43aob6uJ7XU9aVeISBmJGBTQHpSP1qZTq3A
         3KLw==
X-Gm-Message-State: AOJu0YwavMLCTVxfjnlQ/BHVJJL+g7clJiD2G6yA+epsVl2QjyCW9M2A
	hDJ2l9URUJmM/KZg7f1428FxKfctdUFzEH/jyW0=
X-Google-Smtp-Source: AGHT+IFeJb8SEqWexBKYW2cp2WCNXB2f+EuicmyMkGxZV3riHu5oUmCIfRJlKfyciNHh+oNpbKGgp3pnvS7jY0u36gY=
X-Received: by 2002:a5d:67c4:0:b0:31f:b364:a6ba with SMTP id
 n4-20020a5d67c4000000b0031fb364a6bamr6475834wrw.52.1696091013827; Sat, 30 Sep
 2023 09:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926104442.8684-1-dg573847474@gmail.com> <20230930160428.GB92317@kernel.org>
In-Reply-To: <20230930160428.GB92317@kernel.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Sun, 1 Oct 2023 00:23:22 +0800
Message-ID: <CAAo+4rUpC0NOyPWt4xDFWmEnHCGEBf-wbFBDn18TVsLabdocTg@mail.gmail.com>
Subject: Re: [PATCH] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
 and &tx_queue_lock
To: Simon Horman <horms@kernel.org>
Cc: 3chas3@gmail.com, davem@davemloft.net, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

Thanks much for your review on this patch and another patch
that you just commented on.

I will fix the problem mentioned, separate this patch into two
patches and send them as v2 version.

Thanks,
Chengfeng

