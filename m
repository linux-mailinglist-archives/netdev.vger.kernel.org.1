Return-Path: <netdev+bounces-281938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFkJOT7M8GkKYwEAu9opvQ
	(envelope-from <netdev+bounces-281938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:03:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB344877F3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40026303FF1D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874743D50E;
	Tue, 28 Apr 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmvabrfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948737F8B2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388362; cv=none; b=kUpnlo7rvBA33dqJwzLRtGXD+3rlZeiwIdrKpgMZc8AruISKUDlIeWpG826MTgu6vDGh0K6DaYZn29S6iWC3s3jnBpMB7yX6xZDzmQ11+iZvoW4o5YiENo1bumko1kdVn/BjMsTIlZMZLOmxNoKAis58yeUrTyzw85ZptkzErWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388362; c=relaxed/simple;
	bh=UV21fsPH20R53rAOsbw+qETeN4GT0nuFihwLnir8SOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItToxVZ831brz/0k7Lx+eRijaJq+6an/GRfUddmRyMdU0EcbUjHc6ZXvo1zTxZQ2zMjm7VVxeRqLYjBCHehVUaLU+IeL4xkTmjeFHyrFVAtJ8IbNQqXpYE6RFEO015p8ulG8vzsGlc8XTYetEGSPYPNhT/rTcTQe7NqYANry3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jmvabrfy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48896199cbaso113794975e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388359; x=1777993159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjifj32lQV5b+bLCm2NY5OLnoNmHIUz/l7KlvEd3nhA=;
        b=JmvabrfydeY370EwDnYVlGcOJ6OjYbIAThlMZsEp5EexFWcP5LMVdgrVyryGOTGq5C
         9gdq1nWLyyx+2rVOWAPnqo0467TLz/AglqLpMmQYHvro6Pn0XE8kD07ptjgc1R9uEh3C
         EK2iiKj/js1jylung9L9a91StRKqgWT1dCU38JAvDR8+qGDN2TF3qFYLu2sB5DAEQ9bs
         IUk6leB4vG4Dn+pGJdDTN/S9KOfYpHp34dluDOo6hl+CH7f6XvUTPnYrHwM0EQ2OvLo1
         KyAjxl8XwYRfEI7WN3I22DDfH4Xa7IC6dFKNSzYzYxgN8PofJmOVykqA1PsONe2Ex2Ia
         wDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388359; x=1777993159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjifj32lQV5b+bLCm2NY5OLnoNmHIUz/l7KlvEd3nhA=;
        b=BTpNY6RsIJHJ56nWmmWeadsIPVjjR5s9aRuVEv2EcSwS7Rwwe0xVtbtcq99inX89XM
         OtOZxKQKjVhdevLtzZX75ZXHBs1B1f0wpIEMoHCKqBN6o9THQolTiW4qlVN+mXSHq/ga
         A+bASz4DfWjl7+dlPyJPYh0U4Se2ZYok+mWgNHj38WoZsaVHt2FUQANKpfa0lMI5t5cg
         nr6CVAaE4sUX0tHnLC88j3lS90KFGjNLz5Q0Ly9o3JExemu9rYZ5bMnAzyviC41D0//Z
         gDHY6AYmLh+SQneHE2RiCJofVgs1edMI+fMAmkjzA646u7pBpnw5IkRLWsc2nzS6Is9a
         KabA==
X-Forwarded-Encrypted: i=1; AFNElJ9q/GmX5TlJjTMhFTOPEqEwUeZOywfE1B4ck8JTnBw47Jgx4yUslGEfwW8aFOly/DemVpto+8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+8Ipewr823jfykpRlwjnsE8J/afDLh7yohYvaw2xCKomOv6/
	lxAjCnevt2jVabsuLC1nbmjiZsUyqGcUl7vULm7MAMkax9XBgmSN5UD/
X-Gm-Gg: AeBDieu7mQZUfv/WcCIVYfGw9sdjoNZRfnPW9buoeiUkj/PhMO9QWwqaYSJsUCQE7XS
	A8DbcgSUtGCwXIByUyAHdino2kZiximv7R/C8iasAGx1J8UWi3oIsTSMCos7BSogASTdXOiri/9
	iOkislWUSs/1omkSpqlvlpYA06dPKSKjsnszeri7yeyz4pNGXtpE6Rm5Ziou3vkYRoZHR2Ig2Qp
	TjjOPmW+mmiCp/ixhRs1vXKmn2lw0qbER8ex8uF+IV9Dl39pP4S7q8kxqgkrOQtzMaLfsWuH4N2
	bDXqlRngF/xws2hZsPriNr1mjXFB8+uK3y0dmKYdc+xjwB5g2GUkGdRgOHR+R6GtWIunQchrp9+
	9fA33N9ECD5Mxe7FQzva6V/hUA1ScxOqR+Q3G9fZ/eD0i2+GVmHQIU7Sjd5x8oDCIw+dgUwbJaY
	ln688JvrZ5V1d8kxcA3UE+35ZYQaM7Aw==
X-Received: by 2002:a05:600c:a315:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48a77adc73dmr39426575e9.8.1777388358658;
        Tue, 28 Apr 2026 07:59:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775ea85bsm31476575e9.6.2026.04.28.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:59:17 -0700 (PDT)
Date: Tue, 28 Apr 2026 17:59:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net/intel: Replace manual array size
 calculation with ARRAY_SIZE
Message-ID: <afDLQUjaQ4Zs_9D_@stanley.mountain>
References: <CGME20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931@eucas1p1.samsung.com>
 <20260428103653.3539239-1-j.raczynski@samsung.com>
 <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
X-Rspamd-Queue-Id: 6BB344877F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

On Tue, Apr 28, 2026 at 04:06:48PM +0200, Przemek Kitszel wrote:
> On 4/28/26 12:36, Jakub Raczynski wrote:
> > There are still places in the code where manual calculation of array size
> > exist, but it is good to enforce usage of single macro through the whole
> > code as it makes code bit more readable.
> > While at it, beautify condition surrounding it by reversing check and remove
> > unnecessary casting.
> > 
> > Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> > Reviewed-by: Dan Carpenter <error27@gmail.com>
> 
> thank you,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> (next time use "iwl-next" in the title, no need to repost just for that)
> 

These prefixes are a headache.  It seems like no big deal if you only
work on one subsystem, but if you're dealing with tree wide code then
we're dealing with 418 trees.

These days I have a script for net and net-next because they are a
high volume list and the original prefix subsystem.  But otherwise
it just automatically puts [PATCH next] if it's in linux-next or
[PATCH] if it's in Linus's tree.

These are all automatic on my end, right?  So it would be totally
possible to automate in the recieving side instead.

Although in this case, my script would net-next in the subject because
I had no idea that Intel was managing their own ethernet drivers...  It
used to be that wireless had their own tree and everything else went
through net.  So it's just seems like a in impossible task to keep track
of it all even if you are not a newbie.  :/

regards,
dan carpenter


