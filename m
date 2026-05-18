Return-Path: <netdev+bounces-288857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iImwEMenCmoi5QQAu9opvQ
	(envelope-from <netdev+bounces-288857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:46:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 943675666E6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE12F330C0C6
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AE3A3E68;
	Mon, 18 May 2026 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NSoOpmdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30C39891D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082002; cv=pass; b=MeyWOVOZ/hcWyvf/xDnpUR5pt/PFFVJnqJwiKl0QQExZNE522b/ZJZcRwsWfzaiAExWoZGrMNb1zk1eiy34iTcjZzDslilCRM6xbAr/5lgRky6Wi+17QBHWQjH7G+hKKnQ7/iUJr73CGu9A/mV4a928JgbF2eBhnNgTfeP2Yeng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082002; c=relaxed/simple;
	bh=6mld/fwCl0781+nplbcVK5Q+Atqveim/XuEkZHQqRYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSsZAYQM/fNB+QQVeTobY16Lr5Psq5qAcf9o7Q42pVju9lC1twZuwl13XDNIcxqj7zMCmL9idemNT78QyDcVRzbj0soNnjQ6zLZ9Rw5sMvejyUbYIVEF1lDKz1+zBA/lH5xTxSl4ZcBC4zvUu5qpEOQ9nOGMiU7Un7e53hhFZIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NSoOpmdf; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so768939b3a.3
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779081992; cv=none;
        d=google.com; s=arc-20240605;
        b=RGn9gYAnW4jTNbL/KdAYgj9jjjBFB8C8mF98sJXPIkWCSVpSyKraumKYjENK8bJP6/
         DM4vxfYHh18hUI4DORgj/ofJEHXvqIDmoCG6J8sbgOQ+V20kiipAeBaMu2eHgn/W0ak/
         BDgPtBE/OozcT3Zvx+TGUyWcE4hvfU0AgrtL5p49nsrHGS0LHEuM+ZUy73fOEwXYZ+eJ
         aOUnSWHWEeVz3tY+rkG4DyEF/LduY+W/YMUgEkDvcXtDBLEjCyJirpaRJHVCfS48g2GR
         cTPs+V/PVdB25gepGTQXWZ7ZWHTIO/NDfM3jZMbdMw4OlgN/AWmmDgtiUx1ZuZ+hSEsI
         Ccog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        fh=DE1X5eNx5TG1WVnOUxq4D8FRbkcvfrkxOXnYqNNunxs=;
        b=Ne0rE13YrFlowDs9iohuNaNOFB1Q5YNBOXsW3IwUkwTXR9clKXjdS4M1XcwaiOWXxY
         Uxm2agVb24yaLIgiMiq/snWdlQkHCLLTNrIqIQfug5yg1G6Cukz/1Fp9y1IpG3UCnWmY
         TlD4+QpseEH57D5Xpsc9C2siF1tqPQ1BHv5p3LGuthpne0lubZdD2sxtYMpUTPLwOxYu
         KAjK9MRnTXQWYTHxkyUKK0j1lMxM5fnyv/VLg7DF52gmR8KbT2S+No4jWXdszexhUzDy
         pGQ9a5QkzsJEWo0F/RbKtILqfYgyf/bEB3/7o7JdMymU1Rv1deLaABe/1xJpkQ38B6Eh
         Q9xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1779081992; x=1779686792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        b=NSoOpmdfwayFqmHQKPsw/9vrUhwTmX9yxO/FPGTUQApyXhQNoGQ73AqSFIAYn9GMoA
         LVG5BV/FsxtaHQvRITGnZWqMoaKlvHsMotPk1VB9XhyIyQC9daAR3OxTbcTSSwkC7Fyw
         DYDkjttYMbTWlvq21vGa0Sjp4oYbIFTS+5Qinbaxc78yGaLwMpZ/HhwmM0fpr5MTe5AY
         1eQp1mYvGfYTsrnhpsP7C6fp9vgo2t9tYOoBsyypTsL44uwl9tcNYmSmKg8QwY7lpcN/
         A0PuClruV7Uz4omIeeCPaMpCp5Ps85LqcMcmyU4vT6+vxEhmJv9RF4j59AjB6Eb7hmZD
         uhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779081992; x=1779686792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1k7JCzqf21HQ1C00QUFYl3DOKCHggP5kB3fftLNUTDc=;
        b=iFWxfe+kn7Zuba+/RrNVwEMOXDo3yNxvVtH8DQS91AS8yiudStyXj6/lZA8V/pJ+lq
         +vpn+I9ZUsVNUVg4dlo8BRnM1o0UZTaF80bew9awTv2io4oaXEeniOSc0HcOEVJKzGA8
         VWx5Ov5TRQQibD65N3q9QHRzAqJwDgifqMHGdtn8DiupJJxY5LAdh91PANLNn4j9lbTo
         GWasap2Y1UKpHiyp3NSEKifgM0zT95q3a0I7A8UWEgJ7OBpgVEjn8Gw2jvcYg28xukQD
         uqh1YbnX/Ct7YnP12QKMCAhqF1sRzTVMq4xJJooC+RXFgfaf3ueDtlPt/E2+OQh0dyCN
         3YCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gI7bg8C/Ka/G8+MhWrIjpSBqox7afSFVvMX7cbwXJXnK3Kd+WYgyNKOSU6lTPU1yeOf0DB8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoyG0hF3EXYdAYUNjsad+xiHwNsMDUcTHG5QldcSWyFLDekYy
	aazvzYwWdEZGuh9JgCOKgfSMI40MKcQMfyOYbLbZdSZz274KaurlA4V7YRVD0YJlLnFjB3T/uB6
	pap1EEAJcXImtvaKCW5dTs7QFT7cjuaUuc/ns0jTZ
X-Gm-Gg: Acq92OEgGPydXk0umHYvTVccqkibYmIDtGBKMtRLxHklnv1Xs4BGtuRDoPRmU6AuraH
	28okq/XTd9GnlAqVN1nywBNVvRGaaZ1tZ5OPYSMTVabLMEIfc4eF+xZjTTRkpfyiyAPKGpPmFDr
	+7sOI1zVn1mliTO6tiEmcP6/MhgdeeEie0k+Hklslnt+q3ggJsri47SlY+TlZRXqHR8e7BrY2x3
	cuqI4/9NGpm/uGg7Euce/J96nS6S3T/7OVF33TArzUqpRL1DLdtQeJypxrnMCtxa8XHpGKM8Ols
	k0kKN+zJDqG8YlYgow==
X-Received: by 2002:a05:6a00:4c19:b0:838:af72:fb35 with SMTP id
 d2e1a72fcca58-83f33c32d51mr13485269b3a.10.1779081992086; Sun, 17 May 2026
 22:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511062138.2839584-1-xmei5@asu.edu> <deb3e868-456c-43a6-886f-9d882d23975f@redhat.com>
 <agW4kfDB5JjpPD-r@linux.alibaba.com>
In-Reply-To: <agW4kfDB5JjpPD-r@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 17 May 2026 22:26:20 -0700
X-Gm-Features: AVHnY4I5pKhATjXOWintNEChLSk7L138mcEGY8bdVrCg4bjT2d8_2rfJtytM1cw
Message-ID: <CAPpSM+Q+pZkKFv97+1R0kYZud6Mjz-v8qMKP+dg4TO=W=LfauA@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: reject CHID-0 ACCEPT that matches an empty
 ism_dev slot
To: dust.li@linux.alibaba.com
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, alibuda@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, ubraun@linux.ibm.com, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 943675666E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,linux.alibaba.com,linux.ibm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-288857-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Action: no action

Thanks for the information. I just got back from a trip, and I'll send
a v2 after checking the UAF issue.

On Thu, May 14, 2026 at 4:57=E2=80=AFAM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2026-05-14 12:19:46, Paolo Abeni wrote:
> >On 5/11/26 8:21 AM, Xiang Mei wrote:
> >> On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
> >> reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
> >> populates V2 entries starting at index 1, so when no V1 device is
> >> selected slot 0 is left in its kzalloc()'ed state with ism_dev[0] =3D=
=3D
> >> NULL and ism_chid[0] =3D=3D 0.
> >>
> >> smc_v2_determine_accepted_chid() then matches the peer's CHID against
> >> the array starting from index 0 using the CHID alone. A malicious
> >> peer replying to a SMC-Dv2-only proposal with d1.chid =3D=3D 0 matches
> >> the empty slot, ini->ism_selected becomes 0, and the subsequent
> >> ism_dev[0]->lgr_lock dereference in smc_conn_create() faults at
> >> offsetof(struct smcd_dev, lgr_lock) =3D=3D 0x68:
> >>
> >>   BUG: KASAN: null-ptr-deref in _raw_spin_lock_bh+0x79/0xe0
> >>   Write of size 4 at addr 0000000000000068 by task exploit/144
> >>   Call Trace:
> >>    _raw_spin_lock_bh
> >>    smc_conn_create (net/smc/smc_core.c:1997)
> >>    __smc_connect (net/smc/af_smc.c:1447)
> >>    smc_connect (net/smc/af_smc.c:1720)
> >>    __sys_connect
> >>    __x64_sys_connect
> >>    do_syscall_64
> >>
> >> Require ism_dev[i] to be non-NULL before accepting a CHID match.
> >>
> >> Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
> >> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >> Assisted-by: Claude:claude-opus-4-7
> >> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >> ---
> >>  net/smc/af_smc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >> index 185dbed7de5d..12ea3b6dbc64 100644
> >> --- a/net/smc/af_smc.c
> >> +++ b/net/smc/af_smc.c
> >> @@ -1400,7 +1400,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_ms=
g_accept_confirm *aclc,
> >>      int i;
> >>
> >>      for (i =3D 0; i < ini->ism_offered_cnt + 1; i++) {
> >> -            if (ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> >> +            if (ini->ism_dev[i] &&
> >> +                ini->ism_chid[i] =3D=3D ntohs(aclc->d1.chid)) {
> >>                      ini->ism_selected =3D i;
> >>                      return 0;
> >>              }
> >
> >Patch LGTM, thanks!
> >
> >@smc maintainers, please note that sashiko reviews:
> >
> >https://sashiko.dev/#/patchset/20260511062138.2839584-1-xmei5%40asu.edu
> >
> >pointed to another pre-existing issue in this area you may want to addre=
ss.
> >
> >/P
>
> I agree. Apologies, I overlooked your comments prior to replying to
> Xiang Mei's patch.
>
> Best regards,
> Dust

