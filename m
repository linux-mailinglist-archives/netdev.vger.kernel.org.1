Return-Path: <netdev+bounces-39262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F987BE937
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD402818CC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69763AC31;
	Mon,  9 Oct 2023 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S73427jG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF573AC1A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:28:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCBBA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696876082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O0H5nEVXCH4cHWzmT6gbNjCahXhJuDHaEa4XPh9ICj0=;
	b=S73427jGpeJ/y5h66b4G0fE1HIRVZL8EL4iBPN8ffC/CFow02IxckezRfq8TFyTIWr4g96
	xLtstC6LSHBBMBTAmQ+lhHxybuAkEy12IfJAaQSVWXCPxaHhQA6qnhswRaertLP1ksWkSn
	VzQqyuKRRHvzzW2KKi4ZFQ0V2su2eRQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-4wfeoOfhMvq0qo6kbd2tfw-1; Mon, 09 Oct 2023 14:28:00 -0400
X-MC-Unique: 4wfeoOfhMvq0qo6kbd2tfw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-59b5a586da6so39442357b3.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876080; x=1697480880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0H5nEVXCH4cHWzmT6gbNjCahXhJuDHaEa4XPh9ICj0=;
        b=BzrP4YstgoyKJIsmue76H4LHbHy8zFXF0XWkyw8Ha69uiRUY2argFBVem/0m2ap/4P
         way+h4CH96zcVLtQKEdhCy2RUrrEOZFRK47wdZaFyjnb90QnmqTtPC9WcFyqVclTVfXp
         gTESCRsU4965xzXj9xEAAo6sKRkM4Z5OoU2q3w0t5tdmJGkjonVQEmkuboMuneSpClqr
         2+05rdRSYSIyITVs3FY3uiq4991pnkVJcMkt++KNGictNZXT/CFWRCTc8SZ4Gnz3etsQ
         Lhs+mDwfKJWA0vuz581UnYmIXC01Tas5WsaoSqZQ05/Gt+wnbcjDYg3ODkj9Hvm7uQ+n
         vHOg==
X-Gm-Message-State: AOJu0YylyDpvEOyhuduAMHeccZWqlUPHd1XNimsklk7aPHeecQsO+E5U
	dv7He9ejOoDdSdxhdFi1AahYqBNIUj6u6B18WO1MqSqT9DReck3gnvaJoYMUSp5C9ZjiBXRuiIz
	jKvUdkL8eGxs6YSBR
X-Received: by 2002:a81:91d0:0:b0:5a1:d216:8d3 with SMTP id i199-20020a8191d0000000b005a1d21608d3mr6892562ywg.5.1696876080151;
        Mon, 09 Oct 2023 11:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Jf9dyerrsEx+H3Zg2Xqs185Rsralz274ejg0qNy/bUQbKYh03bXpj99R6J4JL0Iy2JVGqw==
X-Received: by 2002:a81:91d0:0:b0:5a1:d216:8d3 with SMTP id i199-20020a8191d0000000b005a1d21608d3mr6892550ywg.5.1696876079884;
        Mon, 09 Oct 2023 11:27:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n184-20020a0de4c1000000b005a4d922cf77sm3841353ywe.119.2023.10.09.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2B229E5820B; Mon,  9 Oct 2023 20:27:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces along with network namespaces
Date: Mon,  9 Oct 2023 20:27:48 +0200
Message-ID: <20231009182753.851551-1-toke@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 'ip netns' command is used for setting up network namespaces with persistent
named references, and is integrated into various other commands of iproute2 via
the -n switch.

This is useful both for testing setups and for simple script-based namespacing
but has one drawback: the lack of persistent mounts inside the spawned
namespace. This is particularly apparent when working with BPF programs that use
pinning to bpffs: by default no bpffs is available inside a namespace, and
even if mounting one, that fs disappears as soon as the calling command exits.

The underlying cause for this is that iproute2 will create a new mount namespace
every time it switches into a network namespace. This is needed to be able to
mount a /sys filesystem that shows the correct network device information, but
has the unfortunate side effect of making mounts entirely transient for any 'ip
netns' invocation.

This series is an attempt to fix this situation, by persisting a mount namespace
alongside the persistent network namespace (in a separate directory,
/run/netns-mnt). Doing this allows us to still have a consistent /sys inside
the namespace, but with persistence so any mounts survive.

This mode does come with some caveats. I'm sending this as RFC to get feedback
on whether this is the right thing to do, especially considering backwards
compatibility. On balance, I think that the approach taken here of
unconditionally persisting the mount namespace, and using that persistent
reference whenever it exists, is better than the current behaviour, and that
while it does represent a change in behaviour it is backwards compatible in a
way that won't cause issues. But please do comment on this; see the patch
description of patch 4 for details.

The first three patches are just moving code around and should not represent any
functional changes. The fourth patch introduces the mount namespace persistence,
and the fifth patch adds mounting of a bpffs instance to the mount namespace
preparation logic.

Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: David Laight <David.Laight@ACULAB.COM>

Toke Høiland-Jørgensen (5):
  ip: Mount netns in child process instead of from inside the new
    namespace
  ip: Split out code creating namespace mount dir so it can be reused
  lib/namespace: Factor out code for reuse
  ip: Also create and persist mount namespace when creating netns
  lib/namespace: Also mount a bpffs instance inside new mount namespaces

 Makefile            |   2 +
 include/namespace.h |   1 +
 ip/ipnetns.c        | 357 ++++++++++++++++++++++++++++++--------------
 lib/namespace.c     |  82 +++++++---
 4 files changed, 312 insertions(+), 130 deletions(-)

-- 
2.42.0


