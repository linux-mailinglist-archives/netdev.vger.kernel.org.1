Return-Path: <netdev+bounces-284780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NpkC0wV+2lLWQMAu9opvQ
	(envelope-from <netdev+bounces-284780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:17:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F24D9388
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A3E53015491
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE53EFD3B;
	Wed,  6 May 2026 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iiufr+VE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB935F5E4
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062413; cv=pass; b=WO8PNQdy1qDAjzZN7WULowAA+OPZtx8b68KBM7yydyUvdU/T+xvcgK30QSTiqu6ZYqIQUqgPiPzgvj3q57le1JZLrS6BTD0HqKE+gChrhCi1MIplkuC5p37la8z+jzNO9m8D/THAKOo491+eClmUmkW6TDh0piEtQCNB3l9XIqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062413; c=relaxed/simple;
	bh=0VmfNOpb9003SdZvctoWunQCh08TFb6DVPDW2FTwmMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgLCP5ucdZihLIk1UMnPn9AphwEs5NXSfBrUzRLeUR8XtI+m60Qafr5A9/OQEvU283kCQQWIGp/ZW2q5wxUn/SwMB080Dal6byDjVTkxNEUYZ7RfZ0gcfAWTuB62lTt7DUOyXKX7HidwdQLkMffJ9YB6FU9NcM3THMo+sV2CqXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iiufr+VE; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5102582e237so48998391cf.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 03:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778062411; cv=none;
        d=google.com; s=arc-20240605;
        b=eaiHrwPo3QXHvIeh+noqSVaGdn0Q13rbD3Ry/8MYZ7D3RVrFpK3FHfLbXfTUC/VKZB
         mZzxDxIAZQaqS8/CGmgq/91JN0IQluirNHmnmLkUV6QJy9rbj3cyr72bqmsh2jxLQPrA
         /S9dq08xVN5T0X7S2IAcenkOQycctH0sTQ0uz6o6kwQHN/BV4jw+su0bG815ysqpuNjD
         m2h2BEslp17jn0Ook2vervwF/yRDXPwE6efiFZZjeaDGcR7A2dil2qm86YZzPPBIr62Y
         YUmXOfOTfxk1YPqOQcQECm8wUuS7U9odDaLbDNvP5QM+J6M3tvYRuHixpMAOT4eNCJrr
         7S6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VmfNOpb9003SdZvctoWunQCh08TFb6DVPDW2FTwmMo=;
        fh=It6yIdkdp61CvfvWOEzfMPzL1YWrnPlFpnSp8AXloFA=;
        b=NFM/81DxQYMgTS7oFAIG0fGFgMHGR0yani2uZbBfzNC2rozUA30Z9MsWIKi/yEifVj
         lvVwjsSR/bC4BfGO4abmAQgIWCKbtV0qvu1uq78l4GXRcKfAemlzNHiCKkAIAvN+wtQ+
         rNYjNyhE6Dn+IWmxzLGhlEwKxN7Dg1aEXQ4St0k3tnQjKUMfGQO2+a8gIW1wH/AqDOso
         PDL7b+/B4zqZ6BZUPgqhz2PjR6hWWTNxOkaza+JGWV0d7SjX8JWy68CBamdpS953lFXm
         MC6KccMjSP8fwisTJB9KviFNQ1DWEbDOo+udtjUHIe4Tr9T/oBW7slwpRsBjsSyxVAUl
         Dx/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778062411; x=1778667211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VmfNOpb9003SdZvctoWunQCh08TFb6DVPDW2FTwmMo=;
        b=Iiufr+VECAfeMy8Ge+lbZ7Wkfn6Qf0Nvq2WyfUqX7EQJTWRVcBMp2ifIt/RLukpWnf
         1v6aszk0b5xgu+dJsOLnYbnmw7ZU++PbyQxgKROYapIAccgX4xhdkBU2G0zn4dqh4020
         1UIN1HZoxj5rLOaTjFZ29HOSGONylGYQj8pdtdckfIBIrR6oRe0O3ZV5aFJsC1QoWyEp
         YkGLbGLXAjyarg++EpVmcbbIRaq2vTQXtGWBRjL7T7wwlnBIb24AOkZ2IXm/q+42toI8
         6QWChHNQCvf3TqqGu22vWVVoFCnH/RPuVejoo17BB4KYBPlsdovnNK3ZrKYgOG0LhwO9
         lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062411; x=1778667211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VmfNOpb9003SdZvctoWunQCh08TFb6DVPDW2FTwmMo=;
        b=pQtB8HGcOAGjip5wODhpQsX1d75x9dX07jAL3RX0fKvl2iBOSaFU6ITOdPKu9EZtjZ
         oCEYG9rZxrBgTkeInZYIMlPoV/8LFjnRaIC+lHrjMcA3J+MgJOMERh4AzgbicWFlxPq7
         hdHSUYFKC/jwZoBrUdAGo2w69iWf5VroVB8ef5tt1hJgDJ9GgECZJ5ZUXcQklfnhDBSc
         b9XGedleCJx9sSqntevyC8rW7X9vgE23As3VKEA6Msyo58wwEyGuUVnVFtsAyZlbwNI3
         nz43k/gmOSUs0tQlFqmKka2OpPJEuu/pGkVS/cyHkAlGmUXaUJrONILd8QoLS16U0lKy
         Y2Zw==
X-Forwarded-Encrypted: i=1; AFNElJ9PA6qbXN6Xnmyy5n//ghNfcyJS9wPI5RBQe3XMrn5RRKFZM4NyW0jefX3mtADVqVaPYNbVPDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUikOC4WVTHOmWqbzoOYvSlJbYBzYVbf80LlhvjQbiS2kGBWO
	KOEaglopeQUhEcyLKT5Re77BWVt5NH6mhSBuF0Yc4YgvVUNuunu3GbpRzRLhOFJw3wgMkHAMPqp
	IbHnCOUW1NmvYzH0hoecNRkDjoS4pvKDuBIwluREy
X-Gm-Gg: AeBDietvL42RsL8VmAG6eOqpHGJlb+gi1w5wuFMhXS5TSCNSgPe3lY3dJx+bndSqHsC
	4FicZDCUyxgwEQp8ANM2yotRy4KcpLoeDurO+ECJPW/TtcoIKGgqzg4DBTZ7ER0z7KfH4oYb1HQ
	FEa2WqFnxW06nDEw5ouLRyLh3Jy1BynWtSz3ZVEfmpsG4g840yVKFJJoHL7x1qDL4gwznZFTqB5
	qKH1msLOw/gaEtk3Jvl7ledarRdumLHQBZIQ2eVbFiE/EPLIXL3ZnjJiJpVPVO1CJ2Z49qhDyZO
	34SGVrwe5iAJi2Vq6clhf5Stp3MRuzNAt15uLGdrCIPhRBB2nQch0NYEkMB8MKA5siGYGT72LOZ
	4dGmMq++ESAT9c8UACD0lR8/tjAQpEI6zcQm0cyVXCdcuyRcjgg==
X-Received: by 2002:ac8:7dd0:0:b0:50d:7b0c:35e7 with SMTP id
 d75a77b69052e-51461fc4757mr37363981cf.43.1778062410554; Wed, 06 May 2026
 03:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506065955.1695753-1-kuniyu@google.com>
In-Reply-To: <20260506065955.1695753-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 May 2026 03:13:19 -0700
X-Gm-Features: AVHnY4JqBio1mj8kjpjK_RA3dTTtDPSOZRc1YgJhmOYM-NVfn0zITjGyhPMBcrA
Message-ID: <CANn89iJmBHXm9sjL-S2OZ4D=ZQuTwWF294DNPU5dcJB4FVx78w@mail.gmail.com>
Subject: Re: [PATCH v1 net] ipmr: Call ipmr_fib_lookup() under RCU.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A42F24D9388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,redhat.com,gmail.com,vger.kernel.org,googlegroups.com,intel.com];
	TAGGED_FROM(0.00)[bounces-284780-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,intel.com:email,mail.gmail.com:mid]

On Tue, May 5, 2026 at 11:59=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Yi Lai reported RCU splat in reg_vif_xmit() below. [0]
>
> When CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dn, ipmr_fib_lookup()
> uses rcu_dereference() without explicit rcu_read_lock().
>
> Although rcu_read_lock_bh() is already held by the caller
> __dev_queue_xmit(), lockdep requires explicit rcu_read_lock()
> for rcu_dereference().
>
> Let's move up rcu_read_lock() in reg_vif_xmit() to
> cover ipmr_fib_lookup().
>
>
>
> Fixes: b3b6babf4751 ("ipmr: Free mr_table after RCU grace period.")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/netdev/afrY34dLXNUboevf@ly-workstation/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

