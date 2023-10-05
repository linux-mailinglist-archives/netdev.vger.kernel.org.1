Return-Path: <netdev+bounces-38194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9587B9BB9
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 10:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CC3B81C208A8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D563AD;
	Thu,  5 Oct 2023 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhQ4hlFJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74B7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 08:06:35 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3A868D;
	Thu,  5 Oct 2023 01:06:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226b8de467so701173f8f.3;
        Thu, 05 Oct 2023 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696493192; x=1697097992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3D64ys7Y9Kfwst1+PfpLbA0bnJLWhV+7Z8p0nT7iUfY=;
        b=HhQ4hlFJKWKiryfgDewlRNIKck7o1tZpVlN+HEERa960sjmSLRphhooRdBOgTKNwcu
         W4R+fEJDzOywQB6pX2wQ5gJiVxcwrZpGtnJhtO1QSVXfYvT2Hl7auYcb2myFIdQbHeZv
         +KpGx1eSEqkgzkuAYcwiOzYdYcmUQi51g2to1/CJDD7xnK3dRCiKK4O7pjpixUyb5JSB
         T+gW1rnyVfAb2r4048m/T9yiewLIg1cll97Lq6GVm818B5BV+2gC65vf60N9uuniju1z
         XhwHRJGwFixKdTQKXlKXpra+JGM0KOsBIntZPlr0wqk8Hri1YI4FXo5nx/IwKRgBeCib
         Z/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493192; x=1697097992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3D64ys7Y9Kfwst1+PfpLbA0bnJLWhV+7Z8p0nT7iUfY=;
        b=Jvw2c1x/XQwUnxd3R5TgegMEuzcgNgzejehve/qbyIl6xqXG071JkIMo20ExQE6R3N
         GgzZEClS8LwdjoO64u09GwpvxMUaEtk5BP8eXOLjfN3HZEbpeK5/jcQK7d9uXkN/Gdxk
         1IaiSvl7TZq1v69lMkRIh6cii+vbxF6UOaKZlDbITJOd5pFBhUzvK14C7ipTEKdkpD2Y
         cFkdRmqDkhaJTrfUqtchxFBslqU1hFK7feDXSx3wFh2x6J+zTqxFexBDIre9m9DzbD3g
         VzUUXJkM25i34tWukGptMjLxNCh7KBo0qlZCQt14bMqgCw8wLYrkBAFpmiSSue1h9GBR
         I7xA==
X-Gm-Message-State: AOJu0Yxqx9OF+bQlUgVhR3jnXxqgYenYtNaG+NN3YAb3bZnDclILEGqu
	Bb4GWTZ25mU7R80lR3IYu7e+ll9x2W7mutGZWAslMJRy
X-Google-Smtp-Source: AGHT+IG1l7K9F4O4IKLUskx/V3dL6B/Gd3COeS+t8ETpAx5U3+ANkIwRQHHPiVldlICWEOzrXKIIKBJ0oXHWWNWKsE0=
X-Received: by 2002:adf:f9cc:0:b0:31f:98b4:4b62 with SMTP id
 w12-20020adff9cc000000b0031f98b44b62mr3645102wrr.37.1696493191520; Thu, 05
 Oct 2023 01:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926104442.8684-1-dg573847474@gmail.com> <20230930160428.GB92317@kernel.org>
 <CAAo+4rUpC0NOyPWt4xDFWmEnHCGEBf-wbFBDn18TVsLabdocTg@mail.gmail.com>
In-Reply-To: <CAAo+4rUpC0NOyPWt4xDFWmEnHCGEBf-wbFBDn18TVsLabdocTg@mail.gmail.com>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Thu, 5 Oct 2023 16:06:20 +0800
Message-ID: <CAAo+4rWOGNo-2XFTj3Fk2so98DrUGC=cQqAmxcELFEk6euPd_w@mail.gmail.com>
Subject: Re: [PATCH] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
 and &tx_queue_lock
To: Simon Horman <horms@kernel.org>
Cc: 3chas3@gmail.com, davem@davemloft.net, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The splited patches series were just sent.

Thanks,
Chengfeng

