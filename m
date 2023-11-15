Return-Path: <netdev+bounces-47899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D517EBC9D
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6DDB20A68
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34140642;
	Wed, 15 Nov 2023 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IULjTcFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE69473
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C83C433C7;
	Wed, 15 Nov 2023 04:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700022659;
	bh=rHQmZPYesAU8iHPEAXrBPpzC8QErB//dUoLj6rkTmbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IULjTcFhI3dmST8rNZHHRilr0kPawPHhRhG3y7+n5yv25MArOAy5GKJ7w2MxHhqKi
	 i0kHDjL5h4AwU2tvBaPlW5/Q59cF3oFgIyagfzkD5hS1VOC1eLrrsEsGQarbhiJaVb
	 rAr8pJhT7WYwlB5jn3A/Qb72iEYRJ4A2xq+rmiMEomLgK9iMgfadbRzhmDQ8wAAD00
	 9y1ODdZgWo2kNSJSB2bB1tjidUrgjwWjbhD+06GhIOgkexN+amZaJ2a8hebCllNlIf
	 hlfbgbVpy7hitJQwCB2fW/eaKn3qAnLZD+xfbILdP9fJ//fXYnelxbWY2aW6q6exGe
	 Hsw2JjOizttNA==
Date: Tue, 14 Nov 2023 23:30:56 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v7 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
Message-ID: <20231114233056.5f798249@kernel.org>
In-Reply-To: <20231113233301.1020992-2-lixiaoyan@google.com>
References: <20231113233301.1020992-1-lixiaoyan@google.com>
	<20231113233301.1020992-2-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 23:32:57 +0000 Coco Li wrote:
>  create mode 100644 Documentation/networking/net_cachelines/index.rst
>  create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
>  create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
>  create mode 100644 Documentation/networking/net_cachelines/net_device.rst
>  create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
>  create mode 100644 Documentation/networking/net_cachelines/snmp.rst
>  create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

Can we add a small MAINTAINERS file entry for these files?
To clearly state who's taking on keeping them in sync?
Maybe Eric?

