Return-Path: <netdev+bounces-59754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5381BFF3
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCB01F25621
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007E576DAB;
	Thu, 21 Dec 2023 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJYRjmeW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B576DA0
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703193676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F81tgorPPC8rKY7lw2woaVz+TujoboSyrJwm0fUy2JE=;
	b=ZJYRjmeW8m6zza1LejJqTCMbBcOGgKILoLhXL4oEJSkGt5FqJ02MVwE40iHQTsjdHpzdVZ
	j/KaSU4dnQpY5NAwG3HNDVw58TPOGWqrc/AjJYcoYuMMBXP/0lmeXOkYkvspYeYE7r5Emv
	YzsK1KmfhzyTr1EICm6ZbtVQk9vDvps=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-k5tZw5skOG-zrOzXrJrKGg-1; Thu, 21 Dec 2023 16:21:14 -0500
X-MC-Unique: k5tZw5skOG-zrOzXrJrKGg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cca8cbe588so193101fa.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703193673; x=1703798473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F81tgorPPC8rKY7lw2woaVz+TujoboSyrJwm0fUy2JE=;
        b=JXA7SnUpph7+FO7EPp39YTVcy2upxJmCoIt7Nm1+rlLVXIPRT09gR32B+/t/6LzAuZ
         Br8RgOWnuCoDMgQ0T3kb0RyRc4P7SVSSlwc66/WV+ELOuhTtigrJNpCOAGUaM5V4NU49
         4Axf8F92XwH/J1fSSE8k+n4tLCcU5W44B41CMyvLzq8aGTGNKrDxzAkNg5ShXsz33eEZ
         DhbPm1472gCHobcgKr8aUo6TECsdco6f+EENpu5ekcytlq701f5TY0j8R7G5Tbiy01m7
         IIXMMB3GjRZXhoBHUoiszOVI6BQpvxYhMNmo9RGy+Gg4Nu/2kwUJjbuD+lz/XCtPlJWK
         I3Rg==
X-Gm-Message-State: AOJu0YxwIoTsPqWaEfuf4mtmO17zQEcwmpQmJUgZF2vFcW9Xgue1tToI
	WFKdaf2njnClrQbWFX5HMQG3+wkZAsFxMCIufg319PX0MBSh22zNn5LfCyKZHOSSyV4mH1r+5fq
	RN6VYZzkYtqZF0rFdgM3Ad8RPFjM2Ld6r
X-Received: by 2002:a05:6512:4849:b0:50e:6878:a70d with SMTP id ep9-20020a056512484900b0050e6878a70dmr210074lfb.2.1703193673206;
        Thu, 21 Dec 2023 13:21:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+lIo/RAFZgRrBMPm4uZK/j79wlB6DaXSbFR6dJpfNdOtMSOXsf0F1KWB6luiPPUS/0JiMvQ==
X-Received: by 2002:a05:6512:4849:b0:50e:6878:a70d with SMTP id ep9-20020a056512484900b0050e6878a70dmr210065lfb.2.1703193672738;
        Thu, 21 Dec 2023 13:21:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id k27-20020a17090627db00b00a268ee9017fsm1368933ejc.157.2023.12.21.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:21:12 -0800 (PST)
Message-ID: <344024e9f616635b36462111abec59aa98e92f53.camel@redhat.com>
Subject: Re: [PATCH net-next] net/ipv6: Remove gc_link warn on in
 fib6_info_release
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Date: Thu, 21 Dec 2023 22:21:10 +0100
In-Reply-To: <1eb090e960de282556174c4fbd5ac0b344ec2626.camel@redhat.com>
References: <20231219030742.25715-1-dsahern@kernel.org>
	 <CANn89iLczu8fXUGxJt8LGEhoUbkNrKyh=5zjZXR4U-HfKPwPsg@mail.gmail.com>
	 <1eb090e960de282556174c4fbd5ac0b344ec2626.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 22:11 +0100, Paolo Abeni wrote:
> On Tue, 2023-12-19 at 09:34 +0100, Eric Dumazet wrote:
> > On Tue, Dec 19, 2023 at 4:07=E2=80=AFAM David Ahern <dsahern@kernel.org=
> wrote:
> > >=20
> > > A revert of
> > >    3dec89b14d37 ("net/ipv6: Remove expired routes with a separated li=
st of routes")
> > > was sent for net-next. Revert the remainder of 5a08d0065a915
> > > which added a warn on if a fib entry is still on the gc_link list
> > > to avoid compile failures when net is merged to net-next
> > >=20
> > > Signed-off-by: David Ahern <dsahern@kernel.org>
> >=20
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
>=20
> Oops, I notice a bit too late I should have processed this one before
> merging back net into net-next.

Actually is not too late. I'll apply this commit just before merging
back net. Sorry for the noise.

/P


