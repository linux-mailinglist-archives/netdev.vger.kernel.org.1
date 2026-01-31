Return-Path: <netdev+bounces-255377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BnV4DJyjfWkETAIAu9opvQ
	(envelope-from <netdev+bounces-255377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:39:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C0C0FA6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A14300BDA6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC52D481F;
	Sat, 31 Jan 2026 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbm/Gz64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95AD27E
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769841561; cv=pass; b=WFg8vRZGh9XEoDfmh33gZH4mAavHy9Kiq94IDSQx88aJTTfd2NVaRYyRLYJ+8RNl3i4FvdqbnGjZSgLXF3zL6L+9ZzkFuGBHwnwX2owMLN2+pdRyu36f6jAQ8tcnDmPfWnrbN9OaJPj0JlJTiWOQ6ruPsZeA0OpGm5GuKqyusAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769841561; c=relaxed/simple;
	bh=MabdoBqgkhimaQ3wX29SwGCw0efrDRj6VQFNnRTcRYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzz/Ply4QzmP/afHip2BrKMULpTMTv7SJZ2efcehU+0yr7y3EEe52BOUXq1oGLS/IBx6sAYLH+PuvGXT8QxO09KKV5FIwlcX6Dz/6O6RpblVjt2XphdlNMJ3NbbaI6/S0ACnbWSQJdqvmYCcGQbiiAKcIftszRskdEHs279MVDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbm/Gz64; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12331482b8fso4030926c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:39:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769841559; cv=none;
        d=google.com; s=arc-20240605;
        b=MrhNaifi04gqwHeq+uyvWEZMMuAwlRJf6bziJsVSelOZBDcsG+ObzTXhVZ5MGOjsu/
         334EOo/B+wYllX3de01nk41LsIMHR5fUHBa2B34hzTC57Id5vt1Haro2QXRbMF6bFOfl
         eZRlQ7SOWc9+irf/PoDlk74zccbsXx57VKJof3TzKKo/wCd4JVEPqI10V53KHbBm6Qv+
         8WMIBGhl0GOEwqmYjC111vrmvX+X6OY9fV22doYklWwcc20G4zyBn+iMfRV/0g1yiPYJ
         HmaGdMRLnB39um0RJmRQuLfmEdmtZlcNBNErzjdwTFDGIx5JXSj9RBli86YufmEq6qgM
         BfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MabdoBqgkhimaQ3wX29SwGCw0efrDRj6VQFNnRTcRYY=;
        fh=88caruQGgnllr8t32lxpmODFaHHrWjiosmWbFN6lAMQ=;
        b=OHBuCdT4YvKUlsXQaRinMJy6fECHLs7YL28OWI+4V8WCEureCU3h8A1sIKCE+wls3b
         W41Fn+leOLnR1AjnLzf/DyMBx0YrObJ3y4fpYvdery44QyF+QNVSC66q9nLqtTnjGcIi
         Tr/yuwzysjgFyN+9DEHkEVGqsmKhQRtXwusVj4HmYCa/KuyIlvB7tCcD94lh5JeYf4i0
         doSfz2bGtLpXuCECBePNW654P1+Cuha25HVU7WfhGMlk18ox449/Smgv88fKDS51s2+9
         GH2VQ4CGT9Jp9yoddDi/hYK/muQGrrbUizvaqfx4WqJPCA2pqH+YxR/vY0v9yQFgi8lk
         pZXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769841559; x=1770446359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MabdoBqgkhimaQ3wX29SwGCw0efrDRj6VQFNnRTcRYY=;
        b=qbm/Gz64gFQ3unv08YlugepwuYzFQlHA9buwHyYOk/8VsjthjUao4xh5OX3H2Xh56D
         /FuCZxadbugIuWio4qjcDrICoz5Uxhu1zBdaDG0JRCBbhTBn8gZE2Ra6Gn+PsUwRfRnE
         svTIJa6Bzv3bRK0IVR0xHJLrDBEdLKDxXgIJA7cYFg0hWXI5Re21DkKnqASZyOeunusY
         NHJPTJO9lhtR+yrWfDIizx/sCf87tEn+wvZDTZZu5PQZDgswENv5FiUDkBX62k/6lEgd
         Cg5MzxdtIxwrYadtsei/vG6CzZDPfDyVywBPqWuiC9Z2kqgdWCtGFbfSJVhTKfc+OAir
         B8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769841559; x=1770446359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MabdoBqgkhimaQ3wX29SwGCw0efrDRj6VQFNnRTcRYY=;
        b=c3UGYcvOlPcyIzeAnz0N2PoTOzvxpfhR2Vut56+bl23XwXPbEnQi+x2spmGyTwr/CM
         AQ3w1Y5wJOp/3uMmU6DTYuyx/7EHtjNjopin09rJSdj/K+XVED29FB0WdM6KK7eZuiGf
         j8lYG6DmMshpCsZ1+/JvTQ4UqcSbMw+dc2aPhoUU7rVkylr+VzB1z6vDfJZy8ch/nMnD
         bniG4sFWGD0dnFHP1bJyUiByIFD63OESzvTH2SzfGtR6cQ+ZiXWajY2hF+pV7vKbTOnm
         Ow6guoNOVpT0MzGFFEliv7DpmjBQbViLSfirCQ9P4qd+uvbvWwhoS99LtP1Ke8CIlexS
         YV0g==
X-Forwarded-Encrypted: i=1; AJvYcCXILCYTlfh78+bGyXPn4bVSVQ1kT8sNEOOmn+GToJB1QSH/bDf68ECVhRs0DtuZ1g8e+rrez7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmyFKFQDS5qYSUs/OKjQVzfPA7jxACM/WBBNDTXhn/d9a+cQk
	4RCnjaBE1kC2hBWvMC17FUoMw25BqIY8nQ9rrNVO5UIof2cFMcCFGxzEjycMHhv5PLCcgSgf/xQ
	75IM7x1aTibkmA0F3AeT9tldVCJVbebCeyEgIabvUmW+LrmNw7TxgLA==
X-Gm-Gg: AZuq6aKH8WBOf0KnzI5GfNnzp7a2gjIsShfYSz3Oid2WrHhjv0KAZOXDTfz7RTcueXb
	LYglASpwtWUXKJi7v4kVGxUs3K9/IT5ah3LOdfc3N1JPLx8INCviL8U3CFShjL8drLFUAtEFSHV
	2yEGRm3QukunXDTs4ZTUehv6AEUC9t8X9ktnJLnnQ9TPPoHqefYNOBMIwRrJnuKGUIDWaUGdDXu
	H+YTlQXhmk5xQ5PHwE2PQbPehOQohY1g1c75WfSpDHyzycUkxhNWzQ876c8u7PwuwsTSn3MoSKt
	82pJSMJVt5paq65117CCoV7tDyzRN50rLJoNQJD4sGL7ZpuflIpYTyZ3yo8k
X-Received: by 2002:a05:7022:e25:b0:119:e56b:957b with SMTP id
 a92af1059eb24-125c0f0dc62mr2646283c88.0.1769841558859; Fri, 30 Jan 2026
 22:39:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-7-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:39:07 -0800
X-Gm-Features: AZwV_QiC7L4qSzb_KIlzs4qil_Auvc-LdJsCcSjjIJJXEFk8kgHVc7KLlu2xq3Y
Message-ID: <CAAVpQUBAODX=pxmM5477kHEc3uGNKN2cBbYq6F5Ja74odJEmCw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/8] ipv6: use dst6_mtu() instead of dst_mtu()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255377-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 784C0C0FA6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When we expect an IPv6 dst, use dst6_mtu() instead of dst_mtu()
> to save some code space.
>
> Due to current dst6_mtu() implementation, only convert
> users in IPv6 stack.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

