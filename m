Return-Path: <netdev+bounces-257111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK4FH7lyhGnI2wMAu9opvQ
	(envelope-from <netdev+bounces-257111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:36:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C79F1637
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A3313005590
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119F3A784C;
	Thu,  5 Feb 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XJiuvuGN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC03A1E9F
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287798; cv=none; b=lHMxVA58UIM/5YzusdSvCp40YPrjIcDdkPAcuzf/G0BOYEmXkrj13ZWtI45trY/7ilD4vSnudFx0H0NutUGDTz14HeX41P/r6y6bJmq7tzq7gc/C1SpzwSzceuitnuDCa3vGXjv0vkJNiWbQkDCUjI4VRrz4nB+XT34ZcRynjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287798; c=relaxed/simple;
	bh=y/A4tFVlBW3ZJcy56s5nncs6uStpUsxS6iRVhc8oAqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPGOX4w9YZ8iBPWmISupdylIWrZcH3LTby/yBpAuBwTRn/UoNPBhaotRP57lI1+A3JgKscc25feFt/UO8BJA55nwmbpTeHomequM4aLIXBmeF2K3IlJbsvs1m1JodkcCTigI6vTdN5R2YHWmgSF813AvFC+EmMS5cbYcrVG6+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XJiuvuGN; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f6DCx3CWLzZFm;
	Thu,  5 Feb 2026 11:36:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1770287789;
	bh=nEf6GU3LWdcnwpRWt5dUL719B6VELwFtsTVttnNmWTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJiuvuGN6JORohBjKUfQCn1gN8ShIyyKNh4a0lTXVcQrCQbqsFUxjeo1gD1xAkFNB
	 veUQvPkOEv60PmoPo+FM6oWCHvsdEwYtxTEu4HBnypd+rCuxjr9eXgJ4/OTZs6nSiV
	 PLwRJYrtKilyRsoN2sF1siAIy+1NGwq4lD2gqREs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f6DCv6Jcjzk4g;
	Thu,  5 Feb 2026 11:36:27 +0100 (CET)
Date: Thu, 5 Feb 2026 11:36:26 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Demi Marie Obenour <demiobenour@gmail.com>, 
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 1/5] lsm: Add hook security_unix_find
Message-ID: <20260205.gah7Dimu1tho@digikod.net>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
 <20260119203457.97676-4-gnoack3000@gmail.com>
 <aYMenaSmBkAsFowd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYMenaSmBkAsFowd@google.com>
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.83 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.83)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257111-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,paul-moore.com,canonical.com,maowtm.org,namei.org,hallyn.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:mid,digikod.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24C79F1637
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:25:33AM +0100, Günther Noack wrote:
> Hello!
> 
> 
> John:
> 
> Friendly ping; as Paul said in [1], we would appreciate a look from
> the AppArmor side whether this path-based LSM hook makes sense for
> you.

FYI, we plan to merge this patch series with another one where this new
LSM hook will be used as Günther explained:

> 
> 
> Everyone:
> 
> In [2], we are currently discussing how the UNIX restriction feature
> would work in the bigger scheme in Landlock, and the current plan is
> that long-term we would like to support semantics where a UNIX
> connection attempt is allowed if EITHER:
> 
>  (a) the path is allow-listed in the policy, OR
>  (b) the server side we connect to is part of the same Landlock
>      sandbox ("domain")
> 
> 
> With the currently proposed hook, (a) can be checked in the
> security_unix_find() hook, and (b) can be checked in the
> security_hook_socket_connect() hook.  Unfortunately, it also would
> mean that if the (a) check fails, we would have to store that
> information on the side (struct sock LSM blob?), return 0 from (a) and
> then later use that information in hook (b), so that we can check
> whether maybe the second possible condition is met.
> 
> Q: The passing of information across multiple LSM hooks is slightly
> more complicated than I had hoped; is this an approach that is
> recommended?
> 
> Therefore, in [2], Tingmao is suggesting that we change the
> security_unix_find() hook and pass the "other" struct sock instead of
> the type.

This new approach is much more generic and should please any LSM wishing
to use it.

> 
> There is obviously a balance between hooks that are very generic and
> usable across multiple LSMs and hooks that are convenient to use for
> every LSM.  
> 
> Paul:
> 
> You have previously said that you would like hooks to be generic and
> ideally reflect the arguments of the same function that they are
> called from [3].
> 
> Q: Would it be acceptable to change the hook arguments, if we can then
> avoid passing additional data between hooks through that side-storage?
> You can see Tingmao's proposal for that in [2].  TL;DR: It moves the
> call to security_unix_find() just after the place where the sk
> variable ("other"-side socket) is looked up and then calls the hook
> with the sk as argument instead of with the type.  That way, we can do
> both check (a) and (b) from above in the same hook and do not need to
> store data on the side.  Is that an acceptable trade-off for the LSM
> interface?

I think it's a good interface because it let any LSM check both the
resolved path and the resolved socket (without race condition), which
makes sense and align with most other hooks.

> 
> Thanks,
> —Günther
> 
> [1] https://lore.kernel.org/all/CAHC9VhQZ_J9316Us0squV_f-MjYXPcex34BnJ14vEBxS9Jyjbg@mail.gmail.com/
> [2] https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/
> [3] https://lore.kernel.org/all/CAHC9VhQ234xihpndTs4e5ToNJ3tGCsP7AVtXuz8GajG-_jn3Ow@mail.gmail.com/
> 

