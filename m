Return-Path: <netdev+bounces-58868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E9E81869F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DF51F2420A
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448515AE8;
	Tue, 19 Dec 2023 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/U3tpg6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0C17999
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702986532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr2qGTapksnUTE7Tzh4sNsa6lEtFhJDg5ZE1fUFhBGU=;
	b=Y/U3tpg6Qcd3Xd+eORQ68e3YVjwwlOKYVdzNZlWOBzIJ5qLGMpWQ+iy97bXfR2MgTwuoXE
	/jkzRBbvzILSFwpP7oSTXxf5p9Ol7rPzWM2fRRWEUoZYT6w6hMDwc2N6PSU6Xg4SXY/Aui
	pg1AUuKlYn3oiWVD7L5wx66w2ZmJ4Dg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-DpqqjIecMrKIPvyzJqn--w-1; Tue, 19 Dec 2023 06:48:51 -0500
X-MC-Unique: DpqqjIecMrKIPvyzJqn--w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-553360a958eso313327a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986530; x=1703591330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fr2qGTapksnUTE7Tzh4sNsa6lEtFhJDg5ZE1fUFhBGU=;
        b=lv1xmnKOYCVa4GlyWcjwgqprhn4YlGIG4/pNmUCp77PzkBJk6OAn/PmTv3TuYw5dMc
         NoPHiA/TAQPrFK+LAfM92Ze0DgkZvuwvrL5YdUiaVVInhhlLxkigjzcTrEhP8IDeSmHg
         pFQiyLMPDq26UVeaCeACuLTOe/av4wXdkckb4UhzoTnjY5JPdTciaCTM4lPSACFPWmSm
         1tBDNyw8OuD/Cjv6J/tyIeljtibVMFoqJDrNql4mMMIxe64SZNFg+Z+zyCx9cO0+j6X6
         0uYb4UcVl+IXZHDZI8Pjf1G8XroBEVMeWXS8edPb0friToyw+uYZ1jsIE+GaI6vVcsho
         bFpg==
X-Gm-Message-State: AOJu0YytiwLe5+6v3f0PPCu1s1O0DBfRKC9LzAzvCil71RTuTm53V0Vb
	BMb3QQxM8+F/H8vuuaf12au/XSQKsFfPQFog0CycXTiA0qlte/ZY+/5EIJGQllN78rbVOU0MXlE
	Ue9PZllcXTzopyb/S
X-Received: by 2002:a17:907:7e9c:b0:a23:526d:3413 with SMTP id qb28-20020a1709077e9c00b00a23526d3413mr4754654ejc.6.1702986530092;
        Tue, 19 Dec 2023 03:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExCwmBgEIuuvM9cArSJRNcvw8/HcjlPweD16H49JF/0xZQ+keTkwYgHN9AFgUq5dZZQ7dCxQ==
X-Received: by 2002:a17:907:7e9c:b0:a23:526d:3413 with SMTP id qb28-20020a1709077e9c00b00a23526d3413mr4754634ejc.6.1702986529725;
        Tue, 19 Dec 2023 03:48:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170906a24200b00a1e04f24df1sm15293971ejb.223.2023.12.19.03.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 03:48:49 -0800 (PST)
Message-ID: <3469d3e0c2cc7cd0519282254d27d6274384404c.camel@redhat.com>
Subject: Re: [PATCH V2 net-next] net: hns3: add new matainer for the HNS3
 ethernet driver
From: Paolo Abeni <pabeni@redhat.com>
To: Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com, 
 salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 19 Dec 2023 12:48:47 +0100
In-Reply-To: <20231216070413.233668-1-shaojijie@huawei.com>
References: <20231216070413.233668-1-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-16 at 15:04 +0800, Jijie Shao wrote:
> Jijie Shao will be responsible for
> maintaining the hns3 driver's code in the future,
> so add Jijie to the hns3 driver's matainer list.
>=20
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> v2: add 'net-next' in subject

Actually we prefer taking this kind of changes via the net tree, so
that they reaches the largest possible audience sooner.

I'm applying the patch there, and fixing the subj typo as a one-off
exception given the current period.

Cheers,

Paolo


