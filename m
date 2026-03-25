Return-Path: <netdev+bounces-271619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCW3DzgAxGlXvQQAu9opvQ
	(envelope-from <netdev+bounces-271619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:33:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF283280D7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 232AB3094D8E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75173F54DA;
	Wed, 25 Mar 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOAGbrkS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE433F65E3
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451348; cv=pass; b=ga57In+80i++PCTX8lVnVcavD79eCa/vRcl6sHwd0+zR+mcJJXDk6orALVxCHDpdS17GKMP4bIjVs2dCrxm/xIhHbqTcPrH+HFGE659L/nnM5BVBTkT5E/yHP/ohi+J6BdFGM+rrdC3QzJKsZbBY11grgmFIKgVYc4vpHNz/Ey8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451348; c=relaxed/simple;
	bh=gszlDD56MGBGGDEqMc46uO3pkVAt5WHl9aNOkPHFvUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4WoyqKfeaohZe0IywS+dAVlHruJm0xb8PWhxWtSQes1JxgDUfKIe8n8ujAcgtNcLcq6QWwKE09a+CtSBT1NrGx2bRQiacamXWCt0gFdF3H9hUWUTz18p0f/8f/alNkiGJIbGk+NeluiJ5+RTJtpdbpWDsxpKT6Tx6KV0XFZDdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOAGbrkS; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79800183233so15152797b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451346; cv=none;
        d=google.com; s=arc-20240605;
        b=KroZLN2veQUy/iB3w4nUZlxac6ii5zLULNWa5lICdSPzCi00L2vu01PH613N9OIAcu
         x3wfi9Ndvsdxn3vKaMzufNVG9WVN7NOZN+wgCuwWoAzoo8Z5RpLvZOkF6AtZlI2ayIYA
         G5LvspAAbfIsM4B1WW0eaPsMVFoYQtkxy8JvOlSmeRnN0g7XAT9PVYVyjgLr04BXeL0u
         jtgRXJ6L/ScbqhpMcjEPDSO0v/xo4g9zYK3Bx81DLdjjQTSglbQvfCuOPSwaf1PzbJUv
         bNjlcCTE9qoPP5iu56VvOfTToAA3Q2RBe/y79uDIhQVhMeeIDkzxQg2IHmDQtJCTSHsb
         uLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KWG8zMrg2FWXG0B5j19VC8HbQUFWFpULGs4rpaOJUVA=;
        fh=WLbgObBjMu6dq6Bjf4umiijlce6hf0BoqoxO/jGfQ4I=;
        b=RgPGCX4zqF6JpWR2jEMwPyvFl3wn7x6ffIeN3995rtEsXZkAjUqtBb7jj50A3ra38T
         ARuZd3fi642DkZ8neJqQYQy2n43YsOmNbvrIunk6EC/yU2nCnZVyy5JNEUg/PquknOad
         hE0O/N2ZpfYMvRRM9xI34mG2jYcv+SiVf78GocsIAUk3MYlymOEohsya2E3rwYVGXixR
         kRSaGKLwVyEe2KhvZEgAUC8u/st5vPZW3qaasE/EoIgJYrgAvv3Pfz5OL0yaqse8GI8W
         SSCnVeyi3y2WZLw1DiTKl/ByKckStrY3tiWrLkE3bnDEdhzvQM+zbeILMbfy2lUKHEyu
         qINQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774451346; x=1775056146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWG8zMrg2FWXG0B5j19VC8HbQUFWFpULGs4rpaOJUVA=;
        b=mOAGbrkSyyl9KV7XqsPOA+PvO1ubfV5FNsD5Nl4sXCj+cvAdXLALYVse3iqvrtIu/1
         5xBMPCOWyB+L3g260lm8eedmd2/TbrEV6MzVY1XEXOZSObd9ghm5Np5j/IbyTbX/NX0a
         h2n1F1zlcwGpS1E+PPF5/p8zQRb6FHuVWsYrVUl+xouINI6yFpQtXdM1NmQQuCxYJJaG
         5xek9UFjRz/6hlTy0mrsx+MOtEgT4MLCkITH4VU55tgYpsDi6nBApiSRBiffG0D4SvBH
         uMd76enGlM+LclQPhr054V+QXS/0DFR7k3BN7XS4W5Ym7kZHGgbN0LdZizXiIO5mRiCS
         AepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451346; x=1775056146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWG8zMrg2FWXG0B5j19VC8HbQUFWFpULGs4rpaOJUVA=;
        b=H+nTKmqOVJbRzYwy9HIT6AQP3QYvH5oNEXJ595oYA+XBjRl62SneLeeDhKNHsCmiix
         JR8b0E2HNuHWmggt5LetEFlmuuxSEX7JhYm0K2Uyw3HEu94QTt/SrPM0FHH1rQ81pvph
         kVYMTYFbUpShyAo/zaruWtp5rzjdOMmnWdHDHkepAXpC8z5ZawCcCy0us4dHs+nxbT+l
         TGYEgTw8bM2vVkhW045yeVk76UF8h4lFAVVImngP9rlpZVxZqUdPlsR/fZTlMlTixM+s
         1T3yoPApLiX4AG89d1a0oiJPZZR68IFyBwgizDK5c0E9+mBZTCTDLSEovcZVaXwGCmUW
         SVPw==
X-Gm-Message-State: AOJu0YyvymIXzRYGPOIwoyOZPE70rOMe9YghkIbSOk+Zc3FCb2wBmeq9
	7T/O9z3PDmBV+b4zQKlphipgLBjF2cCMdTqwim2QlrtcqmSLRBg6sdPR3MiWE0zgQxtIjDtbZrs
	79xjnmRvtLOqtWRgv9CoTE49Ly02X1qMOSV0zzqp5AUFbNhreytJTVcgOCqM=
X-Gm-Gg: ATEYQzzJTLpAF/fFgEvPHmGZEIjokpln1X7sosYiy3lKG/JY9bB7+1NBEF7jFLB2/EA
	6uExqgXKuMCTk7h1D2Z43VlSDBmLmN5nTiMt+DN8KOvXpz1vwZAI6kmSIDfjS3g8byBeWeHxRSV
	vs2IcZIeFqtySuS233EyO34OSdA4cRg4g4tQbFR1aScCZiNTvWNmRkuPY+SxqdV8bfF79xoFMuz
	Arpe5awHljtA7kbWeBto04VZDvChEQa4fOzBEBZSniTbuOLp5sgaPuWr3mTLyrvLHJlVsQ/bNML
	AqbsO76zSYQHYPg8o9vpGJCC/enrDUVc0DeMinaQhjkyBeQ=
X-Received: by 2002:a05:690c:dd5:b0:79a:df9f:3be3 with SMTP id
 00721157ae682-79adf9f40bdmr7010037b3.26.1774451345840; Wed, 25 Mar 2026
 08:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325071854.805-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260325071854.805-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Mar 2026 08:08:53 -0700
X-Gm-Features: AQROBzDps-BMhxbGI873-uwczYtJ8cNb38y0NU6pJY1iWVlK02iugrJyomtqfOY
Message-ID: <CANn89iLNJY3dtYs-TBYy5J_TSwzf3RYE+2zDafaCvh+phHUOhg@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: Fix inconsistent indenting warning
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-271619-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5BF283280D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 12:19=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> Suppress such warning reported by test robot:
>     include/net/tcp.h:1449 tcp_ca_event() warn: inconsistent indenting
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603251430.gQ3VuiKV-lkp@i=
ntel.com/
> Fixes: d1e59a469737 ("tcp: add cwnd_event_tx_start to tcp_congestion_ops"=
)
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Please note you do not need to spam lkml@ for such a trivial patch.

