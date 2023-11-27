Return-Path: <netdev+bounces-51302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060A7FA062
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB741C20B70
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF93288A7;
	Mon, 27 Nov 2023 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6HTrOqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C96D5A
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:11:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so17811a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701090681; x=1701695481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXQCTqnSRhLV4Sf7W+kGf5Qzm7pjsYDnMblRf36t77E=;
        b=k6HTrOqc+WzpAD8nABb/85Sw8puAIJ6tbpuwym0c9It4ib8DdMD2f3a/5J1Z/xtqxr
         xPPXU0j43VPh4FR/GNMCUvA8PA2ecn7jgz0XRnEkpnB+gzIymWukCKhncjVsQqfk9mVi
         bofVcUKUGBPVVTlSktqA4mOGd6pOnxp+oZ/9XnK1sRitppObdSG5IpI2n91mv8lmF2c8
         RMNwX8TnlQYx+QZa+ZYBhxi2+jgFT/hCvpTBDaJdDyevFeSDiAGM3H+kFaJPq5Ayc09r
         3bHsp1CyOkR+pB8wDxEbP7yUWDinpa2aYGzWdfRmMjwAiQsvOM5M9AhgtMYR+Q8OrsPL
         M54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701090681; x=1701695481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXQCTqnSRhLV4Sf7W+kGf5Qzm7pjsYDnMblRf36t77E=;
        b=S1ReU7XjMV6LzHdSa87DctfdJ5CATradyjP8lpEJHyu37kWtbkmJ7OPkOQECwvvr9u
         c/2Mipel/ORhGPd/R/gE3iAKrqJrk8SLcZQ5KIIS95iaex7FSUgcLabAv2fduQcBLk/b
         yREP+HQkd7IHFL5QDIn+snVxXilhDHDpJa+4ELyeBNP+EBlQzfzMCyDSx4LuZyEqIuK+
         5dh6G88ro0SSTKzjlOT54MnnkjJ6xVYIunxmkoPgQFnpy5WQhMzH5tx196fWPUVGeckx
         JtopyHQwr5BrjptSPlSIDqo9nlq2euhrqzIYCX2lN6afnODCjC+hZFEnsy8OuQ0BxKhk
         tnTQ==
X-Gm-Message-State: AOJu0Yz1clQ882jmeynYA77exhO8O+hfSUWrOkQndf0wCpXUaE0pS2FO
	HW+bQgvSoXQ9iF32FDxvpiwCw/m3x1FC/a7jgOu46Q==
X-Google-Smtp-Source: AGHT+IHaHdoxNNJO97Rlc/s9fLfiRimoWf1RBvhtGks3S54kEDX6jrYUxw9CfaJeaLB7r37y7ymoRJs4z69BB5g3pIE=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr586395edb.1.1701090680910; Mon, 27 Nov
 2023 05:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122214447.675768-1-jannh@google.com> <1508421.1701075853@warthog.procyon.org.uk>
In-Reply-To: <1508421.1701075853@warthog.procyon.org.uk>
From: Jann Horn <jannh@google.com>
Date: Mon, 27 Nov 2023 14:10:45 +0100
Message-ID: <CAG48ez11LLG5nccyfY0DpFoFFXbXkxbB9pZPL81EVkbkWW7EKA@mail.gmail.com>
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
To: David Howells <dhowells@redhat.com>
Cc: Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 10:04=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > +     /* same checks as in tls_sw_push_pending_record() */
>
> Wouldn't it be better to say what you're checking rather than referring o=
ff to
> another function that might one day disappear or be renamed?

Hm, maybe? My thought was that since this is kind of a special version
of what tls_sw_push_pending_record() does, it's clearer to refer to
sort of the canonical version of these checks. And if that ever
disappears or gets renamed or whatever, and someone misses the
comment, you'll still have git history to look at.

And if, in the future, someone decides to add more checks to
tls_sw_push_pending_record() for whatever reason, commenting it this
way will make it clearer that tls_sw_splice_eof() could potentially
require the same checks.

