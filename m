Return-Path: <netdev+bounces-267476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KvbGhMetGlLhQAAu9opvQ
	(envelope-from <netdev+bounces-267476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:24:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F5C284E09
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76DEA32667B9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9F39EF02;
	Fri, 13 Mar 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ0oQ3BB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E23976A0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411630; cv=pass; b=NWuwdKJ6tdkVCauQKUjs7to4Ey1zpVYKY1CMToKwVsKHLzi6RiLItiZwodF25VcmtfjlGs5zdJzH6qk/JOv76foDncxHcRBx5VtY8BiLgvnSD1y4Lz6L7m9RdZryzNgk21Nq/9wccEAoi4HDoIbgmmb7tO6ZxHBlFCs2s0SVnJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411630; c=relaxed/simple;
	bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmwsUi6+68xyq6AMFdZXq0YhuT3UgjA7ZFLUC1a1yBq6Mke9D2J229C0LGUzvnJDVdOZEYF/j0dUCijJ6IfypaLRZ4D/aEZxWQgLsBUr7E0QIwYQZ3B08ohHCVsWYJWhLY4nAiwoCk5TxMPJ6YCjI+FFsJnqFEsooWPePbTD/ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ0oQ3BB; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9431300833so334573766b.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411628; cv=none;
        d=google.com; s=arc-20240605;
        b=OcK2wfOvyttKZyXukkcPZeQbI7+Xx1HNZZ73MzH0dZM5f0ZvbBBkRm/9KBj4uRBs3S
         Jxl+G1z65MAwuiX8cKF4YBM/6h3Gp2VqQGCUkC+lEMr5O4BQE9Mz89+hv2Nw+RcqhSRc
         tXlTVyRkES3Y3aO8ANFt3RxTFFs/ciglnqPy0IrkQVOUIwvpCHQX1FvAJxUMrvcxqSWG
         1LG3O5tD7+PnSPLZVNR4oL7MyEHCaA6nd7so2EgSOMrkHYDruSnp5ZwSazFGpazLBUpv
         u+96oiMJ2h2OoAK85efN2yrxOYdFoZrp3ni1lxPyIqBWXSGwyjsColyEr6o2Ab8uavVP
         5dwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
        fh=eflnSJrf469ty1Tynr//fur73KfwXw8zp2iqPVC2TrI=;
        b=NpG7xlgtnnbERDuxLW4SsTpMahzb5rRHVgx+n8f6pr2gZEcpJoUMW7QrInJodaP2Bk
         ZnF6SX31wbKCBMYMoymbwKZdx2nufUMlOw7fkhaQmvd8rCFYo6ZKrrt4lpflp1aAY+9T
         L1g+Zbgoq8nyG8Y98FN15veQ7WAN8Y5iAusYTUl75zy21ou7y65o8iEIPnEoFjtmgpDN
         TXx8IW6FqXX11xHH49t0Zr/gn9l/b0iVTLEpgnflrO87s1S2qZWIgOMr21OlYNfpULQw
         E3uR3NUXoSZNA+9hEu7xVyY+M8cIqzcPfxTWGjTWAroVSjGVKeeQGXNkFcbC+qKE/+v6
         YKag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411628; x=1774016428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
        b=VQ0oQ3BBX+NKPpXwhfJnE3bQFV6OpDwvP2Cn7jW6Nbj9DG8VUQxOZLuBQGDzeT6paN
         XdKzdeuUcUZ7G6AUIAmDojIeiiqwIFxPiMyjRIlSI5v4DknxTrc15GtOUH3JN7tXIlxM
         W8FgZ+SWEcGA1IaeajJ8kyKXj5GzUSLh6/pKv9MMPCAZab2VDlZlRqewQmWoaJOSQwZ6
         BVdupAtMGI6fUidSrL6M5+qBi1FwE29ALLQgW5gP/qZQz/2KeiIEN+mOnK45t3rttCxR
         8hQoNlAuQ5Cch9oZed9YePQhEivZBlUoWoS/O/mLsBC0jBvvSHcWUowcabrlTJagi2tF
         at8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411628; x=1774016428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckmpy3mw1UK9sEOGwbASSY5L7qTviwDScKOnF+2PxxU=;
        b=WbAqdC3Y3/zKHArFwS5Mg2S2YjpfR2nQuLWoJA2VrX+lS1mCJhtwcxL+4zLHJubqiQ
         LgBK5ngHf8YteYHSw97TyxuDhqSGMQ+N/lQ7KxZ7np77gzTw0+hRAgHANQSuUI4CWtLt
         klq8cw9fuv9CDGxiiHcyUnd9TbeS6BcmOnOrKC2y8b+HpmPotjsVxsL7d1yLqeujGvN7
         qqyD0V0qJ+Q4/IBoo1GChRT0r3+yM+NwBhuWT/TBgq8W9EaZUPmMjwLfqvQHOc9knUDP
         stmj2eXfv3t0fYkIhjTfR3jC6sBb18jM5gkTnPmhV/0WDrqhb1S9HD7EOkznEvgIJ6+E
         /+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuoUSYMKaP1NvSIDfgmCe9D1MKw6gFO5d+u0lUiTPgRsHxvn+Qv/MKlneuOQQ3WjjImf9MMwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxWYnWhQR27WRqUJpl7YeL6zKNbt7U7JNxxUg9QUU075+uGuI
	fl9/0kPtIKBQ6iKjAFeXB/NgN9H1i4AnGyDHHByRlkjXtI+0wiMotUGF+DNmw3tonzsefZlnPWO
	W3XUqVIFi0o2OajQTeKaquhbDTHimfI0=
X-Gm-Gg: ATEYQzw1aTazq3MUwH5jZ/ER9SXJupea1u7qe316wI5OHR1iwFrM9z3gv5UeNVtSUdW
	opGW0iPs/xdB5s65c6rWEfxMLR6ss2bSwxabDt3CiRw0rpZSu5SNK/to+wdUqJ1UApxEgYj2BeB
	YZJFZpGd97hfhad07UWwaXfh10VVm1Yq9JXU+sN27H7mkcEk8ezOPyKkwDoIkyI8cgj6Vx6Yibm
	lLsilH9mEGme7HTxP+e4xScgYMuRw4SuhIvcySrW5FxLBvhNrPcSdd+POKfvCqrGjEKvSAnIQTA
	YsNhZ3n7Pg==
X-Received: by 2002:a17:906:338d:b0:b97:408f:edba with SMTP id
 a640c23a62f3a-b976519a11fmr150342866b.35.1773411627235; Fri, 13 Mar 2026
 07:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312183817.104878-1-teknoraver@meta.com> <20260313131624.6562-1-kohei@enjuk.jp>
In-Reply-To: <20260313131624.6562-1-kohei@enjuk.jp>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 13 Mar 2026 15:19:50 +0100
X-Gm-Features: AaiRm512HRVQlYKx8veJJyzZ-hM-j0qXfMX8S7Ikh0C8Ns4fLLpJwVe8NvjC1OQ
Message-ID: <CAFnufp1xYV9+o=25OSjUc==tjRitqNoO1THwxtPvq7puJZkzjA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] e1000e: add XDP support
To: Kohei Enju <kohei@enjuk.jp>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267476-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,enjuk.jp:email]
X-Rspamd-Queue-Id: C0F5C284E09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno ven 13 mar 2026 alle ore 14:16 Kohei Enju <kohei@enjuk.jp> ha scritto:
>
> On Thu, 12 Mar 2026 19:38:15 +0100, Matteo Croce wrote:
> > Add XDP support to e1000e driver. First patch adds basic XDP support,
> > while the second one adds support for AF_XDP.
> > Tested on an Intel 82574L Gigabit card.
>
> I'd Cc intel-wired-lan@lists.osuosl.org since this series is about e1000e.
> Is there any reason not to Cc the list?

Hi, get_maintainers said "moderated list" so I thought that I had to
register first to send a message.
I'll post the v3 there too, hoping that a moderator approves it.


--
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

