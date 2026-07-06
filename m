Return-Path: <netdev+bounces-304957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YnoSCjmcS2qmWwEAu9opvQ
	(envelope-from <netdev+bounces-304957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:14:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2877105EF
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:14:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BS5Loq7h;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304957-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304957-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4EE4372F916
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDE3F0773;
	Mon,  6 Jul 2026 10:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943A3A544D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:07:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332464; cv=none; b=WvmcgBVLFuZ9HQSHydXfQ3fHYDQDikb6UOkjGfaiuLxRbwtrM83on6MgIV/AO4hps54uNn563rVGst1T6siXLCv6aKnvyuftBPURkrAnYcmj4FMQxTa6YkbXcalp3MZGOSn8Ee88UJm5tl+uqLuh2Nu8s63zuch1S+iPpBaPIyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332464; c=relaxed/simple;
	bh=JJUqDu2+dqGsrDoXsty0EwVEEsRe1/5oiBAXNjpKIlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3BWG1rkBSAWdGQOBi6o143+sZgHtabrm62EL1jv0pn1HQI+4h1iLJYHLSqcaoneT3lv6xlVLbfqBxMN03T8xWBmdWXfsosaFNx59KoXMwZ89wUsQ5ThQluEDrjN9Fhfn1RNHN++OYRuJsYAE0BG5ayT1G9TJ51DBCUKzkqXdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS5Loq7h; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8482074a000so292183b3a.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783332462; x=1783937262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1tEp0DM60rJuaNUtw2bTl3r+XcwQp5b/KdfASU4AAM=;
        b=BS5Loq7h02CqGhrydSsTzhjDnXe5gfxmnB0blHXNlkWH9Wx/6/U+mqO+jeIoi6MJgi
         osJtQAf6D0FTX1DI5bFTCTRd+cxKNhL0oJfIBLPu8cSN9WFfFFDgkrYbP2C2Cq0khtIu
         tMUuW8Fr4Fgvm7CDzbDw45DbTphfGOB/ucB8CTeHGTjWCH/4luYJgi73QAt9o1pjcSbV
         +pgKWVGi7siDOJu6MNy2ylapo/bMlY2v9WLn+SfwJVH3+pWx/9P/cKg6M/BnvFPu7UZ+
         Ib40l1L1F17hwfTo5NpxP4TmCL5hRkdBXTTT/kTMCce7TTrtlkFaSEcGprtxj1fpEXy/
         zzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783332462; x=1783937262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1tEp0DM60rJuaNUtw2bTl3r+XcwQp5b/KdfASU4AAM=;
        b=cljASQPgJo71iUmuyghffY/Q+KsJZJOf4hRSW5qMFEIv9XgjT2up5ug3UtVEDPm0Et
         mMQ9HM7ytinejtePQCHQEBx1y/ycL4SEv4qeUSSRlARwCuI79w9Cr4tiZtN59lJq81VB
         kJbDcAU7JZSy6z2eVJ0FvdILr/snZylWFDWZp77yzIfIYI9XP10kz+tLllfzbA4XQAcu
         g6cWvxbTPvRPkeQ4DHCNUz/ffNYxSvHk9GPIN9hoBtSPOeNDp5DMR4zl6C2OgN2DLczX
         TrvrcEVSjzEaheUyWyqgWLSKNQCCtKE3xz/Z2ilZXG7NMTLA2u3RWutgmzwi75FEDHdS
         70eA==
X-Gm-Message-State: AOJu0Yy3Ta1+z02fmdrrcwGUnj4fLaNCnuawc45FNpguDV5AFVPiwuwt
	Lk+mxzpW/VeW3QzCXqbjIqqt1zvjuHymqgw74MBoL0ELVnXg+yGaogPK
X-Gm-Gg: AfdE7cnudimf5Cp2z2yeY787JPrwDnrJUTcPxkWewq4xH+aWPMw17dLdOkHr4FszCOV
	zHlGKwx/eenFiZZqQovW0aL6krK38WcxjKzlBS412/LXm50VcTvzq00B7ndnjQlMbTn3oucxQw3
	Tb0VcLDzhdBBp1KigrgCjs8FoYV/V5cTI47PwJkwFYit3Gi1ln3bWDxawxJxRCSinVoRroubsFG
	h1l3cQy2IAdOfAG4GHkQRE7Pu4+lafDFzAi5g+IST3HA4x/QBsH0aIJfm3ZhY/sqNBzdZ6HaAgm
	y2gtIyKz5rT5KhXl5FdNgS1Ohkbw6HnRiUgJyY5FVkhANiT2gye1TnSeqJVIs2hEPTT74jyoGUq
	6K+wKJOPMmPZoniQztRHOkNwJR8USmqx6pcavp5ugy9DQZHbYCpS35hcclW20+xZKnMX38rQTtC
	zIxsdFra+I7gEMJOm+
X-Received: by 2002:a05:6a20:2444:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3c03e50a96bmr9977640637.28.1783332462454;
        Mon, 06 Jul 2026 03:07:42 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa33asm53276468c88.5.2026.07.06.03.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:07:41 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	paritosh.potukuchi@amd.com
Subject: Re: [PATCH v2 2/2] bonding: reuse neigh_setup from slave neigh_parms
Date: Mon,  6 Jul 2026 10:07:35 +0000
Message-ID: <20260706100735.1852213-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAVpQUChEhWDxVPXOOQQcPMBLNocCACKNiX6AZwy5O-3+wgbtw@mail.gmail.com>
References: <CAAVpQUChEhWDxVPXOOQQcPMBLNocCACKNiX6AZwy5O-3+wgbtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304957-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:paritosh.potukuchi@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F2877105EF

Hi Kuniyuki,

>The real user is qeth_l3_main.c only and it's not compiled
>on 99% host.

>We usually bail out at if (!slave_ops->ndo_neigh_setup),
>which is called after your neigh_parms_lookup_dev(), and
>there is no need to do O(n) traversal.

>With 2K netns, it could incur unnecessary 4K traversal (lo
>+ another dev) for each neigh creation, which is done under
>RTNL or from interrupt context.

>So, it will be a problem.

That makes sense. Thanks for the insight.

>It does not help.  Just populating fields does not change the
>loop detection logic.

True. Just populating fields would not suffice. Do you think
it would a good solution to modify the ndo_neigh_setup 
function?

Currently it takes a (netdev, parms) pair as an argument.

The way the ndo_neigh_setup is being used , both in stacked/
virtual devices and slave devices, is to expose the underlying
netdev's local neigh_setup function, through the parms argument.

There is a TODO in the bond_main.c file that suggests the 
following:

 /* TODO: find another way [1] to implement this.
  * Passing a zeroed structure is fragile,
  * but at least we do not pass garbage.
  *
  * [1] One way would be that ndo_neigh_setup() never touch
  *     struct neigh_parms, but propagate the new neigh_setup()
  *     back to ___neigh_create() / neigh_parms_alloc()
  */

As the TODO suggests, would it be a good idea to modify the 
ndo_neigh_setup function to be able to return the netdev's
local neigh_setup function.
This would solve the problem of passing a dummy parms structure.

typedef int (*neigh_setup_fn_t)(struct neighbour *);

static neigh_setup_fn_t ndo_neigh_setup(struct net_device *dev)
{
    return qeth_l3_neigh_setup_noarp;
}


Though the problem with this approach is that ndo_neigh_setup 
loses the flexibility to modify other fields in the parms 
structure.

What is your opinion on this? 

