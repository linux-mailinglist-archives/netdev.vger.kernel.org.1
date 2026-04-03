Return-Path: <netdev+bounces-275067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MlrF0zJz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:06:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3940394F21
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E8F6300BBA8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07F38A71C;
	Fri,  3 Apr 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKx4crZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B23328F7
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225160; cv=none; b=dCPRzir/2UdrjcdyuH4N0wBnemNEEx36lc9j9i4W+FrvpsIOVUP94bnSwRBBZwP/C5MRVlknYoGBK/K+JvOCYEECIqNjOOFBTT96UnCusCpQZX4EeolRIRV6sfcOhaf7uDUSyMKUOoHkGUL2OtYOxhoPb9AT2ErgrYOdseC/Kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225160; c=relaxed/simple;
	bh=dPL04DWhjNrJecRKU97SRfyIoJ78lkDa9XPzjHYqYBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBcMirRPE+ZT9VnHQsxUSdlYWT6zy/LAKLvQE3vAKx/xhMzhZONw9XdvrZTIOEIHHV/+8L9rmTk/n0uD0VODxsHgGpBIzdpvwNKAKd7jv+nYaNukUxWDUZX/7bhxMaWT0NbvukACMV1ITkf8Ah8fqtASzbTTuzgv78Tjhq64IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKx4crZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A98C4CEF7;
	Fri,  3 Apr 2026 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775225159;
	bh=dPL04DWhjNrJecRKU97SRfyIoJ78lkDa9XPzjHYqYBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKx4crZ+McLwDe6RNaSO6h8jbx+f+E+uWq8OvMuAcDJz0a0QmbNRdk4S0HvR8dVLW
	 0Mzdgw3QT4mi6EG4Hy0MvupGZ+oyOgzxMSEmGT2lClWjF7pz+AEXlKsKy2nSKqZVgh
	 HjEIG8MukR+FJ98FX1vN5uAy9hkjl2NxVwStEp2NYJlTlIDv/6CMrWfJxSpKdQ1jZi
	 vbBrXhEGwZGKJpGM3RXM4AJREdhk0IJrc8t+novzWfwWC4PCY6mFN/lJTXAPbce/wK
	 bl9PHoT57/dUotN8w3DPRWRWEQkuk7pvMtMFMp3GfkMGLZyRJu18b8LohbN7E7DeW2
	 fnrdzA8/Rb9yw==
Date: Fri, 3 Apr 2026 15:05:55 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-net v1] igc: fix potential skb leak in
 igc_fpe_xmit_smd_frame()
Message-ID: <20260403140555.GH113102@horms.kernel.org>
References: <20260329145122.126040-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329145122.126040-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275067-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F3940394F21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 02:50:49PM +0000, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> 
> Use dev_kfree_skb_any() on failure.
> Also call igc_flush_tx_descriptors() only on success.
> 
> [1]
> unreferenced object 0xffff88813aee1b40 (size 224):
>   comm "softirq", pid 0, jiffies 4294709256
> [...]
>   backtrace (crc dee31384):
>     kmem_cache_alloc_node_noprof+0x54f/0x640
>     __alloc_skb+0xd9/0x5b0
>     igc_fpe_xmit_smd_frame.isra.0+0xad/0x510
>     igc_fpe_send_mpacket+0x32/0x80
> [...]
> 
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

I am wondering if we can achieve this while sticking to the idiom
that the main thread of execution is for the non-error flow,
while conditions handle errors.

Something like this (completely untested!):

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 8a110145bfee..02dd9f0290a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	__netif_tx_lock(nq, cpu);
 
 	err = igc_fpe_init_tx_descriptor(ring, skb, type);
-	igc_flush_tx_descriptors(ring);
+	if (err)
+		goto err_free_skb_any;
 
+	igc_flush_tx_descriptors(ring);
 	__netif_tx_unlock(nq);
+	return 0;
 
+err_free_skb_any:
+	__netif_tx_unlock(nq);
+	dev_kfree_skb_any(skb);
 	return err;
 }
 

