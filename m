Return-Path: <netdev+bounces-271285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDErMLXywmnCnQQAu9opvQ
	(envelope-from <netdev+bounces-271285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:23:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1CC31C459
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BF743015A62
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96B34BA28;
	Tue, 24 Mar 2026 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ompKiEpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8C34B1B4
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383794; cv=none; b=UOQKKZeUi0bnB0jjLYRBU/JIHgW/TJJAOb+SyLIPcMiXR3D1PvlRZR6+JUHGiXIB8SVwkOE8QCIwEwGx8guaLw/mOF+GdF843jODID+PgCPHtv2VBT8oJRi2weineppOD5M4/j7zsQxtdmYm7PwsdeytpBDNQafE2Nc7p8NqbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383794; c=relaxed/simple;
	bh=2dmmNNaIIVMuKjl7hj+yptm3i2eKLfkeRwkuuz4ebes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QCjQuVkot7jZp0Uc4XRoqEp+G3D7BHksAnOMQMZqr3lpAISvgqSxA+n0/FAoFn17f0/zIOG2mrWl8QydFrZPTx3dYp8SUmhi7kDKY9JmNniY/FCIqokWWaY3JzAw6Im/PW6OPestawwE3V4JLoO2NSP6PZo+3WJmM3i++N5aNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ompKiEpP; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso3307101c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383793; x=1774988593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2dmmNNaIIVMuKjl7hj+yptm3i2eKLfkeRwkuuz4ebes=;
        b=ompKiEpPtSkWBZUVc3lgQhtHiARgVIKXT45rjAajpv+sGJ46OVDcjvdxiuKq7OD1V+
         gcuclAsQwe/jtI4DZOf2Fualdz7h2H5BxdevcUOxSX1RZ/8CnXzf7J/XnOPPDADhLeJ1
         PmF7R/VgpTeR26YLypEFmG/BlbQ6OFDRkxPflrVOBVeYAZeysXMis0LhTXeodJ9j6QlK
         DoXVU96lmJ0YywOx7Yx49DrRwFIsjNwnolkuIescoR0p2TsD4gF7okZIBUTToYWg20ui
         HSKiEoSMj6fDGwyUqBKXg4tP2/tVz7QlejO8dMjaj4Rc/OUo9f/Ce86KNodMwU24x5vT
         fIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383793; x=1774988593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dmmNNaIIVMuKjl7hj+yptm3i2eKLfkeRwkuuz4ebes=;
        b=fRe8j+mjILinwhI9M7nddgpGi0LQF5VYLecpXaR4By3pVTiHMyp2SGdr6u5ud9CoAX
         IM9NdaZXIsHCMGmssCk9/HIxj2/DthJk3i13eLg1/gyqDy02yAvV05YLDDD2czNURTUO
         +cMNig4LHxLZqXRdgF/4vxQutl7R9kE/Y7YMzMo566nehXWy82oQchq+9lr4iT0GQLrP
         D+t8UuNTRum2vp7qpUngp5cE0u01zuOyWJUuCswL5vYAQ4dO1OH3/kqcn7Phkdxo1GP9
         bcvzRYWui4/dBBuPJnEWtW/mJ5ZD8KKHj05tEzq7dV0hN/JKFblsZwmKQaBafrcucCOC
         poyg==
X-Forwarded-Encrypted: i=1; AJvYcCWSnhE7wz18Rn/NYwtgaVpvSyuzmLs+oHjIvO+cdlht4wurbsXnhn9RhDHWDGPmMZuL7og8g/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOMdrVdxnDLF4jvdX+hlwmab/zQMj8yNHcCHTgojUKLs/KcXZ
	yR51IqXifR7E6mqP16tVqFRMr3AEXtm1Qrj8g9DFQ+/VyrTb5gbwhjr3oDdQFA1e
X-Gm-Gg: ATEYQzwbXgTo0LInALur6PLuET05iW/OYmylQKcTnhE9ZzKCru8UuEaTmXxW961f7Dg
	2vRoGtaDk4xojsTK4QnHOr40XuMJNkY/m2X5+4ABIOIu2htY/ZUjQNmzGuMM+QlAuS9wNm9oDkX
	U//cKtZRKxlZLYLb5saMOkgPv6InuVkZ6wc+0FM47OBjRoCChFw/RlLll56h8lKjPSOYKdtbns7
	yU+nGMa85wClePlcu3Rv9O8M3UhFX9wE78fzTZQomOxeoOl6uT1PFlNDZ3YBklNhQSCmBfn7Qkw
	LzgvEH9szL2WDk/cy2kx1h/kJEtMe2nxTDyeM44pkn0fz46ENCqyOq03NKM9EgRFmKoxEQUgDTV
	EXmobbzUuXe/LUfpOFULQjLvDUSAHDJ/mnqDxej5Mp4IIEvvfI+Qdsj4ABQ8LufrpLKp2Gc6In0
	X8LCv3f3oO7zBdulef1OSfkIKif/Ek1DhOCxYtybnYeF+sZkjphlr/68psZmrU7DzzgSTRKjgWz
	Cjf0w==
X-Received: by 2002:a05:7022:fa1:b0:12a:6c84:6054 with SMTP id a92af1059eb24-12a96eef696mr416917c88.35.1774383792478;
        Tue, 24 Mar 2026 13:23:12 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a73407854sm12144574c88.8.2026.03.24.13.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:23:11 -0700 (PDT)
Message-ID: <88472b1d785ef41441bf82f362a0afd96b6ce4b1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Add trampolines single
 and multi-level pointer params test coverage
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, 	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-open-source@crowdstrike.com
Date: Tue, 24 Mar 2026 13:23:09 -0700
In-Reply-To: <20260314082127.7939-3-slava.imameev@crowdstrike.com>
References: <20260314082127.7939-1-slava.imameev@crowdstrike.com>
	 <20260314082127.7939-3-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	TAGGED_FROM(0.00)[bounces-271285-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5E1CC31C459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-14 at 19:21 +1100, Slava Imameev wrote:
> Add single and multi-level pointer parameters and return value test
> coverage for BPF trampolines. Includes verifier tests for single and
> multi-level pointers. The tests check verifier logs for pointers
> inferred as scalar() type.
>=20
> Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

