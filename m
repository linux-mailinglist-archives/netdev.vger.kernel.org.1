Return-Path: <netdev+bounces-14671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9F742F22
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 22:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CAE280EF5
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF8CF9F0;
	Thu, 29 Jun 2023 20:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FCF846B
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:57:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51614194
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688072230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sdKAVBvrdTlXSRJ5Gzip6C4quTmo3/FhLIwtVCecIjM=;
	b=U07dS7ydzzmbLZSr+jZ/2ndpdb3q0RrXTi3nmlNj9BDvF8sg2MhN7q9rHeHoiXkr7iluT0
	sY7Kk1TIuOzFl9eU0Lw2MSI/qRtbbVBA0Gj9pnhDQ4Yadd3ZxJRo1GMkZxIcuhHoEpzITK
	hK84U0S7j/X4dPQ9fr/KscU0jTF3/5k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-MhLL8TIdM2eUyT3JWqU28A-1; Thu, 29 Jun 2023 16:57:08 -0400
X-MC-Unique: MhLL8TIdM2eUyT3JWqU28A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355cf318so85301066b.2
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688072228; x=1690664228;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdKAVBvrdTlXSRJ5Gzip6C4quTmo3/FhLIwtVCecIjM=;
        b=OvTxy4Wlslb/c/afK5CbYUdX6av1DjCX75XnvTjtHMApO2u9WGSzctULAeBpMn7ljA
         iMNMwlmTxpHoQQFt19YXzLf+7BQQOlKkYH1W1pz0JnGJoyJEPUqiNeDj+zjkvl4RzBIt
         71l2lp984TLKDwU3Wjf9aJjOcpHAjjDpxwO7sYOUFVr9JB3+7vhMx4QYMXs25VX3ej2m
         yYiPNpjVhuvzlT9R9xlSeg9rs3IYDuJ11YGhHhyZ7hsbFljR2h+3AbvZwOZHFgFvftVT
         RxstQFfIYG3y/SAetyOSjwmZfPcYw4WBleLPSLg20bCWLnU+S+DXyDgMKwXvLxReSYPF
         ZMwA==
X-Gm-Message-State: ABy/qLZX9F4eeaeFyHXmmyIaNeI4Pmtcb0UH2Y/RJzg3QDUl2gMpKY9Q
	/ifRadtxH4lUgRyJk6d0gbae9Mer2taqNKnTiCoLupqNsL8FR7RC7wfl403MzKtSocKpzYcL/0U
	zLCH7CrK64cLCTWb0
X-Received: by 2002:a17:906:4d46:b0:992:48b7:99e1 with SMTP id b6-20020a1709064d4600b0099248b799e1mr368066ejv.47.1688072227714;
        Thu, 29 Jun 2023 13:57:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEhd4w0+lvCVJ0pwJ2Ij4PVBzkjDwTpI3LE28LuFoCOb5qTNE9/3xsvxzDo+KQ4/O1RTsTjvg==
X-Received: by 2002:a17:906:4d46:b0:992:48b7:99e1 with SMTP id b6-20020a1709064d4600b0099248b799e1mr368055ejv.47.1688072227141;
        Thu, 29 Jun 2023 13:57:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170906c34800b009888aa1da11sm7165217ejb.188.2023.06.29.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:57:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA3A7BC04EB; Thu, 29 Jun 2023 22:57:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, bjorn@kernel.org, tirthendu.sarkar@intel.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
In-Reply-To: <ZJ3pgau3icByxQxE@boxer>
References: <20230615172606.349557-16-maciej.fijalkowski@intel.com>
 <87zg4uca21.fsf@toke.dk>
 <CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
 <87o7l9c58j.fsf@toke.dk>
 <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
 <20230621133424.0294f2a3@kernel.org>
 <CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
 <875y7flq8w.fsf@toke.dk> <ZJx9WkB/dfB5EFjE@boxer> <87edlvgv1t.fsf@toke.dk>
 <ZJ3pgau3icByxQxE@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 22:57:05 +0200
Message-ID: <87zg4idm1q.fsf@toke.dk>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Wed, Jun 28, 2023 at 11:02:06PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>> > index a4270fafdf11..b24244f768e3 100644
>> > --- a/net/core/netdev-genl.c
>> > +++ b/net/core/netdev-genl.c
>> > @@ -19,6 +19,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct=
 sk_buff *rsp,
>> >  		return -EMSGSIZE;
>> >=20=20
>> >  	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
>> > +	    nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
>> > +			netdev->xdp_zc_max_segs) ||
>>=20
>> Should this be omitted if the driver doesn't support zero-copy at all?
>
> This is now set independently when allocing net_device struct, so this can
> be read without issues. Furthermore this value should not be used to find
> out if underlying driver supports ZC or not - let us keep using
> xdp_features for that.
>
> Does it make sense?

Yes, I agree we shouldn't use this field for that. However, I am not
sure I trust all userspace applications to get that right, so I fear
some will end up looking at the field even when the flag is not set,
which will lead to confused users. So why not just omit the property
entirely when the flag is not set? :)

-Toke


