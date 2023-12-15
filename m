Return-Path: <netdev+bounces-57760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01481408F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7B1B20FDE
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0F17C1;
	Fri, 15 Dec 2023 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4CAOvw5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187F17E3
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSCdKl5IjfrWspr8I8Dc/FxsnqwF+3Y8862VXGQQBSk=;
	b=L4CAOvw5eVifqMQn7FRPMHkT4xjiW/5eJk+bMcr9z9Qo2iBIj2uyHftsIiDQ9nT4cqAnAI
	Gn/2zbsAH5rf2sXMOpTQNdJiApfhJMy65Zed+md4xQsKNH9k3h5h43sfnufki+dNZcm0mR
	xH3szEIYSxwu7EvtsfCEL1zynOCv/No=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-gsTg2qOtOsG2jmbW30mo9g-1; Thu, 14 Dec 2023 22:19:23 -0500
X-MC-Unique: gsTg2qOtOsG2jmbW30mo9g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-552a9862f94so88392a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610362; x=1703215162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSCdKl5IjfrWspr8I8Dc/FxsnqwF+3Y8862VXGQQBSk=;
        b=HuA8p5NrVdwkiVe+Xj4Q01dX+cD5bcE0UQAjTzA+jW+o3wJnh9OA/UnSMY6cRvMuQZ
         WpliZlJ9Vo8udJodAC4kU7D50VLQEPs9tc/NqEIrcQTrRe6dFk+jaJum1E6cuYhvV+Va
         TcdNuNYyPprKdsszDR+G0j8awxuovxrzrimtzlpB6ZcLeXoMC2H9BUVJMJVnBG3CUk4y
         6gOuJL5yPB90zejuAwXBT0Z3gAmPYslx0Pgga1/LmY+MBgV0tnfCl3OKvqHo7iWsa3le
         Zt+TrdYXgn/UnN9CsQQr/xMZ1jdhPj+4zCcqf3G/v96+kKBl5oZGvdKUH/eijkz6UrhA
         drUw==
X-Gm-Message-State: AOJu0YzSywLX9uaebCRoCKUtRViM4QdVYTlq1y0uWdxQ3aFJQt0ShmAW
	KaUD73danZuhPrSPGQJgKt7rHvN0MEhjTkPVMJhF5VzDvNH30lKYC41czpoM3H8ypfp4SL31s+0
	VEgVoOiRCGj2y/avpzCKQ1vjEgqA+ajmL
X-Received: by 2002:a50:875d:0:b0:551:bed4:b613 with SMTP id 29-20020a50875d000000b00551bed4b613mr2409552edv.81.1702610362303;
        Thu, 14 Dec 2023 19:19:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUOXBcBRgK59ieROrGIkoUvJVYo57oHH2Lr3hQ7e9ZqkF9uzeUoyJeDcaR+M2SerjjD0saWyDWdI/QtedqPk0=
X-Received: by 2002:a50:875d:0:b0:551:bed4:b613 with SMTP id
 29-20020a50875d000000b00551bed4b613mr2409546edv.81.1702610362027; Thu, 14 Dec
 2023 19:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-6-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-6-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:19:10 -0500
Message-ID: <CAK-6q+js4OH8HP-T5+U0yY-cH=XNHFJyRZOxc8sOLLR8fctxrw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 5/5] mac802154: Avoid new associations while disassociating
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
> While disassociating from a PAN ourselves, let's set the maximum number
> of associations temporarily to zero to be sure no new device tries to
> associate with us.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


