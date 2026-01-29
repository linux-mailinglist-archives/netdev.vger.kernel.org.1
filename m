Return-Path: <netdev+bounces-254777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NiSNFpNe2n9DgIAu9opvQ
	(envelope-from <netdev+bounces-254777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:06:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37634AFE29
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79CD03019932
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B233876B8;
	Thu, 29 Jan 2026 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjlCG3x8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA5385516
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688394; cv=pass; b=UrHff/yKFn2cSkLhTCPqRqPsxIPGbRObWedkbJQNqdTXzLhlqqrwL68foatYVDpwLrF877mj0M0XHOWFhwnDGbF6GrHVfrMfqn3iFR1Vw4SPIT1VHQnxSkIEkLld0nvDoTEurWbQQ05SXTPqPooZPHxCGaqK5LvXqKn1M3H/ccg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688394; c=relaxed/simple;
	bh=nhTTk5VLQ3xnOV8sVRp0iZp0R3slZLmDy96JjDG7vnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9qqyLc3BucW6NxZyd/uIOCExwCePXOMdjG1S92JLoDTYc+/meI/tPOxLtmhjYyEokpO8IXmxO+mxV0iBTuCv0q7tSKOUi0A2HDIja293yoYuqzGvfsn6uVh89f0I+8z1QeSDlGTgoC7q1W/jxQfyqjITxZS/W94dBtfxUty6dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjlCG3x8; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64997a4dc0fso810672d50.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769688392; cv=none;
        d=google.com; s=arc-20240605;
        b=NhTF8NtwolCgo2Fi21b7/xHERWfOor11VifgFVIr4GCeIbHwOekn5gTakyUNPeUAks
         i0aOk4Lrmn2LbMGjfapzmnTLnp/KRebaFn6QqrlelKS39G9BzuMXa8KknAgKe07M2Ui5
         JV+g2IObz1md9pxH4AnkyWbAb+7WcLOxXjofCuhE1bNe5GAQ3DXAk6HIsHTS+hFM2wuM
         eicQ5r/CYER0RHj1ygGjDHDUP19QJnwgaGqteRj4Ba3fc4yTCz/tR3r5oFOqVqUcPs4C
         qMdmITouB8VVbyJHR+o8houzu1Hi+DmSZusUHjpuedTn6Miz7d0UEfjmVP5f/D3P34n6
         qzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTTk5VLQ3xnOV8sVRp0iZp0R3slZLmDy96JjDG7vnc=;
        fh=FHBgKfide5996XH9HKt4+Ln9xX4pFDQtzZV1FXGvysg=;
        b=ZanDkB1qZmN8epLLO7cyWSOZK18i/GuqE4xWkTJl+mxnnRiaX1Q63WuIjq/t7A3YlY
         kZE+xt7pCnDnCTIUWKL3IcMareo38//28JrfdcfMqqClMrRlAl3PburAWw92qh2mGqWI
         KAGGk5NHc/AUEgiYol3YIzVvP233XlJncSohumsHfA+MzYbEfLOmVJ81m2ugZIlWmk3M
         LZvz0psFvgW3VMD3xYHRIQRC4j2m57pZ1JBuNn9C3QXmJ0vgytQwHMtTfJ6NcjK48C/L
         lPT98QzhKVTI3mhvAWY6wX/C9Gz0tKCwn0m2ivopY0hBhkEwkMBXt3o7rIBo4Tk3mdv9
         tJ9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769688392; x=1770293192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTTk5VLQ3xnOV8sVRp0iZp0R3slZLmDy96JjDG7vnc=;
        b=UjlCG3x8PLA19oNgAVyFPi/Tk1McBZjeciAgvyCYGuityMdvSjkVaB7ShIXdfssIQe
         bIWAHpnZ7RW9VdrRZHpCijhFAUbMJHPWOmm5zT8mC7GsHa2U262ztbIvlHeir3nuI7Z2
         TtLa4bA/bGUn7ZY+8+WRFpxfbO2I4Gfb/onQDGELAXfio8Qb7VWr6tBk/KpRcYXCGWBU
         OSj2/KIydvWx5Z3e9JA8m/Kw6iuOCorKeji9v5yfQvh4nlMucYObnEhVazK8oDX4TVn4
         6mujL0Wwin+YXJpIxEn7F2B3lHO0Vyi7L6pGwB94Oth+oBiW1gKJ5UJk9XdH/cfT/LuW
         EXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688392; x=1770293192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTTk5VLQ3xnOV8sVRp0iZp0R3slZLmDy96JjDG7vnc=;
        b=ovjwzq/PEsuFsxPCcwopehaZlmGu23bdz0bGNCqEWTIAEM5gsnp10v3+pkftgelWhL
         BDoeco+u4LFJfUYBBeVw4ID79LJs5cHtYFp7MbPXLHuBD70ZnzjYcugMp+wn/wYvPRZZ
         AHYlgAhytdTecrGBEytn1Xt5vRerleVEDVWO5OH6ENnoNeM3NbbP6pw6tQEjSmNoa76U
         4YSoZ0Qrryt0sz0szPzdcfL6AKeDye8v6z7BegyyMfGBmPliovKc+ozauRWbk8cFF/uX
         roRxAJ3u48mCCaFZMGMO8rqRJfInw2ApxsnBtK613+BdMOoITSLhnZmOIVrRq1LK4BNo
         G/MA==
X-Forwarded-Encrypted: i=1; AJvYcCVURhR4YAUGg3jmRvaEuBIhLpQCu7uZm0z3s57kgGeqZFefsXOUPqMBysv6y7U9VJjAPztFdPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsleOqVgVXL6CvFFl7w84Tc36lNpq2756RY9xU5AaU+dpJ9On/
	0SNLl0XTujXM28lmy9dnGjs18na3P//VRhsiqyI2YX33pYFcDgZitCMVPVj9YwVSmTNtCOs0gLL
	TjEblUluPzRCYur2UXAxSl8paP+ll/lA=
X-Gm-Gg: AZuq6aKWRitOARTBE2nyYyHdtewvbG28fn/K2USdPZ42LE6Y0xrX3d9Byb7sZrPtI2D
	6yWDWlOzW3SZKKHkdRYc2D+U9EJgclr4ZeQN+/h1He/HGAz5hYD6FJujtsnP80wDZtZiPJGgoqr
	9Dx8ueO/fK/wXS5/oA+RSafAMAPikX3VDVU5+95EzeIvU6AGEvoecXkwxwhfhwQpVDomKMkHSLO
	B/tqVbMkBFamayZOJNiyHyPNUnLJ/34KOoXjZQVunZckVKq+wOf7lg9q9wBIsif49iKtq5SfiFA
	JpoaoXYFa14173R5hZD5DBal
X-Received: by 2002:a05:690e:1301:b0:644:60d9:7519 with SMTP id
 956f58d0204a3-6498fc826c2mr5430656d50.93.1769688392358; Thu, 29 Jan 2026
 04:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129101213.74557-1-dqfext@gmail.com> <aXs14ZJGN3lDnMDc@strlen.de>
In-Reply-To: <aXs14ZJGN3lDnMDc@strlen.de>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 29 Jan 2026 20:06:22 +0800
X-Gm-Features: AZwV_QiM_yCgV5Br78jgWvZgBwzVGxCJnecpTiSDpowaWBveh3X_YZQEustJxGY
Message-ID: <CALW65ja5wOf-5PAkQY0yt8FO1_gTvfL392Q+S3TKtJoQ1kXFug@mail.gmail.com>
Subject: Re: [PATCH nf-next] netfilter: flowtable: dedicated slab for flow entry
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254777-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 37634AFE29
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 6:26=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
> Ok, but please use KMEM_CACHE(), we've had a bunch of patches
> that removed kmem_cache_create() in several places, I would like
> to avoid a followup patch.

But I'm creating a slab with a different name (`nf_flow_offload`) from
the struct name (`flow_offload`). Should I keep the `nf_` prefix?

Regards,
Qingfang

