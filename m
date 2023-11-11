Return-Path: <netdev+bounces-47177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894CB7E8989
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 07:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0541C2074C
	for <lists+netdev@lfdr.de>; Sat, 11 Nov 2023 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5404E161;
	Sat, 11 Nov 2023 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJV+kzfo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C75227
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 06:34:53 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A44D55
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 22:34:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so2565979a91.3
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699684492; x=1700289292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKu2MfyEEqZOiqRvlkmynwqLs8+5RYT8TR7o4ca3DYE=;
        b=OJV+kzfo5cl3ugr3QRC6aPjJVo99xSwmyPgFtAiJmJTgVYSdwCzspeflGSTgQIhAYh
         KeeYIabP4h5lkAKFymoMCvAnZZ1HxHmNYg/qt4n8AnnkH1iKwUikAYW4ppTTtt9pHCzk
         AVDsCHBK2hoc2UlaDBs0kSkiISAJ6iU5Hf2Gxm5YEw/Lc/igVm4ulzdBF9HEkUeRupgs
         x5tHQoqpkgVWC48EqF5F1aLNb9aH9Pbaxcp074d5jiqWzLdcLg1c8v326FbMz65XWMPB
         YeebbF5sU6mwn4RG8KWWWpmmTHaCCVLyCwfzLYJpM1EZSv4vPrDT8i++3HZ29uKw3l21
         sQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699684492; x=1700289292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKu2MfyEEqZOiqRvlkmynwqLs8+5RYT8TR7o4ca3DYE=;
        b=MM3evj4+BB+bazj15ANp02K66bD5Bbdwh5Wkf1T8D0RoRxBspwJ2s3uguhwzXrj00d
         dirudE3swoJA6MAzjVjPzAgS+CoiivATVSM6FN1G/faMO0kVUFgSrKBkPMC4Chd2XZlK
         Cod7WnlPeTO+BTKzGePz8dtyTLhJcBOnZPmh0xaEzuO1uonPqVFeQW08n+hpiP8bGK9Z
         hmc2MAKuiOEG1KUs7TYYFlXJl/j9avze/8dfNX3pCg+msn7paAuO+5SDg0GjDRs8gfLw
         VUtvlE6IO4HppkdCMG7wXyX7KX26Xi7ac5xfTXjm7/ruYkhuk3mFwfwowsEpNukgJJsf
         Jm0w==
X-Gm-Message-State: AOJu0Yw2SUbNWAIRrKnhF93uFVDDGmdzqb7xemLq51/uXaXxM5m9EnzS
	vpRZ3aRSQSVxttPHXAoZPjs=
X-Google-Smtp-Source: AGHT+IGA5tgzROVEy8LICOCjY+a00VcbMGVY0ZL9yWnZYfjU0cxHYyr6gwIqpk7vdVKTvbuIG2aV+w==
X-Received: by 2002:a17:90b:4b87:b0:280:74ce:ae8d with SMTP id lr7-20020a17090b4b8700b0028074ceae8dmr1134379pjb.20.1699684491867;
        Fri, 10 Nov 2023 22:34:51 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001b9be3b94d3sm658905pls.140.2023.11.10.22.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 22:34:51 -0800 (PST)
Date: Sat, 11 Nov 2023 14:34:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
Message-ID: <ZU8ghyf+tAUnk7gI@Laptop-X1>
References: <20231109180102.4085183-1-edumazet@google.com>
 <ZU2nBgeOAZVs4KKJ@Laptop-X1>
 <84246.1699607962@vermin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84246.1699607962@vermin>

On Fri, Nov 10, 2023 at 11:19:22AM +0200, Jay Vosburgh wrote:
> >Do we need also do this if the bond changed to ether device from other dev
> >type? e.g.
> >
> >    if (slave_dev->type != ARPHRD_ETHER)
> >            bond_setup_by_slave(bond_dev, slave_dev);
> >    else
> >            bond_ether_setup(bond_dev);
> 
> 	I'm not sure I follow your comment; bond_enslave() already has
> the above logic.  If the bond is not ARPHRD_ETHER and an ARPHRD_ETHER
> device is added to the bond, the above will take the bond_ether_setup()
> path, which will call ether_setup() which will set the device to
> ARPHRD_ETHER.
> 
> 	However, my recollection is that the bond device itself should
> be unregistered if the last interface of a non-ARPHRD_ETHER bond is
> removed.  This dates back to d90a162a4ee2 ("net/bonding: Destroy bonding
> master when last slave is gone"), but I don't know if the logic still
> works correctly (I've not heard much about IPoIB with bonding in a
> while).  The bond cannot be initially created as non-ARPHRD_ETHER; the
> type changes when the first such interface is added to the bond.

Ah, thanks for this info. I just tried and it still works. Which looks
there is no need to close bond dev before bond_ether_setup().

BTW, I tried to set gre0's master to bond0 and change the types. After that,
`ip link del gre0` will return 0 but gre0 is actually not deleted. I have to
remove the gre mode to delete the link. Is that expected?

```
# ip link add bond0 type bond mode 1 miimon 100
# ip link add gre0 type gre
# ip link set gre0 master bond0
# ip link show bond0
21: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/gre 0.0.0.0 brd 0.0.0.0
# ip link del gre0
# echo $?
0
# ip link show gre0
18: gre0@NONE: <NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/gre 0.0.0.0 brd 0.0.0.0

```

Thanks
Hangbin

