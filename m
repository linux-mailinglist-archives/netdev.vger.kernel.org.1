Return-Path: <netdev+bounces-266888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MV4M7AwsmmzJQAAu9opvQ
	(envelope-from <netdev+bounces-266888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:19:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4FC26CBD5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4819C302EEB7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB1386C22;
	Thu, 12 Mar 2026 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkC/xYlR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA233A01E;
	Thu, 12 Mar 2026 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285460; cv=none; b=bl2wVPayK8BThMp+n8Ejc0MCGguujRyKfXumCnU4zZXg1qJ3kWf6MyHOifw6t5SlE6+5j6oxNnqmyrZdjL1KUOg+D/vaMS2AM6GV9CwlXw7vz8wDLBSd83vKmsjhVaBpdxMlfKvlwz6aBLJk4d53qi/08sjMrdZi8W7sleuNUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285460; c=relaxed/simple;
	bh=+WxW6/yIo2Ep3nh5FOLuEDKSZQuxeuswe0hpbsE9vsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNEYVkaDz6B32cAKIeyWZnlWkzcI3RjhBqSK5U3iY/3Hbk7xm5DsXC0VDJhhmiI7GvLAqiMaolaeWOEeatBIpC8IHPJfRyfozXBGN3yPN4ZSbZP6VnVl9ViV6fkcFSTX6xyWGTOgNGEOjnRqf9SZ/Iet8OCN16QIc2hAvGZtYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkC/xYlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A74C4CEF7;
	Thu, 12 Mar 2026 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773285459;
	bh=+WxW6/yIo2Ep3nh5FOLuEDKSZQuxeuswe0hpbsE9vsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GkC/xYlRHo3AiL1x4fsUFC+sxSqLrPU0SxmF2F6CZquF6q9ESVzhUoZWcHOQih/DX
	 0xqJxa5Tb48hVifrhuzNFXpEFbyJ3OFZOAmDGN7uwrcCRtMnmVvsF/12Bj3a+5FIPn
	 I6oLgjfoDLJkmW7llXhjTJdxc4OpAY5oBYg/TMmqNLk15n0DOlFwZx4MICpWoF335Y
	 e+tZeV4+uXog93GPUGn6OG3wrj0S8ChJUMlZnMDhO05LWB1+ZzLmeDnFH6RlhRd1Yy
	 sE0mFpPblCxg9OE6lBSzG6x0VcbJe6ccDU1J7bFDvGe9y6ixVz9Djzk7n3TZAhyyzu
	 G+ZmKrt60FFEA==
Date: Wed, 11 Mar 2026 20:17:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next 5/9] selftests: ovpn: add notification parsing
 and matching
Message-ID: <20260311201738.20d816bd@kernel.org>
In-Reply-To: <20260310145006.30858-6-antonio@openvpn.net>
References: <20260310145006.30858-1-antonio@openvpn.net>
	<20260310145006.30858-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266888-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C4FC26CBD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 15:50:02 +0100 Antonio Quartulli wrote:
> -TEST_FILES = common.sh
> +TEST_FILES = \
> +	common.sh \
> +	data64.key \
> +	tcp_peers.txt \
> +	udp_peers.txt \
> +	../../../../net/ynl/pyynl/cli.py \
> +	json
> +# end of TEST_FILES

needs alphabetical sorting

Please do use/steal the script from NIPA that validates the format of
Makefiles, cause it's really easy to make a mistake on these
https://github.com/linux-netdev/nipa/tree/main/tests/patch/check_selftest

