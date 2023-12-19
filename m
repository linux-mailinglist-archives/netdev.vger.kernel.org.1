Return-Path: <netdev+bounces-58963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD6818B3A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D112EB22A39
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D21C6B2;
	Tue, 19 Dec 2023 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Z0TYVgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA91CF8A
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so16249a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999687; x=1703604487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jmLJhG28LZj9gVMRRMmFWlExW7xYXSz3l14apqkR3Y=;
        b=2Z0TYVgMLQN88vGPuLrE+lFzhoI/L+aiBv6ESm4hkwGap4sMa9SkwJGvDqQlbZ062/
         KhEKCjECb9i1moYcHAZrZxCDvkKsSzHb1SuzInYCX9EL6Z5nxlx0rJY1ntN+3Quexgjf
         Z8oUTq5zZbL5Ls/cILXm5kdDgHfky+EoCj7rSbwJ7QJxTXOoiJC11HxuV8BpjcVIWJD4
         +YbStBr/X1sxGcyvyQs1fY57yaozQXky72Do4VWVQBzHQr5WeGK5heDz5Df7LrnzEQp+
         O+y++GhZ/WUwsj4IPmn+qvkS1VwTDZxxIp4PkSPbNiuv/HvWUx01QibQ9cydZLDOhG6S
         cUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999687; x=1703604487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jmLJhG28LZj9gVMRRMmFWlExW7xYXSz3l14apqkR3Y=;
        b=PhvU1h47zS3Obvp/jxPezRtlI+0h0dvzhnQ2DSB9aj8M6RbBtYKsLG/1W6KZZRi7hK
         mq6HO76KhzdY0sVqMXPktw9NCN+NGwzizBqzff65dzur+Ku6YmNWdIo0irBkTZJJVZQu
         x3xg581pYc8pc6osZd/ZpLQh6Ai+fYYoWsdZPvVrMdAZT2eb5TRRisBul7wkKq0Pk7JY
         uZn0nc3qouWOOAQUgO6xmrSIeT0pAdA9OxRU48fhUvlUSjn3sv5auWaNOp0ty5vvn2OF
         bfzv/L0jsV3wSEOYUp6nKKFK2djnqXsiNnmM0yrdqHmtkrKNFKSEOINddGpSW1MtW0kj
         4WGQ==
X-Gm-Message-State: AOJu0YxHwPOtur0jLFhoQWHhDhcv0oi1wObecKDp57DWc61f5mg7zV0g
	EdLPRxRwlp6mYMNO82yb0CIPKqVovsXsDGMkvUTsciJ1qpkt
X-Google-Smtp-Source: AGHT+IHGvYceQC8Zg6DYirwFMcBG6Z/KngG1jPJSnwaFoen1xVKA0+mdPqDPKpQorKJRy5P+CD9OrlljaWBfQCCQ97g=
X-Received: by 2002:a50:8d4f:0:b0:553:773b:b7b2 with SMTP id
 t15-20020a508d4f000000b00553773bb7b2mr187029edt.6.1702999686831; Tue, 19 Dec
 2023 07:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-9-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:27:55 +0100
Message-ID: <CANn89iJTeq9DvFH49WNksy6KLxYV54yeBX+BhL9-qbxreKVCgw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 08/12] tcp: Iterate tb->bhash2 in inet_csk_bind_conflict().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Sockets in bhash are also linked to bhash2, but TIME_WAIT sockets
> are linked separately in tb2->deathrow.
>
> Let's replace tb->owners iteration in inet_csk_bind_conflict() with
> two iterations over tb2->owners and tb2->deathrow.
>
> This can be done safely under bhash's lock because socket insertion/
> deletion in bhash2 happens with bhash's lock held.
>
> Note that twsk_for_each_bound_bhash() will be removed later.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

