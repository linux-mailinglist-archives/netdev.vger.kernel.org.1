Return-Path: <netdev+bounces-62821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037C8297C2
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF971F2521A
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B60405CC;
	Wed, 10 Jan 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsABLVz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C93FE3A
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so6140a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704883287; x=1705488087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmzfzN0zzJnyx9WB1y8fn4jQVFu6Vh2c1qnlObNp4q0=;
        b=bsABLVz5ihEahS6N7sIobE6Kqigl4JFKoWapOfjWGLkw4OFo+ChMfE7CQmh2Jo/Tc9
         U3ziIqUoEbMkdDYw7vrlwhsPj5QVeBg8v9AUROYkBk3QMYrKiYZGkmUOJKLfrua80H/u
         uWP60eERtGrVHNMnDgQbJlqycsYozLAERj3jNwHhYBh3S27FWQJyKG5dx/jkfgNbdi8V
         6DsZO2ucyhCi7VqA4rF1QscAz46um5vqitIFn59N6kc0U7kMnUgCnCZs8JxYFLGpJfM8
         OB8x1rzP5KYacQ/Ri3vwK58Jq5GdEQrqkKquFQ40JqhwJ9Dw6UrqqehLd661T2yPWjbX
         z8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883287; x=1705488087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmzfzN0zzJnyx9WB1y8fn4jQVFu6Vh2c1qnlObNp4q0=;
        b=vGSpLoOkrwDBGX18DtczdQ5bK+xmhkjxr0nwbGWMcrOY8nY+LF9VQ8VwS+jxWM/dpX
         0NfHW6OEogJ8e1JF2GjQEwzykPWAIxG6jmhtULIekHysBjfIiq4jA2KiOvapeKBhC9b/
         PACMRqcGTpO8DJgYREEO5j2IW9MvJlyjO7ff6ImVH8DJ/XcFegfwvq0Wz+sxbjnvbzwQ
         q9YLMkwc/89SHVWrpQOeWprQ8dcYGDFeR/IH/Oa7/9ogaKzHzTm+kgy8cSqx/b70Fqg8
         Ve5u6Ts4oW2mYgA9JA0JUIxAzocTC8XTr7pEKMKZlFiva7zlU4yTSYs2nFJhRVt4soXs
         lnHQ==
X-Gm-Message-State: AOJu0Yw00IXvH5zXCjsebucdggzXqlCIIkZ6HtlP9GSp6GzT0iFkOeqs
	223GejHZDmVnxvxORt8knNehRDhjSRNcD++QTsMNlXrJjqVJ
X-Google-Smtp-Source: AGHT+IFIR8eam6MV5NA4qhZdxcgZvP0O579ROvq/Wp+r2y+trDB4Xh8CAip7+nefjj4l4P0g9imxaI7Le8LpzwRTtGU=
X-Received: by 2002:a50:d711:0:b0:555:6529:3bfe with SMTP id
 t17-20020a50d711000000b0055565293bfemr135444edi.1.1704883286597; Wed, 10 Jan
 2024 02:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
 <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com> <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
In-Reply-To: <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jan 2024 11:41:13 +0100
Message-ID: <CANn89iLe9q3EyouoiSfodGBuQd1bHo5BhQifk47L9gG7x29Gbg@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Jan 10, 2024 at 4:08=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
>
> >
> > Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
> > Sorry that I shouldn't be too confident to compile it.
> >
>
> net-next is closed, come back in ~two weeks, thanks.

Also look at commit d0e1a1b5a833b625c ("tcp: better validation of
received ack sequences"), for some context.

