Return-Path: <netdev+bounces-252934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAspOLrMc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:32:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6497A293
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15CA33013D49
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DAB262A6;
	Fri, 23 Jan 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzAeWjou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB83EBF07
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196728; cv=none; b=DdeFoLPJ+xWplSZdMzsUO5MXcPEg9l+RDKukWeswPC0tyy3LK8Fv8dxU1VScUlBqpfzaRDz3ZUs1nEEgpk/d0XW7uHVVdcoKPsPoucgaGYkEHH/ADueTaF2iER1nhguqiSF7cY1OzuYdqc5TwkAkeFaR3e5GzIHeLp8OtWaiFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196728; c=relaxed/simple;
	bh=gbzFp4psNVWVOhtDFbesQI6RSMZKffWxb0sPZAzQIFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxAlgsk7U+gibWV+DPhv8lk9So/f2ydK3cg9x5uuS93W1ixyo2tSvCBz4vxEsDZnRsd6ywEl4e3LUteWj2DkVjY4VmDUfIBVJBbuP+QENw+Yo4lqZ1In1wIuc1GHs7La9GAQ0Lik7szRH8L20C+Kuezs9kSZZ5fmpFtt4jwBNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzAeWjou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46E8C4CEF1;
	Fri, 23 Jan 2026 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769196728;
	bh=gbzFp4psNVWVOhtDFbesQI6RSMZKffWxb0sPZAzQIFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lzAeWjoud4fYXAWwf2j4vuTDX7DdFIe5tG5eKd0rFvJe2WIl82lLNSZmQ5lTm2P5w
	 91EKPdQyKc4Q58vsH+l9yOqWJZEeoa5+/kVt/69olkWPSwRzlxLMO5FD32smDc/h3i
	 W5sdZ1Z+IVBPkPceUw+Yl1ExFgu/oUAeeJJ4SdSbp197MUAurwucKFUEpSphzPBqGj
	 ppvu14twLgF1APXuUKNguFQbzkqP44JL6xnVhaPeXRSyiePN9WpvhkJQFsYySQ3m2P
	 h3F0ZeOtBGDkl9+Lo7c4FD0oicGoPIQJ9FJSHD4DREIwB+RrcTsaHYOzHK4FbXvTlw
	 Sr/XMws0IxqAA==
Date: Fri, 23 Jan 2026 11:32:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me, petrm@nvidia.com,
 razor@blackwall.org, idosch@nvidia.com
Subject: Re: [PATCH v5 net-next 01/10] net: introduce mangleid_features
Message-ID: <20260123113206.06e48b92@kernel.org>
In-Reply-To: <5a7cdaeea40b0a29b88e525b6c942d73ed3b8ce7.1769011015.git.pabeni@redhat.com>
References: <cover.1769011015.git.pabeni@redhat.com>
	<5a7cdaeea40b0a29b88e525b6c942d73ed3b8ce7.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-252934-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B6497A293
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 17:11:27 +0100 Paolo Abeni wrote:
> +	/* TSO_MANGLEID belongs mangleid_features by definition */

missing a preposition between belongs and mangleid_features
I added "in" when applying, hope that's okay

