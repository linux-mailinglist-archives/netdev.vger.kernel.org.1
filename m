Return-Path: <netdev+bounces-268366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CRGHESmuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:54:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B92A25E8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60294301D328
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD822A817;
	Tue, 17 Mar 2026 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Btn3RrMF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85907219303
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708864; cv=none; b=VLIVqXva3YhQ7EU837i91+YwSotc3miSl24AXhI92JUw/o5uzDQEUZPBDCAxMpiZshI8AuU/3q6F800jT+Umai8uGMnjz4w83eVICxKtoJ4kI/lc4SWzMK99iCCrNPcujdE/FUsycVJsejH/FyzL4u/FC85LG4I9FVbMXGkiNK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708864; c=relaxed/simple;
	bh=caPGF/+uDup7Y/QzYuvTP1/tLOuEOtlg/onfpGqB6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJQNitFpAShudKbzBZNzjBDFk39SXSZSxvsb5SKv/ACDH2Xd6gJawKOljpRqTI1UuWqVqFL2Av5kABZopebRx7t6VrzczfX6sLcRXaB4BOUW+s5yLCKvlcxbctVfROgsLNIzg9GrJFZgacOlQB09AOtPkWwAFkgqN3M20Wr9AzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Btn3RrMF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b05761bec1so921095ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773708862; x=1774313662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQf+XocBbjw+0Q/6vJsd5xscgeA40AqvzPM/4HU1+tY=;
        b=Btn3RrMFoAPvIxAEWob7g9aSgjE8G6fCD4646bGflrvr65tCIkQs+bqvqz+xL/+9hY
         6u9D+N3Z5BJxb5uA0sfuMBxNTiDoTPiFB9WsRdN2x3MR0Av2s8e38jnvHMIEJFaPYEiO
         fhkO/sZpar9HtRAWx6vLCKlItvxbsBKysVu4PmfyeiR0McwgKUvQ7kA0PuLmRYkqZ3ay
         UqwxvSMR+4WDFsvS5kImV+KzdD+k/zJRGaF2W5DPeV0I3u0S4oB2oLVDdAOb/4/EEy9F
         31/6GYwO6DWBz/8HQBLM2zhbyA/r0uXhI2+w8hKV9NY4VmsjscoJJ57yWmk9YZwX3T15
         AhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708862; x=1774313662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQf+XocBbjw+0Q/6vJsd5xscgeA40AqvzPM/4HU1+tY=;
        b=R7FCGQqrJqoFS0z6HtWirYX51ueS9tAGmxKfV0BxeRxPOcrfNdtdDFNvlE3Yxuom0a
         TV0ovw0FLH1OQxntgHi6YzVUF5pvzMlNlkmslsuImZsKv1eRmxz8GuwcRMLSBxG352uW
         +PELcH7b5dFsa//cxW37rjFE0VxgEx+6qpqkK5MZQaZshS+HHB56S0ipesJvytWw8AgL
         UV/GE9beISdBWv5AzdkV334N43vBf7sykc+/b7DFKUxRc8dQItrJKPJy2ocHU0RFK71R
         fndvAoQgpsbaGGLiDd7etB2ITt7TD1SdhW5VKSTjE2WxveuiyYIO6qc1X67HIbasgBNU
         cQrg==
X-Gm-Message-State: AOJu0Yy1xbe+QV8bQRVkR5hF4IVE2iyKTNclFa1WGg2pT/mPbCdqvLsM
	76K751Eh0UECZGgY+jL9T46dM1FkY7nwjThFJKrFWbliHmY4DrSfYm7Gn3lXL4RttoE=
X-Gm-Gg: ATEYQzzKSzitvQxXrZl7Gf0QRcPdikJs1yb7QdbyopZlvD/PAWOjTLVEJKcAevcHWHF
	4AxRF+2iY+ehuZz/fNL8wYGVMRohYjBjENbMpbBYUTq2Ik1H+AebrROYDBKU7S5L+pTf74Jie4I
	7xLtMjx5NJB0iYM55HHLAZuGGP1BO+FqK41wAaPRMbuDXDfynx7pE+VWOmZ68Hg4ba6rZnnNutJ
	FJmpj5pJuUipJVdg4qzuWwjk/kmy6Kqp18AnUFpvyZA55S7mirdGpavFCTGQLFM9i0y/2vxC9eR
	IXJ63n/QVk6Ur+rslLb0rmbGhAk/kJ7zCdHFSLaPAHdPXUdUSg+32d8me/EVVcp9Py60qWNALMg
	dfjMA3rekFhrcSks1B58dBLijeAPOGxCADFmkNr0aC+RjlUwt/XWEz5FF/21KnIi7MBYx/Xwz3h
	6BaNHijbQ0qSsi6pLZ0C1l5WI4uh8To2NicUbB9LPh/9GzGGAQra3RNbiaSE/0SbyjXA203vTK8
	etO7S70OgvJpTl4ITmtmA==
X-Received: by 2002:a17:902:ce07:b0:2ae:be67:722f with SMTP id d9443c01a7336-2b063758ee6mr12290245ad.22.1773708861829;
        Mon, 16 Mar 2026 17:54:21 -0700 (PDT)
Received: from stephen-xps.local (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b063e53a40sm7811455ad.3.2026.03.16.17.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:54:21 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:54:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu,
 pctammela@mojatatu.com, savy@syst3mfailure.io, kuniyu@google.com,
 toke@toke.dk, willemdebruijnkernel@gmail.com, Ji-Soo Chung
 <jschung2@proton.me>, Gerlinde <lrGerlinde@mailfence.com>, zyc zyc
 <zyc199902@zohomail.cn>, Manas Ghandat <ghandatmanas@gmail.com>
Subject: Re: [PATCH net v2 3/6] Revert "net/sched: Restrict conditions for
 adding duplicating netems to qdisc tree"
Message-ID: <20260316175418.595d4690@stephen-xps.local>
In-Reply-To: <20260316211052.332383-4-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
	<20260316211052.332383-4-jhs@mojatatu.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268366-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com,proton.me,mailfence.com,zohomail.cn];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email,stephen-xps.local:mid,mailfence.com:email,networkplumber-org.20230601.gappssmtp.com:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: A78B92A25E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:10:49 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.
> 
> Reported-by: Ji-Soo Chung <jschung2@proton.me>
> Reported-by: Gerlinde <lrGerlinde@mailfence.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220774
> Reported-by: zyc zyc <zyc199902@zohomail.cn>
> Closes: https://lore.kernel.org/all/19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn/
> Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
> Closes: https://lore.kernel.org/netdev/f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com/
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

I would prefer that the commit messag have the reason why this was reverted.
Someone in the future might not see the netdev history.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

