Return-Path: <netdev+bounces-256554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPufAhzDgmkpaAMAu9opvQ
	(envelope-from <netdev+bounces-256554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B4E1698
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DCE330095C0
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179002E3360;
	Wed,  4 Feb 2026 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj9cbkjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACE2DEA62
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177303; cv=pass; b=hHgk6HRFQ1M/e6r2+jeALV8+aUYljeUwo4D8zbS/txrqYmVo+sJxEjacEeQ9tgWdKq3R18VX6nAS+dPTcQADa79wyiXeoIWe4ro5xkQxrPL74ULETyjAUjjIwqCfUj+11cPhtaPVwFYTicX7QymUm+WI32EFqF1x746cspkQy0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177303; c=relaxed/simple;
	bh=kS0Oli6V6cUzrhctF1oQaBfXCSq/fvWfEyah3MHaBPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUqJhrhfQWvqzlPXxITQBxKK/Tx7E8t/9nWE9ZPHSDGcu9JTYNm8Y9kmuuR+xh/p2PVY5G5ewH4qdAmwIfPD2dM570OCS2s2da2F+/DntdMuv8YZvVJzCo0Z/jeI5yuwiC67pvQ+KYgAPzCEjjJyhRaTsZzTi9GLNIgBsuM2LyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj9cbkjJ; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894770e34afso84612446d6.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 19:55:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770177301; cv=none;
        d=google.com; s=arc-20240605;
        b=Yr2ft4DJlV86fsHF6jwAQpMtd1QrFlN+cULi0kFto+8pNzxaYoyqT+eJ8MHChzmY6H
         B/mLqbY23IbbjaJHX2leYar7lTSg3l0xvaN+kdLPmC3Kppim20hLDIg0mT2lcGbwmVUm
         dYGUbRmi5Pn/eWkniVR3CDNvaaFjGtEJOuDEAOJDjRVemIXIbUZtU7dmonwO2VnBPwvo
         WX/OMnW3cn5YKoUf+6tmlJcWIhRo5qnTPTh9NraNJgu9v5SlyA3/k2qab2rL/PgbQjHH
         qbNsLVgXeZmv+XnRKZXROwW1pH+dqdV73Xvf04Epz1HefZVrPTCIhkzaBjHyk6YtVYIo
         FUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kS0Oli6V6cUzrhctF1oQaBfXCSq/fvWfEyah3MHaBPw=;
        fh=xskluAOqaexXSQYpB/9qhJBdtThl+8DNrlSVhsnHKrk=;
        b=VmT1eIT+30hf/aJOGwx7yvGKtXrvhyYSnb2FmbUaVa4rt4SLXLooldfWCX9NPMz29t
         NLd3PVI1CZKL9vGOiCsp0Ovmev54xr2dooz5Wt5LL4Q3GDzPo3Mr7AXi+5Th4C0Knyd6
         8eA35VpUw9+T47SCjiGsSUoz0C87PeXZ286zzLKRh5wIoaje3JIgme5vqdrvzYY108r7
         0Gt3H8ylS7EYxYWNnHBqpsXON4W4w6msUjKQd1vZgIORGkQT3WmBAXEVmnoMDrV2X0x0
         vShuLR19xVgIPfFjSsa6nsdwWqTSDwCLWOMQu0ELDEEIiG39iF9TS8G6xwtdhmF1fejF
         zPtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770177301; x=1770782101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kS0Oli6V6cUzrhctF1oQaBfXCSq/fvWfEyah3MHaBPw=;
        b=fj9cbkjJGuRJHrkHUYB2JXOEN7CKtD3kQS5u0lIZU3jOE5CnA5Q64gsMfKGADxLoVr
         c72GqEhkBxzAmOb9GmBvQhazwXjLZoaVGRdVj6EtH6uJ31nQra4Xp3I1Wy2KTc5dYCdL
         9l2I0o+49ExcxdUBKLeC5nvbh8SP449k+PdYdc3Baknvlt7tbg02WssiVbbyeGlwfsD8
         yHFLZk714DnFSoTWbfWMmL8y7L7V2f2ayUYDhAj36MRYrduViZSzCH24vXTeWkLTuzFM
         oIqA2lXhHHZ/sKflQ7qzHcljL8U2X3oBSEFeMIswLihlaLjABrXfIGekO1NbMR7RD7ee
         7NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770177301; x=1770782101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS0Oli6V6cUzrhctF1oQaBfXCSq/fvWfEyah3MHaBPw=;
        b=l3D4rqTfALb5Aa8ybrUNlo6tNfYLjEedmBwuFsMCh+G4uwOaSghKuLuivqeZtaS+aX
         7MuaaTbupbJa+d9V852HVniUWUNfGAjRX94wkqNQgVBTtFt2W7oM73le5PlOpgxB1S6p
         niIGmL8LQ3nqRWWif7yKiL35IfHDq17MvEoORbDDLRzrh1jWBOXF2zhPndyd8B9t++ym
         /sp3FYyMugP45NoIdNyZZ3G0Ny/FHwulccMhJnUS3UCSaryxF7tn8KdO4wBEpGy6B1Wa
         3Il9XvHD5zGGDkCahLdCorM0CbHmtNryMpD9sZMyAg37CV3LhAJSOLl/4WXlAmkMvp3z
         ztKA==
X-Forwarded-Encrypted: i=1; AJvYcCXt0B7+KVuht4ouO3/TwzXpAKcnPvZvdq5juggSCr7AOx99UBmFtDAg7yCzUG0kmF+tjbYAOy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcPru2XLBZ5FRhl4yOurUzksyl3PP6x3v3vE3AvKn2OvXnzPQ
	2h1zm+2lPbOFwJKsfT+Za5AvSSU8QE/15t78lUhGtO6CnHg8ewxO+GEGMFy0t1KuJ9EH7Y89Xgg
	mKxrJfbAjMjAeHej8/e3+f2dQnHo70U8=
X-Gm-Gg: AZuq6aIAffeXjZyxve514ec2fq+LqtErjsdCmpAtXOL2mAsT6JRHfP91RcaXOwLtaD2
	269IZgbbgtjmXECDK2UV8QDNBlL50u5Mw0U5dYCLyNLoAbpJRUM+jck58HnAyTdobUQVhyA6XBx
	70A7vtX6MiKK38tr8Am1sYCCIOEo+jEvu7kwL90SA+1zMWPfyaKNhXRMB7A/SJWxAdFKd7LDa51
	YQ8w3s16Il5co8ICqpbe/Rg1ckjFMATZfG3dhYrHZKzRLhrK26UxFzHzDd77x7dPCGfHqbGnmf8
	IhrPUlt7BqJbf63Xwuapx6k8iBnX6lQ5T4Q3w4HvF3oOao+jiT5uogzp
X-Received: by 2002:a05:6214:29c2:b0:895:479:b3ca with SMTP id
 6a1803df08f44-895220ff3d7mr28476556d6.15.1770177300786; Tue, 03 Feb 2026
 19:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203013924.28582-1-enelsonmoore@gmail.com>
 <20260203194317.07432b29@kernel.org> <20260203194447.0ce4ffd7@kernel.org>
 <CADkSEUgoOyeUqGHXqimczdo1M0S6C20GOpKH5OuEeaRhFnSTDA@mail.gmail.com> <20260203195415.7e462c91@kernel.org>
In-Reply-To: <20260203195415.7e462c91@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Feb 2026 19:54:50 -0800
X-Gm-Features: AZwV_Qgeck6aZFFNgYLuZOdGhs5NISn3xSogSNFre2bhhidkcKkgC32ijOyXh5Q
Message-ID: <CADkSEUj3QCjdGRXue7v+TO27cyKSsHXse8TJ5egc0BPiPwr_Cw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Eric Biggers <ebiggers@google.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Peter Korsgaard <peter@korsgaard.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256554-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 296B4E1698
X-Rspamd-Action: no action

> It's not a big deal, applied thanks!
You're welcome!

Ethan

