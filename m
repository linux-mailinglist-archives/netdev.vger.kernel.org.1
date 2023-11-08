Return-Path: <netdev+bounces-46684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD37E5CDE
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 19:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3EB20DBC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9F32C82;
	Wed,  8 Nov 2023 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="R6BKhcW3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE01321B7
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 18:08:45 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4BA1FEB
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 10:08:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so12144082a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699466923; x=1700071723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXRTWOMUNcJmkjQbAZY5Z0iXJWssUD8btwZJIgiRnSc=;
        b=R6BKhcW34p5Mw1PAE7JrntVO6hyJW6u7EXFvcN9sLfjf7NPq1W89EAz/pHr4ueU5WU
         aF+218byFAgjBlZpnC3xKG/C36W1hNh3mftmb+Su8WDgsGcoRed40vMRxsS48tY7nHcg
         sJZwgCAtx27f4BlGWUhWoPRFF8ukyh/Vz2jhvQg+J4JhJqhkv2Mr8QUyLi7NjA/hzakZ
         YQxQEhZnGcNo1qbom5VVfKfTjRjXQy93Z3RNM1osSbUAuvJD5QqXH0wo5rmsHkxczWvj
         pCVGshCqLQvwb01UgMKtaphBJqyQIT+hOrXq0L3+BQgzO7t/ntg/1sRNigFaxpZlTyMz
         MhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699466923; x=1700071723;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OXRTWOMUNcJmkjQbAZY5Z0iXJWssUD8btwZJIgiRnSc=;
        b=r238pDHm2sF9ghsTFs5eDPoPtMK17TGjzuKVBEsZ3hy9Vxt+u7837hghXvmxlx9jPq
         B0acibCnGIHC1+QgTXOlVZQjsn8eZQUeBwZSqiG0x2yDfkfJTzF98mG5BLZaeZ4vfPmZ
         b6J4uunPklcd8u1TNfNCxBopT3b+nyVLuZVNW9Z7IU3koHW5sYdlfByb6mvYhRCDEM/u
         SCmg3QOR4tvXC7kyvLALDagmSO48lsSMl3irdbOE0sRzkLeRsUTeC3zslRtB6ztK4VU7
         EInwUa99+nDqqyVI06NZe4NcBZnrVHwwBaZueYVUc8rD/Ka8rKOovjhiX0K5T33inETv
         zCCQ==
X-Gm-Message-State: AOJu0YzBEdirklJzlRzNfBuLYrb1lUjMOBlv47pY52nUJMvjfrECi4MX
	Yr4DYiBUZqlN1YOqq4TOR+nrjg==
X-Google-Smtp-Source: AGHT+IE8foAOmvHY8FYHpQiJycUqZ00jR++mzKvCgZjL3jB7F67NLcShlJmBGFYtw2Yc7EK+F9to1A==
X-Received: by 2002:a17:907:26c4:b0:9be:45b3:1c3c with SMTP id bp4-20020a17090726c400b009be45b31c3cmr2135498ejc.64.1699466923181;
        Wed, 08 Nov 2023 10:08:43 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id oy7-20020a170907104700b009ad89697c86sm1416534ejb.144.2023.11.08.10.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:08:42 -0800 (PST)
References: <87jzqsld6q.fsf@cloudflare.com>
 <CAF=yD-+GNV_1HLyBKGeZuVkRGPEMmyQ4+MX9cLvyC1mC9a+dvg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com
Subject: Re: EIO on send with UDP_SEGMENT
Date: Wed, 08 Nov 2023 18:55:49 +0100
In-reply-to: <CAF=yD-+GNV_1HLyBKGeZuVkRGPEMmyQ4+MX9cLvyC1mC9a+dvg@mail.gmail.com>
Message-ID: <87fs1gkthv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 10:10 AM -05, Willem de Bruijn wrote:
> On Wed, Nov 8, 2023 at 6:03=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:

[...]

>> Do you think the restriction in udp_send_skb can be lifted or tweaked?
>
> The argument against has been that segmentation offload offers no
> performance benefit if the stack has to fall back onto software
> checksumming.

Interesting. Thanks for sharing the context. Must admit, it would have
not been my first guess that the software GSO+checksum itself is not
worth it. Despite it happening late on the TX path.

> If this limitation makes userspace code more complex, by having to
> branch between segmentation offload and not depending on device
> features, that would be an argument to drop it. As you point out, it
> is not needed for correctness.

That answers my question. Thanks for feedback.

