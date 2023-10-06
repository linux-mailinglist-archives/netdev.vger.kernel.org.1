Return-Path: <netdev+bounces-38506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52147BB421
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DA71C20924
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C612B74;
	Fri,  6 Oct 2023 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28RGOWpR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F8F9D9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:23:43 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9F93
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 02:23:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso7648a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696584218; x=1697189018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+2OvC4UsKZZVe9u7q5rQ09fkS7zT+qmc1odAaqtWMQ=;
        b=28RGOWpRm/BU2DQ+9/2Ma2G0e9oaAshuMLTes5Kg25jTA6qB9Y2iSxwShFDMys2jQ3
         +iwEbDnbdRvShR4lP3c++LiN5jGqodaWcr2O68pW31VpWeX1EHAvsfl25wU5DBVsbekk
         GDbSvJwbFv12jf+e6tD2y62ql5GOhdVjEDUvh0HWr1ggoVDv8a0JsxARgBdJHtuncbQ0
         extx7i2jzGsx6OdladXmkBNkGV5uETHBudV6GgzJU+B8VEHmJ/38FMxS2ny5xpkaPzbF
         qG+vRYy7uVCDgxe0fapXt5tGiKnpnajBr3HoyLNhajIFjHwwzoRnMhjNWT+ey/gWkAP6
         4Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696584218; x=1697189018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+2OvC4UsKZZVe9u7q5rQ09fkS7zT+qmc1odAaqtWMQ=;
        b=knde5xrMa9S9w4BZU5B7pCETl9vSk4rO8AcGgxyZhGFyOwhgflTnAc3D8zUNQPCQ/7
         kMQ8nAY0phEnmPbLXDJLADF3ELyXu/mRnSE4cMwRk43TclEnXlsiW1aeXZ/rAyjt4S3V
         BLKQaH5kmwfiPOU1qV4cSz2PB9cXYCDnn+J1v2r9Zwglyg+jGjb5ZznETjQ2DpMzExx2
         Iexwrghvhu00CBgXztQ16Ol50Gzxh8ssiuVnnh5fdv+cFgeHtZKoK6L8EeJgUrx5zVLG
         FBT5zvRzO2k5MAvDIxrpBHllJmNA015tl2iU27RWTiacm57NCxuiyIqz46XlqGI1/QXZ
         wuEg==
X-Gm-Message-State: AOJu0Yx+pF+1quqnKR1Y0cDq2jZxU5OEKxOsQ+BO0/9f+hvpP7oiLYD8
	p+EuSloLOwIT+dEpVlGqIvqE33XF7a9CsrkV/w01Ig==
X-Google-Smtp-Source: AGHT+IHoIPRhtUQ5uuIPkP4QsVp+QK7bs+DXcxmsIaDAcPgDTfHtOTqkQjKrkJrop+V5dLLPZT7C8FCSJqLUpERZH2o=
X-Received: by 2002:a50:9e8d:0:b0:52f:2f32:e76c with SMTP id
 a13-20020a509e8d000000b0052f2f32e76cmr184149edf.2.1696584217891; Fri, 06 Oct
 2023 02:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231005181747.3017588-1-florian.fainelli@broadcom.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Oct 2023 11:23:24 +0200
Message-ID: <CANn89iKF65tsKRXoAx6tPmgf-y6zBdT7OgNShNrVjdPjGNOEsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bcmgenet: Remove custom ndo_poll_controller()
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 8:19=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The driver gained a .ndo_poll_controller() at a time where the TX
> cleaning process was always done from NAPI which makes this unnecessary.
> See commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> for more background.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Yes, many drivers should do the same...

