Return-Path: <netdev+bounces-284598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMYaC1F4+mkQPQMAu9opvQ
	(envelope-from <netdev+bounces-284598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:08:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C84D490B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D1F30103A1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA27330328;
	Tue,  5 May 2026 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JllDDKT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B33242A9
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022453; cv=none; b=s3HBh91gzp1QWzURw+1lNYioy4+n7bqAKA1/Bq+4O80ewPwzno+sfpsavbM6gPWJp5kZyxBgdNQ3M/E/rzH050scI4ek5LWbuXcRavIhM6eIARcA4CgHDYIFcghlGjuYfCwoA4I3pdWAb0iCNq7Z+QmxLPfKvtlZ+VA2ok03kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022453; c=relaxed/simple;
	bh=UK/3QSWAx0GO7gZxapFSwtuWEOrtcIjjzc9xV4JUgFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=TrYII1sVoVsJqFXrp3sbrjjBathhpbeEYyP8KeUF5egRMH0QmXikImT722YawlfUhd9HYMH2rV2XVSSe7wEW/6gNMb9KQs9DPxfk9ivsAlscLylOqmMX7LVN767JsFjJ0dHqAI8r4VTNbVbdiwAaJtzBoDPuF10dDEjA+AWZjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JllDDKT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D188AC2BCB4
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778022452;
	bh=UK/3QSWAx0GO7gZxapFSwtuWEOrtcIjjzc9xV4JUgFU=;
	h=Date:From:To:Subject:From;
	b=JllDDKT0kh95jpiYtbnVhx5zQbfkUuUD5oiITc4KfU+ZALC+L4MrV65eXYbkhL5Rr
	 8wEdIBl0B/gYxEvjNTI6uB54noiT5EhA6u/hpkL3ZfWg3164M88EiPfiapfK3ByATS
	 6crRyqrWVYAJnfpPcmtv2pUN0nHKSWlCFeMPaJ3OPZ/F0XpSYv+aDV2i1aevUhrAWr
	 82M7U0IwTWjQ2VQSbKtxa+5x+c+nFoYu1zNNqQ8byY3TrC6tT83noRUCd+IV1UpyAZ
	 g1IBNKCEhg8BXEmfqtwAvQ/9KXckdAR7xlkCrJLCKChU6vsZldrQD5anS41eO2Tgat
	 SRz/Bfmayzjiw==
Date: Tue, 5 May 2026 16:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - May 5th
Message-ID: <20260505160732.534c947f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA4C84D490B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284598-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Present: Eric, Jakub, Johannes, Kuniyuki, Simon, Willem, Paolo

Logo funding approved: aim to use at Netdev 0x1A

Academic Research program
 - Academic Research Grant Program proposal drafted and shared with the group
 - We should not expect usable patches to be produced
 - Plan to set general guidance - Netdev focus - and some example topics

Netconf
 - On the first day of Netdev 0x1A. 13th July
 - No CFP due to shorter length and collocation with a relevant conference
 - Invitations to be sent within the next few weeks

AI Review
 - Claude-shiko running, and finding slightly different issues, does
   not report preexisting issues
 - Hoping to integrate codex once broadly available on Bedrock, as well
 - Once we have Claude + Codex the accuracy should be high enough to
   start emailing the reviews out automatically (and update the netdev
   "FAQ" as appropriate)

