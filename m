Return-Path: <netdev+bounces-257716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OHnMDG9hmkrQgQAu9opvQ
	(envelope-from <netdev+bounces-257716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:18:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 631A0104DED
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7B13303CEA5
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550492853F8;
	Sat,  7 Feb 2026 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee0d4BmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD417A2F0;
	Sat,  7 Feb 2026 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770437911; cv=none; b=UfFwV+Iz1nj+xgQAxtzhY5HyxoqslXH0iu58WgsLxTswZsLXxKirOOSV5DwRctdnv9uHVEEhkwAmPEB0Ju0g/bmkjkF0hHGKPnS8OSwyK7BMiGk8/86NTY5UuteR8SFlkI2vxUgeSdq2KwCWgwJGF++2hwzCGS3TsGsbI+v3MVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770437911; c=relaxed/simple;
	bh=I/XPaaMl7qmHyAIo/RZRkeko4OP/CUjaw/tpKV60tgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbnXo1HuL+F0HP9+euJ0n4mG+MqF+bMSU0Oea8M2nCX0em1R8oLQFSl8mntJtALbYFF2UaIhdd4CreXKBkFa5YMvBWDHTzeA1NdEdc+JCB+nCA6HXT7TVyR+lZ8S8IHCAaZYW3RlgnsXRS7hhvzWRKvZtTIEBgO5x69woevhKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee0d4BmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C1C116D0;
	Sat,  7 Feb 2026 04:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770437910;
	bh=I/XPaaMl7qmHyAIo/RZRkeko4OP/CUjaw/tpKV60tgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ee0d4BmYWWvHV3GWMPuWrxlk6Fv7lKCcva6DL6ccSKmQ0OumJuPry1IQD2N8GsgJt
	 n3JfVn0hD3Ejno9RqYXG88Itr+1F0W9NzayXXTMBIWRxZAyKTYEmC9Az8zDhXobtvI
	 5dH3Zv4lcDVn4Av1RrLSrsizD6eKGWpz4eOEt9j2NcdZYXGq3h27liJMzAUprMIamG
	 ffEqdpHoWfFu57Vttw0L7V78zFtp6NTfA6t68oKObIGDKd6XGX6icWm6zVvRY5cWtc
	 9qz1SRh1FDdeg3cBhNJhIcUAxv8C+np/7eqVwYUiYurZKO8nlhNHZWGXwYOclbHDVr
	 C6BlbeWHnwEiQ==
Date: Fri, 6 Feb 2026 20:18:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] psp: support rekeying psp protected tcp
 connections
Message-ID: <20260206201829.45fd9675@kernel.org>
In-Reply-To: <f3560398-d6fa-4f05-9496-f0e59a5c0fd2@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
	<willemdebruijn.kernel.37bf21c78aadd@gmail.com>
	<f3560398-d6fa-4f05-9496-f0e59a5c0fd2@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257716-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 631A0104DED
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 16:43:46 -0500 Daniel Zahka wrote:
> On 2/4/26 3:45 PM, Willem de Bruijn wrote:
> > Daniel Zahka wrote:  
> >> In the case of tx rekeying, as soon as we install the new tx key, we
> >> have no use for the previous one, and it can be disposed of
> >> immediately.  
> > So this defines a rekey event as an instant in time. An alternative
> > choice is to rekey at a specific seqno.
> >
> > The difference matters only for retransmits.
> >
> > Not sure there is a strong reason for either. But probably good to
> > state the choice explicitly.  
> 
> I suppose if we think about a rekey as occurring at a seqno we could do 
> away with the deferred key deletion, and instead just wait for data sent 
> before that seqno to be ack'd before deleting the key. I would say if 
> nothing else that would be a significant improvement over what I have 
> right now.

If you mean the driver xmit problem - not sure this changed much,
a (spurious) retransmission may theoretically still be queued on 
the driver ring when data is acked.

