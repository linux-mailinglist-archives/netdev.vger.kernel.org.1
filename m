Return-Path: <netdev+bounces-32787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E068E79A6FD
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932C22812FA
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2FFC136;
	Mon, 11 Sep 2023 09:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF75C132
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:50:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F020D116
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694425827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvvs3L+YQhSnM6g4jEesta8gQsZpAYgapPFcdB0bA6A=;
	b=dWesttrC5STChuE6gqXk0S8X0UvCLBxIT5al2UF0eQa4nzugc8CE/ps1/+6Uffg4hJL0//
	AoP/ukgdMsRNSS2mvRXd8tBil6pzl2F0iatuVt7INLTSqzKCXHAyFdHH5EP5tScl/7Dg1Q
	e/g3qX6jAsw1GlQFiMhvvAwyZk/VEb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-vfau8d3XNBaPvdxMWV6SgA-1; Mon, 11 Sep 2023 05:50:26 -0400
X-MC-Unique: vfau8d3XNBaPvdxMWV6SgA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe12bf2db4so9185215e9.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425825; x=1695030625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvvs3L+YQhSnM6g4jEesta8gQsZpAYgapPFcdB0bA6A=;
        b=C0hCRTw8T2gxllj4AJLv8euAcTrhGR7eY85NyRtih+L0yiTekK50I3lsfm9sdWBjuq
         eiRlP4EyVOiWqUnFYR/eAGlOYVPc9SlD8HGBSLa+m/6iEd18uV88KKXF7QhjELCOpTie
         GuQLlQCvIY3RIf6etXByAuBtl8Hpx5trKvYoWj7o46wOnf1Uw//gvor+WhOYsS0upU4i
         kPxSRaDa1xcNGxWVcnNEfFI6iXjSK9Z3BPLWusisnLWqI+3Zc1Gzd2kcjCrA4SIjMrIG
         DB3kOecV4Zxaq6bnpFRiURpjh8L1+VlN/SHSN0blxjsZ0rMsCJV7sGIuYq0g2Wc3W+zg
         W+6A==
X-Gm-Message-State: AOJu0YyH0QcYpdV+o9d/7Tvf/ayMNMH60k4cq+/ikDRe1eVEFoKGQ7fy
	IxXBRfexNKclY9eJY1pXxZwNLuGee435eX0tXF4wLBZYoUSeXFTPjyZ1MpHqUKCRXqR3TWnDAh4
	goyHtsl497Uwpa/+v
X-Received: by 2002:a05:600c:3b8f:b0:3ff:c342:f296 with SMTP id n15-20020a05600c3b8f00b003ffc342f296mr8238002wms.1.1694425825448;
        Mon, 11 Sep 2023 02:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBeOZ35XpuzFuUBK6VoaF0Oo8aJDmM+299WC/TiEV7fK4aIdViKEJ3xbsCi/4Vj/ufqR32xg==
X-Received: by 2002:a05:600c:3b8f:b0:3ff:c342:f296 with SMTP id n15-20020a05600c3b8f00b003ffc342f296mr8237995wms.1.1694425825114;
        Mon, 11 Sep 2023 02:50:25 -0700 (PDT)
Received: from [10.0.0.196] ([37.186.167.86])
        by smtp.gmail.com with ESMTPSA id l12-20020a7bc44c000000b003fe61c33df5sm12767494wmi.3.2023.09.11.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:50:24 -0700 (PDT)
Message-ID: <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
From: Thomas Haller <thaller@redhat.com>
To: Benjamin Poirier <bpoirier@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: nicolas.dichtel@6wind.com, Stephen Hemminger
 <stephen@networkplumber.org>,  Hangbin Liu <liuhangbin@gmail.com>, Ido
 Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Date: Mon, 11 Sep 2023 11:50:23 +0200
In-Reply-To: <ZNKQdLAXgfVQxtxP@d3>
References: <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
	 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
	 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
	 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
	 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
	 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
	 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-08-08 at 14:59 -0400, Benjamin Poirier wrote:
> On 2023-08-07 19:44 -0600, David Ahern wrote:
> > On 8/2/23 3:10 AM, Thomas Haller wrote:
> > > On Fri, 2023-07-28 at 09:42 -0600, David Ahern wrote:
> > > > On 7/28/23 7:01 AM, Nicolas Dichtel wrote:
> > > >=20
> > > > > Managing a cache with this is not so obvious =F0=9F=98=89
> > > >=20
> > > >=20
> > > > FRR works well with Linux at this point,=C2=A0
> > >=20
> > > Interesting. Do you have a bit more information?
> > >=20
> > > > and libnl's caching was updated
> > > > ad fixed by folks from Cumulus Networks so it should be a good
> > > > too.
> > >=20
> > >=20
> > > Which "libnl" do you mean?
> >=20
> > yes. https://github.com/thom311/libnl.git
> >=20
> > >=20
> > > Route caching in libnl3 upstream is very broken (which I am to
> > > blame
> > > for, as I am the maintainer).
> > >=20
> >=20
> > as someone who sent in patches it worked for all of Cumulus' uses
> > cases
> > around 2018-2019 time frame. Can't speak for the status today.
> >=20
>=20
> Nowadays Cumulus still relies on an OOT kernel patch almost identical
> to
> Hangbin's.
>=20
> Looking through an old ticket on the subject, I can see you had
> indeed
> prepared patches to make Cumulus' libnl-using application (switchd)
> delete route entries from the libnl cache based on link down events.
> Ultimately, those changes were left on the table for two reasons:
> 1) This would've been the first time for Cumulus that the libnl cache
> would be modified by the application instead of in response to
> netlink
> events. Roopa was concerned that there might be race conditions.
> 2) There was an expectation at the time that Cumulus would move to
> switchdev, which would've made switchd and libnl unnecessary.
>=20
> I brought up the removal of this OOT kernel patch again a few months
> ago
> but there was not enough interest internally. In fact, I was just
> asked
> to add *more* notifications for a similar case, sigh.


Hi,

Those patches were sent to me directly, and never hit the mailing list
(due to technical problems with the list). More importantly, the
changes were complicated, combined with having no tests. I hesitated to
merge them. Nowadays, the unit test setup for libnl3 improved, and it
would be great to fix this.

This is all entirely my fault as maintainer, but two points:

- libnl3 upstream still does *not* handle route caching correctly (at
all).

- the fact that it isn't fixed in more than a decade, shows IMO that
getting caching right for routes is very hard. Patches that improve the
behavior should not be rejected with "look at libnl3 or FRR".


If FRR gets this right, it's honestly an impressive accomplishment. I'd
still be curious about the details.


Thomas


