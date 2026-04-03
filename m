Return-Path: <netdev+bounces-275044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNJMEIDBz2lH0QYAu9opvQ
	(envelope-from <netdev+bounces-275044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:32:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E227394830
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF75E301D92C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A43B7746;
	Fri,  3 Apr 2026 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI+Qdltd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B03AE193
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223116; cv=none; b=sIcS8V2DWHf50wfAhdBMkkVqTKq0Y/VWAwusYseKB1NAYMmzY5q2hJvLc6OL+BOyYb1C6dx6daUOLJPzx/yem+VRR2HOCf4+AyjLzQNn8JgjVRcLJhqyrkVlRa8EGfnLlHSC4GtJWU2+uFkwb5lpy0ats3Nw9RujOnZRpWQLVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223116; c=relaxed/simple;
	bh=f+FPwYUmQsv8W+rNwDj/HraJ56DYasUUBfwEcEVRSuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orqS5vUHRLRqQBHKCcYuJGW0XA2PcMXBT2GDgaiA/ES8fNqcLlPJbU7K/w1pSPzHLmWpSStpRn+Whe6pw+jqSgoxCD1ejE0q033ytNE6wBHZ2YEqzccJ57znru0o9ZdjCVRePvCyJpd+GWm2LRPlQ0kmKke8yQPNI9JJfvjNHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI+Qdltd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84E1C4CEF7;
	Fri,  3 Apr 2026 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223115;
	bh=f+FPwYUmQsv8W+rNwDj/HraJ56DYasUUBfwEcEVRSuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UI+QdltdOkB4RPobugji1w+yk2S7QVQpn3xp0RzqDUgFypF2jdk/odxZPmP4IvlJG
	 AtR188GhlcKCni4pg2yBbe8JKMS2mqgSEPeJYSTxnRlSAxMzHUoTaTfwOnD36iat6w
	 Ro1H8xWKcCr9wzRlKMoFBEcsU9xx4asgiBeO1evqG0IHZbGIKh1EDt6p6xUAta04ev
	 zbqR6FnA0+r2AqvC3VfDFRVMl95PPzZDTj5Gsk65qeg9x8lCN4vb3VvZO+3d5mZqKF
	 I3v2/vjewadm1mSwYcvtFZpoGbmkgYiW0dQ7PcsmbVEcO+9r02b1bIWSBeA+GZrQhQ
	 h+80FIBBeTs/A==
Date: Fri, 3 Apr 2026 14:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] ixgbe: clean up adaptive interrupt moderation
 algorithm
Message-ID: <20260403133152.GC113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-3-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275044-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 2E227394830
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:37AM +0100, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Improve the adaptive interrupt throttle (ITR) algorithm in several ways:
> 
>  - Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us (12K interrupts/s
>    minimum in bulk mode) to prevent RX starvation in full-blown bulk
>    scenarios.
> 
>  - Add ixgbe_container_is_rx() helper to split the Rx vs Tx logic in
>    ixgbe_update_itr(); Rx uses a latency-favouring path for small bursts
>    (< 24 packets and < 12112 bytes), targeting 8x throughput growth per
>    step.
> 
>  - Limit the ITR decrease in latency mode to at most 2 us per update so
>    ACK workloads do not overdrive the moderation and starve TCP senders.
> 
>  - Add IXGBE_ITR_ADAPTIVE_MASK_USECS (= IXGBE_ITR_ADAPTIVE_LATENCY - 1
>    = 0x7F) to mask out the mode flag bit 7 in ixgbe_set_itr(), replacing
>    the open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch is doing 4 things.
Please split it up.

...

