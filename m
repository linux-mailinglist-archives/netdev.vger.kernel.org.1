Return-Path: <netdev+bounces-279827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PkBHvpT5mmwuwEAu9opvQ
	(envelope-from <netdev+bounces-279827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87142F7DA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AA45358B3A0
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96B3B2FC0;
	Mon, 20 Apr 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="P+Otr73n"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCF4A23;
	Mon, 20 Apr 2026 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692125; cv=none; b=XWLFzaxSZ3K82YoDkN4L5XYK2KoDgZ/ztIVMpsVFAOZhUCiElF2UrjnrFsUNAkACnmVGcW2ybW6UIE3DE3AxIoYO41rrl+SsrvoNh924UQeiPMwVKHs8fQzR2WX9yve6SyOSnD/mxb/0OqSq6LaS3mRxSPIl+Vjiov9TFSVy2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692125; c=relaxed/simple;
	bh=K3dBw9Wa743/1joY3IzX1Q6OH6GdFvdHUxInXgHI1R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOLMcvECGC/GberwdDLYY2qQxKG1Fhes+OC0AQwtO+8sQ//IBqv7iUr9jujHLkFDYm9F4TOxGGPEz9OOkPrFy1LrXk1kURDAuZhI2z5jm3XfmhJTvR/kbN6yzEDIk/9zgwtzyUKzyluiKHGskFRzToAY+yRzY5HzdeGhWA/q26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=P+Otr73n; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gr9nug+IudIAFfAPPf/K/cpRlKvYovwf0x2how1X280=; b=P+Otr73n84cWIFBzXdjgM1nSnj
	47QDqxInfIsUNDSvAvjA8AHpAgoQbTyz0eCZJrpHPmaJBX6/mOdMeLYAAPD1ODq7cBhEuKLNSIOfF
	KQaQ1g07argvqWU8emOxhYTMD4E41LaxDE5SbPsl4E0J6TC44pY7LKoPM2n3iTjk+i0lPQBmmB7Kd
	2YEnf67h9j7p3a2ZmmVcwM1gDT2oyJuykfFGYEJHMI3bb2yIR7wGDxc/414w+La7k4QJ6byPyYV8h
	zdwzMG+sWPRvWF8bvDm+gvA+0vNXSuk0NaCViTpyJy6mr0nqKU+XQGM0doZmoY93H5CUi2AlIv9Su
	gF8SpIwQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wEomX-0007P4-2K;
	Mon, 20 Apr 2026 13:35:22 +0000
Date: Mon, 20 Apr 2026 06:35:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Ariful Islam Shoikot <islamarifulshoikat@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: maintainer-netdev: fix typo in "targeting"
Message-ID: <aeYriUVjlK90HMOc@gmail.com>
References: <20260420114554.1026-1-islamarifulshoikat@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420114554.1026-1-islamarifulshoikat@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279827-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB87142F7DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 05:45:53PM +0600, Ariful Islam Shoikot wrote:
> Fix spelling mistake "targgeting" -> "targeting" in
> maintainer-netdev.rst
> 
> No functional change.
> 
> Signed-off-by: Ariful Islam Shoikot <islamarifulshoikat@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

