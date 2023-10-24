Return-Path: <netdev+bounces-43747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295D7D47F3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37D1281251
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FEB12B92;
	Tue, 24 Oct 2023 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzkfCgby"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C4125BD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:08:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB10120
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698131288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2ft1iIUeqg/aot+9+OZB9Lfvws+RDiPr3cR/Bz0A1g=;
	b=UzkfCgbyIVDbsENfkEmuQ+Rz/3ZaJDwTv6pmduVxxFx6cdPaK+TX05kMxaVTPaMuLLNGDG
	4N1jvS4/pPUnfFMNgFsgeC46uBxA5ocTeu3NQ2FR1YOmKEi6wlSHCMJwb/SBL0y0kpoLhW
	qd/xux/vVrxd1EGvUcr7EH+3VgaFAuI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-D7H5aBqWNCa56sT2xjNqgw-1; Tue, 24 Oct 2023 03:08:07 -0400
X-MC-Unique: D7H5aBqWNCa56sT2xjNqgw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5401de6ce9eso503917a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131286; x=1698736086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2ft1iIUeqg/aot+9+OZB9Lfvws+RDiPr3cR/Bz0A1g=;
        b=iX7/SrGRYdxWUqziYm4PZ13O/wGmuI0JaS0FtakjglCA5rTOkKSOq2/J9WDqzfW4RZ
         xZwIp4YduvgGlNS9cvaznAuvSgb2CLGkgerm1S7gsG4Cbl8DSWebjpMHNHQxapg7+OGJ
         fK4ohwdGe3uQDxHnQbhFgaMemepZPlzPja+qj34kDVwS4sLfUkgPaNr1s5wMi9NzeSJc
         vammeDPinuximuc7Rf61FuplPuqNw8G55jqJ/06c/9DtFA9Vh8vX8I4cXbGaXw+GoAUA
         AHEVebuU+neutY2aXcTkwEAgoqdmjWwpKAYhf8AFdM1udAMKiKeCCJjnkVoXAdYKtQWk
         y7qQ==
X-Gm-Message-State: AOJu0YxUbOrA79eB5lerTdyVBxtSexYBe1/OPXfy8MQ83JGNeiElMNc6
	iLUD5lhLkrIqbcL3nbbjtBxu4hK8Kc8uhnxjRm4yfgJKKyAQrGKW0sX5k0j0rIbRk0D98KaHKoM
	MeA6tUKXwZk8BeNifEbL7x7j6
X-Received: by 2002:a17:906:74d9:b0:9c3:9577:5638 with SMTP id z25-20020a17090674d900b009c395775638mr7384967ejl.0.1698131285920;
        Tue, 24 Oct 2023 00:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPaCM7KIuJtAaMw46pyDZhEwtqHzRUEKzb1sBmdVRk3Pp0xGYZFtcg3FeMCJOb4OO+lA5OVA==
X-Received: by 2002:a17:906:74d9:b0:9c3:9577:5638 with SMTP id z25-20020a17090674d900b009c395775638mr7384951ejl.0.1698131285585;
        Tue, 24 Oct 2023 00:08:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-0.dyn.eolo.it. [146.241.237.0])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906019400b00992b8d56f3asm7794023ejb.105.2023.10.24.00.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:08:04 -0700 (PDT)
Message-ID: <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
Subject: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when
 raising allocated
From: Paolo Abeni <pabeni@redhat.com>
To: Abel Wu <wuyun.abel@bytedance.com>, "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Oct 2023 09:08:03 +0200
In-Reply-To: <20231019120026.42215-3-wuyun.abel@bytedance.com>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
	 <20231019120026.42215-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-19 at 20:00 +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>=20
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> So revert that behavior.
>=20
> After reverting, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>=20
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

It's totally not clear to me why you changed the target tree from net-
next to net ?!? This is net-next material, I asked to strip the fixes
tag exactly for that reason.

Since there is agreement on this series and we are late in the cycle, I
would avoid a re-post (we can apply the series to net-next anyway) but
any clarification on the target tree change will be appreciated,
thanks!

Paolo


