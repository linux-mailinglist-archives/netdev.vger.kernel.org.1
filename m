Return-Path: <netdev+bounces-269660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGIMMPZovGlQyQIAu9opvQ
	(envelope-from <netdev+bounces-269660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:21:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 492002D29CE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526633009B2C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE83B47DB;
	Thu, 19 Mar 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYuYh8jf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE7368968
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955315; cv=pass; b=gFLdz4wcgil5oqptpuBezvptHjAwsJSe6275MLN/LC7yP5Vd524zjvIxjLaaYw/nqYmn55Br/aaRhwNm8IjcjOBNkAmv8SlcfzB7ToaBgiqB1uTvj/3OL+bA4wYIajRafPS+5ZT4AJdDILgDd1cC4x8HGW+5srVQGEhBUCQmDNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955315; c=relaxed/simple;
	bh=221SE52RqevFko6XNRwaQM9HvEmE73WFUCY4jlFOO1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iikESSNbgPpXfQnim+36IRNT5YjtlYHOtDE7N3XamS6BeRSYVWtsEVvQS2W2CVAv8WOq02ek1CeYXqibYx+GtWi9Wmv2VoyzdbEi1+acLZ6RA9as6JSvI/7y8sZF2H4Zj9xysgB2LUQf3tnInGUr4ZR2tug0Tkz9xrbh6Cf3rfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYuYh8jf; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so747203c88.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773955314; cv=none;
        d=google.com; s=arc-20240605;
        b=QYBOEt6R5WGf4g3Lgkro2ysugQdY59WNcP7Q4LfE5kzyw8uFpZPQQXfE0GhPfKgqCr
         VpR7r5qXSEkzb+nk7oVKsU/mcJ6JOaWfT4NtDil/52OH5gGLtMy5D9zA7TBK4eLBSlHm
         51hVXgVfM1Y+LtAIKAlPRPVHBe5165XpdMxuKN9Goc6NYCbFlw43adIaDRj+p+JbnNIx
         MxrQ8+EZkDtsU2Ozb/e4NfKV/oSY2Rch5MX/CHOrljlGDjnHc0ogx/slfBpzeRU7FMvE
         Y4OUrGJ5ufq02BlMbdlB3P+6m42BlRX66icsexAtaFdamt6etjb1lH48hZf/j3GQu5mP
         ubVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=221SE52RqevFko6XNRwaQM9HvEmE73WFUCY4jlFOO1g=;
        fh=iaQFxF4h+K0gqsXk8JHNs0iy7IrLX2aWXbnqlHqysms=;
        b=JHjl2CqTT669jU9tZZsApdvhQj1KCaA8Roudii+08qqikY6irAsm3bYVQ3Vafv3n4c
         8em8rV79Fi8XFo3c/+52+++LVDKa2L4CE0e+3jcIeAtIyNIxjzqNAKHiHNOPMyIE1hod
         M6+GRP+P9RFKGW+8eJmApP6eTwk3AfI7riA1/oBG8QPrqee9l1C2aF34hCrjR0SMFwho
         yYS53S4+eYtCSBzdc8GX6JN+Lt4a76NQqn0HezEuuRfW4HWVFiKJNZwuXSXJXfdoI0AI
         5UyfB9PLbopQDW1VDdLdUGFHwUw6bn5Zm5Yz2PEXr0kEueNUgIVkTO8nujqL2uUVJohF
         Dpmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773955314; x=1774560114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=221SE52RqevFko6XNRwaQM9HvEmE73WFUCY4jlFOO1g=;
        b=OYuYh8jfWV2zj7Qi8ABMTbYmtjujUtTUnbz7b0NTJLQMYfF2g+mzGrFbUPrc/DO/Pg
         X6C9wum5FUU8glVsIpa+/uk9lxDtUp/2qYvkrReSXp1AW+VSACojZFSXpUZk01GD4bQG
         e8JRAo4FYHNQk1LVU2ZlhEANmCqa2Zfe8MW8Ql8zUj73XV1vb/VVJF2B6vAHhoUdyvcH
         XzFDGGT/kcuuhedVkMzS4aazAjwY9J4vPvRbm/XnjQ3990KiWOOExQw+79gGsWqSuXhw
         Q98rb8m4CQ9zgW3ItwnUYce8SLHVzIzVcaJWDqnTib3jRUHOC5GViTpktknGdAV/izSU
         hxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955314; x=1774560114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=221SE52RqevFko6XNRwaQM9HvEmE73WFUCY4jlFOO1g=;
        b=mePS/iVwVEoOsuLLlxVB8SOAjWxSvasCSYbpBZW/oCmBEp5y7LKcM/u6w39qOHUqRl
         nv8MK1ntPI9aG+UKVLqi4fxJk5qWX+wSvMSWKVLLysUye0Q9GHV8eoHY1DITTPLvXRIF
         Vn3ptn9rg4NDvsNSJdADN2E3oFosWS3ASRkaLIjP6PKEpI9Ujd+SJk2vJjRdFjKSP+dw
         bRghzeh9p/GZlJBtF4NfJ4kDHvjqdsBdXsyAJLxLnhobME9xW9F9nwp9x3Dy1xrBBFNO
         BDq3ho6NUHRWC+7DVPCAAVKr2PYHs62Ps/zfTcQYWQXPpXiXOQ9b3hcXCEsUEH+4XdYr
         HGcw==
X-Gm-Message-State: AOJu0YxfWs4msd64L/hW/nmqlVZVI4YlmZ9se7Pkgl3jdLVy6JmKjiL/
	HsC/MtLhc8KiQUmkb2qyUox2ApmNl3T8ThyEEMzRdKZlsUzgO5fnFgbonnvCpCFrt6dDWF0bnpd
	VtXXKip0RrEwwzfqimBDqIOyjnTcNIyU=
X-Gm-Gg: ATEYQzwoWFes4Qo8B2sKxDDO85GZKo5w435VM4XgQqjaIq4yqt7blbkVn32CsAJ2E+4
	4p16bkgCXrCjkhsR5BwNYjKlYhjlQH94LCpmWrHYiH2ViSz2rWVGaEuUn9UGDnJ5xN8NC5oF+rl
	qTOQ4u/fgeqRCjpnBa3pLaQsZOxV1tuVTj3jnbks6aYyzMEzu8Ow3+ftfirhtUhF0Cv6F2LgOVc
	08Hsw4cIbAx024rrJGAb2rs7zurT/H1Z6LyiWdW/Mc+ibVBNFev68ptU4Xb+Lz+9DNeJWnUAHu8
	YkcXk3t+trGHob4Vg56MhL/uhW56WrLYV2Yydv6n
X-Received: by 2002:a05:7022:68c:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-12a7265ef91mr378865c88.10.1773955313615; Thu, 19 Mar 2026
 14:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317065137.1533226-1-atwellwea@gmail.com> <20260317065137.1533226-3-atwellwea@gmail.com>
 <f5c9a512-4779-4cc4-aed9-37ce0131b3b8@redhat.com>
In-Reply-To: <f5c9a512-4779-4cc4-aed9-37ce0131b3b8@redhat.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Thu, 19 Mar 2026 15:21:43 -0600
X-Gm-Features: AaiRm538XUw4IKToQaoAq11Z10_mTYAUbrTsrzh12UMqCaa0aGQGRCabgU4juzM
Message-ID: <CAN=sVvxQg026ch7k+GKxORd1hpQzQtROT2=tNQ1h2HH-re5-eA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: keep scaled no-shrink window representable
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	ncardwell@google.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269660-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.891];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 492002D29CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Paolo,

I re-checked that corner more carefully. I do not want to overstate it as a
common path, but I also do not think the current code rules it out.

rcv_wscale is fixed at connection setup, while full_space/free_space are
recomputed later from the current receive-buffer state. The tree explicitly
allows later SO_RCVBUF reduction, and the window clamp can also change later,
so I do not see an invariant that keeps full_space above one scale quantum
once the scale has been negotiated.

That said, my reason for keeping the small non-zero case is not that
unconditional scale-down would be less safe. It is that it would also change
the long-standing behavior that avoids scaling a non-zero offer away to zero.
My intent here was to remove the larger-window round-up slack without changing
that smaller legacy case in the same patch.

If you would prefer to also change that small non-zero case, I can do that in
v2 instead.

I will also rename gran to granularity in v2, if so.

Thanks,
Wesley

