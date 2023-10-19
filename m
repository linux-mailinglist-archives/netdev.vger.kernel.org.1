Return-Path: <netdev+bounces-42587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E77CF731
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93ACE1C209C3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9D1A5B6;
	Thu, 19 Oct 2023 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zeeb002v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445041A290
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 11:41:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B29F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697715712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TI/4hZfm5I46y0D29HAGjnS5oa9EwhobJ1CLerArnE=;
	b=Zeeb002vtfB57UtFfyNrl5OVnq/RbdNJow8xHrtE9hnZlFKtIXhEvsIC5LYhEYCIGlXWwD
	4ciBp3Hb8ndwdOtRROFUBcgegEIhSyeNwAmS6h0N7/cxEaWM9PwsA7Ir8Tu58+uJqeEfS2
	q+lPVp7iP+a2k0BBwskQ9pgcoGuVZOE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-RVSbJm-3Ni6GKbt4tTNwZg-1; Thu, 19 Oct 2023 07:41:51 -0400
X-MC-Unique: RVSbJm-3Ni6GKbt4tTNwZg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c39f53775fso63448466b.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715710; x=1698320510;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TI/4hZfm5I46y0D29HAGjnS5oa9EwhobJ1CLerArnE=;
        b=fify7FY63C6laciJa9qUG3OT3glwg6tpVJtT0/pjtdTuEq1TlvEKpenbTBhLLLG+bz
         igIZwsJsJRQqH86R/1NjKzvZPVhOuJk1LeS+A4g5VtRSsPCtnja4FDYUY1gGVa9j490f
         jTjuAsQkCXQK12LlfppdN1zHGVHbzRZ1Xb9qA13xoNTCxeQ0BYANJyP4cCJ66sftIVbm
         B+OuuybvbBHfgBCq1Q0yIjtkkD+a/hF60XyjXB+HcVUWB84So61dJ6bH96G7Sbw66qit
         VclOyWJVBF0MN1oYZyRegwpxfY0a2xtz4BsK3g2PwP/4SUyixLNlAbLtvrCEcriG21Rl
         LnOw==
X-Gm-Message-State: AOJu0YwKDi5lKjjjzKuiHK6XPLmU7cnSqpfyvOiQelmVLKHPX8Y/MCBk
	78YkW7rHe3CBnvZ/tMNdojVM7u4R84/z6N9CvyIqQCbC3/OPyNzui2SCIRCY53ibq7sCKfOt0Rp
	pcowcQq6+rImxikr5
X-Received: by 2002:a17:906:4784:b0:9c3:cefa:93c9 with SMTP id cw4-20020a170906478400b009c3cefa93c9mr1808809ejc.1.1697715710017;
        Thu, 19 Oct 2023 04:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzMsXhjyZ1KyMPesr+FdqrKQeZhrb69MrG73o73/8eoTBlCnEASSAFf3oHjlmBS3SYfsbjBg==
X-Received: by 2002:a17:906:4784:b0:9c3:cefa:93c9 with SMTP id cw4-20020a170906478400b009c3cefa93c9mr1808793ejc.1.1697715709608;
        Thu, 19 Oct 2023 04:41:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id g13-20020a1709063b0d00b009ae3e6c342asm3421743ejf.111.2023.10.19.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:41:49 -0700 (PDT)
Message-ID: <4c68b650b02b2a49f90cdf3a0084cf31bd6c7979.camel@redhat.com>
Subject: Re: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on
 raising memory
From: Paolo Abeni <pabeni@redhat.com>
To: Abel Wu <wuyun.abel@bytedance.com>, "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Oct 2023 13:41:48 +0200
In-Reply-To: <c3110f12-5d9f-4907-a712-5a1004ec4fdc@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
	 <20231016132812.63703-3-wuyun.abel@bytedance.com>
	 <d1271d557adb68b5f77649861faf470f265e9f6b.camel@redhat.com>
	 <c3110f12-5d9f-4907-a712-5a1004ec4fdc@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-10-19 at 19:23 +0800, Abel Wu wrote:
> On 10/19/23 4:53 PM, Paolo Abeni Wrote:
> > On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
> > > Before sockets became aware of net-memcg's memory pressure since
> > > commit e1aab161e013 ("socket: initial cgroup code."), the memory
> > > usage would be granted to raise if below average even when under
> > > protocol's pressure. This provides fairness among the sockets of
> > > same protocol.
> > >=20
> > > That commit changes this because the heuristic will also be
> > > effective when only memcg is under pressure which makes no sense.
> > > Fix this by reverting to the behavior before that commit.
> > >=20
> > > After this fix, __sk_mem_raise_allocated() no longer considers
> > > memcg's pressure. As memcgs are isolated from each other w.r.t.
> > > memory accounting, consuming one's budget won't affect others.
> > > So except the places where buffer sizes are needed to be tuned,
> > > allow workloads to use the memory they are provisioned.
> > >=20
> > > Fixes: e1aab161e013 ("socket: initial cgroup code.")
> >=20
> > I think it's better to drop this fixes tag. This is a functional change
> > and with such tag on at this point of the cycle, will land soon into
> > every stable tree. That feels not appropriate.
> >=20
> > Please repost without such tag, thanks!
> >=20
> > You can send the change to stables trees later, if needed.
>=20
> OK. Shall I add a Acked-by tag for you?

Let's be formal:

Acked-by: Paolo Abeni <pabeni@redhat.com>

/P


