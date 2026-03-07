Return-Path: <netdev+bounces-265038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNgYEWSaq2nYegEAu9opvQ
	(envelope-from <netdev+bounces-265038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:24:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2023229DB3
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54A22303D330
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90762306486;
	Sat,  7 Mar 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8D9ZDxQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4950276;
	Sat,  7 Mar 2026 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853857; cv=none; b=T7engPR9eR1+8CyROIikopt2akUjccqD0IxJqeyjDr2Q74nFwPz3K4kZSSUWOs6mF+B+I1iTsysLio6m681/nUnDmXiemgm4TiZfBSsFA/KnehoyYm+5ERXkmoUHzbkPCwgMhDh2fLlD+DNExi2PENJE/9oAjiEFzWgT/Ti4hgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853857; c=relaxed/simple;
	bh=jIv3sOHtJjuB/+XXvI8Bxis4UESLQaEEa9vaYq8Zcdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gluXt9dGrOCV799jE7TSpjA44KNhzeP82pTB56X/br73k0VChnaQtZebanBU48lZKnioRNM9FaQM6ztQ36319c52J+ZjJUVusDNu1psx4sICv1zbHDqp5UtSaBOrhIAUd0na01eOqoXQABNF9bW0mhIegb3XleJPAxAqT7jguso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8D9ZDxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E390C19422;
	Sat,  7 Mar 2026 03:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853857;
	bh=jIv3sOHtJjuB/+XXvI8Bxis4UESLQaEEa9vaYq8Zcdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8D9ZDxQzP0n93VolUxT8V36DK0NIXx/KqND7mhaNstcfQ4v98rYt82t3EtDdYpdN
	 PHhaeTEr+4+HbMyjYq9IyTks0WhtPP5nrXKpyjRLOQGAuLSF5sPApNnG440ZW3MqCA
	 yEIwO6fqrPkTorAEUrLyW9Vxw3G5Q6vqcSblfnjAEgAmVbohdstfW+XcC+yDFF/mFL
	 fx4GxHIp6MDpYRW4PxgZ3t2+aetwroQP3jgAuSrvhTfBhHyDlq0HyWx1MdA7kT4D9N
	 0cNuWFnUJJUAag49Z+yKw5phqXtUvPPlc/Tqsp+l4m2Zy2Z2R4B5p7forZ/SQwetnV
	 qLazlrUmhs46Q==
Date: Fri, 6 Mar 2026 19:24:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Ilya Maximets <imaximet@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v3 1/6] selftests: net: fib_tests: skip rp_filter
 test if cls_basic is unavailable
Message-ID: <20260306192415.62d9fb03@kernel.org>
In-Reply-To: <20260306000127.519064-2-aleksey.oladko@virtuozzo.com>
References: <20260306000127.519064-1-aleksey.oladko@virtuozzo.com>
	<20260306000127.519064-2-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A2023229DB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265038-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 00:01:22 +0000 Aleksei Oladko wrote:
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -441,6 +441,8 @@ fib_rp_filter_test()
>  	echo
>  	echo "IPv4 rp_filter tests"
>  
> +	modprobe cls_basic || return $ksft_skip

tests expects all options in tools/testing/selftests/net/config
to be enabled, we don't intend to cater to custom builds

