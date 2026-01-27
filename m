Return-Path: <netdev+bounces-253979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMhFAzEKeWmxugEAu9opvQ
	(envelope-from <netdev+bounces-253979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:55:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92758996E5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6603630DB2F1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378632A3C9;
	Tue, 27 Jan 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHC9ozcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F8329C5F;
	Tue, 27 Jan 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539637; cv=none; b=Im+jys1kMaR9CLO0Jkd6r05o6tomHilf/YRhz5XJv2EzIRLtxqzNVTphfoHYIcD6cU/tNMODJIvGjBbt6OQf37BYRvDk0bCA+EEOoNVuabIlYuZfd6oRxb1IXIkfCmJhjX0CDZNWaoE/PYWweKvqUnU1H1s7xEAw6kmyLhU/JTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539637; c=relaxed/simple;
	bh=+UVH4DQvol0wsl55oFN29/mx4ehVmvcDVPNiUqen2Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwLnWKSuGvPveL05TYgHOci9igR2oQEMsn9I35DbLmRxJ7GUSeP0dCtDGkbvoMkuTd/jorscS7Dizi3PDooQvwqrmk03o0vaMNVBIyAQkPgCnw6+jw4O5QR8IeBBzu0vt1qog1YfhaKXDXemyl62SZmU07cqvDdQluWC77Sb/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHC9ozcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9B7C116C6;
	Tue, 27 Jan 2026 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539637;
	bh=+UVH4DQvol0wsl55oFN29/mx4ehVmvcDVPNiUqen2Kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHC9ozcwCxxmSno+5UsOABqs97HSK32UCPVKjQ1gJpyvrCrnfE5iDDFLYHC7aHirG
	 GbcdJOoK8rHdn47fEU2KKZPd7ocHUtvgKNXWy7t3YBqXk4VfjV8qxpPbFkIXiGtpmW
	 UqtxEBp+31AbijZ6QiKEicZ+Rm+FTOBc7cPG7rspZh6LGO9rZBh2fnjqyTEkVtfHtj
	 D1X1Ei+lErwLZqIWd8tGu/twqTSIQZdTgJvrGOc4MMgGTEBGqdP5N5OnWjKwBr431g
	 +ZzxuQY2XTOnjUHq9wLZLmBcAs6xXG1FijoS8HtmHBK9nfqwi6isRUHfDxDoWvTPS3
	 lE+vEVlqIyh8w==
Date: Tue, 27 Jan 2026 10:47:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: pabeni@redhat.com, pavan.chebbi@broadcom.com,
 rahul-rg.gupta@broadcom.com, edumazet@google.com,
 ajit.khaparde@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, vsrama-krishna.nemani@broadcom.com,
 andrew+netdev@lunn.ch, horms@kernel.org, davem@davemloft.net,
 michael.chan@broadcom.com, rajashekar.hudumula@broadcom.com,
 vikas.gupta@broadcom.com
Subject: Re: [v6,net-next,8/8] bng_en: Add support for TPA events
Message-ID: <20260127104715.7b552ad9@kernel.org>
In-Reply-To: <CANXQDtZr8-_hVARZyt9xZR-ej8fTZNc-pvg4r3fAPB1ActM2fw@mail.gmail.com>
References: <20260123193504.285573-9-bhargava.marreddy@broadcom.com>
	<20260127032255.3847218-2-kuba@kernel.org>
	<CANXQDtZr8-_hVARZyt9xZR-ej8fTZNc-pvg4r3fAPB1ActM2fw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92758996E5
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 23:28:46 +0530 Bhargava Chenna Marreddy wrote:
> > The agg_arr is allocated with MAX_SKB_FRAGS entries, but there is no
> > bounds check before writing to it. The bnxt driver has a BUG_ON guard
> > at this location:
> >
> >     BUG_ON(tpa_info->agg_count >= MAX_SKB_FRAGS);
> >
> > Is there a reason this check was omitted? While the check in
> > bnge_tpa_end() catches agg_bufs > MAX_SKB_FRAGS, that happens after
> > the aggregation completions have already been stored. If hardware
> > misbehaves and sends more aggregation completions than expected, could
> > this overflow agg_arr[]?  
> 
> We didn't include the BUG_ON as per this discussion,
> https://lore.kernel.org/netdev/20251225125229.GL11869@unreal/

Oh, interesting. I couldn't find it in the patch I assumed it's out of
context. Sounds like AI has imagined it again :|

> We plan to address this HW misbehavior using a recovery mechanism in a
> follow-up patch series.
> Please let me know if you agree with this plan.

IIUC you're referring to issues like "leaking" the ID which is then
recovered by doing a TPA / queue reset. I'm fine with deferring that.
Simple bugs like potential OOB memory accesses have to be handled.

