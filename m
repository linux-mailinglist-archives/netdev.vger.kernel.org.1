Return-Path: <netdev+bounces-42996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB3B7D0F79
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FEF282475
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C5199DE;
	Fri, 20 Oct 2023 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oK7D2fUB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273F199DB
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:16:00 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634C6106
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:15:59 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a822f96aedso7824897b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697804158; x=1698408958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeRAWwn+GIOAPONO5Nd1FGLFR4N0zLDGXgNu8ADyK6g=;
        b=oK7D2fUBOW/C/Pd9y0bJVEnJreKhQNYt95tK+z9yJuHddfW1U0W4ZN61QiEvp3BDAp
         5oQu0lgPqebSlPN/pm5v+jIfgbv2X8cD8InjK1ACUWd36Parcs8fHxClto179t2eGIvh
         BtvXSPNfqAkv86eloPOFOHl+DRn53HMXIjHM5RBhcuP2ye5Mxqb94/rc58fIV5godTHA
         G5bzxoLsZrf53k6l5dEpUsej1Vjh4lf28nxKny5McLYrSrq6DZqgKUhpEGfHPkuU6gqV
         wE39crLkoG/C9kZK+DNJesHEvP+mta8hsIPHFbaaizcugTI/HxXfU+XVrw/8R04Y69TO
         Kz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804158; x=1698408958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeRAWwn+GIOAPONO5Nd1FGLFR4N0zLDGXgNu8ADyK6g=;
        b=DSWrVm8+r96qF7nROImeCOmAgdJQbG+P/wI8ClEaBHuCdqOFW9JqKaLJzn3pfFP5Xp
         unJlpxoH0+eP8ruWSR50m/GE9lNPc89xrldeFdb4t0Ed0zFEqk4yk2d/vIw3IrAWzdpX
         LLA+wLmjeI8S+rISQSs4NY1Qi+YyhfeUKamPfcnQbxgITA7+3JBrb9qsdkANDeNNzED+
         2Xb6kdnWEq65SAE47lPwISqqsk01Eb2O9yFf1Cr1WjA2pCOZkvNZBpNOid1ZGCid5VnU
         PI96/XRnCUuZuiJnnJIq+QJqlyOccFABEbRLVwf+YyGsTFoRtA4FWmqH057W1/mRdVaK
         fxWQ==
X-Gm-Message-State: AOJu0YzQCXL/nhHJUOeZnOnP1h7cz8+SF66OKmnhf36Tl7e8TZU0a4Om
	6geMhVCli0KLl3/3vB9V/1yxq7MWmZnF1hbLmxLe6Q==
X-Google-Smtp-Source: AGHT+IF1EziqpMrk7QV2Fpyaa0sgD98EyxZGn/78LgVc6xQbqFiUqjMe4cD2Nl2kNoj6uyDxBKuhFVKLR+9QTPyeTMk=
X-Received: by 2002:a25:8290:0:b0:d9b:fd8a:871c with SMTP id
 r16-20020a258290000000b00d9bfd8a871cmr1576413ybk.16.1697804158570; Fri, 20
 Oct 2023 05:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020061158.6716-1-hkelam@marvell.com>
In-Reply-To: <20231020061158.6716-1-hkelam@marvell.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 20 Oct 2023 08:15:47 -0400
Message-ID: <CAM0EoMkawLKubMdrTOAcOhYq8Jicc5XuXuytBVi-yy-_QgiTuA@mail.gmail.com>
Subject: Re: [net-next] net: sched: extend flow action with RSS
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	sgoutham@marvell.com, edumazet@google.com, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 2:12=E2=80=AFAM Hariprasad Kelam <hkelam@marvell.co=
m> wrote:
>
> This patch extends current flow action with RSS, such that
> the user can install flower offloads with action RSS followed
> by a group id. Since this is done in hardware skip_sw flag
> is enforced.

Our typical rule for TC is we need s/w equivalence for offloads. How
would this work in absence of offload?

cheers,
jamal

> Example:
> In a multi rss group supported NIC,
>
> rss group #1 flow hash indirection table populated with rx queues 1 to 4
> rss group #2 flow hash indirection table populated with rx queues 5 to 9
>
> $tc filter add dev eth1 ingress protocol ip flower ip_proto tcp dst_port
> 443 action skbedit rss_group 1 skip_sw
>
> Packets destined to tcp port 443 will be distributed among rx queues 1 to=
 4
>
> $tc filter add dev eth1 ingress protocol ip flower ip_proto udp dst_port
> 8080 action skbedit rss_group 2 skip_sw
>
> Packets destined to udp port 8080 will be distributed among rx queues
> 5 to 9

