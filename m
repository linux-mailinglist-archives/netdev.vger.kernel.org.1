Return-Path: <netdev+bounces-276534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOt8GBZV1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:16:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22623BCB41
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B6E302F0EF
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5A3CBE95;
	Wed,  8 Apr 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="MFBfXvo1"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8138A715
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653911; cv=none; b=MxAOnh8qaKPMgD8IwO5uEQjnhmOz48Y6vIO5w0IFQz1E/FPjKwV/e17txwlnAtbm0/pAa8oH/TgfUT5HxJzJ7Lj8BjxgMiGj6v92lO/+8qyAZO0L8OdTtHFuTxzKuwLQiWS8/4y0BKLXBhizFkVJNkjzXW8lPey7AmXiz4fOzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653911; c=relaxed/simple;
	bh=9jBCa9jP/OgIb/Y7yCDe0H0NO7pg10EEJypKE0ioNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPYeW81xd0mhR8Q7+Yd1C+2PgV/v1LGABEL6C88RyipP5FJZxP5bo1su9rXE0RAiOlp7w9NUBYwWuqK5HHUL+yn6Q9fOMJD1hSfT2a//LJ437DnhlDUvA5hUejkAie2mssevkQLHNv5Sv9w0MNpr7v7fGnkS9GyN9Nr1RZOLH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=MFBfXvo1; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 638DBRAt012252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 8 Apr 2026 22:11:29 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=UGQ67r6USA+flx1FAnz9wCvHAQQncWp3Wxkm5JwYX7c=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775653889; v=1;
        b=MFBfXvo1t7b8sFwFAmdphOrfgZfVVvxSCb+4NfRpPw0uUdD9B8mhHefPp4bk36LQ
         AWDyvUSSa1o5RAQA4IMCxMKdpnMHgZlm0Q3x8gEmJGQ+qbF04Pkgjz6wxm7jZOiC
         NgF6847RmsRRT3YIJyBHjChsErS+tRaJv5XLX3lq4IMXwp6SyRO8N/H/0ajSZTR1
         /prnGoiPyajVlHdg1nlgFnmxpLA9BSe/d6mccoDBNC66d+FzvqImqpMW9a+rhYt4
         kFGlxlYBgHPzSY+KFmBpdbpH2QJFOZTneUZltkjDGD1ehDaVpySreYPd7r99pv4o
         1C10Biq3nEmCQljEtIGWzA==
Date: Wed, 8 Apr 2026 22:11:27 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
        netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] e1000e: use
 ktime_get_real_ns() in e1000e_systim_reset()
Message-ID: <adZRkBXUJKZqAiS9@x1>
References: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408083644.1621317-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276534-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:dkim]
X-Rspamd-Queue-Id: B22623BCB41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/08 10:36, Aleksandr Loktionov wrote:
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() in e1000e_systim_reset().  Using the combined helper
> avoids the unnecessary intermediate ktime_t variable and makes the
> intent clearer.

FYI, e1000e_xtal_tgp_workaround(), introduced in a recent commit, has
the same pattern as well, though that commit only exists in Tony's tree.

Also, igc has the same pattern in igc_ptp_reset(). It may be worth
sending a follow-up patch for that as well?

