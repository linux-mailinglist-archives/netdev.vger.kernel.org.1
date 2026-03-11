Return-Path: <netdev+bounces-266382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBCcL/ezsGkHmQIAu9opvQ
	(envelope-from <netdev+bounces-266382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:14:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4537125996A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425D6301DEDC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DF1A6829;
	Wed, 11 Mar 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzHeO0dU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDE1A6812
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188084; cv=pass; b=Ay/pJmOOS6usVPVD9n4TeRvvDqcgUzUBOF0emYUN2kfGrfZjrFcEH+5p58mTAnAgioE0gruASZAC89XE6BvUImn9dVO6kIREuAL2C8TAkGIFJOdMnFICBwD/Y7gDQk9O+dHVqEOTWOrvU8ZrWXPPzdNpzAcZZND/iZcjcbZwsBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188084; c=relaxed/simple;
	bh=D+iqzAhN5qxgYR9QvaLnKhwfg2KaNn6nPiw/GixdEpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnHSLSVpPRc+AO6g7XL6FBjJedCJlMiakmOovmN3T+J0Nl609K35RfnfEyK36ayu9Almi3KueKy3kdmj4PPDgJBahpQEnkSr7rJh2LheacnEEMi4tOfKVNi0maP/SO2hHx+dxH4tCYkCQRctEmiM/1z+1dEuPqT6UZpdByDQVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzHeO0dU; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-417571c6083so1003692fac.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773188081; cv=none;
        d=google.com; s=arc-20240605;
        b=TGfZbL/XOR8Pl6XorHAGHhR3BtJvUWmXKOphpWF2X20ySsZo6obRa+ubtE66K2X5ip
         IqWHBhHUmWTOHMdEY4aCGVk9ObYWeEHtbtIH39sww9dWfukFSYzObAy+N3AZoxbmqu7U
         0r3yprRHQjiQGT95wjddjCIjn0Nqiw8G5P1pQdr22gNnqcdo0qb/xNuG9sUauiQQfd3a
         DZNMPz/CKBaD8QG9dXZDqgXcxwu10RGe3J0Kz2mP6nU3bXKqQIa2RYJhFO+gAqliqD8P
         2MgNl+Q4SIiecJCKtBgGZx37AXberHTRPPoQDgr7SCdYnbF/yjbosGtrnHrSjMsFQljL
         YjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+iqzAhN5qxgYR9QvaLnKhwfg2KaNn6nPiw/GixdEpI=;
        fh=O+7R1+F0hBTTXKwRr6wQNJGi25pCg8Ulkhbg2I0eBsc=;
        b=Jrt7SEC+mylZoAm3V/8wjcqqPwG5JkoOjjGUqHCDC3jZkP9/z6mD/XUuGXNauuzjlO
         qwXuSzZjBGUTjHOjENPF8G2WTG/vyAdMRIf6JJR+knRbRl3kbe1YldyEqPIl0N3XqT2q
         SZDoqYFDQWdZjIk8C2Oag+0tYe88gKQO0eogcDoIdlPA1sZyITVwzmc7ha/H07KXnK8j
         xsTc/Zivm50Q/5zeQJxt0YaS/b1x44/jDUX2FzyUX6JMCatb5DDfb52j656GsvapTT3r
         v1sLCwgU6XdxC+90tD2Ffe3WEd5YPpazAti521EtkCWNxiyL36SJQdQBRIf6EbtnkIgn
         TXhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773188081; x=1773792881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+iqzAhN5qxgYR9QvaLnKhwfg2KaNn6nPiw/GixdEpI=;
        b=dzHeO0dU9vkid1j7gh3ctROTS/PE+Uq+jzX2mcfuMclYudNtomPk2L16CBtazO0oTO
         TKg9bD+UzxwlmeVYxUHySkcLTQfuY+NBcPthbjwdykltBkcGayRInSpz0g9MDffbCVf7
         K2gbewCqMo1TrXhquw/VL0FasLmTHuUF+7sQZriaQlm/pQCvKtzl33h+0IcebAbtkRMv
         IEZpODjNTHIesip1roDO79nEgRbzOR7PeAHilO4AT5v/ypLJpIIIjstMTY964C05oSYH
         bq1shVU1Bj5bBztMHtBHpw5x4xgmzpsKHnVQU9Wr7phIobR6PRkK4KHqsNOfd3XKpiBR
         cTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188081; x=1773792881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+iqzAhN5qxgYR9QvaLnKhwfg2KaNn6nPiw/GixdEpI=;
        b=De5dbOjYXExdSlUUb4OUbU6iQzrRSUUzihD6BNt8A6p7YtL9kzd+ggkEbrAf6OBXGi
         XQMbycvUcHMp+y2auaK1666X/Qk1LlqinWxB+bxEova93ozvFhgarm9Pwe6dkPncsA+9
         lxAUyIpMzibBoYpfuj53jHKtWmfOrtz85aSWX+oW9HKidBZjjY+BbiCNABMmWn0yrpee
         WpBD2OicQfdl5n3AMlIVUrq5eQfOjybOE2wMBZOmBZPRHTBfh9k4dMl4eZKoGGx7FOuh
         ttEXzHBdrpJ2qBOUGDGcWnxUtHLKYhq8IFvcIPJf4thBTRRXU9N20jo3zbilH2HN4TOM
         5dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6p4+m+Wc/sHjV5WMG0PsOLm3Ibc9wTTtAs3Gwh4lylzsIfujklG5WNMdBmKCWBMlzRkp9jE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Krc78jjULiPzOqGs1WBPYNwixtUdtF+i8TGgj63+fiaA3ciw
	FmdcZHgOC6Ee+OJlyWVQUNJ+WYdamIpX//tTusSAMYMczcTOW6jAAOr0B+u/HoDBSF7c4YdsATz
	OQa3XifXaiEwz/S0yCQ2JrZwjMntmpu4=
X-Gm-Gg: ATEYQzywh2yuF8uqggSH917nDfocNC0xiegGDG2y23Xfe4ehQMyEOzuGx+ALY6DFXMd
	V7mNfbbvKruEeNoKz6B7hHsgHWxmw3RZ0XuLjAgjZGTz3KNRTp/mfu2rNgt4sIexhSzGlfmrI6Q
	F6zXEKsY/VtRh+1sb1ylc5G7RTraK6U9Swc0E+3bkD8xxKuTkdHADtbE/P6Q//61O5A8ufaSEGr
	eWWebMjMredoyLkZqxqxCtZkOGtjDgZp8wp14iEXCT+HmYQmskGlVQs+ayh4vCV2nbjPer2RONF
	7Tq2zxBJGx81N7tZzA==
X-Received: by 2002:a05:6870:d0c4:b0:417:53dc:9ae9 with SMTP id
 586e51a60fabf-4177c5d56f2mr559070fac.11.1773188080673; Tue, 10 Mar 2026
 17:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abBf_R81PYmafhWv@v4bel> <abCh2CgVS3Uw7W-_@krikkit>
In-Reply-To: <abCh2CgVS3Uw7W-_@krikkit>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 10 Mar 2026 17:14:19 -0700
X-Gm-Features: AaiRm51IR_cbWg3Y7oVgwA0U166CMGV6--MwttpU-1K7RzhMEk24iRbRJVHQ5R0
Message-ID: <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4537125996A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266382-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eyalbirger@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

On Tue, Mar 10, 2026 at 3:57=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Please also CC the author, and maybe additional contributors, of the
> patch that introduced the problem you're fixing.
>
> 2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> > After cancel_delayed_work_sync() is called from
> > xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> > states via __xfrm_state_delete(), which calls
> > xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.
>
> Eyal, I'm wondering why __xfrm_state_delete() calls
> xfrm_nat_keepalive_state_updated(). At this point the state has been
> removed from the walk list so nat_keepalive_work() won't do
> anything. Am I missing something?

I don't remember for sure, but I think the idea was to have the work
run "now" so that when deleting the last nat-keepalive state it
won't run in the future, and in general to refresh the interval and
not wait for the next iteration.

Eyal.

