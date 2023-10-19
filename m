Return-Path: <netdev+bounces-42644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132987CFB3C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EF52820C8
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47227462;
	Thu, 19 Oct 2023 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="wo0exy0S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918622745C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:36:56 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF31F7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:36:54 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b6043d0bbeso3047439241.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1697722614; x=1698327414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsFML12RHJnOHfkSBiU6dzKYQ/8Nst4lG6vD/F4MSTM=;
        b=wo0exy0SM8EYgePQK3JXwdPZzU3KoykEq2WD7lrDyZ9cVyjyscQ9JKPyClKRnq+GRk
         HkiW3HSCCX7rqYTpzEq5P8hnZqP2PhxJP+ZnNt7CVdp52qZQpdiDtHzx3pDspQsPgpXC
         D5GdM5fqPZEO68R/Xbt+HMyRFwhB8rAW6s4BPuuEhwKHi+yIZopwFX/4bZcE+7JvVXm8
         w9WQ6+2EkQ0gxDIa/E1qG6YUvZqpdhDuNc2ILFEY/bR/bVk57TGbNaDh2aQTnBD+AZmI
         XVnNTMrgHMDjdOXgs2+D8gFhgd/bsS1vxNkELbUXHm4HQmMl/5vINbnFN/R//v7V6n3k
         AWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697722614; x=1698327414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsFML12RHJnOHfkSBiU6dzKYQ/8Nst4lG6vD/F4MSTM=;
        b=HfBuN/0oxpi7tZc4X0r1EQ3evS101O6cavDmPyfgpf3ZDFIaxxDXKBbXsTQJzs1erX
         JVsRR8dTlXPZP5yKZrKOI9OEFrlv5EhoMCDRVaPSUqhw89RqG82gaknJfvhZrbf6TjTK
         KZZLY7C3MAM2tFUPR3rwi90v+gRlrNqEe0nc+S9IY/cTPfq+sPiTI63BZn5/VZTeP+ql
         qIvbT++30FaH0qoFNt7OVp6QfOCMAtk86U+pcppYfg0+LM2+xCTU0e1AnZX03CTpVhM5
         /WaWI9Af3l9xo12/pwDHkZagvQi0QrjDwl7JMlwX7DE/4iSV2dEpere4ddXxtLw/+h3P
         ruVQ==
X-Gm-Message-State: AOJu0YwC2jK8Vf2PXTwRUR52/d3gae7/b6Lquz8zEdptQdwI6Nr49S1i
	q5spQU1u5b97Q5/7lBUdWbM8vZ4ILLyaWtymlvL8bH6pcqzYTNg+gJUunA==
X-Google-Smtp-Source: AGHT+IF9qEMTK3Cq0qn/2zsXc0jRLIf65Pa8o2bb6aXKmDlqkmaMThCy3c4XXGmo1fYPHHdp3TyySxIbp9Dctp6RrpM=
X-Received: by 2002:a67:b242:0:b0:452:6ac0:ed19 with SMTP id
 s2-20020a67b242000000b004526ac0ed19mr2125923vsh.31.1697722613710; Thu, 19 Oct
 2023 06:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com> <15f85fca-54bc-46c6-b016-0d1761052fe4@suse.de>
In-Reply-To: <15f85fca-54bc-46c6-b016-0d1761052fe4@suse.de>
From: =?UTF-8?Q?Moritz_Wanzenb=C3=B6ck?= <moritz.wanzenboeck@linbit.com>
Date: Thu, 19 Oct 2023 15:36:41 +0200
Message-ID: <CAKnz9xJzjpLgZLVZR+LVhrHFQn=utFoZRUrUyowZzKZ=YXhWbQ@mail.gmail.com>
Subject: Re: [PATCH] net/handshake: fix file ref count in handshake_nl_accept_doit()
To: Hannes Reinecke <hare@suse.de>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 3:06=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> ??
> You sure this works?
> With this patch 'fd' won't be available during the 'hp_accept' call,
> but I thought that we might want to read from the socket here.
> Hmm?

Yes, this works. 'hp_accept' only constructs the netlink message for
user space, so it only needs 'fd' for its integer value.

Regards,
Moritz

