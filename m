Return-Path: <netdev+bounces-293010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FsAEGg5GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:59:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BA5FE401
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC11731BF805
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1F3AB47B;
	Fri, 29 May 2026 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRPIQRXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55E2877DA
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037567; cv=pass; b=jJsBFdKSVnUOmHXywAXvAlgZu7OUC4LjbQ5GO9dI2YQB5tu12j6F6+XQC+WkL/N1o3483XXzdpDjYfaqoJvxyXf1ZDL83f0CeLRx/Hs3mvuVh7kDXvgU7sUsXnp8P+cJIbqYkATqCRvYATwMULPX4/N0APMEGyCN5n5MxRh6GL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037567; c=relaxed/simple;
	bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV6GRxgLKb0CoukbTu8Dqvs4VqbVZ2AQs34gEtzr+dQZyK4eOZSfedbcoKYQTlXUTonl3g0C3r7as1kddesSWLhRFH7WxqvTlAssfwmGyl5oIuSCEFiqjbyhBuOPiV8iGwliQI50rlFRKC1r/Ah4SMAq+E890wclersJLpUf57E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRPIQRXl; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so886137f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780037564; cv=none;
        d=google.com; s=arc-20240605;
        b=MpXRhiSoR+VEGLM10Q7snCuRcYdrlM12EGHwE/sF3s0isVBuGMs1ZkM4C8sMEnRqqB
         ErbOUcVoxos1AcAeTBkTfDmJrW570HwmM7YeTVLQkl+PH4ayLOFqrpGM9P++9bPuvrNL
         TXay2QqtdsTiEk7s60DrhpSFFe+zUWLrjN5qIyYiMKw6siampZ1Xs6Z2xJtmbzc4pfaa
         d3BKBsKB89UgTfN5o6kJeIYguC6NVk1e0ptckr2N5xhvJaHLI0kgncHx5ZDUF8MrQEl5
         XdlJvjELAyFbyP3cXzkjXyeGZlXxYvN+4iHjcGGobjpvARzhGNcDPpnjp9mH1Gnmr4dK
         WLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
        fh=rYpS1xWvvCZ1ng5CbgFJJZPOUg2mzytCmTfNTfJM+l0=;
        b=U3snGAtv+k2vsoz2JiiDdpewYaOYE/hI0jZEZKLjo+LzCX48gerWQ+YP531BoSGt1z
         Yjpf/eXjh1rd2UZD6ji+5ub5v2v6fWFbV2iYEGUTh4LiF2c2QO172rqAmQgKrOKm++I6
         dTcSTc76VW/9wh5o4GSx9d1Jh7ORUwt3uTRdw7J0ufB0jSCmYvM+B1E3OytM8Y4V4Bz9
         F5ntp+ey9v/5TPOftrhiA9PT8c12HFaAldNUFJ3kC+UPAmAk/z+dACh65/KOk2MSaKBM
         l5vzn83b0CM1brpLwXp9niM08Ou4NMTfnFtF9cgXsbHQVI4Y4b6L+ydhNj6zVddojdYI
         FTKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780037564; x=1780642364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
        b=oRPIQRXl5RxN+R5q0MMZuh1Ke87ir+4TlNeH2PxpQUL9+Bg0K8Tyk0sRs6ILS/BU6I
         ov+d8qlgDdV5dI//669Z+ghXaqKadPpYACesWknw4RVqCQ67HXOYksJph+FJpcTJDmHZ
         DJpNna2sYRE9otuZFeYvdt8CBXbdhrngefZzZSnu+2M8pH31krIB0dJK2q8k+MdLRYeo
         pKglpUed8we17rSVlbjTUKlOeIw5OoaOY4QNgD7I9bjtN/vN98kh+9m001mp2yusN9qZ
         COKJbXzHXAwvHJI7IM+aftbGilsNq5adUG2WApiEm8luiL40YUzVGN4bgIwoED+V53Su
         T6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780037564; x=1780642364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
        b=g4R1dI9/D3ddCo5YaFRzQ07p5AZ37H5Q/SiAY6B8A1KHNXt2d/DJLy0K1/mLnGjT5D
         m9PxYEonoRaA5dgX0gesFI2yOFY6vsZ/N7cvu57WJziZNXBHK6DRbD8QlLx+YqfWdGMs
         /aNtFYZwRuWZu1tDZK0PMHMJ+wqafiqN19Jspp0stekRkE3IiSSbKHIvXghJs2wBd23U
         F+neaAYxYBOEYd1yVNsh5smX+ZrxP7cwc2emBgVpVrNVwSsevmZZApmafDuCOakACXLk
         uCXhII4drIpmpFG2aTMMM0dj3JlgZc3c6oQqmLeA3sawhHoYH607UU0OMcbXoemenBR4
         aQ2w==
