Return-Path: <netdev+bounces-286745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GTAHZMUAmrangEAu9opvQ
	(envelope-from <netdev+bounces-286745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:40:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F5513A27
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06C031BD40E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5B43CEFA;
	Mon, 11 May 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K7aMYlqX"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D699743CEED;
	Mon, 11 May 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518375; cv=none; b=PCK8vXf4tCX2GK8YezK1sXrxZH50Q+hZgic6Eo/wmKjlYVcoH1iCsW9F9xKZsouCcfRXHN6EIsnb8qEnetJ1Ut3xZU07PtJXJhwRFBY6Um0Wpu97Th957eq1HXxQZxZobZZnd9oKy2JUoCo9JisE6ic0Ofjiyb3YixASoTKXOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518375; c=relaxed/simple;
	bh=/XVTrJF8HWgk/OL2FKXqXG1ws+kAw96BlTcnE6Aovok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qverm30GkOhS8EE5/on5qQHhY7EHyDmWKVKl6OGY4U+gU9C6u5EbPGLc0LmY5AzKlV/b+SF/4Z6/7biRzxM130MMtnJjSCV67+Jf/F+ZK4S9f2aKYyNaBjqr1oLYoKBYq+i5GHctQ+bKfz7gpkKD9B1B/DURHNsvQeBKXZY6RGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K7aMYlqX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1vM5Cx43ONmYVpMXTE4fDdvVZMhNnp8aOLqKkOwozh4=; b=K7aMYlqX99Fm4PIqR+NDM+I+qu
	FbheTWTxnwz5vYGSIW5/s5fPr0me3ap4cx1QHl/ugXCgVygYXJiybWYQ+lAkesg/OYVSDWqOjgFFa
	X+aHamO1OT4m/Gqu580Ju/ujRBgZ334n47CNYYp4D0vUmtrGqhn/EEEn0iOYPFvyn5N75MhNeIdoD
	WkLMLnU3lawYQrGMjb37EGy25t9TQ6YUpQBkWGgVMz/nRZiIUqVagkAAG8oskE5f1YHU8cpsx+G2p
	DhOGakPuN5m9VKgxIZlwjjbo8IxyqWaLDYMSaJfbexmYoMfTuNDBqgoVcLaYmHzztdwb514BIL25f
	GHU2ts7A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMTs2-001k73-2o;
	Mon, 11 May 2026 16:52:43 +0000
Date: Mon, 11 May 2026 09:52:37 -0700
From: Breno Leitao <leitao@debian.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Eric Dumazet <edumaze@google.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Li Xiasong <lixiasong1@huawei.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] selftests: mptcp: join: cover ADD_ADDR tx drop
 and list progress
Message-ID: <agIJRAYJ372xnTtr@gmail.com>
References: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org>
 <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-3-5ee57cb2b7eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-net-mptcp-misc-fixes-7-1-rc4-v1-3-5ee57cb2b7eb@kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: C30F5513A27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286745-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 05:46:29PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Li Xiasong <lixiasong1@huawei.com>
> 
> Extend add_addr_ports_tests with IPv6 signaling cases that exercise
> ADD_ADDR tx-space shortage when tcp_timestamps are enabled.
> 
> Add one case to verify PM still progresses to later signal endpoints
> after the first one is dropped.
> 
> This covers both failure accounting and the non-blocking behavior of
> the announce list after a tx-space drop on pure ACK.
> 
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

