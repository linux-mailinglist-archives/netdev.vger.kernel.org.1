Return-Path: <netdev+bounces-304477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ji7IAaaGR2p1aAAAu9opvQ
	(envelope-from <netdev+bounces-304477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:53:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491D700D85
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JZViriTK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304477-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304477-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303C9300C03F
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9E39BFF2;
	Fri,  3 Jul 2026 09:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5338645E
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:47:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072065; cv=none; b=J6eVoFvibvvlq+Bn3s998NCZ64kfcWn96eZzCG2CsJ+RDMitVXC7lEn3rjJrNzYTGMe8p7EMOqCLP2ubLqjHQTzd7RJT8ipax2Zwc2f46/6uQ+tY5aWvfVWmv1x3V8X4P7LYmJvB0mTvMNOufDIwYgcLt/MxKEiwzfB3t//3/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072065; c=relaxed/simple;
	bh=lNI0jkzgU10bEMmAwWSpjMSI1ZyKMy71h/uww2cMwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DE56TV8Zs3XIjPm7BuLck0CMdwmHPCi5v2Lyz8e/Z9tS9f4KoMf1P/YwEwqP3ng/QJUgmB8vlCdkMu0T3PKW83DHXX1twCEnlY0YX8wadUE7iBSJlIrLCjqObMa8XctyyNgQQWGcGl+J6QQrst+8QIgjTb6G4EYD7+Hzg9lqJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZViriTK; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ca11143dbbso3060895ad.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 02:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783072063; x=1783676863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQfDcSW0vZstOnFMmpjYEhp/0jcqHENe0+2Wtgs9t1Y=;
        b=JZViriTKHE1KkgjJW7DY2XhwMtvtUJ9d/n9T8ng+4VsLf13YExnLlij+cLBBMdvfFR
         AHCThILIrQR065C9+yvs6DyklerssSF0WUBN2K7u2vXKJp6CFxn/znP0QpJpCaRC8QIm
         92eYo1FguPKuqlgn1vEgbibsV5I1BYzdnxI0kD+PRKPapKfQo0Mov/OfuKrvgC+KkFfe
         Bb4Uv6fwbjzkZBCbWWmTBuhpopeL9m3lBhH4OLyaIKO8Y2BDhQ9BCmxxW4V8MbZ1cKIz
         fkN6IDCxYbsHefAYD1kOnTTly2JQ5EQeillVknGe+Uc6kj1HR7SKWG6JBN7cOj6CnEe/
         RsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783072063; x=1783676863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQfDcSW0vZstOnFMmpjYEhp/0jcqHENe0+2Wtgs9t1Y=;
        b=ZBsy+m9DpKahCzfix5wNoWJowz+y5s/xZSugoWHuEz7sB7GG8Yfsdag4D/N+HWh9ot
         yXtQyOkMGw2Lkc0dCVlrBfjb3OgfhNgPg5Mk8RE+d5kLpcUJQlJvPdI2cX8eJBlhJC5v
         2B/P/1khGqFdr1AAEDCBzbDgsGbE/Qp9+1RRCiz3tiaz0Ba91GR4DWW4g3N8hsXzgAAw
         htZAagfpYXoqc7+8pUd3Kl18hc/a4rKQRk5S0aj966qQFBvNyRZiOvaChS3tug0L06cG
         mZLx5yVNDn3sMgyo57sQbpUuRL8DqDWK0kzItnnV8fYKwjkqNy5nXkYRPAb6VR0oU+4s
         eRNg==
X-Gm-Message-State: AOJu0YzXdEFIVmJaXDewc72I6V6TSvuLdtvCKkO9j+QXjWRdowaMHBCA
	czVUVBTialnU240HSNuE0YUCzgz79as+4fRqXO99E+WzaGQIOUpTgmwu
X-Gm-Gg: AfdE7cmANCHXCiZb/lKZRapkQvnBjnKGKBKvCL3W0UyNM/YuCy3rb91wg/aKFlyt2Rr
	+MPDsTDMxueHjOqZSzL9vLCpYOaP9Wx99vBcfavLXrYdT6Di9TM2gqezODRYssJh5WDe1dciqQq
	PLQdRmwXr7sri8kdVthDAr3GvGI8euntiuwG68/zdDF+gcwH60yhO+dcI6KDVLpIYoLJ64y59KX
	3SF5FAcvIQ2PaoepochCtme0xeq2rdgoF2kC5PId9UVOnWiSpGAjhu/Pa5y2avIRGLlh8QpSGZL
	hgZoVeYeP6mdsA53gTNyqhyHtrNroDE3fMs5ZxVN19E6UvBUhtftKJaYBnx3AxO1vWEnWxCk+P7
	v+IUk3m8bZTTPYIBzVmPH9hbnxGBdmEe6mQqScgoeRJR1SYLLcITBl2Jr4mT+SHESDr3UHu2PW/
	moy6k2pMkAr9pVJMNk
X-Received: by 2002:a17:902:ebca:b0:2c8:1f56:9fc5 with SMTP id d9443c01a7336-2ca7e8faf17mr115363295ad.35.1783072062755;
        Fri, 03 Jul 2026 02:47:42 -0700 (PDT)
Received: from amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm19586606c88.8.2026.07.03.02.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 02:47:42 -0700 (PDT)
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
X-Google-Original-From: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
To: kuniyu@google.com
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
Date: Fri,  3 Jul 2026 09:47:35 +0000
Message-ID: <20260703094735.678916-1-paritosh.potukuchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703064109.1836070-1-kuniyu@google.com>
References: <20260703064109.1836070-1-kuniyu@google.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:paritosh.potukuchi@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paritoshpotukuchi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7491D700D85

Hi Kuniyuki,

>This introduces O(n) list traversal while it can be done
>with fixed costs (3 dereferences + 1 call).

>Since neigh_table is global (arp_tbl or nd_tbl), the O(n)
>list traversal could take longer and rather de-optimise.

Yes, that is true. One reason why I chose to do that is
because ndo_neigh_setup is a function primarily meant 
to setup the neigh_parms structure, when neigh_parms does
not exist.
On the other hand, lookup_neigh_parms is meant
to search for a near-complete neigh_parms structure,
that is already associated with a netdev. 
Even if we want to use ndo_neigh_setup, since it takes
less time, I would suggest using it as a fallback to 
not finding an already existing parms, setup.

Moreover, time complexity might not be an issue in this
path since, this is rarely used aggresively. 


One issue with ndo_neigh_setup in bond-like devices is
that, to get the underlying netdevs neigh_setup function,
it expects us to pass a dummy neigh_parms structure that 
has been zeroed out. This seems to be fragile as suggested
in a TODO in bond_neigh_init(). 
Generally its main goal is to fill the parms.neigh_setup 
field.

Can we populate a few more fields in the zeroed-
out parms structure, before passing to the driver in 
ndo_neigh_setup? That seems to be a much safer approach.

Regards,
Paritosh


