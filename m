Return-Path: <netdev+bounces-34881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EF7A5B64
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E32D1C20CE3
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEB338BC4;
	Tue, 19 Sep 2023 07:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC15A3B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 07:41:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7A120
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695109258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8DEMBKUf7wrXxpg4qEqs33NQceh/oaxZGz6ns8z/zo=;
	b=TAV+pjdNc2IlAARadWtKATuxQNmua7Bq9qenlHYB3UI/OXq5wLOn3qGC40NAMz3ZeOCjkT
	iTn7BlDNcQeNiVVyOOZilAZhnFcvrHttxQP7AStTNrpJhQ7pzTcYu+Ol3z1q0sobnAzAt7
	aXn26fCuQltpTw7+lT/nDHJWEeMa5Rg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-PcUp0EpwNXugstWb-ZhmDQ-1; Tue, 19 Sep 2023 03:40:56 -0400
X-MC-Unique: PcUp0EpwNXugstWb-ZhmDQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40503cbb9b3so6281305e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109255; x=1695714055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8DEMBKUf7wrXxpg4qEqs33NQceh/oaxZGz6ns8z/zo=;
        b=c/0FWhrJjBaoGzRrK+d9NnUY/KbGxU4NgFF0Uox+zNMCI0BpCb5agmoFtpp0AFfpeL
         ECZhppvWzU2h0FcL7Iqe+SPmEbRQkGJ0UJk4kei3u92DIJ6wDyAh68KdhIj8mZvaw2s7
         fSgp7CqjrsURyfc3M/LEDP2SN8pr6HhZnjbpMr19c9NAvOPSVPB2vWpqzIBxQQvMbpO5
         3a6IbeJTNFEzQP/771wqiQpIF+xbCvEnpLBCTxIybq6+SsioppL7D/U9/02J5yo1TTvx
         qZowyG0zfCEEb6YzqCbxxI1ONdF+D/Hqs4CMBS2hwVsHPEW4mViwfkMk79xkHCQYlCrs
         HI7w==
X-Gm-Message-State: AOJu0YzfKDD7sKZ04mqQ3I2RPhr6Kyybu9eqS1C5FUSHqH9aLAwtJKbl
	S9J6QQY+zW18K+ilyBJK/rovWrTK5CfT8XwgGogo/3okalvW7ecWXQSK92htY3yeS72ciqcN0EC
	o2BJSpcy15wL0HmBU
X-Received: by 2002:a05:600c:1da9:b0:404:72f9:d59a with SMTP id p41-20020a05600c1da900b0040472f9d59amr9945861wms.0.1695109255429;
        Tue, 19 Sep 2023 00:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER+za7ns1Evg+8KxlXu4Np/4twVy7+ly7Wu1nCY2T/FCiSZTNxseHXcM0mLSfVoVyOXRek2g==
X-Received: by 2002:a05:600c:1da9:b0:404:72f9:d59a with SMTP id p41-20020a05600c1da900b0040472f9d59amr9945842wms.0.1695109255074;
        Tue, 19 Sep 2023 00:40:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d628f000000b0031f729d883asm14701393wru.42.2023.09.19.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:40:54 -0700 (PDT)
Message-ID: <d89e68db75f06c41c9b28584c1210ed31d27db2a.camel@redhat.com>
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
 netdev@vger.kernel.org,
 syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com, 
 syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Date: Tue, 19 Sep 2023 09:40:53 +0200
In-Reply-To: <ZQXcOmtm1l36nUwV@nanopsycho>
References: <20230916131115.488756-1-ap420073@gmail.com>
	 <ZQXcOmtm1l36nUwV@nanopsycho>
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

On Sat, 2023-09-16 at 18:47 +0200, Jiri Pirko wrote:
> Sat, Sep 16, 2023 at 03:11:15PM CEST, ap420073@gmail.com wrote:
> > The purpose of team->lock is to protect the private data of the team
> > interface. But RTNL already protects it all well.
> > The precise purpose of the team->lock is to reduce contention of
> > RTNL due to GENL operations such as getting the team port list, and
> > configuration dump.
> >=20
> > team interface has used a dynamic lockdep key to avoid false-positive
> > lockdep deadlock detection. Virtual interfaces such as team usually
> > have their own lock for protecting private data.
> > These interfaces can be nested.
> > team0
> >  |
> > team1
> >=20
> > Each interface's lock is actually different(team0->lock and team1->lock=
).
> > So,
> > mutex_lock(&team0->lock);
> > mutex_lock(&team1->lock);
> > mutex_unlock(&team1->lock);
> > mutex_unlock(&team0->lock);
> > The above case is absolutely safe. But lockdep warns about deadlock.
> > Because the lockdep understands these two locks are same. This is a
> > false-positive lockdep warning.
> >=20
> > So, in order to avoid this problem, the team interfaces started to use
> > dynamic lockdep key. The false-positive problem was fixed, but it
> > introduced a new problem.
> >=20
> > When the new team virtual interface is created, it registers a dynamic
> > lockdep key(creates dynamic lockdep key) and uses it. But there is the
> > limitation of the number of lockdep keys.
> > So, If so many team interfaces are created, it consumes all lockdep key=
s.
> > Then, the lockdep stops to work and warns about it.
>=20
> What about fixing the lockdep instead? I bet this is not the only
> occurence of this problem.

I think/fear that solving the max key lockdep problem could be
problematic hard and/or requiring an invasive change.

Is there any real use-case requiring team devices being nested one to
each other? If not, can we simply prevent such nesting in
team_port_add()? I'm guessing that syzkaller can find more ways to
exploit such complex setup.

Cheers,

Paolo


