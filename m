Return-Path: <netdev+bounces-55232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C7C809F19
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C8A1F2105B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096C11CA0;
	Fri,  8 Dec 2023 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdhX3oUb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8B1716
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:19:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54f4a933ddcso5853a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702027150; x=1702631950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7AW9hLRSKhPJUrK6Mto3e1MIr7tenkW/+0jbzswQjM=;
        b=VdhX3oUbocUC/T6+3F9xTpFoZsRmz8hmd5CagceTicN/6VY28pRSn3ltRB9TKTHx/I
         MZt2KMEeAzeLpWpfgvJMPNPbQ2JMvTJ8yfSvDeiEzGYsgWz9IDeKMfq7ExtQnRK+JSh5
         Vy1RZSiz/rsJ+BAwyPQBhNpK86bpmQyD5uZfgIpXbaDDM/WjdVG3e3EbTl32s1nW5IJv
         +MLHIEbh111AenEV8D610OU/6cT7FaV5HXWFHQE5IGJlAqxLTYki/3ny38hwPQfK7jxn
         IXadIWAc7gno2njgjC5mTZlYe6tGHsTuR/RsJFzH0S0Vygtu6evI4bB/Prw1L3FKKJTa
         PBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702027150; x=1702631950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7AW9hLRSKhPJUrK6Mto3e1MIr7tenkW/+0jbzswQjM=;
        b=t4v7TK89vEZUKiiJZLVDUU7qb1hLGNsAM7+88zlOBMwMTlsZ3jRNOawQC2m4gQV/XE
         h0Z3VncrIY2yzynENi7o7+0YRrg+YeQxsppmkEv2bVV6t7V3uTnHlxSK+svjQjXFSgUQ
         ZU0n2ljhNVz4zmVJOmSwb9cT8ataHNRXm3oEIpNXu6YC54A4rrZJ7gY8Nprbs6tPQ0Da
         arFKejTYdp+ZCSSnMVhlPk2+4/E3VBKXPphkh9pujSIo2keI4tMv7XBwb/pl2Vixquwv
         n4Rjo1RVp8dubyVVQIhxqt2F0AcjbhTIYVhnI7PeVBL7ZWRG3bjsOnQVWXVAKOe2sebm
         mFUQ==
X-Gm-Message-State: AOJu0YzrZfupKNR7/bS7KqwpAFbINoTwA0NTZKDfxTNgg2IzMZ49NNkQ
	aL37/Hk5edZIwgaKzWegYVMxDqKHdEzx8ZG/2XgjB+yh6qzrjhPV0qo=
X-Google-Smtp-Source: AGHT+IE0qi9KFI2jQFuhm1WFqagxHIK3YqL6b1IhcKKygywdGsrOOwyeWiCYOFjODn9aE2/YCSw5mo0OlxvJ+Ix4jV4=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr46143edj.0.1702027149671; Fri, 08 Dec
 2023 01:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205173250.2982846-1-edumazet@google.com> <2133401f-2ba5-42eb-9158-dcc74db744f5@gmail.com>
In-Reply-To: <2133401f-2ba5-42eb-9158-dcc74db744f5@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Dec 2023 10:18:58 +0100
Message-ID: <CANn89iKTLoBUkOyNnRy486n3HEUKoeFmA90TDc2xiWunK6n_Fg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:02=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
> Hi Eric, could you also open a bug for this incident?

What are you asking for exactly ?

We have thousands of syzbot bugs, it is done by a bot, not a human.

