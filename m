Return-Path: <netdev+bounces-285065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK6BCvLD+2keEgAAu9opvQ
	(envelope-from <netdev+bounces-285065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:42:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52D04E1564
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC2BA3009B29
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D33793CD;
	Wed,  6 May 2026 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Gs9krC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458023793B0;
	Wed,  6 May 2026 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107374; cv=none; b=E+CJFlaAMjFbD5cRxMbzsGSuN4FlmIwKLBZwui0smZkZS5TWhyY7gBvOTyc0XVVVkK5vusgk+qcxpVoy+aUtQ+TeIVZ69aumgtn9ewGbjzSsqigiEli1LmFoNldGkIVRSbhzUxtIhyE8XoQMwI6AjKRQwLecmqUEG9EPdKglasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107374; c=relaxed/simple;
	bh=E/WS6QkygG9jH7w4Y7Tty3k6UJMDQoP3S4LhV6TVsY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZenlBosYCJNoozQr4l8w+yJLBwzESNwrhrhIoHMO3TSAcITpd2VBJGXt0zJrQeDuOmDHQWdIFRcfcxdViqBmjIyvNxKpwXArPAbefoeeYjkRlUdvoTrhvoZFTePWrfndrD40/207SQTHeG6r18XUV5H1Vr1ivsDT6T+T9uwJ/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Gs9krC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BA9C2BCB2;
	Wed,  6 May 2026 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778107373;
	bh=E/WS6QkygG9jH7w4Y7Tty3k6UJMDQoP3S4LhV6TVsY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+Gs9krCqZ8uNuQYltwqb2dLUpqGRNmjuolYwEgj2gAZoFO/MSO2IcSEtNvtx32Ce
	 reqexpAKkdC1lsy7xlxQbD5JHsOOFHWw3HJrrfVvIvmpA+tIYvV+Dxvf1QIYRGXKY7
	 KhLnxDNTH7xBJnieV/MjH1v6EYZtaLG0yW9j8a2YXOzypy+BPRtU9ClGWG9sGRgB0s
	 +2r1FSoyXgZ8Mqfr2UAAYgcJvfpIDBmPrG3oMLvDVoS7OptOyF4ntj7FSE+rKE0Up1
	 blbscUmiVlcR8ZeBIlXt7DMYTu6hmWYWsCSBCvy/7nClsekUZUNHvRc/ygP4vAKUV3
	 fRTxb0wXwhAjw==
Date: Wed, 6 May 2026 15:42:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybw==?= Costa <alvaroc.dev@gmail.com>
Cc: jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org (open list:DEVLINK),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] devlink/param: replace deprecated strcpy() with
 strscpy()
Message-ID: <20260506154252.65d673c2@kernel.org>
In-Reply-To: <20260506211415.16343-1-alvaroc.dev@gmail.com>
References: <20260506211415.16343-1-alvaroc.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B52D04E1564
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285065-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed,  6 May 2026 18:14:11 -0300 =C3=81lvaro Costa wrote:
> Replace strcpy() call used to extract a string parameter from param_data
> with strscpy(). Since strscpy() already performs bounds checking and
> ensures the destination string is NUL-terminated, remove the string
> length check as well.

The current code validates the netlink attr is nul-terminated.
I'm not sure if your patch retains current behavior.
I am sure, however, that checking whether the change is correct
is a poor use of everyone's time.
Please don't send these sort of patches for networking.
--=20
pw-bot: reject

