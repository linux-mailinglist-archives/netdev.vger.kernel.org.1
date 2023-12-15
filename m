Return-Path: <netdev+bounces-57748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FF814061
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF7281C6D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366CD1118;
	Fri, 15 Dec 2023 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/XGRh4C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD14110C
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702609576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLyeXI6IfJc+fASECf3zMo4is78Uk23MBbPT3av6ivU=;
	b=N/XGRh4C8hWhqWudDTuhUCxHoA9K3CBZ5icOuMnswWzxABUrHPz+cHg8SifI2VJmybO4O6
	Jc2jgQnTr/vhAw2mBzOMLhZcUdw3a4LFAP9v0Y2RpfmWpcfBzx7SvXgjm7vI/RZiVHXmZR
	ASX8EHpIBNShP+nlcjjG1MqWC5DlWEE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Fw7zbS1iOrqCofgpuIBPtQ-1; Thu, 14 Dec 2023 22:06:14 -0500
X-MC-Unique: Fw7zbS1iOrqCofgpuIBPtQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5528b4ab7bbso71090a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702609573; x=1703214373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLyeXI6IfJc+fASECf3zMo4is78Uk23MBbPT3av6ivU=;
        b=JzjyHQuuPZByYkUSHgu+hFBtRhxeu1r9jCqLbaxY5PEaRJeP8rgBb0WVddUpmHxk/w
         QmsVYz91WhHSY/96gh5HXS9iAjPINIVKsT8lhyydPl9Pdx48vPxxGTEfReCo5LcxGF+O
         P1Bf6z186bM/3cUvwlxxCwfEdkXN/EBI4OQo/ZLcYVEZ+Y3TX/p9ql1YkHYAJyCFPaZG
         THWC5RjASIdBO8SACXzJgmUIWb01PObrTjM4II+0hPm4ooGKc/GO22oTqO0X0LyIvNub
         /qcIUpPN4nT2OShn5osX9wySqTnY2g23plnCyVxb5kYMgj0ZMVbnNFu2uuY83E8RX/qs
         y5JA==
X-Gm-Message-State: AOJu0YztbCf/Zh2ULrcFACaN8C8G0QL2mEEhZCS+F7EvgK1iSrAs9/bp
	FmUBWUl2zzIF35x4/tHFPGyrsoygjsnFETYD43VTXMUWcXpT/CTWd0Jfklb9hWJtfVcfGQgeS25
	/8hJ91YE4mWFTonwr90G6IfclX2GHROA9
X-Received: by 2002:a50:858d:0:b0:551:1861:1c47 with SMTP id a13-20020a50858d000000b0055118611c47mr2032241edh.67.1702609572936;
        Thu, 14 Dec 2023 19:06:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNE6nZcFlIOZHgwqroui93FL8SZNxtDtzVDg3pz5u6tWYJ3fFnA7mF/k7PxS8UGZT2GnHMojimj8VkLlntfq4=
X-Received: by 2002:a50:858d:0:b0:551:1861:1c47 with SMTP id
 a13-20020a50858d000000b0055118611c47mr2032239edh.67.1702609572655; Thu, 14
 Dec 2023 19:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-2-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-2-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:06:01 -0500
Message-ID: <CAK-6q+hWSnhtqX5JmsPHH8Psz=MVs3cuXYwfvmt80=a0Gwj_=A@mail.gmail.com>
Subject: Re: [PATCH wpan-next 1/5] mac80254: Provide real PAN coordinator info
 in beacons
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
> Sending a beacon is a way to advertise a PAN, but also ourselves as
> coordinator in the PAN. There is only one PAN coordinator in a PAN, this
> is the device without parent (not associated itself to an "upper"
> coordinator). Instead of blindly saying that we are the PAN coordinator,
> let's actually use our internal information to fill this field.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


