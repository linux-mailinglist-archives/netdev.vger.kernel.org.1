Return-Path: <netdev+bounces-57523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142BC813452
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E92B2191A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D05C098;
	Thu, 14 Dec 2023 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSHhuf5j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0791FC6
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702566791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ79FmjjPCNVzAGPAHYNPxV+2uxiGR+nSxB6va4aTn8=;
	b=QSHhuf5jXGbB7AdfpfdB3pylKUpjKCt4Ygy2oDI7AoLfpWl6NdB4frgTqEkbIIhEDSZCw6
	aQ+v6ppn7CkSPfuiQ8rgcPHKAGE8B7/0tZla1eXhDUZdC5qZiPGqg0FzzTktefItjYqMZ8
	hx5+VGqLplWenZcCx+9oWm9HyQrRMy0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-3XflVeqoM2aLlu_BqxNN9Q-1; Thu, 14 Dec 2023 10:13:10 -0500
X-MC-Unique: 3XflVeqoM2aLlu_BqxNN9Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5e2aa53a692so22300757b3.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566789; x=1703171589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ79FmjjPCNVzAGPAHYNPxV+2uxiGR+nSxB6va4aTn8=;
        b=hpDV7ngw9/F54684BC71rqKxD9YgKQ7MES9/Z3Lo+YN5UYWcy7G1d2cd9YOHlSoL/o
         8ZcW3nZeF91CfhwyPyb+bdkgufjVH6gtAYJBscnQaCdoz2+5PygX7cebdfOT1BFm8duf
         RHToPwWveiw+T8eU55lyryj/mDLKGKI60CZKj6aV8OuOG2KIcLB+QPMLBKxOaH69xZQ2
         dsQgL7ERzkjD4bpU5jcuva5m6/fx1Wm7llfqAq4EOmobF3ixZHqjMO/CyvBJncweY+TE
         aULfydEFAw6/SKnbGwsGzjrNOu1zOasN7p/7BYWsNmyLqFBb6wmdDQd+4XtEcpSdolIh
         h7UA==
X-Gm-Message-State: AOJu0YxQXZk/i7XWW/7qg3+ozMCOVlSFO7NpcJj2ICSqIc451sbtKjJu
	ubznCyEX4XsXdU/zPEBafZrqGtk+2jUOLFzE7Mcallw+gyiaLNtveG6Ci7PHFZFwT7FKn/NiHFN
	b5GqI1eMeRCfBY4WyEdFt2/KrW0FMsabL
X-Received: by 2002:a0d:cb8f:0:b0:5e2:82ec:7156 with SMTP id n137-20020a0dcb8f000000b005e282ec7156mr2962187ywd.32.1702566789441;
        Thu, 14 Dec 2023 07:13:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQqCaLl5i21W9CMh7N2+Rl07zELQZVVb3jyU44JbeSmdxS4TaPEXVTBQW+5PMhV7xSxwEnbHW9iEqmOJArgLc=
X-Received: by 2002:a0d:cb8f:0:b0:5e2:82ec:7156 with SMTP id
 n137-20020a0dcb8f000000b005e282ec7156mr2962173ywd.32.1702566789201; Thu, 14
 Dec 2023 07:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213224146.94560-1-donald.hunter@gmail.com> <20231213224146.94560-9-donald.hunter@gmail.com>
In-Reply-To: <20231213224146.94560-9-donald.hunter@gmail.com>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Thu, 14 Dec 2023 15:12:58 +0000
Message-ID: <CAAf2ycnV-z8EWM=QBgJFgjVsE_AfeoJqZEqP_woW8Q9OmnHd8A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/13] doc/netlink/specs: Add a spec for tc
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Jacob Keller <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 22:42, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> This is a work-in-progress spec for tc that covers:
>  - most of the qdiscs
>  - the flower classifier
>  - new, del, get for qdisc, chain, class and filter
>
> Notable omissions:
>  - most of the stats attrs are left as binary blobs
>  - notifications are not yet implemented
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Based on the "ovs: remove fixed header fields from attrs" patch from
Jakub, I should do the same here before the tc spec gets merged.

I will respin with the fixed header fields removed from the tc op attrs.

Cheers,
Donald.


