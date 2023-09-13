Return-Path: <netdev+bounces-33438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924879DF94
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAC71C20B83
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 05:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEE156C5;
	Wed, 13 Sep 2023 05:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69914F92
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 05:56:07 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD16B172A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:56:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-415155b2796so126691cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694584566; x=1695189366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jShndLL7yr7Ah0UGTvVnJYox4eb+w2lvEq2Vv/aeBxg=;
        b=xI2jIsB65Xa5diZNh/WxGzwSz49E9grMvqjfWeGUkbogkHtLMhj+PCHtwxcLH18E/Q
         WHWOtDzfoD19cL9OP7VlXNde1EgeqjuJ2weV+4e7A7y4w72rvdMAzNken/Z0GP+6l8md
         mm4b4/o081M70w0AKzD9lkJg/OyhWlYaUvXO8SJJ7bFOeAPPxSEL0Hgk7NuFKhy5gobF
         pdNJeTUE8SChXEbnr4o2pr/4d+bIpZAO/4GiHLsPMnHEENaWV+X4vHoTyVjUliSSOwBz
         Q93cCzH62iOjX8IGszY4biuT7HfLZ8+O0XrzJ2jA3QzCB8DWA+lVuLJKJd2gTyQ6EgRa
         MhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694584566; x=1695189366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jShndLL7yr7Ah0UGTvVnJYox4eb+w2lvEq2Vv/aeBxg=;
        b=hfFtgMB2d1VcqV+kfMbr1aidkpfqUh28ECZ3LRRFL8N6OXNMngPtLB0FsS+44JhJp1
         LbHl4olV2U69uLnpTviiZEAL2T24iecpmCwFhDjpf6M8m985F0mEhUtyBRAglCmr0Idl
         tyIj6ZW7WOA4ZvrHeJJCdI4rr/kPFfTfvGB37xLfdYNX1A62Nu8aMOUZi28swbUU7In+
         i4iVq9aPKgMahlMb7hfoXi8HwWQ9lnSKO8tI/LXwRKQjU/VxVDzmrYVIXSHW4+EqIc/E
         WLMxHokY2kYKXv3eDk9T6YUV9tPEbheKQZSYibrfy7dPEv7cPLlWtN+SEHt3Cv14fwOp
         pt+g==
X-Gm-Message-State: AOJu0YzZeQR5NgtylOQgObuSVQ4am5CgpjttKcV7LNbTKgbW1XmOTSWe
	yYmBrOGAMeJfc1JfxBD6CmCWVHQMW/jhVxcVP8SJ9g==
X-Google-Smtp-Source: AGHT+IEVz0DqnnCMeEYbd31jlnNUeLoDLN9HtQFEjbmB4SylaWaJ0LRWX04ZYfzAKCnzGdU6su4WCTuxqHHCdF2li6g=
X-Received: by 2002:a05:622a:15ca:b0:40f:c60d:1c79 with SMTP id
 d10-20020a05622a15ca00b0040fc60d1c79mr179833qty.28.1694584565486; Tue, 12 Sep
 2023 22:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Sep 2023 07:55:54 +0200
Message-ID: <CANn89iLA-iba+D5SYxWKYAR1pbo8+qp5w88Q-Xs2KcdFV9JTyA@mail.gmail.com>
Subject: Re: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Balcanquall <alex@alexbal.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 7:26=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Alex reported that running ssh over IPv6 does not work with
> Thunderbolt/USB4 networking driver. The reason for that is that driver
> should call skb_is_gso() before calling skb_is_gso_v6(), and it should
> not return false after calculates the checksum successfully. This probabl=
y
> was a copy paste error from the original driver where it was done properl=
y.
>
> Reported-by: Alex Balcanquall <alex@alexbal.com>
> Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt ca=
ble")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

