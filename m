Return-Path: <netdev+bounces-38807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46E7BC8F6
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4261C20947
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8C31A7C;
	Sat,  7 Oct 2023 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcM6WLAb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBC30FB6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:58:51 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940B9BA;
	Sat,  7 Oct 2023 08:58:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so2993347f8f.3;
        Sat, 07 Oct 2023 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696694328; x=1697299128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QqEN0Z4sFsNAs75sSbd741FXKiHxVIQSvrwRy+HtBEY=;
        b=XcM6WLAbxgUhEftkUXXO5x9WKlT65CEIEhGBOec38u9nsGraXl4MjIm2rqHarl7dT5
         KmY8HR4EsQcXjdWDCpGwAixXplIIFlB2hHPQGoWM7ZgGzQ/B+anHd4HLHIcrwHH/EvX3
         a6ds1L48Zen9ytZs8faOjd/YYdWxBRo6Z/M9hDndj9igjhvuDwK66EtextASAc9BIa/1
         KdT8Xcvuzl1CORYXS5zmcelfbSt/izD8f0ENmbpdrD0i8Lou0Je3mwKrEtQY0Bo3tcpu
         Edo3djkj78ijU0Wws9FeN4TRkC+l9nRrMAuQd62WTRPqI+F9cQLp7Xq3FNBN0IoP6Q+q
         7IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696694328; x=1697299128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqEN0Z4sFsNAs75sSbd741FXKiHxVIQSvrwRy+HtBEY=;
        b=qfHyNE3RGcjVfhFiiS+sG4YHcGjKD++iVFc2NdxBKV5Dr0oPg4StdG9eWsJQGyrjau
         PwxS+6OP3ZuqEup00W7tWAwlZa8pfrdg/bCDyGxUJm3S/MHf1lKQEhg2xt0yEgYm4Kmr
         iDTnjzigh2dw0yZd2984xILr1d3FTx2waexZRIzilobxQ1qGjowZA2jYAGh7C1v/ce37
         cMHKsZx7z2jhWvVAxBIKTTb0Yaylp1ppiFT6N7Rw3IYd3vTVptjQcNF6nZNyD6FpW44b
         vd1BukSmJBtuFlFP1SJvLSucflXpuaXZLo8uEEa3hhsP3KtapQ+byTKnHTZOCHps0oYI
         KWAQ==
X-Gm-Message-State: AOJu0YycDQYUk47QMuhP0hqhRD+7QYCozjVqJMuTbTtnEMftRs2nLeOy
	a/RrhDXPejJdkTWH7swWek+Lx4XLNrq8prrROt8=
X-Google-Smtp-Source: AGHT+IEHLl8aq/s7V6Mwt8/mGLMaX7dCJA80WXQJs1/MhGZyKdeRaRJIasSfDrLB+1/d+ThCfu/HG8W4pp9l4Lahang=
X-Received: by 2002:a05:6000:109:b0:320:9e2:b3a2 with SMTP id
 o9-20020a056000010900b0032009e2b3a2mr10138068wrx.33.1696694327693; Sat, 07
 Oct 2023 08:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005074858.65082-1-dg573847474@gmail.com> <20231006162835.79484017@kernel.org>
In-Reply-To: <20231006162835.79484017@kernel.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Sat, 7 Oct 2023 23:58:36 +0800
Message-ID: <CAAo+4rUE=+9Kp8CvMH3w15dJotkX03h=5YMV+hu-YSobkwj1NA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, davem@davemloft.net, horms@kernel.org, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

> and irqsave here. I think you're right that it's just softirq (== bh)
> that may deadlock, so no need to take the irqsave() version in process
> context.

Yes, spin_lock_bh() is enough.

I just found spin_lock_irqsave() is more frequently used in this file, so I
also used spin_lock_irqsave() here for uniformity consideration at that time.

Should I send a new patch series to change this to spin_lock_bh()? That's
better for performance consideration.

Thanks,
Chengfeng

