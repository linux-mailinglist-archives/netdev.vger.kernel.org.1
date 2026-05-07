Return-Path: <netdev+bounces-285125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FQDA1v++2moJgAAu9opvQ
	(envelope-from <netdev+bounces-285125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:52:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D6D4E27C8
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46291301D335
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5A29ACCD;
	Thu,  7 May 2026 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmfXwG6A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A981FECBA
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122328; cv=pass; b=h4rBdpNssm4Qoc62NbzQNgn5BjI51mJFgt/vmw6D7SMDzbkQeDVAXwL7qf4gerXAVcUmamujKTfec9x6/7tZuQe6KsDaivQJ7tQIU8L9iHDWFKu4C+SoTW45M3rW8SXy2dFzrZSq6mlP11muHnYoNzcNt9z/qPO/2vObtlANBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122328; c=relaxed/simple;
	bh=PkCMtPE8mW8mvPwrSIz+jd5OjsQ+57U8W/+096S8vDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLZbbUnfzRc/S/w2wVoumssA5DwGWmeI1BN9ArrwoVK9mCG7v4frlBh2Ro5a1Vzdp8gfSY37388DKM6iVjoxaX6vTIg/qM7qu1S8CL+ubP63grW5BnJ0DBuJMejfGDLMBz3d9NuUXOdzYBg+zq2PIGTp6tQ08kSKI/2cZ0ITkGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmfXwG6A; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso311733a12.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778122325; cv=none;
        d=google.com; s=arc-20240605;
        b=RVugjpuFb/+ErCraSx+dnK77DN20BEv+HnDfyul8rAis6ZIsbIImd5sLedGbvuf2Gt
         jSUS8h1ZplX6aRoWh4HF4uz/ZP9qKIX0veoi4y2CE8Px+pJbg5hMuyJ/bmpszITxLg4o
         upy5bycbmwAzHCztV95wjEq8wNkrp2xJ1WyX2dQGgswer79a4DSBigctTDYn0JGknAav
         mCAogLZl48FOXtdWawatxBszFZRXD5JNznbYlmf7sU9UsjCFyjOT/DVOPYRP+NkprU8k
         yjEe1ZmVk1uSJg7/PAtDVl2UUZwfbfscuc0yiqbBwlonQUsjf0esQ87s8O7iL+l1sQGq
         pRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PkCMtPE8mW8mvPwrSIz+jd5OjsQ+57U8W/+096S8vDk=;
        fh=hIv9c14k7nAoT453n3RBnmG/U5qd4C49abBmSRh98pw=;
        b=VPH1FP1VN+X4CVjkM1MVlBVDylIx0yAWv3+dvvlH/rfcZ1ZAOR/e4RaS9IGP+LpQn6
         yhV6BD7iMq8+dHSZNC5nxZja9ofngktIluTeOgGGyop9603mpmOlWFqr4EBfjKnW6HQL
         IS4cDVJgwYd5U2Co9LvsC8CNAjtq7KCOd7IUIWHjoDy2k1TITSlno3x/0mqR/r8tp0Yr
         9yq40fMrX1rCMli/Z3HYvzEbnGRmwHAgMwaTCE5jJKik/9huRsvkL93rv6PIwgKFldPS
         mYOH78f9jSv+mMj/Ox+MatIxalGLRTr9xoBUZj/HDYP79wIiW3AhK4PZQ2jB2jUQwTvQ
         Zj6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122325; x=1778727125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkCMtPE8mW8mvPwrSIz+jd5OjsQ+57U8W/+096S8vDk=;
        b=fmfXwG6AxWn2AzpmhZtXnVK18R3azmfLY7E6CBM6SlPglsU8LnrxtBiZPgcfJf4+1P
         q4nUaEx+U9Y+IoCKWJW+hYXbsmVoYeidejCtHDphFSE2v869MvkrjNKO673/Xf06wiuN
         2kW09XrzXJzqJDr3HvhAmzu+cdelpvHcIf4jlr32h3k7FRhyIOfmKIqWGvmx/FYeeno/
         Z399Tmua2RwxaZ7gHTPQe0wSBY4PpVPPMbRY5pWqAj1Ahm7iBF2mjPScdN7nq4xxdygU
         DMALXmbRrArvHNTsOq2cSJGMmEsX8AQENnkb9riThtIPm/LDSyXZ6Ei7gGrbK0XXc7El
         ntUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122325; x=1778727125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkCMtPE8mW8mvPwrSIz+jd5OjsQ+57U8W/+096S8vDk=;
        b=Z+lvNk2tphfAG9No4q3j3uF5GZU1jcTZt/hFSXAZtSgrzB2X5GdcbWZZom4dHupSpM
         O2qVH55bk6BF7Vd78vMu+bMJGUSb3ipav89Syn/yFEkNDTfFF3Z9qN1NnlFlpkdT9f6r
         LFhN+dJY1H6787zvNmsOcgTFUtEWOormW5TkKOCYReKcFsv+pC9U7uguEHKSxZErLprV
         POsnBe65h+R/ojYzWBPNUSXRS9fcMsjGqcOyRC9MILfu1e2mkDmWhDf8CZB9PQy+bhsJ
         yYGfWARtRaVdg0yz4A0Gq/ONrVIUHzdDYlyL9AAZfbs2unnvQS80ga1v9x2ke7m76hLm
         fKPA==
X-Forwarded-Encrypted: i=1; AFNElJ+6d1+rcq4HAGjIbWShSJBI5c6pxVl5TBGr1anA+jYa3LZZoVvchGbgzxWzJ+JArJBlxL7Eiio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxR2cDuSFYv3csY2HZoHLD/EzdonWjfzwkoLt6hS4+E8rdSpDY
	aua1Av01NQSukXkXeVTImp2c0M8gsmFuxm7csEvVjfWzFIjFILKRPvDCEczlnX2q//dqrk6M8Ts
	ui9lKvs0jFoWZa1MMPwpi7nLybNhEGCM=
X-Gm-Gg: AeBDieuV5DShn3f5Oqi4UwSgrog46WPy6Bzr98nWotQFw4hZGpYpeetVSYGudUYbHY7
	vGpFjhExKdcx/3du+Ek+bMYSR0/EjWC9ZTjH+S9Ly4U4UxUXhlaok60Q5Pz5sdzhYflVCgg+ebq
	YQaXPWgljjqw0LzbTV9fi2Ys3JO4Ky1X1pz++ykLrvCDoMuEMbedYb0+HbwgBQqImtSpsD/pOV1
	GrijaCWDDyfJEf4BODqxanv1zvFmtLLG50cJZqcDlODMJszR3aBlhLnScZY7wKX53g9Phs8SSl2
	fKPkyGri1tkR8YTi8iRkXknyO+oCPeg/rmh1jyKqG9Af/wTD1Dg=
X-Received: by 2002:a05:6402:158e:b0:676:54d5:bc5e with SMTP id
 4fb4d7f45d1cf-67d63aa0627mr2692675a12.8.1778122325100; Wed, 06 May 2026
 19:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
 <20260503-realtek_forward-v2-4-d064e220b391@gmail.com> <20260505182638.6b543f5b@kernel.org>
In-Reply-To: <20260505182638.6b543f5b@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 6 May 2026 23:51:52 -0300
X-Gm-Features: AVHnY4JRe8rpxs-cH-IWaKEEU0OUeA7HGqTdGQZPxdFBmUDLM688upjzi-dzTVQ
Message-ID: <CAJq09z5kC7JMtvOdMOCxwHcg4OG_Q-qicrP=h4pYp6STkvu3kw@mail.gmail.com>
Subject: Re: [net-next PATCH v2 4/8] net: dsa: realtek: rtl8365mb: add table
 lookup interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B5D6D4E27C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285125-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

> Defensive checks are discouraged in the kernel. AI will make short work
> of finding such trivial violations.

Sure. I removed this and other cases. I hope it is fine now. I'll soon
send v3 with the fixes.

Regards,

Luiz

