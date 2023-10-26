Return-Path: <netdev+bounces-44612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C67D8C58
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 01:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33AE2821B8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 23:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86663FE5E;
	Thu, 26 Oct 2023 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YazgZT7D"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C418050
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:52:50 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F290
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:52:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso639e87.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698364366; x=1698969166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR3QzRP1pe5qwiInquyulK4CecHvK7FxLOO4TAyv7dA=;
        b=YazgZT7Dg8kqWANoGNyoVeg4cciDmYxFixtYqTzi/S4tzZhbtQGW0L3149jd4OeYPT
         tpiflrXkmlCYV4CTqKUCvAQgt47CFS9LeeEpACCkMMhKQ0Yl3S+E2zDcG5MbuCzyWszb
         1Bibb8szhcIZ0Z+z8gzl2PRd9y1d3l3IOaQ6MuREvR5hoEgEjaAIRV6jOhVHexWYpzrv
         5h55v97fX+1GWnb7rDdoDs0ui9Rp47uvnK4QJcnHnaEN6rh3F1EnJ4PXjE7rx7Fh0/h/
         4TvyaqQoIKUcE3LC5mbNmG8heM1AORbyz81n9IOjmHEwIpLTJvjndcosTxdbnN33UW75
         I1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698364366; x=1698969166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR3QzRP1pe5qwiInquyulK4CecHvK7FxLOO4TAyv7dA=;
        b=tn7iEM3qWjKxKWjUZ3xTRqSyten6j2zyDLjNrhllA8b82OCxjAjg3AfaucDiQd3SDB
         M2KsOUFsm/eyqGeK+y3YyarXM45B4Md7BgKSmaYbndrpn2heKAvamXLg00RM8bLg20C6
         anOd4tCO+OgtbuHLgBdJWgs/hvjP0/VKDUjqsRwYY898mXP1DKGrVoZLnHcRvJObWALh
         ZXm6Es56nMexgESjtQSGA27g17RMEm4FAlFtugHh1ckzbAuju2JQFX/+GRd7Fr9tDa4l
         ow13k1Za9nOo/PhRI7yKgfmX4tGQzaJqkxW7l1zHwmKbbKFe+HyVmZo4QFVFCJHGrf7w
         8myA==
X-Gm-Message-State: AOJu0YyB1HYeJ2InwJwpl6xrhx4hw15bv8a9mL1FT00lmP/Xasc6aEHg
	UJ2vzlA0dPMibddR6ucGLriXaxgTx0eVdZedDIpltQ==
X-Google-Smtp-Source: AGHT+IFUt2iTTaXjRPjbJ1RfDqHMsdX/qkFs7NotCUrUJX1fMqWB5PNk8VQ6C39hakkGO2S2MN6vkQyfkgBjn0sCm0U=
X-Received: by 2002:a05:6512:78f:b0:501:a2b9:6046 with SMTP id
 x15-20020a056512078f00b00501a2b96046mr12723lfr.7.1698364366357; Thu, 26 Oct
 2023 16:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com>
 <20231026081959.3477034-4-lixiaoyan@google.com> <20231026072003.65dc5774@kernel.org>
In-Reply-To: <20231026072003.65dc5774@kernel.org>
From: Coco Li <lixiaoyan@google.com>
Date: Thu, 26 Oct 2023 16:52:35 -0700
Message-ID: <CADjXwjjSjw-GxtiBFT_o+mdQT5hSOTH9nDNvEQHV1z4cdqX07A@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path variables
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 7:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Oct 2023 08:19:56 +0000 Coco Li wrote:
> > Subject: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path va=
riables
>
> s/smnp/snmp/
>
> > names of the metrics. User space binaries not ignoreing the
>
> ignoring
>
> > +/* Enums in this file are exported by their name and by
> > + * their values. User space binaries should ingest both
> > + * of the above, and therefore ordering changes in this
> > + * file does not break user space. For an example, please
> > + * see the output of /proc/net/netstat.
>
> I don't understand, what does it mean to be exposed by value?
> User space uses the enum to offset into something or not?
> If not why don't we move the enum out of uAPI entirely?
>
I mostly meant that i.e. cat /proc/net/netstat will export enum names
first, and that userspace binary should consume both the name and the
value.

I have no objections to moving the enums outside, but that seems a bit
tangential to the purpose of this patch series.

> > +     /* Caacheline organization can be found documented in
>
> Cacheline
>
> Please invest (your time) a spell check :S

Much apologies, will run through spell checkers in the future.

