Return-Path: <netdev+bounces-46222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFD7E2978
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C79B281179
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF129405;
	Mon,  6 Nov 2023 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lrW6szNY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F328E1C
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:13:01 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5A191
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 08:13:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so4847506276.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 08:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699287179; x=1699891979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/7b/bMKFrKXhUKdv44Wdfghedf9BfYUOWeiJtb0PfY=;
        b=lrW6szNYJZclZpIlI5suJgL8SyciFOd+qNJpU+FNEaDRqdjF2/nRj9N02IMz07rGys
         QCKVvO9VXUOS/c1B/R5SwFTCTrO3ZM7iCLD/Pwg7FAXIR74Q9N+mmfzSvEuzbz+kZ4Pa
         U0J+xF/G61bSx8wEz7DlxIEZHwlRfMWKsTdM/HurUfsdlOigPHgNRLV2YFKJp5oVN+R1
         YBVf7RqG4qx2ZjoYeK8+QVNtsT8/nLUBpDIcs2NVRkRY0HcB+2l6V16nrUb2IqU7U1Xq
         dHD7ErOGh7CarRHo9bK52uzBW1O025X89gtNv/58TSxtAnDhKxS9Pqj0LERPgogq8h/d
         Bh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699287179; x=1699891979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/7b/bMKFrKXhUKdv44Wdfghedf9BfYUOWeiJtb0PfY=;
        b=aA2CrBsMyRtq/FZJxXtEnOm9clR9+vvYLuumhKS9k4w6j8LS4i20Idw4lAkIhsIhwe
         ZxEtAYjLKPP7YZ1XWxcgRK4g4dk+uRCXZE0DPAJNnVlUgQ6Ow399evKkJTbk/kO3M+NH
         sGylkUcKURdmOIf0Tq4swmU/Gh2waUVcJQKMZSOuVP3Xw+pmgemr8qq6Wu5OhspnUAe+
         U+rWtMikiTFBAeAMsRFN0VLYBdSfjg/VASu0sDq3eyvNNhIqwzx98WQqEYXBwXla3/cy
         uQFq3t0U4jUDSbqxRotxWqkjw/kHWVaO9nnrkxdeIpNt0LAQtvRTzCHviiN/F1B3uC3n
         u+GA==
X-Gm-Message-State: AOJu0Yys7Fk9kNGkO22zZuyidD0om19m1LqPJtQi9Zm7fqbbbqQLjAK9
	+set+7VruWsdFGmgXwZjsaQFWcsqFwWuXCUyVwnAYXld7HjXRoxRa3I=
X-Google-Smtp-Source: AGHT+IG+kDV+I00d+TDF0snnUmtICSHAuE4noPxdOJq3KgKBlyp+ZObkSHoaGpSPxvdzq0JEs00fhUEcCNw/Dqtvfts=
X-Received: by 2002:a25:ab10:0:b0:d7b:9211:51a5 with SMTP id
 u16-20020a25ab10000000b00d7b921151a5mr27685528ybi.44.1699287179244; Mon, 06
 Nov 2023 08:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
 <29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch> <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
 <20231105192309.20416ff8@hermes.local> <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
In-Reply-To: <b80374c7-3f5a-4f47-8955-c16d14e7549a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 6 Nov 2023 11:12:48 -0500
Message-ID: <CAM0EoMm+x2eOVbn_NMDYVu4tEjccvvHObt0OSPvCibMAfiNs5w@mail.gmail.com>
Subject: Re: Bypass qdiscs?
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, John Ousterhout <ouster@cs.stanford.edu>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 11:27=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 11/5/23 8:23 PM, Stephen Hemminger wrote:
> > On Sat, 4 Nov 2023 19:47:30 -0700
> > John Ousterhout <ouster@cs.stanford.edu> wrote:
> >
> >> I haven't tried creating a "pass through" qdisc, but that seems like a
> >> reasonable approach if (as it seems) there isn't something already
> >> built-in that provides equivalent functionality.
> >>
> >> -John-
> >>
> >> P.S. If hardware starts supporting Homa, I hope that it will be
> >> possible to move the entire transport to the NIC, so that applications
> >> can bypass the kernel entirely, as with RDMA.
> >
> > One old trick was setting netdev queue length to 0 to avoid qdisc.
> >
>
> tc qdisc replace dev <name> root noqueue
>
> should work

John,
IIUC,  Homa transmit is done by  a pacer that ensures the packets are
scheduled without forming the queues in the NIC. So what David said
above should be sufficient setup.

cheers,
jamal
>

