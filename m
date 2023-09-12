Return-Path: <netdev+bounces-33327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E979D6A3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5707281BCB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10781800;
	Tue, 12 Sep 2023 16:43:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE38621
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:43:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1307C10E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694537007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bVHKgpISHkqCHiU3dxh57FnbAZ+iAvp3SzRx4v8ZuQ=;
	b=VPTXibZK7q+8SUvfKrfqzIgnCZ8j4VpTl8t/HcNb4HqPXxssjtZwFj8nFgXcYGcL884+74
	Gfk0TWylwMqe6xJ9sq9Vf0ZzeGJVAozH3S9PaUr76UdR/qSa9vcDgvj2w+AB0iSBn5liSu
	V2OLFUdJ66tHiq1JDanYM30NBbtPudM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-MAiJeWLaOxqCqljZmEE3zA-1; Tue, 12 Sep 2023 12:43:25 -0400
X-MC-Unique: MAiJeWLaOxqCqljZmEE3zA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b04d5ed394so15371121fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537004; x=1695141804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bVHKgpISHkqCHiU3dxh57FnbAZ+iAvp3SzRx4v8ZuQ=;
        b=wwL89Bk4A7xLGeJIFHLctld9mCistNQtwxZ000eRNDnreLNPTGHkfOqReIM3DjRVDR
         9eXTymHoptGVdIEtrW7EDVbU2dA1vUXHDCLLuAx6gY6TI9k7UsxlAq/aARAU8c8C6e6f
         q61RZpXGfJLNFXBuzG9rjo3hvXFlMVUvfOtxxhGukZQBmYDTEMn7mfVVeMQVA9HjvbLe
         NMPB5yJlVf33zFHxaUKFGF6wEHYtP7KZRnOgCBAf3M2FwlrqyN7mR9q3BzPryl/yF9xF
         /iJTz3TaDduLao6/kPnLI2nPyxPBnuKTHKOUk/4qX+W7HHm0Asv8uGtT+tEvGF9RMvQC
         Z4zg==
X-Gm-Message-State: AOJu0YyyfssfHv0HGkW248ML1lWSYT77TALFXvWqK/zp15sDdJbkUXMH
	h6auuecaPckpmmZvhf5yM3PUiEIUN2ymeiHzo8qZh7xyRRIgwsMC9tmTdrHEnAaW0S3oEBlo6dY
	bngQ7mdSzjJoGrGfV
X-Received: by 2002:a2e:b0f0:0:b0:2bf:b0d3:20f9 with SMTP id h16-20020a2eb0f0000000b002bfb0d320f9mr234014ljl.5.1694537003902;
        Tue, 12 Sep 2023 09:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN1r3UWsMGn9SrqexOOT/6c/EwRnBl0chm4B1kyRF9Ujhs+42AWdvXR2rhcIEktE5d7HuZ0w==
X-Received: by 2002:a2e:b0f0:0:b0:2bf:b0d3:20f9 with SMTP id h16-20020a2eb0f0000000b002bfb0d320f9mr234002ljl.5.1694537003512;
        Tue, 12 Sep 2023 09:43:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id jj27-20020a170907985b00b0099e12a49c8fsm7142924ejc.173.2023.09.12.09.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:43:23 -0700 (PDT)
Message-ID: <a4ebf8016d35fd7a64be65e79025a384ee4b105d.camel@redhat.com>
Subject: Re: [PATCH iwl-next v2] ice: Add support for packet mirroring using
 hardware in switchdev mode
From: Paolo Abeni <pabeni@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrii Staikov <andrii.staikov@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Date: Tue, 12 Sep 2023 18:43:22 +0200
In-Reply-To: <ad50a349-11be-36bc-fed4-94f5aab3eabd@intel.com>
References: <20230912092952.2814966-1-andrii.staikov@intel.com>
	 <0168a988486f4bff08bd186d5aea1cfe4900a2c3.camel@redhat.com>
	 <ad50a349-11be-36bc-fed4-94f5aab3eabd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 16:41 +0200, Alexander Lobakin wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Tue, 12 Sep 2023 11:56:15 +0200
