Return-Path: <netdev+bounces-277898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNBdMnAE3GnCLAkAu9opvQ
	(envelope-from <netdev+bounces-277898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:45:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8173E5EE4
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0961E30094D5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FD227B94;
	Sun, 12 Apr 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElD3NXpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA234C6D
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776026732; cv=none; b=IZaSBgRGJTv61AClDMrygd4WyBgB3diD3ffhFWIau5Z4khD96l4XuqfYl+Ubc0wdj3YFIdrV6GHlHlsQj1OyoAhf+77fXt5lVzrbIGoNZklKEJwUHM7udidWUVGAwWDeUil6z0dHckkI5G+WNGIRCmnzzHYBnM46IfRcKUa3C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776026732; c=relaxed/simple;
	bh=L5q3yussTrMPyWqu9vjUv6rZOTO2EiE1UYPz1nWF14E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRhmHreUmK+ZCqmpwiZ9lyiogaKhpWTA1itJsc26DdJ83oGSZS9daD54vddXbCK8JZZvVlAeNJwcxugIfaYQxh1kaRe3S0ig/yzZRqw6FYfFS+LOEgV7bhJagBxj5HCrfZU0pIFo5JMLDXST4xC0jJKWp6AArSqsNiUBWH+8bgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElD3NXpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F929C19424;
	Sun, 12 Apr 2026 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776026732;
	bh=L5q3yussTrMPyWqu9vjUv6rZOTO2EiE1UYPz1nWF14E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ElD3NXpXnRCLngnwcIbJ0kiN7cu5zD7JBUocX4dF5XlI1aYk5IwBeQMJrKgP6KJWL
	 RuNGAN9jmOpes3Cx8wMHbnJNu156jF7FL05UbZ7uef0AW9J74h1QQiUZOUzXsI1jqU
	 dfImNWZ44KDn3fftpb2d13vhJFvK1erZhNKmLTKQ9nJ26pycStssGQW88MD+md1eUM
	 7vumrU4Ga7EbiHrBeeH97vyFscVd1pdzfTJS/HWjZ6XNS64VoNdBRGyhpL37IYo8hK
	 Ri47uzr5nw400PWz6IzB7zeI1okO2/gcnyQg1MKsC4nZ/dXkUzUI2Gxac5gC6SnHDN
	 Z4ADoWLJISASQ==
Date: Sun, 12 Apr 2026 13:45:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v18 00/15] Begin upstreaming Homa transport
 protocol
Message-ID: <20260412134531.21341692@kernel.org>
In-Reply-To: <20260410200310.1915-1-ouster@cs.stanford.edu>
References: <20260410200310.1915-1-ouster@cs.stanford.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C8173E5EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 13:02:54 -0700 John Ousterhout wrote:
> This patch series begins the process of upstreaming the Homa transport
> protocol. Homa is an alternative to TCP for use in datacenter
> environments. It provides 10-100x reductions in tail latency for short
> messages relative to TCP. Its benefits are greatest for mixed workloads
> containing both short and long messages running under high network loads.
> Homa is not API-compatible with TCP: it is connectionless and message-
> oriented (but still reliable and flow-controlled). Homa's new API not
> only contributes to its performance gains, but it also eliminates the
> massive amount of connection state required by TCP for highly connected
> datacenter workloads (Homa uses ~ 1 socket per application, whereas
> TCP requires a separate socket for each peer).

make coccicheck says:

net/homa/homa_peer.c:213:21-22: WARNING opportunity for swap()

