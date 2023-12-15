Return-Path: <netdev+bounces-57746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E395C81405E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E682819C0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92310E1;
	Fri, 15 Dec 2023 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHp6EXXU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBD566C
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702609536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9uC6ryckwgkjdiCz+BBk3Y38k+wG6P2U1aM9PzOevk=;
	b=AHp6EXXUz5O2A0xUEHGFfoZG3scrjBPSpwMdY1FCQFOF+XiCbMhSY7LNzSHXPIyTbKT9Xc
	+eBbCikGZYrgrH2h18kAXF6TGjzxssX/gZg1ivQaK2mPdCvPI4Y5lSdT2cscOiOPjBdGpk
	lBQY2tsipwKon1o6DjZrQg+wViG7D/4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-8ywE2sy5OJS5t-dGb-v24Q-1; Thu, 14 Dec 2023 22:05:34 -0500
X-MC-Unique: 8ywE2sy5OJS5t-dGb-v24Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54cb71a5e16so78127a12.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609533; x=1703214333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9uC6ryckwgkjdiCz+BBk3Y38k+wG6P2U1aM9PzOevk=;
        b=JWngNbhfP+yfykYLU2TSBlH2Q20u7UpBDSUTuU2pZHqBLoZ4BsmM35yW1MxUoGrdLD
         FGLbBtzGXODZgEGBeuM7pWk36tYQjlAOXbWV5KanxXBwD5eYSdwGZiLp2eB1CIYaT4et
         D5l1AvReujfLI5rJMMNtJeF/UqPb/dKLM4N7RpckgUhirRCyXab98pkzfz6nz8Q6vzrU
         rOS51r64NSNNqNB03VgHmc9G2xnOzft7Sd19p94Gkx82iePnvO4TI5ARauMmxU3cS9N4
         jhZGyR+E0bgpmlKIsmm6+CXvSX11jhm4RuizVlgbtMN8TEsMC/V17oHkjYKCzvXG0wgG
         BiCQ==
X-Gm-Message-State: AOJu0YyuQec2+i0b54VLVC6fk6+22XSOvSO1CHl9e0+idhEcQ/WxuDjK
	saYvWuMdkW7/X4HyNPzFgBNOpjIZXpK2QVu1Ujql+Yqo41Nr2uOmIj7Iqu7aHD1jJ3s8YHTE/oZ
	DMc3wrcGc3G+coy5FJSkyxJ5pWjkhMfBj
X-Received: by 2002:a50:f696:0:b0:552:81fe:8858 with SMTP id d22-20020a50f696000000b0055281fe8858mr903561edn.10.1702609533348;
        Thu, 14 Dec 2023 19:05:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU7lu4l3r2Us7r6+r2mvMBEd8VPuCUg7LwwGWNLAA+lH54vPJXQZ5goqUn/HRyVLR8Mpl8NFkObOEn0e7M2KU=
X-Received: by 2002:a50:f696:0:b0:552:81fe:8858 with SMTP id
 d22-20020a50f696000000b0055281fe8858mr903549edn.10.1702609533097; Thu, 14 Dec
 2023 19:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com>
 <20231128111655.507479-3-miquel.raynal@bootlin.com> <CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
In-Reply-To: <CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:05:22 -0500
Message-ID: <CAK-6q+h8wFD6Phq51fau9t-L7f9vH89OkbS2p+LLSZRNA-LbPA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 2/5] mac802154: Use the PAN coordinator
 parameter when stamping packets
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

On Thu, Dec 14, 2023 at 9:46=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Tue, Nov 28, 2023 at 6:17=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > ACKs come with the source and destination address empty, this has been
> > clarified already. But there is something else: if the destination
> > address is empty but the source address is valid, it may be a way to
> > reach the PAN coordinator. Either the device receiving this frame is th=
e
> > PAN coordinator itself and should process what it just received
> > (PACKET_HOST) or it is not and may, if supported, relay the packet as i=
t
> > is targeted to another device in the network.
> >
> > Right now we do not support relaying so the packet should be dropped in
> > the first place, but the stamping looks more accurate this way.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


