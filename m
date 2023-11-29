Return-Path: <netdev+bounces-52233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089FB7FDF1A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A29C1C20A6E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD0B5C3D6;
	Wed, 29 Nov 2023 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGYotj5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C490
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:10:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so481a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701281457; x=1701886257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnncOB2h9jk2qjqG+JIa0//zO7OvYoVVbykcUe7Jp/c=;
        b=bGYotj5rsTyGBNiNZ1wGEy8Ux4gKjH0aU0z6sHYy9wHZPJW7c0sIvJCW1orhTEefEP
         bJEdO4EAkiQzI+dyJcmGBQ1X799cyOYm0/Qk8H9jpA/TZiipH9BAgV0hIHHamuaEbEqm
         /mduHdNv8iq7ECdB1egzeGux3mugY2h/AXdBB7HwsdREAE23u74lSlsH3+8cLQf9VpZM
         hi2xMyFSsf3y3NYwU+0qe+UI1xGdS6t+VaZStIGKQwksVdZvjzAm2VEUtNFQSQKPGbe+
         mJM1EkYqV5buzAKNJ1QQkatvn00pTwEwV3Bpc8sUH7wNkGnmsTFcwM+SWVhUCuzPO0A2
         Q30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281457; x=1701886257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnncOB2h9jk2qjqG+JIa0//zO7OvYoVVbykcUe7Jp/c=;
        b=wesAz1yKSG84heZydsrLT4oh60l8Dbn81jL7nx8gI8QauYlJgh7VV3LWnOwKQ4GDII
         moDs5Ep4AipijGMewKoQcsRXz7Z4Psr4XQ5p872Isqpgowho51BBRuU/Y2FTU5It892y
         1LIs9kR2aQ3IQ5sS6OELob1WIkcbnYMm6hyseBo42Ird9BjVMBihCYUvpfa0ZEavbiIn
         fp/cEj++3hkC6zfOn45dG6aL1r7gQBFrfwkcmaU3a19mVLE/ElvorUd9dX43eApPjwHn
         G+KbQUPZgKknNSGfAR4QM9zvtXO/u8YmddtHKW+isTWnLMm3KQvJHofpI8HqtY+Y0zx+
         p8QA==
X-Gm-Message-State: AOJu0YzgGMEwg4pbGZ2D4YTXg3nlC5+gHW/rRlwhFqOsF16o+01lqbSc
	AforMiJVxjMptjhCmSLHNHeW2a4bboJFp8dzG9fkPg==
X-Google-Smtp-Source: AGHT+IHLXlzTI+N/IYiqmHn8zamPjw1heaZyyJEhUCCIo5P8wqmxHtc3KxwNqm6ZvQxeKqJ3Qxrr5q0UW3DEEznGUyU=
X-Received: by 2002:a05:6402:11c6:b0:54a:ee8b:7a99 with SMTP id
 j6-20020a05640211c600b0054aee8b7a99mr853479edw.0.1701281456539; Wed, 29 Nov
 2023 10:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-8-dima@arista.com>
In-Reply-To: <20231129165721.337302-8-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 19:10:45 +0100
Message-ID: <CANn89iKHXv_eNgc0525r=RAREqNXenf+StMHzK2=K_uKj-N4rQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> This extra check doesn't work for a handshake when SYN segment has
> (current_key.maclen !=3D rnext_key.maclen). It could be amended to
> preserve rnext_key.maclen instead of current_key.maclen, but that
> requires a lookup on listen socket.
>
> Originally, this extra maclen check was introduced just because it was
> cheap. Drop it and convert tcp_request_sock::maclen into boolean
> tcp_request_sock::used_tcp_ao.
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

