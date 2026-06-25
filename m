Return-Path: <netdev+bounces-302061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /VfnBRpwPWqi3AgAu9opvQ
	(envelope-from <netdev+bounces-302061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 20:14:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D86C81F8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 20:14:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YsH+TheN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302061-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302061-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A413304C04E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2F305693;
	Thu, 25 Jun 2026 18:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5E30BF67
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 18:14:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411285; cv=pass; b=dIOJmPoQ0PDGU6OuSxJZ1UVI/ejtVenoudVDe0hTkKyfuC0ApFE/ZG0ldxEvT3qzrVFbmWO41+hZ07G8ar5swSZkQptfrzTMK9qVzVgAP9wXa6e+R6mnXntthw4/2S5dbNczORqZMpTfQV2K6vI2KjbcZrIXIVS01x9nujj1ZoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411285; c=relaxed/simple;
	bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2oFCIdnPi0PZl/jvAqDlLA4q4MJrgqFvEDnk1PFLteNcWQ1PIJ9a2/jmDmC9/URMEF04i2m+Z3I2zNZSFI73EkP4TzKTst1PRjo11IZCvF0QWugV6UzEO2zwjgH/xSxK3N9tqbTIuQYz2zapXbDjiw5L+jdBwn8qByKZ0fNmy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsH+TheN; arc=pass smtp.client-ip=209.85.128.174
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80814edb536so2989897b3.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 11:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782411284; cv=none;
        d=google.com; s=arc-20260327;
        b=XysfCDrnfKXkz4a+hl/g/FTk9aqoILWQshksN0cDazKWr/DxOW3HA6eP9x1vykbiSc
         c4M94wdgwLsf1ZRo/0OoEKLe9m7UX5Jp43Z7ZB/vSyfQXMxO6cg18qAUf5Cy9NvLDmLn
         fenKfIjXeyKtc2TwvitQqcQ1bgIA5YxC29RvcZQkE5UE1cOhWJnebTXksMBQD1o/3fPZ
         7Ez/idd68av7yCsAAJSRPmQfjKw/GS1iOucCS+LgXjP3yGkEtsG5rpBZoPi9Bqzh9lu/
         qzD6mqjXbBJ7R0odljsiw8WMHvqzLTkLQn2SLx4bMEjCe+nAejijJcgzbLcyLupbObby
         t9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
        fh=EjtBA4FHZ7X2kMtX/2NvQbmPWRZ35bu8Umx8rhUo2Io=;
        b=Thl3pD+/wh083pM8aj+iH6DQSFPAJPYkzEAfaPTleTRlR8LGgtRo/UY9ElLslf/jFl
         aNT5Etj5d2F9LDjbKcAdD2jHGIFpbRbVpibJmKCb10Hj/ipFljhNyGk7JTQOeV6vItqy
         D3Jk1ouaJmwNdp79F1eXUMFPp3WCkHqlAkDi/rHZqhXbOa7F+AxUuK7pN9b1pxdgXh7g
         jnDP1Sj7FeUQw96se4DtPLrf0/3/olY4/Aa4XT5PJiNlwKKHyvDsAVslNJ3b1z/Vhsmk
         1iegKxbESLWNR1Q6y+m/mYKDa77Z3KZ+d4nekoLsbKLnuOjr+5dQFzdO4dC82yIoeMu9
         xwCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782411284; x=1783016084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
        b=YsH+TheNLALnL5HxS0Tl3CZNjq8wRWX7pDBCY/7sCkdb2Q/uhULcSAhAv84byNb53R
         WVwpRf8moTZbxckCvWhwAnxbVqU0W9uIWlbqtZKGs1qgA8NYgQq9T9Z7NrK3eRnuFWXQ
         t+/Kh9YgdIqoULm3IC0rR1+AHsE3dAM0Dvkc5Zo4wcwKLH/jDhCk7t59dBUxS4Iq83u/
         CBnsjH2u1JNH3kaAiqIBAG27Q/5YxGnfJiq56oOx1383wwd5rjhbwCHDWW8Pz2BzfT27
         PnACWwqfF+mgA0NKDrz/UT55Yvg+Sjp1zxLype1S7+PeOkKVRMdTxBnF8ccMjZshZ7uo
         0nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411284; x=1783016084;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
        b=nN8K1KVECA1vE6juF0W9YYtcMREzpF7d9FrRzBt/q6DgOJ4V5KObXpJGdpiM5DfVxg
         NE08oRMdLvKiVrQ2/hkbTTmjAiHM1k5rSH3BMcSx8pbRyfnz5bRngYXlTg514O4zcP4y
         mWhzomTfMw7wBsEvWmVu9j9Kfra9CmEFkUq474EHHzLRBVjgUQmZ6607i9aaBWvKR0tw
         MGWhrhnVI7W8C/zB0C/5Pc9i7ckmi1tEaLSx1gKR3MqJFPzTBNDylEQtzxOikq4sLVME
         uhEildWC9hklaeBGwcFcu91HfDZObPXE9wHYC5WpPHXQredUSUYUakbEW0p6cp0nzyxU
         qEPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFWGeCeJNmL4IQbs+MjYJlEEe8/nm/xhgEUo4pjiRl8yygUaC/recPYTjgHhxcaejdUq3Y6JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sYJCieuECTWG4J4pK75RLPPTjQ2rpnJ8ueVpK/UrOpBsXBs7
	CEG7p1wS+yL2KXkNbG1udzoFWJGBu7gitJjRBhQxkK9LV/z31U/krrEFezpYxrL6oK3Hiw2cyo1
	wR+sArTBsJ55rgdNhEQE4ygwheXPZFKY=
X-Gm-Gg: AfdE7cnLmr92PvAGvrHALU75ZmBswlZlgtrtKwaTWjgOIIJBZ9z++6XelbD8GU0g2fl
	KYvXND2EWnSNTkJemO3UOiKTxcSRiKf2IcjtxHT5AjQxolmVaaJUowzOnqdme/CRJl/NxDz5E9N
	JW/xK2XtXLgbCNrOvyE/Wd9OLCzwZqUo8Qr54izsCqMAHSkeWOgxq5Tsle8n2qvqYcjJeoQ0kNE
	6UZbeEWpQVtgirGJMpr9+QynTJyEa1mAytW2YauH+eMZPoCzgd9dv3k4r8UnH8FQXDplep/WA==
X-Received: by 2002:a05:690c:e692:10b0:80a:9ff6:c43 with SMTP id
 00721157ae682-80a9ff61205mr25153867b3.55.1782411283461; Thu, 25 Jun 2026
 11:14:43 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 11:14:42 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 11:14:42 -0700
In-Reply-To: <20260625081916.77a017f3@kernel.org>
References: <20260625142354.2600-1-alhouseenyousef@gmail.com> <20260625081916.77a017f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 11:14:42 -0700
X-Gm-Features: AVVi8CeRpgsX-IM0rJirJ8x3XArWsDsSY-_wBW5Xm7mk9ypUTgRjoBRQZ1o7Vu0
Message-ID: <CAMuQ4bVM83fGeSRCz0hoB65mjSs204VkDbiojDHn+7ui3Z1qEg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix SCTP_RESET_STREAMS stream list length limit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302061-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 805D86C81F8

Hi Jakub,

Understood, sorry for the extra mail. I will avoid reposting
networking patches only to add tags.

Thanks,
Yousef

On Thu, 25 Jun 2026 08:19:16 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 25 Jun 2026 16:23:54 +0200 Yousef Alhouseen wrote:
> > Changes in v2:
> > - Add Fixes and Acked-by tags from Xin Long.
> > - v1: https://lore.kernel.org/r/20260624122213.4052-1-alhouseenyousef@gmail.com
>
> You don't have to repost patches for networking just to add tags :/

