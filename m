Return-Path: <netdev+bounces-261319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCqVJvc2oGkqgwQAu9opvQ
	(envelope-from <netdev+bounces-261319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:05:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9851A58B2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64CF630093BF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A983803C6;
	Thu, 26 Feb 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="UAxOvLyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78936682C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107501; cv=none; b=svvi+pzIKBSLjrWJ08CADSxFtTbdy2GCdn01oWr4fb2vykhcQAUKOwkxcqDiAkd3NZKn54qIiwARLGjZLVbKaT+R7qTLCqypJa8gEDxmwymIPls8KbrASB+GZEhLozQlObKFVof1ygMigiixrD/YvjvLYaKHEd+oeMTk3HJxYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107501; c=relaxed/simple;
	bh=qMKVcxH3JxZ2sUWwtxj/iC4YG2Sf3lqypstyaZYLIew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLNJD2lrAot3Lk4DxjofOxpnkml2JrmkVv8WNlNoVpRexT8/Vzp+jH9XTLHtlWUnvMsDxCf4x0jvcj44mn/+69cTG0Q3DpPT0nz/rrtAIvF2ibFE6rFsIG7SFoLNq1fPbx3DxyZMVUHYxjY+LX3RL/8KQg8kjt0T6X83guj67JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=UAxOvLyk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1772107490; bh=qMKVcxH3JxZ2sUWwtxj/iC4YG2Sf3lqypstyaZYLIew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UAxOvLyksafMv4xOBZT3Ygt991y/0VBfiJ0GXPzNRzSuatbgpYuwtJV8NwH6YOaXo
	 tSPGYce3i+p97CYUNxL91cpme4NOlQhmPfz3Ch1K58j9kLWo4GKXNCNI90emm4z/nk
	 vLhhNliVEh96U2xXQlKAYa4TJFTd5JPzndf0EwlNM1hJdkrqxb6nJdqLdKJtpfeG7Y
	 p0AhEbJNX1t5djKpQjNpap5aRezlUwJCsNzpSB6LsBElo6C1bKcByYZrC4t+jFMzAN
	 kmpCNFCAD+q56R9AuX2rIeByonzUM52xHy+H/HW+uXZFUqHxJhLPLFrjzFdIuYNO46
	 IQ3AvEb9/eJsg==
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Jamal Hadi
 Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>
Subject: Re: [PATCH net 1/2] net/sched: sch_cake: avoid sync overhead when
 unlimited
In-Reply-To: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-1-01830bb4db87@tu-berlin.de>
References: <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-0-01830bb4db87@tu-berlin.de>
 <20260226-cake-mq-skip-sync-bandwidth-unlimited-v1-1-01830bb4db87@tu-berlin.de>
Date: Thu, 26 Feb 2026 13:04:47 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v7fjlnhc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[toke.dk,reject];
	R_DKIM_ALLOW(-0.20)[toke.dk:s=20161023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261319-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[toke.dk:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:dkim,toke.dk:email,tu-berlin.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C9851A58B2
X-Rspamd-Action: no action

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> Skip inter-instance sync when no rate limit is configured, as it serves
> no purpose and only adds overhead.
>
> Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-=
instances of cake_mq")
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

