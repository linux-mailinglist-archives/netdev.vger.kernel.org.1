Return-Path: <netdev+bounces-266818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7tofAZoPsmkvIQAAu9opvQ
	(envelope-from <netdev+bounces-266818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:58:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2826BCCD
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FBA6301BEF1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7FE336EC6;
	Thu, 12 Mar 2026 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg0RHufk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D72FF641
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277079; cv=none; b=TgxKB55YkkIDUKeQzWA96dydKEOJOa25BK5GGcxRk6CK8EUWiZ8VGPC7aiX0DRdsJ6/os8sr0LylGkRIAaMNhwrx/QjzEFgVGB1Dz8y7y31/I59tJkKDHxKQk2mckpG09ooxe/auHvSKnUrl+wPBLNveC75FyariCytKhcZ13bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277079; c=relaxed/simple;
	bh=FlhhvoPyWIxJK5TvVsFz5MgRPM14lagVxibvQmy0HZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyCIxaL4izLkHFAvh6TFl0RMCmtqW2clGY+3t64XjuXaeDNu5638nadIx6jUVcC68MjX86QIaXFyG1xBOpM9RNUy1eYozRXNv0mneB9S4SlZIXRF8AFARI6nSW4MIjG6/G6IAkvLf2hSyI5rQ1OFRwt4R+YPZi3mIl3/BhyScdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg0RHufk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab077e3f32so2158105ad.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773277077; x=1773881877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tovsez19mbX2YCXeDVNyLM/nSxorc50zGgAiX5yI75A=;
        b=Hg0RHufkvsqfQEArInI/UrBOyHdCAkzXoK7cgSPVdlEMHcTkFX6iiSjqJyqTqOcKTZ
         Xx/CsaC85BpfFYOOxgAtaIF6800T3G3CnPP/Y+NGeufJ82hOeb/G9qgjemE4hbIj9kW+
         kfaXSqlRKuEOwYLQJx+e7C3gaS264BoQI6/B4YwyKHua3Mcpxkev147fAO01fJ+YnpIx
         QVLiFtWXtXnigICzEnXU4YdTh26DvscXzSlvds02cpwitSpKS/rgIcznVaZ7J1UnfPMF
         D29R+QCB8ObL7NScixzxaoZOe3Fr2i98MYUY9z78btdR0Tn7WP/kGDYHjHCpZuAkTh2m
         uCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773277077; x=1773881877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tovsez19mbX2YCXeDVNyLM/nSxorc50zGgAiX5yI75A=;
        b=Pj+fIgSZ38U9JSvQldMY8WMUp2XRSpdygqiTmPKJbHkqPgLOEZbCY94J1woJZgeeB3
         VfbXART5HLpDNL+fLwv9hs298uohQU725rHDGe7MjUzHe8c8fd3scdZObPfrVmRVRFRN
         unhHq/DVwmeGtkS43/I8cJCv3hoETBU5JxTM4pT1S2l0Cq7dRfIfrInsfMPuvtVL5R7d
         ioOCg5R/A8KZIr+V1Nqn8m0ML3jVsWmYqXGOprLdbkPb8adsmOSWsRmdyEC+LR+kI+si
         g1TMYiAY6Djhb7DP03LEovKRF4Y9uecgWNRMEcH09hpB0fGAKTumtF/vUVNvazO8TbGz
         8nmA==
X-Forwarded-Encrypted: i=1; AJvYcCWuXkJBNfxbBqfpjjwxLtQjV2x8lpnP1V0OoJ6RP0atjLXpiSpC9Pt3EebzdO5tZZ8YQlk9oDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/YeTQGQCEg4/7YIiPOx1Kf685VqsBtZLMqFmuzR3gdcQ9ZdQ
	3XZI/e8rc38IzALijn9kgOxvyLWVTVqgZykGjQBY9BXFvArS9yPNTFzd
X-Gm-Gg: ATEYQzw/kKOcVrloMox8WHZ8aq8D6BO3g6Y/GbXWamEtaZakLLwLN7ceNXhhWpLU66a
	NSlrOiNzJHa8UhkswrR85RG0GpjnOMxnGxTZ/rsS4OWAEuOiLwU06zF7txFJCRCoS3ElZM3D+NX
	DM3skLAK9ebqqZrjKqzzQNc9zLn74iSmvsuI7ds9ZSt2Z++2LSzwijsXom96Bwj/q8Hh/JgFRUk
	PPdqp/fEV/tlQUIHaMbHYcFH7tNImQnhJovWwBen0FYzxruKq/3blKdca0SE/89xDp+eVj684KR
	duZPcxLwmQ+5L/gYWEjLvRZsLf9aYaAYhuAvKzh9hzqQyx/4DPXPYuUVQ9Aw26B7c/xynhwCfHO
	lYJANTX3l5NoOloEjKZngrKJjF9TDzHz63g7uwIVfRdAzXVV/YFmQtVSEUs+CV7+2GaaXHrWRkm
	NACAmj4cUHW9O3wg1JsZta+E6cG+E=
X-Received: by 2002:a17:902:dad1:b0:2ae:4d44:c64d with SMTP id d9443c01a7336-2aeae8ca72bmr44549965ad.42.1773277077366;
        Wed, 11 Mar 2026 17:57:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae2466d3sm38224245ad.22.2026.03.11.17.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:57:56 -0700 (PDT)
Date: Thu, 12 Mar 2026 00:57:50 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ynl: ethtool: remove duplicated unspec entry
Message-ID: <abIPjrsMuOTruLQh@fedora>
References: <20260311-b4-drop_dup_unspec-v1-1-e0dfa47b5981@gmail.com>
 <20260311172559.7d7713f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311172559.7d7713f9@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64F2826BCCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 05:25:59PM -0700, Jakub Kicinski wrote:
> On Wed, 11 Mar 2026 11:22:29 +0800 Hangbin Liu wrote:
> > There is a duplicated unspec entry. Remove it.
> > 
> > Fixes: 0187e602c03c ("ynl: add missing pieces to ethtool spec to better match uapi header")
> 
> Does it break some user space that assumes no duplicates?

No

> Otherwise I think we can merge it via net-next. (no need to repost)

Sure, OK for me.

Thanks
Hangbin

