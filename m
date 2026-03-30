Return-Path: <netdev+bounces-273236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKAPFTqPymlC+AUAu9opvQ
	(envelope-from <netdev+bounces-273236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:56:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D06AC35D451
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAC893043C2F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C332470F;
	Mon, 30 Mar 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TZx+5zNO"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FF2FD681;
	Mon, 30 Mar 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882134; cv=none; b=aP51g1k+9WQ0LjXnQyALs1dNDFNT8OTUJBe2g7a9JcOHXgZKsJ9j+nBLZBajr171Q7FpdV/chIuxUgPai0ICK8dpLKaHNvzUDpu04kWSY/aIvqldwTk8GZcJO6tBE5Jym4BTYSbA/QbTaQfeUpqFBsaNIFbr5NVXkwfdz32HAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882134; c=relaxed/simple;
	bh=+rneihPA99w1zYJtAb51T7C+DGJ7S5Ey/mUQ3GL389I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhH3h76JqVg/nE8X0MRr4ThyDYGeN374kCarRtrfb0cKwFBPzbyEozUlUcIJXELWonUZ9iDUAD/R+viwtlN4Y0aBu2Gb+IDIphPZ3M1PVHOLHTmU2k1fainN38O9m+VHm3gCnIlmI6Qc1DSHHRUGTu6pgR81xJRSSPuJUf/Dxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TZx+5zNO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1774882130;
	bh=+rneihPA99w1zYJtAb51T7C+DGJ7S5Ey/mUQ3GL389I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZx+5zNOCj5K7geJ74QVeHyyPQ6tILcOzJtuwLHaWzLdokuiw/v3thzz3hbXWNV0n
	 MQ/PfqR7x8dZPVO3dxVE5+tOozfJrzLm4upwzMsvr5oqzVnLsXd9KLQwpGNLZyrp1X
	 bjFy3KU69dYtpe823b6E9+fqLrhPirAWMoXGsZzg=
Date: Mon, 30 Mar 2026 16:48:50 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, arnd@arndb.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: fix skb_ext_total_length() BUILD_BUG_ON with
 CONFIG_GCOV_PROFILE_ALL
Message-ID: <9e6d5484-3670-40fa-8c09-201b76cd0088@t-8ch.de>
References: <20260330135337.937540-1-khorenko@virtuozzo.com>
 <20260330135337.937540-2-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330135337.937540-2-khorenko@virtuozzo.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273236-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,virtuozzo.com:email,weissschuh.net:dkim,weissschuh.net:email]
X-Rspamd-Queue-Id: D06AC35D451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-30 16:53:37+0300, Konstantin Khorenko wrote:
> When CONFIG_GCOV_PROFILE_ALL=y is enabled, GCC inserts branch profiling
> counters into skb_ext_total_length() and, combined with -fno-tree-loop-im
> from GCOV, prevents the compiler from constant-folding the loop that
> sums skb_ext_type_len[] array elements.  This causes the compile-time
> BUILD_BUG_ON(skb_ext_total_length() > 255) check to fail, even though
> the actual computed value is well below 255.
> 
> The kernel already has a guard for CONFIG_KCOV_INSTRUMENT_ALL, which
> causes the same problem.  Add a similar guard for GCOV.
> 
> The number of loop iterations matters: with 4 extension types (as in
> earlier kernels), GCC 11 can still constant-fold despite GCOV. With 5+
> types (after SKB_EXT_CAN and other additions), it gives up.  This is
> why the issue only manifests in recent kernels with GCOV enabled.
> 
> Tested with GCC 11.4.1 and GCC 16.0.1 20260327 (experimental) - both
> exhibit the same behavior.
> 
> Note that skb_ext_total_length() is still correct at runtime; this
> change only allows the build to succeed when GCOV_PROFILE_ALL is
> enabled for coverage analysis.
> 
> Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

Would it help to mark skb_ext_total_length() as
'notrace'/'no_instrument_function'?


Thomas

