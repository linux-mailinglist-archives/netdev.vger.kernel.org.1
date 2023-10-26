Return-Path: <netdev+bounces-44457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB287D8084
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A961F281DBD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EF2D043;
	Thu, 26 Oct 2023 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwhMrgYy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132510E3
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:18:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE47198
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698315523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEWaTPy+OzG1mamkgathmA7TpNhhzzc36d0J2bA1+KE=;
	b=BwhMrgYyziWXBiN7wj6GfY01WOfWMHIJRkQFLhr9Tpg8mVcmhPYvA9QNIV3OtsShuFeX8g
	XoQn+JL/RpMFzkASpcv60Mz0qR34bVz3dWAp9mR0gM4kz8Wa0Z32dgj21QWXfbtoQxPjgZ
	HpQOV1L77cx8K0w1EDW3nBzRNK9WsjI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-4WbtzkwZPF27KIW4sHgBew-1; Thu, 26 Oct 2023 06:18:42 -0400
X-MC-Unique: 4WbtzkwZPF27KIW4sHgBew-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53f8893ddbdso173758a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 03:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315521; x=1698920321;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEWaTPy+OzG1mamkgathmA7TpNhhzzc36d0J2bA1+KE=;
        b=vZDbyLw68fQ/XwTxYkY2s1XBnPIpFyu63Q0KnvLD4wOieFNu0VDp/Vj7Xn6j3yKuuR
         c9LGPZPUAohuY1jqSpqLIMsuwnGnQghljZ+z5drPpYrT21EbFsljQI88JJoiKMgB4U25
         DSbU4yCbHWc+kpWLvlztzqF6cpg/CcCeTi/zhwqv+FIY+BmAj0WOASvPe9GSVxT9RIAZ
         EAYQLa3CwNiqCC4nXnVWV8uzve6/gP6FTK/a5y4uwwh8hHsR3wQguGHOrDfUIit5Tu2A
         PZEF5StMt7xYB495kRWgAQZmuc2xpNQacT1OhDr7xkWtWwEPDAfeoSgLtJQG4g3EkURZ
         NL3g==
X-Gm-Message-State: AOJu0YxOdeYygvZEZhlmF/BTxaddQABuhpt4zXdAeK4Yh9Y1WojYe1BL
	+9iCdUHJ6Kz0BX9Q5UAPQNu1plCqCdlkor+kBalqkhb6HOLvKcJQdRL3fQzJfituQl5KV94WgMG
	N5RT46gbm7MdAhegNutr9vKWU
X-Received: by 2002:a50:9f8f:0:b0:53f:1a05:d346 with SMTP id c15-20020a509f8f000000b0053f1a05d346mr13718271edf.3.1698315520512;
        Thu, 26 Oct 2023 03:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ7yOQbD6vHhja3ixZg2/pfDXyx27381QNMjHLvGdqxJ7gMGZ6Vm8fllVgn75Itcw8KMRcJg==
X-Received: by 2002:a50:9f8f:0:b0:53f:1a05:d346 with SMTP id c15-20020a509f8f000000b0053f1a05d346mr13718257edf.3.1698315520195;
        Thu, 26 Oct 2023 03:18:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-52.dyn.eolo.it. [146.241.245.52])
        by smtp.gmail.com with ESMTPSA id b59-20020a509f41000000b005402b190108sm7785792edf.39.2023.10.26.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:18:39 -0700 (PDT)
Message-ID: <4d040834d0391cce77a333b3ea577cb130fdc72f.camel@redhat.com>
Subject: Re: [PATCH v1 net-next 00/12] tcp: Refactor bhash2 and remove
 sk_bind2_node.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	netdev@vger.kernel.org
Date: Thu, 26 Oct 2023 12:18:38 +0200
In-Reply-To: <20231023190255.39190-1-kuniyu@amazon.com>
References: <20231023190255.39190-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 12:02 -0700, Kuniyuki Iwashima wrote:
> This series refactors code around bhash2 and remove some bhash2-specific
> fields, sock.sk_bind2_node, and inet_timewait_sock.tw_bind2_node.
>=20
>   patch 1      : optimise bind() for non-wildcard v4-mapped-v6 address
>   patch 2 -  4 : optimise bind() conflict tests
>   patch 5 - 12 : Link bhash2 to bhash and unlink sk from bhash2 to
>                  remove sk_bind2_node
>=20
> The patch 8 will trigger a false-positive error by checkpatch.
>=20
> This series will affect the recent work by Coco Li reorganising major
> structs.

Given the above implicit dependency, the fact the the struct reorg is
almost in a ready state, that we are at the end of the cycle and that
this series has the potential to bring some non trivial side effect, I
think it would be better to post-pone this series to the next cycle.

Cheers,

Paolo


