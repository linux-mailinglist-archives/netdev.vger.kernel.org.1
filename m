Return-Path: <netdev+bounces-282942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAJsAmSE82kY4wEAu9opvQ
	(envelope-from <netdev+bounces-282942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674544A5BFB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970A730E2EDB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2A472784;
	Thu, 30 Apr 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="MTnC6gsm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CC46AF16
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566341; cv=none; b=lTEIpHUXPZYv2GbqK0IxYLk9Z3jaT66VKUxpaGPvXf2XY2VPzIdWJBvbyCadFrs4IB7rGGF3TjFCb76AcCCMubxVweryqQOvr+jBdDBItekGcvIVBzL9M6KmW/pDM4T5Hbk5erjc6eeDNkx9dDh2gQCvbTeRmVean8rFFbFdCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566341; c=relaxed/simple;
	bh=8PUZzr9WoqYVnOdEOehfl992GyTKDX4gQB+f2aatRuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rocerPtM2/Ku8YLVLSxtmZeh/rO908hX4bEdlPQ4V9xn/EJtUOd2BB9DART9fuka+p9OXOy62O3CD4RB6QyCTXUPfcWynNbiJ1Ss25hbpPTd898WYJATY0egCzHmURc+HbPjzFj4UvfNukdPUTGwORO3bOU4iAmsKrhLuM7Q9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=MTnC6gsm; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Type:Cc:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8PUZzr9WoqYVnOdEOehfl992GyTKDX4gQB+f2aatRuE=; t=1777566339; x=1778430339; 
	b=MTnC6gsm9DVmnDo5EXWTwA99XepVfOkStM5FqCXJD/jbKOSMZmVPPidH4wUm+rfavceO0amz/FY
	5TRbAnmLmY1hFhdhwJtvCXTxwhQmfH8YsmuEZO+rYpq0hmOXuLFdyaM6l6rYjAMr6Z8QBAVxrJd1T
	tWIy0mRnN9YAJ1hUydbYn4NTZMo0LAlgUjmutLhjcuu91kPbpKFWJKBWP4QE6x46jnkFz7IIMvdyu
	xsuGbzZaWujuED5Gg0/r56UlUUDpIMrN8SV0cXlWoY1NasQoRwmuUei8EYynPHdVDBzPw44Sntlqk
	pDUE9YL3d3u8ig0mfxayK2K2IhPmtPDGC15Q==;
Received: from mail-pf1-f172.google.com ([209.85.210.172]:54737)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wIUCj-00024s-49
	for netdev@vger.kernel.org; Thu, 30 Apr 2026 09:25:33 -0700
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so846757b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:25:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIKRK/fLp+xuwtZsky/MIHxDeRvcF7Y6f0bRT18DLR5kEprOzk
	WvCq4UK8+LLoBMnCUZQUJ/vOwfixIrddcWyTmKxzApXAFToCfiWJo7yF4fZ/P9f7qKT90AgfATe
	nsOKguyhTIuNDvl1VJBn29EhWSEHi8Kg=
X-Received: by 2002:a05:6a00:2d1a:b0:829:86aa:e163 with SMTP id
 d2e1a72fcca58-834fdb34fb8mr4072480b3a.13.1777566332797; Thu, 30 Apr 2026
 09:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428231520.1857-1-ouster@cs.stanford.edu>
In-Reply-To: <20260428231520.1857-1-ouster@cs.stanford.edu>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 30 Apr 2026 09:24:56 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwuqj1YFSgwMwBfdjofEzC8nU2X_zv3mzq6by2K7mGufQ@mail.gmail.com>
X-Gm-Features: AVHnY4JZL0Ei6SKDw1V2s212upPsYlXN-0n3L3XvCO3BXvIeWXKU8REN0kCd-38
Message-ID: <CAGXJAmwuqj1YFSgwMwBfdjofEzC8nU2X_zv3mzq6by2K7mGufQ@mail.gmail.com>
Subject: Re: [PATCH net-next v19 00/15] Begin upstreaming Homa transport protocol
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Score: -1.1
X-Scan-Signature: 946122a1693bfdbb49d371411bb557d1
X-Rspamd-Queue-Id: 674544A5BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282942-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

The sashiki-gemini review has found a bunch of issues, which look
super-helpful (and a little sobering at how many there are :-(). I
will of course address all of these, but I'm wondering if there is a
recommended way for me to respond to these "on the record" (analogous
to responding to emails sent by humans)? In particular, there are a
couple that are false alarms, so I'd like to do something to keep
these from reappearing in future AI reviews. Any suggestions?

-John-

