Return-Path: <netdev+bounces-285938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL2CDd8c/mnymwAAu9opvQ
	(envelope-from <netdev+bounces-285938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:26:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC74F9F36
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD05030297B3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDA9388399;
	Fri,  8 May 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzactBeb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6C37BE62
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261212; cv=none; b=TQaNd3+3TOoKsHHAXb78qDQgQBeVnYp26D2ZZT8PWrBUC0+wMz9mfOno/HlOlQwoXG/4cAUXdSKdMSDtaqRoInyUwhwszyOhGBEa/xqfdXPBkELhmVnKN6G5plEsa1xv1vEyM0qyUm9YmR3wq9QR5DQA6TTIvHVP5We3bCZkdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261212; c=relaxed/simple;
	bh=Jm7pHPykzXvhlBTyVsKD/1Cl9+n7bKEt4iRr0kDgMTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C900+cNZYoB4J7lwnzTkduULdOiLPlwSh0zWlHV80J4j8ZqKTP3TUJOl6jRX8Agb3eYly00WaL3cs5i+lli8g8vySxixO+O4oqxBwoX6P9R13LykW1QX3Rs/MMgxKz8PmciIG1UldI2zCr3c7+87TkKDsllt1VivO7KsgF2Yjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzactBeb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778261210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ibh7LjPfvBLgT/tpVXxRHveeXcSku8wakGYGI8sSKuc=;
	b=VzactBebpLVKkZ+4w0dCtFqUS+OWtD5IVMWz1rFS4338fPyqlKKsuVQNNhNJKwAROVyFT9
	5SxT6VghIdylZntYMeBoy4xT49JmAVOknR3FemndgPLtYO3IsoGmES8gUWL/STcabJvD2P
	J4CJfLa1xjofyZSfwnDXB0RBABi5nZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-lGVe0lkNNNW2OdIvNWCSWQ-1; Fri,
 08 May 2026 13:26:44 -0400
X-MC-Unique: lGVe0lkNNNW2OdIvNWCSWQ-1
X-Mimecast-MFC-AGG-ID: lGVe0lkNNNW2OdIvNWCSWQ_1778261203
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3B54195608F;
	Fri,  8 May 2026 17:26:42 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F75219560A2;
	Fri,  8 May 2026 17:26:39 +0000 (UTC)
Date: Fri, 8 May 2026 19:26:36 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: add tests for PPPoL2TP
Message-ID: <af4czAjnz--nOUYf@thinkpad>
References: <20260508032158.67887-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508032158.67887-1-qingfang.deng@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 9ADC74F9F36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285938-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pppol2tp.sh:url,ppp_common.sh:url,pppoe.sh:url,ppp_async.sh:url]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 11:21:49AM +0800, Qingfang Deng wrote:
> Add ping, iperf3, and recursion tests for PPPoL2TP.
>
> Assisted-by: Gemini:gemini-3-flash
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  tools/testing/selftests/net/ppp/Makefile    |  1 +
>  tools/testing/selftests/net/ppp/config      |  3 +
>  tools/testing/selftests/net/ppp/pppol2tp.sh | 93 +++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100755 tools/testing/selftests/net/ppp/pppol2tp.sh
>
> diff --git a/tools/testing/selftests/net/ppp/Makefile b/tools/testing/selftests/net/ppp/Makefile
> index b39b0abadde6..6036fa134351 100644
> --- a/tools/testing/selftests/net/ppp/Makefile
> +++ b/tools/testing/selftests/net/ppp/Makefile
> @@ -5,6 +5,7 @@ top_srcdir = ../../../../..
>  TEST_PROGS := \
>  	ppp_async.sh \
>  	pppoe.sh \
> +	pppol2tp.sh \
>  # end of TEST_PROGS
>
>  TEST_FILES := \
> diff --git a/tools/testing/selftests/net/ppp/config b/tools/testing/selftests/net/ppp/config
> index b45d25c5b970..8bc3b7c33d5c 100644
> --- a/tools/testing/selftests/net/ppp/config
> +++ b/tools/testing/selftests/net/ppp/config
> @@ -1,4 +1,6 @@
>  CONFIG_IPV6=y
> +CONFIG_L2TP=m
> +CONFIG_NETKIT=y
>  CONFIG_PACKET=y
>  CONFIG_PPP=m
>  CONFIG_PPP_ASYNC=m
> @@ -6,4 +8,5 @@ CONFIG_PPP_BSDCOMP=m
>  CONFIG_PPP_DEFLATE=m
>  CONFIG_PPPOE=m
>  CONFIG_PPPOE_HASH_BITS_4=y
> +CONFIG_PPPOL2TP=m
>  CONFIG_VETH=y
> diff --git a/tools/testing/selftests/net/ppp/pppol2tp.sh b/tools/testing/selftests/net/ppp/pppol2tp.sh
> new file mode 100755
> index 000000000000..5ddcc6c41c33
> --- /dev/null
> +++ b/tools/testing/selftests/net/ppp/pppol2tp.sh
> @@ -0,0 +1,93 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ppp_common.sh
> +
> +NK_SERVER="nk0"
> +NK_CLIENT="nk1"
> +OUTER_IP_SERVER="172.16.1.1"
> +OUTER_IP_CLIENT="172.16.1.2"
> +
> +PPPOL2TP_DIR=$(mktemp -d /tmp/pppol2tp.XXXXXX)
> +
> +# shellcheck disable=SC2329
> +cleanup() {
> +	cleanup_all_ns
> +	rm -rf "$PPPOL2TP_DIR"
> +}
> +
> +trap cleanup EXIT
> +
> +require_command xl2tpd
> +ppp_common_init
> +modprobe -q l2tp_ppp
> +
> +# Create the netkit pair
> +ip -netns "$NS_CLIENT" link add "$NK_CLIENT" type netkit
> +ip -netns "$NS_CLIENT" link set "$NK_SERVER" netns "$NS_SERVER"
> +ip -netns "$NS_SERVER" link set "$NK_SERVER" up
> +ip -netns "$NS_CLIENT" link set "$NK_CLIENT" up
> +ip -netns "$NS_SERVER" address add dev "$NK_SERVER" "$OUTER_IP_SERVER" peer "$OUTER_IP_CLIENT"
> +ip -netns "$NS_CLIENT" address add dev "$NK_CLIENT" "$OUTER_IP_CLIENT" peer "$OUTER_IP_SERVER"

Is there a particular reason to create the test setup with a netkit pair
instead of the more standard veth pairs?

Thanks,
   Felix