X-Forwarded-Encrypted: i=1; AFNElJ9Hoz8ObDXwunJ/rQ9ENyp0nJ6OSuli4kMD7J+kbn4B7uEZK4boXJ5RnRPCKnCPjWZ28LNfCBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+iwZljISJje1RVRuO7UcaLoBF7qlLtOyQPH3LLTp3O/fbzoj
	/UucDccsRJhGsP1VUw1sm8FI2USI8KyTzvnlcYnnsgbOmLZIRVXCmV+qDd3Y6u/lPYvl1QhG1OA
	Szi4SCHZx2oD5ny8urvbSnP9qIL3P15SeCCO7wzM=
X-Gm-Gg: Acq92OEHFVMQpv5zrpXOfLYKimFZ3FqltbS4mIc8noLk+PqYI3Bn0IW2FwdHtI96hwt
	MJd+2+nL8uFCHmsr0Yrz+gpe1tclGLMBVQpsz89TkTvOWpDdBaFMZ8bUD5BKo5bQ21Pd+5fCbrw
	7WSaYzq4qYsx9OXb/5bYOxI6sIHt1oDKxt92R39s/trFu0M1X5LAI4javy4zV+pUB+APOyogfPW
	AvjhGQyzXvtCLfJdb9G4ZrzmnuuVh7zH4By+shQ9PNXFruWhsQDfUu4T/bOsLF6OOdwmBZ3OF3B
	c267aelwYpd1AO9ycgSUtMsVcQo3
X-Received: by 2002:a05:6000:4915:b0:45e:ec31:91db with SMTP id
 ffacd0b85a97d-45ef132db76mr2142532f8f.1.1780037564017; Thu, 28 May 2026
 23:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
 <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
 <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com> <CAAVpQUAp8pvg=s0K3QmkN62Osat-kf+4XPosfgbBZ_avzZR04A@mail.gmail.com>
In-Reply-To: <CAAVpQUAp8pvg=s0K3QmkN62Osat-kf+4XPosfgbBZ_avzZR04A@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 29 May 2026 14:52:33 +0800
X-Gm-Features: AVHnY4IOOkLMXNm_j8bV0jM4Vc6N9eDKu9CgnwIhR-_I7cCTyGyv25rgE_WIjvA
Message-ID: <CAHPEe=G330Dve0BdMhs783LiwC68eik7dc=Amm_Qz=kdD9nQ3A@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293010-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D12BA5FE401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

> > > Do all other callers of ->get_link_net(), dev_get_iflink_dev()
> > > and batadv_getlink_net(), require the same capability check ?
> >
> > No. Those are read paths.
>
> See how netif_change_proto_down() uses dev_get_iflink_dev().

Thanks for catching that. You're right, "all read paths" was too
broad. netif_change_proto_down() is a mutation function and it calls
dev_get_iflink_dev() inside its logic.

I read through it. The resolved iflink_dev is only used there to test
reachability (the !iflink_dev return) and to read
netif_carrier_ok(iflink_dev) for the carrier_on conditional. The
mutations (proto_down, carrier_off/on) target dev, which is in the
caller's netns and was cap checked at the rtnl setlink entry. So I do
not see a parallel cap gap on that path.

If you agree, I would like to keep this series scoped to the
rtnl_changelink path Xiao reported. The per-type cap check on
t->net->user_ns mirrors 8b484efd5cb4. If you see another angle on the
dev_get_iflink_dev() callers, please tell me and I will look again.

Thanks,
Maoyi

