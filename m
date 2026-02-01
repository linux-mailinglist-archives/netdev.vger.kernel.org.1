Return-Path: <netdev+bounces-255557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG1KNECdfmkJbgIAu9opvQ
	(envelope-from <netdev+bounces-255557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:24:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA8C47D2
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50D8301828D
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7061A08BC;
	Sun,  1 Feb 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMi7VuSo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66743EBF32;
	Sun,  1 Feb 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905469; cv=none; b=SmLsNsxHJsNz+KVGPr2CHgEoDjxR03hfS6gO2X1CPNzGuedgHO2uPX1gj9+hZZYSyJTaEJY661uIElAGtVTLDHJLPyc2HyabF7QZbd+vDYRL/FZCcUiadVFOUKipzS2U7IMJDr8d1GjVhNff0noMNnzU/D0lnTl72sFmguUWsjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905469; c=relaxed/simple;
	bh=deT1os3gwcyPUwfuAHtNhxe293mF+dXR5IBQuQzUJOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nd2ZzRhyq2nsEsHj9Lx+/e4TPFoFKhFkNmFr2MI1O4L3EH8dLCut1DSSoWZlm3nCtys27NktHVdVYw86h7si8RDc6EycPnvdXk5AQlb11ftfGs6lVf51yOAFoCETQHtJzYctmVZcC63fGxfmHWZj8n6g1cUXJ0qQDy6bEegDLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMi7VuSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA5DC4CEF1;
	Sun,  1 Feb 2026 00:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769905469;
	bh=deT1os3gwcyPUwfuAHtNhxe293mF+dXR5IBQuQzUJOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AMi7VuSoy8R3XEPAN4lpaGh7OHYn4KVSaftIiHAfHc0kLcrH2WyKIWO6Wt8wN9HrA
	 qmcRSVDNRwecMVuXVtLX26iM8VS5G6YHJyZXORy9OKuyJCiIuF72Rw+FICqbXWeJ38
	 q1CHJJOYAo3lNX1lyq2/4fIABr7/eZAuukpQ9sS5fYHZ7hOKzGqd8nlMXHmOlfNLsW
	 Vb6Ux2oeIcnuREsT1+CP+46w2PfZWw9aUVbOZD/fGWs+Slu8v1WhVpJZPWKDGRYM77
	 9nBHGK3RLIggSUtRyYxhH1NeRy+/cjQTUQa96yxrqO4f9vYss33pgiuTuxpYzqmw0k
	 StoHItHm/jYfQ==
Date: Sat, 31 Jan 2026 16:24:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 16/16] selftests/net: Add netkit container
 tests
Message-ID: <20260131162427.741b8085@kernel.org>
In-Reply-To: <20260129222830.439687-17-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-17-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28BA8C47D2
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:30 +0100 Daniel Borkmann wrote:
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.

We should cover the uAPI and the tricky part of the handling please.

So off the top of my head main bits:
 - the expected attributes on lessor and lessee via Netlink
 - destroying the netkit with MP attached
   - checking the state via YNL,
   - attaching MP from the main dev to make sure we didn't leave
     anything behind
 - destroying phys dev while netkit exists (prolly netdevsim :S)
 - making sure XDP can't be attached on phys dev when MP is installed
   via netkit

... whatever else you found to be tricky in the implementation.