>=20
> > Hi all,
> >=20
> > On Tue, 2023-09-12 at 11:29 +0200, Andrii Staikov wrote:
> > > Switchdev mode allows to add mirroring rules to mirror
> > > incoming and outgoing packets to the interface's port
> > > representor. Previously, this was available only using
> > > software functionality. Add possibility to offload this
> > > functionality to the NIC hardware.
> > >=20
> > > Introduce ICE_MIRROR_PACKET filter action to the
> > > ice_sw_fwd_act_type enum to identify the desired action
> > > and pass it to the hardware as well as the VSI to mirror.
> > >=20
> > > Example of tc mirror command using hardware:
> > > tc filter add dev ens1f0np0 ingress protocol ip prio 1 flower
> > > src_mac b4:96:91:a5:c7:a7 skip_sw action mirred egress mirror dev eth=
1
> > >=20
> > > ens1f0np0 - PF
> > > b4:96:91:a5:c7:a7 - source MAC address
> > > eth1 - PR of a VF to mirror to
> > >=20
> > > Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> >=20
> > The amount of patches that IMHO should land only into intel-specific
> > MLs and instead reaches also netdev, recently increased.
>=20
> Let's clarify what you mean by "intel-specific MLs".
> Do you mean our internal MLs and review or the open one, IWL?
>=20
> IWL is mostly rudimentary. It's open, but almost nobody outside of Intel
> sits there, which means 2/3 of patches doesn't get enough attention and
> reviews. It's used by our validation as well, but that's it.
> Our internal ML for Ethernet patches works as usually. I realize roughly
> half of all patches pass it without a Reviewed-by tag and it's something
> we're actively working on. If all goes well, no patches without a proper
> review will go outside Intel's internal Ethernet MLs.
> Now, the second part,
>=20
> >=20
> > Please try harder to apply proper constraints to your traffic, netdev
> > is already busy enough!
>=20
> Do you want us to stop CCing netdev when we send patches to the outer
> review to IWL?
> This would mean they will once again start missing enough attention from
> the outside. I hope you don't want our patches to be reviewed *only* by
> Intel folks, right? I don't feel this a good idea.
> That's why we started CCing netdev this year. And we do that when we
> send patches to IWL, i.e. outside. It's not like "ok, let's Cc netdev
> instead of going through our internal review process".
>=20
> Our clients, partners (e.g. Czech RedHat), our developers, want our
> patches to have proper complex review. Dropping netdev would mean that a
> patch of some non-corpo guy will be reviewed more carefully and at the
> end will have better quality than an Intel patch, which "shouldn't
> overburden netdev".
> Saying "we'll see them when Tony sends a PR" also doesn't work well for
> me. A patch gets taken into a PR once it passes internal review, then
> validation, this always do take a while. Imagine waiting for a month for
> your patch to be sent in a PR to get a negative review, so that you have
> to repeat this process again and wait for another month to get some more
> change requests and again :D
>=20
> In a couple months, no our patches will hit netdev without a proper
> Reviewed-by obtained during the internal review, let's not take corner
> cases and effectively hide our code from the world?
> I don't think you'd like to put a huge banner on netdev's lore saying
> "please also take a look at intel-wired-lan" :z I also don't want ppl to
> behave like Greg KH some time ago when he said "where's your damn
> internal RB, stop abusing LKML" in reply to my early RFC PoC sent only
> for an open discussion xD

I was under the impression that some patches landed on IWL cc-ing
netdev possibly unintentionally, e.g.:

https://lore.kernel.org/netdev/20230904021455.3944605-1-junfeng.guo@intel.c=
om/

My intention was to raise attention on such events.

Cheers,

Paolo


