Return-Path: <netdev+bounces-50401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0727F59BF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EDB2814BB
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDC18B1F;
	Thu, 23 Nov 2023 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXvsARSi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799301B2
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:04:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so8164a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700726691; x=1701331491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1YTbV2smtQCXsY9F1mEAz+9rHxMSVHBfAEMzp2ajYU=;
        b=oXvsARSi9WfeSZPZ8lFl0R38PrLtFDE+bwUihkVp7q7BvCv9/IcB7bGhhufcYGnY01
         a6QKmgvRJYkUbzmjOW621R4GrTyOrDVafezYxGasFgAlDRcvSb8FC+HU0iXm2wrLVmCy
         uu1wChwdZYxTmTlKBoswwPFHT4kBqVmPFjrjazOA2h9SXGMlgg9wcV7cCCDy+9uQugwB
         fRnXeuPr8/091MHauOYNNnXykIBE3Ewh2pii7uixLaYfujJEWvG0Rbss0BxPwYpjWYcg
         f+nbTfvfOLQjSzo6hX6dZfPwB4jEKw2O6C/uhzSSXvDVHLSbM1Ej1CzzfBITggNxJQTT
         MWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726691; x=1701331491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1YTbV2smtQCXsY9F1mEAz+9rHxMSVHBfAEMzp2ajYU=;
        b=t/g+4mIqUe7pX/y6srXpVm4SAWMm9zt31+Jv5PTuHMGdMLgwSp0mFGsKu5tghsGuT8
         BlEpDbqZOe/lPjNwXyKzB1VzE3edxnuqcklkSVJQ12LabqsDl8UOWMWpn/NjVJ++jOEY
         GgQ09IDjFlhNJRqiOso1DnQ2L7yiREpvaQOLIRQkeZIml7RaZTPm9YI3mqbvhtN6uSj/
         reY9ZkRZ7HtWrMLn3kHOyGWo0L/JYpFYx/tMc19E4HqEOcwWUXPRkgWea/TKWeJjWGV3
         ZiF/wce2/3GKaNdFBkrd2KvUK1KHOdMS5fDcrh7w20OeV4SF7DJSs+nS4gfBn5apEvCB
         Xbzw==
X-Gm-Message-State: AOJu0YxwRGT5jTZyglCCjgWcLT1gZtiyYr1D1rE6Q1eU7tWZ1EvGUfCH
	avzueJ3bh6yVPy9Pz4amezZwW+LCi2G14VxPWu9hoQ==
X-Google-Smtp-Source: AGHT+IF41JZDlrTLBZxU9H6FMQHm1BOQglk/S4Qe3ximVIvwUDqTwQGSwoU0MrI7utodRKGO9rQDWOF0z1+an7padt8=
X-Received: by 2002:a05:6402:35ca:b0:544:24a8:ebd with SMTP id
 z10-20020a05640235ca00b0054424a80ebdmr311814edc.4.1700726690673; Thu, 23 Nov
 2023 00:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123071314.3332069-1-shaozhengchao@huawei.com>
In-Reply-To: <20231123071314.3332069-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Nov 2023 09:04:36 +0100
Message-ID: <CANn89i+Ne=v7i97r6Zo3gSPaUBZt=c2ZroCwv9bXisva+j5nQw@mail.gmail.com>
Subject: Re: [PATCH net,v3] ipv4: igmp: fix refcnt uaf issue when receiving
 igmp query packet
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 8:01=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> When I perform the following test operations:
> 1.ip link add br0 type bridge
> 2.brctl addif br0 eth0
> 3.ip addr add 239.0.0.1/32 dev eth0
> 4.ip addr add 239.0.0.1/32 dev br0
> 5.ip addr add 224.0.0.1/32 dev br0

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

