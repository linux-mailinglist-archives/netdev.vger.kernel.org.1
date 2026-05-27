Return-Path: <netdev+bounces-292210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNYLAUW1FmokogcAu9opvQ
	(envelope-from <netdev+bounces-292210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:11:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC95E1957
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40C743086174
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB593E5A14;
	Wed, 27 May 2026 09:07:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691539A805
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872840; cv=none; b=cx4Rlv9xTQz9EUIZ/gE9SOjCguFzJXP2FYjOJUDXrONpFWL5CbOhnACCw/WKqGaSOCffXwSK1FROmmG37H+9YZWuDuZhzWNFz/gytW3XmvIjegzFeDHVPFhs2ho8cA+23rkZtmqYNqC++a8OAv2tJ9y/1t/VacD2U0f2xP3+8fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872840; c=relaxed/simple;
	bh=44aT5xfiUtknRAhR5zZlfqChyD0Nm+3QecUxX6O1BjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l48CXSE6zZEj2EesNwkxDjNGg1WeHGh7J0YKVLjWSX7MEXvIkx5CLF0B6fevwf7NCBjb4MQCfDGGBcDcd5dxp5sLzvU/CUz5lHZ28m2c+X92ZekVfKMZUHmrmkAdDovVjL/Jgb8snUBz+V5xTK+uSEy88us4NU6ckVWU6oITVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso9125782f8f.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872838; x=1780477638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyARKihwlaP3a/dCiYNPjiyiHcIHjP8nxEFuraQQzp0=;
        b=ipsx+UYfL2QetW4766YVs8SjZk/T4T0FnKZwbsQWLQo1OjZw8Ef6EnQslpGEM88giz
         my3ApoTFgnq1iFfS9QNl6B297vTrpmWB3/dWCbvtEGNK3XayjunihmmU58lpWml/XhEG
         BnhCjawSNhTJra3McXRFHs9ixIHvXfWQimpY1NSVoS8zzsqH7Wbku8Z+ZHv/Ev+TYs7m
         J4GLQSW6qGVJCCzyiBbKvA1zOD0c4b/DSe/kofMZWPcSwHfjB5pS0uDoEm924h6KwI0R
         hDEb7OBxIQOWaX9IoeGT05xGgJ23euEin7i+azovXsoAtzzfxOyJqcyruHBOSWhkmSUL
         dVeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tfARUe/kP65nFLos1OPZUYc7Y6FFccpnB5VPF4dISN6GoxMFGvY8ro7joanJ9ZFi7xwAitvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Z7sT+HDybZRjV6pE4u8gMCm2n5R1KRvZLt6kvNmB/6a30T2j
	lEGxb3yVajRurzLphiHDr+6f979IMoGUYlqJvxVPfKnjuyelhojfr6Cg
X-Gm-Gg: Acq92OF823FwGSGQSoAXVwsnbE31fTJ382GPGn+PACTyDNGGKFTY+XnwXw+jdKrU2aI
	HpEEh901uNwYKKG8q0gFf9dRxaFIp0BsCLI2yLEZeVe1gqQrCVD6eKh8Nxg9pVoGA/A5uQEehsL
	Ra4YFmNRt5f1AKr5/PemAkvqWtcsByUyJdj2v9tUkOrPnPTtfYbT2LiiIO4IoeCbfVk59l9CtgJ
	HGo5k2gUbLjztanUEGg6ld8NlYXAl7JZ9zkcnO7CxaUAhjQi1JpeDbSHTX1ud9OCM9ElijOb8x1
	i31S6ZMOTU7HTPfe3uPtjcQ8w9M35U4z+SCbBkEVj+wejkxQMp7J4OgpNLLj5He4sRfWFwSV/jF
	dbAh6B5hL8XTD5WnA481t2d0+QADvrDN4aC089cak3FmHp9lIrP9jms1EGKgTXHL1TUp6xctliE
	QxFBnqwgEd9va8oXtYHaLRGhLv3g==
X-Received: by 2002:a05:6000:1867:b0:45e:9433:f301 with SMTP id ffacd0b85a97d-45eb38df5f5mr40201049f8f.41.1779872837424;
        Wed, 27 May 2026 02:07:17 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb548dfasm4359821f8f.4.2026.05.27.02.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:07:17 -0700 (PDT)
Date: Wed, 27 May 2026 10:07:16 +0100
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gustavold@gmail.com, asantostc@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 0/9] netconsole: stop charging every netpoll user for
 netconsole-only state
Message-ID: <ahazcZw0KRwu5hUR@gmail.com>
References: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
 <20260526190053.619cc53d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526190053.619cc53d@kernel.org>
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292210-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.938];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71FC95E1957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:00:53PM +0000, Jakub Kicinski wrote:
> On Sun, 24 May 2026 09:12:16 -0700 Breno Leitao wrote:
> > struct netpoll is shared by every netpoll consumer in the tree:
> > bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
> > netconsole users only need a per-port handle that lets them transmit
> > SKBs.
> 
> Are any of the Sashiko reports real?

Yes, there are real pre-existent issues reported by Sashiko.

> At least one seems legit (parallel device and target removal).
> If yes we should probably try to fix them before we shuffle the code
> around?

Ack, I will get them fixed and them move them around.

Thanks,
--breno

--
pw-bot: cr

