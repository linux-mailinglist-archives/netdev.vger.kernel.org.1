Return-Path: <netdev+bounces-267846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK8cE6+/tWmr4gAAu9opvQ
	(envelope-from <netdev+bounces-267846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:06:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E9F28EB5B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07263302C6F7
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795E37B000;
	Sat, 14 Mar 2026 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTdtN5xI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8F2046BA;
	Sat, 14 Mar 2026 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773518763; cv=none; b=WrJNAbIzQKE9arKUlnSwzlV/WV9sUpuh4JfxfMRWEBFPgNqd3DXzf/if3HkAzrNdUXdz6/EURaNT9mstYgiN52PnJYbvwJ6JxUxzD0VwfVFmPpA0v2N4HL76OHKSzfZbd+V71bn7DoUdXZI7Ee44id2UstzGq0IeyxuFU4aUCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773518763; c=relaxed/simple;
	bh=Vedks8gdVTP9wSEvN7dGkLWh0D4RhYNYqCAWeATFhWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgDl4ylmUK8JuRRjG+ZTnMOu513N93m1ecsZpayL2x9vzUyLJG4gZKWOVpEWfTzSSV91H5gMxmHlq2Sn5Yp4dlDdRPUSkk9dAzSBg04m4u1P10n718uP1IbftUhr59gKfWMxVnTg/pPf6r3+OPD5TEK4iA0nN5B85xzhwlnQ54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTdtN5xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083B3C116C6;
	Sat, 14 Mar 2026 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773518762;
	bh=Vedks8gdVTP9wSEvN7dGkLWh0D4RhYNYqCAWeATFhWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pTdtN5xIqR30KmjBfL2KVNQ1fJ3tNDtIqYf0GCDpV1TYBmDuvVkBMGOs1xffttMK/
	 rOEr7rz960iJaHe/9QXE3nJa+ajDGXJmF3XUXdlUbOL2okafXfWZdmzYL7PFO1g09d
	 Ez1wRArCWruFWBeoSaCEPbFOPm9zlt5lkJfJK/IbbXgpfP3pP1DxZfOHx6BsFD37aq
	 LzB6E0tUoFeWcu5U/SkLXe/vKZowq0dG9UWgRWUxP3wjAZoihPMETtdKpvhIq2UOJv
	 xq/jBiILKhz03EHljS//m30IMJdncPWeXxuSt+DIVqGCcW+ILnks6x0hUohjf5uhZd
	 +mmtcOLhMVYhw==
Date: Sat, 14 Mar 2026 13:06:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: stfomichev@gmail.com, horms@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
 mst@redhat.com, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, ronak.doshi@broadcom.com, pcnet32@frontier.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/7] Introduce async callback
 ndo_set_rx_mode_async
Message-ID: <20260314130601.0ec7a534@kernel.org>
In-Reply-To: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267846-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7E9F28EB5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 23:58:02 +0530 I Viswanath wrote:
> This is an implementation of the idea provided by Jakub here
> 
> https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/
> 
> The set_rx_mode callback is invoked under the addr_lock spinlock which
> makes it illegal to sleep. This means set_rx_mode is prone to
> sleep-in-atomic bugs as drivers have a tendency to do the I/O directly
> in the callback.

Stan is actively working on this:
https://lore.kernel.org/20260313145113.1424442-1-sdf@fomichev.me
I feel like I spent enough time reviewing your attempts and Stan
will not need as much maintainer attention to bring this to 
a closure so let him cook. Sorry.

