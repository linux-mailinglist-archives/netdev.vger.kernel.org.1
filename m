Return-Path: <netdev+bounces-287343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEwbIFuyA2qy9AEAu9opvQ
	(envelope-from <netdev+bounces-287343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:06:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206252B2D3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1EB03086A11
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E61137B02B;
	Tue, 12 May 2026 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjhTpofi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE60342524
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627159; cv=pass; b=LSAhXUDQHNus3EUAUUvHSG7QF/UDt8lBw9x/YpeWgZqTPgUxRN1/JTxEy1en1EsCub+FV4UbyHaIMpVybPX1xlGS/8BpvAJKRQfFXSrUTvE53PJT1mJAAFyUAnmqI/N/JPAUC/SaEMGOXpYtM5VYw/dt5AVLAcn+bckbGak/3zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627159; c=relaxed/simple;
	bh=RhzImYsmOKKHk6qrADsWWn7xKpqZhsUfQxb019Di648=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/tiWLnk1aAwASrJqetedpmYL5U/9Gq8/prK3F+AqdmIe+X/s7jlxHgBErdeptewVxTRZVO7z8Cs4jR2fLTr2lMMijtWL+uExWLk3wknYU83EUnCNq/4zAFEzs5ztjApM2WmzyGgG31TdnbA1M7CaM6iikD/hdDb/k3jLj9HZfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjhTpofi; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64d5a7926cfso5727938d50.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 16:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778627157; cv=none;
        d=google.com; s=arc-20240605;
        b=L8BCkgzm7SkmE/U478cdSYYTw3Sz2lO4osxThjvxAFHM3SloUif8zCDtbU37HQN6au
         9ZFDOSUw65lbh6r5gN/nk9MeXW5k9GisxN13Svhpf29kN47m10LSHj/XKYIfssOW+z2M
         HROWVwqH0JBeYkou9mosQCrwAvVCewPfG6UWGRoBgBdTW6IKhH8SV7gq0wzluVJc3ANf
         5a5au9MjBL1X6xv4tc0Ft0PuzaCQQDXC61hQVJTiI1vUspU0FUNOB5eSle/KjW+42Tlb
         h5M2OkumMihD90tNyed0fz+J965o5QehcbuKeTPPDJoIQcfcXWNUQYUTkTdmIJvHziMF
         n22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W1cX5/tujz2IvokGuYBkLn/0gcvAXJBHFlLEw+M7GKk=;
        fh=Tkop5rzECCdLpgblxz97MQel2qDU5RX7IruSaLvkvTw=;
        b=RL/y0blh0GChAaVtDKlanP3xcwtImxnBRUxUOhqhvd6vu4sX9vSC56IQH41HxP1Zgg
         0WSNJjmIanWUm4H9eFF1MTqbAnAFRQHYC31TJdirV+xa+E+lnsouMzaaQwOo3FF/OK+j
         032WE1JnHIxT+MKuFd1h/rCAJnK7GQdMIaKBE5absy4oqJxNkeXG3rN4jZ56C3gWraba
         gTCVEZpnJYrkAxT2NQniPc1uDLTqS65AoxyWscVkPymNLDbza3ryCXg9PDIRzJGqAJLp
         R9I6vPjxSke4rLh0tEsNWbnJO0F7MRU8muKzhOxLTM/Qb0vmVU512fQa4/Go/wAzWsd/
         VF9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778627157; x=1779231957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1cX5/tujz2IvokGuYBkLn/0gcvAXJBHFlLEw+M7GKk=;
        b=DjhTpofixFHRFuMnAdAeX1Tt+FOGGdbmhSShAAdLjnkUw8QEe4Nrk86l9SLfDI3ZxY
         Q8p2u1IZ3ESFKzQ8d/oGyiVBUNocDbCoHVm0DqRbDIZmUFSx9mkiNSlSWow5K31FBHw7
         ByhzZepgYFWCL2Ge3mDYHKdKQFouOhEwPhjYrvfI5U7y4v3LX2qP3D+GCRnAjmerMrco
         XL24KugvqqknpwuD//o7cy58rhgRVuJ1jMOy/PFsG7rsvKkiOqkhEN7WvLuc8vzvSwXC
         obwVY3jYdzM6pjgjL5ygzCWL+3r9+0wRqOeUiNPbPZZCnjItSrh7IrX3Ax+Qg7gIrvvF
         w8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627157; x=1779231957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1cX5/tujz2IvokGuYBkLn/0gcvAXJBHFlLEw+M7GKk=;
        b=cMyzKtBF5/3sqS/wRV9CSvDAamNsiHO3N6Ml5zbiKxtIuiHVmgTECGg1LNEWQuk5Nn
         X2MObxq4Kw72TSeVtkomwR8fkY51xCsUXYnyC6FenFdX6QBpLlaY0kUfwUcODYmpcQ1k
         JK7x8UwNS+uBrkZ1LzOdCxmvEZ0+A3IuUKS8nYVvt5H3IBJZc5vwn5NuY1wXo0uzp/Qz
         Odu51cdcJ7tZF4LUtqbXQqo+73DzlJAMXVzflhFZtnsxLcJXwFNLJ6RpD0fVWmFrmrw8
         0vMeaKKG/3BKXaldWR4b+o7gOobS6fSQCUEHrBHfsDQiRmstYlrEDSXHf70JjFbO8hGk
         AQVA==
X-Forwarded-Encrypted: i=1; AFNElJ8EUzyzdy3QdDN5Wtt0xJPEu+kh8StWvOquRHkYYfckJyB9RtB9fZawiGdximkx0E3Xuhu3Z08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfChrXSUVa51BDKgKS5GFTTXORiixzsy38QGTk1sv8Mfo//J9p
	GiDoZIAHASk3gpYPoKq/xd/kx9tfTcaB+bvmd4MjmZWMXBMQWdcsEYDhSa/RLVZ7/ss8+hYsIa8
	wOdxQSXXH8bsubLU6jaCx2SALCLKUVxLy9ENOzHk=
X-Gm-Gg: Acq92OGH/KbmjCwlaKRUF/HlC42RLjwaKL0fE738fYUNPhF3zDcck9Uarx6VLW4X8Ni
	JJz+jsLFRvlwIqGYH6p1w2Gj6wTNIu2PLozSq+2HLTdhDbVOeqW075qvBJ1WF+nfuTdiKX2lS0J
	Gz7fokMgJKLjO04PkCYs9MuRO/be4jGbzvzE31nS4B7kiYYNYDivfbtN8QTI1zUEl5oN7Q/lXAi
	1k0O/stG2B7pFCPNfBGLQACce57h9q1fyVKdai10AmI+lFVu63zVOJyQ8yXZkX1yWrPiTS8gviV
	p5u2UORympCbfCOQvGBUewySSfddbMBoygZx
X-Received: by 2002:a05:690e:130b:b0:652:f6aa:f73c with SMTP id
 956f58d0204a3-65df830c830mr342312d50.62.1778627157080; Tue, 12 May 2026
 16:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778614451.git.michael.bommarito@gmail.com> <agOrCj3YoMAxsxYf@chamomile>
In-Reply-To: <agOrCj3YoMAxsxYf@chamomile>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 12 May 2026 19:05:45 -0400
X-Gm-Features: AVHnY4LLHxol5Z8Cuh4v98Ejrlk8HjLaj8LKu4bDeQhq9QSTqxdejNfNpCA0ivk
Message-ID: <CAJJ9bXxFHsLDfaEfDTMJajrVJ1GyGUCrNpYoRSdOnVm2AxocHA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] ipv4: harden against ihl < 5 IP_HDRINCL packets
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Maciej Zenczykowski <maze@google.com>, Kees Cook <kees@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1206252B2D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287343-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,netfilter.org:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 6:34=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
> There are possibly more ways to mangle ihl in the kernel in 2026, not
> only NFQUEUE and nft_payload.

Yes, and there's a peer issue  in BEET IHL wrap I fixed in 017ccd82092e too=
.

In addition to a few other nft_* paths, my understanding is that tc,
NFQUEUE in userspace, eBPF, OVS, etc. will all be a problem unless we
guard in the IP stack itself.  But then if there are legitimate uses
of this path, we might cause regressions for people with complex rule
sets.  That's why Herbert suggested we should bring the issue here to
get feedback from the list broadly.

> Your patches LGTM, are you suggesting more patches?

I think the answer is yes either way, but either A) a smaller patch
set in IP that I can handle if we go that route or B) distributed
across people who know each of their systems better if we handle in
each subsystem.

Thanks,
Mike Bommarito

