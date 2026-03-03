Return-Path: <netdev+bounces-263469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FvaUHiV0p2mehgAAu9opvQ
	(envelope-from <netdev+bounces-263469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:52:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C01F87F3
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5E1330B1724
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16C3750AB;
	Tue,  3 Mar 2026 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdvuSQ3k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CB372EF4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581864; cv=none; b=dixS4ioVtQu3D1+MP0QhfujqO4WuNanfa9u1AA3u3Dti+f6joJp7CgIhsZpdlbfHgGiBOdrNqaKObGEKVbO2WbPPIblTrobkr3D2Fq8VjhQ+um+PPNCr5G6GCY0hVUwBcLFUHKVae276Ol5Rypcybeij+3/Z6kToG7U3X+ndgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581864; c=relaxed/simple;
	bh=zEgTPChxj4u7k9ir9GB4BDX4ci+E3FeicHFxfp/k7KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoFNPzWHCnOufoDlT96/j1ke2GFHJyfA8Fjzt7jkX5gl2NnDMmB/gvpy2GXGWeddjh1Th/h9ImMt8h5wMI3FB26UIpRh94a0bjyakGtGjnqlWIZd0K539qp6/uQZDvVIqYpOpos/ITx7LXVQdLyMXxNCQDqjEyjvZ9MhGYZNG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdvuSQ3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE36C116C6;
	Tue,  3 Mar 2026 23:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581864;
	bh=zEgTPChxj4u7k9ir9GB4BDX4ci+E3FeicHFxfp/k7KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdvuSQ3kzvLwvQ227WEF35947iSGYaaJouj5a7InLrEe9mY2IR7U88WCp5rZwRwL9
	 B5wlHVIYlDTPBaj7Ey6jKE7pAtHnxPP3JoBPonU0iutp7VdPtpS7fHtX9G2GCMhSpM
	 sP60MgRmUOFcGNd/ky8ZLJYMa4lIaRFPoRLxnE4b50FgsAJ9oy6xUP5ZEFEKO0xBMI
	 LU2qO2l2LSdHomVQ+kW4/lqWs6zM05i24wpat1utMgl6ZrW0bGynaM+CPB3sSC5IkV
	 1AiEkliwshvCV12i1MGpN1RkGDI+hVh6iN7O1e65Dm5Syuu46eNDndZsfYp/ij6HwL
	 TCWz99IKlf/CA==
Date: Tue, 3 Mar 2026 15:51:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Joe Damato <joe@dama.to>, Wei Wang
 <weibunny@meta.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v2 4/4] selftests/net: Add netkit container
 ping test
Message-ID: <20260303155102.1c5de2c5@kernel.org>
In-Reply-To: <20260302053315.1919859-5-dw@davidwei.uk>
References: <20260302053315.1919859-1-dw@davidwei.uk>
	<20260302053315.1919859-5-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 291C01F87F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263469-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun,  1 Mar 2026 21:33:15 -0800 David Wei wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index 2307aa001be1..b6524040418e 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -1,3 +1,4 @@
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_FAIL_FUNCTION=y
>  CONFIG_FAULT_INJECTION=y
>  CONFIG_FAULT_INJECTION_DEBUG_FS=y
> @@ -5,6 +6,8 @@ CONFIG_FUNCTION_ERROR_INJECTION=y
>  CONFIG_IO_URING=y
>  CONFIG_IPV6=y
>  CONFIG_IPV6_GRE=y
> +CONFIG_NETKIT=y
> +CONFIG_NET_CLS_BPF=y
>  CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
>  CONFIG_UDMABUF=y

the sort order we use ignores _ characters:

$ ../nipa/tests/patch/check_selftest/validate_config_format.py tools/testing/selftests/drivers/net/hw/config
Validation errors in tools/testing/selftests/drivers/net/hw/config:
Lines 9-10 invalid order, CONFIG_NET_CLS_BPF=y should be before CONFIG_NETKIT=y


Also here and in patch 2 we're getting new pylint --disable=R warnings.
Please fix them where possible.

