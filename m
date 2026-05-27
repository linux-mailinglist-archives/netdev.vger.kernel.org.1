Return-Path: <netdev+bounces-292468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMUGIudxF2quFQgAu9opvQ
	(envelope-from <netdev+bounces-292468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:36:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E25EAB1E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC25A3009169
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40462E3AF1;
	Wed, 27 May 2026 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKwADrgr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFC363C60
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921379; cv=none; b=kmDSKIyPsEBUFKdkJgphwEMJkID81musxX/1mg65m5Smk6qvuqoCV4V9DbdnU6vBMc1bOzKZmEcyNeZn+CQPcosxxt4PugQoVdLYnFeJuf1C3LhwYyMWrOXeCsrIQuiuUqVWYV+3Wd4C5P/XVod80M+9kgFGsrqIw6wjXyUqX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921379; c=relaxed/simple;
	bh=VEHvifIf2h4ngrtdzTMJGFGtQoqcD392zoSfpiPmBBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvAf0lIuGCdeZUjl6R2v3SWjqZJAKbw1CiQohazL/XAfmVz6CazymFtGoIOxYF9LlfuCP4JrSId2Cb1l4J9Nun0SAhgyb9Ftt/VAD3CppL7uJ2QelopqWS/RxJxJonFUqEBUXdJ2Xe45TeCGQKTPtJQgI1iYUXyxMy0DdvwRWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKwADrgr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0CF1F000E9;
	Wed, 27 May 2026 22:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779921378;
	bh=0yabREBtdvuWZG8/PEf31cTg/2D8cnUNoAqn0QYoWYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AKwADrgrdN/ehavWYCEP96O3nQXa2svNKfgzZV8jDnuTvQ0ze5bx5gLcH9iLxLwke
	 x6I0bEx/uk8FFwzsJIkhwaT6a4xfYi5CDDrHVyyNTtagk5b6ZrYLPH0PrXhIrY6QR5
	 +5XAkl9xBzt00QelIRAgkFEzyFlo1g5OpqhFvtqIkZjWHHvKtqnwEl+0sudC8MoCPl
	 5EhWqRWGCAkjYNCgTwktksF38xf0ZAetwC1bvAXBTTmsKCCuEcgYv5V69+VGWfF7+w
	 HpRKbjWSaNJ0c1uojHlwEFDDHO4bs0jfu8iA4ecV7gFQDveLur+onU6By8T2yMRvuC
	 KlSbZKO/RcIow==
Date: Wed, 27 May 2026 15:36:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: steffen.klassert@secunet.com, netdev@vger.kernel.org
Subject: Re: nipa: tree selection fails for ipsec-next series?
Message-ID: <20260527153616.17c2b5e4@kernel.org>
In-Reply-To: <ahaz550I55ZvMRDI@Antony2201.local>
References: <ahaz550I55ZvMRDI@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292468-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A8E25EAB1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 11:05:43 +0200 Antony Antony wrote:
> Looking at the nipa source, series_tree_name_direct() matches the cover
> letter subject against _trees.keys(). Since ipsec and ipsec-next are not
> in the deployed conf_trees, the match fails and nipa falls back to
> guessing against net-next. I am guessing ipsec-next is missing in the config too.
> Where is the config nipa runs use? I didn't find the exact config nipa bot 
> used.

The netdev@ NIPA is for the netdev+bpf patchwork instance, and 
the related trees. Should be easy for y'all to spin up an instance 
for ipsec.. ?

