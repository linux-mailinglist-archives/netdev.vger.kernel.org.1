Return-Path: <netdev+bounces-18503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7A757624
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A473280F07
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21086A941;
	Tue, 18 Jul 2023 08:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143206D24
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:02:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311101BE2
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689667293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGgKzTR9YoRtBqm+b+SCdEpyJqviblA3DLX1usMPJ1k=;
	b=d6UU9cTKl4y/IbHeHtZegR88MN7zYpTHI/gGHe23LvgZ1vYhnQRQcXZILrGFYqnjfnz5sB
	NCltF94gXOg5d2Ldx0A/n6PapKKuK336xyj9U8HmruHU900TKt7FyvNKD4c1ylJxZP/k2W
	ZAXgeSyqItGUfeMT+X0e1EFHygu9hjY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-gYGZbBjRPmun84pwNPUUIA-1; Tue, 18 Jul 2023 04:01:32 -0400
X-MC-Unique: gYGZbBjRPmun84pwNPUUIA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-401df9d2dc4so12644801cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 01:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667291; x=1692259291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGgKzTR9YoRtBqm+b+SCdEpyJqviblA3DLX1usMPJ1k=;
        b=StX4zzvVFycs9cmnHmeTPqfcwTKEhvn3j5Xd7g+O4roJeq2FeRRQkH6yI3NzeC7a+s
         kgGerfp1mqGYQ1gLrFRLyahyNkEmFiGEmYIrl8Xib51XNZA7vsnp4wt0UsdIsRXQ41GH
         MKeuGU2UYyooN1JD4M1TAwBoS0F6s+KYMXl/NprA/ygHjkMx5yaRAqDRnsbdoy+kKY+G
         9GT+2YFSlesu3zLNxchTwRS878u+e3GaudNwdifEjo76gs+9x0JWY5RGdtgsVqE8PHb8
         lonwccWio9wfgRGVwxzu/ucAmpMYceg+U1X12ZhbDDxnyyrK7h9qDR0+Vnq3Cz78DiE/
         ZWAA==
X-Gm-Message-State: ABy/qLYJewerOiia5T6xSWrmcBdiIYDcwjQE86Ypq4DLwq6lpw5nIzfx
	PUUDLwtxrOL2QmTXgd79v59mrwfcjWq9iFAU+JPFi7LHtd3fSjAjN6XIhjHhF2Jj+JEbQeH50nq
	AUCY5lxBBiyvaIQDV
X-Received: by 2002:ac8:57d2:0:b0:400:84a9:a09c with SMTP id w18-20020ac857d2000000b0040084a9a09cmr11679221qta.6.1689667290880;
        Tue, 18 Jul 2023 01:01:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNwEG9+jDHMCVumg/HFSb01jOLXCaaIurYPdPExZ6lzBRK/NSh84ieV6FAlAZvd/8hu35kKw==
X-Received: by 2002:ac8:57d2:0:b0:400:84a9:a09c with SMTP id w18-20020ac857d2000000b0040084a9a09cmr11679202qta.6.1689667290658;
        Tue, 18 Jul 2023 01:01:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8474a000000b004033c3948f9sm489477qtp.42.2023.07.18.01.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:01:30 -0700 (PDT)
Message-ID: <33950173db97ff49475551cd53ae287be895a6be.camel@redhat.com>
Subject: Re: [PATCHv2 net 2/2] team: reset team's flags when down link is
 P2P device
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Liang Li <liali@redhat.com>, Jiri Pirko
 <jiri@nvidia.com>,  Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 18 Jul 2023 10:01:27 +0200
In-Reply-To: <20230714081340.2064472-3-liuhangbin@gmail.com>
References: <20230714081340.2064472-1-liuhangbin@gmail.com>
	 <20230714081340.2064472-3-liuhangbin@gmail.com>
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

On Fri, 2023-07-14 at 16:13 +0800, Hangbin Liu wrote:
> When adding a point to point downlink to team device, we neglected to res=
et
> the team's flags, which were still using flags like BROADCAST and
> MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
> interfaces, such as when adding a GRE device to team device.
>=20
> Fix this by remove multicast/broadcast flags and add p2p and noarp flags.
>=20
> Reported-by: Liang Li <liali@redhat.com>
> Links: https://bugzilla.redhat.com/show_bug.cgi?id=3D2221438
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 555b0b1e9a78..9104e373c8cb 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2135,6 +2135,11 @@ static void team_setup_by_port(struct net_device *=
dev,
>  	dev->mtu =3D port_dev->mtu;
>  	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>  	eth_hw_addr_inherit(dev, port_dev);
> +
> +	if (port_dev->flags & IFF_POINTOPOINT) {
> +		dev->flags &=3D ~(IFF_BROADCAST | IFF_MULTICAST);
> +		dev->flags |=3D (IFF_POINTOPOINT | IFF_NOARP);
> +	}

It's unclear to me what happens with the following sequence of events:

* p2p dev is enslaved to team (IFF_BROADCAST cleared)
* p2p dev is removed from team
* plain ether device is enslaved to team.

I don't see where/when IFF_BROADCAST is set again. Could you please
point it out?

Thanks!

Paolo


