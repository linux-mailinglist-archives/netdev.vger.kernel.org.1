Return-Path: <netdev+bounces-270804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK4AImrJwWlUWgQAu9opvQ
	(envelope-from <netdev+bounces-270804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:14:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF62FECF3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6255302DF4A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34313815F5;
	Mon, 23 Mar 2026 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zz6c8Y8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2729BDBB
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307687; cv=none; b=BsIPsNiEqvHLNfBEBcCsq1SAcTQJrn6UYIe5IwLFLhOHSSypFGab8qfsduvpVuLP7GxziDkwBynXUWi2+K367lUHiHBDGkenIh0wRStm1QK6RHHOZwmXSKkT5iqdEqB42+o7Y6aUbcYe7+xD9LP85ESbGZslA/NegBX0Jk8dii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307687; c=relaxed/simple;
	bh=psUtjzbVDqbRSHLGIFO49jP1GHoaJM92TMwHfn0BiPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gveLlwpHe5l6hp1y7YYK7xPdJvTA9lEy7D6JHxZJHBUAmLYT5mFx3IBV9fSvuGS5FABynJu3QALLmQJwxoZXIOFWbaBpr/s0wiaNwVXZOWuaZ9Lb3mCPBpiXkNb0udkK6SJBdlgNDw8tCRtZS0O0S0W5e3UrFJIvFyLDUGD+CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=zz6c8Y8z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab39b111b9so14795005ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774307686; x=1774912486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMg3lNbBP8Ca7xUJowkSGVPVJMZjC1tfGW4sMdbdTf0=;
        b=zz6c8Y8zwUQ4dHdrg48xxeerVdMNyfpXfX/4nwOeKcQJIS9RIg7oQVDMnzsmrpenMP
         XuOLAB0fkSDa6aVEnsvhG01qrWLQPJbRJhLOvYq0S2TlRwvC6dyxwu08GctqDJChWPAs
         8f0mB1kKYCOArxw2TABKOiezibxjpOUu5qbO8++ac5udejt5ia9npQIXQVY/hkVUL3OX
         XFOqNelGLyEKzmn4yUYq9fzjUuycRTES80DN6qko6/MP7faJf6LJJ3huU9q1ICpYykLv
         nt/ZcJFJ4F/lc8xdhS/Ja1hJroxvGudYym6yW7X4CrSGUYZAgnZxnl3NlDaLjwGb24mg
         D9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774307686; x=1774912486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oMg3lNbBP8Ca7xUJowkSGVPVJMZjC1tfGW4sMdbdTf0=;
        b=kNqnCY6H0EXGeJmldmOShgFJfvNUvKaFlpRlo7BXy/Jhd1cQ1RIqdQ1cTSgOnzjqpL
         nQzinmI/VQIRMH7bQOQ//5l4nvIWX92qWalyLknO2OKLQ5luGplfQOzQUJ0zqGWtsaJq
         yS4qd2GFFHfMNSTBmjB5Zxej8rDzoAKKSd5gposBQjEJFZmdNBytosGRVKOJLCxCFyX/
         SuP7/4mJDpj/hVKFv8b3Xb20I7J3jVnRD7lttMb/U8yHId0jSRslFgnVWeq3LMk3KT22
         s5aIxp6wvioDLWrwFPDViiXVgNn2jLb3WUOo4+Cc83/NFAgKLLYW1CffG4aaDDZbzp2m
         ZUyw==
X-Forwarded-Encrypted: i=1; AJvYcCVu3Z2ZNiiW1dgoMc+SNTWgt6coOFJk6ngNaky6YXXiuXZe7jI99wtfwwLzyXPMsE0Y9Wgcjyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnJaUAsPN5wyxjoQV2rPm5N5ztzfTJ7Urnll2xrA/0M/ZirEI
	PMAUer4NYpOOwLzLTQOuh9SHfF5BYnvEKLyLtbsZ427tJ1gJoRZcFc4rfRONfnTcxO0kfa1vN39
	sqD8w7cM=
X-Gm-Gg: ATEYQzxjc7SEmoOYFrFWWFeqiCFFawSIrz+rIBu0PRf2m3gfNA5GFfLfLI1J5OVeV8K
	cRxO99quk2tSUeM2CCEM92pHTB3eeZk29rODWkUyJqHBVR9Xh8MmgeuzlbbhQWguNqXSR5LeOpt
	auj/D+hnEgEKVeHt8A2CVQPNNMnQxJB1mX/8AoKUv2cYKYNtfDWg5HJM24Eo/4V94dVKUhXm7SW
	j7jKm+zGODdMNKR3KWL2CDw6D2NhBmAExpbqYQP3RNNPrAdTupVls2wu/YR+yZZDYWH8MnsyNGq
	c5mqNeCCCxilYWDlYappBSc2W09FVO/D2Xr2Ui1DtM8oFpHKHzwWBK+UayiYaMFGKu007p2DJMz
	JWOIpGiuPuzNwJXYkifUF4skOdJ1YaDXW0BXBk7nnFrA5c/JFdkx+Wt81pvswqLXXDB50D6ZxtC
	oac/gvQ6HSJtZHaQ1J3fClXeYxQ2igDU1Uf8U=
X-Received: by 2002:a17:902:d4d2:b0:2b0:7a27:bb2b with SMTP id d9443c01a7336-2b0827a9076mr134541315ad.34.1774307685654;
        Mon, 23 Mar 2026 16:14:45 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516aa6sm165708025ad.9.2026.03.23.16.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:14:45 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:14:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Liu <will@willsroot.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, victor@mojatatu.com,
 xmei5@asu.edu, pctammela@mojatatu.com, savy@syst3mfailure.io,
 kuniyu@google.com, toke@toke.dk, willemdebruijnkernel@gmail.com
Subject: Re: [PATCH net v2 5/6] net/sched: fix packet loop on netem when
 duplicate is on
Message-ID: <20260323161431.4d6915eb@phoenix.local>
In-Reply-To: <EsDe28RrNQr1KI6OSdjyA2kOYQnj2CqzSDd3lga9Epk_wzttTU6-pIzhVrZSFdqZqWZvIU_Z83b05OwNrKMhUlyrSlNoV3YaKYY1azzHph0=@willsroot.io>
References: <20260316211052.332383-1-jhs@mojatatu.com>
	<20260316211052.332383-6-jhs@mojatatu.com>
	<20260316175705.2ef5004e@stephen-xps.local>
	<CAM0EoMmso3BeWwBd_6tWPhPqTiZ=4ZywNuMeWxuvgZADXd1OUw@mail.gmail.com>
	<EsDe28RrNQr1KI6OSdjyA2kOYQnj2CqzSDd3lga9Epk_wzttTU6-pIzhVrZSFdqZqWZvIU_Z83b05OwNrKMhUlyrSlNoV3YaKYY1azzHph0=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270804-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,phoenix.local:mid]
X-Rspamd-Queue-Id: D1BF62FECF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 01:25:59 +0000
William Liu <will@willsroot.io> wrote:

> > > Would prefer that if ttl is exhausted packet was dropped.
> > > Rather than silently not duplicating.  
> 
> I think silently not duplicating better matches the semantics of preventing duplication of duplicates, which is the goal of the fix.

Ok, I was more considering mirred -> netem case.
Whether that is a reasonable configuration is debatable.

For the case of duplicate of duplicate, yes that should not happen.

