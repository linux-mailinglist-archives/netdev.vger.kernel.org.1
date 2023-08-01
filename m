Return-Path: <netdev+bounces-23115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ACA76B005
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57280281342
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229C200A8;
	Tue,  1 Aug 2023 09:56:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FCE545
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:56:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541CFF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690883767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7AkGxgIekr3B/Xi9Hc4bEe4bhUAkjtnittxm2HngSE=;
	b=cv+i9AARV6snyvLmgjn+dlOpXFR882dAom1+tlt9kBpyLf9zSniZmiKBYR0xIJt2sMTJdA
	L4hLZ4jzF157ZqhY7lJOaSG/nuMw1piy+OUfeuEbnDC4eaBtwL8t4peH3JFq2eVGmg8gw6
	U93vHUA3SbodqC/bLnxx+EgCxJTfKgQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-FoqGgjpWPA-0RGADyPdCkg-1; Tue, 01 Aug 2023 05:56:06 -0400
X-MC-Unique: FoqGgjpWPA-0RGADyPdCkg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4054266d0beso13004121cf.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 02:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690883765; x=1691488565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7AkGxgIekr3B/Xi9Hc4bEe4bhUAkjtnittxm2HngSE=;
        b=b1pguRmrLVi6CzWAm5dOOdMSK7Zk9fcRqgAgHyjoE8TxdW6CFbmSVxmuU1ym9u3V8G
         UT6a37iaQhhtE08eXNTndXZYq+Y3aYqHGbr7x+RP7vV7QqTggr8GZJHpeqRf6tbc8e1/
         3GfxDMhQ+Y80Xu/uelg0wMxVXITtjvbYtXF2ftvEMtMw8lgXLG2jbOII42N4w4hP7yU+
         ryVpY4B0h4S0Bz0REeAnTVWtdFIdtcLMxJ815h3UsKSF4VfwjwhPYtHr3DMzKMTrLYiO
         sCyQHr+CihoSbcylo04N/sS1FesUhNStfxCgV+PH8ebcZQOTDu1nLRF2Sui5htONPCaS
         555A==
X-Gm-Message-State: ABy/qLaOLKYhPEdIM7qllD+lYL48EPZ9SLVLhIQjVFpgP9XCysQ0od+k
	m7ZQmwm2LpiqRnZPgwZo1nirrbE4UKDuWzntBXUqCMTYbuIbBrHfx8nHzrsaWxKYpFzBlY/0yxl
	c67E0V+l7aYBKGaJ4
X-Received: by 2002:ac8:5c07:0:b0:403:b188:36cd with SMTP id i7-20020ac85c07000000b00403b18836cdmr11770888qti.4.1690883765717;
        Tue, 01 Aug 2023 02:56:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3mDdRhwHGpGL1fZoVRLPyUi/+W8E46m2xqPCD2b5T8XZugpLGxPspt36Xhsk80UGCrYdcAw==
X-Received: by 2002:ac8:5c07:0:b0:403:b188:36cd with SMTP id i7-20020ac85c07000000b00403b18836cdmr11770870qti.4.1690883765409;
        Tue, 01 Aug 2023 02:56:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-251.dyn.eolo.it. [146.241.225.251])
        by smtp.gmail.com with ESMTPSA id g11-20020ac842cb000000b003f38aabb88asm869114qtm.20.2023.08.01.02.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:56:05 -0700 (PDT)
Message-ID: <256143aea3ba443d5496045158e6529923d0d44b.camel@redhat.com>
Subject: Re: [PATCH net-next,v4] bonding: support balance-alb with
 openvswitch
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Kowalski <mko@redhat.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Cc: Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>
Date: Tue, 01 Aug 2023 11:56:02 +0200
In-Reply-To: <d191a2a0-cbaf-df3a-0b5c-04d98788a4f3@redhat.com>
References: <96a1ab09-7799-6b1f-1514-f56234d5ade7@redhat.com>
	 <18961.1690757506@famine> <d191a2a0-cbaf-df3a-0b5c-04d98788a4f3@redhat.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-31 at 22:21 +0200, Mat Kowalski wrote:
>=20
> On 31/07/2023 00:51, Jay Vosburgh wrote:
> > Mat Kowalski <mko@redhat.com> wrote:
> >=20
> > > Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
> > > vlan to bridge") introduced a support for balance-alb mode for
> > > interfaces connected to the linux bridge by fixing missing matching o=
f
> > > MAC entry in FDB. In our testing we discovered that it still does not
> > > work when the bond is connected to the OVS bridge as show in diagram
> > > below:
> > >=20
> > > eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_ma=
c)
> > >                         |
> > >                       bond0.150(mac:eth0_mac)
> > >                         |
> > >                       ovs_bridge(ip:bridge_ip,mac:eth0_mac)
> > >=20
> > > This patch fixes it by checking not only if the device is a bridge bu=
t
> > > also if it is an openvswitch.
> >=20
> > 	What changed between v3 and v4?
> >=20
> > 	-J
>=20
> v4 changes:
> - Fix additional space at the beginning of the line
>=20
> v3 changes:
> - Fix tab chars converted to spaces
>=20
> v2 changes:
> - Fix line wrapping

Note that you should wait at least 24h before submitting a new version:

https://elixir.bootlin.com/linux/v6.5-rc4/source/Documentation/process/main=
tainer-netdev.rst#L350

3 new revisions in a raw is really not a good thing.

The used email address and the SoB mismatch. You should fix that either
changing the SoB or adding a suitable From: tag.

Please include the changelog in the next revision, after the SoB tag
and a '---' separator.

Cheers,

Paolo


