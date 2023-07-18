Return-Path: <netdev+bounces-18557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE17579FE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BD91C20AB1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E94C159;
	Tue, 18 Jul 2023 10:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7923BC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:59:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8CE6F
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689677983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LJtquyTxvI13pU6MFUwaqbon9SOflLb0YCrw2Fb03I=;
	b=NkdsHy9OajsB+1aJhqX4ilbC+RoAEkAJBdWQhzlZP2HEcrC0MCcK+4IGzGC7qJVevx/9ih
	hU4WCi7SBjgxx/h1aiWJZpL+Zy/Qz8L9yBarVEdot+rCVGPcRJJBSKUp/9Gnc11wzh3YJR
	ZbY3mhPuLMsxebhEz03B7Y1VvE2ahRg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ZqsrlCcNPJ68_GWr7-_hXg-1; Tue, 18 Jul 2023 06:59:42 -0400
X-MC-Unique: ZqsrlCcNPJ68_GWr7-_hXg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767edbf73cbso110790885a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677981; x=1690282781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LJtquyTxvI13pU6MFUwaqbon9SOflLb0YCrw2Fb03I=;
        b=FQ39zYIVILbF38LLtA/JrEh0gXC0sQBfJH70xlZIxghM2PmZsIs2M7jVv10NSbrMD7
         Y10rQUD0ynoIwyZJ/cUn+4XBYH6utktY4YVlcjWsN10lpe2KtSTkCNZYq7tBkfiLgGSm
         PKKuZryqdfHYehQUnGgOTYXYycCK4RE7Dn+LtyZ59xjtczF208S1dp7bvbOSWEacQMOL
         yRj1B9p1hX68tg7elI47rbVQKC6AuB54rrehzkAl83wJ3oE4DGkuXw/TlYI7UwOJWIP5
         Mo5ggd4tFGXFax+4gf9fRtIIkVINWmuMeHIPYzKcC4uLMsqUPVVPSSAOoIA+H90qhan/
         hadw==
X-Gm-Message-State: ABy/qLYcLSyoKPhbUJm0wsWNguwkFpx+6fqkQ/jlfxF39iln46FDXPXp
	RV+bhT/b05DtFL+Kvl6kFvnYn/RJxjlpZuroF07C2ytuUETFGApbXrl2LDsgmN6VLAHVwHfYP+t
	JyuH+22AniaHv6P3dvivV+jAz
X-Received: by 2002:a05:620a:29cc:b0:767:f2e7:47c0 with SMTP id s12-20020a05620a29cc00b00767f2e747c0mr13801583qkp.1.1689677981627;
        Tue, 18 Jul 2023 03:59:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHaWbmtgr3kD2KEOLEey3ZLpqvLoUgmS/YsvVYCMRl1p1bCJcAotZPbA4wnQc+q2bC8iP/GIQ==
X-Received: by 2002:a05:620a:29cc:b0:767:f2e7:47c0 with SMTP id s12-20020a05620a29cc00b00767f2e747c0mr13801571qkp.1.1689677981309;
        Tue, 18 Jul 2023 03:59:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id i19-20020ae9ee13000000b00767d00d10e9sm498503qkg.58.2023.07.18.03.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:59:40 -0700 (PDT)
Message-ID: <0df7419db6799e0ea9b896a52ae4a6c85ca34b20.camel@redhat.com>
Subject: Re: [PATCH net-next v2] rtnetlink: Move nesting cancellation
 rollback to proper function
From: Paolo Abeni <pabeni@redhat.com>
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski
	 <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman
	 <simon.horman@corigine.com>
Date: Tue, 18 Jul 2023 12:59:37 +0200
In-Reply-To: <20230716072440.2372567-1-gal@nvidia.com>
References: <20230716072440.2372567-1-gal@nvidia.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Sun, 2023-07-16 at 10:24 +0300, Gal Pressman wrote:
> Make rtnl_fill_vf() cancel the vfinfo attribute on error instead of the
> inner rtnl_fill_vfinfo(), as it is the function that starts it.
>=20
> Signed-off-by: Gal Pressman <gal@nvidia.com>

This looks like -net material to me (except for the missing fixes tag).
Any special reason to target net-next?=20

Thanks!

Paolo


