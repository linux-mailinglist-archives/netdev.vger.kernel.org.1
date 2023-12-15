Return-Path: <netdev+bounces-57759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59381408C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EAD282196
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CF15CF;
	Fri, 15 Dec 2023 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJcvNtZs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8DC566C
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU6XR3jlZFj9LBTMMxQsE/bFIXz44r7Zm39uegVLGgU=;
	b=TJcvNtZse4loCErmGAs32UdavV/eE32m9AR5jfte+m0cYW5ZFndHvtUIYxjb2YsUlZvXbg
	xsGTFSiQqovbD5f3jNK6k4Wu/SHS/gqCOoTYC8Y60AvOYZw5YmQcxxD2bC5/K1SjTssn30
	ap/GHkItP3cl6s1NYe2uXFDrgzYTXIU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-bmfXSUYcNN6a2W8_v5nlMA-1; Thu, 14 Dec 2023 22:18:13 -0500
X-MC-Unique: bmfXSUYcNN6a2W8_v5nlMA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55262d6782bso1506455a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610292; x=1703215092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU6XR3jlZFj9LBTMMxQsE/bFIXz44r7Zm39uegVLGgU=;
        b=lCJv9DGkxPrf89TwQpSBGYLV4wRWF826r8fy04dpmujnwvSymvQIZVY9OfSL1eZK0C
         Zky4p/T6C8hg8OEAtyI4t4cL8c6dPec6x5ypp+NvbVB1NNWz5wZzqRY0jKCTL4CuriBm
         kmGPMepEXRfLDeFbmElwhHtsVA4Bj9bo/bUT+MGN09afS4H6mhI8Im42K5rl6NK9Oncl
         hnzIDMgTETDZodaqeFdXUbUVLzpdmT0YCLqZBnYYiJjaGeTAjySESwYqLmgHTykWDfrv
         ML1W9tBW5JgqScnn0un0zWYqKYf4TaNX8IjGVT4XrCILGGY6aKURy3ZVAjnXpRQbIoUp
         GV5w==
X-Gm-Message-State: AOJu0Yx2Vu/v0QmPs7VP9kKCQK8YdLaXlFoOwovomLSxNKH5ZP0olCTu
	oz/TEF4cECfPVVYJVlb89HLjkN5fqB/xh5k8Lia4MNrMZpdeCBM21kUXp3Qw+gRxe8szYZRNWw1
	SsBNHx5rpnsNJLBecQl/QFhW3s+xwHVUb
X-Received: by 2002:a05:6402:324:b0:54d:d0c5:4f53 with SMTP id q4-20020a056402032400b0054dd0c54f53mr12331618edw.11.1702610292113;
        Thu, 14 Dec 2023 19:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEwmS0vcN1VG7p2MzdbnRZT2VT7sNeOOxpCkPhbzjD+VkiECTLviq6iTxQSJAE2rXbfhZy7m96f3Y4Fer/J3c=
X-Received: by 2002:a05:6402:324:b0:54d:d0c5:4f53 with SMTP id
 q4-20020a056402032400b0054dd0c54f53mr12331612edw.11.1702610291991; Thu, 14
 Dec 2023 19:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-5-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-5-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:18:01 -0500
Message-ID: <CAK-6q+gd20PfRQdyLHHCdwqOsUMThm2_V6HW9VqUpzhisHdF4w@mail.gmail.com>
Subject: Re: [PATCH wpan-next 4/5] ieee802154: Avoid confusing changes after associating
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 28, 2023 at 6:17=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Once associated with any device, we are part of a PAN (with a specific
> PAN ID), and we are expected to be present on a particular
> channel. Let's avoid confusing other devices by preventing any PAN
> ID/channel change once associated.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


