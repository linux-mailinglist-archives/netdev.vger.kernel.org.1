Return-Path: <netdev+bounces-292638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBrAImYQGGrmbQgAu9opvQ
	(envelope-from <netdev+bounces-292638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:52:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3776F5EFF81
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DA6B306A765
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168723B583E;
	Thu, 28 May 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="2XlRQg5W"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4703B2FF6;
	Thu, 28 May 2026 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961824; cv=none; b=nC2rWfRnOcTXnCAyo+caNCsurxpPz87kJvP9zYSzez3cv9gNEV/QVQD09o4ZD5hz00Z4ED2F7yK218Pcs7U4vuA7rxIxa5Jr0jwXutGIrfucc/90EMolUovXqRAz7iABCr4N0Vq175ZIUXvYB/T46FoPd8tQyV8j95MArPSklcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961824; c=relaxed/simple;
	bh=q/yFETOVxE5lPK77YT6DGCEtEdwwDVTyGeprqe8CyXc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=neyIabqnIQkf9/WYJ/8JLQaTosct0jDebm3YGs4wXIRt/tK+QJ8zHBYu8I9X9k2hH1J7l6MMMlu6ZyIJ/S8ziOQKrso2ccfn4u7wzbhLy5jn2qSlyzSOQJxF2JxeiLt0ALc8AG6HFsZiO1prn0b6DKIgTWmf+Rs/lnPvO9g6cr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=2XlRQg5W; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64S9nub9018745
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 10:49:58 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64S9nub9018745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779961802; bh=q/yFETOVxE5lPK77YT6DGCEtEdwwDVTyGeprqe8CyXc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=2XlRQg5WONXBHiNAzSPWkFSyLQ82I9BfQ5VW2Ezp2j4rpUpfvfFPMGtwkvm+NAuiD
	 Jo9jHsUkzkEBa/zyWfXiqoQRY2LgTOiVEMPaooOYnMAYfrwsubf7q0LAfRq1yXbDhz
	 UqRY5lBNEGpNNWzHsPehLk0W+29tzPvaFg/b7lYvcQaA/GCYbjG4ZsP7w/xWZTXyzT
	 kHf8HeBaY6KaRWVtckKOnPdQg5OIL62OW8QCrHhhyxPuWyVMzUmDTsC0X9iTN3OLIf
	 zrnpu7PsWBAiIqyLqiut5C62aT+pUq4WRSg2qUqV45xdhsMSrtu+I2X7zLHIRZnddX
	 Oqsqmj2SDjPDQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <CABvLYuBZ=U96gVpYqHnnhwBZxp8OZzH-W503MsbNd4JPqLbEpQ@mail.gmail.com>
Date: Thu, 28 May 2026 19:49:45 +1000
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D8553DC-DD24-474C-AAD4-46B1ED80669A@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <0FB1CAF0-D30C-4A24-A684-1D1DBEE52FA5@padl.com>
 <CABvLYuBZ=U96gVpYqHnnhwBZxp8OZzH-W503MsbNd4JPqLbEpQ@mail.gmail.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292638-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 3776F5EFF81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> I think some of these were the result of running the kernel review
> prompts through Claude. Other drivers are probably from before LLM
> reviews were introduced.

It seems to me it would be better to validate idleslope and sendslope in =
cbs_change() or cbs_enable_offload() so that all drivers can benefit =
from this? Also stylistically perhaps the comparison could be broken =
into >1 statements.

> I have a different opinion. The driver is in control, if these get out =
of sync
> you're having bigger problems. Either something else is writing to the =
device,
> or the hardware is changing state by itself which means it's unstable.

Valid. :)

> The 6020 family has 4 queues, but only 2 queues support CBS. That's =
why there's
> a seperate queue mask, even if CBS support wasn't added for 6020.

Ah, I wasn=E2=80=99t aware of this. I suppose this is the best solution =
then even though for the majority case it could be inferred.

Luke=

