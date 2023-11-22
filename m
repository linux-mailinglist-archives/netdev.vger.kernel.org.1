Return-Path: <netdev+bounces-50168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3C7F4C19
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C7AB20D96
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB294E62A;
	Wed, 22 Nov 2023 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzYIL4xd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18BA2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700669791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKZ3++moq0dieX7sidFav8qb9CISSo3s6DWdpC452H4=;
	b=UzYIL4xdN1U9XpyrpXEfqbrNFG9EAgZUhMXY2P33cvDVbkkzXVdpKwJ40vVpbxNu90lPI8
	B2ugHe2FXq8cjrr/w5yz/NgXE3REyhMEIuvtrlW9SPjPngyP+a3/4AN4QKv5NUBxh90tPx
	WE5A9miD/S8rYcako2UkH+oqoPozjNo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Ny0jfcYAME2_bqxK1UJ_Mg-1; Wed, 22 Nov 2023 11:16:29 -0500
X-MC-Unique: Ny0jfcYAME2_bqxK1UJ_Mg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a02344944f5so22489666b.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669788; x=1701274588;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKZ3++moq0dieX7sidFav8qb9CISSo3s6DWdpC452H4=;
        b=fOjA3DvBS+B4kY2jvHFi5mWKE42iQWyCA6NsJ0Vrk/9DhLzYiICOYgBeryWNCIjYLD
         +oHHbgycZ2BbPLdVvZRxoRKwbruo3AE1sW3yE+xwE8F4h1aglxYXNRrG/TIyEUFbAqEA
         2P1YyHNVZiH3PNovVC0l+ssJI8ZTdSe5KG3Nf4Dhq3xMNTJ5icyGxrApeZSxdNUbFip+
         rrhrEmRcyZPQ5arjwBwTFcluGqWBwRQlHLkWD7rgU5N4/LLr7N1nUXjFxyY2jYVGutDv
         L0hc5Tuj3/Jx1kdIDUD2OQ7GjRu3S5SStPiWC3PvRZYQ/+z+mKGuiq0FHAU7hKcRrWL9
         ZtVA==
X-Gm-Message-State: AOJu0YyHlvg6nRtyilSS0WjVLdVWoD/haQiGPG1Lnpfsz+27rRlc+YeW
	naWHeuKlvysOCSOFwlHovZ20MFI3GOW3HJIjEBeL4TYTjj7zoZvDS7o5n6XvOaMyG1tUYTfFyz7
	Afbr4qYInYIAbJ27S
X-Received: by 2002:a17:906:224d:b0:a00:1d05:e28d with SMTP id 13-20020a170906224d00b00a001d05e28dmr2094822ejr.5.1700669788286;
        Wed, 22 Nov 2023 08:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvANlGP37PeBW2H5M/oy2vkE4tzc1hqFrhhiPwsjqL4fSWCeCr0fNv/TDqb7GLqJlQkiMlrw==
X-Received: by 2002:a17:906:224d:b0:a00:1d05:e28d with SMTP id 13-20020a170906224d00b00a001d05e28dmr2094805ejr.5.1700669787962;
        Wed, 22 Nov 2023 08:16:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-248-230.dyn.eolo.it. [146.241.248.230])
        by smtp.gmail.com with ESMTPSA id gq16-20020a170906e25000b009fca9484a62sm4654819ejb.200.2023.11.22.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:16:27 -0800 (PST)
Message-ID: <f5b7507a4f3f4bff91a92d653762adc0fca33ff3.camel@redhat.com>
Subject: Re: [PATCH net-next,v5] bonding: return -ENOMEM instead of BUG in
 alb_upper_dev_walk
From: Paolo Abeni <pabeni@redhat.com>
To: shaozhengchao <shaozhengchao@huawei.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Date: Wed, 22 Nov 2023 17:16:26 +0100
In-Reply-To: <8fc84e79-f5c9-8fbe-1fe8-b23b059f03d0@huawei.com>
References: <20231121125805.949940-1-shaozhengchao@huawei.com>
	 <8fc84e79-f5c9-8fbe-1fe8-b23b059f03d0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 10:04 +0800, shaozhengchao wrote:
>=20
> On 2023/11/21 20:58, Zhengchao Shao wrote:
> > If failed to allocate "tags" or could not find the final upper device f=
rom
> > start_dev's upper list in bond_verify_device_path(), only the loopback
> > detection of the current upper device should be affected, and the syste=
m is
> > no need to be panic.
> > So just return -ENOMEM in alb_upper_dev_walk to stop walking.
> >=20
> > I also think that the following function calls
> > netdev_walk_all_upper_dev_rcu
> > ---->>>alb_upper_dev_walk
> > ---------->>>bond_verify_device_path
> > > From this way, "end device" can eventually be obtained from "start de=
vice"
> > in bond_verify_device_path, IS_ERR(tags) could be instead of
> > IS_ERR_OR_NULL(tags) in alb_upper_dev_walk.
> >=20
> > Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> > Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
> > ---
> > v5: drop print information, if the memory allocation fails, the mm laye=
r
> >      will emit a lot warning comprising the backtrace
> > v4: print information instead of warn
> > v3: return -ENOMEM instead of zero to stop walk
> > v2: use WARN_ON_ONCE instead of WARN_ON
> > ---
> >   drivers/net/bonding/bond_alb.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_=
alb.c
> > index dc2c7b979656..7edf0fd58c34 100644
> > --- a/drivers/net/bonding/bond_alb.c
> > +++ b/drivers/net/bonding/bond_alb.c
> > @@ -985,7 +985,8 @@ static int alb_upper_dev_walk(struct net_device *up=
per,
> >   	if (netif_is_macvlan(upper) && !strict_match) {
> >   		tags =3D bond_verify_device_path(bond->dev, upper, 0);
> >   		if (IS_ERR_OR_NULL(tags))
> > -			BUG();
> > +			return -ENOMEM;
> > +
> >   		alb_send_lp_vid(slave, upper->dev_addr,
> >   				tags[0].vlan_proto, tags[0].vlan_id);
> >   		kfree(tags);
> Hi Paolo:
> 	I find that v4 has been merged into net-next.=C2=A0

I'm sorry, that was due to PEBKAC here.

> So v5 is not
> needed. But should I send another patch to drop that print info?

Yes please, send a follow-up just dropping the print.

Thanks!

Paolo



