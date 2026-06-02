Return-Path: <netdev+bounces-294045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INOFNqV8HmrnjgkAu9opvQ
	(envelope-from <netdev+bounces-294045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:48:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4386162925A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 08:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A45E30BD895
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F142ED15F;
	Tue,  2 Jun 2026 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RSnzM3cH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5473A839B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382572; cv=none; b=WM7TKKCqGbNmSG0duvN/cpfJJXI5RYBt87VhLgzr7dfB42wIEYcNHg9kepT0gtw8KZcgXqal6X2bUTP+3CViBBewMH64eZd/W71OepNIFGPgYQVO+QUspEInmCAqa2anRQ/CabGO/3EJjX2cBraQ7ZjbwE7hiRkOi0BF8+qAhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382572; c=relaxed/simple;
	bh=qE///xx7EQlY0uI+1+xH8GZBQ0wprBOgoD0QacK7mPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbCmSmsekI/aaAyJEk99I2Z5KTI4sF/IhGG+OD6c8b/RO5PRsoYqmxlk2CwnPQWPuOClhjHRcEmcRccqkhyqqrZrpQqFqhEhUMm+NGzZNM/o/XR4TzTQ9YaHvnyh1ggGzxJ61y28H/9+0dcTewiznNdj+Sdx4DnIA4uHiOHaJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RSnzM3cH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so3583197f8f.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780382569; x=1780987369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2N/m1TM4Ju0vSdiUK1Hy2gxsTSd/KSb52qvXdhc7mG0=;
        b=RSnzM3cHvYHE3UTZ9p3pZ6e/UntlVl8AHG5/DqSuzSAOJw945T9sAvT3an+z0I7QGr
         fB5wcnf4toeO9IGAtqKw4OqK8y61RC2PnjA6blbdexKAk2cVjQuZ59KxwcqMDHyWQ5qS
         nXbvmO/hMkvHTJinb+4nle7UD+6pwkDt0hP6ZqRMze7Ur2kDFg1hk3vlMyg02XzZSY5T
         6qvaX92Q/dkQLr/GHVE0uwzUfyGb0Op9M+JyHA/GkXG4vNJTE5BC7FdCwzIjWnhjYCl7
         xrkNaCE9MouLUCM8Zs72X7cIOBxwzjuuzVs+jsiLw2PN+OLNY3/tUO2TnZF6pG8ru1tO
         UAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780382569; x=1780987369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N/m1TM4Ju0vSdiUK1Hy2gxsTSd/KSb52qvXdhc7mG0=;
        b=L/97OYbFLgfzN9F7+mcs3qpCSd3jRSb1kNZcKFhK8ZTP9OrJE/8UokzTtIvkqD7QdU
         nQnGY8+5lSY43yDVl1JUbrbXT7CgVdnge8l7TeIeOQEtq1+EzC7A2KY0L1Z06U+bPZfv
         +bSygWe4w0dNzaXsxoSR5W8JaD8ZP609t2nLrF3ki4YOg5ctGXSl+J4DcL7cHT0nirpM
         LfOmiHF46nMvipZNZOKWmhR/FZPaS3QszifAOwELJuVxSTf8KR8oC5e2MxiJiKPWfbxn
         2pYtTA83OEBHSOGHXawQHTJ9pPwdCJOvTquEahPiSmVk7LLwAP5D6Fi3tvmSsFdAGhUw
         oFxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oDlai3E1nQl8Om8tH+dBQLDfMqUr4/Wvff3WLpN9ONKKa4boGu8Pwj/n6DhXMBlHkbp5tqg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9nslWiBWqV3RQIhO4biIEyh32tFc9uuffvZCLw8/mESXqxmw
	7MUVS7HBivs4sYMFxF3gk6lI7LmjauKKVP4D0KOrPlpwQMTl/by8klp1CXVgOrG9tn4=
X-Gm-Gg: Acq92OF8I0xEocjK+GyWKl2zFd3dtRlp3tcIbCi5YjKie4CWxrYJD9qN51Z6nRon2Rt
	ehKvzVxqYsEcOVeUk4B20WbrxnbA4nSv+rsPdlAb7AhJn2wp/YE0gTE7WOHsBn8kaW1pmx8VHF5
	VnSdLXTPHAIAeXZvC//ScWcjRW9pXgRPRzN+YsWgHYagW3p+sxZt2ukdk6AJZ3nrf/UJnR+A99j
	AnDWizHigdVmhyzfm8g3AZ5eImE8Fqo/GmzwI0johcX33Jmd60/iiI976d5OV5g2SaYbj2pFmyQ
	M0wWSEOTlpv7DminHTR9NsEdSEhhVP4z9Pi7jZHcbdvYhNXop8ScimyM0DdXzkzQjm/qcmOriyf
	alhM7k55g6qfHNyXdIbAiSW34k8n4rnKi6jRJAj3GUJPBR3o3juasTeQaobPz1hMw8fUmTyL7Xa
	bujyC8QHc/p2s9qe3ZFS00ShlukBICWMokBuTtWE7drJL8pcaAilqtaAz5ONJQpKGGRQpB5B8ZI
	t2i
X-Received: by 2002:a05:600c:a55:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490b0717e7dmr51100485e9.32.1780382566124;
        Mon, 01 Jun 2026 23:42:46 -0700 (PDT)
Received: from u94a (218-164-49-131.dynamic-ip.hinet.net. [218.164.49.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fdf0asm121897245ad.26.2026.06.01.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:42:45 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:42:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah56iBM2P_9hF3_L@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5pf25fhVH9WuU-@u94a>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294045-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim]
X-Rspamd-Queue-Id: 4386162925A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
...
> On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > Hi BPF maintainers,
> > 
> > This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> > The series is intended to fix a verifier state-pruning issue where an
> > impossible scalar path can be kept while the real success path is pruned.
> > 
> > This is a verifier scalar range-tracking issue, not a helper-specific
> > issue.
> > The visible failure is that the verifier can prune the real success
> > continuation, which should not be skipped, and keep only an impossible one.
> ...
> 
> This sounds somewhat similar to the issue fixed in "backport of iterator
> and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
> to test on the latest stable 6.6.y as well at see if you can reproduce
> the issue there?
...

My mistake, the reproducer you had doesn't use iterator or callback, so
probably not fixed in stable 6.6. I'll take a better look at this later
this week.

> 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
> 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

