Return-Path: <netdev+bounces-261320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB5TJBY3oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:05:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8481A58D9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4EEF301D06D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67E3803C6;
	Thu, 26 Feb 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="IvwH9DoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAB37FF6F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107539; cv=none; b=ZGik03ehv0U3Jw8X8yQLZ1m87HayENIsdwkfhpfX7fx6mt2fX+DIMY7qArltIHMBlPkChg5h8Nb3ygOAMJZ6KM6rUy2BXl6NnYdXj/sGOlZl7cSXzBW71LSq2hd996qH2W2k7TPlKAW1h4R4QXAUNqOl9oxqToxrmA4cSuQ6WQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107539; c=relaxed/simple;
	bh=A5dFRRCQjsWGVb/MvbVCVM8MvJA8LbLiMMWYqv5yflI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CArkhfpB1rUbraGrVYUKVhNEDXMgtmjjAOwt5diihsuEP/rmJJwGWhZqA6obS6M38RGqr0DQJEhkPpQlr8JmTzmVADjiGnEwbLJnPNaJ7k1YDN2oy7rupvyHRdhm3qgOvy/02/MT7fwElNDtSiKwFVqKEHG2NJUXvrRR1KfvMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=IvwH9DoY; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1772107536; bh=A5dFRRCQjsWGVb/MvbVCVM8MvJA8LbLiMMWYqv5yflI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IvwH9DoYYdKF9J3FjEqQYkV0sYW5LehRJLHm0OiCL1eD7GVONSeuD5gFqh2i0vJmB
	 SXW6JR18hvKxfylkfzmI0QPk2nfUZc7Q+5LODGL6GhvylxM9GhJgjG1Ytn/+cf73PI
	 rjRIz8JiRmpaC0sXDIn3HcV2rpRoJ/6ce+yHLNyzbIOMhA2zujWwGkJOsU86KxY/WT
	 t3FEKfa3N4inQTMQNkeSDitg3c9cfXHzcoeCbZDTahEKHeVZFjCO8oET3ib//GBl8+
	 leLnBCqMoGx/xkip7MYZlTmlNDZ1Ohipj7IvtPE83rbH8V5F/5lXzn9NGWlU7Q1yB9
	 +Vx+bw8qBhuKg==
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Jamal Hadi
 Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>
Subject: Re: [PATCH net 2/2] net/sched: sch_cake: fixup cake_mq rate
 adjustment for diffserv config
In-Reply-To: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-2-01830bb4db87@tu-berlin.de>
References: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
 <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-2-01830bb4db87@tu-berlin.de>
Date: Thu, 26 Feb 2026 13:05:36 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87seanlnfz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.63 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[toke.dk,reject];
	R_DKIM_ALLOW(-0.20)[toke.dk:s=20161023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[toke.dk:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:dkim,toke.dk:email,tu-berlin.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C8481A58D9
X-Rspamd-Action: no action

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> cake_mq's rate adjustment during the sync periods did not adjust the
> rates for every tin in a diffserv config. This lead to inconsistencies
> of rates between the tins. Fix this by setting the rates for all tins
> during synchronization.
>
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-=
instances of cake_mq")
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

