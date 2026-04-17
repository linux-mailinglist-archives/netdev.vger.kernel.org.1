Return-Path: <netdev+bounces-279365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOFNM85f4mlM5QAAu9opvQ
	(envelope-from <netdev+bounces-279365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A541D20A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DA143145B0C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3434753F;
	Fri, 17 Apr 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Y+Mx2vPY"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456E350D74
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442905; cv=none; b=dNAn4rgWYTdm+VD+2x11iKDNrWC8z4UlsqAk5QiiYiHi9cJ/avP/zy4MCho4IBT9fnaWGD6Fb4+z70EN6jZwkjvdISygD05jfRXAi9Cw/W2ZKVGw5RIA70+EkSeL6vV9bTzVGksGLlkRwCgXTa2VWTn3ftggqG98uh9sY7dlizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442905; c=relaxed/simple;
	bh=LahCPMaNW4+EJMQUur8o6yJaL/QVwiKBq9Lz/a9CeHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2vCJUKIc5SO0AeUr+t3t0M0luXyUxd+FL2OTzp+Ybku5rQjfBierhIfbuBWCXzCpm8CID7gkiwpNi/cLcQA3pqg1n5DoNVLgGPrBSNMN3kRpXmn5m7MZhaNCRnaaNZtg12DKZCCUshGgBJHjV35hAXL9khdbDMHmZmAI2j4zqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Y+Mx2vPY; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63HGKjCb019556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 18 Apr 2026 01:20:46 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=aucRIRNpULh5tCJF/CYGnKrKwCbL4hITukOd5aDy3lE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776442846; v=1;
        b=Y+Mx2vPYR6FTXpkb33ZpRugexom9CWm7BDSsBqR+SdVVyW9OlWjqxIONLeAEuAv4
         jL5h5XmSGXtHWES+olWwYkinXRchl2oZ4eyaLDebPL8fvRVF1voyFVbQuYnr8Sn6
         49VNsX5CPrUgwMSJcI2wJmY8AljkpL8kvQKveUE2VVjqsWlu5b4e1bWGe59Um8Us
         mSQ1T81rroaqUMtzK8xEsX/PNSwTibmHJpMYTf+C3guA82TLK7MLBjGfMUENfni1
         41mE8tLFyXK49VCmhH42iI8n3jIC8FPBdb+HGzee4xuqSSuqnFRSQIaICnbn2sNL
         QqTi5nSlwq6PdR7lpE27Ww==
Date: Sat, 18 Apr 2026 01:20:44 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        kohei.enju@gmail.com, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] igc: fix potential skb leak
 in igc_fpe_xmit_smd_frame()
Message-ID: <aeJdUhe7_x1ZKFzX@x1>
References: <20260415025226.114115-1-kohei@enjuk.jp>
 <20260417115122.GA31784@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417115122.GA31784@horms.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279365-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C4A541D20A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/17 12:51, Simon Horman wrote:
> On Wed, Apr 15, 2026 at 02:52:18AM +0000, Kohei Enju wrote:
> > When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> > allocated skb, leaking it. [1]
> > Use dev_kfree_skb_any() on failure.
> > 
> > Tested on an I226 adapter with the following command, while injecting
> > faults in igc_fpe_init_tx_descriptor() to trigger the error path.
> >  # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> > 
> > [1]
> > unreferenced object 0xffff888113c6cdc0 (size 224):
> > ...
> >   backtrace (crc be3d3fda):
> >     kmem_cache_alloc_node_noprof+0x3b1/0x410
> >     __alloc_skb+0xde/0x830
> >     igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
> >     igc_fpe_send_mpacket+0x37/0x90
> >     ethtool_mmsv_verify_timer+0x15e/0x300
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> > Changes:
> >   v2:
> >     - change to idiomatic style with goto (Simon)
> >     - add Cc to stable (Alex)
> >     - add reprodunction steps (Alex)
> >   v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/
> 
> Thanks for the update.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Sashiko has comments about a potential existing bug in the same code path.
> I'd appreciate it if, as a follow-up, you could look over that.

Thanks for the heads-up. I'll look into it.

> 
> Thanks!

