Return-Path: <netdev+bounces-291333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONPHHQ1ZFGofMwcAu9opvQ
	(envelope-from <netdev+bounces-291333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D15455CB9CC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025A9302B778
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3B38655D;
	Mon, 25 May 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b="qkmwoldY"
X-Original-To: netdev@vger.kernel.org
Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB81991CB;
	Mon, 25 May 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.81.229.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717922; cv=none; b=dA79rK5wO2mSd8kYiUhzFmGOKE6rEivlvYJZRSxSEdbW54I1srqa9ywCIgDlz64MACMKS/I3pHRZoOKxfZDb4neUW52okSjMsFRPniAmNxeqBgSn5zG6wj12lYZyGU/lB6aRjaV88SkWDTTrIL6YxAa/KJ4MiUvzmZ3J/smfgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717922; c=relaxed/simple;
	bh=r/TJfs2FjL308K6t4+w4fchQ51JmwkBTb0M9HQq5j5E=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M+YgZZU+NZPnE+Ux/U+nIuCa9oYKv5yuQYtQfj+wQxN74IwZWdl9N6FAMwTMJtDEHc6bPuYqLDMMEYsF6aQ3z6DQItR+ENl5oR3xkKmom8ixiSy2HMnZv3PoxRA4kVd4bxzUOeKktB3qZkesNJKpf9dQlA4F1NAP7cnD+zPxw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech; spf=pass smtp.mailfrom=chaosmail.tech; dkim=pass (1024-bit key) header.d=chaosmail.tech header.i=@chaosmail.tech header.b=qkmwoldY; arc=none smtp.client-ip=77.81.229.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Received: by chaosmail.tech (Postfix) id 52D991C7F11;
	Mon, 25 May 2026 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1779717918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjnVfgz6zh4SF3gMbSx456mbBro9ABf5bWAoYvwZu+I=;
	b=qkmwoldY0R8w+0rmZMTmWCi+CcadvVw6SdMk05tvUh+mSzuoKZNKjflD1vD3kyAKK4bVSX
	6PPOEqV3T0ZbsgKWxHiIXodhBmSP+qGfbpzj8QH6rlxH2Oq8b+4I9ztkiNyUUijA1W3Dh5
	wkm//BnOjkZZALJNM4Sp91l2ai8I2qU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
Date: Mon, 25 May 2026 16:05:06 +0200
Cc: Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <172D11E7-AF98-43F8-B41B-907738749EA5@chaosmail.tech>
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
 <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
To: Joshua Peisach <jpeisach@ubuntu.com>
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291333-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[chaosmail.tech:s=mail];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,gompa.dev,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[chaosmail.tech,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@chaosmail.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[chaosmail.tech:+];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chaosmail.tech:mid,chaosmail.tech:dkim]
X-Rspamd-Queue-Id: D15455CB9CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> On May 25, 2026, at 15:58, Joshua Peisach <jpeisach@ubuntu.com> wrote:
> 
> On Mon May 25, 2026 at 8:11 AM EDT, Sasha Finkelstein wrote:
>> 
>> + cmd.enable = !!enable;
>> +
> 
> Probably a dumb question, but worth asking - what is the purpose of the
> "!!"? Wouldn't just passing "enable" be sufficient?

This is a way to enforce that the value is exactly 0 or 1, not 0 or non-zero.

> 
> Also, currently, cmd.enable seems to just be set and used in the case
> of boolean conditions. Would it make sense for the enable field in
> brcm_prio_cmd to be a bool or does it not really matter?
> 
Opposite, actually, this struct is fed to firmware, and it needs to be
specifically a u8.


