Return-Path: <netdev+bounces-42532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE767CF348
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB41C20AAE
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145815AEF;
	Thu, 19 Oct 2023 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAg2vyxH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9233E14F6F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:53:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBD9F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697705628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKYvltGDTZPHmBBUWHHWQGHBOyryxG9yuCEoL9SPiSs=;
	b=WAg2vyxHelCIf1LGecRpKCTeOil0N+c1Kfv4F4z89Og1Svawoh2apIFvOrDIwmaWDHKWlG
	DWfaJwypauxNAWctyPo+8FaYpDhZGeHr1ENvyHw7Ctt77Zvl5hP3ztNEs8UJLsy1k+rjzN
	rs/ohPDaLHXZDIbARIJttdQLJ2NaYqU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-KKQLYcTON828GD3Sf3bTMA-1; Thu, 19 Oct 2023 04:53:47 -0400
X-MC-Unique: KKQLYcTON828GD3Sf3bTMA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53eaedf5711so693140a12.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697705626; x=1698310426;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKYvltGDTZPHmBBUWHHWQGHBOyryxG9yuCEoL9SPiSs=;
        b=msvqKACvqgrxlIdo76QhhrsHuYrcK1QbUbI1NwKuktjQJsx1nAP7oyQqzzOdrz/i2Y
         Zs3U+pSj3OEQYblS/hp9Dw/5qW7CKJrH3Yu+jwJWSiGA/RHqAjhHNRfQru0JdB7MO9Ms
         GzxyL6X+x8KUmeGYPeP2Wjt1weHxqBapM91bgdncjTNZkuzazMHTHYgZ2/4zYoWpaKGg
         vytS+Cwuk7eB0bhaivPVBX3RzR1HxJ7avGz7eoBtuc2NMFKzg/lPmV56gNh+hkiNkHd9
         Z0egw+w1c4cIbqBXRGeDpXWZK4cnVSTZUw7tS7FcVWU7mg1Zgic1Qoa+gyQRfcABaDSd
         pfFg==
X-Gm-Message-State: AOJu0YyWQNAL1EB7aGP3lA7XuwB/cuPvfjytmPghdIcLjF0jFKjs5vq2
	MXzn6aOAVZ1sznzbKyz9lX4+8AGhhuxSnuENDf9DsARgxUNJBWCzAOWdTVCBhQZGyzTFtdh36qN
	sF9Ce4VgUmp+xTmzWGZghM/4g
X-Received: by 2002:a50:9f82:0:b0:53f:1a04:e4e4 with SMTP id c2-20020a509f82000000b0053f1a04e4e4mr1054315edf.2.1697705625851;
        Thu, 19 Oct 2023 01:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAUZUJc0kzm+7kKUWEc28P8pZT8ZjRc38n6nk/Neu6/YYJzX8nberMRXNYx7or9BO1aWDr3A==
X-Received: by 2002:a50:9f82:0:b0:53f:1a04:e4e4 with SMTP id c2-20020a509f82000000b0053f1a04e4e4mr1054298edf.2.1697705625468;
        Thu, 19 Oct 2023 01:53:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id a6-20020aa7cf06000000b0053e625da9absm4050443edy.41.2023.10.19.01.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:53:44 -0700 (PDT)
Message-ID: <d1271d557adb68b5f77649861faf470f265e9f6b.camel@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising
 memory
From: Paolo Abeni <pabeni@redhat.com>
To: Abel Wu <wuyun.abel@bytedance.com>, "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Oct 2023 10:53:43 +0200
In-Reply-To: <20231016132812.63703-3-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
	 <20231016132812.63703-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>=20
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by reverting to the behavior before that commit.
>=20
> After this fix, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>=20
> Fixes: e1aab161e013 ("socket: initial cgroup code.")

I think it's better to drop this fixes tag. This is a functional change
and with such tag on at this point of the cycle, will land soon into
every stable tree. That feels not appropriate.

Please repost without such tag, thanks!

You can send the change to stables trees later, if needed.

Paolo


