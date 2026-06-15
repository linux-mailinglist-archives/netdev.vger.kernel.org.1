Return-Path: <netdev+bounces-299662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id At1bI7aNMGp3UQUAu9opvQ
	(envelope-from <netdev+bounces-299662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353468A9EE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fPMgCvK7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299662-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC7B2301CD19
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5231A34040A;
	Mon, 15 Jun 2026 23:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBD2FFFB5;
	Mon, 15 Jun 2026 23:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566775; cv=none; b=H7fjPrRi9Ez9tzjluwdCu9PxUS6vg1OfdXW3ic6dAwQPQhEaOc4udd3s6fvkns/+OFYGKiE/sfNH3yjXr2HZfagbm8Q4dwS9gAbd4Md9afPB5Y6T+HBGazuK6eKcdVymNqsOHTfP7Jo0xo4J+u/hnR3mo2h+TPbimH9Lbw5i4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566775; c=relaxed/simple;
	bh=SHvzDj1OR4GhwL93Bhi84vBiepAvE9mnwY/OVp9q5C8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mImKiBDg0CiOvQ79L0fQdmyDdcbwEoMEh91bS51aCtlqe1CwmcKXyv5I96AriA9+oIoJQolf9OYihOckv105KjBeQeMErrEPwQrH0P72qQc3FNxFb19spkOt2SFxKNA0yL7Wsc5r9wEBaywD9t+rQgntBNduduPn5xVNTxFLGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPMgCvK7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22CE1F000E9;
	Mon, 15 Jun 2026 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566773;
	bh=GNNjaKv8UKkb1Uz9SG65/M2zLsNI/nbiv3MfshiBmYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fPMgCvK7zvSL4WN+HNIYzac/rPEKPktiZXucF3h+37Mi/U3iHhUDcNhLa9Bosi/tv
	 TeKaUwtOBb/2PMAi03rA7P4e7G6dhuypbZBjhed7nXw2X+HW2EuGZpKn8YaVytsRXS
	 SHdI3+j8ZnBMaPU4A48Zn9LCpTU5o6M7Tv9fZZsSBbBTYd8e3ZDTxsrp3DQymXcwDG
	 d2wZGS/hUyPO34lKU7UEvGyfYCf8LQZAiZa2WJ6UuPkU6zs6O4tNjI+xG5RRMVaq2W
	 y81Z5ydhoCC1OETektoFclEiL56hniyMI5KuoUAJxCsTwbjdHEOJ1XCerXGkPbSNK5
	 V0YePBhj6n4DA==
Date: Mon, 15 Jun 2026 16:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: m-malladi@ti.com
Cc: elfring@users.sourceforge.net, haokexin@gmail.com,
 vadim.fedorenko@linux.dev, devnexen@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, arnd@arndb.de, basharath@couthit.com, afd@ti.com,
 parvathi@couthit.com, vladimir.oltean@nxp.com, rogerq@kernel.org,
 danishanwar@ti.com, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, srk@ti.com, vigneshr@ti.com
Subject: Re: [PATCH net-next v7 2/2] net: ti: icssg-prueth: Add ethtool ops
 for Frame Preemption MAC Merge
Message-ID: <20260615163932.50bb3df0@kernel.org>
In-Reply-To: <20260615231041.1007484-1-kuba@kernel.org>
References: <20260610052511.781752-3-m-malladi@ti.com>
	<20260615231041.1007484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:m-malladi@ti.com,m:elfring@users.sourceforge.net,m:haokexin@gmail.com,m:vadim.fedorenko@linux.dev,m:devnexen@gmail.com,m:horms@kernel.org,m:jacob.e.keller@intel.com,m:arnd@arndb.de,m:basharath@couthit.com,m:afd@ti.com,m:parvathi@couthit.com,m:vladimir.oltean@nxp.com,m:rogerq@kernel.org,m:danishanwar@ti.com,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:srk@ti.com,m:vigneshr@ti.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[users.sourceforge.net,gmail.com,linux.dev,kernel.org,intel.com,arndb.de,couthit.com,ti.com,nxp.com,redhat.com,google.com,davemloft.net,lunn.ch,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9353468A9EE

On Mon, 15 Jun 2026 16:10:41 -0700 Jakub Kicinski wrote:
> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> > index 5ec0b38e0c67..8073deac35c3 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> > @@ -189,6 +187,11 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
> >  	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
> >  	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
> >  	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
> > +	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
> > +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
> > +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
> > +	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
> > +	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
> >  	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
> >  	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
> >  	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),  
> 
> [Medium]
> Are these five new entries duplicating values that already have a
> standard uAPI?
> 
> The same five firmware counters are exposed through the new
> .get_mm_stats callback as the standardized MAC Merge stats
> (MACMergeFrameAssOkCount, MACMergeFrameAssErrorCount, MACMergeFragCountRx,
> MACMergeFragCountTx, MACMergeFrameSmdErrorCount in struct
> ethtool_mm_stats), and adding them to icssg_all_pa_stats[] also
> publishes them via emac_get_strings() / emac_get_ethtool_stats() as
> ethtool -S strings.
> 
> Documentation/networking/statistics.rst describes ethtool -S as the
> private-driver-stats interface; counters that have a standard uAPI are
> expected to flow only through that uAPI.
> 
> Could the firmware-register lookup table used by emac_get_stat_by_name()
> be separated from the ethtool -S string table, so the new preemption
> counters feed get_mm_stats without also showing up under ethtool -S?

This -- not sure about the other complaints but this one looks legit.

