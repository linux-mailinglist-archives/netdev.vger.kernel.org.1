Return-Path: <netdev+bounces-299995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fEkLJOr0MWpDtAUAu9opvQ
	(envelope-from <netdev+bounces-299995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E3695ED8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 03:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AYbBsRKs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299995-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A3B930448A9
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 01:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4462C21F0;
	Wed, 17 Jun 2026 01:14:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD32E5B2D
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:14:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658844; cv=pass; b=M0UDUqVRR6REq0BxYHCYLqxHyrnwGCcve0O0HjWrtgYhqExY2Y4ynyRk9WrbEFd7fsVAs0o6xZ0F9JcXwQ+ICZ2feO5tqJBEmLXbWKDEFohlYCOb1k+6jUkx9zF9it19MG2IYxoY17+2RSU/6X6CQ3JadnhFkuZNDqp5gQaZHjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658844; c=relaxed/simple;
	bh=B6RQPdbAM1Bdx2RJlhkCbQkRabhwiTgjUzcmiJ3hJJY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kexUe2LaNhQiR4rG+DT8V7QloZYOQr9rsjGTeYkTaK4vQu2j3cUmSisGHxdfyiyN3eaFVsCbyxoANp2eZfpou4Bv2U667WwPnsTSqRoM0WpM0xnr9jsVl3pEwnRE5ulHCBqrBT4dWGgdWM2xq+k7yVoDB3MGYB6rs3TZlS1DUjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYbBsRKs; arc=pass smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so48833356d6.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 18:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781658842; cv=none;
        d=google.com; s=arc-20240605;
        b=JfIWq19jkRQL/V9Yp4FhHXLMBw+vWqJMTsUr+qysKEpRD65QEwifPm+n0JFrzPrPxI
         MGAGrK0tHizUBm3CfoQOOTeLwicf+uM6Ci9W7isoBVWV5hrh/DRSlQevacv9Yk0/jRT1
         IXlHMyOwj802LmiqtKXqU3+MTnBhgKi01yOBy7B/Xqj6flyf1g8Fa57wHCnPTbF3niX4
         GwxYiwBKKerfR3o5vPoS0TQku3iYQ5NqnR3FCOLmMMQvJ8dYZVH8+dqwh/F5+1ojnWFx
         KA6dwv5de8N8+itWw3VyOCtJtw+Eg0sf/aCRnVIAOmiltWMicDRXh0Lrxm+yCyZoIWbv
         WOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=B6RQPdbAM1Bdx2RJlhkCbQkRabhwiTgjUzcmiJ3hJJY=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=aFJCZYGk9VbCJ+e8VDrwTUKJ7tnMFoh3aNoSStJiLr7ebbhMYN84ruU+2nU63osrAc
         vToj2C8Z+zN0OTyhv9u9DdaHIX0H4VN8xo5jXkhszfIIFaC7/I5CaIDGzI3z7hfvrlCE
         46Bib2FKEa0r3CtNoqBHQt2Vkhwrm2HX1YcZK2vD1U7B8LBUkQ1DDYhFijVv90xWCx8o
         evA7IY4gK3+8YOvTjUAypCd3nWu2+B/ZRRBeCZJAE1D8DyuK5+XiLsTfY5/IuL4oaGUU
         ixn++IClgGAvbShzFC+kgg8GUntWpUcQBhZLkFLuJVzLC92THA5oLH8/ZjMOD0Ie8OwC
         eJ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781658842; x=1782263642; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B6RQPdbAM1Bdx2RJlhkCbQkRabhwiTgjUzcmiJ3hJJY=;
        b=AYbBsRKsMlOdI4SUgbZk8URFHW5Fzscvq77L3Jtc10QoRAyIhIYQ+yU5v3KQuBHvsD
         HJhkzQ27KvY3lQXGq3mBzb4rHtDtf+3OlrFL1KYQGqu/TVvhgwb7u/zR1Nashybl+dgj
         UQyDcyV6IOKbSnNaI74MAYTKnhPKID+4QiKiJ75Xh+JFTiMW7z87TRBe5DR95LfJoJ2f
         2HS7CngNh1yyQag1l2jX0zKb9mrDcQbw065iUVzUA6qkVmMZd8BtFaQ33C9uWfJ4yVgH
         6bge+SNgyMwT+o0jkrjOZ3YBOMOgp/CNrfz8IF9okrUxa7iSbP/QQTVuj7IZElVXLYRw
         W5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781658842; x=1782263642;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6RQPdbAM1Bdx2RJlhkCbQkRabhwiTgjUzcmiJ3hJJY=;
        b=bvPtgA5VMa7cRcCOhltegiOgw85JxG9DC+00igXQsZ2j4T2GsacEwEJYmZPkuNC7Gf
         DFlWDmzex/8jkhDzNAYnk0tzLUTGmAfKBy6OcVHaBxX8MnZLjNSni5ThZ0jHgZi0NMFw
         weAKaJ4uSi/NWP12vi3u4k1JHsdchE5L1FCu1VjN+x/RW1ItVUq2Rcw+I9wrYwrXxMPt
         SF5mbsWKJP6X7SagTVohxgZESRj21+rYOuw7QzrTWbkRUcFzJ3qlseHS2R3dctENDrAz
         /KBgVJBJfirIlWwUGoFMv1oBHQSKRcqN6RLmmLNjmpKzrxUWmAZaRIXvTIue+w/whiGy
         yNaA==
X-Gm-Message-State: AOJu0Yz21Zd2IZ1aDG/0C8D6uabiWVaHj9N7hxe3hVZMe7rBeRGwlVSW
	rAl2VZIsiJ8+BNugm+/KmfU5U6M7X6w9fYoW4BfqsalhmVg4O47b37c98wv06hMtbb1AoOD5qae
	vlk1px7uD0jcocov6SK6ib8jCG0Idu3fKhw==
X-Gm-Gg: AfdE7ckqZaZsxhgClURmnWbZUFPYTLIDXj9n2x5mOwOFl4IhYMVnbR4UgHNY2x37aSc
	5TpL4E5mVM+8LyfFmFU9UsDerkZW7fp2UBbnEFoGPfhn/5/sRauO7vwHQO7V5CWdvdcbbx8bYoQ
	+LJEKGP/2rl/qREF+yhXQnxEIZBBW7FClk6U8yZCLEktA5GYvTAJLBbSitmzv4j8VKwTfp7y9/X
	xqpyyTb2K5vH3n5fP5dQiK27LjAownoy5FF07XdALuYTbAZUEXXvchjkSJNvl6xgoGT8FzgvwXh
	FD+KjIU=
X-Received: by 2002:ad4:594b:0:b0:8ca:25d3:bf41 with SMTP id
 6a1803df08f44-8db5b6b245cmr36671406d6.8.1781658841830; Tue, 16 Jun 2026
 18:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jon Maser <jonmaser8@gmail.com>
Date: Tue, 16 Jun 2026 18:13:51 -0700
X-Gm-Features: AVVi8Ce9hCx4Peg0ANlTuotwUozzACAMc_QQSbyx5qGXC13-IVTCvzcW2qgLNPQ
Message-ID: <CAF=mWJMErgOuTML7hFy6gEH5zqACOdZU62Xh=bR55=VbB4fJ2g@mail.gmail.com>
Subject: Proposal: module for optional /net directory for network data
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-299995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jonmaser8@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonmaser8@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 075E3695ED8

A little under the weather but hopefully this comes across well lol

This may not be for the sensitive. and yeah I do have a mental
disorder as well, and I'm not an expert

But it would be nice for network operations to be aided by a /net
directory, where devices can have full access to network data,
including hardcore bit by bit access, complete control of data coming
in,and out, shell access to network data, you can easily cache network
operations for forensics, you can enhance firewall technology, even
with hardware firewalls by giving vendors time to adapt to a high
level access of network data

It needs to be a module to be a true unix imho

It can be as easy as cat sendack.ns > /net/0/in && cat /dev/eth0

Its also easy to write a firewall in shell script


Hopefully that impresses the Linux community!! lol

Jon

Also if it gets down to interception, wiretapping, and other felonies
I dont mind being told no, Its the linux communities job to crack down
on illegal stuff, just like the nerds before us

