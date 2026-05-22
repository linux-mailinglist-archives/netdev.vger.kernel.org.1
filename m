Return-Path: <netdev+bounces-290780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DFQMNc8EGrUVAYAu9opvQ
	(envelope-from <netdev+bounces-290780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:24:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB45B2F4A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 669513060DF7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF483C3789;
	Fri, 22 May 2026 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+qgeWZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB03C1F31
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447989; cv=pass; b=CTa0fzb4nsGzS9oX3JWR1MfzfpN9xjzpWDVkNyOBslmgJGFVbjOqizg1Lvj6rNbZTaPgPAqc+N2d7cjjdLBtJ+3rF6y7XV/tf/jpVjZeY2QAOca06n7nme1aw30qulJS70d1O11ItNhXxg3FaZlFg+HXVU0Up7hy8J6Hm6/USrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447989; c=relaxed/simple;
	bh=Cb8jzTVP/g4hZIUKlfTnMnNDv+bNwVUN4cKy5ljB38g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5S0plSYnYOoVyc7fsD4FM4z9atNggK9s+CPhJj+BKB6CdgpvHadQzVx10qjzcT5L6FozicP29/poYhYER62sZntKmgcyWmpMCq9GUgc/k1oogxZW+9WwiK7HRbII8Li/5YheIjKcRNDx0CgamKs9DM1tLvNsBQ0lk9L5I4ZfY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+qgeWZd; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516cbde40f2so16124631cf.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779447987; cv=none;
        d=google.com; s=arc-20240605;
        b=H2yeKatkkfkv1FRRq42gIDTqkTGw5VKb2Lg9Sd7EDHa0cDg8E9Vq2qAFpYoLG8jYb8
         TRxlretaKbzIHuzxTZ6O4amaIFwQLy8h5/M2+zL+noopwwAxTEZgUM65LWgbVaQV/hrR
         FTg9gPuIxkGAgODbQmzO1SaCZLumhHra+SbYd+GBOBL16RUBuj5SB/vAmZFxSOCmR5XJ
         +8a5cGT2nLoyOCbW29+bctVjyi1wqReqw5GH0k2VEeEsvPuiqjXp9rZmwZHWn7QM8abw
         OWZtBAclkisWz1f5at2VJHkp8o5ZFqmB6sASlSHjrNWLE8IlcnhFcmkSnvXUymEVfQek
         FEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ej6QpaknZjbuF3/decAt6oWWqXsmIj8KOp/5Rx73bU=;
        fh=1BIH+fGMVMBrdCT60ksGThKsetCv+5Rc7f71uxAv1gA=;
        b=Kb1Zd5Cl3Av3qWq+tA/JyRd5iaUADdKiPumHMI/M3evHNXBmAYS1eI3fGWlZbaHgEo
         DQhvHprSqttvbdCKbWdWCE9IURiy5RGcAet6I5rF0yD7AEeYShBdTIwZksg7KQ2z/9BS
         xbo1GERapssXUuH2WOdes5/7XbKzKgmlQhBPm1Y9JEayMv+UHpqaIp1PmBDONJXPHFxh
         Lc/TV4PjgM/yWghxPK+KcWkA1FZmempnd1fjGGttr11QUAeJDPX+KNzeqRTu5B2S7nbi
         w9W9wd9O5t6El/wsJrpD3P4gSwRqHcJuJFgz92L/7wDJ5i5FhUfxXSPqF1vtrghbfLeE
         4vBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779447987; x=1780052787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ej6QpaknZjbuF3/decAt6oWWqXsmIj8KOp/5Rx73bU=;
        b=g+qgeWZdwGThOpc3lcrH7zpUN6OJjfeiIQ6Sjp9jZ1LXmwXKn9CeH3BqUrW3rXfRmM
         9pFQFPcdA2AsybKCOYpKRveDJQLxeRadWY+oTenXAmwdAVxTccdVXb4dl67CNIYr/4qe
         Vcd6o3mIGv55CtqC6AKcdrFdJUvfGmehvskTtTfsolWvdkb6QXnUjYxphn9Ly0rQYFmU
         K+sQWz+ykHgcXU+MH8laUMnkEcJUmIUYPTCCe85QGg6dHiJTfS+M00ODZBS760tRrhpH
         yLtwJQxQ0pY48RGhRpFHstWiZlSvT6lesc++MHVtUKzbuq5LQkn/Hl89dNAungw/C8tp
         2wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779447987; x=1780052787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ej6QpaknZjbuF3/decAt6oWWqXsmIj8KOp/5Rx73bU=;
        b=WeJqYbH41p8VPUdyiN0CJNYLTRnAU2TLBSisWZPolOBRRYp6NQIGlNPuxg1s3t0XHQ
         t5wcimaG5gsVvBs1YksbHY2mkLsCY53mUnubvXrbViKGii1p25SvvIh5dYE/GzzVFVvm
         d/m7bmozEZvilNaK0BQQ8apl/lZMfvke+ERCh9/X/C0T1aqLUUVW5XuSRz6JiAKm8+sB
         xVjRIfUDPpNQGUmVTjA0U6DUApulprpTaxhHLnYbVcHqVKlhqx6ECs7wjzpYUl9g7+Fw
         /k3D5BdVYd5mWZha+2XF7E685wHnYTlg7hRbzp5hRfheEw7Pyh1UnXnRtMZBf+D20z8W
         bh3g==
X-Gm-Message-State: AOJu0Yyfpd0StgYlq1PwirAGs0bEJ/OyoHpoRaw5ZNmYWx03aEktt/9v
	RnIFiGHeh3fpmBDc55bO1bS15egGOfMWb/oCfxCdLuqv8RtDbQtCpJkF6K0F38odbTbuonq2Mjw
	MeBpaS3ZNK0kFtZ2EBwpFBG4oc1oIo/7ypeZeVCDb
X-Gm-Gg: Acq92OFllcqEe3eRkrQYxzYE73/678NN+UWGwjtuV68Y8gcP32bPUvDYrGfIg3f+t3x
	T70zE5wGzkjjP3C8oAd6FDCBRQc0Zs2Gvq/sXhsVYZJB1D5TbK5pTxzpBc45WupQaLtLofktf2Y
	f52PPkWVVmspRWzcL0jUP1RkjDBTiqiVtnxW8DmHqsvr+Glx7ltRGvOrlwh5992XZqE6mHVNRgN
	9EM5LKY3q530/jjG0Jie2YDSKUFrHnhkawqGtVu5E3xqSovTBISce0Plc2e3wTG013S9oAFumyg
	Vmlx/L2a/y9kcebvuwr4PMD5kjwAZsn1OuUzuYlTiE3JzGAozhCGysqnDhNlpLBWtu/fpFZSnVc
	C1ujq2NgcXnjr/+3PdnXm6JxOdQ73A/xazTZMZZxd9byhwrpyFlubavSdlcFys1pd
X-Received: by 2002:a05:622a:a942:b0:516:d5aa:42d5 with SMTP id
 d75a77b69052e-516d5aa4534mr34969431cf.10.1779447986114; Fri, 22 May 2026
 04:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522104257.2008-1-fw@strlen.de> <20260522104257.2008-5-fw@strlen.de>
In-Reply-To: <20260522104257.2008-5-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 May 2026 04:06:14 -0700
X-Gm-Features: AVHnY4JAvpfq33Omq5xczX5BUpmPFogQtSNG7NfdvnnXCyQleptcPiwbspf5ErM
Message-ID: <CANn89i+_Mt220itgSf0P476U_=ayRpKomiQgqy1QYnF3g9UrdA@mail.gmail.com>
Subject: Re: [PATCH net 04/10] netfilter: xt_cpu: prefer raw_smp_processor_id
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290780-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,appspotmail.com:email,strlen.de:email]
X-Rspamd-Queue-Id: D1FB45B2F4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 3:43=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> With PREEMPT_RCU we get splat:
>
> BUG: using smp_processor_id() in preemptible [..]
> caller is cpu_mt+0x53/0xd0 net/netfilter/xt_cpu.c:37
> CPU: 1 .. Comm: syz.3.1377 #0 PREEMPT(full)
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
>  cpu_mt+0x53/0xd0 net/netfilter/xt_cpu.c:37
>  [..]
>
> Just use raw version instead.
> This is similar to 14d14a5d2957 ("netfilter: nft_meta: use raw_smp_proces=
sor_id()").
>
> Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x=
_tables")
> Reported-by: syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

