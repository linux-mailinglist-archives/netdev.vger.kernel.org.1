Return-Path: <netdev+bounces-62938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C69829FB6
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4D62881E8
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28454D111;
	Wed, 10 Jan 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGkElYkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7D4D100
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d47fae33e0so1855ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704909021; x=1705513821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziX4iAyQd6HuMoejvtTa4o/24+LLm+GeIG6etI51RFw=;
        b=RGkElYkxQBgBJkizvSkQMJOVLAS/Rb/Kepoa5WqZhH2V+qYL2wa5vDpervBAc0M09E
         +mKHacKxWgjrRd3ILvbdSh3kF7xjtbLhnCGHY9bfw3IDz0X+nanlLW6ytJP7wvhAL2nX
         2Yy7angzUm+GDmpQ9p2M+ZDUURDMW2uK/+6WKyACxLauMlSdGTCL33YhydIYuGtPg4iG
         Ht+TCkNTNwMi75caTg0zZXPgXU2q3NdGfp/DRIAMre1qx1AimDHAoNRRGEo3CLkJ/Z5Q
         ZF7M0NxXVxhoAH6B2IP9PJIaG92fRzBTJ0eAQkPl0Z9vpLDFGM8MVQzImPFKgHBcjOIO
         LUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909021; x=1705513821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziX4iAyQd6HuMoejvtTa4o/24+LLm+GeIG6etI51RFw=;
        b=DA2JUaZX6ssIE8OpbdTyGABWvxHR73oEi3mo1O9eMRZrQsVuLpgwKw43wGWcZpCDRs
         g5Oaam/k0jFXtoswcNW2VW4NF4RSlCcbBeRa9ypsSNh/fsr0c9STKjMPpX+S2UPq2M0a
         nU82zIkl/Q3HSdiLGN9CnW/QqeOURnT+sJ6+AmHP9f9qcxNIxNbugUEFgF8pkJno1ksh
         O5LciMj5qpgT50yuwxjAydxr9DOVbmz2+2Zxa2924wjO/THRVYVp1kq66cXUAYxZDpj5
         i+IrrXIGSFPuqrLmgVNykpJWqBFqJitxZ29LpXmJ1VL0Ur41SaBEQtDYB4rHf2s/otaf
         VfFA==
X-Gm-Message-State: AOJu0Yx3j6O+uIgFoZXWYe3VKrwxLRiQxocmowixZLsDEjjhgiu5vsfo
	cyCjbIb0w01LWJjeXBPlv8vgvttPpYiAlPXoEXKVRGOA6p7Wdr4c0rI0aYdyHNgHuDV8UkQeb/Z
	D67eJhOSFmT0hIOaXyxnbDDwQqHwbBySTMNIZ
X-Google-Smtp-Source: AGHT+IEJ1kVbKPySZnD2kKeOBfKyCBhNXAuJLGSkzYysePXX7J9uu7bfnYGIqnXlWDnqA8f4ASaYZl73K0Ijv1kIfTA=
X-Received: by 2002:a17:902:da8c:b0:1d4:c2bd:eff1 with SMTP id
 j12-20020a170902da8c00b001d4c2bdeff1mr7544plx.8.1704909020628; Wed, 10 Jan
 2024 09:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com>
 <20231220214505.2303297-3-almasrymina@google.com> <20231221232343.qogdsoavt7z45dfc@google.com>
 <CAHS8izOp_m9SyPjNth-iYBXH2qQQpc9PuZaHbpUL=H0W=CVHgQ@mail.gmail.com> <20240104134424.399fee0a@kernel.org>
In-Reply-To: <20240104134424.399fee0a@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 10 Jan 2024 09:50:08 -0800
Message-ID: <CALvZod4xbQr0gZdfXYNTaS11d2T2hHpXxi5Lfyt=y+TcDseOhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, David Howells <dhowells@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
[...]
>
> You seem to be trying hard to make struct netmem a thing.
> Perhaps you have a reason I'm not getting?

Mina already went with your suggestion and that is fine. To me, struct
netmem is more aesthetically aligned with the existing struct
encoded_page approach, but I don't have a strong opinion one way or
the other. However it seems like you have a stronger preference for
__bitwise approach. Is there a technical reason or just aesthetic?

