Return-Path: <netdev+bounces-305899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mlueAemCTmrVOAIAu9opvQ
	(envelope-from <netdev+bounces-305899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:03:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE5728FE2
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:03:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pvr+HOy3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305899-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305899-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D95307E5A1
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38843713B;
	Wed,  8 Jul 2026 16:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4D438025
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529644; cv=none; b=OsglbrysdoLHa9MEP/WIZBk2IePDbhqky9ufQyBuQQ6FGia6G7kZ+tDHvEjAR95CjYOGCfodSzevBqhC36U4t/FEugdLKQAEPSMLOq5S2WKpbI51Ud2z1to8xMb2uGZ8UWg5CccmSO1I+A4WKQ2GQAZQSNI/boa3NtMbMyosUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529644; c=relaxed/simple;
	bh=xCYFMAjgPJDY/t9Mmqrv/XueFYFlFyqzJG0g30NW4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkEqPiRg0X4/UEyfTsEhYzokMpuHtXqhUentDuC76yWf3tUIYIGI7pZtz1uWTOKnJoJjhwNjbjhzTikNaUhju8fOLgmWm3NvOACwJYTz6lv2QwPaaEzK+fWTsREJadPhz5rSVUfBdz9XysPHtBDVyOVeD2GaemdN+fuJ/4k00Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvr+HOy3; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf4496889so524055ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783529642; x=1784134442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCYFMAjgPJDY/t9Mmqrv/XueFYFlFyqzJG0g30NW4Ck=;
        b=pvr+HOy33mjsK7v89RXUXWxlpIQ5FhE0wnFMAHBM4gw0aEw1KKwpLl5Eij5Bw3Eh6b
         zYjHolr/4XtPoK69NUHWRDJCkg7+9N2Ed27zhz+w1ZQ/2KY6AKNzTRqQx5lccCYcXQUF
         37muZV/C5Cu9K/6RkBT0vj6Dz3Lqzeb/jZWB+w50/ec+Duzbvu4H1XmwG6iPELIcEJW4
         3RFYcZhdmlFEOWETaoNZaCLPXG4iRL/cKS4Yn+HqwnJA0CUX7dh2FsjlsmWOFZeWfrI3
         DegO/Xnna0z2GR3GTrbaFd6G0qN132PDoAypk7fFzVfob55btihvnuHiL0PzlTwiNmLI
         Jx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783529642; x=1784134442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCYFMAjgPJDY/t9Mmqrv/XueFYFlFyqzJG0g30NW4Ck=;
        b=V5NMCgbqXjtdy5aoV+4Eb1kZ6IIjDi+VNRDzVZ8MOk7n7bXQVzg/JpOz4yeP8q/PWC
         tdIs6Qgr9b6DRehAk+dXqwGKTOfEXvYU00OcBvcIM2CbMoehZ1M1aBewEVigTFEXDsow
         Ioi7Csr4g2uyhmUSeZKiTAa8lMDl5f7zrcwQCaGO6DEadKACF0ssuig0f+i4PgXnw2L+
         LgrKB+JF01ZVXTkSZciFeG0Rle1gMQu/hubk0OMLxgN7jrqV6kCpMC7MLkwnARNEouQo
         vt3qsMdpIulqbZ+owpF5JyWe4Doq2zR8WxYrAk7oE+tlDSTzk1kOhRkwm2/+AzA479kl
         3sqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjkgNcVgKDSJDRUut5mgnVtQj/owE+dSe9F9e2afMQr7el/dsKeU1Wjug19kPfuxaYsHRV6PE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8eh0bVHhD2xRvCzEY6mTAyZipNF5U3h4C4UPWBrv9ZP0/Jqk
	ReL2xWxy24Wobn67qv8ZxaCax2ZVlxcjN8JnNdNAoVBGSy4lCpc1WaVX
X-Gm-Gg: AfdE7cmO+LDDvXjBO+4oh92ePhR7KWmqUPRv7m/SXGs22YjBzBptCkORs6bkS7+SLb8
	wmU1Vryc4UGec4GmM4rRGb8hqMTou9Vkn8mgmgyBOwiXLLuPs2ejfrHjwpslCeF5AhAxc5wLUTO
	eNOvFzCYuHAzaTDiLd6nEnIqE3Z1VKymf5XBnv2rZyCFuyQcOnqMohrS/7r9hvAYNAbBPBfp3dh
	Aah9nNQQqW2CKBPwGZZpaOdPz6KHIeuR9M/Z/MWIMdqLIo3NM1PdbkTXZ4CgMCnOOaZfF0BwMqI
	FB6/1nmIGI74FIgfimY887SlGmNUHdsAnFfcxxocQJ0V6PaJDFMdZhpRIg/DvjFl0fGzDJL5V8q
	gja6qJysSAUtUQn62twlxRBvrKuAmWFzaxh2H7IljqtWugrWhUcHN7xBldBQFy6Kk2++F2rmEfj
	sGUw61yzQFPwfV4BGGo2xMXvBF7+NFvA==
X-Received: by 2002:a17:903:1b66:b0:2cc:86d6:24cc with SMTP id d9443c01a7336-2cce9f79426mr39826815ad.4.1783529642147;
        Wed, 08 Jul 2026 09:54:02 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bcc0sm30747565ad.67.2026.07.08.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:54:01 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: vadim.fedorenko@linux.dev
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jmaloy@redhat.com,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Wed,  8 Jul 2026 12:53:57 -0400
Message-ID: <20260708165357.1080-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <04feb35c-ab30-4a12-ae19-a160b451c14a@linux.dev>
References: <04feb35c-ab30-4a12-ae19-a160b451c14a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:AutonomousCodeSecurity@microsoft.com,m:blbllhy@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:jmaloy@redhat.com,m:kuba@kernel.org,m:kys@microsoft.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:tgopinath@linux.microsoft.com,m:tipc-discussion@lists.sourceforge.net,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[microsoft.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.microsoft.com,lists.sourceforge.net];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ABE5728FE2

Thanks for the suggestion. I'll use NLA_POLICY_MAX(NLA_U32, U16_MAX)
in tipc_nl_prop_policy and drop the manual upper bound checks in v3.

