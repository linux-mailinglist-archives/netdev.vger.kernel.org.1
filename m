Return-Path: <netdev+bounces-47015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A6F7E7A01
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2981C20B6E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4558A79E6;
	Fri, 10 Nov 2023 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fITl/Egu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95167483
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:14:47 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0C903E
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:14:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1055570f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699604084; x=1700208884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iHTbnop4lW4koc0QbnAiPUYd//zLPqiRYZVB/oTh6Ig=;
        b=fITl/EguiF9R1hxkrrwQ7OPm7CHkQwq8QquVZyv8rUX6gdJYdhv5fZD7jKdUi8cMWY
         c8PH57U+EVXXn86oHnB30c4M22q34CqCtKdqX+KkKfjH9NNskNU0DOumhw4zOv+Go+aW
         HA/VaeaZ+K6PNGNjskyIeST4WORQuOuDlVCt6DcPm6mSp2TXiPPsV3xoG/IOpGsIHikR
         IxtYFmdl+Yn+051D/akEQP0ntp9mJd8Y+6UEa53F+wq4bTYo8WI3a0SDZwP7cUB8IUPO
         2v0lsF8rUI0U36Rel64elOj7Cc1xrkliSThd4MO2sAwFzIVoxkEVTtSvteOV2KlEFHhd
         0N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699604084; x=1700208884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHTbnop4lW4koc0QbnAiPUYd//zLPqiRYZVB/oTh6Ig=;
        b=YdgUqyNQgovBg5fDOTQEtlckwcczNWhYvXAMEsd0+P9jCC4qBxzB/zjt1F7hpZMvK0
         qJJa6gPsFNPko0RZWQ1heM5KLI8B3iyabZguPejpMq/fvSms/41XTtBavf0LIZ+nQLbx
         MrWhOqBaOtHBu4uhkRFt+AnrydzP21MlxEFENDR9ON7jUJRTI/teYILI4FK9B3dWRKRe
         rhfR7Jl8LuiPpmEWEC+O1ZUgQpGNTkWPnccSnByydJ+gdJTuPvAeR093XNmAGsBQD0iz
         R7iQf7+Hxhc72sxIQZUxf+DpXGjfNUIL5EqBSbCZloJ6dPtzTumK4CzTJ2peN/dR/gdY
         x/MA==
X-Gm-Message-State: AOJu0YzQtl1ee2Gaj51lxBv7yaKfUOEvsovg5WhbBB/kNE/l6eK0Kjw3
	PUbs6B/z0GIW4KSPBJpKHNG82dMuGMWy7fD6Evo=
X-Google-Smtp-Source: AGHT+IEsudDcP7JOqJzb21kA7vqsjYb0Dr2Klckxg1XZRuBAe+vQduJpXgsoOwOvsmaT+bG4GO3VkEaCDLTCGyuu86g=
X-Received: by 2002:a5d:6f1d:0:b0:32f:89fb:771b with SMTP id
 ay29-20020a5d6f1d000000b0032f89fb771bmr2094116wrb.4.1699604084281; Fri, 10
 Nov 2023 00:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109000901.949152-1-kuba@kernel.org> <CAGRyCJHiPcKnBkkCDxbannmJYLwZevvz8cnx88PcvnCeYULDaA@mail.gmail.com>
 <20231109071850.053f04a7@kernel.org>
In-Reply-To: <20231109071850.053f04a7@kernel.org>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Fri, 10 Nov 2023 09:01:29 +0100
Message-ID: <CAGRyCJFLytO-k1ekbQE5Z3LN7RVJciB_4Yh9PUVYA3EZeWMG5A@mail.gmail.com>
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 9 nov 2023 alle ore 16:18 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Thu, 9 Nov 2023 08:40:00 +0100 Daniele Palmas wrote:
> > For example, I can see the splat with MBIM modems when radio link
> > failure happens, something for which the host can't really do
> > anything. So, the main result of using WARN is to scare the users who
> > are not aware of the reasons behind it and create unneeded support
> > requests...
>
> Is it not possible to clear the carrier on downstream devices?
> Radio link failure sounds like carrier loss.

The problem is that the MBIM standard does not define the
CDC_NOTIFY_NETWORK_CONNECTION, so carrier loss detection is managed
through the indications on the control channel.

But the kernel is not aware of what's passing through the control
channel, so it's the userspace tool that should detect carrier loss,
disconnect the bearers and set the network interface down.

For example, ModemManager is capable of doing that, but the problem is
that usually the standard modem notifications on the control channel
arrive later than the splat: increasing watchdog_timeo does not seem
to me a good option, since the notification could arrive much later.

One possible solution is to have some proprietary notifications on the
control channel that detect RLF early and trigger the above described
process before the warn happens: by coincidence, I wrote a custom
ModemManager patch for this a few days ago
https://gitlab.freedesktop.org/dnlplm/ModemManager/-/commit/89ba8ab65d4bfbd4cf1ff11ed58c08b112aca80f

Regards,
Daniele

