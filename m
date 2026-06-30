Return-Path: <netdev+bounces-303320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8yzuHCwJRGo4ngoAu9opvQ
	(envelope-from <netdev+bounces-303320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB3A6E729B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JWSEllub;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303320-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303320-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4B6A3058119
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE346AEFB;
	Tue, 30 Jun 2026 18:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA43F5BEC
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843669; cv=none; b=sNHlEVsUmLe7Dwk5RpkGTwD+UqGmx86RI4qUanlw6KRUVH3Xe3ckUZSO9PdcQ/XyvsNTwzWM9yS/TRoChuVayYdEmXMSiGhh1I3eqhs9icgT6VUQ7IjWrl3cDKM1207MVcXpPKhkpJnOHgFfv/sQUEaxopWZNvvzW3CtdOPMBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843669; c=relaxed/simple;
	bh=S+bs5YY8NX9MFni5ePZnk3auDFAdp7FktKQwrUCbjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMpK5ygAmrmfcWDpev0gUNB7ikOYqPfSPPNFWudFqp4CZiqAnBgNjTPO2xHjHYUICPtK+THpNuZ5G5skptR01tDmKtiqeSi/Bdagnr+CDlDqIEzvOaGhYLYMG7fqYc5+6hQ73tM2PuL4M4DLxnq3B4HW5SVY1p+qU9Mai2feXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWSEllub; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2c825308c4cso3392965ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843667; x=1783448467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moTdohrP+sT6ghuoSBO6hBwLx93Lg4139OZjTwnLapA=;
        b=JWSEllub/oy0geh1hNIMvNZxLHNkAdSvzdKjzioSVyU8h3ZxU5iUx2JZlqDCbZRA2T
         wcHHuUsDnGb/BcEqwqxVB6hUYkohbSGwGUCvGIaVx3Y8OA84SRyRwmNqJfE2157DqHdD
         0Kkbzo7lEpcOTObenhEND3Bhgo9mxvvYF0xad42yLVs1PBNg6Y0qcLUOi2VGABST724a
         2fl0iF/pIZNcBMNzu+CSKiSAkEd6s9zgVOpkHnJXqHc+DQi+6coP8wA5xxNHoavnweK6
         CY/J6r6q85EduTGZmbub5jMni7zUuQw5q2XUurGkgLWoCrPI+zrWSVowQb9SgIq9tnsg
         XKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843667; x=1783448467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moTdohrP+sT6ghuoSBO6hBwLx93Lg4139OZjTwnLapA=;
        b=ZgGHhqhbwoXxbXV0m9zceTtuRFizNnpvdM2q8pTDNPti5fDtD9lbk7gRZSkikrDCbO
         JlRwY/nfuI6QioL5GUl89JVZBXnoT+oIxHYuxdRmzfDQNQWQ+OTNS9yUIevtti7kpprl
         SQf7JUJiNScE5VkVvoxXldQ3A0uCl/z15Yr8FjNpmpC+p1RTdmskIWmKMYXaVIAFEwvg
         Kvi5yemNsq9xRS6rZGSsdwJ/AApWwSUzSBK6H8hQTPDX15IqNEYkh6y3N3r7KsrCQGah
         btPOh0k252CI47VidPfijAj1NymYBJbxfyuno6Gf6PqaHn+ceKGe8VrU3KCPEzJZ4q1B
         +8kg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Y+PjjLlFoDfd/lVJ7oGE7rhweZtJ+BMv9gkyQRFNnaxAXTzYHKIPGq6hbmhoP17j16nUaJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHuERukiK9HrYNow3U1sM7nR4H5oPCcYwNFLSiXp/2BCm0lQA
	rylYTSiaizxmLvsqYT4c6WR7+9XxG+0xsBC9tvaneWIHjfLY3Gi1N9aN
X-Gm-Gg: AfdE7ckY5PWGKi0m5cNSeDdBMgQtI26KoFiqsiN+WMSGZJzoY1ZtKPHsugky+eLxtFl
	EUIad24JGFm616GEtIdgRRkTcvI8ra9AcOv1W9DcobFG03ZOiPjKNDg7ifGZiY1WmQ9BNQSRqC+
	IybVDxW6bOh99v18TVj3s0kbjV9hxyeOWyx0Jg3kcDThK1dELGZuuW8d1HPa92A3MeqCvxzj9a6
	JEAGbQTnz8yZk1rusJX0Nbj0pIxkhaq0HCb/pZ+bFT1ixgjxiyWKwFGvK50+fmogmFocjbX6Al6
	CHveXml6Pw8TkEpUglEgmv568bb5relstS65dfA95DXjgyNfYNTVwo96HMp6LHceRZ1l1v2jfkT
	itQnY7foMKSp7ncL93z1eeD+t2XAuQKLU4WYejMS5lnnkfcunlkX6lXYVr+8zzLM1v9l5gauqAJ
	TT+b/PS4n9gV8V8F1V
X-Received: by 2002:a17:902:cece:b0:2c6:beeb:d7db with SMTP id d9443c01a7336-2ca2d55fb55mr39847525ad.16.1782843667531;
        Tue, 30 Jun 2026 11:21:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a71053sm19735655ad.8.2026.06.30.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:07 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:20:39 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/4] ipv4: raw: convert do_raw_getsockopt to
 sockopt_t
Message-ID: <akQI8dwSsRcok272@devvm7509.cco0.facebook.com>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-3-193335f3d4d1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630-getsockopt_phase2-v2-3-193335f3d4d1@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303320-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fomichev.me:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BB3A6E729B

On 06/30, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the sockopt_t
> interface, switching do_raw_getsockopt() and its raw_geticmpfilter()
> helper to take a sockopt_t.
> 
> The thin raw_getsockopt() wrapper keeps its __user signature for now: it
> builds a user-backed sockopt_t with sockopt_init_user(), calls the helper,
> and writes the returned length back to optlen. The helper uses
> copy_to_iter() instead of copy_to_user(). No functional change.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

