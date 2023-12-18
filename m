Return-Path: <netdev+bounces-58659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE3817B9B
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77A21F242D2
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A47146E;
	Mon, 18 Dec 2023 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnaSB4Dy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2257346C
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702930361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsJVSX6IEkmtFV9+0aEN/tS3XHrjWv1JC1BbSwjirH0=;
	b=OnaSB4DytjLY55nDa3ws5dmT4YbUUhDTXfTAMfqDz5CSI+7k3rulmEaA3Yru/T92/GjUup
	BAX+d+xs93duM7bgzdI6mWyDUceQj1ggkORg0fqrHvcVNQNgrlGuTAsqvNn+qMo6NUcOLr
	ccTTUKvi+g52+hqVZFnlGYjhrWizWyI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-50DtuWmMNqGWqrSHaEpn7w-1; Mon, 18 Dec 2023 15:12:39 -0500
X-MC-Unique: 50DtuWmMNqGWqrSHaEpn7w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a23739b8459so1015866b.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 12:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702930358; x=1703535158;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsJVSX6IEkmtFV9+0aEN/tS3XHrjWv1JC1BbSwjirH0=;
        b=YKn6Cslk81oTUjPeLcZqdLn49qOOiuny6Ht7XaqDnKgx1KPB5oKYqUEZE2+KAdCCGB
         xkij8yCdKqGnUFVMRXsnQLzXrYB8Hip2Fzh2BY+ExgQhFOe/ZDfBTD5RIYmG22wWDZTe
         1hcQfZ/LqZtPpEzxBNQoNbJTo+YXsEwPQZ5jIsbbZNKrx71ETmd5cI4aT8zFjmiyC7tp
         zlHFI1TEtyZbFCXgircHhKYUmn9ehMCDHEyXt/ARdDJtiCO5bZjs4FL2OnUHj2cbr+Yr
         lGV6kkfCM5KqZogK97+rEXTJrGNLFkbv+NYVtV9TGx9WQ2fzCb1e2zxeqhIWCI3EnuRa
         darg==
X-Gm-Message-State: AOJu0Yzzz7b4jSSl+u5aKZ4qUnc56MKVrWw+E2/4HCrdvI1kMR0IrhRR
	ACmNxBjgdiTTmwky548wTkdyUrsnRl2euPzjWUC1U9giabInBCBZIPYXX4f23IVCGyiYPuBF7OT
	MrQlQQ7hBJcsv+bZO
X-Received: by 2002:a50:bb06:0:b0:553:46ed:3133 with SMTP id y6-20020a50bb06000000b0055346ed3133mr3447595ede.1.1702930358296;
        Mon, 18 Dec 2023 12:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxMl1ef4XcJR6LMN9lFW5JBcbOLREMzwim3fhKSyUDak7Z0VJgOu2KaMA5DHNWK50AhpB2Fw==
X-Received: by 2002:a50:bb06:0:b0:553:46ed:3133 with SMTP id y6-20020a50bb06000000b0055346ed3133mr3447586ede.1.1702930357962;
        Mon, 18 Dec 2023 12:12:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-3.dyn.eolo.it. [146.241.253.3])
        by smtp.gmail.com with ESMTPSA id l14-20020aa7cace000000b005530492d900sm2561975edt.58.2023.12.18.12.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:12:37 -0800 (PST)
Message-ID: <baa4bd4b3aa0639d29e5c396bd3da94e01cd8528.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org, 
 qi.z.zhang@intel.com, Wenjun Wu <wenjun1.wu@intel.com>,
 maxtram95@gmail.com,  "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Simon Horman
 <simon.horman@redhat.com>
Date: Mon, 18 Dec 2023 21:12:35 +0100
In-Reply-To: <20231215144155.194a188e@kernel.org>
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
	 <7b0c2e0132b71b131fc9a5407abd27bc0be700ee.camel@redhat.com>
	 <20231215144155.194a188e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 14:41 -0800, Jakub Kicinski wrote:
> I explained before (perhaps on the netdev call) - Qdiscs have two
> different offload models. "local" and "switchdev", here we want "local"
> AFAIU and TBF only has "switchdev" offload (take a look at the enqueue
> method and which drivers support it today).

I must admit the above is not yet clear to me.

I initially thought you meant that "local" offloads properly
reconfigure the S/W datapath so that locally generated traffic would go
through the expected processing (e.g. shaping) just once, while with
"switchdev" offload locally generated traffic will see shaping done
both by the S/W and the H/W[1].

Reading the above I now think you mean that local offloads has only
effect for locally generated traffic but not on traffic forwarded via
eswitch, and vice versa[2].=20

The drivers I looked at did not show any clue (to me).

FTR, I think that [1] is a bug worth fixing and [2] is evil ;)

Could you please clarify which is the difference exactly between them?

> "We'll extend TBF" is very much adding a new API. You'll have to add
> "local offload" support in TBF and no NIC driver today supports it.
> I'm not saying TBF is bad, but I disagree that it's any different
> than a new NDO for all practical purposes.
>=20
> > ndo_setup_tc() feels like the natural choice for H/W offload and TBF
> > is the existing interface IMHO nearest to the requirements here.
>=20
> I question whether something as basic as scheduling and ACLs should
> follow the "offload SW constructs" mantra. You are exposed to more
> diverse users so please don't hesitate to disagree, but AFAICT
> the transparent offload (user installs SW constructs and if offload
> is available - offload, otherwise use SW is good enough) has not
> played out like we have hoped.
>=20
> Let's figure out what is the abstract model of scheduling / shaping
> within a NIC that we want to target. And then come up with a way of
> representing it in SW. Not which uAPI we can shoehorn into the use
> case.

I thought the model was quite well defined since the initial submission
from Intel, and is quite simple: expose TX shaping on per tx queue
basis, with min rate, max rate (in bps) and burst (in bytes).

I think that making it more complex (e.g. with nesting, pkt overhead,
etc) we will still not cover every possible use case and will add
considerable complexity.
>=20
Cheers,

Paolo


