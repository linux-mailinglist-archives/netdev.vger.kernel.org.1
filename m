Return-Path: <netdev+bounces-287202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBm3EM86A2qh1wEAu9opvQ
	(envelope-from <netdev+bounces-287202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:35:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6658522A75
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6F37307A57D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DB3B1ED6;
	Tue, 12 May 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAhsQscX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D537DAA7
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596220; cv=pass; b=RH1Ufvezk3pRX2hOs9G6UjCUmX9vcs/50lV1fU6vx7zrMDh0S5hYlst8iVsoAJBzGOqlCvF/JRbx8HtfZqssfxexUNwd9AHwtbL4onHlCiSnecbScHIEsdRLObxIagDaSKcHGkeMlfTRtIvx4lbAgA0WOTAbGrKSzSNSnRTZXkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596220; c=relaxed/simple;
	bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsBzCL2z3fOf+GH8HAedhiIeJ3nPCuEcy3+9C26lTvP+ZiF1RQNoaZVFd/JrxKvPz3MNRTtZndM6y88Rpka9j7a/z4noK287q2bEGflyOn71s/2dP4h6ZPXSZg5ME4ws0jc3wKjB4v+PpwU7Mx9XZBX89AylZTs2HVsXnX5/m0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAhsQscX; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a877510541so5814079e87.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596217; cv=none;
        d=google.com; s=arc-20240605;
        b=d8zU1/68EyOLlz1jwp7B30CEN/2L0+JM6rjf4TlyqdjHxTArGhjGJnsDH3IfnT3J+N
         8m15sIsVt1j3nZ/QmC8His6tmdz8Kam+dehMsa2N4SsXW9rpMG867BQyCrtg8OR/gz/F
         htpdI3p1bi9GrJJ9XKYpNB2+moVFg+6kWmwh5aE6OYarxFdsNSRRazZWGjg+Jzeadg/b
         KHZrPtAxRi131KabuVXIf5Y6Nb3Zzc/KPXFEewT4wMxDK5h0IGxam5rJldM+5eugmvSP
         v6yXVmgQgFFyrxy6OuQ0+bk8qoUL4Z7yseYuGltOTrjbcQir4f/NjPKxdOFa/7+aRj03
         iAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
        fh=rmh01ny99yPpSBaFShz9so8SrlkY59jRuAX18dIU5UU=;
        b=Xw3QQde2cvt1b+juvWWKUJgqx2Bma7lhXdDBdJzTgxO65JEr8NjAxlY0JhecwpdvIQ
         0PiXhetJVUCX+ts+YneBLSoIa60qkpjHoopqCk9sSKbkCHjchHWh2f82XzrGKBq+1KDo
         JGEfAXJXVEbFGAMOQ5gSrMVhU8s7cTgEXT5ek6/TTOXxi3FhD12hs9KJsGW6DmKdiCvc
         RbgfurkkxxaFUsbquqXzBMX6YRK8fAVK/55e7I/2Q/TfF37Vgm3+k4/OWr9h0x60eFgD
         Xqf6vpxShK1lHpDhTu9rGn9HDQFBekh/QVY7gVY2mrcrGTCuE5f5FflJ3aEr1K2m0pf4
         44qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596217; x=1779201017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
        b=lAhsQscXVW8HYzzh8RN/12vVlMvG7gTs8XAi3mcdIz6+MhqEpZWzcnewwncX4eKJ8u
         ImJJ4fwMsLioXxzws+WiXpzatoaVFn6BUEidAEbdz3o+8FLMF8hfwvTK0NzQirTTVRBs
         E0EJwFePYgRiG7MZ9TfPWb//2PtJ9quhhEFmugdlzXn/ph9yrDwNwRHOlAegZ9TSKLbB
         I2La1eGp656SbDrG1JyUtU8ss9DjKfmVCJuD2Z1xRQgvI4leJYFHlwtUwjzbu+mX6Ejf
         L2oo/9iwdPc4MmsfUHFgEB9YddeqLiZVaFpaLtjCV7b3nAyP3xYH3CE9aXcZ6szL6Vzx
         MafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596217; x=1779201017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UC1HOOPlstS9mzxWy7fLV16WOvX2ORKqeZVhf04C1lA=;
        b=rt4S0QDFOfZVECtQJZvQjg5LYZyC9Y/AaRmoiufSd94ALmPDqA6h6K/7+aX0Q0CveH
         E5acxG90Qe8n8RIU/NDnMpWhT9PF0mg4J8tsTq9lPQpoLDLunhsrAHudn0EvW6FZEaRK
         ZkNdzQnFyN7OQcHJ/KeXHz8KTbx1E/L+YqrTksTjbH7lPcBz/TJcP+wE/uvSw9ucEtuy
         +gI7TAfyTkwZTIdWZCSVQvnrm3wibWZgj1kDz5sjhq4qHKA680GGACO3+n68zPvg9g4E
         AvBx387m1hM+FlJQSuX5daIxOHgAUxpVGzOjUIOQJuoW6VMNvhmwZ4uHGYNlEkHsJ292
         Ab0g==
X-Forwarded-Encrypted: i=1; AFNElJ+i1PWWrUzSszVGpynuXixrWlMz1Ux2/1dO8PnFqO2Cn0H6WUKNmhU3xXYSxIVqfsW0BpxTpMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNFXwwad6LeNX2M3DxXOygDKm7St4WhFOOfS4rNLc1TPwYCuB
	27bxz7Si5UpESnvjCIupho+VWJO5fPWJGt4JL3b4tFrXnxML0Wcr067rjmKlDHKiHwV0RTSx854
	wcnaMvZjgVuIbnLtj28iitvCczBl1is8=
X-Gm-Gg: Acq92OE+S0OCUB+bh4GKEqMX/Ix187zkRHMBzS/X24iO0Nytzq0MotjU21HHX+OgCDj
	RuOTfpFROUBotKWotXXynTDn9gGJSO4RMf8aXI1kcD44XddpVqBPQky4b7GuHzWFnRs3CmdgcoX
	GxV68kPK05cxX4KgvTapJFGFLH5XBBnENqqlEL0WPzepYumngS97LJaXQ4Pjc3dcYcACWhmjQUS
	VpnNiM+WwPZT4piVDsL++FWGwGbEcDTFDYewOp6sbXrqi3HPnDeV77JZTn/NtgKNE4kZiAcYmrq
	4OaGYpPw0xxQiFgaFF3fcWzC+LWRO8MzxVwFP2U=
X-Received: by 2002:a05:6512:3409:b0:5a8:99bd:12cc with SMTP id
 2adb3069b0e04-5a8e31ee2f9mr1426213e87.28.1778596216912; Tue, 12 May 2026
 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com> <20260511071634.463aea60@kernel.org>
In-Reply-To: <20260511071634.463aea60@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 12 May 2026 22:29:38 +0800
X-Gm-Features: AVHnY4IsZt3e09x8B5jihx9KDxzH4Eu-DIuM85L3vRHC_QGU6iCLOtNxoLVJC04
Message-ID: <CAL+tcoBezmEsBBNUxdz1p0FBsWd4qgmJX6xYZMgHxegHAoZKjA@mail.gmail.com>
Subject: Re: [PATCH net 0/4] xsk: fix meta and publish of cq issues
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B6658522A75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 10 May 2026 09:23:06 +0800 Jason Xing wrote:
> > The series is the product of previous review from sashiko[1].
>
> This series breaks the BPF selftests, it seems:
>
> Error: #277 ns_xsk_drv
> Error: #277/21 ns_xsk_drv/ALIGNED_INV_DESC_MULTI_BUFF
> Error: #277/22 ns_xsk_drv/TOO_MANY_FRAGS
> Error: #278 ns_xsk_skb
> Error: #278/21 ns_xsk_skb/ALIGNED_INV_DESC_MULTI_BUFF
> Error: #278/22 ns_xsk_skb/TOO_MANY_FRAGS

Thanks. I should've updated the selftest as well.

Thanks,
Jason

