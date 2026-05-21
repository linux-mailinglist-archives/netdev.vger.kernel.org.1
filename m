Return-Path: <netdev+bounces-290369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHA2OT/xDmqmDQYAu9opvQ
	(envelope-from <netdev+bounces-290369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 464795A43BB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7180230210FD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5563C417E;
	Thu, 21 May 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVWGSSQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750D3B9D99;
	Thu, 21 May 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363820; cv=none; b=uqhf5MEANMQAmBQ/PH2qvyB29pCIFtIb8GM3WJLx0wvTLrbDKOVNQqCXkz2lvpqCX/LUHzawH62w3pHny/CyAGogMVg1G7m/hakdVrXggEFtge+HYS+UeqcB6y1G3XTuFb1CDZaETXBuB+MHRKwZBpO1lCD5+J+if3hP8JTOWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363820; c=relaxed/simple;
	bh=QOd//fO+Z95+AtVyKwYZqUD+VnOJI1Z/8+wve31LCik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ8KiQuSF1hyxYFJ+IsIubt31XRJsupNfkHbtd0Nbq3WKpSeDxi/mg/B4fwYZwsfjMh2LGMuvE6Wj7wTIQ2LZvoF2Yzl/9xT5tpRPq9rKm5DMdbAj8r7as2H1FiUZSt+2clfU6FFIvjOdyfVBEuY8RR26Q3aUjVNTQVMBeB3xxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVWGSSQk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1384C1F000E9;
	Thu, 21 May 2026 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363818;
	bh=gNwhZlZNvRf30NjRud00r64+zMtRvb84BXByEUe94wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KVWGSSQkk7z2naqeJYJq6xHDJDJnA4c1yP3WGTzwMTrL5NehmGY25IXM4PaHiJoCq
	 YE0sw3ITwkOvRbHQZWO83SC6dGNMEj2Iy1VHSmkGYDKstDCs35IYnLwRhAzHnLJ3dR
	 S4yKQ0MPhoL6xXVBQ/9tGpNPgPsCIMtwHgl7pjkaxic9P1I5ZVsNNGVPkV/qcT/dec
	 vTeUU5zXzfe6PEbTRV1jMgdWwu1K/vogJsjUrjACNhBQNNdg/YdWhHDFXXjKCGBuYN
	 Ao2f1ASEDBeCTTaMBqIMc09I0BinuzmIroz9wyaBVfGwoa8+SAZitgo3kMfCP3qo52
	 XEC7f9RVp5Sjw==
Date: Thu, 21 May 2026 12:43:32 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] ixgbe: do not configure xps for XDP queues
Message-ID: <20260521114332.GC1506108@horms.kernel.org>
References: <20260518111506.65284-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518111506.65284-1-larysa.zaremba@intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 464795A43BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 01:15:04PM +0200, Larysa Zaremba wrote:
> netif_set_xps_queue() should not be called for an XDP Tx queue, since such
> queues are not netdev-exposed. On systems with number of CPUs >=64, on E610
> adapter, netdev is configured with maximum number queue pairs being 63
> (due to MSI-X assignment), but configuring XDP results in 64 XDP queues.
> 
> So, during XDP program load, when netif_set_xps_queue() is called for the
> last XDP queue, we get a WARNING with a call trace and KASAN report
> afterwards (if enabled).
> 
> [ 2012.699800] WARNING: net/core/dev.c:2854 at __netif_set_xps_queue+0x116a/0x1e40, CPU#36: xdpsock/103668

...

> 
> Skip XPS configuration for XDP Tx queues.
> 
> Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


