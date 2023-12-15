Return-Path: <netdev+bounces-57758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A681408B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127D21F22F2E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381AE46AC;
	Fri, 15 Dec 2023 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJC/K21K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE56AD9
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5xoVNAc3uN7zDhUP5/XuZ9lvsG13QS+0NjaofDIv+A=;
	b=fJC/K21K5gUow8YKpi9gUPvNw35TSo9zTpZx9924J8d22bgE+isLvCHfNLMh00sP9d+aRc
	kTGg4EvuL8TfULSvBzUshdnwll7MZkRTmeWK8UX648AnrD+flzSVaVVeb+vnTsx14XHV6T
	hSSsXO+8FnMqO95abEbfp1CYNgjWlao=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-8SfnbiziMLaLecbBASG-FQ-1; Thu, 14 Dec 2023 22:17:29 -0500
X-MC-Unique: 8SfnbiziMLaLecbBASG-FQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55285349727so80533a12.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610248; x=1703215048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5xoVNAc3uN7zDhUP5/XuZ9lvsG13QS+0NjaofDIv+A=;
        b=hJSTduQvy8v4BDv3zhU4fH0KntX3Pouiqr/RXdatfF64HqsNsKmUH/LwuPiYU8e2BO
         lXuKrpjW52Dhra5gAi53GEqvOrKXsWtFr+HusWGfqMQRze4a5PaFYbcja1jnwm1dGtZV
         8ZErnHQceESwSbPZ35L/d5i2Re7Jt88MlS79gY7FlxRnK3qfgZqhITb0ZC166tSFad+2
         BE/GCj7k3tKkAhrQwQ3+EZ33pxG7ToL0oQZ5kJirXto0PsyujGaqxuH9G0JDT/ROI69Z
         qKLaHMe5wD3uph6088+vACeLNhYT6PY06MML+K5rdbVmMZI+Vpr9bA3QdpjXLBZ1y4SH
         Cmzg==
X-Gm-Message-State: AOJu0YwrQ78Wfguv8BF+dleb2unVrafuRLVeHS9iUd+0Uk+OpAIAsvA4
	vCUD2QTvu3+iciaVeNnUJgNU+b1XMLIOhcWMvoum+fnc2OI1VqxNLf8/XXAMRzpxWiYnu+HMxRo
	+ITwXk5htbQEAwvhm1fKbFohsqRKz9eP4
X-Received: by 2002:a05:6402:2051:b0:54c:5f17:1163 with SMTP id bc17-20020a056402205100b0054c5f171163mr5362515edb.58.1702610248403;
        Thu, 14 Dec 2023 19:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYodYhdQRjwTPKLzEFZ/TKE0p3OPU7KHSXvbX5fsSIF4Lkasnl2mVXc2fCW1tS1Gcpf2YF5YJ462UZHLzptwE=
X-Received: by 2002:a05:6402:2051:b0:54c:5f17:1163 with SMTP id
 bc17-20020a056402205100b0054c5f171163mr5362509edb.58.1702610248119; Thu, 14
 Dec 2023 19:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128111655.507479-1-miquel.raynal@bootlin.com> <20231128111655.507479-4-miquel.raynal@bootlin.com>
In-Reply-To: <20231128111655.507479-4-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 14 Dec 2023 22:17:17 -0500
Message-ID: <CAK-6q+jThrZJBK4qRknODnNoaPMxrDp2rwWETi2SJV=Di1VQGw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 3/5] mac802154: Only allow PAN controllers to
 process association requests
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
> It is not very clear in the specification whether simple coordinators
> are allowed or not to answer to association requests themselves. As
> there is no synchronization mechanism, it is probably best to rely on
> the relay feature of these coordinators and avoid processing them in
> this case.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


