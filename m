Return-Path: <netdev+bounces-44474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6A7D8288
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4AD281FB5
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C012DF60;
	Thu, 26 Oct 2023 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZTNdywl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE22D782;
	Thu, 26 Oct 2023 12:22:40 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929931AE;
	Thu, 26 Oct 2023 05:22:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2b1af09c5so464025b6e.0;
        Thu, 26 Oct 2023 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698322955; x=1698927755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj9G8F7ts5VApr8eLYiKxxaoSqqOh3fiVYzbTmY/nQ4=;
        b=dZTNdywlRMsMWTp4xYwnH7u//w0HCot6eFphGLcfjq2+i+HdkuodNHWtY17T+K97lk
         IH+WSg8EPAERH2QJNRVNR8g6IeZAKy4wpFfchecxe102cjk0vHXWIuQ9bS/PTjwH7fIR
         nFCXC7htgC7lzzsF2IN8XtksgHDm3cQZ8GEwRN2rCUt9sHrGKreSmpkeE1hHQZHB33oY
         akjWuBEhqP03yiWafHP7dXIO6RBY7Mk4z7Mj4Y7V4cWX1n+9maDN9mzLYDLwKWTIHujD
         XHCMxiO1qrEDfQF9y0E10IyrBiwg5wZTzedzeoT821pKGN5EZl4CAZNWyKFqG8IEPYoc
         h0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322955; x=1698927755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj9G8F7ts5VApr8eLYiKxxaoSqqOh3fiVYzbTmY/nQ4=;
        b=RSS6VrYAV/xlS3Gm9OFITTli1M6fRyEjbFDdYwq5xrp4hkE1rvxdfUgAZrsLiObuS4
         18WJVlukCkfXMcR8EPYx6hsIabEPiUVem3qD6UY9OmUc6SFe8FUz9crKpOTM2+J0++Pm
         ouxUWKb02b9NXB1Xx8evEkzM56Pdf+qotJDWqqzDU6V/r+rOUArIRRc+EIBA1jEZKCFS
         s3Kg30mxIZRRD2Tnt3x20vOd7PQ/VmntIrVlSJ/SJC7YT9QWGKvqCLYhJ7KeXZ1gW1/j
         0o42KqMbcccVZzhxi/4Zw2VahOw3PbLVU0F1QuuatoIBH15jm6qoGvuqYQlGUg1M92ug
         X76Q==
X-Gm-Message-State: AOJu0YzTcy6hswngg5eE3mdAUcoOdIRSQn6WkVzoJ+WRGDfmeGxYEw1L
	2odU1RFxSjK8XdHUNhTGPzfmsftiTnbSpXi+Csjtc0sT6k3xAQ==
X-Google-Smtp-Source: AGHT+IE8pljuqrs+PF23/bNeXZENbNpAGwK9/6GDGs4QWb6U8aA/p+sqpeUuvbmjin9No8afMm11aA6r7JFN8xe2iuY=
X-Received: by 2002:a05:6808:b29:b0:3ab:8956:ada4 with SMTP id
 t9-20020a0568080b2900b003ab8956ada4mr15500877oij.10.1698322954778; Thu, 26
 Oct 2023 05:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-4-fujita.tomonori@gmail.com> <CANiq72n6Cvxydcef03kEo9fy=5Zd7MXYqFUGX1MBaTKF2o63nw@mail.gmail.com>
 <20231026.205434.963307210202715112.fujita.tomonori@gmail.com>
In-Reply-To: <20231026.205434.963307210202715112.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Oct 2023 14:22:23 +0200
Message-ID: <CANiq72=QgT2tG3wy5pioTQ9n416kksZrL1791pehwR=1ZGP52w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/5] rust: add second `bindgen` pass for enum
 exhaustiveness checking
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	tmgross@umich.edu, benno.lossin@proton.me, wedsonaf@gmail.com, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 1:54=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Sorry, I totally misunderstand your intention. I thought that the PHY
> abstractions needs to be merged with your patch together.
>
> I'll drop your patch in the next version and focus on my patches.

No harm done! I understand you were trying to help, and I apologize if
I sounded too harsh.

Your abstractions are not blocked on this patch -- they could go in
without this, that is why I suggested marking this one as RFC and
putting it at the end of the series. The exhaustiveness check here is
an extra feature that prevents a class of bugs, which is great, but it
does not really affect the abstractions, i.e. there is no unsoundness
in your code whether this patch is in or not.

I will send the patch soon, and assuming it lands, then you can start
using the feature if you wish. I would recommend basing your patches
on top of that patch (or `rust-next` when the patch lands), so that
your PHY series contains the addition of `check_phy_state`.

Cheers,
Miguel

