Return-Path: <netdev+bounces-46762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451B7E64C9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 08:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55931C20856
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D6FC01;
	Thu,  9 Nov 2023 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVfk9uyg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06259101C7
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 07:53:14 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F419A3
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 23:53:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40859c466efso3460375e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 23:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699516393; x=1700121193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0cFNkdPBXEQmauFCGvQJX1OnSg1i3W/wJxSSXiUuRQ4=;
        b=FVfk9uyg5Fxt5RLyK5JCyGM30yfi2aib++YDlo3pryk1tzuwzYolXWHCz/Z26au8dm
         MLV3Nkbs5WhoLwhoE0wSKVWE0TGkHZ5Fc96zv1Xz0y3gEh860fKpqVdJp5BVnZ6Mpw+1
         jZWiRkDkHsFoZUOSTmsGVXtxLpgKkfsRzjS2CzRvfHB8T0svM8kOBzTq263ksM5/MnzF
         oeR9V1i2myHEUtIVzdGf1EhGHVviyZ+tRJ5iasR8W6SWcQggWqUMLUjrS9j7WHPM59Ij
         viaB8bbyzmKIbtp+aSf1ln/C6CWnAIGzxnM5Mto8FDT3r+b0Q8YTZfEdxBxGZ4qTw/CX
         I8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699516393; x=1700121193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cFNkdPBXEQmauFCGvQJX1OnSg1i3W/wJxSSXiUuRQ4=;
        b=joygf469Fp5le76+2sOiXNU13omwjLUs3umJq+42qBXmGZKWFTXN5u0Fb92tB5RnRz
         pln5tmT0JNmql+xlcTvxOhdxIC6E8RQypxxGYErhPjj6Rv0aSwFjvLKRDMZBq4L5lmgO
         Q6VekUysV9teMD1qYXJHC3g1wdF2zse7UCuRp49bDbAVHfCEZdzoxKfagCyfT1DurwIW
         QtXpYDnol5rrO7tcMI0enVc1xE2b5EnrqodzPYX89KgPS6QHbvsSeuHbUlFixCCWCd9W
         iXxb6Fy5p5Pq3xtlUdxMYebXnjMUCgtJxZrpyXwblEyJ1hsJfLywCHCMQSedqAYQEzpQ
         wgnQ==
X-Gm-Message-State: AOJu0YyUD88fuZuSj1+XqYH3pFa0XPTdmP5/sZn5cAUpOkmoE0rmMRzv
	q4NgnOmfHFsWFrVGzVIEzwrgvqthF08LiqANVvA=
X-Google-Smtp-Source: AGHT+IGFigdZwZNUPQfZqfhswnOapjFKfyiHaWWzohYVg4S929u3tIAKVf2qhiH3bG8mIugyj7Btl2pI3cd3CJ0MONI=
X-Received: by 2002:a05:600c:a4c:b0:406:52f1:7e6f with SMTP id
 c12-20020a05600c0a4c00b0040652f17e6fmr3880123wmq.12.1699516392526; Wed, 08
 Nov 2023 23:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109000901.949152-1-kuba@kernel.org>
In-Reply-To: <20231109000901.949152-1-kuba@kernel.org>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Thu, 9 Nov 2023 08:40:00 +0100
Message-ID: <CAGRyCJHiPcKnBkkCDxbannmJYLwZevvz8cnx88PcvnCeYULDaA@mail.gmail.com>
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

Hello Jakub,

Il giorno gio 9 nov 2023 alle ore 01:09 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> The top syzbot report for networking (#14 for the entire kernel)
> is the queue timeout splat. We kept it around for a long time,
> because in real life it provides pretty strong signal that
> something is wrong with the driver or the device.
>
> Removing it is also likely to break monitoring for those who
> track it as a kernel warning.
>
> Nevertheless, WARN()ings are best suited for catching kernel
> programming bugs. If a Tx queue gets starved due to a pause
> storm, priority configuration, or other weirdness - that's
> obviously a problem, but not a problem we can fix at
> the kernel level.
>
> Bite the bullet and convert the WARN() to a print.
>

I can't comment on other scenarios, but at least for mobile broadband
I think this could be a useful change.

For example, I can see the splat with MBIM modems when radio link
failure happens, something for which the host can't really do
anything. So, the main result of using WARN is to scare the users who
are not aware of the reasons behind it and create unneeded support
requests...

Thanks,
Daniele

