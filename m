Return-Path: <netdev+bounces-43816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E0B7D4E9C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438F11C20974
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AE26288;
	Tue, 24 Oct 2023 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx25fGXi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E997498
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:11:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BC10C3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698145879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H7Y3L+wO4O4PCAdKbwK4BPdzk6P9AjMRpwDaWWqLDQ=;
	b=Kx25fGXieD0/Ex61NNcJ9KFyOBBfMWdyyPBTdJx0bVafVyVu3Tih9Iosqg7tkloCh6AIjm
	6KxNKmBtwXa4tof+e0vARAx+m9nDitnDvQiToe30qQwJlUu/E1THefJ+X7w2vf1t+lndHK
	8u/2HGt3Se0jebXaRGDcHIGCPz2W9KU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-OEXZlvVSP0Gby6nCo-CpjA-1; Tue, 24 Oct 2023 07:11:16 -0400
X-MC-Unique: OEXZlvVSP0Gby6nCo-CpjA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c45a6a8832so44241566b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698145875; x=1698750675;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H7Y3L+wO4O4PCAdKbwK4BPdzk6P9AjMRpwDaWWqLDQ=;
        b=Omna8pS/jC7gTcF5YlXz5PUXbxrdYUW2poiNPe2P/aJE9lKDhvT390VRJDSvuVC0kw
         0Rbqo9Ebld4fyASO6iR31nlnGNRjDoWognHdGBMeEEKuW2QTGAdhT950vKmDVBfQOt1w
         NcVANsdJPnt0ymQy+x3LQeJvJ1JWFJop3+KsxDgA0PaWCico1aJqZuXi/7P4+GeEsA40
         7uULJoAPrxW7QKXM2jLNEJ6RYGBjt18Vun6PG49hH30SVYLtsv8wWSWn22Qw7j3ZsrkW
         aUWbqljudxpFwI7turU3gVq5EeSV4J6nOBSP29qWFfq7OXW/mQyv/fE0txUGiyzLw9Sv
         YThw==
X-Gm-Message-State: AOJu0YxGgvAQSRcf+Ys2o61DcVJ0nUYh28IqQGGLJ0cOWaT8+E+7YiaK
	N4bf2F9ZDhxen0wnx3fdkxx3H9u6pkHxWYm/zOglYhB4ZMXN7QkBdO1/KVpOdrIM12DiYKpPAXS
	k5fcEZ4vsEZbmuMu2
X-Received: by 2002:a17:906:f50:b0:9cb:b737:e469 with SMTP id h16-20020a1709060f5000b009cbb737e469mr1904591ejj.4.1698145875542;
        Tue, 24 Oct 2023 04:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbm6fF0XWXv8tlBeoO6lS6nrzwyNW4FLJl6hKfbijCy2f0/nuEpU6IezwHCF7SzoFNY107dQ==
X-Received: by 2002:a17:906:f50:b0:9cb:b737:e469 with SMTP id h16-20020a1709060f5000b009cbb737e469mr1904578ejj.4.1698145875194;
        Tue, 24 Oct 2023 04:11:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-180.dyn.eolo.it. [146.241.242.180])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm8026369ejw.158.2023.10.24.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:11:14 -0700 (PDT)
Message-ID: <f44e4fd716729f1f35ef58895b1acde53adb9b35.camel@redhat.com>
Subject: Re: [PATCH net 2/2] liquidio: Simplify octeon_download_firmware()
From: Paolo Abeni <pabeni@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 dchickles@marvell.com,  sburla@marvell.com, fmanlunas@marvell.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 veerasenareddy.burru@cavium.com
Cc: felix.manlunas@cavium.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Tue, 24 Oct 2023 13:11:13 +0200
In-Reply-To: <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
	 <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-10-22 at 22:59 +0200, Christophe JAILLET wrote:
> In order to remove the usage of strncat(), write directly at the rigth
> place in the 'h->bootcmd' array and check if the output is truncated.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The goal is to potentially remove the strncat() function from the kernel.
> Their are only few users and most of them use it wrongly.
>=20
> This patch is compile tested only.

Then just switch to strlcat, would be less invasive.

Thanks,

Paolo


