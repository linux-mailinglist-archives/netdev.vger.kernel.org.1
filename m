Return-Path: <netdev+bounces-267184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A4mG14Ms2nURwAAu9opvQ
	(envelope-from <netdev+bounces-267184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:56:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A55277693
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D546230292DF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D753FF8B6;
	Thu, 12 Mar 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI8hh3dV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF533B974
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341777; cv=none; b=UfnzanE6iXGItyllrPz43DdM648tKcMMPhVfpe8RnjwmOkqXxhsX8xrg91qcT+DTG3FicJhLdJl4GN3AX4fowEawMg0CqoVW03x1nXlNqRIp0++CxKDA1i3AAQ7wdAmdmm0nISr+BmAJnULhjcINC5Nd3hormmT2gRSHCAz3VUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341777; c=relaxed/simple;
	bh=kWznZNvAog+f3GshpHTgqXEPG6CQ2aWoU6mzA7oIuds=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=FzMLC/V0wS4jKz84fgG25geQDsjipWNBZkYbzi0URWz8HAMEVkVFhhI1e1TcjI12faqG1/byE+5auxaa7sIpIU5z+d+CV7kokvP5vdun/nI1Zok2IDgUZyqpAl4d+V/dRVJ3MVp42vcxcFhitWfb7GPuN32QP5493tlAZhhcFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI8hh3dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC5BC4CEF7
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773341777;
	bh=kWznZNvAog+f3GshpHTgqXEPG6CQ2aWoU6mzA7oIuds=;
	h=Date:From:To:Subject:From;
	b=GI8hh3dVSrwC/AhxnvHOpx4QQm6tv8/mqLqf0gLejSMQbncvsir6GweGvB1smETd7
	 ityelLankmTs/pwLjBeb//xCjA2BlPLd4W4werSWxJA3Vjb/m5PdggYbYwuBbKgfL4
	 CvRbkzEu01/zTDFDxL9VMUqh9hRPm1niXCeDDMO9aRxbI38ZRrdB63LCqQynuNp1Yf
	 0mbyNLjKK07s1SLuDrVjjuK5RbuuWczxVI4yD9f0E3C21XImy6iNvVZ7ge4tH3J98H
	 QuaCrzxCf1/eeoBLTKilxAKZdKf8zGo4a7ucV6gKTsSfdy2g0Ivh0Jyz91+5pU7Dkn
	 vxMqOkbonkXiw==
Date: Thu, 12 Mar 2026 11:56:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Mar 10th
Message-ID: <20260312115615.79c2abb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-267184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03A55277693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Present: Andrew, Eric, Johannes, Kuniyuki, Simon, Willem, Paolo

NIPA/Lab MoU
 - Approved by board
 - Simon to move paperwork forward

PHY SoW
 - Appears that work can commence now

Lab status
 - Racked 2x stage 2 machines, with NICs connected back to back
 - Began provisioning tests (ETA 2 weeks)
 - Added runner for emulated fbnic

Conferences
 - Time to consider LPC Networking track, Paolo will follow up

Research grants
 - Simon to look at creating RFP

Logo for the foundation
 - Jakub to get a quote to create logo

