Return-Path: <netdev+bounces-49976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4880E7F422A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036AA281465
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0C55778;
	Wed, 22 Nov 2023 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ODa5HEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC22172E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:44:38 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso7566a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700646277; x=1701251077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnktvLfPqF8ubdwz6Rv7MhJE7wv1zfKWDKkb317lazM=;
        b=4ODa5HENDSzzwv6pT1R1TahfucrkcUfcpJTZ/EU8jINAm4XZwBQINB50dGvfFHJARt
         6i0TmmApRDo/oQtHPUytexA+AiSoZnDzlLuKhGIT3o3N49MbQ7YUODO5Lyq9XrkEbSoF
         AzN/hadc2YGkfSo9beoB/lLKfbJILLmlAy8pMmo71oQv1lke+ITZv7JNXyhMXUj35FmP
         KcA1PhW1PyNscrjluk6PJavaTa92xUFhkaVW8dbUbkAXyMUr3UcLEYxnGEMd36g5/1zB
         8wU57B680n1qr9b6N3anttz8SiEMkVF/EikGlDsRGUBgJGXip8J8ZAanZzO3kqLl2Ic1
         A2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646277; x=1701251077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnktvLfPqF8ubdwz6Rv7MhJE7wv1zfKWDKkb317lazM=;
        b=B3WLD/ojk64QZEIeRZ8lsMgZ0jHQnWktLt1jc9gmI4FDGug9WEa9vsfdk/aw4oVR0m
         1NyaSHi5jOaQfpgKc2UPu7HBi3yxGVjbmWi/ThuW87K4tQet/GI166IBgyYjpuoI/Zlx
         iJ9MzMr/R2ao7b6ExrYrUs2i3KD5A1kvBlhFEdMKe8EDvMJwJjdnYcBBoybENNTT9vIz
         DrOdOjrfStJvl6ESfYpjepMJWWko14tTcor5+gU84iLQoApHkqMKZ0rXlOFVMxt7RHT8
         E9p9zzeADH95keXuZjQJQG/TqXYIZnjhTx4oJZg9rPTsiWU2TpfXnUX4rekEGz0jupJf
         nJNg==
X-Gm-Message-State: AOJu0Yz/hiKBB8Ck8db+8MK1PajGXn9buA76Tuj1ykp+d12OS3QOoM8d
	EORREVX0bkT/owEMMYg5XBaWKrQv9jfWa44vQIiKJw==
X-Google-Smtp-Source: AGHT+IEw7r1n9fqM0DGOnLCSLx8mF0pTFwuuF4zVoLqjVdm1czYpNWLBdySeqm3YRu5jLsQEaBr3qQgctLdDtefNoGc=
X-Received: by 2002:a05:6402:3222:b0:548:b26f:9980 with SMTP id
 g34-20020a056402322200b00548b26f9980mr88089eda.5.1700646277073; Wed, 22 Nov
 2023 01:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-9-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-9-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 10:44:25 +0100
Message-ID: <CANn89iK8ujFgDHc8Y1sc0goBbm4=voYOvty6ND2VhbmjK8AYgg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 08/13] net: page_pool: add netlink
 notifications for state changes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Generate netlink notifications about page pool state changes.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml | 20 ++++++++++++++
>  include/uapi/linux/netdev.h             |  4 +++
>  net/core/netdev-genl-gen.c              |  1 +
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/page_pool_user.c               | 36 +++++++++++++++++++++++++
>  5 files changed, 62 insertions(+)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

