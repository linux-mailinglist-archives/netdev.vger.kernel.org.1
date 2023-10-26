Return-Path: <netdev+bounces-44489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1B7D8461
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C332B20FD2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD82E646;
	Thu, 26 Oct 2023 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQdw5NFC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF471848A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A5C433C7;
	Thu, 26 Oct 2023 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698330005;
	bh=ywpSF45QICbahUWWhznkYrdYXFXZq4D/vBvHkybPSSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQdw5NFCg1Pv2XXCWbLCVsCQrz7xiU0fAKQIn6PiAuFTl7tXtWvQM8O+rZ7m8Mpx+
	 qgAfdyV21+sdzjn+Zrn6wVdiMHZR080BFxJguJthV4QhQVhS95Iq4i/yIv1zChWJ/B
	 IwjmIeN8L7qHjE7JtIDExM/WfLtu10szHBKmU/xJmnJNk3WhZv/pZ1j7UsqmLvyPE5
	 w/0B2ZjM8nPy4KGi5dSDMpM9I6GhXUCWAZ1CQDWXqkgtpw+orJOgkMPEoPsQVo4OYT
	 k6GjmmDxGvezzsKSgYLOuTjAYrjUay+JKHgh+PK5MjD7VZZvs3ACOVOmUxw9BjgHRb
	 0f6MxxgPOaW0A==
Date: Thu, 26 Oct 2023 07:20:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path
 variables
Message-ID: <20231026072003.65dc5774@kernel.org>
In-Reply-To: <20231026081959.3477034-4-lixiaoyan@google.com>
References: <20231026081959.3477034-1-lixiaoyan@google.com>
	<20231026081959.3477034-4-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 08:19:56 +0000 Coco Li wrote:
> Subject: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path variables

s/smnp/snmp/

> names of the metrics. User space binaries not ignoreing the

ignoring

> +/* Enums in this file are exported by their name and by
> + * their values. User space binaries should ingest both
> + * of the above, and therefore ordering changes in this
> + * file does not break user space. For an example, please
> + * see the output of /proc/net/netstat.

I don't understand, what does it mean to be exposed by value?
User space uses the enum to offset into something or not?
If not why don't we move the enum out of uAPI entirely?

> +	/* Caacheline organization can be found documented in

Cacheline

Please invest (your time) a spell check :S

