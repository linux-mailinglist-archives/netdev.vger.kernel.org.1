Return-Path: <netdev+bounces-258173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EswG0nli2kVcgAAu9opvQ
	(envelope-from <netdev+bounces-258173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:11:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCF120B59
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2D6F300C037
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1892F3C3D;
	Wed, 11 Feb 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwzdjNgz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD722F6574
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775878; cv=none; b=RuvRnAeUjm3svz6MMLJeWkwmtrI8wMsJpnEEcgD4M/uT+OQvIBSHoXV91yWVH8tnx5KrHr4lkq+cFYYhE57+oxOpIEYlTBnpCbfSVYmsFz3A/RmDiDIih0rBJj0oX2O2bViPwHgv2oqUi1XIiu8bmKNyw+fGsw1UfuZli2YXNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775878; c=relaxed/simple;
	bh=pwjgTaJxqoUwexUfJ0seJxAeeOxDbZFNQHt9s+xJz88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KN/TKtA0lKdsiLezAZUj8FXXGiQDbKR4l9fIhn9OlJzB3KQSziocyHb6LdLhZnH9gQH6jVytwZCuU1YeGh0B1NhGw4duEuNrhHxslJlrXTiPi7PRTUHpDTn+6auJmeIWwNIH4sUCI1tRHVRQREeMQO89NS9DXlWdCgiLI9yjJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwzdjNgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30F9C116C6;
	Wed, 11 Feb 2026 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770775877;
	bh=pwjgTaJxqoUwexUfJ0seJxAeeOxDbZFNQHt9s+xJz88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwzdjNgzO1Kl3KiAsqp02DxQEVLMKZAeVCv7DquEx9bDAVv2riFQsvEC1kN5hYHA6
	 giAMPU1Cpe7r4WFz60m6f2dylotLLwSJ/DlthxZdSXjn4+vpLqsWf4HIi9xsoYdlIG
	 IML8eBV8tye6YTwIFr4m5ziT9fNmE3KDcq57h13UYh0LIq0qUn4yZDVtuhRLmPg4Nq
	 hSdm+yd6yeJwYEKC+NIAtM1Jew/tW1mdSthFoQlmGCBucr5BgQ3YdDIfqGP26QIG9S
	 dtegT46aQEFsIPScXERFAX4GeqFEoAFeOOKJCZsMl+LYyk0jD467ccF9mvwHFryRCq
	 Ke/NfLUYZjlOw==
Date: Tue, 10 Feb 2026 18:11:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc =?UTF-8?B?U3XDscOp?= <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v4 4/4] selftests/net: add no NDP b/mcast,null
 poison test
Message-ID: <20260210181116.1dea39bf@kernel.org>
In-Reply-To: <67615bd24a429899f500a248bb2a0bd261d71c84.1770399836.git.marcdevel@gmail.com>
References: <cover.1770399836.git.marcdevel@gmail.com>
	<67615bd24a429899f500a248bb2a0bd261d71c84.1770399836.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258173-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AFCF120B59
X-Rspamd-Action: no action

On Sat,  7 Feb 2026 21:40:36 +0100 Marc Su=C3=B1=C3=A9 wrote:
> @@ -171,6 +172,7 @@ TEST_GEN_PROGS :=3D \
>  	epoll_busy_poll \
>  	icmp_rfc4884 \
>  	ipv6_fragmentation \
> +	ndisc_send \

This needs to go to TEST_GEN_FILES, _PROGS are tests in the kselftest
makefile framework (somewhat confusingly). If we add it here ksft
tries to run it which fails:

# selftests: net: ndisc_send
# 0.01 [+0.01] Usage: ./ndisc_send <iface> <mac_dst> <mac_src> <dst_ip> <sr=
c_ip> <target_ip> <op> <lladr>
not ok 1 selftests: net: ndisc_send # exit=3D255

