Return-Path: <netdev+bounces-272445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GFiGStDxmlRIAUAu9opvQ
	(envelope-from <netdev+bounces-272445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:43:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B60D3412BB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65ADC30E2E57
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8253D170E;
	Fri, 27 Mar 2026 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSRVoD3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2B3D6CB1
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600519; cv=pass; b=N5hQHlUqvzMWAk0zMo7ptO0uHtVzuimN7SAWgJiboyXfOaY0JVXwuxPdKQbR3TNiOywpe3x+DXf791hDA3lQF45gMRKW+1qCstpLRhfYQY7ETnLk7XDI2/zh8Vix3Omvq3M1EK3sAeIIrpBOoxpMh+bdHP4XQT0xDzdBeIJis1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600519; c=relaxed/simple;
	bh=qYBJ7lG2jPqlCAQklJIlC/RTAf122HGcyvH4xyxPcD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGgBfjO8WJhdfWvBbk56Tr9fwZp0JsLDXE1Q0xox+5DdzuoPkBbEmJZ7It4XjBObUvKHMPTXGMSs9KptwF6jNw97bBNxrGQrMMsF/gCryGOvGfzwIJRpBnPWhjn74m2VSi+p68pTc/sRncP3hs85FHPV5a+QnXrTnXAF0+NgME4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSRVoD3i; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a299cba953so2109313e87.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774600516; cv=none;
        d=google.com; s=arc-20240605;
        b=bwP7vvmvUkghIUCcTQmVfWKKYj8t8OdeaXakzfIUr34zrKD84lVwSqoAygkGl8HJEI
         /zyrk2pOWARuyDwLpK5yvViTvtHS2wdz2wl8BPEQ+uFRA+vzHbz1HBlJn1TkXDhzH3N/
         bo+A+1tTKvTOZ3nS0lawtvI1dCaoB1tDQA9WJbVV+pi9C9zjhRDSp+WtPNxIVMFxMvh0
         HVYIM9kWCXNfJuMb7+UBfptFfmXtpkbDjGisZNaB8W/Q42xuNfDYEabvav7sf3BwAQMx
         iMC/oH9GsIIVEMwGOptv1X9uSQvajh/uchXYHeXUYOsYlD6W2heFt0z3rMhznDclJ6+4
         zB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYBJ7lG2jPqlCAQklJIlC/RTAf122HGcyvH4xyxPcD0=;
        fh=CktjoNrYNBUUaU+S7nKhHFB2PCywnAAvKowoQ4HD6pg=;
        b=JsMX2FaGOXbakNeCFttQRfy+0At3Hl2QvIfkUpF+7cyuvhRDi483hd/KZciB1+n5DZ
         N2QeKI9/gy8blFoGlOR8qs6UQpSooCB2wySaerQ5HD3d7uWUaaCkIpcXBQLYOWH+ssbG
         an2iYF3z4Mwh4XdenMKBH/YahmYL0rEUCGsxwqQNZ+rXUT9t3P+w6jGt2uGX8nmcaXDj
         0tV/JPoe73UfwhXIR6kDShR2ZVdVevYdE46dMqZpPLsECiNBWgHVvhM9CtwpZdG/OL2H
         gwFdQwhLvLbQNMLaE5vODl1/rvohBDc8CSMlZTotAL+rkwbdC8w0jyUUF1NHqPYoOyuI
         9rSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774600516; x=1775205316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYBJ7lG2jPqlCAQklJIlC/RTAf122HGcyvH4xyxPcD0=;
        b=pSRVoD3iBtz3+bbNs5Tjgg89pFWgjkXtiTsTaqvSEFdWbzXjF0yOOLjNZi7tkCbEzG
         VdWRgfyDxuoLjDwbmoWBSzsUC01sCG5esIddP82A0OMf1VjKTRz7b7zcMf/toEMuSMGS
         DNAZRhmdhpMJx3/Ghc3kPNZarwgoAHJ1ZKXscptmPTP70ygJwE4NIZZRcvyqVNfjVCZy
         1SY38KuH/roOBWWIzslAkUWMGBg66q4CZXiIyo7EAelgUYRuHBRFiPh5bSeLx00tqjSt
         IE+GsjJAplCGpn/36zB6QPhvN6YC264N5k3MvgHk6aDLwDxd7vUpZHWnVj4b4UhcUTbw
         HBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774600516; x=1775205316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYBJ7lG2jPqlCAQklJIlC/RTAf122HGcyvH4xyxPcD0=;
        b=eJpE6uSWsEGubo9mfZCqWFYGJaoI7Qedao9ddBboyXQZ1cdXuSBTW+55iAwPbcbDOY
         UjKqjiYMgcRu/fynCar8ffUvvTH4GTenPmtcjAaY3v7Cejt5NIOYAAigpezVLLWHodx5
         HiuuHVaW744WsFylrk72EtNrilltlgEaPIPzxNkqhggawZ5QxaHOHEYHsbO2b6X3zno0
         0AC54Tsal1MH4GD2srCgtC+NcMWRCOBWCr2OkHiaAJMmB12kxjibpwsVxwAi+Yj5ZnJA
         MsD3I+Emi5RAPg+CNnuX1zo66BZSQ7AqlSlRALPriRk4xiGXqbcdcx2GJ/bQStcFhe9a
         SMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9V0sYx95IylRZIdhbtMdyPwq+/GFHsiZMXhofMFZQMTONo7K7FWX6ikWvcWjm/GGwzq/0Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivARUNS0S9gyqzJtvg62JNMdJz8T7VtaSq19yWupUQwax0kg8
	PreMk+her59osVzFdf9F8adoAMrDn7v4Qldiv5jgkEvF1HY3m+fEm0AW6BvOr1FwIhSGSizxgFL
	PIIgNZyJqI12YkeJ3wb3KGUuT1MqvnLWfCZU0uTY=
X-Gm-Gg: ATEYQzytIFmXKFbD8cgVU9o0GTpRiIs7xHPrssapGkT+jnubj3SHjHUoS9t91jTO0i5
	7VhqBZ+qyyTinDiXaMRL1VWX+GK+8BApn9Fy/Z1jLM5GyPlnqi6EnaQ5qDCMU1dgPV4SFUkuITV
	5U1NpvZFdYbJK7CR1DmEOvyCan/iEd5F7vPszeHJysoW3RbFmN0uXKzHKTkWNR3N89FzskoAF/9
	Fw11e9KsMmhciOgZPU9o4wRYQYelIdJ7POyybiZIsOogNKuaEp7VYdyazeBIavAr5KGJgffM+sj
	TIeUNWGF
X-Received: by 2002:a05:6512:10ce:b0:5a2:9cb6:ef4e with SMTP id
 2adb3069b0e04-5a2ab920dbemr645542e87.21.1774600515244; Fri, 27 Mar 2026
 01:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326144249.97213-1-kerneljasonxing@gmail.com> <acYD8JT16b3_htIz@mini-arch>
In-Reply-To: <acYD8JT16b3_htIz@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 27 Mar 2026 16:34:37 +0800
X-Gm-Features: AQROBzBFpeC9jgdD2TkLOeX99Kk7Kr0iH0GXi8wk5nv1NgDam9EvjEI6SoT6zYk
Message-ID: <CAL+tcoBHpSo6FHto4qxibdjUEkDPOaYTvVOUHv+OU_wh1PSqkQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272445-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B60D3412BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:13=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 03/26, Jason Xing wrote:
> > Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> > defers freeing of alien SKBs (alloc_cpu !=3D current cpu) via
> > skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
> > SLUB spinlock contention to improve multi-queue UDP workloads.
> >
> > However, this unconditionally impacts the napi_skb_cache fast recycle
> > path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
> > when the TX completion NAPI CPU differs from the SKB allocation CPU,
> > SKBs are deferred instead of being returned to the local napi_skb_cache=
,
> > forcing RX allocations back to the slow slab path.
> >
> > The existing net.core.skb_defer_max=3D0 could disable this, but it is a
> > global switch that also disables the defer mechanism in TCP/UDP/MPTCP
> > recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
> > can co-exist with other protocols. That's the reason why I gave up
> > reusing skb_defer_disable_key. Besides, if the defer path is disabled,
> > that means TCP/UDP/MPTCP in process path will trigger directly freeing
> > skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
> > which could affect others. So my thinking is not to touch this path.
> >
> > Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
> > static key to selectively control the alien skb defer feature. Let
> > users decide which is the best fit for their own requirements.
>
> For a non-zc path adding a userspace knob feels like too much. And there
> is zero documentation for users to decide which mode to use.

AF_XDP is the only one case that I use to exemplify. Reusing defer max
is not flexible and good enough as I've mentioned in the commit.

Please note that the knob is applicable for single or few flows
regardless of what kinds of protocols/tunnels, which brings 6.6%
improvement back that is not trivial/negligible.

You're right about the doc. Will add the following one, thanks.
diff --git a/Documentation/admin-guide/sysctl/net.rst
b/Documentation/admin-guide/sysctl/net.rst
index 0724a793798f..42e06f93306f 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -368,6 +368,19 @@ by the cpu which allocated them.

 Default: 128

+napi_consume_skb_defer
+----------------------
+When set to 1 (default), napi_consume_skb() defers freeing SKBs whose
+allocation CPU differs from the current CPU via skb_attempt_defer_free().
+This reduces cross-NUMA SLUB spinlock contention for multi-queue workloads=
.
+
+Setting this to 0 disables the defer path in napi_consume_skb() only,
+allowing SKBs to be returned to the local napi_skb_cache immediately.
+This can benefit single-flow or few-flow workloads (e.g. AF_XDP TX)
+where the defer detour hurts the fast recycle path.
+
+Default: 1
+
 optmem_max
 ----------

Thanks,
Jason

