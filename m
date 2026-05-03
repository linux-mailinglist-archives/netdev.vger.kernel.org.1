Return-Path: <netdev+bounces-283544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pj2J6Xk9mkgZgIAu9opvQ
	(envelope-from <netdev+bounces-283544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:01:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B84B48B5
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 08:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F3B30097E4
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BAC3A383A;
	Sun,  3 May 2026 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/3DsIfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3813A380F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777788066; cv=pass; b=kZhRQdUs8J2P5uxEy8q1MxMYknGzxRCP+YZq8KQE224QxVr2A+83C6X1BFFPUdyG29N6cQ8QNFYQ4IO6SKrbPc2VJ+MsS1cPp/CmPRM3OEvba3mEfEj5uewpnudpLeMJypbDvRoAHlNHVKS5FgDOEizr99halQJjR6YzYEurtaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777788066; c=relaxed/simple;
	bh=wCfwMR9ECj9hefOAeQDZqg7OdsjiS2RBtQZxyfoYZM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gd15u7ZeaSZvpySVtUDXCrFeBawU9tLBFRpgRcw873PwyZI0jAu3Q2Bef6z+zEtWEg++09ehayzlJ+4pSTBk+LoNx4uXoA6intcq7djw6VRpT9Tr9wl5+LEt4mvIBofh5YNg0BPByi4c2KZUdFmvuxYw2LHvdPE176zykqBHfjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/3DsIfx; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-506362ac5f7so23445941cf.1
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 23:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777788064; cv=none;
        d=google.com; s=arc-20240605;
        b=D53fqWbG6qqMjl3TOWK1el8SGhwbUwbZ7IHRpsQjjBQNLx+5rdmRtp54GtP8BBxOJj
         hA/0jngmWw0fOiE/eOkliPQpjGhLwsuRPE/8KDZ1/3yZznMuj3TbNhx18kbf7lr/TT4C
         tDCrEPRAIqq3JtZ07vXHh+KSKKDhDy2gSSaEI2+fGbRmhxSj0bFBcXI/4YMLl8r41QR0
         tCX8bb4NPWeOcBj3546hA3A+ILHX2bS9mMev1otKorg2MplfvRsZSHwhKfj5CJdKBOkM
         EiFfhR4hxoK0Rzqz+yMCHoVDsH1KC8kULWqvs8ePei1mNKOuqh/vfkeQQWOijlQKTMic
         Ifvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X9ULHTRkNyp7KStodIgdtfu2PjfPsaT5zkV+m42qZQw=;
        fh=o0HGR1WDv0YDWarOTcIqXWaHXan/QPWd8Cz4NSgDWEs=;
        b=C1uDe//Iykq8889qbXkx0P1tBr0rKYnfEiOlQCcfsbkl3FdR0242ceJo9ja0fPBUTP
         ouoWEqdQxUdfQgfayPrupLS7/7zR85yHybOZ6vu9Qkgmkb0Y9vlUTInQOCMkW0uzNo1/
         3fi34WYl66BhDGq8KhPVNzpi1+cfDiVUEdrW/tUrLrH/DLj+P912D6AeuCJxfzTGT8Vr
         YwHxZKVjBwwlnEIAjcSOA7syNhSYZKn1p7tWHB2AsfWNG3duy5L73NA87Hr1hlsrqcJ6
         wT7HxsJUEsHbUFXPxBgFeXMfuv/n7sebAWvSjUSddVFVWPe01ekOP9cYHgwYkD8h3Lrg
         tRKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777788064; x=1778392864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9ULHTRkNyp7KStodIgdtfu2PjfPsaT5zkV+m42qZQw=;
        b=k/3DsIfx0DaTYgMKQaSS/5GQ3AU3dIybvTV0+1T0l0wlv6aTQc5tZ9dx6QdzO9g1cU
         w8SX60PLp28apvhZK06HOEs/H65j73RZ/Z6jG0J0XejDWb4fjK7dJpMkL8UdfdAXHJkn
         +ArLpjxlRsnHdsRDNCnLb2k4TPhZnyerLAmRuMlb/FSeS0/84vki1xmVu93Avz+kaWXD
         ArxMuBw0p0I8SafnqDskAqla3GnlHewVWj+axIr0HL/rgJZTgq4aT1cfRRb1OAgHeEXm
         8izpG1RTNuw7OjBdarP89OUFeBrl7pwd0tyQDgZWgwjuGF5SsewBFxb4L+nvsqsmDDAs
         NqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777788064; x=1778392864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9ULHTRkNyp7KStodIgdtfu2PjfPsaT5zkV+m42qZQw=;
        b=k4LPBuNHOwvjUbUEEMipcsltBG5BMAphexWLus8FuwGfOyl8q7GEpXO2bUqS+rcB5J
         7uQtUFlWX0E8J3+gaBbKIL/3Igzsmqrw6hLEKYvpISmDkKZ2KCiLyzln4t1FnsFZ0O96
         6FEKMJMvfoun0SM/ChD0YZhWmp9jjwODpZUz1LQuacBpecQ3we5q+z97SENzFjgqZ/2x
         9+HsG+QKIw0N+wiSPzu2RcM3mQ2RYNY4N9lz/Fv845KI92aaWoHU3Q4C233pWEqV2zZS
         8/Pg16bz+98ppX4gp2fJXdnwDtGyl7Pwxz5RBCnjfdEXpf7+bm7GMnrE346q2n5LXn45
         pfKw==
X-Forwarded-Encrypted: i=1; AFNElJ9E9q3xl9h8LZqHyqCSTgPYlvvDUBQaFj/iJichWDDlVXCXbTYsT0UVd725va3pLlZ2TNFxgmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3J5n9g/OtBe1yjga17BiXqxDPSv0nSaLquckYZJVutFw91xv
	wq/WJcFwMrlqsvhGyLIaN0NL1TUAlefbPUKk8vMXuwx0iGDUvmMZ9IkcpCN07loKg9o6po28/xp
	hhlnt1gWqf6zweKcg41qhjkt6nhZzQ55HTXHc
X-Gm-Gg: AeBDievlKkH1T+VNyYxLaDF0hoHsFyayohM9uT8DY3p4uJLVZckSHTXDyf6FSFZVEZV
	RMFhSQ+5CMGdHNLlBAJ0blWytHg1TO9JPXiExQRm+5WL4efRAciaIwfsIglxaaXXtTSN3jxTkQ8
	ttdkegwCOLfNyWtq1AwDm1jUVq9R9y1GF/ktDZJPuS1BlajIqpdyCef2r2nRndpjzWFTpyohFWD
	rA8FNtNqnX6Fje5cfO4ktI3IlGvUpvEIf+7gvp6gE1HzujHoHEcpHFNZNJEixGcGzHKel6/U7Mv
	waDO7QCQ0//3cMj1wsHoWJqdSLAe1lqcKHOEkp/3Vl6N1pHL444vLlcQNghoDIfTZ127ywdbIws
	Gurv6
X-Received: by 2002:a05:622a:587:b0:50d:8b23:4948 with SMTP id
 d75a77b69052e-5104bf71ec5mr80525351cf.46.1777788063794; Sat, 02 May 2026
 23:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503030801.14080-1-enelsonmoore@gmail.com> <2026050340-kilogram-prissy-a833@gregkh>
In-Reply-To: <2026050340-kilogram-prissy-a833@gregkh>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 2 May 2026 23:00:53 -0700
X-Gm-Features: AVHnY4Lgk75zXObx5AKxwFVNfKeHDu-2UsHM6uymzVhpbBAn4tV8BBUVB7TAHRk
Message-ID: <CADkSEUgPtjkKC684O3qB=koKDPwJoUj-qU_4Z_18NAU_+bBqkw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: synclink_gt: remove broken driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Haren Myneni <haren@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Qingfang Deng <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 222B84B48B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283544-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linuxfoundation.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,garyguo.net,protonmail.com,umich.edu,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi, Greg,

On Sat, May 2, 2026 at 10:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Then that means someone uses it somewhere.  Don't generate bindings for
> something that will break because it is no longer in the tree :(
That project generates bindings for every UAPI header automatically,
but has a hardcoded lost of them, so its presence there doesn't mean
anyone is using it.

> If no one does use it, then please get that project to fix their code so
> that we don't break their build.
They have had to remove headers from their list that got removed from
the kernel before. I will send them a pull request to remove this
header and then resend this patch with the UAPI header removal
restored. Does that sound good to you?

Ethan

