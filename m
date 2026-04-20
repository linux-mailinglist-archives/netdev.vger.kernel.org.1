Return-Path: <netdev+bounces-279671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNukFynU5WmmoQEAu9opvQ
	(envelope-from <netdev+bounces-279671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994C427AE3
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E86D530166FA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFB38236B;
	Mon, 20 Apr 2026 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDJCVPuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652B2FE560
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669730; cv=pass; b=nVrVQrG/KPLo+u+tBwm8NvMeMbHcVzoTW9pHVqYvuJtLA1hi4G796LxT20G4jUrn5lDao5PNhtWGPfTsoZPbcezfqlQ46d/8s2Nmnht1nP1Z4cWCe7ifI2MPZrnRDi/2DTjEVdw4JIW+hjrEhUpescidTtXaBVIU7bOg7xMCzGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669730; c=relaxed/simple;
	bh=KCWKz+FtlPBgRCYFABaMUT1OdH92SjQSov3W4C2s+FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxOBW1dKBi5LeOk6oLRHBVexRtrByj4HsOFyCpDg3RHbrU3r/nMlsk3JW1LiJvzbZRaJtRCkFY5M4RzN9JYI8FoIPCr3pmY3m8GpHhWWaPUq46TEY9ll6gAu+MNssNbjlCfv4hse0QdAvCTMdSfK8IEQz/6JymwwrZ82OZ2taOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDJCVPuz; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb38e86cf2so259591685a.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 00:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776669727; cv=none;
        d=google.com; s=arc-20240605;
        b=TrpxCe5Nkd6RbEuapDlTlDyzWmNdW0wZoLfofi70gOdVZJGO69Bbb9JYdu8Lx+Hgt4
         lKgtpk6TOFrsE1k+Tl3+9gK6/QDfGz/1ja9Pb4bkxCHIcZHAvVr3B7ICt7Ep+UDWfpyJ
         C10vjirW+g41AHYYfl+rthtYeDDCUEBRCpy7H+AeTgUOq+C5x2jGg2Tv+YMOkhR+Wf9N
         LVB1Qm+PTs3ADFWAAKZw/Fg6wiGjZoBWMamhvPqhg86Rqmu9ipOF647Zw5lIQqtjYMXa
         +WUGSCCWoqtIHrq+0aaf7GA2gqZWKfkKFYaCROi8tORvsy9olTqTkJxAsQo3XWsXmZnO
         99qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BDIniOySTzGT5p8wsR3mWPyJ5w+on2w+W1qyzBFCzag=;
        fh=lWxYg71sBwlmJGiZ/9eG/kV0juEdXfosdQwBgDF0kzk=;
        b=hVIa8t9YfXva++FOWqqFFxuxNgFMPVQd0pjQq3Oji0ngN+P253HZhGmYBoZmpsqzhU
         SX0NomP6fyEnLg8ViE0FHaVvinNafWiUym1fpj+OWaf3ii5mMdupIiCGW0UDa574Pm3E
         I2GI2dAaO0a1SaLNtgyz7H4Vvm418M/edQWeQ6WV1EZ6RboChDfvxlsRIV0HsuAnXi7+
         emsdS7Bt+bQppAvz3m1L8fsMQK75hptA/j2AKZ5Kul2mSdk0xcuaw8re5Tmaui60LRe5
         nEt+cbfJI+vXUOIdqylpy5Pkoouvz7RQETKojDAlSkDAo89tcBhADzcEmqZpREYGAAXD
         +KnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776669727; x=1777274527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDIniOySTzGT5p8wsR3mWPyJ5w+on2w+W1qyzBFCzag=;
        b=DDJCVPuzU10QlXdjK6OlJNkwQsZj6EXvYe4n8quCnB9da+URAgQWGaiPk7k5w++0MD
         vNvpGpnShW/Kyjv+ZtAHY19DOU6CULPe3K1m+4lvlhZMRMxNUHt8aWNoefEVzr8gRHMD
         YTtAYjVzoOJUgbZ9vY8aC6oNBWzgbNYeTrhnjP/gP/sq+hJ5ZBFuUWXiXXfc1sejhaoS
         JcMgMXv6dGtIUfRA8O4GNIPs4igz2PIe8QwjX3o6CbIE578kprG49qa7UuA46iW8moyS
         d8qsqbEdelQtOu4QM1c36vvW/SFxH9sJ9LCYOeLKFSFR6A4yXtqdYDnMtRPlWGlx+zK2
         E9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776669727; x=1777274527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDIniOySTzGT5p8wsR3mWPyJ5w+on2w+W1qyzBFCzag=;
        b=h86+hbJ5/4bkhd20bgzwF1Rnofoaqj3F/kpwJcM9NTSlx/bmSoUd3XJR6YFFLEP/AQ
         51XorDTsSnH9tT0q10w9IRFR30e0qvuVl7sj12w2NYmcDpnoGMGCxHxciHiKzpHgOElC
         dJ0DUxie53FDgbRrlrAmgnUWfIFChkFjVxa182iHIpAIrUZsQO2hritrYXhXUogGlFOS
         gAMtpnefm601O3iBDaooUT882wEwSgWaL6cg0cDz/hoNKflj8fY1ic4JR9AONGfUxjiO
         PWmdzFMRtt0R/sL1u/sZGlSQPUjuqMd0TNhxx6f6DmuSPdybPPTNo94yZGyyC8w8JpIX
         E41w==
X-Gm-Message-State: AOJu0Yz9Z4XU8FPUZTgOji8tBC1DnzntvQUaIeX8RFVpnlAp2YK/d3OT
	4wQQ+MMsomWIAN8Zaf/4bm4kCWmV0lMWj6yOUMTxMytV93Zw7m23+OY0yJdNGz9q1K71NSB/YAE
	s0Uf+1IkHWYXvJIrYNmEdUrnRKWVB5LEReSkDyQoE
X-Gm-Gg: AeBDieuG1Tsf/83fyqLhXVW19WKdgBdypk6y15yz4lD6bAGAlWN6++eNlzqx7a7lcr7
	AuRp/lIcnCsmrq1RpzHfZkld2VMb0UmUlqdWrRTjFT3AWIZrqJ/FrnDjpXTeeDQ67lVrnVicubJ
	F96Rqq44TNPZNYz4DFNLxpXYvioylqq6dyHhEDu0AkNmmD3iq1iIrCsPspG1ueglufTMA6T5JjF
	ltB3TI+2mWEj2S+uI8tc2n2Eo2Ry+a+dJyvfgHIyjjQUwXhwjB8BuFMqSEVikMdahzMGEb03MjB
	ojAWImIXlmGy6D8JUdUMCmwMS/sM3Q//hP0LzLOusL4qiWE8zbafRGwvjSVsh/k+xtUOYlcG2Cr
	yek79LgNU
X-Received: by 2002:a05:620a:4612:b0:8d4:aa50:686b with SMTP id
 af79cd13be357-8e7911ce9cdmr1760867885a.31.1776669722994; Mon, 20 Apr 2026
 00:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420025428.101192-1-jiayuan.chen@linux.dev> <20260420025428.101192-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260420025428.101192-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Apr 2026 00:21:50 -0700
X-Gm-Features: AQROBzAPtbdNncUYWcDbX3rq6a0AQWH842ELgzylDrIvAQmNen0p8Yr8P2Snyzw
Message-ID: <CANn89iLOoA7=rHuGKY6xKUWrVksxR-EoRJ1xWsPm4quBdqWsrw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: send a challenge ACK on SEG.ACK > SND.NXT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279671-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 1994C427AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 7:55=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> RFC 5961 Section 5.2 validates an incoming segment's ACK value
> against the range [SND.UNA - MAX.SND.WND, SND.NXT] and states:
>
>   "All incoming segments whose ACK value doesn't satisfy the above
>    condition MUST be discarded and an ACK sent back."
>
> Commit 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack
> Mitigation") opted Linux into this mitigation and implements the
> challenge ACK on the lower side (SEG.ACK < SND.UNA - MAX.SND.WND),
> but the symmetric upper side (SEG.ACK > SND.NXT) still takes the
> pre-RFC-5961 path and silently returns
> SKB_DROP_REASON_TCP_ACK_UNSENT_DATA, even though RFC 793 Section 3.9
> (now RFC 9293 Section 3.10.7.4) has always required:
>
>   "If the ACK acknowledges something not yet sent (SEG.ACK > SND.NXT)
>    then send an ACK, drop the segment, and return."
>
> Complete the mitigation by sending a challenge ACK on that branch,
> reusing the existing tcp_send_challenge_ack() path which already
> enforces the per-socket RFC 5961 Section 7 rate limit via
> __tcp_oow_rate_limited().  FLAG_NO_CHALLENGE_ACK is honoured for
> symmetry with the lower-edge case.
>
> Fixes: 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack Mitig=
ation")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> ---
> I'm not sure if 'blamed commit' is appropriate, because I think
> it's due to missing parts of the implementation, or it might be
> directly targeted to net-next.

The Fixes: tag seems appropriate, and net tree LGTM.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

