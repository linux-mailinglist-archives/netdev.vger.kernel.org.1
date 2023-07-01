Return-Path: <netdev+bounces-14959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD580744976
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF97E1C208D1
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE88BE65;
	Sat,  1 Jul 2023 13:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EABA35
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 13:51:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6CB3C0B
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688219495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxhZ/1EAsGn/VKuMZdxrD8EcmuqfUPJ5IAs/ohFMG1k=;
	b=NpCeef+Ikw04fjZJd4foeWr+HyRVxX443CtjlD/7jn3bi22fpZdQ54PlmphmBqrRceJByC
	DRNqTrFBshvvsEgXolpFmgpHzs0duPypttNzqnrq/pljSD1sKimaZZ1c/X6S5S+RHqohOV
	NQgeYZ/P9AaKbW+K+ExS6NV8KP/8XAA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-PTlwe15kMvaaGsrNqh7DVA-1; Sat, 01 Jul 2023 09:51:33 -0400
X-MC-Unique: PTlwe15kMvaaGsrNqh7DVA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-988643252e0so199252166b.2
        for <netdev@vger.kernel.org>; Sat, 01 Jul 2023 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688219492; x=1690811492;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxhZ/1EAsGn/VKuMZdxrD8EcmuqfUPJ5IAs/ohFMG1k=;
        b=RX/5g86SJ81KHJquex/TgZdUpnaxjpkktCsJG0DORKN8yTUmp6rYOZifX8yPQqIfTS
         5W7pfMqkhqXHcCGYV1tU3zfwgatWmunx2SjnJI93wwg8H9bw75Cx2bEm/R6rtAz7PJ+y
         nE8wFD38/qBGkwmW2j8GtZY1kL1w+MGwtAYf36NwBdoBGU+lxOQkT3kj5hOzOjD8XU+v
         uo6EfJBEx2NMNO/v9EGWIIiwbqqVxMHLcdnSktlZ+l1oWpcqfxHBGT5RKmrvzC8Vw22q
         nDyWZwRukE1WQU99YIsiq6B/BnHB/Uhby1qhADILO8ZRhM13E5KjRddEn4STuAM9i1qY
         DcPA==
X-Gm-Message-State: ABy/qLaEGmim0zZ2/AZdfzVbrGd4u+wTEIZucmVIi2q7r1sFyHGctws9
	nV+ZqmnCFwmr5uQttRtvYhcxiMzvQYaxdttsc8D2LEWT0xohkdKqg+rV/+/2fMN4aN246oLGcnl
	11TfINPJn3JI68nzY
X-Received: by 2002:a17:906:811:b0:992:a618:c3c4 with SMTP id e17-20020a170906081100b00992a618c3c4mr3993790ejd.66.1688219492534;
        Sat, 01 Jul 2023 06:51:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2gY+bYCOq/0RmGNARSqCWqw6Sb29a/jvVvw0nSGDXRt1w+wtr2nwk22OmAFuhTzHHbVG6/A==
X-Received: by 2002:a17:906:811:b0:992:a618:c3c4 with SMTP id e17-20020a170906081100b00992a618c3c4mr3993772ejd.66.1688219491937;
        Sat, 01 Jul 2023 06:51:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gt12-20020a170906f20c00b00992b2c5598csm2997805ejb.128.2023.07.01.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 06:51:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 84208BC093A; Sat,  1 Jul 2023 15:51:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <ZJ8YLASfbw97mUZf@boxer>
References: <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk> <ZJx9WkB/dfB5EFjE@boxer> <87edlvgv1t.fsf@toke.dk>
 <ZJ3pgau3icByxQxE@boxer> <87zg4idm1q.fsf@toke.dk> <ZJ8YLASfbw97mUZf@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 01 Jul 2023 15:51:30 +0200
Message-ID: <874jmneo4d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Thu, Jun 29, 2023 at 10:57:05PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>=20
>> > On Wed, Jun 28, 2023 at 11:02:06PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>> >> > index a4270fafdf11..b24244f768e3 100644
>> >> > --- a/net/core/netdev-genl.c
>> >> > +++ b/net/core/netdev-genl.c
>> >> > @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, str=
uct sk_buff *rsp,
>> >> >  		return -EMSGSIZE;
>> >> >=20=20
>> >> >  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
>> >> > +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
>> >> > +			netdev->xdp_zc_max_segs) ||
>> >>=20
>> >> Should this be omitted if the driver doesn't support zero-copy at all?
>> >
>> > This is now set independently when allocing net_device struct, so this=
 can
>> > be read without issues. Furthermore this value should not be used to f=
ind
>> > out if underlying driver supports ZC or not - let us keep using
>> > xdp_features for that.
>> >
>> > Does it make sense?
>>=20
>> Yes, I agree we shouldn't use this field for that. However, I am not
>> sure I trust all userspace applications to get that right, so I fear
>> some will end up looking at the field even when the flag is not set,
>> which will lead to confused users. So why not just omit the property
>> entirely when the flag is not set? :)
>
> I think that if you would read anything different than default 1 from this
> field and your driver does not zupport even ZC then your driver is wrong.
> It's like reporting something via xdp_features and not supporting it. You
> only overwrite this within your driver *if* you support ZC multi-buffer.
>
> OTOH were you referring to omitting putting the u32 to netlink response at
> all?

Yes, the latter. I have no objection to the internal field being set to
1 by default or anything, I just think we should omit the netlink
attribute when it doesn't have a meaningful value, to avoid confusion -
being able to do that is one of the nice properties of netlink, after all :)

-Toke


