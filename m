Return-Path: <netdev+bounces-271179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJnYF4PAwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:49:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F93195AF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328AC3059F15
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5213F7ABC;
	Tue, 24 Mar 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="vbxFv6Bp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247783A1693
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370514; cv=none; b=SiluVzlW5ABeLjPXcYHGCkkakGgDAVdlvCNXoZVMvk5G+vpc3jEB6GyHEUk/EdV14gmWG/INP0SkwRq0fJd/gKaKTx2QtmzY36bZL1jEYQagrM2veEtSw9dS+ASqgEzbdftBVNODKffqY+tv902m/vS+eESPydwePHOWGLIYkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370514; c=relaxed/simple;
	bh=7MatbDgQaWgyh+g+DD4yZjrx8Tdr7YMJC0zFSYrDllM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvG8GfaGQ43Qkqp8kCwGJ1gNzEPmaB0WPY2ZOq5kSlbqXQUuDfxsqgcZyh+oLZpIhfpgJvlYcbl+yg/i6SR3x5cGnILU47dGQsN9AJ9l0Jz+azltztU9Nk064j+84gnr1d9QTif/gfQNbBZT0ijNkjG5KBQZN49Qu1tOoxiW/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=vbxFv6Bp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b05761bec1so224095ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774370512; x=1774975312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MatbDgQaWgyh+g+DD4yZjrx8Tdr7YMJC0zFSYrDllM=;
        b=vbxFv6BpcqIkm4AeKu4gyPUI1iEFsAyCEl24gZHOyAdza8EdaWF5k2vTgofZ8ULd7U
         SqbNmZmGm/cq7IpxfaILIWCpyFxg6OYMHvNFlwTfZSL3t/w4+m2fdTQmjybYB0lEPGJZ
         025SQy1ldvBeNF3XEuLBqzWR6Q3Ix96oRIurRN5aHrY03Ujnz/f7Kq4hkgbI0SZr2nav
         FKAa+6zZAHE37XN+BBgNeXhsnwhEJNoY8eQD+wWd0stw1it+HNWScHefkkGc+BeXGcv9
         JiLzcQlcits5/rHdm/3u1O9BGE9iDfJbJj8R+iX7beD+Q3czz/kzf7E+4UAN3IBbjezu
         5s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370512; x=1774975312;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MatbDgQaWgyh+g+DD4yZjrx8Tdr7YMJC0zFSYrDllM=;
        b=mjpS2j00Ly1fr+aW4vbLXHqR9r1yI1piFcm2bFQHz1wJFiD0MrbZAQTmu7NsBTJKau
         HbRoRcVDkHeCl23vMrmnYDP1Q8w1icGPAla5eg4JgN8CIZ9WEIWkJO7k8xPuvIGHQBwF
         tWZ/6bD2zxXPeqGuyItdodbrd4p37GJ81QtfP+ADqu+YpvoYtWLJdosCpXepVrWL0803
         Wv2kFzuU1nobIBFFb9lN4eIbQGqeQl30vR7LP6mvRdhgimFDKLScvD684GIhbdYvB7Sl
         gHv1hDUG9xifumVxL2xsQ9I6hnePLvQFOhy6LZ3++oH3hi94zblgR5FgaaJB5ZHE7mH4
         eliA==
X-Forwarded-Encrypted: i=1; AJvYcCUw4amjY43A29bCR1Ok/2FiWmp0U8Ma+8e6zxEQknI21dyNxv3k/BjS9Lmb35FRkPmY/cO4J0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWNJen8V2yMC7q+n1wAiFJQexjOTfPRMLORdgSNWj0A6Hfq7C
	CKb71r+XMfFaZkuZhnyau/wYTNZdWTPV+1p9QpvR7VocrEuupLdFkLdydE6nIkCQiQM=
X-Gm-Gg: ATEYQzy2vXi6E0ka/M6ygprW3opx70EZlXvOINLRahTyWTX2VX0V1Nm+7vSH1cNCLsj
	sDedFxoYEUQ8QrdQxxdSXk1kMCgLAPAMMJ/pAkaQfSY4wrjYnUXPBjNRYy/7Rj96OmLSwH2Kiob
	iG5eLJqGLcnB68tsUQt0ETif4xaLWelCQrpuf6GQ/mg2P2u3IBPJcEUS6SGVpf/pFyg3E2Oibiw
	mCwTnFZyJOUmlUQJJKUWKrDkrPbvKN5WRFoTX6Es6dfueWtTPYmsxXPL/zvoiROVsMi5BQj5/xM
	l/yTNSKOpZo2POJr9paK5vwQZFe0Q+8JjnwAjqztPx2aZskpEy8fHHgilSxvFwVWqJdQaooZ6dE
	6/3Pb1k3LMZdKbvJQDl+rYIsLdKnTBJwYX5kZwvC9QJ1swgHRYHgYUbBGMyvRDkPX/kJu5xkdDI
	Jh7AC2
X-Received: by 2002:a17:902:db0e:b0:2b0:5a4c:726f with SMTP id d9443c01a7336-2b0a4e0f962mr38951665ad.15.1774370512477;
        Tue, 24 Mar 2026 09:41:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm191790655ad.7.2026.03.24.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:41:52 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:41:51 -0700
From: Joe Damato <joe@dama.to>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
Message-ID: <acK+z8Udlg1qyDeu@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Matteo Croce <technoboy85@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
References: <20260320132356.63194-1-teknoraver@meta.com>
 <20260320132356.63194-2-teknoraver@meta.com>
 <1d708196-7b89-431f-bb17-177564196894@gmail.com>
 <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,vger.kernel.org,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: B70F93195AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 03:11:56AM +0100, Matteo Croce wrote:
> Il giorno ven 20 mar 2026 alle ore 22:23 Mohsin Bashir
> <mohsin.bashr@gmail.com> ha scritto:

[...]

> I addressed all the comments and I'll send a v4 soon, thanks!

I was paging through the code last night and I was wondering: have you
considered splitting this patch into multiple smaller patches?

It would probably make it easier for reviewers to read and comment on.

Just my 2 cents since you are sending a v4.

