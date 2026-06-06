Return-Path: <netdev+bounces-296163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4jn/OJeYJGo49AEAu9opvQ
	(envelope-from <netdev+bounces-296163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 00:00:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860964E723
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 00:00:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=D0ozqqdm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296163-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296163-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2183A3016529
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1721A304A;
	Sat,  6 Jun 2026 22:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A813DBA0
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 22:00:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780783251; cv=pass; b=Pgoe3y/GJiu/ubDgIAXaQBR0StMTslKeOvnOYLQlGZq1ic7rlVxWfYoQ/CdzSH+F2d+205/XAFfn+8x61nMRGTPX/vIM7zS1PxRQHiDGTdV8siqOvk6AQN5+mNGGJaR8y9qI4wj6UhqbQwBKMb3p1VkfLERHKH6tuxK/fMAHMpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780783251; c=relaxed/simple;
	bh=JklZoVSHSSeMVT5K/IXdnIYd5bJQP32cB2VrlK1mgsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcKpI2/ZHR3uilSQ5SZZ0iXKFIE3std9e9D4niRTQ6NwHnv/t7VAV/DCzUcqZu8FzFG0TUdZv3PAcMzq50gOuxY52uILyZW9KEMPoTdlvdZULF96aT+VX7ug7VDSHDJIwkTm//ohVm00+chHC53QxYkuhlbzzRy6J3t85JD3pLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=D0ozqqdm; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423efd76c8so2090848b3a.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 15:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780783249; cv=none;
        d=google.com; s=arc-20240605;
        b=TPCbnPgEVZtdT29VSXM+jMAplht1LnTT/OU8ilQtoN0nB2pOHQzT7I8jO0fQyP/4Ce
         nughe869dPMn8vPlRajudQOb6vJO30eeHGPHkxkSSdeVhJvqkAnt8Cp0rEFJa+rlK9xO
         2v3GOE2G52fHLHmcLB2wRmfwMq1ePP+OcOxxLWlDFRO5mNThSwiFhQUhjxO6TVVmbfJB
         C4D8X/ysSXQPFonSBw2nPDN8BHFDjfkPy9SvClWn58JkNJk1OGOk0/VtuwVyBOwj4rCo
         fw/Y8h9A1/i7XXDy59KLj9bDp8mLKhjgQIoIubAHtXugVnQK5U0Z02ufv/oNzOlLUbwe
         AzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HBZWdID8otG8mvTK/jX8anFGJZbVGI+h8QUrOAueMus=;
        fh=F5SIwZPCEJ6RPFO5FmSqekmMdPz8af1oJypOUxZ2YvE=;
        b=WzqhZ0dTw1z6IvOBwuoE5BE035yeBeOraOnVbzq2OBeE0tLOnTIx0gvo72avWMgVIx
         q1+rqMXfSeAQqlwXuMCM1VQR0XCBj6wz+cdiF7ehHwVxkssXZ/WuJ83C3rYeWAHuaWq+
         D/OCZmrEMnn6q8KYZr1Wk71O5RnDbnTWQvknIqrcjYQzs31nAf9w1a9iWVZf04iezuSo
         +k5HEMDmxtYmXbLGnvuGDvAJHIJR12O736OH9KZR8DF+pkQQJ9hr6zMIc5ZI9yM3gyno
         9e0W4Kx/PrWA4ON6TBBeavMP9aCIHVyW8hU86Uufydq/c/yV/0PqRbpc0m+d4yVXk4H5
         BW9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780783249; x=1781388049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBZWdID8otG8mvTK/jX8anFGJZbVGI+h8QUrOAueMus=;
        b=D0ozqqdmurbFK07djFO185Is27FfP4ENEmgs1ei1rlwrePhiPZrbM5TO4M3hwtfu/s
         /qL/A/8gnR5gd7cCyP9foIPwLxizbZf7IaG8pbTfKJBkKS3OSxzFeyJTQovNvCzeOVHM
         XdSCN5VFCyUKTZjYGQBmOdV8gP4P0HncHCy9vxpxROIwI6jXTRdWl1aczLy1SH4fEaDM
         svhbgCKVUB3G9vzEcPctW4Iwf4WWUTuSvyWtyEdt3HlXuuek7icVIK/TX+7fjXK+Pa97
         /dhRMYGIQ10CrrMLtGRHFlVDQ7X088MgxBjEHUB7zAX8JIeq5OVGhnXayGcFjCzRBkIV
         r7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780783249; x=1781388049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBZWdID8otG8mvTK/jX8anFGJZbVGI+h8QUrOAueMus=;
        b=BHGaN3g2iqrsCYMmuQ4KXAkupcDOTuk3uLPrzgdlKL7K27Vakx+jwAP+mgChzKb1P5
         wus4QI85lMJZj0pwGAZB6Bc4+dlL5cnJFdhxV6g1iDl++/HgyLCAoOfClF0mXvbzSl0I
         n7RqhNk1xUEpIxvtSX+fC5Ybp0C8JMNtmJywNSf1I5yvJMRN3e+jGlkl1tMMY24iGJNI
         X68+q4I2ym6jabt0R7PAIIJ+egxSmY0m8/1Xnn4eff3cg0xweKJxZm92+UP48uGCGR4V
         fYiJ0jgbJTns6EA7/f1fQR1XbIcI27B07le92SAt3H7/0gtEW6ipsOxwTR1scSGVMt/Z
         feAA==
X-Gm-Message-State: AOJu0Yxp7Up846ypF2TnZVdUymQKZUfAC+pajn1ry3zO+PTjHLHIEaOH
	nOqoVU+JgS0q07fv79cOgpcmZIf5ggpDCp1h/BV5rEN1TC6NBZ6ujuIelOVbMb7lvV9+UIKqmXu
	BVyf94eCnEQ8EptPlkFvaEpjnB5cOj7L3SkILA7Dd
X-Gm-Gg: Acq92OERi1SDbF2UyCWoiS/idxzLClsC7SSpbB1WOIhcqxMwyuGe+/kdx06ZYrSqmIO
	jx18TL2dqqg9ycQ9kN82uIX1bJKqN4TUjX8VVXSrtG8hn5oOek1xuW6GiI+m9y+XnCXgxNJzk3f
	WBOsxSKD7VJASSwWTbSRXcKuZe6P2n3+ymgFgaGXv+/p7IMr+sItvgJC4z1BWy8yxkdWCUFppfV
	+gRJt/N55C40/Hkl8aRbdpBDZcxYrOEpkZ9V7nT+0vOq8ya8UUJbOEK4M1RxmAMdXYiOveyrmo3
	SpK0FKi8scN+KRdUypW4Vs+w2Vde6dlfpN7RpQxjbYKKjMF1pw==
X-Received: by 2002:aa7:88cb:0:b0:842:68d3:e29d with SMTP id
 d2e1a72fcca58-842b0e7d233mr9029036b3a.36.1780783249552; Sat, 06 Jun 2026
 15:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405000324.548623-1-xmei5@asu.edu> <20260407070716.GA752875@shredder>
In-Reply-To: <20260407070716.GA752875@shredder>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 6 Jun 2026 15:00:38 -0700
X-Gm-Features: AVVi8Cf7lOaRxhyC9Nd1mAHqEQjUOB9sRQGvd0iUnAgNqhuZ5cGPZR2gKctHC9s
Message-ID: <CAPpSM+Tuf5tLGabgjXg3=1sFOAg3ioFPMGeSeoufCPhrLH6tfw@mail.gmail.com>
Subject: Re: [PATCH net v2] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev, 
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296163-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:from_mime,asu.edu:email,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8860964E723

Thanks for the feedback, and sorry for the delayed v3. It was sent.

Best,
Xiang

On Tue, Apr 7, 2026 at 12:07=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Sat, Apr 04, 2026 at 05:03:24PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> > the configured exp_interval converted by interval_to_us(). When
> > exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> > interval_to_us() returns 0, causing the worker to fire immediately in
> > a tight loop that allocates skbs until OOM.
> >
> > Fix this by validating exp_interval at configuration time:
> >
> >  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to [1, 7] in the
> >    netlink policy so userspace cannot set an invalid value.
> >
> >  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
> >    not yet been configured (defaults to 0 from kzalloc).
> >
> > Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. =
CCM frame TX added.")
>
> Nit: Doesn't matter in practice, but let's blame commit 2be665c3940d
> ("bridge: cfm: Netlink SET configuration Interface.") instead as I don't
> think this bug could be triggered before exposing the netlink API.
>
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: Move validation out of the datapath and into configuration
> >
> >  net/bridge/br_cfm.c         | 6 ++++++
> >  net/bridge/br_cfm_netlink.c | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> > index 118c7ea48c35..dea56fffa1c1 100644
> > --- a/net/bridge/br_cfm.c
> > +++ b/net/bridge/br_cfm.c
> > @@ -805,6 +805,12 @@ int br_cfm_cc_ccm_tx(struct net_bridge *br, const =
u32 instance,
> >               goto save;
> >       }
> >
> > +     if (!interval_to_us(mep->cc_config.exp_interval)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Invalid CCM interval");
> > +             return -EINVAL;
> > +     }
> > +
> >       /* Start delayed work to transmit CCM frames. It is done with zer=
o delay
> >        * to send first frame immediately
> >        */
> > diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> > index 2faab44652e7..1bb33c8f587b 100644
> > --- a/net/bridge/br_cfm_netlink.c
> > +++ b/net/bridge/br_cfm_netlink.c
> > @@ -34,7 +34,7 @@ br_cfm_cc_config_policy[IFLA_BRIDGE_CFM_CC_CONFIG_MAX=
 + 1] =3D {
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_UNSPEC]       =3D { .type =3D NLA_REJE=
CT },
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_INSTANCE]     =3D { .type =3D NLA_U32 =
},
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_ENABLE]       =3D { .type =3D NLA_U32 =
},
> > -     [IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =3D { .type =3D NLA_U32 =
},
> > +     [IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL] =3D NLA_POLICY_RANGE(NLA=
_U32, 1, 7),
>
> Use BR_CFM_CCM_INTERVAL_3_3_MS and BR_CFM_CCM_INTERVAL_10_MIN instead of
> the magic numbers?
>
> The Sashiko review points out that blocking BR_CFM_CCM_INTERVAL_NONE
> might break user space, but it seems weird to allow passing a value that
> is interpreted the same as an invalid one. Worst case, if someone
> complains, we can revert and go back to v1.
>
> >       [IFLA_BRIDGE_CFM_CC_CONFIG_EXP_MAID]     =3D {
> >       .type =3D NLA_BINARY, .len =3D CFM_MAID_LENGTH },
> >  };
> > --
> > 2.43.0
> >

