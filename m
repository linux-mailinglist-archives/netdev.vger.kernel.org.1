Return-Path: <netdev+bounces-258300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFB3GvOfjGmPrgAAu9opvQ
	(envelope-from <netdev+bounces-258300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:27:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D501F125A51
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED6993011064
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2F2D8375;
	Wed, 11 Feb 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="es7BJzkf"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89017BB21
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823662; cv=none; b=W2xHLEKyP23gQLMyOsfIrryLteyM0QoN4eDBwyLt+mc93X8+oHy4G82yel5HsO845HfXn0o+/68yJhqBfmoJbDPceN1eSYdAn0wQmhCTcSI7tbtUjJEfPeMuwzuWIeUaeVnqXL0q2nfflqke6Jqc9pfcqb0v5hFMZ4NUwsfxPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823662; c=relaxed/simple;
	bh=7nXvzHRcz9OdTY9UVPbwcgd+YPxqsXO/tP+VWTcmiBk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFarRdhcHSztL92ArY0rB4HNlxUayYr9uagSTci8uus4ivzTKvoH1ykwsY482YXItewSftAT+6vQzMLRYluU80kMQM8V2UIhkli1Xth6SLfSQmmZf9/ogHMXZXQ0Hgs2WxzwppmCXAopuMr3e52QrOlmqQe+y7HkC0PS/MuElrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=es7BJzkf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kvp+0Na0cRa1/qXJ/7KH6URM0xg+XZMbEtZZp11D+oI=; b=es7BJzkfI9iCd1ETIcDGnpjhQu
	u40R1m4GkjZa9UV8Xeaqvxxt/I5iatEEOeh54GSagcQ0mUvJggtOxpn3BiQogPqfYpARavWAGdw08
	8q3cqJAdW93iX3PjXBxhLa90HCl4sB24FUJ5G31vH7kEY2Fx6jca4pX92lROS3V4xl8gtq+X9hzeY
	1qeX5tdi+axtwP9k4X3xUN+k8lIyXCdDJUN2rBqSRbh8Vi5oJoO6M24ZdMJCf5ppJLTWXJ/7f02CI
	2VXzJUlOxj99PE90TiemnDoTdjfxMtiDYhujygnyZknU99ZDfb9k0Fx5lOHYLsGIx8bPVX5hJObHf
	67FApt5w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vqC7p-00B7ux-Jn
	for netdev@vger.kernel.org; Wed, 11 Feb 2026 15:27:33 +0000
Date: Wed, 11 Feb 2026 07:27:30 -0800
From: Breno Leitao <leitao@debian.org>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
Message-ID: <aYyfthvGbOheMzWE@gmail.com>
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
 <09a77964-37bf-4b3c-bfa9-8939eb7761ab@gmail.com>
 <aYyHNGBPu0dEIEzS@gmail.com>
 <aYycsIGsth4ob1sU@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYycsIGsth4ob1sU@gmail.com>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-258300-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+]
X-Rspamd-Queue-Id: D501F125A51
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 07:17:34AM -0800, Breno Leitao wrote:
> On Wed, Feb 11, 2026 at 05:44:56AM -0800, Breno Leitao wrote:
> > On Wed, Feb 11, 2026 at 01:26:35PM +0200, Tariq Toukan wrote:
> > > On 09/02/2026 20:01, Breno Leitao wrote:
> 
> > > If the problem is that the WARN_ON is being called at a high rate, then it
> > > should be rate-limited.
> > 
> > That would be a solution as well, and I am happy to pursue it, if that one is
> > more appropriate
> 
> In fact, I got more inclined to try to fix it in iommu code, let's see how it
> goes.
> 
> https://lore.kernel.org/all/20260211-dma_io_mmu-v1-1-cf89e24437af@debian.org/
> 
> --
> pv-bot: closed
--
pw-bot: closed

