Return-Path: <netdev+bounces-36705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3017B1602
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 10A9DB20A43
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 08:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D133993;
	Thu, 28 Sep 2023 08:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E433989
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:29:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A7B7
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695889766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=C2a6LqA41kHTYejtD6Zn0gAUZKMovtpeoJa3mXbkQMs=;
	b=IxGZb+C85uau7rrcTBRtYIOOEzpu5Dfe6Kr8FFHdYQrEFXkY2SyIZxO4s6PeMVLgFIEF8u
	1ObSAN3AnXoT3LUoA1qv102vEFSsJD4NcqMBhV86UNfUVuUnbmfGBf7LDDBHU1c27eLyF/
	2oCZlsDOGX9jG7CF743DaaqZwUjix0w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ga7YOrLGNPOMgGfggoUOKA-1; Thu, 28 Sep 2023 04:29:23 -0400
X-MC-Unique: ga7YOrLGNPOMgGfggoUOKA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-532eb7faea1so10280690a12.2
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695889762; x=1696494562;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2a6LqA41kHTYejtD6Zn0gAUZKMovtpeoJa3mXbkQMs=;
        b=Cuoux23NPCmnRCquZyFjlM78EaXcdN0Dpf4Jh0Ldmk3otWS/Abhve+4VQ6PYijsVg5
         L+rizXlZn9t5UBpTxRDJifjrnAJ8sFgZOoWFgmKq4QioKSNqUCh6EUj/iWpEvF+7PP2U
         XuZAE58SDVM6Elu6IFZXRzNnh1eAqZUFNJocOaaHxse/I+h1Z/UXB+zXCrqOQWs20Bxr
         K0VZlyN7Zz5owqzTyhHW1/V4dQeAtdNC6WkqZ7AzZhoC+lfkU8wyABwbo7NUyqPWzQ8l
         +Yhrmj9+rSiQPuLnLo+G+T9cvAckOyMLPNJHhqckqLt2eRDeMgMdN/Wpzgo3qcmTs30S
         xKeA==
X-Gm-Message-State: AOJu0YxkmZSlBY+8nAoASy85Jj2nu8ZNiIYVwSP68Vrvtm719qsHwvax
	Qt4ruaO+hjY7r3vs1t2xZ6H9sS9eur7Vw2PJqJ7p0D8u4ZMyJhUdi9QTlxwGApaGxKcMTH8Zv9R
	HUuOJSEzEBTKh3DaO
X-Received: by 2002:aa7:cd74:0:b0:530:df47:f172 with SMTP id ca20-20020aa7cd74000000b00530df47f172mr560775edb.15.1695889762732;
        Thu, 28 Sep 2023 01:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKLk8j/n8RrrFIlitg8C8yJoSVGCOYrRpk3kk1bte0swFS7RYyRzSEIwVZphn7atMruYMHzA==
X-Received: by 2002:aa7:cd74:0:b0:530:df47:f172 with SMTP id ca20-20020aa7cd74000000b00530df47f172mr560762edb.15.1695889762404;
        Thu, 28 Sep 2023 01:29:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ds11-20020a0564021ccb00b00536368246afsm71580edb.50.2023.09.28.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:29:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 30896E262BB; Thu, 28 Sep 2023 10:29:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Persisting mounts between 'ip netns' invocations
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Sep 2023 10:29:07 +0200
Message-ID: <87a5t68zvw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi everyone

I recently ran into this problem again, and so I figured I'd ask if
anyone has any good idea how to solve it:

When running a command through 'ip netns exec', iproute2 will
"helpfully" create a new mount namespace and remount /sys inside it,
AFAICT to make sure /sys/class/net/* refers to the right devices inside
the namespace. This makes sense, but unfortunately it has the side
effect that no mount commands executed inside the ns persist. In
particular, this makes it difficult to work with bpffs; even when
mounting a bpffs inside the ns, it will disappear along with the
namespace as soon as the process exits.

To illustrate:

# ip netns exec <nsname> bpftool map pin id 2 /sys/fs/bpf/mymap
# ip netns exec <nsname> ls /sys/fs/bpf
<nothing>

This happens because namespaces are cleaned up as soon as they have no
processes, unless they are persisted by some other means. For the
network namespace itself, iproute2 will bind mount /proc/self/ns/net to
/var/run/netns/<nsname> (in the root mount namespace) to persist the
namespace. I tried implementing something similar for the mount
namespace, but that doesn't work; I can't manually bind mount the 'mnt'
ns reference either:

# mount -o bind /proc/104444/ns/mnt /var/run/netns/mnt/testns
mount: /run/netns/mnt/testns: wrong fs type, bad option, bad superblock on /proc/104444/ns/mnt, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

When running strace on that mount command, it seems the move_mount()
syscall returns EINVAL, which, AFAICT, is because the mount namespace
file references itself as its namespace, which means it can't be
bind-mounted into the containing mount namespace.

So, my question is, how to overcome this limitation? I know it's
possible to get a reference to the namespace of a running process, but
there is no guarantee there is any processes running inside the
namespace (hence the persisting bind mount for the netns). So is there
some other way to persist the mount namespace reference, so we can pick
it back up on the next 'ip netns' invocation?

Hoping someone has a good idea :)

-Toke


