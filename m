Return-Path: <netdev+bounces-52270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF27FE182
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9021C2091B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC861668;
	Wed, 29 Nov 2023 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tR2TCM0K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E8E6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:06:34 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so3846a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701291993; x=1701896793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1063OHT6kjBDG51LEBUaBow49RhgIY33vuDcgT5PKo=;
        b=tR2TCM0KzOEMWsXLSiQByR1SdarpDo7wyIFabAjmEpgDrnzrMeTnxyR17ABTAO8qDn
         +fCHJitIw0ewl2ZL7a/kKC3B/fGocP8hy7on216S6nEgcePlIRNHzrKmwYYvwE/7S+Ue
         23gXb9r6GVNmFjQAqzpJ3NMJ40DPo1MgK1K6aqnsekpQvnmVwTwnVO/BKrTMLWkhmrlg
         k4DLUJQelWwmscyeLX77C3f4kZGsC8aGCJcmTDLDiUZ1RH4x5YI/+Ix/9QgkB+BRIKYu
         EqE+ssazkj6kBOpDq9tZlIVrjYaWCpg8Q21pVIBqyUggpaMU8E5JXMorOlJrRCEuOLXd
         1dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291993; x=1701896793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1063OHT6kjBDG51LEBUaBow49RhgIY33vuDcgT5PKo=;
        b=nAOoZxhmGtgWq8mHG38r5XfDGRE0JbP/4oqUXZIosBTl1SjQmTBnQ/F3u1i6vXpbvW
         UM9O4OGLcxkZvUOMNKc1jLGZ45/rMibORgbbeHTzEkx8CzDJ/3qpisLUqnTTq+JTSGsY
         TkAjD8S0IJ5SMl9lsZ+gJg/Vt1CCO282iV9xPgGYcJrg48WxsUQz8sPkZETCyV441Vv9
         A7CVWmELNdtwR66gj8/pyagFLBXji+SVQS8i1E69uuz0pwl4rMnWjmyfvC7krwJphe1Q
         SONt7AHUTehPEnkF0u6mHD5F0Jyya3K1Bzo/joOmyptaJC0sV9lBZRsoQm4yFGgOZ6D3
         pomA==
X-Gm-Message-State: AOJu0Yx7AJlqu/c2vJL0LOwhHtjxjqqtkyzS8cfVEEQiadgDVsuOBI+W
	DSM/PpKA3ZL7wTeysHUNgAfCHsFcyiCLwe4un9CwsKtD3pW0+nRSwD8=
X-Google-Smtp-Source: AGHT+IFh6mZsYFt9ulLX8SzGUlesTKcg3LyO/gnb00rNh8SgaPXVetsnZJac1nDdhBONg58NtQR9y2JrJInel7wqhhg=
X-Received: by 2002:a50:8a8e:0:b0:54b:bf08:a95f with SMTP id
 j14-20020a508a8e000000b0054bbf08a95fmr28640edj.6.1701291992539; Wed, 29 Nov
 2023 13:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
In-Reply-To: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 22:06:21 +0100
Message-ID: <CANn89iJxdOGcjbrLwP4ryEB=c74=0A8vdOFowv98f6n6tuuztg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP local_port_range
To: David Laight <David.Laight@aculab.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"jakub@cloudflare.com" <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:26=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> Commit 227b60f5102cd added a seqlock to ensure that the low and high
> port numbers were always updated together.
> This is overkill because the two 16bit port numbers can be held in
> a u32 and read/written in a single instruction.
>
> More recently 91d0b78c5177f added support for finer per-socket limits.
> The user-supplied value is 'high << 16 | low' but they are held
> separately and the socket options protected by the socket lock.
>
> Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> always updated together.
>
> Change (the now trival) inet_get_local_port_range() to a static inline
> to optimise the calling code.
> (In particular avoiding returning integers by reference.)
>
> Signed-off-by: David Laight <david.laight@aculab.com>

Nice, I had this patch on my TODO list :)

