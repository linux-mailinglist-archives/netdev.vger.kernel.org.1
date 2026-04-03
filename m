Return-Path: <netdev+bounces-275202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d9izBg0g0GnU3gYAu9opvQ
	(envelope-from <netdev+bounces-275202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5661C398169
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8EB30221EF
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A22BE7B6;
	Fri,  3 Apr 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvzHTlAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FD279358
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247370; cv=none; b=fgLNZBmxPThaaVywwX0hmegG/mk6zL+v6EKejgDUQNXMorlgmI6ypR5yK1JaZZuSWE7OGRpEKEeWm4kC8A1X7dV4L3VE2SnnpKe1v5XwFrtuaU6lR7RQVwwEVjh6oV9wfpMHOOAvwbnExkPwVBfwAOt6RO9OtV1mu8TFyOrNY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247370; c=relaxed/simple;
	bh=kRsdmDX7gWtEfL1NZRFie0sO06YIDWSyDlF7Xu3tDWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDF0cSOzqnABeHP4E2UDMonJBJWcG3R0nqKKjJjYiNMut/xH20G+2vSnycL236Xhm+CjIRTI+VayN8AWq/hpqzzm0dDPz/a2gZqJdcNt286kWJ42xwh87jvqmffRYBuDPsZXNrx/uKKYEkqPQcObIw7shJaiUCJd0Ggzt4qnLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvzHTlAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA9C4CEF7;
	Fri,  3 Apr 2026 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775247369;
	bh=kRsdmDX7gWtEfL1NZRFie0sO06YIDWSyDlF7Xu3tDWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RvzHTlAtPtAmNh71kFPkZpvTiNN0MJD5T9aQD9BS65FHMPtKOXzYpanOM/QjD0zaz
	 AT9dc2tl2Oe2/iwh/uxivINHUKBGC/DwHxWeUOtF8lJqZs/VO95Teo9s/9IE7mCLeO
	 0EWLc2aoXZ8jymJcDbU9vTezHRn53kwR+MItlWF+J/ngvY6P8WowCKOUHokkUfvIXG
	 1YKAkP3XX2i+LFYG7oN7kwNIMXXplow01lln9hsuA1nsCJ1V/TzKANtP8xzDmrMJSY
	 7I0mQOjLGzKGJnqT4ihfRh24PnO8e7Or5IBRFBQbFnCC0Tzeoww4lhxBlOy1ZCuhUW
	 qNa5Lbh3LzpIw==
Date: Fri, 3 Apr 2026 13:16:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juanlu Herrero <juanlu@fastmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] selftests: net: fix checkpatch warnings in iou-zcrx.c
Message-ID: <20260403131608.4b8fecb1@kernel.org>
In-Reply-To: <20260403195754.10619-1-juanlu@fastmail.com>
References: <20260403195754.10619-1-juanlu@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[fastmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5661C398169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 14:57:53 -0500 Juanlu Herrero wrote:
> Subject: [PATCH] selftests: net: fix checkpatch warnings in iou-zcrx.c

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
-- 
pw-bot: reject

