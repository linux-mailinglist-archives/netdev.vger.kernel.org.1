Return-Path: <netdev+bounces-54842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB6880884F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7221C2163E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC53D0B9;
	Thu,  7 Dec 2023 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXt/W1Qp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98C310C4
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 04:49:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bed6c1716so4176e87.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 04:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701953344; x=1702558144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rOWXHXcE/bl3GnAmoX8Mz2P8oxpbxVD71OVPuO+AYA=;
        b=QXt/W1Qp51lyrQ4PEje7CGArUBuPVOOrjaOEIu8n1UXRV2j2AqY7P8gH2X/Cke1uin
         421p2d/SwK0IxDJYgHKsnUrJ2aUnEIjPLSJeT08aCSD6GDTPK4GzFy6gWzCueqKb6504
         LTlRwgMywH7fO+aecSihYQf3Mko57gFg+DPN6Kd90EqxVbaWDRTWpVpPDkJTajevAyqP
         njSRsB1dA+pFaKcAKx+zVApwl3B5KV51AxCeMsD3pH3HquZ4t9ahX6bC0hGrZwK0Vvq6
         lTfYbBqlHHqpG70fZvks19yD5yZVXELYkIm50t9E0dzYf3LPe8kCFm4CAlmBIhRQch6J
         lI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953344; x=1702558144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rOWXHXcE/bl3GnAmoX8Mz2P8oxpbxVD71OVPuO+AYA=;
        b=lrJ9Aa6b1uTIVmNNVwtHdwyVYHfQf5PgNKlajdcEcd5P3hIXeNxxnd5ZhRcEIPvQQT
         2wJT0XNPBXCDudeKXK6nxhkxSn4uETi3OntSr/1XGXq6AS8acYG7Jn37hJ7T4PYpblJ2
         sXqKX+YKu1CxYq9V3urK2z752tlwqK0r6DkrVSgkjeozEzZobGciHwtRi0XsAKfJXiXi
         b8LTN+SAAztHZ7oBJQSLKVSrNMN5cWeI8BXw/ymw3YnQd4FB1JdeEP0zkTzaqJjbHtHo
         qRM7liG0vKAoET2hNld68uHEnXtK2oc3Pa1WvS++lGY9sCZbptijyub89rr8TBJXPdzf
         Dhxg==
X-Gm-Message-State: AOJu0YxGwgGcEL/vOoAnBNbnO/lDcaYwlVxcuPgdfBuMbVFFg3NnrTD6
	N92zzMebJtog8BELXcgLLzvI2O9a/OKljowPOTfyyA==
X-Google-Smtp-Source: AGHT+IGbt+UpAMoyYY7GlgknL8bUKAI9Y8W4Kc2Ebc7/+lJDbwPMqattnZK6taTE0zf1tBEM6IywWv2eeiMKtkj7RBA=
X-Received: by 2002:ac2:4439:0:b0:50b:fced:ca9b with SMTP id
 w25-20020ac24439000000b0050bfcedca9bmr87733lfl.7.1701953343451; Thu, 07 Dec
 2023 04:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201143821.1091005-1-aleksander.lobakin@intel.com> <20231207115751.GG50400@kernel.org>
In-Reply-To: <20231207115751.GG50400@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Dec 2023 13:48:52 +0100
Message-ID: <CANn89iKiiexYLXP1fW3anaZt0TJWPUBBmXdjsAV8t3CH3Ra8aw@mail.gmail.com>
Subject: Re: [PATCH iwl] idpf: fix corrupted frames and skb leaks in singleq mode
To: Simon Horman <horms@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Michal Kubiak <michal.kubiak@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:58=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Dec 01, 2023 at 03:38:21PM +0100, Alexander Lobakin wrote:
> > idpf_ring::skb serves only for keeping an incomplete frame between
> > several NAPI Rx polling cycles, as one cycle may end up before
> > processing the end of packet descriptor. The pointer is taken from
> > the ring onto the stack before entering the loop and gets written
> > there after the loop exits. When inside the loop, only the onstack
> > pointer is used.
> > For some reason, the logics is broken in the singleq mode, where the
> > pointer is taken from the ring each iteration. This means that if a
> > frame got fragmented into several descriptors, each fragment will have
> > its own skb, but only the last one will be passed up the stack
> > (containing garbage), leaving the rest leaked.
> > Just don't touch the ring skb field inside the polling loop, letting
> > the onstack skb pointer work as expected: build a new skb if it's the
> > first frame descriptor and attach a frag otherwise.
> >
> > Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

It seems singlequeue mode is not really used on idpf :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

