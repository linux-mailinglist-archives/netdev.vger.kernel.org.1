Return-Path: <netdev+bounces-286655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDNXD+vfAWptlgEAu9opvQ
	(envelope-from <netdev+bounces-286655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:55:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC450F6F3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3933045EDA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B93ED10F;
	Mon, 11 May 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1dT215E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E33A6B8E;
	Mon, 11 May 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507251; cv=none; b=Uj9QPOWFia3W5k0DV6aT5AFApFRTH4tN0Dws34MCWdECDroY3SQ0Au3bRyOK3DaWO+HihcNuHfEuj3wNWImwMQzikrTK3C2cPEQ8/UPxP/+SiSwdrOZOW0c8FixVH2QigU03tlCKsRjSaeeA/7ddl/zq72esN6JRsCmdkpIsKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507251; c=relaxed/simple;
	bh=tLEp70UHG/EuCtRgDahvTDvSVaeMSKrr5gp+ozE1qW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrRAaJ9pJZT85lptuBWRfPuNrdQRkFGVgl8JClV+Jozzs/ofRWLbvdLxwnOYTbb3lGs2isDUFquIiu77bAagQlk+z/KdDsoJizEEyQxt8YdfhXdTkEk/mB6C6G9Hq67s4zTOnbO/+zXJdBFic0GFgH813TkU8eiWTLmdJj4WZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1dT215E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F12C2BCB0;
	Mon, 11 May 2026 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507250;
	bh=tLEp70UHG/EuCtRgDahvTDvSVaeMSKrr5gp+ozE1qW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1dT215Eo1W/iomsuPqD/B4aeP3cPbUVynPZPTZO3/3aHSKkzOBx9TZLq7cXhnchL
	 Cw6V1i3ubK4zwonDCjV91jJoXY1q8e1FrEebMyrZKfGzbqOkwVrIqxyNYoPpBHYZ4Z
	 YI3EahzXHL6E/wQLxw/JNUgeQrUK7mmiu/T03CfJJfdAClAk+fwjKaaFISo5bfXSWZ
	 r5HoIMImqRKTVQDV6aDQGnkOmsvHF2HJRjISoqYCx1OBBg9Hfx74mnydsJLgsipzjf
	 JNB1XOgdNtWiLYjbRyuZNMam+ziA5JxKN/jM4C96uuD2oUycYzdXMpUEYoS3w9VWih
	 7vful3DVMisXA==
Date: Mon, 11 May 2026 06:47:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next 6/7] selftests: net: getsockopt_iter: cover SCO
 BT_CODEC conversion
Message-ID: <20260511064729.11c507b1@kernel.org>
In-Reply-To: <20260511-getsock_three-v1-6-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
	<20260511-getsock_three-v1-6-1461fa8786ab@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02AC450F6F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286655-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 03:41:51 -0700 Breno Leitao wrote:
>  tools/testing/selftests/net/getsockopt_iter.c | 65 +++++++++++++++++++++++++++

please don't add Bluetooth tests under net/ (or at least they must
cleanly XFAIL if Bluetooth is not enabled). Also Bluetooth has its
own tree so not net-next in the subject.

