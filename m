Return-Path: <netdev+bounces-42913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4F7D09AB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83062B20D2B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CADD2E3;
	Fri, 20 Oct 2023 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvAcrGW5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0291DDA6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:41:52 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E311B6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:41:51 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788fb06997so34715385a.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697787710; x=1698392510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBa0xa/eHNcCLSN4jU5w9L+UgbLX0/qpCkz9jorDITs=;
        b=AvAcrGW5aY1lChxIAg/NbMHQ3hA8v4cgab7mfBDL4APx+gjN6uvUBsgeNoU/Bvh2Y6
         nf0fIgpZF0y6jfzKhI1uhyGuzmG148xrvklISNAYk6zwEWveZqKz4oFvDMPRidT7IZdw
         nhckKrrAWYxW9G+zgFFX6JCI3/Hvrf6YK8n710rdNHmDYh4APf7KOUOEi6GSGam+RInA
         yocUWPBUf7p+M7kzj/BP07qylEu60z2U9vlSgW1AxkANHQM3AuOZOcLnhQCyC7Q+WGUn
         eHVdE0zPK51YZvVVHJPZxeQV+SXVORm4TLLXBZbtJPCKevpfdt/6wRpjmVHVzzDTndlm
         +QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787710; x=1698392510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBa0xa/eHNcCLSN4jU5w9L+UgbLX0/qpCkz9jorDITs=;
        b=jzWwg2p5i7tiqGLfFKouDs71QNxuazCA7YkPXlnxYizDzK+51JJlKn5nYwmnIUWP8R
         Gn+MQtLxodBLSZ+13hUdTQQ7eEcl8blGMWNF+g4I6mxI9KORlVIRyJLXC8G618MUjCBn
         IrB19ccGl877hPF1v3lvXAe/6VhGlZ0MrhRCRhWnu0gWRNiyERuk++K8qGaYxXvNQlEV
         cpCozZKfLkMW2cbYRzNbRA7A591G/KmnftlWW0zsG7jVKb55bdmuwQvHiKA8QVN1eEaE
         wju5oZ8czt7p/kcoXI7po9vVwgqzzivG445rUHpGJ50zkJeQiA2a8HTLS2smSKiKVfxM
         6Mjw==
X-Gm-Message-State: AOJu0YwgWj/IT7PHRlLwsz/ke5oN86PeFumsIAfYpWZOiDZy4H7rZLPX
	kGKHH8mmxZGR4U65rw1g2cH/AEq2Xot/OFnXs6PRlw==
X-Google-Smtp-Source: AGHT+IF4DP8EnmUuEgxb0AWEosQEB3fTMTya1XnxFLtaGR6STLfbHmgJkB9SCGKsieIg9mX9CbrMN19r3UImMJv5EAs=
X-Received: by 2002:ad4:596a:0:b0:66d:1230:9682 with SMTP id
 eq10-20020ad4596a000000b0066d12309682mr1436777qvb.62.1697787710110; Fri, 20
 Oct 2023 00:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <20231016165247.14212-12-aleksander.lobakin@intel.com> <20231018172747.305c65bd@kernel.org>
In-Reply-To: <20231018172747.305c65bd@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 20 Oct 2023 09:41:10 +0200
Message-ID: <CAG_fn=XP819PnkoR0G6_anRNq0t_r=drCFx4PT2VgRnrBaUjdA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to bitmaps
To: Jakub Kicinski <kuba@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, dm-devel@redhat.com, ntfs3@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 2:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
> >  40 files changed, 715 insertions(+), 415 deletions(-)
>
> This already has at least two conflicts with networking if I'm looking
> right. Please let the pre-req's go in via Yury's tree and then send
> this for net-next in the next release cycle.

Yury, Andy,

The MTE part of my series will need to be reworked, so it might take a whil=
e.
Shall I maybe send v8 of
https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com/
(plus the test) separately to unblock Alexander?

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

