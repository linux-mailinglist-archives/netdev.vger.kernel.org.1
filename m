Return-Path: <netdev+bounces-266623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIb3CuRWsWmGtwIAu9opvQ
	(envelope-from <netdev+bounces-266623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:49:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B3263197
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9517C300DDEC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BED3CFF6A;
	Wed, 11 Mar 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET6O/QAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F9285CA2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229792; cv=none; b=aPPfYIhIRDFNat6vyyb//JsZeE9VqvFbaFq+X/VX20NLRLaTwucN5GEtaVBdHa4F90dJQ3IGUuzIXVxJvjYcJ3qCUwaqEd7t11Rl10Z9I5cdjuA0oZkNF1DO9ByQwd3qQduYmPmHfHn5DPodWsEBtNFcIE4nRFbEQyf67hWCEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229792; c=relaxed/simple;
	bh=kqXVxGne/MWyib/ntpXgb3tQGa6smsxb82pVRytJqLA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Js7PUOBHU1DIUqHBDX+BTuSSDh2B8/Z5i4Y4u/CuWEchkBvWMhn5LDxgoqvmH7W8lB1Y0ui9T8uX5EOIyKtKrvSSSZVGJyoQt0g0fndzl5bzYjKE8E7f9wVI/JFF9NDxGweDoDgNREAOmNyF4RxPpNQOXi+GhlEPOHdmO1rIvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET6O/QAb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso9879298f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773229790; x=1773834590; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gtZWJKK71/PDQsHfoE3LMJRE6oUsBVmqxC597OJfIU=;
        b=ET6O/QAbDRbZxAf6vYWT/KmfSU0kQ6/f8dhdtZi9tXJU/XCCJqkM9iuA8z/pY/01mQ
         pwJ13qH1IvNNhexgd8cmapOc7ZCIH3EaHoUf5aKzZVRLcl3uN4K4yrtNNNP5BGMNezNw
         IfKFo4h2H7/MslhCb2oOLmToAg514m6mY9AUaVWMqdygE5hvklSuVEdGb7/qO4EM93NL
         3whpakSDkNOidDapdaISrzm5Z1v4iA1k4KCZjkKZ4M/pGjxPhfISadnJRBEIM2I/bJ5r
         B79trOhuYsNXK1edw5vSAUu5AxJYrfScdiuPD8RRBIs/3/D2fsA2DJOHxdDO7Mj80Oz8
         yQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229790; x=1773834590;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3gtZWJKK71/PDQsHfoE3LMJRE6oUsBVmqxC597OJfIU=;
        b=Gej+d0UfFc/sU3M1DfXAi4erqoETOfGsOtMri3Rdk8dyQ5K40Y61pR3+kgb7QYu6SA
         FrGwA18bS1P98LLJxuW0XTp70lqHbFE+WS+G1NRJO89zuvVAMneQBmRM3ShzKuIdFlJ6
         FTINs4zKkBGVM45t5HUV2JhdXbviil8toIpAUm7AH5x1CXiEkX+4u5OgRSBLSol2JfBf
         FH7mwqO8oQlM8DrtmNeUnu+ayjjsDCfNxV8OionTqkfQw2TULF9XAoVvy515/zwiupWP
         SuT2pTkFoRkbq0m2G6+yPtrkjPyvgraAu2PwdHOt8LkzPHil0TdzjhBakAofZi2790VU
         z5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWxx++Vgg1F32r45+YLvW1z8C9o/drQWz1HB+4HUtaSiaU0A8X8Rs/Rz1+F5LjdFTDph2luDl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhoO6IBiNZ2CwqpeVMTKo03tMK5dCarbErKsJ0Gsm3fXka4VP
	T1Quu/B0zdHPuHQ/8cN+/7uqZLkBrBxfGYVJ6dKaudV8g56cwZswehN4
X-Gm-Gg: ATEYQzy7yL/iGiLSDvToiZkmOjyQ5SFztKi7337h+4ie2r2RKrzQl5ff/CFLq2oe3It
	2br0d+59RcwO2FJUI1SLfZ/UPYVb2LSjYHAuTkQFTXHQxiU+RNNamZ3M/dZDRYDkuw2Aq0aCu6G
	jhaSwTtMZ1zvg986iTseHXW0kZJxRywRizwWMxtCtiai1xtJzLcnH69OIoYzjSKGoyqOw69m+z3
	DP8R6iNXSQNSa/+yTIyeobkiwmQm0//sGZ4ZfPkYBQZuIS67zZsSBF4xYP6dzvKqlOe9OUkJ7xM
	YCC/Wx5ccP8pD5gWvu4cia2VAt7mt405jx6+E5RjXmXco/WUXPflGQIL02n5zlxl8aywAVV264e
	+eYlV78FkpkVfuguo75GeI0WLF91bTo2Pk6KzuzrYEHn5rGttZ3v9oTyb64Y+zb7CHtYNHvJQUc
	Fir584k+oPsZOGZERWFz2PLRYNfw==
X-Received: by 2002:a05:6000:381:b0:439:b628:90e0 with SMTP id ffacd0b85a97d-439f822a51emr4501917f8f.28.1773229789792;
        Wed, 11 Mar 2026 04:49:49 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818d5eesm7181960f8f.1.2026.03.11.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:49:49 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  shuah@kernel.org,  sdf@fomichev.me,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] tools: ynl: policy query support
In-Reply-To: <177319682153.3014711.5472638473199917370.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 11:30:59 +0000
Message-ID: <m2jyviob64.fsf@gmail.com>
References: <20260310005337.3594225-1-kuba@kernel.org>
	<177319682153.3014711.5472638473199917370.git-patchwork-notify@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 813B3263197
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266623-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

patchwork-bot+netdevbpf@kernel.org writes:

> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Mon,  9 Mar 2026 17:53:32 -0700 you wrote:
>> Improve the Netlink policy support in YNL. This series grew out of
>> improvements to policy checking, when writing selftests I realized
>> that instead of doing all the policy parsing in the test we're
>> better off making it part of YNL itself.
>> 
>> Patch 1 adds pad handling, apparently we never hit pad with commonly
>> used families. nlctrl policy dumps use pad more frequently.
>> Patch 2 is a trivial refactor.
>> Patch 3 pays off some technical debt in terms of documentation.
>> The YnlFamily class is growing in size and it's quite hard to
>> find its members. So document it a little bit.
>> Patch 4 is the main dish, the implementation of get_policy(op)
>> in YnlFamily.
>> Patch 5 plugs the new functionality into the CLI.

I was mid review, looking at a couple of issues:

- It would be good to fail more gracefully for netlink-raw families
- I get "RecursionError: maximum recursion depth exceeded" for nl80211

Happy to address these in a followup.

Cheers,
Donald.

