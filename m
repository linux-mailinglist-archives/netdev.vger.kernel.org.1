Return-Path: <netdev+bounces-57654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5E813B86
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6D01F221D4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B14B6A343;
	Thu, 14 Dec 2023 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihiCPmiI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063516A34E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702585796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VeWMzNSZ2QNuDqNT7iu3DaR/0LYYsUyqA3zg/AVtiI=;
	b=ihiCPmiII0VPLrva7ZS2R9MR0Xnr6ZuXiM2c2US4QvW49Jxvq7mZeVM4/LuSsMUV8/07gX
	0warOTfxcosFw3RUI+Z4B3y0eUi96zSwXxNhm5bQjeJyxxCyYnfHzB0uGXHNMzYK+iPBAD
	Q8+ucfxh/gIsYuGlYyU6ZWYqLm7LT5I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-6Aq6Ye6tP4afAk80-sdr-Q-1; Thu, 14 Dec 2023 15:29:54 -0500
X-MC-Unique: 6Aq6Ye6tP4afAk80-sdr-Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1d3a7dbb81so135664666b.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585793; x=1703190593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VeWMzNSZ2QNuDqNT7iu3DaR/0LYYsUyqA3zg/AVtiI=;
        b=l5AuKne+oPtt9SuV+HiZDErj72NdI+he0CMVbOTfdDfJpUQppTr/qH1ZdWzbsH9u/1
         vgP0xqh3F9hXc3+5ZzGc+wNv8Id1+LlMImU6enygfSN0sR++Q+HwO1EVB3ZXpQaIX3RY
         FoIKL+n2WfGqARqUNwlrom9wm9juBVa6vHNszR3ssowrncvIgcJY0prrZXq/NpJaru0e
         VIgZrFDpgKkl42t7+waymIeUknJHq3Gcf7qhfRT3KS1pDzJqCXd73JOu9Nz4ZyAs1kO8
         xX+SWfE2NOYMzFOzUkCevjCUFoy4OPRMIaLodvo5w7efvCBJaglo9hxL2WPIlGWivxQe
         QNHw==
X-Gm-Message-State: AOJu0Ywkrfxxtlmbtr8CcOJoaA2VIICvwzpQOPwa/FAa1yIsdrW/zt5y
	BTnQKIMhBXnJ0isinYQFNHRme9W6jfJ3T2AnUEL2DpIvz2z1Ass5Hokc3KY0ygPFXEAOWiR36US
	BuT3ZTM1yMlgWAvXE
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr12287961ejc.7.1702585793655;
        Thu, 14 Dec 2023 12:29:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVB8NJENF9W5+PYVg9IhRQTIGKS5k2J1bPNOEPW/tQ/WtjWH/+1BYcrSLI5KXZKzQnB2Ldxg==
X-Received: by 2002:a17:907:c312:b0:a01:ae7b:d19b with SMTP id tl18-20020a170907c31200b00a01ae7bd19bmr12287942ejc.7.1702585793261;
        Thu, 14 Dec 2023 12:29:53 -0800 (PST)
Received: from gerbillo.redhat.com ([84.33.188.175])
        by smtp.gmail.com with ESMTPSA id cu12-20020a170906ba8c00b00a10f3030e11sm9856479ejd.1.2023.12.14.12.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:29:52 -0800 (PST)
Message-ID: <55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, 
 intel-wired-lan@lists.osuosl.org, qi.z.zhang@intel.com, Wenjun Wu
 <wenjun1.wu@intel.com>, maxtram95@gmail.com, "Chittim, Madhu"
 <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>,  Simon Horman <simon.horman@redhat.com>
Date: Thu, 14 Dec 2023 21:29:51 +0100
In-Reply-To: <20231127174329.6dffea07@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-11-27 at 17:43 -0800, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 16:15:47 -0800 Zhang, Xuejun wrote:
> > This is extension of ndo_set_tx_maxrate to include per queue parameters=
=20
> > of tx_minrate and burst.
> >=20
> > devlink rate api includes tx_maxrate and tx_minrate, it is intended for=
=20
> > port rate configurations.
> >=20
> > With regarding to tc mqprio, it is being used to configure queue group=
=20
> > per tc.
> >=20
> > For sriov ndo ndo_set_vf_rate, that has been used for overall VF rate=
=20
> > configuration, not for queue based rate configuration.
> >=20
> > It seems there are differences on intent of the aforementioned APIs.
> >=20
> > Our use case here is to allow user (i.e @ uAPI) to configure tx rates o=
f=20
> > max rate & min rate per VF queue.Hence we are inclined to=20
> > ndo_set_tx_maxrate extension.
>=20
> I said:
>=20
>   So since you asked for my opinion - my opinion is that step 1 is to
>   create a common representation of what we already have and feed it
>   to the drivers via a single interface. I could just be taking sysfs
>   maxrate and feeding it to the driver via the devlink rate interface.
>   If we have the right internals I give 0 cares about what uAPI you pick.
>=20
> https://lore.kernel.org/all/20231118084843.70c344d9@kernel.org/
>=20
> Again, the first step is creating a common kernel <> driver interface
> which can be used to send to the driver the configuration from the
> existing 4 interfaces.

Together with Simon, I spent some time on the above. We think the
ndo_setup_tc(TC_SETUP_QDISC_TBF) hook could be used as common basis for
this offloads, with some small extensions (adding a 'max_rate' param,
too).

The idea would be:
- 'fixing' sch_btf so that the s/w path became a no-op when h/w offload
is enabled
- extend sch_btf to support max rate
- do the relevant ice implementation
- ndo_set_tx_maxrate could be replaced with the mentioned ndo call (the
latter interface is a strict super-set of former)
- ndo_set_vf_rate could also be replaced with the mentioned ndo call
(with another small extension to the offload data)

I think mqprio deserves it's own separate offload interface, as it
covers multiple tasks other than shaping (grouping queues and mapping
priority to classes)

In the long run we could have a generic implementation of the
ndo_setup_tc(TC_SETUP_QDISC_TBF) in term of devlink rate adding a
generic way to fetch the devlink_port instance corresponding to the
given netdev and mapping the TBF features to the devlink_rate API.

Not starting this due to what Jiri mentioned [1].

WDYT?

Thanks,

Paolo and Simon

[1] https://lore.kernel.org/netdev/ZORRzEBcUDEjMniz@nanopsycho/


