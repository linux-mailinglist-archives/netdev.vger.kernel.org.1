Return-Path: <netdev+bounces-270022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCQiJwuTvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:33:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A6E2DF7CB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D30301DCCF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CA3DF00D;
	Fri, 20 Mar 2026 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="KSgBB4xj"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE73DE43C;
	Fri, 20 Mar 2026 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031189; cv=none; b=tsxCyfbcxrvIPNzJ2oawSoBqpezsiLkL32wW4nSWEjHupAj0OmLUwlOCvZ9D+AA7BuXd2BmVg7Gtqemy0LWt59hhWs/U5r5jRYmDWIPXfsdIIreNaKF0sM4n+c8gHE/oe+pLXE+NA2BoWdX+9aPOckkrS9hEierJs/WW7VBkS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031189; c=relaxed/simple;
	bh=o5ItQIhCeMX6Yk+7eJ4ESB+JTMW+68A9aocn8H3JSaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cj0RtqmHMO/qQKsTBJ/v/Bo7lG5EGQuqb4/0MfUzVvHqR36uAZ6/lm32aN0tAeRsCoC3k4OLXWFcgtlCPJUJ2rejNM4MQUGcGbYlQypvUVMgAW+/Rlv6pzypwMkMGNkCqYby/oRW98qoKyb/8SMEEa81KAyMYrVNOvk55EXGpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=KSgBB4xj; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fcrcB5MD3z68YL;
	Fri, 20 Mar 2026 19:26:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774031178;
	bh=o5ItQIhCeMX6Yk+7eJ4ESB+JTMW+68A9aocn8H3JSaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KSgBB4xjI45yHwv14LfECFzElIA1YiwlBSeOMp53jNJSLBfnOXfuKk0SAWwe+uGSo
	 /BDedZP5vaSlddB4CLbkVt2bA7opfc/xKZPtrtGFVFzbhJ4P1Kz4K5T/2jN011kQPU
	 4sQQ5V+fm9DrlKrBbaWVOYI1+1eWRd7d84puCw/MURMaMLJd3C/IYCTESfVHJyN0/V
	 PGZay0dvgqEaW4CZhYIzF9515taUI4/wtSQU2JH+JNU/KYgk0Dr1XK0oaA51b9xw5J
	 K92QeTgaM69mgbUbbJl7TFxMykEWTvW11AK1+2TdqtNN9BMEBLjDk5I8vH7D0OM4xo
	 4Y/TvVQxn7g/w==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4fcrcB4dYYz4xS8;
	Fri, 20 Mar 2026 19:26:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4fcrc96SLXz8sbl;
	Fri, 20 Mar 2026 19:26:17 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 35E52635BD;
	Fri, 20 Mar 2026 19:26:16 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e2b7f273-905f-40b0-95bf-ac6f9beb888b@leemhuis.info>
Date: Fri, 20 Mar 2026 19:26:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bluetooth regression fix likely to miss -rc5
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: kuba@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bluetooth@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260319190455.135302-1-luiz.dentz@gmail.com>
 <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info>
 <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177403117699.3567880.6442946421288956324@mxe9fb.netcup.net>
X-NC-CID: IOLwiIw8DiIfpdvW7TEHhfxmZo2gVPkkujN5xX25ZardnN99F40=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:dkim,leemhuis.info:email,leemhuis.info:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F3A6E2DF7CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 19:02, Luiz Augusto von Dentz wrote:
> On Fri, Mar 20, 2026 at 12:47 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 3/20/26 01:00, patchwork-bot+netdevbpf@kernel.org wrote:
>
>> The quoted bluetooth pull to net afaics came a tiny bit too late for
>> this week's net PR to mainline. I assume there won't be another this
>> week, as that would be unusual from a look at the history (and well, if
>> I'm wrong I'm happy!). That is kind of unfortunate, as those bluetooth
>> changes contained a fix[1] for a regression that at least three people
>> reported (and I know of at least one other person that was affected)[2].
>> A regression that is known for nearly a month now and thus already took
>> way longer than the "fix within a week, preferably before the next rc."
>> rule of thumb Linus recently mentioned[3].
> 
> Afaik, it was tagged as regression on March 1st afaik, according to
> [2];

Well, the first report was 2026-02-22
https://bugzilla.kernel.org/show_bug.cgi?id=221120

I don't blame you for missing that, as it took some time to reach you
due to the know deficits of our bugzilla setup (and looking back I could
and should have forwarded it faster once I had noticed it) -- which is
another reason to change something there, but that is a different topic
(see the recent discussion on the ksummit list).

> traces were only provided on March 15th, so yeah it was fixed
> within a week once the necessary traces were supplied.

Sure, and I can fully understand that you need traces to fix this and
that not reverting the culprit helps motivating someone to provide them.
But OTOH from Linus statement in [3] it sounds like he would have
preferred to see this fixed faster through a revert.

I guess it's not too much of the problem that it took a bit longer from
the report to a fix. But thx to your efforts (many thx for that) we now
have a fix, so I'd say: let's mainline it quickly to (a) get it tested
and (b) prevent more people from running into this, as then they might
bisect for nothing.

Ciao, Thorsten

