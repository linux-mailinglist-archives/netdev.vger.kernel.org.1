Return-Path: <netdev+bounces-264943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFKRD7xQq2nZcAEAu9opvQ
	(envelope-from <netdev+bounces-264943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:10:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FA228338
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4751B30297AD
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFA494A19;
	Fri,  6 Mar 2026 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMXlmh4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F9494A13;
	Fri,  6 Mar 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835001; cv=none; b=gQn8FKIkPgfvMJDfKnQcwtoq90FkLMpwFFEGRUhTtAZhk7S26Kho050r4lmk5Wlc63cBf/9ebGzHET21VMhO2cWqxQyjNn4ufhvF9/C7hcUTvHYQVPHM3yCMfOyRQTA0EadvE+khL3Ery+Ssqq1ZIq5TJWGzMWMC3/vWsbk2Pug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835001; c=relaxed/simple;
	bh=RYAyxzeSLE7RG7ogsH1lNJ9UT2pOY9bqibfbO9VMaGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3pMI5d8urF62tXotmAng18U9XdY4tOml/csIUn7UPNiLdCEp97x6q1YUeYvjqWo+QXSAYu6of2H4mzkn0uMGkMhhbd+sB6hPqD9rIkSAQdIL4euVxvD3YNj6VTTlEenkbDGNesg4kDQW2LjKwhBhkhca06seB27N2mta4vjkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMXlmh4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE78C4CEF7;
	Fri,  6 Mar 2026 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772835000;
	bh=RYAyxzeSLE7RG7ogsH1lNJ9UT2pOY9bqibfbO9VMaGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMXlmh4/cI1gH8JhsAVVyjOKHtdPp6URvfFSBFYfUhJYzl2V8vPS39wRMeUOKuhGL
	 X6hB70aemwwCiAI1Hvm7Ppphwiqjfmutgn7Xb8ZoOGO1pJtziyRLiNoCcb74t6nXKU
	 x7UervIXEWzEj8ZqipOYJ4B5TgChFNckfpnsvUcyhsBhEWGS93i8IF5zZPYbhwEPBb
	 fuiBvQLTzo1ZwO4CrPY5RHN+MqXWtQ03XkCKbmsS6sZEiAWeeefUr26VLKTC+Ltcq/
	 8Q6k+cxu2iNJWhXUqfYPBsVke2UelwrMv/FwGVZvB6m81qDjKd5JVbljIh67rxWFNP
	 vVv7beqrlMoSw==
Date: Fri, 6 Mar 2026 14:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Jacob
 Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>, Mohsin
 Bashir <mohsin.bashr@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Pei Xiao <xiaopei01@kylinos.cn>, Stanislav Fomichev <sdf@fomichev.me>,
 Willem de Bruijn <willemb@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] eth fbnic: Add msix self test
Message-ID: <20260306140958.42ccee3a@kernel.org>
In-Reply-To: <aasqpPj2rOIKgnSY@PF5YBGDS.localdomain>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
	<20260305150947.16893-4-mike.marciniszyn@gmail.com>
	<aasqpPj2rOIKgnSY@PF5YBGDS.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 934FA228338
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264943-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 14:27:32 -0500 Mike Marciniszyn wrote:
> There is a change in the patchworks checkpatch test the wants to see this as:
> 
> test_data = kzalloc_obj(*test_data, GFP_KERNEL);
> 
> Unfortunately, the net-next repo does not yet have this api and doesn't
> have the checkpatch and the new api that comes in:
> 
> Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof allocations")
> 
> This looks like the checkpatch.pl in the test is not from net-next/main.

I suspect your local tree is old? Or I don't get what you're saying..

