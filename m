Return-Path: <netdev+bounces-260700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOptOopTnmmmUgQAu9opvQ
	(envelope-from <netdev+bounces-260700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7318F8DD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F5B131B3088
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5B242D9B;
	Wed, 25 Feb 2026 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyMRHaDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899071D5ABA
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983187; cv=none; b=iRPxZvwyALJoI/16LM35BAwp2qXLL2ixM0VOouWMK/uPUOjcW4dPOavw2QUgwPFsiIQBjmVlWMcQlJdDMZ0VXxtNpLam/PHpE6CMyFSI1BakT9nT4EGnwLTpijsA84FL4YW0pMd/EeFM8skWMZr4eSVXh4+/9F04NmJg6kgqui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983187; c=relaxed/simple;
	bh=dgCqP1wC3kkVRPwEgnmmTAcXIfkbb3bE5ArT/DmkQOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSt/KJFSb7xTUNTvs4+xIH8kaBSkT/FpFT80tKEikaDsVer4FPiwKg5tJne8iIWHRDD6r1jaUHy6jO2thIF1b5Br0Mwt5t7QdCN2+pFUyafeA1ReRIKn+EZBl49BVAqRHp3u79Zzfr56QC3U41b6TkMPRxTsQj73LIlOEcVAlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyMRHaDq; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdbd13ca01so1153374eec.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771983185; x=1772587985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cl4vTLP8IzKeLoBBF/ybGJIwJxZXmpWJZCht+wjaEF8=;
        b=PyMRHaDqkLeANhAZ5oh9lTDYKt5TTPF6E7r+3CO+xBtRyM9VNHXkSsCszRfmNQw+JH
         5X0kXXZcXIfMxrmoJcBC6woIdB3oyNs/InJDoCj7LW8+HrurgikPAy+AMcV0+tG1PL2R
         wkqyyuNGj5mcYy5nqMjQbfeOWBz6iGADP5PD8grJrD1hVvYwDCy2tXWhK3h9BuhU1GFp
         JakXx1CEO3NJ7YQMzfwDCQgQnMUBVVyc6PsZyfroqTMFVfCZwqVaViWiKs2VawCi8cBw
         alavXHxzEGtqVlBWWNKa+STzmkpMSMXr2GNelSa+JmiyFqCfWuAm6f3M6DA8/u+G5Hus
         cAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983185; x=1772587985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl4vTLP8IzKeLoBBF/ybGJIwJxZXmpWJZCht+wjaEF8=;
        b=tVz1OWP0yALG4FQXd/JYcXaRCasHciSweQ3f3L6+aoR/qkZOI2ooscbAPSZmeiptuV
         s7LgLAEqcIHzPp3vet93jnKs1+I0JMtmYvayUllRVB966gbAGUdQ20t7G5f56t9JhV5X
         PyZTT3ulW7blsP2Q0jYUunaj/vRYwYWjhWDDOK7Vu04UM4gSHqQwPuGE5FxevTI5pYlV
         oBQZKDZqteVdH7VwiYOjf2XWrK2q6hQ8kNc4/4QZIdnrxib3TdoioAr47oT5VDF9d2Bz
         V66Eh0J8uEc7tLJz+9BpDtLFLSxyFuyefDZSdYlk4qWnKi4DJoRlEYLNPog17EryQvbP
         QxdA==
X-Gm-Message-State: AOJu0YzDoR3rNS2BWVqvNx6T/QxRUC9Dorb/WxcHh4S/vlj4UfvFveAm
	9BHDsuLaiCARMKDd+a/Krrpp2yPAoWS1eIi6E1t6h+mD7GK/9UY9dTs=
X-Gm-Gg: ATEYQzznCN/fkjRcn120DIhM41o3P037TtfLQcICxwF7GUucR84ifZyYLaEvysh+OyF
	f+KB/laTpS4T3fDaimWS6jw+RfZDBhA7hByLp/X4KzyPVhSpdtl/Y+b6RjE6NvStUw1iJ6F6SAE
	76o//dR8txLiPcl+zdEPevegwM2NE84rMvh574GFUKNQq7gJGlV6Ud1CTTqlb/9woPRKrOkZY8+
	IlXySFN+4kuuE2QV+4qL7wnigB3oxBBzOUzL48V3VISOBtXRdEXZI1YMTOoOF5vpimmrFxNJqBP
	oizMXZPTKls7UtwOAQ9klgeUKVZbz31h5fRJPabFcx+BHg8M0ftwBg/b1qBwIltLIxPy+S4JH03
	UnBKG4ALkPxpW6GJM2r4+U3sCxEZlr5YMzLci8PMCgCH7YiK9ZID0vhWG4oExVVd5H5dnQtOUNc
	lc7zUxdzuqfn5PGtlU7LdOmPwMFItQx4B5WMB0RFeN7/L+zGrUrEcLr2GBdzCHbvNQ4iczqipB+
	lgYqfDRlhAOqGQVnA==
X-Received: by 2002:a05:7301:1286:b0:2b8:261a:fbdf with SMTP id 5a478bee46e88-2bdc352ec32mr239553eec.39.1771983185326;
        Tue, 24 Feb 2026 17:33:05 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdc412c8aasm210660eec.25.2026.02.24.17.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 17:33:04 -0800 (PST)
Date: Tue, 24 Feb 2026 17:33:04 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, jiri@resnulli.us,
	andrew+netdev@lunn.ch, penguin-kernel@i-love.sakura.ne.jp
Subject: Re: [PATCH net v3 0/2] team: Fix reference count leak when changing
 port netns
Message-ID: <aZ5RUG7DzE--oZ9e@mini-arch>
References: <20260224125709.317574-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224125709.317574-1-idosch@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260700-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67A7318F8DD
X-Rspamd-Action: no action

On 02/24, Ido Schimmel wrote:
> Patch #1 fixes a reference count leak that was reported by syzkaller.
> The leak happens when a net device that is member in a team is changing
> netns. The fix is to align the team driver with the bond driver and have
> it suppress NETDEV_CHANGEMTU events for a net device that is being
> unregistered.
> 
> Without this change, the NETDEV_CHANGEMTU event causes inetdev_event()
> to recreate an inet device for this net device in its original netns,
> after it was previously destroyed upon NETDEV_UNREGISTER. Later on, when
> inetdev_event() receives a NETDEV_REGISTER event for this net device in
> the new nents, it simply leaks the reference:
> 
> case NETDEV_REGISTER:
>         pr_debug("%s: bug\n", __func__);
>         RCU_INIT_POINTER(dev->ip_ptr, NULL);
>         break;
> 
> addrconf_notify() handles this differently and reuses the existing inet6
> device if one exists when a NETDEV_REGISTER event is received. This
> creates a different problem where it is possible for a net device to
> reference an inet6 device that was created in a previous netns.
> 
> A more generic fix that we can try in net-next is to revert the changes
> in the bond and team drivers and instead have IPv4 and IPv6 destroy and
> recreate an inet device if one already exists upon NETDEV_REGISTER.
> 
> Patch #2 adds a selftest that passes with the fix and hangs without it.
> 
> v3:
>   - Add a selftest.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks!

