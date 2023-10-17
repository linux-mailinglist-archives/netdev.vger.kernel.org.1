Return-Path: <netdev+bounces-41882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602567CC173
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B50281A66
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7F41776;
	Tue, 17 Oct 2023 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8gVlGJc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681CEBE69
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:04:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD87B6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697540673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYqRkp5nbhNy4codggZnLt08peOmFDnihVhb/KDpZ7g=;
	b=X8gVlGJcO6vNKZXmedJ/EDQ+fyaku2poikmYjbQXEhNcpJrvIcanddmDAAxXUyr8UAwC5k
	TwKwesYl4TBQ9tosxoB7WyDDVEF+dpqfq2jaasyCQl2V/dMa5Cf+dybFbG7FG+XxRloHWk
	XCzIg97N/0ayGI2q0ei7JZj2jEBRjEQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-fHmgh0qYOZWPzFav72VMfw-1; Tue, 17 Oct 2023 07:04:32 -0400
X-MC-Unique: fHmgh0qYOZWPzFav72VMfw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9bfbc393c43so39247966b.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697540671; x=1698145471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYqRkp5nbhNy4codggZnLt08peOmFDnihVhb/KDpZ7g=;
        b=N4O9zaqkFsFU6m5MkTmKupetWX9OC7UbDhfqVKJYtVgs8Am2LgaJkTMqUxiYQLh7dR
         EuagP54pgS6wKXwQyR8vHO4qUavfi3gY8/oJFrP/czUexOcEbiqSv7bLudxat+BF0tgY
         EaDKqp1EnaqZnoATmMhwFNuqt1yukk78sRCBCOccAgq0nkeCrjrR/n/uuIxNohiX7NbF
         uJLn2gHxrVdZQXeVeWpNdl/zkalx4r97DtCKLR/tQ0mJikcRf+vrHkRukSJFiVzBkNpy
         VDiC3GaKl6JfmFhgxaTrZxYBJkt+JgoUgooCHL50Tcdh65jUwzLIiRjVh9Kk2OOJulOo
         ibMg==
X-Gm-Message-State: AOJu0YzAlyxTJEq7aIB2Vc1xF/EjqkOReBdNPPsQ0fjUlAdn1BGbJ9an
	k6cQJpfMD+aPGtOASwZLMPMLoUH6a/TdvOK9aHOabhLUQIsIvPv7V5cxDiyDvY5tOXfFhaCvfmJ
	htVCQbkgLjf+h88xQ
X-Received: by 2002:a17:907:94c3:b0:9c4:409:6d42 with SMTP id dn3-20020a17090794c300b009c404096d42mr1341013ejc.3.1697540670844;
        Tue, 17 Oct 2023 04:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESTIhEc9vD0Ik4h6NFgWxMULaxTEBNNmO1WfnFCd7dcXYuY3RUp7VoDu/Rw9S2hN4rrq8jTQ==
X-Received: by 2002:a17:907:94c3:b0:9c4:409:6d42 with SMTP id dn3-20020a17090794c300b009c404096d42mr1340990ejc.3.1697540670506;
        Tue, 17 Oct 2023 04:04:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-87.dyn.eolo.it. [146.241.233.87])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061cc500b0099315454e76sm1021589ejh.211.2023.10.17.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:04:30 -0700 (PDT)
Message-ID: <a3612d9fce07dffc1029cf49286f16913d2e2df8.camel@redhat.com>
Subject: Re: [PATCH net] net: ethernet: ti: Fix mixed module-builtin object
From: Paolo Abeni <pabeni@redhat.com>
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>, Arnd
 Bergmann <arnd@arndb.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com, 
	r-gunasekaran@ti.com, Roger Quadros <rogerq@kernel.org>
Date: Tue, 17 Oct 2023 13:04:28 +0200
In-Reply-To: <20231013100549.3198564-1-danishanwar@ti.com>
References: <20231013100549.3198564-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-13 at 15:35 +0530, MD Danish Anwar wrote:
> With CONFIG_TI_K3_AM65_CPSW_NUSS=3Dy and CONFIG_TI_ICSSG_PRUETH=3Dm,
> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
>=20
> The build system is complaining about the following:
>=20
> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
> ti-am65-cpsw-nuss
>=20
> Introduce the new module, k3-cppi-desc-pool, to provide the common
> functions to ti-am65-cpsw-nuss and icssg-prueth.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Given that you target the -net tree, please include a suitable fixes
tag, thanks!

Paolo


