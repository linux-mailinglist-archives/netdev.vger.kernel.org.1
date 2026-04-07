Return-Path: <netdev+bounces-275817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKwmGTZh1GnltQcAu9opvQ
	(envelope-from <netdev+bounces-275817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:43:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E54343A8C5A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21943014BDA
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525062135C5;
	Tue,  7 Apr 2026 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGpkZP9/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9341EA7CE;
	Tue,  7 Apr 2026 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526195; cv=none; b=b+FSNtpdl1e5c81w6pftjYBqQVqRzGtgMEk2d7Ywb/2F+xqmTXCkl3it2zbSSoXhKsFNFEbgqEYW3XDgaKjknRPY30sOgNbqK7b/VgdU0/qKYSzczeHcfQvbMHMrEYmHQHjKHM1wv4TEbpYRrDU1vH1ZNV5TP7ilZKukRPo5NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526195; c=relaxed/simple;
	bh=/wFbz7nW/QdAMU7lzO7ww8Rlb/6Og7pScrCkte1ume8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1IOjEWNXCZI9b8dr8K6QD8IIf6vjgr02C023dKLDQOQaWlJlQXBzg9sIUR/dcaq7WuW6fXK8KEm5q+Iua8rz/kKAAPDhMQzsTaLyTWB6fADBCraQbrZ5zem+ThWx0FhpqSlIzXYtvUqvzWykPzxu8IEl08fFjKf4gJi5syY01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGpkZP9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97172C4CEF7;
	Tue,  7 Apr 2026 01:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526195;
	bh=/wFbz7nW/QdAMU7lzO7ww8Rlb/6Og7pScrCkte1ume8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jGpkZP9/1jqW5AypC2rOM6aKCKax0we2yimxgUEBGjSvDEDLqGNRR9sIbNjhbEqWi
	 0h3/Y/KPvR/EKuVxoGcd40yY/xJ0eMRKWISXNN/ORQ/wASsgSf1Zb5tjOv15Wff3kn
	 rL3qiqQZ3uqWFjTv694gH8t/xabJ8UqNiYM7mq5FCID3jOgLSGGOfv4EXl8qPOUlI4
	 XseC6esSeKMz4QkGImsFtOj+G4ETd+zYJtDCT4FGr9WRULdjvH+41Rx9XpyOgieXG5
	 vPKzdmbFsGOAEzNZu8l1Cvzr0RCQ2+FGuA6e/p18NRXTwomvLALmRLfRZ9Z3wpexQz
	 0bnYtwx5ojf4A==
Date: Mon, 6 Apr 2026 18:43:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] ipv6: sit: remove redundant ret = 0 assignment
Message-ID: <20260406184313.5c446354@kernel.org>
In-Reply-To: <20260403084402.4105936-1-yuehaibing@huawei.com>
References: <20260403084402.4105936-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275817-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E54343A8C5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 3 Apr 2026 16:44:02 +0800 Yue Haibing wrote:
> The variable ret is initialized to 0 when it is defined
> and is not modified before copy_to_user().

Makes more sense to remove the init during definition IMO.

