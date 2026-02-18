Return-Path: <netdev+bounces-259210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bHH3KrZclWmsPgIAu9opvQ
	(envelope-from <netdev+bounces-259210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 07:31:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2908F1536EC
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 07:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA9AC30059B5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6A26B777;
	Wed, 18 Feb 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="CXHyHB7F"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728019755B
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771396274; cv=none; b=tAtDY9cFWirtnSASmK20cbb3oG2B6FbwTXqYdTtT/Chhr0euZQ4NMKY2wE+DIuud9j2i86xSD+LoqaEaKQrX9FyVNmghmMH4YW/mpEw4jqjGqK/s53eWmiveWHK907KWpQwg/yLFocaVr72JVR54eXSEHToTdlvpVA1mUicPH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771396274; c=relaxed/simple;
	bh=6PBhQp+yCEHPXtv1ZAuuFCujQrXoi3Mp1ntGeHYawbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkHR7V69YkUB/51cY83KZYIpvcHw80KhvYC5NbIIytxlWwJWzH2lCc+C1jrCAfHgR4bSjnenk+lfG0Pb9zu9k5LrKPwC3m0FyCe0K2qXKLpj1OcnsaTJLQjSa1oFmd1MEtf9u/WZduxMkmKkznHPcEk70ANRxvno/kysv0yFzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=CXHyHB7F; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (54.52.30.125.dy.iij4u.or.jp [125.30.52.54])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61I6V3kH014987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Feb 2026 15:31:04 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=KsvKsqG0ZGQHHD8pKdr61ytdZ0EagShQ8nJeP8O0BRI=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771396265; v=1;
        b=CXHyHB7F2w+xJag89PIZ6Vk+5kghA6Oa9FP/3B382Ws2eYUMhFZ/HuStNEsB0KpZ
         oXr8PjSG+BOZ9hrbYzQOZrHO8vYp+AhPz7b/bG5yctf1n0/5da8kvN5rcnTBdSQk
         jjskegzia4/xLac5lJEJWDcbJlOiYQ7cuoaPSjz6Z5cER1nHC5pJqmtGG+RotAUm
         z5KKMNyNVYM7MMXlYeoYrq/H3EGI+OKo8AwOA7E3IPUAEi+lzulCjWwmnq3pBpiC
         pSpNY3D+CF7Nv8hiroqcx1EHVjjqFJCNW1nGusut9h9PA/dWFKmdrP24psp6BcpP
         J0PdnuE72nrLC973NPT51Q==
From: Kohei Enju <kohei@enjuk.jp>
To: przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        jedrzej.jagielski@intel.com, kohei.enju@gmail.com, kohei@enjuk.jp,
        kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()
Date: Wed, 18 Feb 2026 06:31:03 +0000
Message-ID: <20260218063103.10265-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <234a3e23-590e-4e55-a242-41a2fb377d22@intel.com>
References: <234a3e23-590e-4e55-a242-41a2fb377d22@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259210-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:mid,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: 2908F1536EC
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 06:39:43 +0100, Przemek Kitszel wrote:

> On 2/14/26 20:14, Kohei Enju wrote:
> > iavf incorrectly uses real_num_tx_queues for ETH_SS_STATS. Since the
> > value could change in runtime, we should use num_tx_queues instead.
> > 
> 
> [...]
> 
> > Use immutable num_tx_queues in all related functions to avoid the issue.
> > 
> > [1]
> >   BUG: KASAN: vmalloc-out-of-bounds in iavf_add_one_ethtool_stat+0x200/0x270
> 
> [...]
> 
> Thank you very much Enju-san,
> this is a nice improvement!
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Side note: I'm working on enabling 256 queues for iavf, what means

Cool, and thank you for reviewing!

> changing the reported max number of queues, what finally means screens
> of zero stats printed, unfortunate, but better be correct that pretty ;)

Indeed.

> 
> > 
> > Fixes: 64430f70ba6f ("iavf: Fix displaying queue statistics shown by ethtool")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >   .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 +++++++++----------
> >   1 file changed, 15 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > index 6ff3842a1ff1..98bec3afc200 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> > @@ -313,14 +313,13 @@ static int iavf_get_sset_count(struct net_device *netdev, int sset)
> >   {
> >   	/* Report the maximum number queues, even if not every queue is
> >   	 * currently configured. Since allocation of queues is in pairs,
> > -	 * use netdev->real_num_tx_queues * 2. The real_num_tx_queues is set
> > -	 * at device creation and never changes.
> > +	 * use netdev->num_tx_queues * 2. The num_tx_queues is set at
> > +	 * device creation and never changes.
> >   	 */
> >   
> >   	if (sset == ETH_SS_STATS)
> >   		return IAVF_STATS_LEN +
> > -			(IAVF_QUEUE_STATS_LEN * 2 *
> > -			 netdev->real_num_tx_queues);
> > +		       (IAVF_QUEUE_STATS_LEN * 2 * netdev->num_tx_queues);
> >   	else
> >   		return -EINVAL;
> >   }
> > @@ -345,19 +344,19 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
> >   	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
> >   
> >   	rcu_read_lock();
> > -	/* As num_active_queues describe both tx and rx queues, we can use
> > -	 * it to iterate over rings' stats.
> > +	/* Use num_tx_queues to report stats for the maximum number of queues.
> > +	 * Queues beyond num_active_queues will report zero.
> 
> <rambling>
> zeroing inactive stats is bad behavior, not introduced by you of course, 
> but worth to fix (as a followup, not necessarily by you)

I agree.

> 
> unrelated to the prev paragraph,
> even if we remove explicit = 0 from the driver, ethtool userspace will
> still print (lots of) zeroes for "under-reported" stats, thanks to
> multi-syscall stats retrieval, that could be "fixed" in ethtool, but
> perhaps does not matter, as users use wrappers anyway
> </rambling>

The root cause of the OOB this time is that iavf_get_sset_count() uses
real_num_tx_queues for allocating buffers, and iavf_get_ethtool_stats()
uses num_active_queues for writing [1].

This may warrant more thought, but I was thinking that using
num_active_queues in all related functions would also be acceptable.

That's because, thanks to netdev_lock(), we can ensure num_active_queues
is unchanged within each ioctl call (ETHTOOL_GSSET_INFO,
ETHTOOL_GSTRINGS, ETHTOOL_GSTATS).
In other words, num_active_queues is effectively immutable for the
duration of a single ioctl, avoiding OOB.

[1] 
Thread 1 (ethtool -L)       Thread 2 (work)        Thread 3 (ethtool -S)
netdev_lock()
iavf_set_channels()
...
iavf_alloc_queues()
-> alloc {tx,rx}_rings
-> num_active_queues = 8
iavf_schedule_finish_config()
netdev_unlock()
                                                   netdev_lock()
                                                   iavf_get_sset_count()
                                                   real_num_tx_queues: 1
                                                   -> buffer for 1 queue
                                                   iavf_get_ethtool_stats()
                                                   num_active_queues: 8
                                                   -> out-of-bounds!
                                                   netdev_unlock()
                            iavf_finish_config()
                            netdev_lock()
                            -> real_num_tx_queues = 8
                            netdev_unlock()

