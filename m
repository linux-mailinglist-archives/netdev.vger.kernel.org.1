Return-Path: <netdev+bounces-260706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFpROgRXnmkKUwQAu9opvQ
	(envelope-from <netdev+bounces-260706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:57:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980AF190441
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC4D530E6AC1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD10248886;
	Wed, 25 Feb 2026 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQdH/H/q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701671FC7
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984187; cv=none; b=S4mk9tN8meLpvmxE1DgFu5l8RapRnHwptqiZHFEXa89Bz5jPdWmMOd5kLfPijzAAacE+9uqbwH3PeClin63fuUuypmHmXzUdNfVpSb3vcpCZg8Xx9qyx/aLnLFWq7QhcvNxik3aR3BoQh6NDexClPjhQZt3dIIGUd3Ngt77TDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984187; c=relaxed/simple;
	bh=UnvMTmqzgD2ANWMjeTsjYqnnQaamppxc4Fn/oLiJKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIJTy7jXDcDSc8edShpSzpCbXGY8NM9O00AtAQf+qUdyEpx+tphkHo711pEKU9wHGj31Fz72FRw6V/2aEcbFC0Elj4HOgdhcWyLOIyWHBi9OGeywwgBp6Dcg8IGoaSuo5461tVktw1bxuZ5sGJPQ8bg5XxpJkPtcfPJGxOTR7RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQdH/H/q; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4b77adso7601261c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771984183; x=1772588983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oUK1ogXqhyxce3y3aAcPvYgkr3Cbva04wd5JBw1uJzo=;
        b=iQdH/H/qYwNO2wASKQKQ0ywRO6J/uwTFWonirAAvyo84p4DFtSBsaLw+1vGslhoVb0
         YNhIIynPxvFfKSD7K+b2z0EtJcgLgWbPyJeMVPvrHZyuHsx8T83ZrNg8NTfooJnn2mhh
         vNboLhKpv6JYXf/5lhDnriS54auJ/g1eOkejTiNtvfGOaxZuu9u5HmsIDnwQNOTLNBOv
         KabwkyY5b8tVVICTkRFoxncYgG/c18uzUDy93w4Bs06M9V0ao6zDLVmRapU0lIcnXd/b
         V3V+SPk93mkep8RdLcX6ycT2iH5nOafOwIsLDO1QH4lxCc1dyJlJ1/BbxKCbDaViHEMr
         LxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771984183; x=1772588983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUK1ogXqhyxce3y3aAcPvYgkr3Cbva04wd5JBw1uJzo=;
        b=l19nB9JEQtnZ/hA1d9nvP24QkoAhGMeR4WXXsoh/cxhhJW3xqnArSms2uuWaDiyc9j
         wozX2Ld2LpaMDboeTla/WHcXSfudM9Gp3VFA5FuI1KNBHZtyG4fVeU8SKFRmYhPMCgs/
         HDlH4aYThrt3+HPTR93fwQgaTlreb58fqQMlR6NlG03HT53DHRXLbJ6atSkCm/PT80zN
         TrSGR5yvjDMPhui2HHSybNeMDPR9X7E/jzY6Se4aeFd8jIW9/GQSzAJqLs+NDQbi8ipx
         wWT1xhRqWMUwdd+CxM8Gb0NZs8yI+QpsF0e9xIUp1kQwO6YEtwsy8Wt7rs8X7qGs3aIc
         M4aA==
X-Forwarded-Encrypted: i=1; AJvYcCWhGPz/iP8LIg7UrNig1vFAXZnqNZAel4ENqlKqhwJ886cLMEateqLyizMHFf+JIRfX8nn07pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrP8Yg3ISML6pity3hFq+Yju7zAr7HJ0OP++R+/E6u2rtN4Fy
	sBQMGP6wx0OS+6c4zLVwCbb17f53CcztaEUBvCz9wX3eRlEtecOOwio=
X-Gm-Gg: ATEYQzxzXvtehY4GGI1bCi9YtwXzJ+2KDuyq3zttqW8NcpHkTf6v88wWDE9Dgz5EroL
	HnczZ2/9ngN4EVsjAbSikAZihisjPnuLJpvhFSXRheiMxloy/hUpldzS7HcCVmT8kf+bBtSccZ4
	/477PRntDgxNfbmzrsso1yP/9MJtDMqlFxXw8lyBSYphAdOvBtzjSApOiHAxi8LSKLvu5j+RKVM
	hs0IlQ/zaJ73jPoyuAZODBM1h+++VNDbaGViHomwykTK88MciDW4UMXQTvL97vhhKw43W9H3IyS
	MKPT74uSL+RfelbTHh1VDSG8MdioXjnCka4//8dQiKgbEMWBN3zBKLFQwD/Y/uOxmsFjSTgMUl8
	9/UXu5B/JixwNJ8wupnzRohGgTpCdgta3Rv2VQRC/GQgIEO8CRilDI9crAYRAM1Mu7ia1tfq9uZ
	7sYep8RxKrimo8dPxmrTNEFHalsQVc4ZVzB5tUaA1FN47zN4yRiJPIdfgrUsmIv4SzeVKXVyEQM
	AB7e55Ysa28k8QWPA==
X-Received: by 2002:a05:7022:6b94:b0:127:5c3d:bd95 with SMTP id a92af1059eb24-1276ad32725mr5411784c88.32.1771984183281;
        Tue, 24 Feb 2026 17:49:43 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af102d9sm11140052c88.1.2026.02.24.17.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 17:49:42 -0800 (PST)
Date: Tue, 24 Feb 2026 17:49:42 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Message-ID: <aZ5VNkUqkTEzX6PJ@mini-arch>
References: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260706-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 980AF190441
X-Rspamd-Action: no action

On 02/23, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> binding->dev is protected on the write-side in
> mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
> concurrent bare read in net_devmem_get_binding() it should be wrapped in
> a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
> with the underlying register in unforeseen ways.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Note1: This didn't crop up in a discrete error, but just something that
> didn't seem to quite follow my understanding of memory-barriers.txt, as
> frail and feeble as that understanding may be.
> 
> Note2: the "Fixes" commit I referenced is the first one to introduce
> binding->dev bare accesses, but the later patch '6a2108c78069 ("net:
> devmem: refresh devmem TX dst in case of route invalidation")' carried
> that forward. I wasn't sure which was the ideal one to select for the
> "Fixes" label.
> ---
>  net/core/devmem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 63f093f7d2b2..cb989949d43c 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -398,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
>  	 * net_device.
>  	 */
>  	dst_dev = dst_dev_rcu(dst);
> -	if (unlikely(!dst_dev) || unlikely(dst_dev != binding->dev)) {
> +	if (unlikely(!dst_dev) ||
> +	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
>  		err = -ENODEV;
>  		goto out_unlock;
>  	}

What about the other similar check in validate_xmit_unreadable_skb?

I don't have a strong opinion, but it feels like as long as we are not
using these ->dev pointers (and we are only using them for comparisons),
we should be fine (plus, memory tearing for u64 is not something that
can happen?).

