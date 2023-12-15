Return-Path: <netdev+bounces-57880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F995814630
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF351C2257A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB31C2BD;
	Fri, 15 Dec 2023 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9l314U9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AB1C28F
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702638421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SBrpdDFNUNV9rPT9NLwnq0LGAxyDiW4IAOIo/k6GdI=;
	b=d9l314U9R3CIClmwWSBpsbeIW3OA6+YWunDiJLeiHn/n2AR59D7080W+d50KyrK4yYRkSw
	scKBOmz6l5LB9QzWTofH4G7xTECnBTX0Twc4TYCW0Zdk6rPqGi5Hcfk1oNlrDbhDiyX8/b
	vf1aBbpYe7l1F0oD8+kTUtMbTAK17do=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2qIOFF6xNhCoSsapn7XPLg-1; Fri, 15 Dec 2023 06:06:58 -0500
X-MC-Unique: 2qIOFF6xNhCoSsapn7XPLg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1d3a7dbb81so12430266b.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638417; x=1703243217;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SBrpdDFNUNV9rPT9NLwnq0LGAxyDiW4IAOIo/k6GdI=;
        b=FS8Zn2SbrbE8mDvDtgWSAj/fwija7a37zuBVc3hdoJchOHQX/yjcBLBWIMtBTaVuq4
         id1hfn0Vq/v/CsiOJmQ8hIBsmDcvr/Y53NpHRxxleZsDOGFhjpstzvKPKHIFMliFg072
         9sQVRDIMRz96ZUGNm23mOL9vuQq5ZEBuL47vWEjhLvwqyRoJY7L/qaHIt5cLHliJHdbk
         8oIihXPc8T+D5Zz8s8dMPJGF2fuWbpzt65trp32E4GVay6vOMWHsJG3kivxH3GbXJupN
         qWbbTlErAE0K0KfIQj2kgM7sj2QSnQ6k9Z+dpn10549IpoVowY0W1IPNzY+SnZzIZAlf
         9rLw==
X-Gm-Message-State: AOJu0Yykkhky/2GJ5/h29EjUlOPz5qz6NGyr/xYXN9AI2BW/8a5YFjsH
	fr64Cyy8s7mGHcKa2yZg3DBLUkDkoAh5ZOgNk5B24YjJWL7I/aN76zFO7/xVZazMnPqZo3qwbSo
	QE9YNLegtuCBGHcEW
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr13400113ejc.7.1702638416821;
        Fri, 15 Dec 2023 03:06:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqpkcw+CXAIe9OcjU9a+jALwDiPC7w1Lq9B7//FnjoXl2yypFOCqn4E0ZWOM64gx9WBsXmQw==
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr13400093ejc.7.1702638416441;
        Fri, 15 Dec 2023 03:06:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-255-162.dyn.eolo.it. [146.241.255.162])
        by smtp.gmail.com with ESMTPSA id st10-20020a170907c08a00b00a1cd0794696sm10590739ejc.53.2023.12.15.03.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:06:55 -0800 (PST)
Message-ID: <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, 
 intel-wired-lan@lists.osuosl.org, qi.z.zhang@intel.com, Wenjun Wu
 <wenjun1.wu@intel.com>, maxtram95@gmail.com, "Chittim, Madhu"
 <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>,  Simon Horman <simon.horman@redhat.com>
Date: Fri, 15 Dec 2023 12:06:52 +0100
In-Reply-To: <20231214174604.1ca4c30d@kernel.org>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	 <20230822034003.31628-1-wenjun1.wu@intel.com> <ZORRzEBcUDEjMniz@nanopsycho>
	 <20230822081255.7a36fa4d@kernel.org> <ZOTVkXWCLY88YfjV@nanopsycho>
	 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	 <ZOcBEt59zHW9qHhT@nanopsycho>
	 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
	 <20231118084843.70c344d9@kernel.org>
	 <3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
	 <20231122192201.245a0797@kernel.org>
	 <e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
	 <20231127174329.6dffea07@kernel.org>
	 <55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
	 <20231214174604.1ca4c30d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 17:46 -0800, Jakub Kicinski wrote:
> On Thu, 14 Dec 2023 21:29:51 +0100 Paolo Abeni wrote:
> > Together with Simon, I spent some time on the above. We think the
> > ndo_setup_tc(TC_SETUP_QDISC_TBF) hook could be used as common basis for
> > this offloads, with some small extensions (adding a 'max_rate' param,
> > too).
>=20
> uAPI aside, why would we use ndo_setup_tc(TC_SETUP_QDISC_TBF)
> to implement common basis?
>=20
> Is it not cleaner to have a separate driver API, with its ops
> and capabilities?

We understand one of the end goal is consolidating the existing rate-
related in kernel interfaces.  Adding a new one does not feel a good
starting to reach that goal, see [1] & [2] ;). ndo_setup_tc() feels
like the natural choice for H/W offload and TBF is the existing
interface IMHO nearest to the requirements here.

The devlink rate API could be a possible alternative...

> > The idea would be:
> > - 'fixing' sch_btf so that the s/w path became a no-op when h/w offload
> > is enabled
> > - extend sch_btf to support max rate
> > - do the relevant ice implementation
> > - ndo_set_tx_maxrate could be replaced with the mentioned ndo call (the
> > latter interface is a strict super-set of former)
> > - ndo_set_vf_rate could also be replaced with the mentioned ndo call
> > (with another small extension to the offload data)
> >=20
> > I think mqprio deserves it's own separate offload interface, as it
> > covers multiple tasks other than shaping (grouping queues and mapping
> > priority to classes)
> >=20
> > In the long run we could have a generic implementation of the
> > ndo_setup_tc(TC_SETUP_QDISC_TBF) in term of devlink rate adding a
> > generic way to fetch the devlink_port instance corresponding to the
> > given netdev and mapping the TBF features to the devlink_rate API.
> >=20
> > Not starting this due to what Jiri mentioned [1].
>=20
> Jiri, AFAIU, is against using devlink rate *uAPI* to configure network
> rate limiting. That's separate from the internal representation.

... with a couples of caveats:

1) AFAICS devlink (and/or devlink_port) does not have fine grained, per
queue representation and intel want to be able to configure shaping on
per queue basis. I think/hope we don't want to bring the discussion to
extending the devlink interface with queue support, I fear that will
block us for a long time. Perhaps I=E2=80=99m missing or misunderstanding
something here. Otherwise in retrospect this looks like a reasonable
point to completely avoid devlink here.

2) My understanding of Jiri statement was more restrictive. @Jiri it
would great if could share your genuine interpretation: are you ok with
using the devlink_port rate API as a basis to replace
ndo_set_tx_maxrate() (via dev->devlink_port->devlink->) and possibly
ndo_set_vf_rate(). Note the given the previous point, this option would
still feel problematic.

Cheers,

Paolo

[1] https://xkcd.com/927/
[2] https://www.youtube.com/watch?v=3Df8kO_L-pDwo


