Return-Path: <netdev+bounces-54477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E95C80737C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28C1B20F11
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924A3FB39;
	Wed,  6 Dec 2023 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDUxckXp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A7D5F
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701875644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDBnyP1g1RG8X2pWpNL9U6g9VK+bR9BnvKJLC9D2B9Y=;
	b=iDUxckXpbUkV0lK/3oqmUOfbhjunx/VT+OJlQNDAXlT9d/8td1o9CpT9NiWAZu4mn5rai3
	wRG2dpGiss3BGfWoDVXDghY7HtRmnecJfRGhWlBj9HNV5zB1q/QEcwqh2Iu3QrGhz6XxYO
	/6L93rDtUfRh8YQuZ7rRzI65qrgzH9o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Dw6yz-NKPiie1xDYhSNtgw-1; Wed, 06 Dec 2023 10:14:02 -0500
X-MC-Unique: Dw6yz-NKPiie1xDYhSNtgw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1ae30a04ffso81633366b.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 07:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875641; x=1702480441;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDBnyP1g1RG8X2pWpNL9U6g9VK+bR9BnvKJLC9D2B9Y=;
        b=jHCfQKJHCgKWN7xUkaaLNegFPKQD8fEtQhWbhqfjvZrDjWYi7u8B2n4dQ7H/sxjwpr
         E8rdTL/ZAU/6S6IEz6dAzLiBXPRBrKd/K9unVNtLsdSkBgsMHaTXV2L1k6DTb8hj3ej/
         S/JRQEvft35L1Mxv3et96ydJ90DGeWMUskl2C+C6CVMzOip6Fn8UMhloUoS2ORzBwKuE
         i6coz+YQfPeJQ+gUmWJkDActrYOuMld3QSsGhSyJXfEMXKh1oHWSADIWXIpgTDK2k7G/
         AU8NbeOMT7stj1vVVuLtfjq4MQB/RXGpgVCaJE066bo/5LSH6IRGFT2Ph0TuV93flJ7K
         ukqA==
X-Gm-Message-State: AOJu0YwXp/izi9UUimSWArHDNXMFUE36FMVfGU/Pq2l4jpAFr4GGTqM3
	MqX42ESMFV/XhVPT73uezRp+EKHYEZoVbGc+Oxv7YroLPupMKZ5yqiL+gjgfh3b8n2Qf00Gx0wB
	I45bVYmcdfa7885Er
X-Received: by 2002:a17:906:7f08:b0:a1d:1c71:8158 with SMTP id d8-20020a1709067f0800b00a1d1c718158mr1376389ejr.4.1701875641534;
        Wed, 06 Dec 2023 07:14:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH4g3R2HEOI3zDVywah2i1EzMR4lb37y99R2HGm/dv2ky/blvgh6Pw56PyopKcfjAyqvBjqA==
X-Received: by 2002:a17:906:7f08:b0:a1d:1c71:8158 with SMTP id d8-20020a1709067f0800b00a1d1c718158mr1376368ejr.4.1701875641118;
        Wed, 06 Dec 2023 07:14:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709064e5900b00a1aa6f2d5fcsm37351ejw.110.2023.12.06.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:14:00 -0800 (PST)
Message-ID: <70497ad83be1c7bd715abc8f29c72ee39a381f58.camel@redhat.com>
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,  Shuah Khan <shuah@kernel.org>, David Ahern
 <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,  Po-Hsu Lin
 <po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>, James
 Prestwood <prestwoj@gmail.com>, Jaehee Park <jhpark1013@gmail.com>, Ido
 Schimmel <idosch@nvidia.com>, Justin Iurman <justin.iurman@uliege.be>, Xin
 Long <lucien.xin@gmail.com>, James Chapman <jchapman@katalix.com>
Date: Wed, 06 Dec 2023 16:13:59 +0100
In-Reply-To: <87jzpr5x0r.fsf@nvidia.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
	 <20231202020110.362433-2-liuhangbin@gmail.com>
	 <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
	 <87jzpr5x0r.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 13:32 +0100, Petr Machata wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>=20
> > Side note for a possible follow-up: if you maintain $ns_list as global
> > variable, and remove from such list the ns deleted by cleanup_ns, you
> > could remove the cleanup trap from the individual test with something
> > alike:
> >=20
> > final_cleanup_ns()
> > {
> > 	cleanup_ns $ns_list
> > }
> >=20
> > trap final_cleanup_ns EXIT
> >=20
> > No respin needed for the above, could be a follow-up if agreed upon.
>=20
> If you propose this for the library then I'm against it. The exit trap
> is a global resource that the client scripts sometimes need to use as
> well, to do topology teardowns or just general cleanups.=C2=A0
> So either the library would have to provide APIs for cleanup management, =
or the trap
> is for exclusive use by clients. The latter is IMHO simpler.

Even the former would not be very complex:

TRAPS=3D""
do_at_exit() {
        TRAPS=3D"${TRAPS}$@;"

        trap "${TRAPS}" EXIT
}

And then use "do_at_exit <whatever>" instead of "trap <whatever> EXIT"

> It also puts the cleanups at the same place where the acquisition is
> prompted: the client allocates the NS, the client should prompt its
> cleanup.

I guess I could argue that the the script is asking the library to
allocate the namespaces, and the library could take care of disposing
them.

But I'm not pushing the proposed option, if there is no agreement no
need for additional work ;)

Cheers,

Paolo


