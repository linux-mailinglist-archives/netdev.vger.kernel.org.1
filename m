Return-Path: <netdev+bounces-268056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGESIlLJt2kRVQEAu9opvQ
	(envelope-from <netdev+bounces-268056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:11:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16CF296C5F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464CD304BCD1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEF382F19;
	Mon, 16 Mar 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OGF3AbdV"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC7382377;
	Mon, 16 Mar 2026 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651957; cv=none; b=FRYpCer0pm+qDD5PLUMqJvJa+XhyN60jM+ILgrObhR0TGJ97xvMihDmKBeG+i533cPsxXNFUmdxIu+tisJJ6R3TGPLQ7B/YwosgbiQ6Ys9FKRO68f+EfGdPBFh9trqRmA3d2YqunyMahCsaJ3rTiP7YoRZSS6vl7ynWZJ9Zopy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651957; c=relaxed/simple;
	bh=G2LFJt8R9fFd++vW7my/5zXv4IoLBTAqkvv7sRHq4Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5+vlRtWaHrZUMy4eN+hnTOxeVBWdk1u6k1raf+m8317SmfoMjknZczUnSD0z0prZ+vCmVNQehZpj7dO7wVR46Bq9s7rzo1HWAonTBzVKz/p9+Ta6EAeuBPaB1hqHpO8B5IcZ9fBz3LNc0YWGvC1jRYnO+RJnEkkiCLCBCy/M5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OGF3AbdV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qLUlMhrZTsCbyIM2ECNzKk26tUdD5KXnr1JNfWqqqDE=; b=OGF3AbdVJVkSwgpOoNCColoJIa
	RCYMEOrn6rk5NJ0JKeyMVAyQDwECbvGEiiHxVqWj2P9DElDs2o8zzwDHVgN0XujjEw5erFD2ciGDa
	ek18iv2b9FyW6TWmpON76vAR6l6f6YKswGTSV3AME4OJzczLeGT32mbMQzVXE2u0TvEFbD7jkY8xK
	ZbQfIriraXn+ot62CMkou2VunEQgahocmQ3Tfac5c0DV62SmM6DtqtESud0DjUrCLsHJd6sNuhTxV
	+qaeZOih3YlOAYMGPtnl5gnCqLQB9WemBrAE4/QMg02ycMbdI+d1ZTBkG7NXD95m++JnP9D4RHX/U
	pXAWTBzg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w23tU-0020G0-Lv; Mon, 16 Mar 2026 09:05:47 +0000
Date: Mon, 16 Mar 2026 02:05:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	petrm@nvidia.com, noren@nvidia.com, gal@nvidia.com, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: py: give bpftrace more time to
 start
Message-ID: <abfH1RJzcf7Q94kQ@gmail.com>
References: <20260315160038.3187730-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315160038.3187730-1-kuba@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268056-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netpoll_basic.py:url]
X-Rspamd-Queue-Id: F16CF296C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 09:00:38AM -0700, Jakub Kicinski wrote:
> After commit under Fixes debug runners in the CI hit the following:
> 
>   # subprocess.TimeoutExpired: Command '['bpftrace', '-f', 'json', '-q', '-e', 'kprobe:netpoll_poll_dev { @hits = count(); } interval:s:10 { exit(); }']' timed out after 15 seconds
>   # # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}
> 
> in netpoll_basic.py >10% of the time. Let's give bpftool more time
> to start, it can take a while on a debug kernel.
> 
> Fixes: 82562972b854 ("selftests: net: pass bpftrace timeout to cmd()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

