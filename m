Return-Path: <netdev+bounces-34929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DFB7A5FDA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91ED1C20BD3
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD0D15BE;
	Tue, 19 Sep 2023 10:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469315A6
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:41:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9FF0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695120106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qh3emiPdIdlM25Yhko4R585FyY+ucfl7CnLlpHuoPw=;
	b=KvnmEJ12DDOPt31G1jJorb2ef+o8k3fOcC0j0cjV49Ow+hY9j5wXVF1CrxNzXiaZ5DU/36
	+uRpfMo8CUvtXGBYDUowywmXl4t6zLDUlKLT2K7VUvZU7+nDYGGh+g9devYnHJpDXgS6Zz
	k6A4tvnDOvDDFz7EDg+DYzh4C1VcpA0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-wdf5nteBOTuvvQsOfL56uQ-1; Tue, 19 Sep 2023 06:41:45 -0400
X-MC-Unique: wdf5nteBOTuvvQsOfL56uQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9aa1e8d983aso127835766b.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120104; x=1695724904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qh3emiPdIdlM25Yhko4R585FyY+ucfl7CnLlpHuoPw=;
        b=hosS4zM80fbMLwLjqsP+MCjv4drN8fOuf0Z9Fz6kUN5dTnx3Z/sQ8hcfA2tbmkedby
         q5iRKwx4VPUYxu6eI8+zhTWgDNO8V52hwhimPeWlCU0ixS15LxOEzXIkBD+RbvRewDkM
         d6hkO2OI4XcN4zzzxAin9E0YUCngFSX5K5r/fWukvr067GgGS8yK6ASbST2HksZ24xUe
         T8E+b7LaWlp/pM34l1NAF9l4OeuHAFaYn+D7pcVz1U4f1KyW0FoCAt0fVkEvw+NQX1wm
         xxcmDYIFqBtSMpNIvpb9yDgF9TSstOt/zbNx/BQppmMosM/ZAEt4OuL9yUSP95KeCZWc
         2VJw==
X-Gm-Message-State: AOJu0YxHWfPzuNfDfa9ACb+dOgUFw0NHVwDNLj3m7bjAv5bA+VpDLQbj
	+QWMUyo0oZPO4o3vwjKWrPga90qz12YiGudYqY8M7oBbC7odOncJpOIT2h5yEvvB1g8Wodez3ou
	3hvZUFXPEHOVfZrLU
X-Received: by 2002:a17:907:1ca1:b0:9ad:f4d9:f6f2 with SMTP id nb33-20020a1709071ca100b009adf4d9f6f2mr8079813ejc.5.1695120104416;
        Tue, 19 Sep 2023 03:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm1AWCcxmIi0Cd289KzRwYMahlgaoY2fNb1rvHdXyDdFHBd//O03w0o3kUJUwjiKREWV+rwA==
X-Received: by 2002:a17:907:1ca1:b0:9ad:f4d9:f6f2 with SMTP id nb33-20020a1709071ca100b009adf4d9f6f2mr8079797ejc.5.1695120104083;
        Tue, 19 Sep 2023 03:41:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b009a9fbeb15f5sm7563973ejb.46.2023.09.19.03.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 03:41:43 -0700 (PDT)
Message-ID: <4d88cd641c25cc231fcbad62c19cae60749bb171.camel@redhat.com>
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, netdev@vger.kernel.org, 
	syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com, 
	syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Date: Tue, 19 Sep 2023 12:41:42 +0200
In-Reply-To: <ZQl4oCdoeKWO8QqA@nanopsycho>
References: <20230916131115.488756-1-ap420073@gmail.com>
	 <ZQXcOmtm1l36nUwV@nanopsycho>
	 <d89e68db75f06c41c9b28584c1210ed31d27db2a.camel@redhat.com>
	 <ZQl4oCdoeKWO8QqA@nanopsycho>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 12:32 +0200, Jiri Pirko wrote:
> Tue, Sep 19, 2023 at 09:40:53AM CEST, pabeni@redhat.com wrote:
> > On Sat, 2023-09-16 at 18:47 +0200, Jiri Pirko wrote:
> > > Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
> > > > The purpose of team->lock is to protect the private data of the tea=
m
> > > > interface. But RTNL already protects it all well.
> > > > The precise purpose of the team->lock is to reduce contention of
> > > > RTNL due to GENL operations such as getting the team port list, and
> > > > configuration dump.
> > > >=20
> > > > team interface has used a dynamic lockdep key to avoid false-positi=
ve
> > > > lockdep deadlock detection. Virtual interfaces such as team usually
> > > > have their own lock for protecting private data.
> > > > These interfaces can be nested.
> > > > team0
> > > >  |
> > > > team1
> > > >=20
> > > > Each interface's lock is actually different(team0->lock and team1->=
lock).
> > > > So,
> > > > mutex_lock(&team0->lock);
> > > > mutex_lock(&team1->lock);
> > > > mutex_unlock(&team1->lock);
> > > > mutex_unlock(&team0->lock);
> > > > The above case is absolutely safe. But lockdep warns about deadlock=
.
> > > > Because the lockdep understands these two locks are same. This is a
> > > > false-positive lockdep warning.
> > > >=20
> > > > So, in order to avoid this problem, the team interfaces started to =
use
> > > > dynamic lockdep key. The false-positive problem was fixed, but it
> > > > introduced a new problem.
> > > >=20
> > > > When the new team virtual interface is created, it registers a dyna=
mic
> > > > lockdep key(creates dynamic lockdep key) and uses it. But there is =
the
> > > > limitation of the number of lockdep keys.
> > > > So, If so many team interfaces are created, it consumes all lockdep=
 keys.
> > > > Then, the lockdep stops to work and warns about it.
> > >=20
> > > What about fixing the lockdep instead? I bet this is not the only
> > > occurence of this problem.
> >=20
> > I think/fear that solving the max key lockdep problem could be
> > problematic hard and/or requiring an invasive change.
>=20
> But it would solve this false warnings not only here but for many
> others.

Well, let's see if Taehee can came up with something addressing that. I
think that if such problem proves to be too hard, we should consider
other options.

Cheers,

Paolo


