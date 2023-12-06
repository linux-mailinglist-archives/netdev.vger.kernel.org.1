Return-Path: <netdev+bounces-54442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE48580714F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A88E1C20C76
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BC3BB3C;
	Wed,  6 Dec 2023 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLeJA4CA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891CBD50
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:53:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso8952a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701870803; x=1702475603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+gLZKiKj1GCcMobmu/DUk62mvWsOs0b7/e7NkIe1CE=;
        b=oLeJA4CAU5VKPmxqltgKScm2YYivPL2s7kokDZ11L4rwADBz0BTI6T6RjfrCPrBOxU
         3T7KrycVZcetpLk4KU4vDCD3y0zSKBcFU3RLO/9zY93RzkgTmCiAjKyllP33qbfWBeln
         gFTIdG5jJZwpGaPVoem+qQvS9UEbtrlFpfNWNCOdpEFRb5M1oD52LpIkygSrwzQsuxUp
         envLdZ+6+j0JcZ3XXZ9QE5Ll5v4vtFll8ic1475orAY+hydx6L81lbYoPWrT7F//fy6c
         CPB805xkDfKFQ1lqaRvi++kBYWeZZ/Fly0fiuhkUp8XE3/nuKlS7E8Wtsexfz0xOBZAp
         r5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870803; x=1702475603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+gLZKiKj1GCcMobmu/DUk62mvWsOs0b7/e7NkIe1CE=;
        b=cWCl0oDLR2gRN+++ZIBIpzNmPsNP+5HaknNLyNiboBXl/rF2XkWJzz9e8AMiTSmOdZ
         XfA0L780+wIcNH6SeGGfOdFYJaKyD7xDUJHGkVO3hPZ+bOWqUp95yj6yqqWVST4zW7hW
         66CBu5OlJAMHi3j3I0cOskN/ym6YSg4MHgZzFaBtLC5Aj11wbn+hh2fz672fZw/3Eipu
         YlVbDpbJttx5tvnHTsse5sf/VDikRlZCLriv0ALsbYJ6dWyMFzX0T2cpUMOFKnO0R3dG
         JLQE7G7AUz+MXLmcn68YFR3E4yBUN9iDkjlIRrPtNjXPYLcnA7lil8Bp6H43ilpQVYGI
         WXAA==
X-Gm-Message-State: AOJu0Yz1wcFJ7tAtvpve4JBkUTFYXSLSQNg42Kg7wBNyFYMJL2Dp/dD7
	veFREv0O0vwFhUt905KkmJkhkvFrBXc3CA46IhpmCA==
X-Google-Smtp-Source: AGHT+IFIDix0CAvjRl+6bl9SxYnnl9tQeRl3UbNWwZSdM4WPZ5ygMYG41gGwLszA67qDUP7Og9mVV4CMH271YQ4Bgrs=
X-Received: by 2002:a50:d0cc:0:b0:54c:9996:7833 with SMTP id
 g12-20020a50d0cc000000b0054c99967833mr67928edf.7.1701870802633; Wed, 06 Dec
 2023 05:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
In-Reply-To: <4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 14:53:08 +0100
Message-ID: <CANn89iKCECyTvRnedsS-0BGBXi00L3Kj+HrmpNQnejm0vMD5Hg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] Use READ/WRITE_ONCE() for IP local_port_range.
To: David Laight <David.Laight@aculab.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>, 
	"jakub@cloudflare.com" <jakub@cloudflare.com>, Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 2:44=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
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

SGTM thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

