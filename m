Return-Path: <netdev+bounces-39445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B307BF447
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDAF281A4F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F95D26D;
	Tue, 10 Oct 2023 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzQwLWhm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA0D518
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:26:55 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C27110C9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:26:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c012232792so65688281fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696922812; x=1697527612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o4Hny8Bp62dXkDYUCnY1VMd74kxsOiw4WrEv/PlhCAw=;
        b=RzQwLWhmhChCAkyCL9wWsd6nkOo6Aj647TfjTKI7StSc2tKjdC3MbfZMYgFO6CPiS6
         h0dYFPrLlph1s+06DHl16IBZsCozEscJHWGkMYd7ojrIrAcFAoXtI6cdjm+5hxsmKD0p
         2ibkyzcaplE6tjm6FV3YUxGGRwVvUGus5ex1KhPQPwOJtYDpU6oj83itKAtYmyfqOZFb
         /0sM4A52uQllVErC8NLrffnHF18Wkk0/D9j1mc0t4siEF2G5ZjNJ00AqXVuGDZSt/lFR
         OiMs7HAeJkYwD6unRzaPN2QjCpKrtXtF/qy/s8dkGCx+8a9W2WCkVJeYk/c3H3t2cV8a
         CQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696922812; x=1697527612;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4Hny8Bp62dXkDYUCnY1VMd74kxsOiw4WrEv/PlhCAw=;
        b=AIJ25pFvKUUb41JjE3RanlXQilM+6rR520srvUHw4YfzaZQCNdw0RpWB23L+dc4lJZ
         Uem1ywInfPVov1t4aLdGf1SHenEE4b1mHXwHYtqmPWVAhQJZveObn/tD5/tHbQxMoD8v
         N2/HTjQNXUl2RTR7UJW6nlWY7atoeK1Mbah9OvKytqG7zQUnS/4/ZGeqUs3REtN+3gz1
         gA3hZ0guECtFDEr0EgVrWmnzDCWcdlHm9W6V+XjpxwD7j2xaM/KkTMt8qotuNDgL1Yiw
         5uHYcq5mxm6i+TWvf68Ak2HNUSbI50kenXTp4h9nfeOO/6//sbv/vS6iKwTfqd0OBd+t
         ALRQ==
X-Gm-Message-State: AOJu0YwRfSoiG1AKmk6SfatcmdE0YVgSpkeD/7vcP8SbHsN/9COQfgIo
	RV0B0O8AC9GTxS/916ELfjqJEuLZsuyWeWH7/k058FqmSyc=
X-Google-Smtp-Source: AGHT+IFWEl5v5gLvsVCPrixixuRBbEhoITca87VZwRpu1Yga1nQ/y1/SNlnXJUrtQqrxj1fLncjncUcIXDcmjNjiPPU=
X-Received: by 2002:a2e:2413:0:b0:2c0:ff6:984f with SMTP id
 k19-20020a2e2413000000b002c00ff6984fmr14019651ljk.49.1696922812124; Tue, 10
 Oct 2023 00:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francesco Venturi <francesco.venturi1@gmail.com>
Date: Tue, 10 Oct 2023 09:26:40 +0200
Message-ID: <CACvgxrHamYWW2oj8CVETvBd79Vuep9Ra0epFnPF+S2am6Xdeaw@mail.gmail.com>
Subject: Nice to meet you; I'm a Highschool networking teacher
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nice to meet you, my name is Francesco Venturi and I'd need your help...
I've had a look at a presentation about ethtool and how to run
ethernet diagnostics.
I need to show my students these capabilities, but I need to know what
hardware to buy.
Can you please kindly provide me with a list of supported NIC models,
both PCI and USB (and perhaps chipsets) that support most of this
functionality up to today, including the "--cable-test" ethtool
command line option?
Can you also please point me to a Linux distro having access to a
version compiled with netlink support and provide me with some
guidance on how to install it without compiling?

Thank you very much in advance!

Francesco Venturi

