Return-Path: <netdev+bounces-285083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNQhEhjX+2mzFQAAu9opvQ
	(envelope-from <netdev+bounces-285083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:04:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB64E1A7B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 512DF30075C5
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B2B40DFA9;
	Thu,  7 May 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCJ8wYWb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E67800
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778112276; cv=none; b=GoCU3yJk0Vs9nRWIF9u7UqRCiLZGt+qONCz24NHbz5qP9gDm6JYi03zvLPILcujqsXGWkqo1LPX0J48hsSUVilqDhumg/W24uT5fplpjf/oa6cepStWbgZgRF6H2WFWvHonBdLvd5DDoG0GJ7ZNNH0u7VrN/5Yq7c0+ObEuqOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778112276; c=relaxed/simple;
	bh=Tg5TruUAInPgPbeh2Se6Ejd6i06XFBwHuLdZW2mdD7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6zUA4daQtSUI/db7GwI1wLoWUvzJRcuXDlHpQqBdtaaQOCIet/nfIvn0PqahtqY/PNeBwIY6mTutzyNNKx9m/rNNJBT/tUwrsKdy/c1Bb0AcJGM3l8NEUP70SVPMgFJnq8ShXWu801IjfdIFVSxvMTy9pR4tGMUf5wbkwRBtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCJ8wYWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7FBC2BCB0;
	Thu,  7 May 2026 00:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778112276;
	bh=Tg5TruUAInPgPbeh2Se6Ejd6i06XFBwHuLdZW2mdD7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCJ8wYWb/jsv4jHyYpJoqrYDbHbAV1nkKreWJOqNOtl6c/nbNBa3/KJ1G0tB8gPbS
	 zk0ZNJ05PempTLCvB6ufbf1ROvi6y/cPpImMFPUZVrRYounQbRIOIoKHwO9NpzDF5c
	 qTBE65okEhQKeAiSSXTEI3swOih7c72X7drhhpJpeyz4MwgbsEt49rHKPY4Q842Egq
	 3s1swMIxunF0qA80XBBt/0oMRr9ZKiuPz+Pf8or2AU96gTAzg5/i352ieUvmxOkS25
	 3JpHdfLXA9FO2KyYBHanTQrSBu4JQXRc/twx6BZddUZkI1WS9gK4XdyV+TZItXzZ2e
	 MjCJpE/J8BVrg==
Date: Wed, 6 May 2026 17:04:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/8] tools/selftests: Add a VXLAN+IPsec traffic test
Message-ID: <20260506170435.34984dfc@kernel.org>
In-Reply-To: <20260505132326.1362733-5-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
	<20260505132326.1362733-5-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97CB64E1A7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285083-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, 5 May 2026 15:23:00 +0200 Steffen Klassert wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index dd50cb8a7911..ae0168c2bbe6 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -12,5 +12,10 @@ CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
>  CONFIG_NETKIT=y
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_INET6_ESP=y
> +CONFIG_INET6_ESP_OFFLOAD=y
> +CONFIG_INET_ESP=y
> +CONFIG_INET_ESP_OFFLOAD=y
>  CONFIG_UDMABUF=y
>  CONFIG_VXLAN=y
> +CONFIG_XFRM_USER=y

Oh, sorry, changed my mind we can't pull this:( both the Makefile and
config break alphabetic sort, our CI will flag every incoming as red 
if we merge this as is, we need this on top:

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3b6ff4708005..82809d5b2478 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -28,12 +28,12 @@ TEST_PROGS = \
        ethtool_rmon.sh \
        ethtool_std_stats.sh \
        gro_hw.py \
        hw_stats_l3.sh \
        hw_stats_l3_gre.sh \
-       ipsec_vxlan.py \
        iou-zcrx.py \
+       ipsec_vxlan.py \
        irq.py \
        loopback.sh \
        nic_timestamp.py \
        nk_netns.py \
        nk_qlease.py \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index ae0168c2bbe6..8c132ace2b8d 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,21 +1,21 @@
 CONFIG_BPF_SYSCALL=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESP_OFFLOAD=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IO_URING=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_BPF=y
 CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NETKIT=y
 CONFIG_NET_SCH_INGRESS=y
-CONFIG_INET6_ESP=y
-CONFIG_INET6_ESP_OFFLOAD=y
-CONFIG_INET_ESP=y
-CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_UDMABUF=y
 CONFIG_VXLAN=y
 CONFIG_XFRM_USER=y

