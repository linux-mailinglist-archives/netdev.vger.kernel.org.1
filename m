Return-Path: <netdev+bounces-42014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C57CCA62
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 20:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D625B210E3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE22D7A8;
	Tue, 17 Oct 2023 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTv/+qhB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662402D785
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 18:10:37 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811793
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:10:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so9385e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697566234; x=1698171034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5CLGezqUU5J9Ow0ItaPezsuh/PY9FbgkNlSLvJbEg0=;
        b=mTv/+qhBOl2JflUQ00x6Ny+9BV2WS/RntIzwhARCwdv1WRwIXXrj5apK5qnZzG2dhi
         OlHTbo165S0awQ5WuzAEbUv5dp9DTcDlzF3+rL1STv7cfIjVbLRAC6LPsExMCwVyWpfu
         aQribNuwtpar/a2zlXxVWad2flIHD1PJIZphuvF2GTB7tOvTUoxR92BARCvlGxNpPfsP
         S2YO4xKit+WG1qGV+b0of5cIX9BsTzHqLU9HfHFr9tVqSf55qioo1uw06crqmGwRHX4d
         8nJ2pwM2CdVJ/ief8BRAVFZd2TkAaJlvs55pecVaPMwaJZIQA9kYVxrQlJOZNt3mjEh5
         DOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697566234; x=1698171034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5CLGezqUU5J9Ow0ItaPezsuh/PY9FbgkNlSLvJbEg0=;
        b=qr4dKoUDiEeV4Y0Be4Kc/cGhE41raS7UoVAkzGyOCG1zNfQbUVYviTRLYs0o7OqCXx
         OmjO+puVrou7o0nfuU2YcYRrrTRS2EqzH4HNnncPELES2svYr1Fv9nfxiqhT9EQIIBb3
         qZpkZO9MF/mAgNEnigll/rwpEOLdLdh8QYJG46Ow9jg3xpf/dbncbc1Fe08URd+ZwVET
         PZt7MfHKA2QMbrsUUeLzgVpoWn55ZdoCHLZTAasJmmfJwJJQu3DXYYOsUduBIPAvxjKw
         /dJH4LcGmKLGKw4/9AgGncgJjxcZAoFWQgBXuDZYUnsOHxoa0lDULOSoNhDP6z65xHU6
         Dq7Q==
X-Gm-Message-State: AOJu0YwBjR/DxROYg9zI9TXVvcgZWIszQyr4ykcppTxxPfq7ThjHgZJ5
	Iihi4QS8cBzNbDKHt2C7NBt+JdHWkF84FLNO4HmxsQ==
X-Google-Smtp-Source: AGHT+IF5K5jC8YY681Mbj/NLRNNbjZUkUMLUmhprlITPO3030qAXux1X5TXdlEd+hqNo8nOk0n5Y3Lzo6y8uK1eW3jY=
X-Received: by 2002:a05:600c:1d91:b0:408:3725:b96a with SMTP id
 p17-20020a05600c1d9100b004083725b96amr19608wms.0.1697566233980; Tue, 17 Oct
 2023 11:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-3-lixiaoyan@google.com> <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
In-Reply-To: <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Oct 2023 20:10:21 +0200
Message-ID: <CANn89iJVGQ0hpX8aSXjyfubntfy_a9xrZ5gGrx+ekY0THZ4p+Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path variables
To: Andrew Lunn <andrew@lunn.ch>
Cc: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 3:57=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 17, 2023 at 01:47:13AM +0000, Coco Li wrote:
> > From: Chao Wu <wwchao@google.com>
> >
> > Reorganize fast path variables on tx-txrx-rx order.
> > Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
> > There are only read-write variables here.
> >
> > Below data generated with pahole on x86 architecture.
> >
> > Fast path variables span cache lines before change: 12
> > Fast path variables span cache lines after change: 2
>
> As i pointed out for the first version, this is a UAPI file.
>
> Please could you add some justification that this does not cause any
> UAPI changes. Will old user space binaries still work after this?
>
> Thanks
>         Andrew

I do not think the particular order is really UAPI. Not sure why they
were pushed in uapi in the first place.

Kernel exports these counters with a leading line with the names of the met=
rics.

We already in the past added fields and nothing broke.

So the answer is : user space binaries not ignoring the names of the
metrics will work as before.

nstat is one of the standard binary.

