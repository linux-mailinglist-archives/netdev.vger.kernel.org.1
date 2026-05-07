Return-Path: <netdev+bounces-285523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EDqF1YO/WmFXAAAu9opvQ
	(envelope-from <netdev+bounces-285523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:12:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B390A4EF9F7
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DBEB3047E67
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8A34EF0D;
	Thu,  7 May 2026 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="X0/sJHVT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FB318EE6;
	Thu,  7 May 2026 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191913; cv=none; b=n0LqYdnHIceH7MD+HVem+0KOY0nEJUeXp7eiXzFs2oag4arv6+Rg3vvyh25KlmwR+fVE9Sc18FRu1xCqj9TmKYMXZXOP4PI5boMG1JSYssQyOgdKHpzMpIxw2/ucBd6qDBVgHtdPBtGv44LOS0F3C0Ls1PWD41bFxaRd8GO5xys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191913; c=relaxed/simple;
	bh=8JSg9r72ljwweYTMVtgN/TlsiqysZHew7xYeUb2bLqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgD0tOH/uWHiLFlfBGSDbno+4cmQVy2E3Fx3KlgShDwSSSKO+U83sYGDKEtD5cJo6vqyg7PxLlVTVlZy9d2vvj0R4L0T1HfSNzVxw+FucS27LbKYicSVmNzZI8PlBU45ULbJVh5ta+GI5cZP1xGJHvczWFT0lDp3QeYWERZolnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=X0/sJHVT; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1778191902; bh=8JSg9r72ljwweYTMVtgN/TlsiqysZHew7xYeUb2bLqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0/sJHVTsw/4QPKa/S+b5VZ1vMOigLRzwRjwdLeZ3SYsRSVY/23DjBNtmYb+3VYJk
	 3b2Xxep1K4TkYRLw+zPIAHGp3zpTs2qIV6XYqN3r2p47HYfwpmDXKmYzYrE5WHTOeQ
	 x6VnHeDaBjou3pXxwa6P2mYlR7I3FtmMd6mF/h1PEHl0CJWY0IdydlPimb3Fn9odSe
	 QrdezghFl7yyW0t7c8d6198OXzMZczE+GfTcZNE7yLhYHw1onObbPc2DejJqzS6qpQ
	 RWU74vcRObSo0+pahD6iOeYF8W2vpvfN4QWg0REDYl5c4dYTHCrZyddfLS5W4d5IVt
	 6MFLQcR8gG9Bw==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 0494A12591A;
	Fri,  8 May 2026 00:11:42 +0200 (CEST)
Message-ID: <5f123bea-f2c5-466a-aa47-3db1f6142acd@buffet.re>
Date: Fri, 8 May 2026 00:11:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>,
 netdev@vger.kernel.org
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <aftfVvru3npQ9kWq@google.com>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <aftfVvru3npQ9kWq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B390A4EF9F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[buffet.re:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[buffet.re:mid,buffet.re:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Günther,

On 5/6/2026 5:33 PM, Günther Noack wrote:
> For the final revision, I think it would be good to squash the two
> commits that are about LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP.  That
> reduces the chances that someone backports the first but not the
> second to one of the distribution kernels.

I did indeed split the implementation of that access right into two 
commits, 100% to ease reading each part of the change semi-independently 
for reviewers. It can/should indeed be squashed without losing anything.

-- 
Matthieu

