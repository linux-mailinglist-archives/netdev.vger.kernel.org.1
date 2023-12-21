Return-Path: <netdev+bounces-59753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6C81BFE8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC4D1C21F86
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11A76DA0;
	Thu, 21 Dec 2023 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZBNuPDr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6856280F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703193100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QG3Vmx1RXLUkPYNVOQ9J3qNZiav3NJMyWthRgfk5oss=;
	b=VZBNuPDr74++7FYnS52GQgTAjeg2X9sFu98dd6T/Qsyh/SsvxBPub4Av05Ytaj4rz0uznC
	p8svUOopgxdxjbXduMcPmuP6kIws7diVPTDS1XrvsUNQevaiIh64+TZv/suirOSA/Emm1Q
	bWuMpCSjENmPNRy/i3vm0Alj3mahvG4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-NDEE3ugFMxaT4wjF_QORBA-1; Thu, 21 Dec 2023 16:11:38 -0500
X-MC-Unique: NDEE3ugFMxaT4wjF_QORBA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7d4ae8932so26889539f.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703193098; x=1703797898;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QG3Vmx1RXLUkPYNVOQ9J3qNZiav3NJMyWthRgfk5oss=;
        b=lzyIVLYDxfQwM0YCAs0WbNA3q8C+29zz74IP8nnMUXqQlYQoS92JbOd2fn8OXZPUHp
         R8gEZRtHB0zCph+T/8g25rHGBya0BFMp8uyneoXyp/wGVAqYMIpALO/MZJFJrB07G8jT
         2IV8CATmtlEE+c5tF3N4jJhOAwcJNvyv/Vjy9USwoVs55yZZJPl9LlIOX5ifvH0+ZB1N
         Bluo2JuGGvb9rezHnqpNHWdoWzrIhwKwh8NY+2agEEEvjV/pODF0FU8ee2rE7UJziAyM
         qFiBUoSW80tRPIgrnTkhRk2O4kQqJ9xBGBbuhomoxxrkZ8ZZl0baKCQw+oYM5z1QRU62
         vonA==
X-Gm-Message-State: AOJu0YyBeF2pSKFa3qIFYM9R1LBMzEs9xpzqtJ/97+AVaPn6YxWTKwIK
	ilHCmVRbry79wAOX+iou5L6xhZZb5mJ75Dy3OPWQR+aVNV5AKKQyXz8OAOuBxYHhAGia4m2o8Ph
	tB56rH35hW2kjyVMqRT4R8xUWa/q5ZKJF
X-Received: by 2002:a6b:e916:0:b0:7ba:9b40:2648 with SMTP id u22-20020a6be916000000b007ba9b402648mr99634iof.1.1703193097978;
        Thu, 21 Dec 2023 13:11:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFF9SaZmxsp7NEcn0Qh0EdXBka0QJBiSuyuGczKVot8Z1TuzSs6AtLY/V/zQKm9YaYIp12hA==
X-Received: by 2002:a6b:e916:0:b0:7ba:9b40:2648 with SMTP id u22-20020a6be916000000b007ba9b402648mr99624iof.1.1703193097657;
        Thu, 21 Dec 2023 13:11:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id z20-20020a056602005400b007ba79d74f2csm648403ioz.24.2023.12.21.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:11:37 -0800 (PST)
Message-ID: <1eb090e960de282556174c4fbd5ac0b344ec2626.camel@redhat.com>
Subject: Re: [PATCH net-next] net/ipv6: Remove gc_link warn on in
 fib6_info_release
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Date: Thu, 21 Dec 2023 22:11:34 +0100
In-Reply-To: <CANn89iLczu8fXUGxJt8LGEhoUbkNrKyh=5zjZXR4U-HfKPwPsg@mail.gmail.com>
References: <20231219030742.25715-1-dsahern@kernel.org>
	 <CANn89iLczu8fXUGxJt8LGEhoUbkNrKyh=5zjZXR4U-HfKPwPsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 09:34 +0100, Eric Dumazet wrote:
> On Tue, Dec 19, 2023 at 4:07=E2=80=AFAM David Ahern <dsahern@kernel.org> =
wrote:
> >=20
> > A revert of
> >    3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list=
 of routes")
> > was sent for net-next. Revert the remainder of 5a08d0065a915
> > which added a warn on if a fib entry is still on the gc_link list
> > to avoid compile failures when net is merged to net-next
> >=20
> > Signed-off-by: David Ahern <dsahern@kernel.org>
>=20
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Oops, I notice a bit too late I should have processed this one before
merging back net into net-next.

I'll squash this change into the merge commit to preserve
bisectability. =20

Cheers,

Paolo




