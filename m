Return-Path: <netdev+bounces-259817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PFUeC/1EmWm/SQMAu9opvQ
	(envelope-from <netdev+bounces-259817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:39:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70616C2F8
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 06:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF36E302D0B9
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA4311C30;
	Sat, 21 Feb 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="3UfMh97u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CD30DD1B
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652346; cv=none; b=RmMmkJuByqjOUauvZDNzRgFRDQA27b1Tb/AZe115lIeJjZjk5jQc86H0zHpeksn6rg8527LOAB1sWgZrR3HXSg3QGGUwAbaHfPTPHUan6u8AZ3kpZUFEgQK8T3NQg0M6ybQ7UXCyKzHP9T4ABJI9mnhEkAIAI6LLUgvRlm4mqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652346; c=relaxed/simple;
	bh=ahXtCAjLyzpktbzU9Uo5EQqnUb3w3OlwKLRRzTyTsfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFVFE9GoXziUTXeOfM9eCr7lpB/MFlwYAepB3+g221Q/iadpqDcN1qifeuzpjjseq/P05vibsVPtwO7gORQVgPBg0DMdrhan3VCBuxFBjzMHArG/vv/apA3lni10iqm8x0BH1Y5LzBwTfjUOka7MaZ2DmIHfCtloSPn2MZvzkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=3UfMh97u; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-897002b7576so34566646d6.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771652343; x=1772257143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCOEccdl1+Um0o8Qy8pjpdJNLvrpEJcLKiSSv8fk4VA=;
        b=3UfMh97uZrn+43qWFvQnPrvtUq/I/VHEY1xYJMiS3LhthpqMRgTSAzRwPd6MysmV+1
         4BVsr+Hg1+dzfGvPMDknFJ90+YngUdZZE+tXap4XgFul4FFgVTJIj6pW8b5BlDP/uxRS
         iYI8q9rmXLT17YXB0q9r7U8cu1z4QCo4DIWHtaDP22YeqYoZak9tIe4JJID80VCdoXvY
         FJauGllMsSGOEyxbMz6cO0VrB2FpQDIKF1C2oPlcOeP9/IePD/b7sNw19PhuyOC3oIEp
         LzI0xQYJuq9CrVBNqioK1IDoHdZozVd9g2qwXcvXQ3MfM4Jj9WnBoUIIvjR1ItDXH4Kw
         Z0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771652343; x=1772257143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCOEccdl1+Um0o8Qy8pjpdJNLvrpEJcLKiSSv8fk4VA=;
        b=dIiIkhoJN/zYorbNF+cYuaHMXKnhZmcNZkk1J+Qqb2U2UTe5j941P9ryZ1/D+qVRqm
         TDRa3ImH8CrlpsIwLMfRSvQZ07+xCv+JJP7DDJ1ZgyVyLqNvNKx49Ylc0aQCbJVRE7Al
         kkzCJXj6q8Y3hsJul/A4HJqnGAbveqVpae6AAYSM2SdPMeE131d1lWFMfq1N/kzOfom+
         T4/m1EvrZcGHSSjB/FykuX1Dh8gfIKHVDZn3RdC9OSu+qsw4w8oWhrfIKEPjWBSrGyC9
         qU/GxBandXt+IBmR05rjJUQWsDM6whxAnGzDWT+U2ptSQFVRNsvngvhH5J2dUGGuKzpt
         9bFA==
X-Forwarded-Encrypted: i=1; AJvYcCXxN6b+6Hul+CbwBsfx+OkRvGE/7DzvfEuT3lclO0TZaV10J8vKUCwKqpKrj6IfLRlq106OmZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF9hv1CUPwvbkydciEJ9dE93vjpGJA2tfrM/0A/INumL3yzdVx
	EnEXdGin2esNZHp7/xiED6WDq7Rx/Vi20sVaVDMBpjoe7xmbM4QKJVpcTWnaun5FU5U=
X-Gm-Gg: AZuq6aLWtKOHXLn8Gm/Bu2Ldi/LNKROFE5lAdhhLXUwJ9KCs3N29RNMufFn3O/LnbPV
	1LUtDSmMjjkGSJVp5de1vaQqiJYL3KhPQTKnVT+wr5jJFIVbxMj/rv/Rjta1pjxZljAtiy8vMrI
	uxi4Dcyr9H7jOqQTz/LmVdrZDy5gZKH+AenuUQGY2pNOi+gIqxIae8COuESSgtyLV4KW6jI7Swp
	BbLUib9TY9YyHRA4GC2qOE9X/SEXyrEe0biteTKvJUSuwF1kIiZVsVZoJFxbbCwTQbTpRpx3uIS
	mMWgtKzXO5DQYim/SVOSArAQWWvutR4yMbuFvyRx7QbZuuMraJ1byWykw2SxZWe4Hye6Zgp4N5T
	cInCQrTgmSUBrfreADtTEiUKsE2pWAcnypNsFzSYos5NfsZyrkTts8gELuAGv5Scvh8NFmPAIWC
	9NJh9eYaSazVwufoER9YSYeOqG45480Afud8kWXvfNYgcfy0ULEJrKQG3rCLrXN0nr3fhWexr55
	CM=
X-Received: by 2002:a05:6214:300d:b0:880:8600:efbf with SMTP id 6a1803df08f44-89979d90729mr35805436d6.56.1771652342958;
        Fri, 20 Feb 2026 21:39:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d060846sm122327385a.14.2026.02.20.21.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:39:02 -0800 (PST)
Date: Fri, 20 Feb 2026 21:39:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2-next 2/3] utils: timestamp: add JSON support
Message-ID: <20260220213900.76198834@phoenix.local>
In-Reply-To: <20260220-ipr-monitor-json-v1-2-eb4b0d5f7820@kernel.org>
References: <20260220-ipr-monitor-json-v1-0-eb4b0d5f7820@kernel.org>
	<20260220-ipr-monitor-json-v1-2-eb4b0d5f7820@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259817-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phoenix.local:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6E70616C2F8
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 19:54:02 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> Only if the output stream is 'stdout', because all JSON helpers like
> print_string() only write on 'stdout'.
> 
> Supporting JSON is easy with the helpers. The biggest modification is to
> extract the end value.
> 
> No behavioural changes intended for the moment, this is a preparation for a
> future usage of print_timestamp() within a JSON context.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I would go farther, fp is always stdout. Drop the argument to the function.

